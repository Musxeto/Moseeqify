create PROCEDURE delete_from_user
    @username varchar(50)
AS
BEGIN
    delete from [User]
    where username=@username;
END
GO
create PROCEDURE delete_from_Artist
    @ArtistID int
AS
BEGIN
    delete from Artist
    where artistID=@ArtistID;
END
GO
create PROCEDURE delete_from_Genre
    @genreName VARCHAR(50)
AS
BEGIN
    delete from Genre
    where genreName=@genreName;
END
GO
create PROCEDURE delete_from_album
    @albumID INT
AS
BEGIN
    delete from Album
    where albumID=@albumID;
END
GO
CREATE PROCEDURE DeleteSong
    @songID INT
AS
BEGIN
    DELETE FROM Song
    WHERE songID = @songID;
END;
CREATE PROCEDURE DeleteAlbumSong
    @albumID INT,
    @songID INT
AS
BEGIN
    DELETE FROM AlbumSongs
    WHERE albumID = @albumID AND songID = @songID;
END;
CREATE PROCEDURE DeletePlaylist
    @playlistID INT
AS
BEGIN
    DELETE FROM Playlist
    WHERE playlistID = @playlistID;
END;

CREATE PROCEDURE DeletePlaylistSong
    @playlistID INT,
    @songID INT
AS
BEGIN
    DELETE FROM PlaylistSongs
    WHERE playlistID = @playlistID AND songID = @songID;
END;

CREATE PROCEDURE DeleteUserListeningHistory
    @username VARCHAR(50),
    @songID INT,
    @listeningDate DATETIME
AS
BEGIN
    DELETE FROM UserListeningHistory
    WHERE username = @username AND songID = @songID AND listeningDate = @listeningDate;
END;

CREATE PROCEDURE DeleteUserFollowsArtist
    @username VARCHAR(50),
    @artistID INT
AS
BEGIN
    DELETE FROM user_follows_artists
    WHERE username = @username AND artistID = @artistID;
END;
