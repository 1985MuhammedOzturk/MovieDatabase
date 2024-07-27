CREATE OR REPLACE TRIGGER scores_before_update
BEFORE UPDATE ON Scores
FOR EACH ROW
BEGIN
    IF :OLD.ScoreValue != :NEW.ScoreValue THEN
        INSERT INTO ScoresHistory (ScoreHistoryID, StartDate, EndDate, MovieID, ScoreID, OldScore, NewScore)
        VALUES (scorehistory_seq.NEXTVAL, SYSDATE, NULL, :OLD.MovieID, :OLD.ScoreID, :OLD.ScoreValue, :NEW.ScoreValue);
        
        -- Update EndDate for the oldest entry with NULL EndDate for the same MovieID
        UPDATE ScoresHistory
        SET EndDate = TRUNC(SYSDATE)
        WHERE ScoreHistoryID = (
            SELECT MIN(ScoreHistoryID)
            FROM ScoresHistory
            WHERE MovieID = :OLD.MovieID
            AND EndDate IS NULL
        );
    END IF;
END;
/

CREATE OR REPLACE TRIGGER scores_before_insert
BEFORE INSERT ON Scores
FOR EACH ROW
BEGIN
    INSERT INTO ScoresHistory (ScoreHistoryID, StartDate, EndDate, MovieID, ScoreID, OldScore, NewScore)
    VALUES (scorehistory_seq.NEXTVAL, SYSDATE, NULL, :NEW.MovieID, :NEW.ScoreID, NULL, :NEW.ScoreValue);
END;
/

DROP TRIGGER scores_before_update;
DROP TRIGGER scores_before_delete;




-- Update a score
UPDATE Scores SET ScoreValue = '22' WHERE MovieID = 69;
-- Query ScoresHistory table to check if updates and inserts are reflected correctly
SELECT * FROM ScoresHistory WHERE MovieID = 69;


-- Delete a score
DELETE FROM Scores WHERE MovieID = 12;

-- Check the ScoresHistory table
SELECT * FROM ScoresHistory;
SELECT * from scores;
