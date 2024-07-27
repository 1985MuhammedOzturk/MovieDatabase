CREATE OR REPLACE VIEW MovieScoresView AS
SELECT m.MovieID, m.Title, s.ScoreValue, sh.StartDate, sh.EndDate, sh.OldScore, sh.NewScore
FROM Movies m
JOIN Scores s ON m.MovieID = s.MovieID
JOIN ScoresHistory sh ON s.ScoreID = sh.ScoreID;


CREATE OR REPLACE VIEW MovieSoundtrackView AS
SELECT 
  m.Title,
  m.MovieID,
  st.SoundTrackName,
  sth.StartDate,
  sth.EndDate,
  sth.OldSoundtrack,
  sth.CurrentSoundtrack
FROM 
  Movies m
JOIN 
  Soundtrack st ON m.MovieID = st.MovieID
LEFT JOIN 
  SoundtrackHistory sth ON st.SoundtrackID = sth.SoundtrackID
ORDER BY 
  m.MovieID, 
  sth.StartDate DESC;

