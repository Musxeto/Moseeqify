INSERT INTO [User] (username, email, name, password, dob)
VALUES 
    ('john_doe', 'john@example.com', 'John Doe', 'password', '1980-01-01'),
    ('jane_smith', 'jane@example.com', 'Jane Smith', 'password', '1990-05-15');

-- Insert artists
INSERT INTO Artist (artistID, name, bio, profilepiclink)
VALUES 
    (1, 'The Beatles', 'English rock band formed in Liverpool in 1960.', 'beatles.jpg'),
    (2, 'Michael Jackson', 'American singer, songwriter, and dancer.', 'michael_jackson.jpg'),
    (3, 'Queen', 'British rock band formed in London in 1970.', 'queen.jpg'),
    (4, 'Bob Marley', 'Jamaican singer-songwriter and musician.', 'bob_marley.jpg');

-- Insert genres
INSERT INTO Genre (genreName)
VALUES 
    ('Rock'),
    ('Pop'),
    ('Reggae');

-- Insert albums
INSERT INTO Album (albumID, name, artistID, releasedate, coverimagelink)
VALUES 
    (1, 'Abbey Road', 1, '1969-09-26', 'abbey_road.jpg'),
    (2, 'Thriller', 2, '1982-11-30', 'thriller.jpg'),
    (3, 'A Night at the Opera', 3, '1975-11-21', 'night_at_the_opera.jpg'),
    (4, 'Legend', 4, '1977-06-02', 'legend.jpg');
-- Insert songs for various albums
INSERT INTO Song (songID, title, artistID, albumID, genreName, duration, audiolink, releaseDate)
VALUES 
    (1, 'Come Together', 1, 1, 'Rock', '00:04:20', 'come_together.mp3', '1969-09-26'),
    (2, 'Something', 1, 1, 'Rock', '00:03:03', 'something.mp3', '1969-09-26'),
    (3, 'Maxwell''s Silver Hammer', 1, 1, 'Rock', '00:03:27', 'maxwells_silver_hammer.mp3', '1969-09-26'),
    (4, 'Oh! Darling', 1, 1, 'Rock', '00:03:26', 'oh_darling.mp3', '1969-09-26'),
    (5, 'Octopus''s Garden', 1, 1, 'Rock', '00:02:51', 'octopuss_garden.mp3', '1969-09-26'),
    (6, 'I Want You (She''s So Heavy)', 1, 1, 'Rock', '00:07:47', 'i_want_you.mp3', '1969-09-26'),

    (7, 'Wanna Be Startin'' Somethin''', 2, 2, 'Pop', '00:06:03', 'wanna_be_startin_somethin.mp3', '1982-11-30'),
    (8, 'Thriller', 2, 2, 'Pop', '00:05:58', 'thriller.mp3', '1982-11-30'),
    (9, 'Beat It', 2, 2, 'Pop', '00:04:18', 'beat_it.mp3', '1982-11-30'),

    (10, 'Bohemian Rhapsody', 3, 3, 'Rock', '00:05:55', 'bohemian_rhapsody.mp3', '1975-11-21'),
    (11, 'Love of My Life', 3, 3, 'Rock', '00:03:39', 'love_of_my_life.mp3', '1975-11-21'),
    (12, 'You''re My Best Friend', 3, 3, 'Rock', '00:02:52', 'youre_my_best_friend.mp3', '1975-11-21'),

    (13, 'Is This Love', 4, 4, 'Reggae', '00:03:52', 'is_this_love.mp3', '1977-06-02'),
    (14, 'No Woman, No Cry', 4, 4, 'Reggae', '00:07:07', 'no_woman_no_cry.mp3', '1977-06-02'),
    (15, 'Buffalo Soldier', 4, 4, 'Reggae', '00:04:17', 'buffalo_soldier.mp3', '1977-06-02');
