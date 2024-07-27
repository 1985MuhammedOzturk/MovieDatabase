CREATE OR REPLACE TRIGGER streaming_on_before_insert_trigger
BEFORE INSERT ON StreamingOn
FOR EACH ROW
BEGIN
    INSERT INTO StreamingOnHistory (StreamingOnHistoryID, NewPlatform, OldPlatform, StartDate, EndDate, MovieID, StreamingOnID)
    VALUES (streamingonhistory_seq.NEXTVAL, :NEW.PlatformID, NULL, SYSDATE, NULL, :NEW.MovieID, :NEW.StreamingOnID);
END;
/

CREATE OR REPLACE TRIGGER streaming_on_before_update_trigger
BEFORE UPDATE ON StreamingOn
FOR EACH ROW
BEGIN
    IF :OLD.PlatformID != :NEW.PlatformID THEN
        -- Update the previous record in StreamingOnHistory with the new end date
        UPDATE StreamingOnHistory
        SET EndDate = SYSDATE
        WHERE StreamingOnID = :OLD.StreamingOnID
        AND EndDate IS NULL;

        -- Insert a new record into StreamingOnHistory with the new platform
        INSERT INTO StreamingOnHistory (StreamingOnHistoryID, NewPlatform, OldPlatform, StartDate, EndDate, MovieID, StreamingOnID)
        VALUES (streamingonhistory_seq.NEXTVAL, :NEW.PlatformID, :OLD.PlatformID, SYSDATE, NULL, :NEW.MovieID, :NEW.StreamingOnID);
    END IF;
END;
/



-- Inserting a new record into the StreamingOn table
INSERT INTO StreamingOn (MovieID, PlatformID) 
VALUES (1, 1);  -- Adjust the values as needed

-- Check the StreamingOnHistory table to see if the new record is inserted
SELECT * FROM StreamingOnHistory;

-- Update an existing record in the StreamingOn table to change the platform
UPDATE StreamingOn 
SET PlatformID = 2  -- Change the platform ID as needed
WHERE StreamingOnID = 10;  -- Specify the StreamingOnID of the record you want to update

-- Check the StreamingOnHistory table to see if the update is reflected
SELECT * FROM StreamingOnHistory;

select * from soundtrack;
select * from soundtrackhistory;
