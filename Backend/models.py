from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

db = SQLAlchemy()

class User(db.Model, UserMixin):
    username = db.Column(db.String(50), primary_key=True)
    email = db.Column(db.String(100), unique=True, nullable=False)
    name = db.Column(db.String(100), nullable=False)
    password = db.Column(db.String(100), nullable=False)
    dob = db.Column(db.Date, nullable=False)
    dateJoined = db.Column(db.DateTime, default=db.func.current_timestamp())

    def serialize(self):
        return {
            'username': self.username,
            'email': self.email,
            'name': self.name,
            'dob': self.dob,
        }
    def get_id(self):
        return self.username

class Artist(db.Model):
    artistID = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)
    bio = db.Column(db.Text)
    profilepiclink = db.Column(db.String(255))

class Genre(db.Model):
    genreName = db.Column(db.String(50), primary_key=True)

class Album(db.Model):
    albumID = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    releasedate = db.Column(db.DateTime)
    coverimagelink = db.Column(db.String(255), nullable=False)
    artistID = db.Column(db.Integer, db.ForeignKey('artist.artistID'), nullable=False)
    artist = db.relationship('Artist', backref=db.backref('albums', lazy=True))
    songs = db.relationship('Song', backref='album', lazy=True)

class Song(db.Model):
    songID = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    artistID = db.Column(db.Integer, db.ForeignKey('artist.artistID'), nullable=False)
    artist = db.relationship('Artist', backref=db.backref('songs', lazy=True))
    albumID = db.Column(db.Integer, db.ForeignKey('album.albumID'))
    genreName = db.Column(db.String(50), db.ForeignKey('genre.genreName'))
    duration = db.Column(db.Time, nullable=False)
    audiolink = db.Column(db.String(255), nullable=False)
    releaseDate = db.Column(db.DateTime, default=db.func.current_timestamp())

class Playlist(db.Model):
    playlistID = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    creationdate = db.Column(db.DateTime, default=db.func.current_timestamp())
    username = db.Column(db.String(50), db.ForeignKey('user.username'), nullable=False)
    songs = db.relationship('Song', secondary='PlaylistSongs', backref=db.backref('playlists', lazy=True))

class PlaylistSongs(db.Model):
    __tablename__ = 'PlaylistSongs'
    playlistID = db.Column(db.Integer, db.ForeignKey('playlist.playlistID'), primary_key=True)
    songID = db.Column(db.Integer, db.ForeignKey('song.songID'), primary_key=True)

class AlbumSongs(db.Model):
    __tablename__ = 'AlbumSongs'
    albumID = db.Column(db.Integer, db.ForeignKey('album.albumID'), primary_key=True)
    songID = db.Column(db.Integer, db.ForeignKey('song.songID'), primary_key=True)

class UserListeningHistory(db.Model):
    __tablename__ = 'UserListeningHistory'
    username = db.Column(db.String(50), db.ForeignKey('user.username'), nullable=False, primary_key=True)
    songID = db.Column(db.Integer, db.ForeignKey('song.songID'), nullable=False, primary_key=True)
    listeningDate = db.Column(db.DateTime, default=db.func.current_timestamp(), primary_key=True)

class UserFollowsArtists(db.Model):
    __tablename__ = 'user_follows_artists'
    username = db.Column(db.String(50), db.ForeignKey('user.username'), primary_key=True)
    artistID = db.Column(db.Integer, db.ForeignKey('artist.artistID'), primary_key=True)
