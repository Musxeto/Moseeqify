-- Delete a user from the User table
CREATE PROCEDURE delete_from_user
    @username varchar(50)
AS
BEGIN
    DELETE FROM [User]
    WHERE username = @username;
END
GO

-- Delete an artist from the Artist table
CREATE PROCEDURE delete_from_Artist
    @ArtistID int
AS
BEGIN
    DELETE FROM Artist
    WHERE artistID = @ArtistID;
END
GO

-- Delete a genre from the Genre table
CREATE PROCEDURE delete_from_Genre
    @genreName VARCHAR(50)
AS
BEGIN
    DELETE FROM Genre
    WHERE genreName = @genreName;
END
GO

-- Delete an album from the Album table
CREATE PROCEDURE delete_from_album
    @albumID INT
AS
BEGIN
    DELETE FROM Album
    WHERE albumID = @albumID;
END
GO

-- Delete a song from the Song table
CREATE PROCEDURE DeleteSong
    @songID INT
AS
BEGIN
    DELETE FROM Song
    WHERE songID = @songID;
END;

-- Delete a song from an album in the AlbumSongs table
CREATE PROCEDURE DeleteAlbumSong
    @albumID INT,
    @songID INT
AS
BEGIN
    DELETE FROM AlbumSongs
    WHERE albumID = @albumID AND songID = @songID;
END;

-- Delete a playlist from the Playlist table
CREATE PROCEDURE DeletePlaylist
    @playlistID INT
AS
BEGIN
    DELETE FROM Playlist
    WHERE playlistID = @playlistID;
END;

-- Delete a song from a playlist in the PlaylistSongs table
CREATE PROCEDURE DeletePlaylistSong
    @playlistID INT,
    @songID INT
AS
BEGIN
    DELETE FROM PlaylistSongs
    WHERE playlistID = @playlistID AND songID = @songID;
END;

-- Delete a listening history record from the UserListeningHistory table
CREATE PROCEDURE DeleteUserListeningHistory
    @username VARCHAR(50),
    @songID INT,
    @listeningDate DATETIME
AS
BEGIN
    DELETE FROM UserListeningHistory
    WHERE username = @username AND songID = @songID AND listeningDate = @listeningDate;
END;

-- Delete a user-artist follow relationship from the user_follows_artists table
CREATE PROCEDURE DeleteUserFollowsArtist
    @username VARCHAR(50),
    @artistID INT
AS
BEGIN
    DELETE FROM user_follows_artists
    WHERE username = @username AND artistID = @artistID;
END;
