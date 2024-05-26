CREATE DATABASE moseeqify;
USE moseeqify;

-- Create User table
CREATE TABLE [User] (
    username VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    name VARCHAR(100),
    password VARCHAR(100),
    dob DATE,
    dateJoined DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT CHK_User_Age CHECK (DATEDIFF(YEAR, dob, GETDATE()) >= 18),
    CONSTRAINT FK_User_Song FOREIGN KEY (username) REFERENCES [User](username)
);

-- Create Artist table
CREATE TABLE Artist (
    artistID INT PRIMARY KEY,
    name VARCHAR(100) UNIQUE,
    bio TEXT,
    profilepiclink VARCHAR(255)
);

-- Create Genre table
CREATE TABLE Genre (
    genreName VARCHAR(50) PRIMARY KEY
);

-- Create Album table
CREATE TABLE Album (
    albumID INT PRIMARY KEY,
    name VARCHAR(100),
    artistID INT,
    releasedate DATETIME,
    coverimagelink VARCHAR(255),
    CONSTRAINT FK_Album_Artist FOREIGN KEY (artistID) REFERENCES Artist(artistID)
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
    releaseDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_Song_Artist FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    CONSTRAINT FK_Song_Album FOREIGN KEY (albumID) REFERENCES Album(albumID),
    CONSTRAINT FK_Song_Genre FOREIGN KEY (genreName) REFERENCES Genre(genreName)
);

-- Create AlbumSongs table
CREATE TABLE AlbumSongs (
    albumID INT,
    songID INT,
    PRIMARY KEY (albumID, songID),
    CONSTRAINT FK_AlbumSongs_Album FOREIGN KEY (albumID) REFERENCES Album(albumID),
    CONSTRAINT FK_AlbumSongs_Song FOREIGN KEY (songID) REFERENCES Song(songID)
);

-- Create Playlist table
CREATE TABLE Playlist (
    playlistID INT PRIMARY KEY,
    name VARCHAR(100),
    creationdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(50),
    CONSTRAINT FK_Playlist_User FOREIGN KEY (username) REFERENCES [User](username)
);

-- Create PlaylistSongs table
CREATE TABLE PlaylistSongs (
    playlistID INT,
    songID INT,
    PRIMARY KEY (playlistID, songID),
    CONSTRAINT FK_PlaylistSongs_Playlist FOREIGN KEY (playlistID) REFERENCES Playlist(playlistID),
    CONSTRAINT FK_PlaylistSongs_Song FOREIGN KEY (songID) REFERENCES Song(songID)
);

-- Create UserListeningHistory table
CREATE TABLE UserListeningHistory (
    username VARCHAR(50),
    songID INT,
    listeningDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_UserListeningHistory_User FOREIGN KEY (username) REFERENCES [User](username),
    CONSTRAINT FK_UserListeningHistory_Song FOREIGN KEY (songID) REFERENCES Song(songID)
);

-- Create ArtistReleasedSongs table
CREATE TABLE ArtistReleasedSongs (
    artistID INT,
    songID INT,
    PRIMARY KEY (artistID, songID),
    CONSTRAINT FK_ArtistReleasedSongs_Artist FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    CONSTRAINT FK_ArtistReleasedSongs_Song FOREIGN KEY (songID) REFERENCES Song(songID)
);

-- Add trigger to enforce age constraint for users
CREATE TRIGGER CheckUserAge
ON [User]
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE DATEDIFF(YEAR, inserted.dob, GETDATE()) < 18)
    BEGIN
        RAISERROR ('Users must be at least 18 years old.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;


-- Create a trigger to automatically insert records into AlbumSongs table
CREATE TRIGGER InsertIntoAlbumSongs
ON Song
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert into AlbumSongs if the inserted song has a non-null albumID
    INSERT INTO AlbumSongs (albumID, songID)
    SELECT inserted.albumID, inserted.songID
    FROM inserted
    WHERE inserted.albumID IS NOT NULL;
END;

truncate table artist
-- Insert an artist
INSERT INTO Artist (artistID, name, bio, profilepiclink)
VALUES (1, 'John Doe', 'Bio of John Doe', 'https://example.com/profilepic.jpg');

-- Insert an album
INSERT INTO Album (albumID, name, artistID, releasedate, coverimagelink)
VALUES (1, 'Greatest Hits', 1, '2023-01-01', 'https://example.com/cover.jpg');

-- Insert genres
INSERT INTO Genre (genreName)
VALUES ('Pop'), ('Rock'), ('Hip-Hop');

-- Insert songs
INSERT INTO Song (songID, title, artistID, albumID, genreName, duration, audiolink, releaseDate)
VALUES 
    (1, 'Song 1', 1, 1, 'Pop', '00:04:30', 'https://example.com/song1.mp3', '2023-01-01'),
    (2, 'Song 2', 1, 1, 'Pop', '00:03:45', 'https://example.com/song2.mp3', '2023-01-01');


