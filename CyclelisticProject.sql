/* ===============================================================================
CYCLISTIC BIKE-SHARE CASE STUDY: DATA CLEANING & ANALYSIS
Tool: SQL Server Management Studio (SSMS)
Description: Analyzing differences between casual riders and annual members.
===============================================================================
*/

-- Step 1: Initialize Environment
USE CyclisticProject;
GO

-- Step 2: Data Cleaning (The "Process" Phase)
-- Removing maintenance/test station records to avoid skewed results
DELETE FROM Divvy_Trips_2020_Q1
WHERE start_station_name = 'HQ QR' 
   OR end_station_name = 'HQ QR';

-- Removing outliers: trips < 1 minute (accidental) or > 24 hours (lost/stolen)
DELETE FROM Divvy_Trips_2020_Q1
WHERE DATEDIFF(SECOND, started_at, ended_at) < 60 
   OR DATEDIFF(SECOND, started_at, ended_at) > 86400;

-- Step 3: Analysis (The "Analyze" Phase)
-- 3a. Compare Average Duration and Total Volume per User Type
SELECT 
    member_casual, 
    AVG(DATEDIFF(SECOND, started_at, ended_at)/60.0) AS avg_ride_duration_minutes,
    COUNT(*) AS total_rides
FROM Divvy_Trips_2020_Q1
GROUP BY member_casual;

-- 3b. Compare Busiest Days of the Week (1=Sun, 7=Sat)
-- This helps identify leisure vs. commuting patterns.
SELECT 
    member_casual, 
    DATEPART(WEEKDAY, started_at) AS day_of_week, 
    COUNT(*) AS ride_count
FROM Divvy_Trips_2020_Q1
GROUP BY member_casual, DATEPART(WEEKDAY, started_at)
ORDER BY member_casual, ride_count DESC;