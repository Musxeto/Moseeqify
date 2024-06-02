from flask import Flask, jsonify, request, session
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS, cross_origin
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from sqlalchemy.exc import IntegrityError
from functools import wraps
from models import User, UserListeningHistory, UserFollowsArtists, Artist, Album, AlbumSongs, PlaylistSongs, Playlist, Song
from models import db
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
@app.route('/play-song/<int:song_id>', methods=['GET'])
@login_required
def play_song(song_id):
    song = Song.query.get_or_404(song_id)
    # Save listening history
    listening_history = UserListeningHistory(username=current_user.username, songID=song.songID)
    db.session.add(listening_history)
    db.session.commit()
    return jsonify({"audio_link": song.audiolink}), 200

# Play Song from Playlist
@app.route('/playlists/<int:playlist_id>/play-song/<int:song_id>', methods=['GET'])
@login_required
def play_song_from_playlist(playlist_id, song_id):
    playlist = Playlist.query.get_or_404(playlist_id)
    song = Song.query.get_or_404(song_id)
    if song in playlist.songs:
        # Save listening history
        listening_history = UserListeningHistory(username=current_user.username, songID=song.songID)
        db.session.add(listening_history)
        db.session.commit()
        return jsonify({"audio_link": song.audiolink}), 200
    return jsonify({"message": "Song not found in playlist"}), 404

# Play Song from Album
@app.route('/albums/<int:album_id>/play-song/<int:song_id>', methods=['GET'])
@login_required
def play_song_from_album(album_id, song_id):
    album = Album.query.get_or_404(album_id)
    song = Song.query.get_or_404(song_id)
    if album == song.album:
        # Save listening history
        listening_history = UserListeningHistory(username=current_user.username, songID=song.songID)
        db.session.add(listening_history)
        db.session.commit()
        return jsonify({"audio_link": song.audiolink}), 200
    return jsonify({"message": "Song not found in album"}), 404

# Manage Playlists
# Create Playlist
@app.route('/playlists', methods=['POST'])
@login_required
def create_playlist():
    data = request.get_json()
    name = data.get('name')
    if not name:
        return jsonify({"message": "Missing name"}), 400
    playlist = Playlist(name=name, username=current_user.username)
    db.session.add(playlist)
    db.session.commit()
    return jsonify({"message": "Playlist created successfully"}), 201

# Update Playlist
@app.route('/playlists/<int:playlist_id>', methods=['PUT'])
@login_required
def update_playlist(playlist_id):
    playlist = Playlist.query.get_or_404(playlist_id)
    data = request.get_json()
    new_name = data.get('name')
    if not new_name:
        return jsonify({"message": "Missing name"}), 400
    playlist.name = new_name
    db.session.commit()
    return jsonify({"message": "Playlist updated successfully"}), 200

# Delete Playlist
@app.route('/playlists/<int:playlist_id>', methods=['DELETE'])
@login_required
def delete_playlist(playlist_id):
    playlist = Playlist.query.get_or_404(playlist_id)
    db.session.delete(playlist)
    db.session.commit()
    return jsonify({"message": "Playlist deleted successfully"}), 200

# Add Song to Playlist
@app.route('/playlists/<int:playlist_id>/add-song', methods=['POST'])
@login_required
def add_song_to_playlist(playlist_id):
    data = request.get_json()
    song_id = data.get('song_id')
    if not song_id:
        return jsonify({"message": "Missing song_id"}), 400
    playlist = Playlist.query.get_or_404(playlist_id)
    song = Song.query.get_or_404(song_id)
    if song not in playlist.songs:
        playlist.songs.append(song)
        db.session.commit()
        return jsonify({"message": "Song added to playlist successfully"}), 200
    return jsonify({"message": "Song already exists in playlist"}), 409

# Remove Song from Playlist
@app.route('/playlists/<int:playlist_id>/remove-song', methods=['POST'])
@login_required
def remove_song_from_playlist(playlist_id):
    data = request.get_json()
    song_id = data.get('song_id')
    if not song_id:
        return jsonify({"message": "Missing song_id"}), 400
    playlist = Playlist.query.get_or_404(playlist_id)
    song = Song.query.get_or_404(song_id)
    if song in playlist.songs:
        playlist.songs.remove(song)
        db.session.commit()
        return jsonify({"message": "Song removed from playlist successfully"}), 200
    return jsonify({"message": "Song not found in playlist"}), 404

# Search Songs
@app.route('/search', methods=['POST'])
def search_songs():
    data = request.get_json()
    query = data.get('query')
    if not query:
        return jsonify({"message": "Missing query"}), 400
    songs = Song.query.filter(Song.title.ilike(f'%{query}%')).all()
    return jsonify([{"title": song.title, "audio_link": song.audiolink} for song in songs]), 200

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

if __name__ == '__main__':
    app.run(debug=True)
