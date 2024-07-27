CREATE OR REPLACE TRIGGER streamingon_before_update
BEFORE UPDATE ON StreamingOn
FOR EACH ROW
BEGIN
    IF :OLD.PlatformID != :NEW.PlatformID THEN
        INSERT INTO StreamingOnHistory (StreamingOnHistoryID, StartDate, EndDate, MovieID, StreamingOnID, NewPlatform, OldPlatform)
        VALUES (streamingonhistory_seq.NEXTVAL, SYSDATE, NULL, :NEW.MovieID, :NEW.StreamingOnID, :NEW.PlatformID, :OLD.PlatformID);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER streaming_on_before_insert
BEFORE INSERT ON StreamingOn
FOR EACH ROW
BEGIN
    -- Insert into StreamingOnHistory
    INSERT INTO StreamingOnHistory (StreamingOnHistoryID, NewPlatform, OldPlatform, StartDate, EndDate, MovieID, StreamingOnID)
    VALUES (streamingonhistory_seq.NEXTVAL, :NEW.PlatformID, NULL, SYSDATE, NULL, :NEW.MovieID, :NEW.StreamingOnID);
END;
/



INSERT INTO StreamingOn (MovieID, PlatformID)
VALUES ( 1, 6); -- Assuming MovieID = 1 and PlatformID = 1


UPDATE StreamingOn
SET PlatformID = 2
WHERE MovieID = 1; -- Assuming MovieID = 1 is being updated to PlatformID = 2


select * from platforms
select * from streamingon;
select * from streamingonhistory;



CREATE OR REPLACE TRIGGER streamingon_before_update
BEFORE UPDATE ON StreamingOn
FOR EACH ROW
BEGIN
    IF :OLD.PlatformID != :NEW.PlatformID THEN
        INSERT INTO StreamingOnHistory (StreamingOnHistoryID, StartDate, EndDate, MovieID, StreamingOnID, NewPlatform, OldPlatform)
        VALUES (streamingonhistory_seq.NEXTVAL, SYSDATE, NULL, :NEW.MovieID, :NEW.StreamingOnID, :NEW.PlatformID, :OLD.PlatformID);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER streaming_on_before_insert
BEFORE INSERT ON StreamingOn
FOR EACH ROW
BEGIN
    -- Insert into StreamingOnHistory
    INSERT INTO StreamingOnHistory (StreamingOnHistoryID, NewPlatform, OldPlatform, StartDate, EndDate, MovieID, StreamingOnID)
    VALUES (streamingonhistory_seq.NEXTVAL, :NEW.PlatformID, NULL, SYSDATE, NULL, :NEW.MovieID, :NEW.StreamingOnID);
END;
/



INSERT INTO StreamingOn (MovieID, PlatformID)
VALUES ( 1, 6); -- Assuming MovieID = 1 and PlatformID = 1


UPDATE StreamingOn
SET PlatformID = 2
WHERE MovieID = 1; -- Assuming MovieID = 1 is being updated to PlatformID = 2


select * from platforms
select * from streamingon;
select * from streamingonhistory;




