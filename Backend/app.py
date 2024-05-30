from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from sqlalchemy.exc import IntegrityError
from models import db, User, Artist, Album, Song, Playlist, UserListeningHistory, PlaylistSongs, UserFollowsArtists, Genre

app = Flask(__name__)
app.config.from_object('config.Config')
db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

@login_manager.user_loader
def load_user(username):
    return User.query.get(username)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        user = User.query.filter_by(email=email).first()
        if user and user.password == password:
            login_user(user)
            return redirect(url_for('profile'))
        else:
            flash('Invalid email or password')
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        name = request.form['name']
        password = request.form['password']
        dob = request.form['dob']

        user = User(username=username, email=email, name=name, dob=dob, password=password)

        try:
            db.session.add(user)
            db.session.commit()
            login_user(user)
            return redirect(url_for('profile'))
        except IntegrityError:
            db.session.rollback()
            flash('Username or Email already exists. Please choose a different username.')
            return redirect(url_for('register'))

    return render_template('register.html')

@app.route('/profile')
@login_required
def profile():
    listening_history = UserListeningHistory.query.filter_by(username=current_user.username).all()
    user_listening_history = []
    for history in listening_history:
        song = Song.query.get(history.songID)
        user_listening_history.append({'song': song})
    return render_template('profile.html', name=current_user.name, user_listening_history=user_listening_history)

@app.route('/playlists', methods=['GET', 'POST'])
@login_required
def manage_playlists():
    if request.method == 'POST':
        name = request.form['name']
        playlist = Playlist(name=name, username=current_user.username)
        db.session.add(playlist)
        db.session.commit()
        return redirect(url_for('manage_playlists'))
    playlists = Playlist.query.filter_by(username=current_user.username).all()
    return render_template('playlists.html', playlists=playlists)

@app.route('/artists', methods=['GET'])
def show_artists():
    artists = Artist.query.all()
    return render_template('artists.html', artists=artists)

@app.route('/follow_artist/<int:artistID>', methods=['POST'])
@login_required
def follow_artist(artistID):
    follow = UserFollowsArtists(username=current_user.username, artistID=artistID)
    db.session.add(follow)
    db.session.commit()
    return redirect(url_for('show_artists'))

@app.route('/songs/<int:albumID>', methods=['GET'])
def show_songs(albumID):
    songs = Song.query.filter_by(albumID=albumID).all()
    return render_template('songs.html', songs=songs)

@app.route('/play_song/<int:songID>', methods=['GET'])
@login_required
def play_song(songID):
    history = UserListeningHistory(username=current_user.username, songID=songID)
    db.session.add(history)
    db.session.commit()
    return redirect(url_for('profile'))

# Admin routes for CRUD operations on albums, songs, and artists

@app.route('/admin')
@login_required
def admin():
    if not current_user.is_admin:
        flash('Unauthorized access.')
        return redirect(url_for('index'))
    return render_template('admin.html')

@app.route('/admin/add_artist', methods=['GET', 'POST'])
@login_required
def add_artist():
    if request.method == 'POST':
        name = request.form['name']
        bio = request.form['bio']
        profilepiclink = request.form['profilepiclink']
        artist = Artist(name=name, bio=bio, profilepiclink=profilepiclink)
        db.session.add(artist)
        db.session.commit()
        return redirect(url_for('admin'))
    return render_template('add_artist.html')

@app.route('/admin/add_album', methods=['GET', 'POST'])
@login_required
def add_album():
    if request.method == 'POST':
        name = request.form['name']
        artistID = request.form['artistID']
        releasedate = request.form['releasedate']
        coverimagelink = request.form['coverimagelink']
        album = Album(name=name, artistID=artistID, releasedate=releasedate, coverimagelink=coverimagelink)
        db.session.add(album)
        db.session.commit()
        return redirect(url_for('admin'))
    artists = Artist.query.all()
    return render_template('add_album.html', artists=artists)

@app.route('/admin/add_song', methods=['GET', 'POST'])
@login_required
def add_song():
    if request.method == 'POST':
        title = request.form['title']
        artistID = request.form['artistID']
        albumID = request.form['albumID']
        genreName = request.form['genreName']
        duration = request.form['duration']
        audiolink = request.form['audiolink']
        song = Song(title=title, artistID=artistID, albumID=albumID, genreName=genreName, duration=duration, audiolink=audiolink)
        db.session.add(song)
        db.session.commit()
        return redirect(url_for('admin'))
    artists = Artist.query.all()
    albums = Album.query.all()
    genres = Genre.query.all()
    return render_template('add_song.html', artists=artists, albums=albums, genres=genres)

if __name__ == '__main__':
    app.run(debug=True)
