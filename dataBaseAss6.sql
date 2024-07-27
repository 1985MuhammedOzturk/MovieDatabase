
INSERT INTO Directors (DirectorName)
SELECT 'Sam Raimi' FROM DUAL UNION ALL
SELECT 'Chris Miller' FROM DUAL UNION ALL
SELECT 'Michael Bay' FROM DUAL UNION ALL
SELECT 'Gore Verbinski' FROM DUAL UNION ALL
SELECT 'David Yates' FROM DUAL UNION ALL
SELECT 'Francis Lawrence' FROM DUAL UNION ALL
SELECT 'Paul Greengrass' FROM DUAL UNION ALL
SELECT 'Jon Turteltaub' FROM DUAL UNION ALL
SELECT 'Tim Hill' FROM DUAL UNION ALL
SELECT 'Zack Snyder' FROM DUAL;

INSERT INTO Genres (GenreName)
SELECT 'Action' FROM DUAL UNION ALL
SELECT 'Animation' FROM DUAL UNION ALL
SELECT 'Adventure' FROM DUAL UNION ALL
SELECT 'Thriller' FROM DUAL UNION ALL
SELECT 'Comedy' FROM DUAL UNION ALL
SELECT 'Musical' FROM DUAL UNION ALL
SELECT 'Drama' FROM DUAL UNION ALL
SELECT 'Biography' FROM DUAL UNION ALL
SELECT 'Horror' FROM DUAL UNION ALL
SELECT 'Romance' FROM DUAL UNION ALL
SELECT 'Crime' FROM DUAL UNION ALL
SELECT 'Mystery' FROM DUAL UNION ALL
SELECT 'Fantasy' FROM DUAL;


INSERT INTO Actors (ActorName)
SELECT 'Tobey Maguire' FROM DUAL UNION ALL
SELECT 'Mike Myers' FROM DUAL UNION ALL
SELECT 'Shia LaBeouf' FROM DUAL UNION ALL
SELECT 'Johnny Depp' FROM DUAL UNION ALL
SELECT 'Daniel Radcliffe' FROM DUAL UNION ALL
SELECT 'Will Smith' FROM DUAL UNION ALL
SELECT 'Matt Damon' FROM DUAL UNION ALL
SELECT 'Nicolas Cage' FROM DUAL UNION ALL
SELECT 'Jason Lee' FROM DUAL UNION ALL
SELECT 'Gerard Butler' FROM DUAL;




INSERT INTO Songs (SongName)
SELECT 'Spider Dance' FROM DUAL UNION ALL
SELECT 'Fionas Dream' FROM DUAL UNION ALL
SELECT 'Autobots Assemble' FROM DUAL UNION ALL 
SELECT 'Hes a Pirate' FROM DUAL UNION ALL
SELECT 'Phoenix Rising' FROM DUAL UNION ALL
SELECT 'The Last Man on Earth' FROM DUAL UNION ALL
SELECT 'Ultimatum' FROM DUAL UNION ALL
SELECT 'Secrets Unveiled' FROM DUAL UNION ALL
SELECT 'Chipmunks Song' FROM DUAL UNION ALL
SELECT 'Battle of Thermopylae' FROM DUAL;


-- Inserting into Platforms
INSERT INTO Platforms (PlatformName)
SELECT 'Netflix' FROM DUAL UNION ALL
SELECT 'Amazon Prime Video' FROM DUAL UNION ALL
SELECT 'Hulu' FROM DUAL UNION ALL
SELECT 'Disney+' FROM DUAL UNION ALL
SELECT 'HBO Max' FROM DUAL UNION ALL
SELECT 'Apple TV+' FROM DUAL;

-- Inserting into StreamingOn
INSERT INTO StreamingOn (MovieID )
SELECT 1 FROM DUAL UNION ALL
SELECT 1 FROM DUAL UNION ALL
SELECT 1 FROM DUAL UNION ALL
SELECT 2 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL UNION ALL
SELECT 3 FROM DUAL;

-- Inserting into Scores
INSERT INTO Scores (MovieID, ScoreValue)
SELECT 1, '90' FROM DUAL UNION ALL
SELECT 2, '91' FROM DUAL UNION ALL
SELECT 3, '92' FROM DUAL UNION ALL
SELECT 4, '93' FROM DUAL UNION ALL
SELECT 5, '94' FROM DUAL UNION ALL
SELECT 6, '95' FROM DUAL UNION ALL
SELECT 7, '96' FROM DUAL UNION ALL
SELECT 8, '97' FROM DUAL UNION ALL
SELECT 9, '98' FROM DUAL UNION ALL
SELECT 10, '99' FROM DUAL;


select * from StreamingOnHistory;

DECLARE
    v_start_date DATE := TRUNC(SYSDATE);
    v_current_platform_name VARCHAR2(100);
BEGIN
    FOR streaming_history_rec IN (
        SELECT 
            1 AS current_platform_id, 1 AS movie_id, 1 AS streaming_on_id FROM DUAL UNION ALL
        SELECT 2, 2, 2 FROM DUAL UNION ALL
        SELECT 3, 3, 3 FROM DUAL UNION ALL
        SELECT 4, 4, 4 FROM DUAL UNION ALL
        SELECT 5, 5, 5 FROM DUAL UNION ALL
        SELECT 6, 6, 6 FROM DUAL UNION ALL
        SELECT 6, 7, 6 FROM DUAL UNION ALL
        SELECT 5, 8, 5 FROM DUAL UNION ALL
        SELECT 4, 9, 4 FROM DUAL UNION ALL
        SELECT 3, 10, 3 FROM DUAL
        -- Add more rows as needed
    ) LOOP
        -- Retrieve the name of the current platform
        SELECT PlatformName INTO v_current_platform_name
        FROM Platforms
        WHERE PlatformID = streaming_history_rec.current_platform_id;

        -- Insert into StreamingOnHistory with the current platform name and NULL for the new platform name
        INSERT INTO StreamingOnHistory (StreamingOnHistoryID, NewPlatform, OldPlatform, StartDate, EndDate, MovieID, StreamingOnID)
        VALUES (streamingonhistory_seq.NEXTVAL, NULL, v_current_platform_name, v_start_date, NULL, streaming_history_rec.movie_id, streaming_history_rec.streaming_on_id);
    END LOOP;
END;
/

select * from streamingonhistory

DECLARE
    v_movie_id NUMBER;
BEGIN
    FOR movie_rec IN (
        SELECT 'Spider-Man 3' AS title, 2007 AS release_year, 2 AS genre_id, 1 AS director_id, 1 AS actor_id, 1 AS score_history_id, 1 AS soundtrack_history_id FROM DUAL UNION ALL
        SELECT 'Shrek the Third', 2007, 2, 2, 2, 2, 2 FROM DUAL UNION ALL
        SELECT 'Transformers', 2007, 1, 3, 3, 3, 3 FROM DUAL UNION ALL
        SELECT 'Pirates of the Caribbean: At World''s End', 2007, 1, 4, 4, 4, 4 FROM DUAL UNION ALL
        SELECT 'Harry Potter and the Order of the Phoenix', 2007, 3, 5, 5, 5, 5 FROM DUAL UNION ALL
        SELECT 'I Am Legend', 2007, 4, 6, 6, 6, 6 FROM DUAL UNION ALL
        SELECT 'The Bourne Ultimatum', 2007, 4, 7, 7, 7, 7 FROM DUAL UNION ALL
        SELECT 'National Treasure: Book of Secrets', 2007, 4, 8, 8, 8, 8 FROM DUAL UNION ALL
        SELECT 'Alvin and the Chipmunks', 2007, 2, 9, 9, 9, 9 FROM DUAL UNION ALL
        SELECT '300', 2007, 4, 10, 10, 10, 10 FROM DUAL
        -- Add more rows as needed
    ) LOOP
        v_movie_id := movie_seq.NEXTVAL;
        INSERT INTO Movies (MovieID, Title, ReleaseYear, GenreID, DirectorID, ActorID, ScoreHistoryID, SoundtrackHistoryID)
        VALUES (v_movie_id, movie_rec.title, movie_rec.release_year, movie_rec.genre_id, movie_rec.director_id, movie_rec.actor_id, movie_rec.score_history_id, movie_rec.soundtrack_history_id);
    END LOOP;
END;
/


DECLARE
    v_song_id NUMBER;
BEGIN
    FOR soundtrack_rec IN (
        SELECT 1 AS song_id, 1 AS movie_id, 'Dancing Spiders' AS soundtrack_name FROM DUAL UNION ALL
        SELECT 3, 1, 'Rise of Autobots' FROM DUAL UNION ALL
        SELECT 5, 1, 'Phoenixs Flight' FROM DUAL UNION ALL
        SELECT 7, 1, 'Ultimate Showdown' FROM DUAL UNION ALL
        SELECT 9, 1, 'Chipmunk Jam' FROM DUAL UNION ALL
        SELECT 2, 2, 'Fionas Lullaby' FROM DUAL UNION ALL
        SELECT 4, 2, 'Pirates Tale' FROM DUAL UNION ALL
        SELECT 6, 2, 'Last Stand' FROM DUAL UNION ALL
        SELECT 8, 2, 'Revelation' FROM DUAL UNION ALL
        SELECT 1, 3, 'Spartan Rhythms' FROM DUAL UNION ALL
        SELECT 3, 3, 'Autobot Anthem' FROM DUAL UNION ALL
        SELECT 5, 3, 'Wizards Waltz' FROM DUAL UNION ALL
        SELECT 10, 3, 'Battle Hymn' FROM DUAL
    ) LOOP
        INSERT INTO Soundtrack (SongID, MovieID, SoundtrackName)
        VALUES (soundtrack_rec.song_id, soundtrack_rec.movie_id, soundtrack_rec.soundtrack_name);
    END LOOP;
END;
/


DECLARE
    v_start_date DATE := TRUNC(SYSDATE);
    v_current_soundtrack VARCHAR2(100); 
BEGIN
    FOR soundtrack_history_rec IN (
        SELECT 
            1 AS movie_id, 1 AS soundtrack_id, 'Dancing Spiders' AS soundtrack_name FROM DUAL UNION ALL
        SELECT 3, 2, 'Rise of Autobots' FROM DUAL UNION ALL
        SELECT 5, 3, 'Phoenixs Flight' FROM DUAL UNION ALL
        SELECT 7, 4, 'Ultimate Showdown' FROM DUAL UNION ALL
        SELECT 9, 5, 'Chipmunk Jam' FROM DUAL UNION ALL
        SELECT 2, 6, 'Fionas Lullaby' FROM DUAL UNION ALL
        SELECT 4, 7, 'Pirates Tale' FROM DUAL UNION ALL
        SELECT 6, 8, 'Last Stand' FROM DUAL UNION ALL
        SELECT 8, 9, 'Revelation' FROM DUAL UNION ALL
        SELECT 1, 10, 'Spartan Rhythms' FROM DUAL UNION ALL
        SELECT 3, 11, 'Autobot Anthem' FROM DUAL UNION ALL
        SELECT 5, 12, 'Wizards Waltz' FROM DUAL UNION ALL
        SELECT 10, 13, 'Battle Hymn' FROM DUAL
    ) LOOP
        SELECT SoundtrackName INTO v_current_soundtrack
        FROM Soundtrack
        WHERE SoundtrackID = soundtrack_history_rec.soundtrack_id;

        INSERT INTO SoundtrackHistory (StartDate, EndDate, MovieID, SoundtrackID, CurrentSoundtrack, OldSountrack)
        VALUES (v_start_date, NULL, soundtrack_history_rec.movie_id, soundtrack_history_rec.soundtrack_id, v_current_soundtrack, NULL);
    END LOOP;
END;
/


select * from streamingonhistory

DECLARE
    v_start_date DATE := TRUNC(SYSDATE);
    v_current_platform_name VARCHAR2(100);
BEGIN
    FOR streaming_history_rec IN (
        SELECT 
            1 AS current_platform_id, 1 AS movie_id, 1 AS streaming_on_id FROM DUAL UNION ALL
        SELECT 2, 2, 2 FROM DUAL UNION ALL
        SELECT 3, 3, 3 FROM DUAL UNION ALL
        SELECT 4, 4, 4 FROM DUAL UNION ALL
        SELECT 5, 5, 5 FROM DUAL UNION ALL
        SELECT 6, 6, 6 FROM DUAL UNION ALL
        SELECT 6, 7, 6 FROM DUAL UNION ALL
        SELECT 5, 8, 5 FROM DUAL UNION ALL
        SELECT 4, 9, 4 FROM DUAL UNION ALL
        SELECT 3, 10, 3 FROM DUAL
        -- Add more rows as needed
    ) LOOP
        -- Retrieve the name of the current platform
        SELECT PlatformName INTO v_current_platform_name
        FROM Platforms
        WHERE PlatformID = streaming_history_rec.current_platform_id;

        -- Insert into StreamingOnHistory with the current platform name and NULL for the new platform name
        INSERT INTO StreamingOnHistory (StreamingOnHistoryID, CurrentPlatform, NewPlatform, StartDate, EndDate, MovieID, StreamingOnID)
        VALUES (streamingonhistory_seq.NEXTVAL, v_current_platform_name, NULL, v_start_date, NULL, streaming_history_rec.movie_id, streaming_history_rec.streaming_on_id);
    END LOOP;
END;
/

DECLARE
    v_start_date DATE := TRUNC(SYSDATE);
BEGIN
    FOR score_history_rec IN (
        SELECT 1 AS movie_id, 1 AS score_id, 90 AS new_score FROM DUAL UNION ALL
        SELECT 2, 2, 91 FROM DUAL UNION ALL
        SELECT 3, 3, 92 FROM DUAL UNION ALL
        SELECT 4, 4, 93 FROM DUAL UNION ALL
        SELECT 5, 5, 94 FROM DUAL UNION ALL
        SELECT 6, 6, 95 FROM DUAL UNION ALL
        SELECT 7, 7, 96 FROM DUAL UNION ALL
        SELECT 8, 8, 97 FROM DUAL UNION ALL
        SELECT 9, 9, 98 FROM DUAL UNION ALL
        SELECT 10, 10, 99 FROM DUAL
        -- Add more rows as needed
    ) LOOP
        INSERT INTO ScoresHistory (ScoreHistoryID, StartDate, EndDate, MovieID, ScoreID, OldScore, NewScore)
        VALUES (scorehistory_seq.NEXTVAL, v_start_date, NULL, score_history_rec.movie_id, score_history_rec.score_id, NULL, score_history_rec.new_score);
    END LOOP;
END;
/


DROP TABLE ACTORS;
DROP TABLE DIRECTORS;
DROP TABLE GENRES;
DROP TABLE MOVIES;
DROP TABLE PLATFORMS;
DROP TABLE SCORES;
DROP TABLE SCORESHISTORY;
DROP TABLE SONGS;
DROP TABLE SOUNDTRACK;
DROP TABLE SOUNDTRACKHISTORY;
DROP TABLE STREAMINGON;
DROP TABLE STREAMINGONHISTORY;



-- Drop sequences if they exist
DECLARE
    v_seq_name VARCHAR2(100);
BEGIN
    FOR i IN (SELECT sequence_name FROM user_sequences) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || i.sequence_name;
    END LOOP;
END;
/

-- Create sequences starting from 1


DROP SEQUENCE genre_seq;
DROP SEQUENCE director_seq;
DROP SEQUENCE actor_seq;
DROP SEQUENCE score_seq;
DROP SEQUENCE scorehistory_seq;
DROP SEQUENCE platform_seq;
DROP SEQUENCE streamingon_seq;
DROP SEQUENCE streamingonhistory_seq;
DROP SEQUENCE song_seq;
DROP SEQUENCE soundtrack_seq;
DROP SEQUENCE soundtrackhistory_seq;
DROP SEQUENCE movie_seq;


CREATE SEQUENCE genre_seq START WITH 1;
CREATE SEQUENCE director_seq START WITH 1;
CREATE SEQUENCE actor_seq START WITH 1;
CREATE SEQUENCE score_seq START WITH 1;
CREATE SEQUENCE scorehistory_seq START WITH 1;
CREATE SEQUENCE platform_seq START WITH 1;
CREATE SEQUENCE streamingonhistory_seq START WITH 1;
CREATE SEQUENCE song_seq START WITH 1;
CREATE SEQUENCE soundtrack_seq START WITH 1;
CREATE SEQUENCE soundtrackhistory_seq START WITH 1;
CREATE SEQUENCE movie_seq START WITH 1;
CREATE SEQUENCE streamingon_seq START WITH 1;

-- Create tables with primary keys using the sequences as defaults
CREATE TABLE Genres (
    GenreID NUMBER DEFAULT genre_seq.NEXTVAL PRIMARY KEY,
    GenreName VARCHAR2(30)
);

CREATE TABLE Directors (
    DirectorID NUMBER DEFAULT director_seq.NEXTVAL PRIMARY KEY,
    DirectorName VARCHAR2(30)
);

CREATE TABLE Actors (
    ActorID NUMBER DEFAULT actor_seq.NEXTVAL PRIMARY KEY,
    ActorName VARCHAR2(30)
);

CREATE TABLE Scores (
    ScoreID NUMBER DEFAULT score_seq.NEXTVAL PRIMARY KEY,
    MovieID NUMBER,
    ScoreValue VARCHAR2(30)
);

CREATE TABLE ScoresHistory(
    ScoreHistoryID NUMBER DEFAULT scorehistory_seq.NEXTVAL PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    MovieID NUMBER,
    ScoreID NUMBER,
    OldScore NUMBER,
    NewScore NUMBER
);

CREATE TABLE Platforms (
    PlatformID NUMBER DEFAULT platform_seq.NEXTVAL PRIMARY KEY,
    PlatformName VARCHAR2(30)
);

CREATE TABLE StreamingOn (
    StreamingOnID NUMBER DEFAULT streamingonhistory_seq.NEXTVAL,
    MovieID NUMBER,
    PlatformID NUMBER
);

CREATE TABLE StreamingOnHistory(
    StreamingOnHistoryID NUMBER DEFAULT streamingonhistory_seq.NEXTVAL PRIMARY KEY,
    NewPlatform VARCHAR(30),
    OldPlatform VARCHAR(30),
    StartDate DATE,
    EndDate DATE,
    MovieID NUMBER,
    StreamingOnID NUMBER
);




CREATE TABLE Songs (
    SongID NUMBER DEFAULT song_seq.NEXTVAL PRIMARY KEY,
    SongName VARCHAR2(30)
);

CREATE TABLE Soundtrack(
    SoundTrackID NUMBER DEFAULT soundtrack_seq.NEXTVAL PRIMARY KEY,
    SongID NUMBER,
    MovieID NUMBER,
    SoundTrackName VARCHAR(50)
);

CREATE TABLE SoundtrackHistory(
    SoundtrackHistoryID NUMBER DEFAULT soundtrackhistory_seq.NEXTVAL PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    MovieID NUMBER,
    SoundtrackID NUMBER,
    CurrentSoundtrack VARCHAR(50),
    OldSountrack VARCHAR(50)
);


CREATE TABLE Movies(
    MovieID NUMBER DEFAULT movie_seq.NEXTVAL PRIMARY KEY,
    Title VARCHAR(60),
    ReleaseYear NUMBER,
    GenreID NUMBER,
    DirectorID NUMBER,
    ActorID NUMBER,
    ScoreHistoryID NUMBER,
    StreamingOnHistoryID NUMBER,
    SoundtrackHistoryID NUMBER
);
