from flask import Flask, jsonify, request, session
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS, cross_origin
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from sqlalchemy.exc import IntegrityError
from functools import wraps
from models import User, UserListeningHistory, UserFollowsArtists, Artist, Album, AlbumSongs, PlaylistSongs, Playlist, Song
from models import db
import logging

app = Flask(__name__)
app.config.from_object('config.Config')

db.init_app(app)
login_manager = LoginManager()
login_manager.init_app(app)
CORS(app, resources={r"/*": {"origins": "http://localhost:5173"}})

# Error Handling Middleware
@app.errorhandler(400)
def bad_request(error):
    return jsonify({"error": "Bad request"}), 400

@app.errorhandler(401)
def unauthorized(error):
    return jsonify({"error": "Unauthorized"}), 401

@app.errorhandler(404)
def not_found(error):
    return jsonify({"error": "Not found"}), 404


# Login Required Decorator
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not current_user.is_authenticated:
            return jsonify({"message": "Unauthorized"}), 401
        return f(*args, **kwargs)
    return decorated_function

# User Registration
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    email = data.get('email')
    name = data.get('name')
    password = data.get('password')
    dob = data.get('dob')
    if not all([username, email, name, password, dob]):
        return jsonify({"message": "Missing fields"}), 400
    try:
        user = User(username=username, email=email, name=name, password=password, dob=dob)
        db.session.add(user)
        db.session.commit()
        return jsonify({"user": user.serialize(), "message": "User registered successfully"}), 201
    except IntegrityError:
        db.session.rollback()
        return jsonify({"message": "Username or Email already exists"}), 409

# Login
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    if not all([email, password]):
        return jsonify({"message": "Missing fields"}), 400
    user = User.query.filter_by(email=email).first()
    if user and user.password == password:
        session['user'] = user.serialize()
        return jsonify({"user": user.serialize(), "message": "Logged in successfully"}), 200
    return jsonify({"message": "Invalid email or password"}), 401


# User Logout
@app.route('/logout', methods=['GET'])
@login_required
def logout():
    logout_user()
    return jsonify({"message": "Logged out successfully"}), 200

# Play Song
from flask import request


@app.route('/save-to-history/<int:song_id>', methods=['POST'])
def save_to_history(song_id):
    try:
        data = request.get_json()
        username = data.get('username')
        if not username:
            app.logger.error("Username is missing in request payload")
            return jsonify({"error": "Username is missing"}), 400

        # Fetch the song from the database
        song = Song.query.get_or_404(song_id)

        # Log the song ID for debugging
        app.logger.info(f"Received request to save song with ID: {song_id}")

        # Create a new entry in the listening history
        listening_history = UserListeningHistory(username=username, songID=song.songID)
        db.session.add(listening_history)
        db.session.commit()

        # Log success message
        app.logger.info("Song saved to listening history successfully")

        return jsonify({"message": "Song saved to listening history successfully"}), 200
    except Exception as e:
        # Log the error message
        app.logger.error(f"Error saving song to listening history: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@app.route('/playlists', methods=['POST'])
def create_playlist():
    print(f"Request method: {request.method}")
    data = request.get_json()
    name = data.get('name')
    username = data.get('username')
    if not name:
        return jsonify({"message": "Missing playlist name"}), 400

    playlist = Playlist(name=name, username=username)
    db.session.add(playlist)
    db.session.commit()
    return jsonify(playlist.serialize()), 201


@app.route('/playlists/<int:playlist_id>/add-song/<int:song_id>', methods=['POST'])
def add_song_to_playlist(playlist_id, song_id):
    playlist = Playlist.query.get_or_404(playlist_id)
    song = Song.query.get_or_404(song_id)

    if song not in playlist.songs:
        playlist.songs.append(song)
        db.session.commit()
        return jsonify({"message": "Song added to playlist successfully"}), 200
    else:
        return jsonify({"message": "Song already exists in playlist"}), 409

# Get Specific Album
@app.route('/albums/<int:album_id>/', methods=['GET'])
def get_specific_album(album_id):
    album = Album.query.get_or_404(album_id)

    if album:
        album_data = {
            "id": album.albumID,
            "name": album.name,
            "release_date": album.releasedate,
            "cover_image_link": album.coverimagelink,
            "artist": album.artist.name,
            "songs": [song.serialize() for song in album.songs]  # Serialize each song
        }
        return jsonify(album_data), 200
    return jsonify({"message": "Song not found in album"}), 404

# Get All Songs
@app.route('/songs', methods=['GET'])
def get_all_songs():
    songs = Song.query.all()
    songs_data = [{
        "id": song.songID,
        "title": song.title,
        "artist": song.artist.name,
        "url": song.audiolink,
        "album": song.albumID
    } for song in songs]
    return jsonify(songs_data), 200

# Get All Albums
@app.route('/albums', methods=['GET'])
def get_all_albums():
    albums = Album.query.all()
    albums_data = [{
        "id": album.albumID,
        "name": album.name,
        "release_date": album.releasedate,
        "cover_image_link": album.coverimagelink,
        "artist": album.artist.name,
        "songs": [song.serialize() for song in album.songs]  # Serialize each song
    } for album in albums]
    return jsonify(albums_data), 200

# Manage Playlists
@app.route('/playlists', methods=['GET'])
def get_all_playlists():
    playlists = Playlist.query.all()
    playlists_data = [{
        "id": playlist.playlistID,
        "name": playlist.name,
        "username": playlist.username,
        "songs": [song.serialize() for song in playlist.songs]
    } for playlist in playlists]
    return jsonify(playlists_data), 200

# Get a specific Playlidt
@app.route('/playlists/<int:playlist_id>', methods=['GET'])
def get_playlist(playlist_id):
    playlist = Playlist.query.get_or_404(playlist_id)
    playlist_data = {
        "id": playlist.playlistID,
        "name": playlist.name,
        "username": playlist.username,
        "songs": [song.serialize() for song in playlist.songs]
    }
    return jsonify(playlist_data), 200

# Search Songs
@app.route('/search', methods=['POST'])
def search_songs():
    data = request.get_json()
    query = data.get('query')
    if not query:
        return jsonify({"message": "Missing query"}), 400
    songs = Song.query.filter(Song.title.ilike(f'%{query}%')).all()
    return jsonify([{"id": song.songID, "title": song.title, "artist": song.artist.name, "audio_link": song.audiolink} for song in songs]), 200


@app.route('/search-and-play', methods=['POST'])
def search_and_play_songs():
    data = request.get_json()
    query = data.get('query')
    if not query:
        return jsonify({"message": "Missing query"}), 400
    songs = Song.query.filter(Song.title.ilike(f'%{query}%')).all()
    if songs:
        # Play the first matching song
        song = songs[0]
        # Save listening history
        listening_history = UserListeningHistory(username=current_user.username, songID=song.songID)
        db.session.add(listening_history)
        db.session.commit()
        return jsonify({"audio_link": song.audiolink}), 200
    return jsonify({"message": "No matching songs found"}), 404

# Follow Artist
@app.route('/follow-artist/<int:artist_id>', methods=['POST'])
@login_required
def follow_artist(artist_id):
    artist = Artist.query.get_or_404(artist_id)
    if artist not in current_user.followed_artists:
        current_user.followed_artists.append(artist)
        db.session.commit()
        return jsonify({"message": "Artist followed successfully"}), 200
    return jsonify({"message": "Already following this artist"}), 409

# Unfollow Artist
@app.route('/unfollow-artist/<int:artist_id>', methods=['POST'])
@login_required
def unfollow_artist(artist_id):
    artist = Artist.query.get_or_404(artist_id)
    if artist in current_user.followed_artists:
        current_user.followed_artists.remove(artist)
        db.session.commit()
        return jsonify({"message": "Artist unfollowed successfully"}), 200
    return jsonify({"message": "Not following this artist"}), 404

# Add Artist, Album, Song (Minimal Admin Facilities)
@app.route('/admin/add-artist', methods=['POST'])
@login_required
def add_artist():
    data = request.get_json()
    name = data.get('name')
    bio = data.get('bio')
    if not name:
        return jsonify({"message": "Missing name"}), 400
    artist = Artist(name=name, bio=bio)
    db.session.add(artist)
    db.session.commit()
    return jsonify({"message": "Artist added successfully"}), 201

@app.route('/admin/add-album', methods=['POST'])
@login_required
def add_album():
    data = request.get_json()
    name = data.get('name')
    artist_id = data.get('artist_id')
    coverimagelink = data.get('coverimagelink')
    if not all([name, artist_id]):
        return jsonify({"message": "Missing name or artist_id"}), 400
    artist = Artist.query.get_or_404(artist_id)
    album = Album(name=name, artist=artist, coverimagelink= coverimagelink)
    db.session.add(album)
    db.session.commit()
    return jsonify({"message": "Album added successfully"}), 201

@app.route('/admin/add-song', methods=['POST'])
@login_required
def add_song():
    data = request.get_json()
    title = data.get('title')
    artist_id = data.get('artist_id')
    album_id = data.get('album_id')
    genre_name = data.get('genre_name')
    duration = data.get('duration')
    audiolink = data.get('audiolink')
    if not all([title, artist_id, duration, audiolink]):
        return jsonify({"message": "Missing required fields"}), 400
    artist = Artist.query.get_or_404(artist_id)
    album = Album.query.get_or_404(album_id) if album_id else None
    song = Song(title=title, artist=artist, album=album, genreName=genre_name, duration=duration, audiolink=audiolink)
    db.session.add(song)
    db.session.commit()
    return jsonify({"message": "Song added successfully"}), 201

# Fetch user listening history
@app.route('/users/<username>/listening-history', methods=['GET'])
def get_listening_history(username):
    print("Fetching listening history for user:", username)  # Add logging
    listening_history = UserListeningHistory.query.filter_by(username=username).all()
    history_data = [{
        "id": item.songID,
        "title": item.song.title,
        "artist": item.song.artist.name
    } for item in listening_history]
    print("Listening history data:", history_data)  # Add logging
    return jsonify(history_data), 200

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)

if __name__ == '__main__':
    app.run(debug=True)
