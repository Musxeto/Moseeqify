create database moseeqify

use moseeqify

-- Create User table
CREATE TABLE Users (
    username VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(100),
    password VARCHAR(255) NOT NULL,
    dob DATE,
    dateJoined DATE DEFAULT GETDATE()
);

-- Create Artist table
CREATE TABLE Artists (
    artistID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    bio TEXT,
    profilepiclink VARCHAR(255)
);

-- Create Album table
CREATE TABLE Albums (
    albumID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    artistID INT FOREIGN KEY REFERENCES Artists(artistID),
    releaseDate DATE,
    coverimagelink VARCHAR(255)
);

-- Create Genre table
CREATE TABLE Genre (
    genreName VARCHAR(50) PRIMARY KEY
);

-- Create Song table
CREATE TABLE Songs (
    songID INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(100),
    artistID INT FOREIGN KEY REFERENCES Artists(artistID),
    albumID INT FOREIGN KEY REFERENCES Albums(albumID),
    genreName VARCHAR(50) FOREIGN KEY REFERENCES Genre(genreName),
    duration INT,
    audiolink VARCHAR(255),
    releaseDate DATE
);

-- Create ListeningHistory table
CREATE TABLE ListeningHistory (
    username VARCHAR(50) FOREIGN KEY REFERENCES Users(username),
    songID INT FOREIGN KEY REFERENCES Songs(songID),
    timestamp DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (username, songID)
);

-- Create Playlist table
CREATE TABLE Playlist (
    playlistID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    creationDate DATE DEFAULT GETDATE(),
    duration INT,
    username VARCHAR(50) FOREIGN KEY REFERENCES Users(username)
);

-- Create PlaylistSongs table
CREATE TABLE PlaylistSongs (
    playlistID INT FOREIGN KEY REFERENCES Playlist(playlistID),
    songID INT FOREIGN KEY REFERENCES Songs(songID),
    PRIMARY KEY (playlistID, songID)
);
