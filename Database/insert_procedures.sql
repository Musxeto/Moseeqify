create procedure insert_in_User
    @username VARCHAR(50), @name VARCHAR(100)
    ,@password VARCHAR(100)
    ,@email VARCHAR(100)
    , @dob DATE, @dateJoined DATETIME
AS
BEGIN
    insert into [User](username,email,name,[password],dob,dateJoined)
    values
    (@username,@email,@name,@password,@dob,@dateJoined);
END 
GO
create procedure insert_in_Artist
    @name VARCHAR(100), @bio VARCHAR(MAX), @profilepiclink VARCHAR(255)
AS
BEGIN
    insert into Artist
    values
    (@name,@bio,@profilepiclink);
END 
GO
create procedure insert_in_Genre
     @genreName VARCHAR(50)
AS
BEGIN
    insert into Genre
    values
    (@genreName);
END 
GO
create procedure insert_in_album
    @name VARCHAR(100), @artistID INT, @releasedate DATETIME, @coverimagelink VARCHAR(255)
AS
BEGIN
    insert into Album
    values
    (@name,@artistID,@releasedate,@coverimagelink);
END 
GO
CREATE PROCEDURE InsertSong
    @title VARCHAR(100),
    @artistID INT,
    @albumID INT = NULL,
    @genreName VARCHAR(50) = NULL,
    @duration TIME,
    @audiolink VARCHAR(255),
    @releaseDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @releaseDate IS NULL
        SET @releaseDate = CURRENT_TIMESTAMP;

    INSERT INTO Song (title, artistID, albumID, genreName, duration, audiolink, releaseDate)
    VALUES (@title, @artistID, @albumID, @genreName, @duration, @audiolink, @releaseDate);
END;
CREATE PROCEDURE InsertAlbumSong
    @albumID INT,
    @songID INT
AS
BEGIN
    INSERT INTO AlbumSongs (albumID, songID)
    VALUES (@albumID, @songID);
END;
CREATE PROCEDURE InsertPlaylist
    @name VARCHAR(100),
    @username VARCHAR(50)
AS
BEGIN
    INSERT INTO Playlist (name, creationdate, username)
    VALUES (@name, CURRENT_TIMESTAMP, @username);
END;
CREATE PROCEDURE InsertPlaylistSong
    @playlistID INT,
    @songID INT
AS
BEGIN
    INSERT INTO PlaylistSongs (playlistID, songID)
    VALUES (@playlistID, @songID);
END;

CREATE PROCEDURE InsertUserListeningHistory
    @username VARCHAR(50),
    @songID INT
AS
BEGIN
    INSERT INTO UserListeningHistory (username, songID, listeningDate)
    VALUES (@username, @songID, CURRENT_TIMESTAMP);
END;

CREATE PROCEDURE InsertUserFollowsArtist
    @username VARCHAR(50),
    @artistID INT
AS
BEGIN
    INSERT INTO user_follows_artists (username, artistID)
    VALUES (@username, @artistID);
END;


use moseeqify