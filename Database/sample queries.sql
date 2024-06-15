-- Total Number of Songs in Each Genre
SELECT genreName, COUNT(*) AS total_songs
FROM Song
GROUP BY genreName;

--  Number of Songs in Each Album
SELECT a.name AS album_name, COUNT(*) AS total_songs
FROM Song s
JOIN Album a ON s.albumID = a.albumID
GROUP BY a.name,s.albumID;

-- Total Number of Albums by Each Artist
SELECT ar.name AS artist_name, COUNT(*) AS total_albums
FROM Album al
JOIN Artist ar ON al.artistID = ar.artistID
GROUP BY ar.name;

-- Total Number of Songs in Each Playlist
SELECT p.name AS name, COUNT(*) AS total_songs
FROM Playlist p
JOIN PlaylistSongs ps ON p.playlistID = ps.playlistID
GROUP BY p.name;

-- Total Number of Playlists Created by Each User
SELECT p.username, COUNT(*) AS total_playlists
FROM Playlist p
GROUP BY p.username;


-- Most Popular Genre Based on Number of Songs
SELECT genreName, COUNT(*) AS total_songs
FROM Song
GROUP BY genreName
ORDER BY total_songs DESC;

-- Number of Artists in Each Genre
SELECT g.genreName, COUNT(DISTINCT ar.artistID) AS total_artists
FROM Genre g
JOIN Song s ON g.genreName = s.genreName
JOIN Artist ar ON s.artistID = ar.artistID
GROUP BY g.genreName;
