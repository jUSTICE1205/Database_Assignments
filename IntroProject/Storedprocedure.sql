/*
 * Name : Clavan Dsouza
 * Course : DataBase 2
 * Date : 03/03/2024
 */

USE TRAIN_BOOKING_SYSTEM;
GO

/* 
 * Clavan Dsouza
 * March 3, 2024
 * Fixes the departures and arrival by swapping them.
 */
CREATE OR ALTER PROCEDURE usp_FixDepartureArrivalTimes
AS
BEGIN

	BEGIN TRANSACTION;

    BEGIN TRY
        DECLARE @UpdatedCount INT;

        -- Temporary table to store rows that need to be updated
		
		DROP TABLE IF EXISTS TempTrip;

        CREATE TABLE TempTrip (
            TripID INT,
            OriginalDeparture DATETIME,
            OriginalArrival DATETIME
        );

        -- Rows where departure is after arrival
        INSERT INTO TempTrip (TripID, OriginalDeparture, OriginalArrival)
        SELECT trip_id, depart_datetime, arrival_datetime
        FROM Trip
        WHERE depart_datetime > arrival_datetime;

        -- Update departure and arrival times
        UPDATE Trip
        SET depart_datetime = t.OriginalArrival,
            arrival_datetime = t.OriginalDeparture
        FROM Trip
        INNER JOIN TempTrip t ON Trip.trip_id = t.TripID;

        -- Output the results
        SELECT @UpdatedCount = COUNT(*) FROM TempTrip;

        IF @UpdatedCount > 0
        BEGIN
            PRINT CAST(@UpdatedCount AS NVARCHAR) + ' swaps performed between departure and arrival times.';
        END
        ELSE
        BEGIN
            PRINT 'No swaps performed between departure and arrival times.';
        END

        PRINT CAST(@UpdatedCount AS NVARCHAR) + ' Rows will be swapped/updated.';
		
		COMMIT TRANSACTION;
    
    END TRY
	
    BEGIN CATCH
        -- Rollback
        ROLLBACK TRANSACTION;

        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

BEGIN
    EXEC usp_FixDepartureArrivalTimes;
END;
