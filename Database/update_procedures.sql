-- Procedure to get content of a table dynamically
CREATE PROCEDURE get_table_content
    @TableName NVARCHAR(128)
AS
BEGIN
    DECLARE @Exec_STAT NVARCHAR(MAX)
    SET @Exec_STAT = N'SELECT * FROM ' + QUOTENAME(@TableName)
    EXEC sp_executesql @Exec_STAT
END
GO

-- Procedure to update user information in the User table
CREATE PROCEDURE update_in_User
     @username VARCHAR(50),
     @name VARCHAR(100),
     @password VARCHAR(100),
     @email VARCHAR(100),
     @dob DATE,
     @dateJoined DATETIME
AS
BEGIN
    -- Update user information
    UPDATE [USER]
    SET name = @name,
        [password] = @password,
        email = @email,
        dob = @dob,
        dateJoined = @dateJoined
    WHERE username = @username
END     
GO

-- Procedure to update artist information in the Artist table
CREATE PROCEDURE update_in_Artist
    @artistID INT,
    @name VARCHAR(100),
    @bio VARCHAR(MAX),
    @profilepiclink VARCHAR(255)
AS
BEGIN
    -- Update artist information
    UPDATE Artist
    SET name = @name,
        bio = @bio,
        profilepiclink = @profilepiclink
    WHERE artistID = @artistID
END     
GO

-- Procedure to update genre information in the Genre table
CREATE PROCEDURE update_in_Genre
    @old varchar(50),
    @genreName VARCHAR(50)
AS
BEGIN
    -- Update genre information
    UPDATE Genre
    SET genreName = @genreName
    WHERE genreName = @old
END     
GO

-- Procedure to update album information in the Album table
CREATE PROCEDURE update_in_album
    @albumID INT,
    @name VARCHAR(100),
    @artistID INT,
    @releasedate DATETIME,
    @coverimagelink VARCHAR(255)
AS
BEGIN
    -- Update album information
    UPDATE Album
    SET name = @name,
        artistID = @artistID,
        releasedate = @releasedate,
        coverimagelink = @coverimagelink
    WHERE albumID = @albumID
END     
GO

-- Procedure to update song information in the Song table
CREATE PROCEDURE UpdateSong
    @songID INT,
    @title VARCHAR(100),
    @artistID INT,
    @albumID INT = NULL,
    @genreName VARCHAR(50) = NULL,
    @duration TIME,
    @audiolink VARCHAR(255),
    @releaseDate DATETIME = NULL
AS
BEGIN
    -- Update song information
    UPDATE Song
    SET title = @title,
        artistID = @artistID,
        albumID = @albumID,
        genreName = @genreName,
        duration = @duration,
        audiolink = @audiolink,
        releaseDate = ISNULL(@releaseDate, CURRENT_TIMESTAMP)
    WHERE songID = @songID;
END;

-- Procedure to update album-song relationship in the AlbumSongs table
CREATE PROCEDURE UpdateAlbumSong
    @oldAlbumID INT,
    @oldSongID INT,
    @newAlbumID INT,
    @newSongID INT
AS
BEGIN
    -- Delete the old record
    DELETE FROM AlbumSongs
    WHERE albumID = @oldAlbumID AND songID = @oldSongID;

    -- Insert the new record
    INSERT INTO AlbumSongs (albumID, songID)
    VALUES (@newAlbumID, @newSongID);
END;

-- Procedure to update playlist information in the Playlist table
CREATE PROCEDURE UpdatePlaylist
    @playlistID INT,
    @name VARCHAR(100),
    @username VARCHAR(50)
AS
BEGIN
    -- Update playlist information
    UPDATE Playlist
    SET name = @name,
        username = @username
    WHERE playlistID = @playlistID;
END;

-- Procedure to update playlist-song relationship in the PlaylistSongs table
CREATE PROCEDURE UpdatePlaylistSong
    @oldPlaylistID INT,
    @oldSongID INT,
    @newPlaylistID INT,
    @newSongID INT
AS
BEGIN
    -- Delete the old record
    DELETE FROM PlaylistSongs
    WHERE playlistID = @oldPlaylistID AND songID = @oldSongID;

    -- Insert the new record
    INSERT INTO PlaylistSongs (playlistID, songID)
    VALUES (@newPlaylistID, @newSongID);
END;

-- Procedure to update user listening history in the UserListeningHistory table
CREATE PROCEDURE UpdateUserListeningHistory
    @oldUsername VARCHAR(50),
    @oldSongID INT,
    @oldListeningDate DATETIME,
    @newUsername VARCHAR(50),
    @newSongID INT
AS
BEGIN
    -- Delete the old record
    DELETE FROM UserListeningHistory
    WHERE username = @oldUsername AND songID = @oldSongID AND listeningDate = @oldListeningDate;

    -- Insert the new record
    INSERT INTO UserListeningHistory (username, songID, listeningDate)
    VALUES (@newUsername, @newSongID, CURRENT_TIMESTAMP);
END;

-- Procedure to update user-artist follow relationship in the user_follows_artists table
CREATE PROCEDURE UpdateUserFollowsArtist
    @oldUsername VARCHAR(50),
    @oldArtistID INT,
    @newUsername VARCHAR(50),
    @newArtistID INT
AS
BEGIN
    -- Delete the old record
    DELETE FROM user_follows_artists
    WHERE username = @oldUsername AND artistID = @oldArtistID;

    -- Insert the new record
    INSERT INTO user_follows_artists (username, artistID)
    VALUES (@newUsername, @newArtistID);
END;
