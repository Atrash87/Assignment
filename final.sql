
--Join weather and train tables
SELECT *
FROM dbo.train$
JOIN dbo.weather_data$ ON 
    dbo.weather_data$.time >= dbo.train$.start_time
    AND dbo.weather_data$.time < DATEADD(MINUTE, 30, dbo.train$.start_time);


	--Precepitation V.S Rental
		SELECT
    rain,
    snow,
    hail,
    thunder,
    fog,
    COUNT(*) AS rental_count
FROM
            dbo.['Train-weather$']

GROUP BY
    rain, snow, hail, thunder, fog
ORDER BY
    rental_count DESC;



--tempreture V.S rental
SELECT
tempm,
    COUNT(*) AS rental_count
FROM
            dbo.['Train-weather$']

GROUP BY
   tempm
ORDER BY
    rental_count DESC;

	-- Monthly bike rentals
SELECT
    MONTH(start_time) AS rental_month,
    COUNT(*) AS total_rentals
FROM dbo.['Train-weather$']
GROUP BY  MONTH(start_time)
ORDER BY  rental_month;

-- Monthly bike rentals by time intervals
WITH TimeIntervals AS (
    SELECT 1 AS interval_id, 'Morning' AS interval_name, 6 AS start_hour, 12 AS end_hour
    UNION ALL
    SELECT 2 AS interval_id, 'Afternoon' AS interval_name, 12 AS start_hour, 18 AS end_hour
    UNION ALL
    SELECT 3 AS interval_id, 'Evening' AS interval_name, 18 AS start_hour, 24 AS end_hour
    UNION ALL
    SELECT 4 AS interval_id, 'Night' AS interval_name, 0 AS start_hour, 6 AS end_hour
)
SELECT
    MONTH(start_time) AS rental_month,
    
    interval_name,
    COUNT(*) AS total_rentals
FROM
    dbo.train$
JOIN
    TimeIntervals ON DATEPART(HOUR, start_time) >= start_hour AND DATEPART(HOUR, start_time) < end_hour
GROUP BY
     MONTH(start_time),  interval_name
ORDER BY
     rental_month, interval_name ;

	--day of the week and month rentals
	SELECT
    MONTH(start_time) AS rental_month,
    DATENAME(WEEKDAY, start_time) AS day_of_week,
    COUNT(*) AS total_rentals
FROM
        dbo.train$
GROUP BY
     MONTH(start_time), DATENAME(WEEKDAY, start_time)
ORDER BY
     rental_month, total_rentals DESC, day_of_week;


	 --Overall Day rentals

	 SELECT
    DATENAME(WEEKDAY, start_time) AS day_of_week,
    COUNT(*) AS total_rentals
FROM
        dbo.train$
GROUP BY
    DATENAME(WEEKDAY, start_time)
ORDER BY
    total_rentals DESC;


	
	 SELECT
    T.*,
    S.place_name,
    S.lat,
    S.lng
FROM
    dbo.['Train-weather$'] AS T
JOIN
    dbo.station_data$ AS S ON T.start_location = S.place_id;