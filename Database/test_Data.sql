-- Insert artists
INSERT INTO Artist (name, bio, profilepiclink)
VALUES 
    ('The Beatles', 'English rock band formed in Liverpool in 1960.', 'beatles.jpg'),
    ('Michael Jackson', 'American singer, songwriter, and dancer.', 'michael_jackson.jpg'),
    ('Queen', 'British rock band formed in London in 1970.', 'queen.jpg'),
    ('Bob Marley', 'Jamaican singer-songwriter and musician.', 'bob_marley.jpg');

-- Insert genres
INSERT INTO Genre (genreName)
VALUES 
    ('Rock'),
    ('Pop'),
    ('Reggae');

-- Insert albums
INSERT INTO Album (name, artistID, releasedate, coverimagelink)
VALUES 
    ('Abbey Road', 1, '1969-09-26', 'abbey_road.jpg'),
    ('Thriller', 2, '1982-11-30', 'thriller.jpg'),
    ('A Night at the Opera', 3, '1975-11-21', 'night_at_the_opera.jpg'),
    ('Legend', 4, '1977-06-02', 'legend.jpg');

-- Insert songs for various albums
INSERT INTO Song (title, artistID, albumID, genreName, duration, audiolink, releaseDate)
VALUES 
    ('Come Together', 1, 1, 'Rock', '00:04:20', 'come_together.mp3', '1969-09-26'),
    ('Something', 1, 1, 'Rock', '00:03:03', 'something.mp3', '1969-09-26'),
    ('Maxwell''s Silver Hammer', 1, 1, 'Rock', '00:03:27', 'maxwells_silver_hammer.mp3', '1969-09-26'),
    ('Oh! Darling', 1, 1, 'Rock', '00:03:26', 'oh_darling.mp3', '1969-09-26'),
    ('Octopus''s Garden', 1, 1, 'Rock', '00:02:51', 'octopuss_garden.mp3', '1969-09-26'),
    ('I Want You (She''s So Heavy)', 1, 1, 'Rock', '00:07:47', 'i_want_you.mp3', '1969-09-26'),

    ('Wanna Be Startin'' Somethin''', 2, 2, 'Pop', '00:06:03', 'wanna_be_startin_somethin.mp3', '1982-11-30'),
    ('Thriller', 2, 2, 'Pop', '00:05:58', 'thriller.mp3', '1982-11-30'),
    ('Beat It', 2, 2, 'Pop', '00:04:18', 'beat_it.mp3', '1982-11-30'),

    ('Bohemian Rhapsody', 3, 3, 'Rock', '00:05:55', 'bohemian_rhapsody.mp3', '1975-11-21'),
    ('Love of My Life', 3, 3, 'Rock', '00:03:39', 'love_of_my_life.mp3', '1975-11-21'),
    ('You''re My Best Friend', 3, 3, 'Rock', '00:02:52', 'youre_my_best_friend.mp3', '1975-11-21'),

    ('Is This Love', 4, 4, 'Reggae', '00:03:52', 'is_this_love.mp3', '1977-06-02'),
    ('No Woman, No Cry', 4, 4, 'Reggae', '00:07:07', 'no_woman_no_cry.mp3', '1977-06-02'),
    ('Buffalo Soldier', 4, 4, 'Reggae', '00:04:17', 'buffalo_soldier.mp3', '1977-06-02');






-- Insert artists
INSERT INTO Artist (name, bio, profilepiclink)
VALUES 
    ('Lil Mussi W', 'WE UP NIGGA.', 'MUSSI.jpg')

INSERT INTO Genre (genreName)
VALUES 
    ('Rap')


INSERT INTO Album (name, artistID, releasedate, coverimagelink)
VALUES 
    ('PAN DI PHUSSI', 1, '2023-04-30', 'PAN_DI_PHUSSI.jpg')


-- Insert songs for various albums
INSERT INTO Song (title, artistID, albumID, genreName, duration, audiolink, releaseDate)
VALUES 
    ('Default Mic', 1, 1, 'Rap', '00:01:29', 'https://firebasestorage.googleapis.com/v0/b/moseeqify.appspot.com/o/Mustafa%20G.M%20-%20default%20mic%20%5Bprod.%20HeyyLotus%5D%202023-04-29%2010_32.m4a?alt=media&token=1b4b8d49-56c0-4340-beae-e859f22c9e343', '2023-04-30')