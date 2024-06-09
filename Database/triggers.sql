use moseeqify;
/*trigger that displays the message after insert the new record */

CREATE TRIGGER trgAfterInsertUser ON [User]
AFTER INSERT
AS
BEGIN
    DECLARE @username VARCHAR(50), @name VARCHAR(100), @email VARCHAR(100),@password VARCHAR(100), @dob DATE, @dateJoined DATETIME;

    SELECT @username = INSERTED.username, @name = INSERTED.name, @dob = INSERTED.dob, 
           @dateJoined = INSERTED.dateJoined, @email = INSERTED.email,@password = INSERTED.password
    FROM INSERTED;

    PRINT 'New user inserted: Username = ' + @username + ', Name = ' + @name + ', Email = ' + @email + ', password = '+@password +', Date of Birth = ' + CONVERT(VARCHAR, @dob, 120) + ', Date Joined = ' + CONVERT(VARCHAR, @dateJoined, 120);
END;
drop trigger trgAfterInsertUser
/*trigger that displays the message after update the existing record*/

CREATE TRIGGER trgAfterUpdateUser ON [User]
AFTER UPDATE
AS
BEGIN
    DECLARE @username VARCHAR(50), @oldEmail VARCHAR(100), @newEmail VARCHAR(100), @oldName VARCHAR(100), @newName VARCHAR(100), @oldDob DATE, @newDob DATE, @oldDateJoined DATETIME, @newDateJoined DATETIME;

    SELECT @username = INSERTED.username, 
           @newEmail = INSERTED.email, @oldEmail = DELETED.email,
           @newName = INSERTED.name, @oldName = DELETED.name,
           @newDob = INSERTED.dob, @oldDob = DELETED.dob,
           @newDateJoined = INSERTED.dateJoined, @oldDateJoined = DELETED.dateJoined
    FROM INSERTED
    INNER JOIN DELETED ON INSERTED.username = DELETED.username;

    PRINT 'the record of ' + @username +' is updated'+ 
          ', Old Email = ' + @oldEmail + ', New Email = ' + @newEmail +
          ', Old Name = ' + @oldName + ', New Name = ' + @newName +
          ', Old Date of Birth = ' + CONVERT(VARCHAR, @oldDob, 120) + ', New Date of Birth = ' + CONVERT(VARCHAR, @newDob, 120) +
          ', Old Date Joined = ' + CONVERT(VARCHAR, @oldDateJoined, 120) + ', New Date Joined = ' + CONVERT(VARCHAR, @newDateJoined, 120);
END;
/*delete trigger*/
CREATE TRIGGER trgAfterDeleteUser ON [User]
AFTER DELETE
AS
BEGIN
    PRINT 'A user record has been deleted.';
END;

/*trigger that displays the message after insert he record in the artist*/

CREATE TRIGGER trgAfterInsertArtist ON Artist
AFTER INSERT
AS
BEGIN
DECLARE @artistID INT, @name VARCHAR(100), @bio VARCHAR(MAX), @profilepiclink VARCHAR(255);
    SELECT @artistID = INSERTED.artistID, 
           @name = INSERTED.name, 
           @bio = INSERTED.bio, 
           @profilepiclink = INSERTED.profilepiclink
    FROM INSERTED;

    PRINT 'New artist inserted: ArtistID = ' + CAST(@artistID AS nVARCHAR(10)) + 
          ', Name = ' + @name + 
          ', Bio = ' + ISNULL(@bio, 'NULL') + 
          ', Profile Pic Link = ' + ISNULL(@profilepiclink, 'NULL');
END;

/*trigger that displays the message after updates the record in the artist*/

CREATE TRIGGER trgAfterUpdateArtist ON Artist
AFTER UPDATE
AS
BEGIN
    DECLARE @artistID INT, @oldName VARCHAR(100), @newName VARCHAR(100), @oldBio VARCHAR(MAX), @newBio VARCHAR(MAX), @oldProfilepiclink VARCHAR(255), @newProfilepiclink VARCHAR(255);

    SELECT @artistID = INSERTED.artistID, 
           @newName = INSERTED.name, @oldName = DELETED.name,
           @newBio = INSERTED.bio, @oldBio = DELETED.bio,
           @newProfilepiclink = INSERTED.profilepiclink, @oldProfilepiclink = DELETED.profilepiclink
    FROM INSERTED
    INNER JOIN DELETED ON INSERTED.artistID = DELETED.artistID;

    PRINT 'Artist updated: ArtistID = ' + CAST(@artistID AS VARCHAR(10)) + 
          ', Old Name = ' + @oldName + ', New Name = ' + @newName +
          ', Old Bio = ' + ISNULL(@oldBio, 'NULL') + ', New Bio = ' + ISNULL(@newBio, 'NULL') +
          ', Old Profile Pic Link = ' + ISNULL(@oldProfilepiclink, 'NULL') + ', New Profile Pic Link = ' + ISNULL(@newProfilepiclink, 'NULL');
END;
/*delete trigger for Artists*/
CREATE TRIGGER trgAfterDeleteArtist ON Artist
AFTER DELETE
AS
BEGIN
    PRINT 'An artist record has been deleted.';
END;

/*trigger that displays the message after insert the record in the genre*/

CREATE TRIGGER trgAfterInsertGenre ON Genre
AFTER INSERT
AS
BEGIN
    DECLARE @genreName VARCHAR(50);

    SELECT @genreName = INSERTED.genreName
    FROM INSERTED;

    PRINT 'New genre inserted: Genre Name = ' + @genreName;
END;

/*trigger thatX displays the message after updates the record in the genre*/

CREATE TRIGGER trgAfterUpdateGenre ON Genre
AFTER UPDATE
AS
BEGIN
    DECLARE @oldGenreName VARCHAR(50), @newGenreName VARCHAR(50);

    SELECT @oldGenreName = DELETED.genreName, @newGenreName = INSERTED.genreName
    FROM INSERTED, DELETED;

    PRINT 'Genre updated: Old Genre Name = ' + @oldGenreName + ', New Genre Name = ' + @newGenreName;
END;
/* delete trigger for Genre*/

CREATE TRIGGER trgAfterDeleteGenre ON Genre
AFTER DELETE
AS
BEGIN
    PRINT 'A genre record has been deleted.';
END;

/*trigger that displays the message after insert the record in the album*/

CREATE TRIGGER trgAfterInsertAlbum ON Album
AFTER INSERT
AS
BEGIN
    DECLARE @albumID INT, @name VARCHAR(100), @artistID INT, @releasedate DATETIME, @coverimagelink VARCHAR(255);

    SELECT @albumID = INSERTED.albumID, 
           @name = INSERTED.name, 
           @artistID = INSERTED.artistID, 
           @releasedate = INSERTED.releasedate, 
           @coverimagelink = INSERTED.coverimagelink
    FROM INSERTED;

    PRINT 'New album inserted: AlbumID = ' + CAST(@albumID AS VARCHAR(10)) + 
          ', Name = ' + @name + 
          ', ArtistID = ' + CAST(@artistID AS VARCHAR(10)) + 
          ', Release Date = ' + ISNULL(CONVERT(VARCHAR, @releasedate, 120), 'NULL') + 
          ', Cover Image Link = ' + @coverimagelink;
END;

/*trigger that displays the message after UPDATES the record in the album*/

CREATE TRIGGER trgAfterUpdateAlbum ON Album
AFTER UPDATE
AS
BEGIN
    DECLARE @albumID INT, @oldName VARCHAR(100), @newName VARCHAR(100), @oldArtistID INT, @newArtistID INT, @oldReleaseDate DATETIME, @newReleaseDate DATETIME, @oldCoverImageLink VARCHAR(255), @newCoverImageLink VARCHAR(255);

    SELECT @albumID = INSERTED.albumID, 
           @newName = INSERTED.name, @oldName = DELETED.name,
           @newArtistID = INSERTED.artistID, @oldArtistID = DELETED.artistID,
           @newReleaseDate = INSERTED.releasedate, @oldReleaseDate = DELETED.releasedate,
           @newCoverImageLink = INSERTED.coverimagelink, @oldCoverImageLink = DELETED.coverimagelink
    FROM INSERTED
    INNER JOIN DELETED ON INSERTED.albumID = DELETED.albumID;

    PRINT 'Album updated: AlbumID = ' + CAST(@albumID AS VARCHAR(10)) + 
          ', Old Name = ' + @oldName + ', New Name = ' + @newName +
          ', Old ArtistID = ' + CAST(@oldArtistID AS VARCHAR(10)) + ', New ArtistID = ' + CAST(@newArtistID AS VARCHAR(10)) +
          ', Old Release Date = ' + ISNULL(CONVERT(VARCHAR, @oldReleaseDate, 120), 'NULL') + ', New Release Date = ' + ISNULL(CONVERT(VARCHAR, @newReleaseDate, 120), 'NULL') +
          ', Old Cover Image Link = ' + @oldCoverImageLink + ', New Cover Image Link = ' + @newCoverImageLink;
END;

/*delete trigger for album*/
CREATE TRIGGER trgAfterDeleteAlbum ON Album
AFTER DELETE
AS
BEGIN
    PRINT 'An album record has been deleted.';
END;

/*trigger that displays the message after inserts the record in the song*/

CREATE TRIGGER trgAfterInsertSong ON Song
AFTER INSERT
AS
BEGIN
    DECLARE @songID INT, @title VARCHAR(100), @artistID INT, @albumID INT, @genreName VARCHAR(50), @duration TIME, @audiolink VARCHAR(255), @releaseDate DATETIME;

    SELECT @songID = INSERTED.songID,
           @title = INSERTED.title,
           @artistID = INSERTED.artistID,
           @albumID = INSERTED.albumID,
           @genreName = INSERTED.genreName,
           @duration = INSERTED.duration,
           @audiolink = INSERTED.audiolink,
           @releaseDate = INSERTED.releaseDate
    FROM INSERTED;

    PRINT 'New song inserted: SongID = ' + CAST(@songID AS VARCHAR(10)) + 
          ', Title = ' + @title + 
          ', ArtistID = ' + CAST(@artistID AS VARCHAR(10)) + 
          ', AlbumID = ' + ISNULL(CAST(@albumID AS VARCHAR(10)), 'NULL') +
          ', Genre = ' + ISNULL(@genreName, 'NULL') +
          ', Duration = ' + CONVERT(VARCHAR, @duration, 120) +
          ', Audio Link = ' + @audiolink +
          ', Release Date = ' + CONVERT(VARCHAR, @releaseDate, 120);
END;

/*trigger that displays the message after updates the record in the song*/

CREATE TRIGGER trgAfterUpdateSong ON Song
AFTER UPDATE
AS
BEGIN
    DECLARE @songID INT, @oldTitle VARCHAR(100), @newTitle VARCHAR(100), @oldArtistID INT, @newArtistID INT, @oldAlbumID INT, @newAlbumID INT, @oldGenreName VARCHAR(50), @newGenreName VARCHAR(50), @oldDuration TIME, @newDuration TIME, @oldAudiolink VARCHAR(255), @newAudiolink VARCHAR(255), @oldReleaseDate DATETIME, @newReleaseDate DATETIME;

    SELECT @songID = INSERTED.songID,
           @newTitle = INSERTED.title, @oldTitle = DELETED.title,
           @newArtistID = INSERTED.artistID, @oldArtistID = DELETED.artistID,
           @newAlbumID = INSERTED.albumID, @oldAlbumID = DELETED.albumID,
           @newGenreName = INSERTED.genreName, @oldGenreName = DELETED.genreName,
           @newDuration = INSERTED.duration, @oldDuration = DELETED.duration,
           @newAudiolink = INSERTED.audiolink, @oldAudiolink = DELETED.audiolink,
           @newReleaseDate = INSERTED.releaseDate, @oldReleaseDate = DELETED.releaseDate
    FROM INSERTED,deleted
    -- INNER JOIN DELETED ON INSERTED.songID = DELETED.songID;

    PRINT 'Song updated: SongID = ' + CAST(@songID AS VARCHAR(10)) + 
          ', Old Title = ' + @oldTitle + ', New Title = ' + @newTitle +
          ', Old ArtistID = ' + CAST(@oldArtistID AS VARCHAR(10)) + ', New ArtistID = ' + CAST(@newArtistID AS VARCHAR(10)) +
          ', Old AlbumID = ' + ISNULL(CAST(@oldAlbumID AS VARCHAR(10)), 'NULL') + ', New AlbumID = ' + ISNULL(CAST(@newAlbumID AS VARCHAR(10)), 'NULL') +
          ', Old Genre = ' + ISNULL(@oldGenreName, 'NULL') + ', New Genre = ' + ISNULL(@newGenreName, 'NULL') +
          ', Old Duration = ' + CONVERT(VARCHAR, @oldDuration, 120) + ', New Duration = ' + CONVERT(VARCHAR, @newDuration, 120) +
          ', Old Audio Link = ' + @oldAudiolink + ', New Audio Link = ' + @newAudiolink +
          ', Old Release Date = ' + CONVERT(VARCHAR, @oldReleaseDate, 120) + ', New Release Date = ' + CONVERT(VARCHAR, @newReleaseDate, 120);
END;
/*delete trigger for songs*/
CREATE TRIGGER trgAfterDeleteSong ON Song
AFTER DELETE
AS
BEGIN
    PRINT 'A song record has been deleted.';
END;

/*trigger that displays the message after insert the record in the Albumsongs */

CREATE TRIGGER trgAfterInsertAlbumSongs ON AlbumSongs
AFTER INSERT
AS
BEGIN
    DECLARE @albumID INT, @songID INT;

    SELECT @albumID = albumID, @songID = songID
    FROM INSERTED;

    PRINT 'New AlbumSong inserted: AlbumID = ' + CAST(@albumID AS VARCHAR(10)) + 
          ', SongID = ' + CAST(@songID AS VARCHAR(10));
END;

/*trigger that displays the message after updates the record in the Albumsongs */

CREATE TRIGGER trgAfterUpdateAlbumSongs ON AlbumSongs
AFTER UPDATE
AS
BEGIN
    DECLARE @oldAlbumID INT, @newAlbumID INT, @oldSongID INT, @newSongID INT;

    SELECT @oldAlbumID = DELETED.albumID, @newAlbumID = INSERTED.albumID,
           @oldSongID = DELETED.songID, @newSongID = INSERTED.songID
    FROM INSERTED,DELETED

    PRINT 'AlbumSong updated: Old AlbumID = ' + CAST(@oldAlbumID AS VARCHAR(10)) + ', New AlbumID = ' + CAST(@newAlbumID AS VARCHAR(10)) +
          ', Old SongID = ' + CAST(@oldSongID AS VARCHAR(10)) + ', New SongID = ' + CAST(@newSongID AS VARCHAR(10));
END;
/*delete trigger for albumsongs*/
CREATE TRIGGER trgAfterDeleteAlbumSongs ON AlbumSongs
AFTER DELETE
AS
BEGIN
    PRINT 'An album-songs record has been deleted.';
END;


/*trigger that displays the message after inserts the record in the playlist */

CREATE TRIGGER trgAfterInsertPlaylist ON Playlist
AFTER INSERT
AS
BEGIN
    DECLARE @playlistID INT, @name VARCHAR(100), @creationdate DATETIME, @username VARCHAR(50);

    SELECT @playlistID = playlistID,
           @name = name,
           @creationdate = creationdate,
           @username = username
    FROM INSERTED;

    PRINT 'New Playlist inserted: PlaylistID = ' + CAST(@playlistID AS VARCHAR(10)) + 
          ', Name = ' + @name + 
          ', Creation Date = ' + CONVERT(VARCHAR, @creationdate, 120) +
          ', Username = ' + @username;
END;

/*trigger that displays the message after updates the record in the playlist */

CREATE TRIGGER trgAfterUpdatePlaylist ON Playlist
AFTER UPDATE
AS
BEGIN
    DECLARE @oldPlaylistID INT, @newPlaylistID INT, 
            @oldName VARCHAR(100), @newName VARCHAR(100), 
            @oldCreationdate DATETIME, @newCreationdate DATETIME, 
            @oldUsername VARCHAR(50), @newUsername VARCHAR(50);

    SELECT @oldPlaylistID = DELETED.playlistID, @newPlaylistID = INSERTED.playlistID,
           @oldName = DELETED.name, @newName = INSERTED.name,
           @oldCreationdate = DELETED.creationdate, @newCreationdate = INSERTED.creationdate,
           @oldUsername = DELETED.username, @newUsername = INSERTED.username
    FROM INSERTED,DELETED

    PRINT 'Playlist updated: Old PlaylistID = ' + CAST(@oldPlaylistID AS VARCHAR(10)) + ', New PlaylistID = ' + CAST(@newPlaylistID AS VARCHAR(10)) +
          ', Old Name = ' + @oldName + ', New Name = ' + @newName +
          ', Old Creation Date = ' + CONVERT(VARCHAR, @oldCreationdate, 120) + ', New Creation Date = ' + CONVERT(VARCHAR, @newCreationdate, 120) +
          ', Old Username = ' + @oldUsername + ', New Username = ' + @newUsername;
END;
/*delete trigger for playlist*/
CREATE TRIGGER trgAfterDeletePlaylist ON Playlist
AFTER DELETE
AS
BEGIN
    PRINT 'A playlist record has been deleted.';
END;

/*trigger that displays the message after inserts the record in the playlistsongs */

    CREATE TRIGGER trgAfterInsertPlaylistSongs ON PlaylistSongs
    AFTER INSERT
    AS
    BEGIN
        DECLARE @playlistID INT, @songID INT;

        SELECT @playlistID = playlistID, @songID = songID
        FROM INSERTED;

        PRINT 'New PlaylistSong inserted: PlaylistID = ' + CAST(@playlistID AS VARCHAR(10)) + 
            ', SongID = ' + CAST(@songID AS VARCHAR(10));
    END;

/*trigger that displays the message after updates the record in the playlistsongs */

CREATE TRIGGER trgAfterUpdatePlaylistSongs ON PlaylistSongs
AFTER UPDATE
AS
BEGIN
    DECLARE @oldPlaylistID INT, @newPlaylistID INT, @oldSongID INT, @newSongID INT;

    SELECT @oldPlaylistID = DELETED.playlistID, @newPlaylistID = INSERTED.playlistID,
           @oldSongID = DELETED.songID, @newSongID = INSERTED.songID
    FROM INSERTED,DELETED
    PRINT 'PlaylistSong updated: Old PlaylistID = ' + CAST(@oldPlaylistID AS VARCHAR(10)) + ', New PlaylistID = ' + CAST(@newPlaylistID AS VARCHAR(10)) +
          ', Old SongID = ' + CAST(@oldSongID AS VARCHAR(10)) + ', New SongID = ' + CAST(@newSongID AS VARCHAR(10));
END;
/*delete trigger for playlistsongs*/
CREATE TRIGGER trgAfterDeletePlaylistSongs ON PlaylistSongs
AFTER DELETE
AS
BEGIN
    PRINT 'A playlist-songs record has been deleted.';
END;


/*trigger that displays the message after insert the record in the userfloowsArtist */

CREATE TRIGGER trgAfterInsertUserFollowsArtists ON user_follows_artists
AFTER INSERT
AS
BEGIN
    DECLARE @username VARCHAR(50), @artistID INT;

    SELECT @username = username, @artistID = artistID
    FROM INSERTED;

    PRINT 'User ' + @username + ' started following Artist ' + CAST(@artistID AS VARCHAR(10));
END;

/*trigger that displays the message after insert the record in the userfloowsArtist */

CREATE TRIGGER trgAfterUpdateUserFollowsArtists ON user_follows_artists
AFTER UPDATE
AS
BEGIN
    DECLARE @username VARCHAR(50), @artistID INT;
    DECLARE @oldUsername VARCHAR(50), @oldArtistID INT;
    DECLARE @newUsername VARCHAR(50), @newArtistID INT;

    SELECT @oldUsername = DELETED.username, @oldArtistID = DELETED.artistID,
           @newUsername = INSERTED.username, @newArtistID = INSERTED.artistID
    FROM INSERTED,deleted
    PRINT 'User ' + @oldUsername + ' changed following status for Artist ' + CAST(@oldArtistID AS VARCHAR(10)) +
          ' to User ' + @newUsername + ' following status for Artist ' + CAST(@newArtistID AS VARCHAR(10));
END;
/*delte trigger for userfloowsArtists*/
CREATE TRIGGER trgAfterDeleteUserFollowsArtists ON user_follows_artists
AFTER DELETE
AS
BEGIN
    PRINT 'A user follows artists record has been deleted.';
END;
