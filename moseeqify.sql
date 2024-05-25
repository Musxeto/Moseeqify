CREATE DATABASE moseeqify;
USE moseeqify;

-- Create User table
CREATE TABLE [User] (
    username VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100),
    name VARCHAR(100),
    password VARCHAR(100),
    dob DATE,
    dateJoined DATETIME,
    CONSTRAINT DF_User_dateJoined DEFAULT GETDATE() FOR dateJoined
);

-- Create Artist table
CREATE TABLE Artist (
    artistID INT PRIMARY KEY,
    name VARCHAR(100),
    bio TEXT,
    profilepiclink VARCHAR(255)
);

-- Create UserFollowsArtist table
CREATE TABLE UserFollowsArtist (
    username VARCHAR(50),
    artistID INT,
    PRIMARY KEY (username, artistID),
    FOREIGN KEY (username) REFERENCES [User](username),
    FOREIGN KEY (artistID) REFERENCES Artist(artistID)
);

-- Create Album table
CREATE TABLE Album (
    albumID INT PRIMARY KEY,
    name VARCHAR(100),
    artistID INT,
    releasedate DATE,
    coverimagelink VARCHAR(255),
    CONSTRAINT CK_Album_Songs CHECK ((SELECT COUNT(*) FROM AlbumSongs WHERE AlbumSongs.albumID = Album.albumID) > 0),
    FOREIGN KEY (artistID) REFERENCES Artist(artistID)
);

-- Create AlbumSongs table
CREATE TABLE AlbumSongs (
    albumID INT,
    songID INT,
    PRIMARY KEY (albumID, songID),
    FOREIGN KEY (albumID) REFERENCES Album(albumID),
    FOREIGN KEY (songID) REFERENCES Song(songID)
);

-- Create Playlist table
CREATE TABLE Playlist (
    playlistID INT PRIMARY KEY,
    name VARCHAR(100),
    creationdate DATE,
    username VARCHAR(50),
    CONSTRAINT DF_Playlist_creationdate DEFAULT GETDATE() FOR creationdate,
    FOREIGN KEY (username) REFERENCES [User](username)
);

-- Create PlaylistSongs table
CREATE TABLE PlaylistSongs (
    playlistID INT,
    songID INT,
    PRIMARY KEY (playlistID, songID),
    FOREIGN KEY (playlistID) REFERENCES Playlist(playlistID),
    FOREIGN KEY (songID) REFERENCES Song(songID)
);

-- Create UserListeningHistory table
CREATE TABLE UserListeningHistory (
    username VARCHAR(50),
    songID INT,
    listeningDate DATETIME,
    FOREIGN KEY (username) REFERENCES [User](username),
    FOREIGN KEY (songID) REFERENCES Song(songID)
);

-- Create Genre table
CREATE TABLE Genre (
    genreName VARCHAR(50) PRIMARY KEY
);

-- Create Song table
CREATE TABLE Song (
    songID INT PRIMARY KEY,
    title VARCHAR(100),
    artistID INT,
    albumID INT,
    genreName VARCHAR(50),
    duration TIME,
    audiolink VARCHAR(255),
    releaseDate DATE,
    CONSTRAINT DF_Song_releaseDate DEFAULT GETDATE() FOR releaseDate,
    FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    FOREIGN KEY (albumID) REFERENCES Album(albumID),
    FOREIGN KEY (genreName) REFERENCES Genre(genreName)
);

-- Create ArtistReleasedSongs table
CREATE TABLE ArtistReleasedSongs (
    artistID INT,
    songID INT,
    PRIMARY KEY (artistID, songID),
    FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    FOREIGN KEY (songID) REFERENCES Song(songID)
);
