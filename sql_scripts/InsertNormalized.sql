
/********************************************************
* This script Deals with the normalization of the data.
* The populating of 'details' table will be handled in another
* script (DetailsInsert) in order to save space, said scrip should be run before accidents is populated.
*********************************************************/

	#Before work can be done on the table all "TRUE" and "FALSE" values must be turned to "1", and "0" so they can be used for comparison.
#ammenity
UPDATE us_accident_mega 
SET ammenity = '0'
WHERE ammenity = "FALSE";

UPDATE us_accident_mega 
SET ammenity = '1'
WHERE ammenity = "TRUE";

#bump
UPDATE us_accident_mega 
SET bump = '0'
WHERE bump = "FALSE";

UPDATE us_accident_mega 
SET bump = '1'
WHERE bump = "TRUE";

#crossing
UPDATE us_accident_mega 
SET crossing = '0'
WHERE crossing = "FALSE";

UPDATE us_accident_mega 
SET crossing = '1'
WHERE crossing = "TRUE";

#give_way
UPDATE us_accident_mega 
SET give_way = '0'
WHERE give_way = "FALSE";

UPDATE us_accident_mega 
SET give_way = '1'
WHERE give_way = "TRUE";

#junction
UPDATE us_accident_mega 
SET junction = '0'
WHERE junction = "FALSE";

UPDATE us_accident_mega 
SET junction = '1'
WHERE junction = "TRUE";

#no_exit
UPDATE us_accident_mega 
SET no_exit = '0'
WHERE no_exit = "FALSE";

UPDATE us_accident_mega 
SET no_exit = '1'
WHERE no_exit = "TRUE";

#railway
UPDATE us_accident_mega 
SET railway = '0'
WHERE railway = "FALSE";

UPDATE us_accident_mega 
SET railway = '1'
WHERE railway = "TRUE";

#roundabout
UPDATE us_accident_mega 
SET roundabout = '0'
WHERE roundabout = "FALSE";

UPDATE us_accident_mega 
SET roundabout = '1'
WHERE roundabout = "TRUE";

#station
UPDATE us_accident_mega 
SET station = '0'
WHERE station = "FALSE";

UPDATE us_accident_mega 
SET station = '1'
WHERE station = "TRUE";

#is_stop
UPDATE us_accident_mega 
SET is_stop = '0'
WHERE is_stop = "FALSE";

UPDATE us_accident_mega 
SET is_stop = '1'
WHERE is_stop = "TRUE";

#traffic_calming
UPDATE us_accident_mega 
SET traffic_calming = '0'
WHERE traffic_calming = "FALSE";

UPDATE us_accident_mega 
SET traffic_calming = '1'
WHERE traffic_calming = "TRUE";

#traffic_signal
UPDATE us_accident_mega 
SET traffic_signal = '0'
WHERE traffic_signal = "FALSE";

UPDATE us_accident_mega 
SET traffic_signal = '1'
WHERE traffic_signal = "TRUE";

#turning_loop
UPDATE us_accident_mega 
SET turning_loop = '0'
WHERE turning_loop = "FALSE";

UPDATE us_accident_mega 
SET turning_loop = '1'
WHERE turning_loop = "TRUE";

#	Adding to accidents should happen last b/c of foreign key, get the correct Detail_ID 
#by joining 
INSERT INTO accidents (accident_id, report_source, TMC, severity, start_time, end_time, description, Detail_ID)

SELECT ID, report_source, TMC, Severity, Start_time, End_time, description, Detail_ID
FROM(us_accident_mega INNER JOIN 
	details 
    ON 		us_accident_mega.ammenity = details.ammenity AND
			us_accident_mega.bump = details.bump AND
            us_accident_mega.crossing = details.crossing AND
            us_accident_mega.give_way = details.give_way AND
            us_accident_mega.junction = details.junction AND
            us_accident_mega.no_exit = details.no_exit AND
            us_accident_mega.railway = details.railway AND
            us_accident_mega.roundabout = details.roundabout AND
            us_accident_mega.station = details.station AND
            us_accident_mega.is_stop = details.is_stop AND
            us_accident_mega.traffic_calming = details.traffic_calming AND
            us_accident_mega.traffic_signal = details.traffic_signal AND
            us_accident_mega.turning_loop = details.turning_loop
);


INSERT INTO weather(accident_id, temperature, wind_chill, humidity, pressure, visibility, wind_direction, wind_speed, precipitation, weather_condition)
SELECT ID, Temperature, Wind_chill, Humidity, Pressure, Visibility, Wind_direction, Wind_speed, Precipitation, Weather_condition
FROM us_accidents_mega;

INSERT INTO address (accident_id, house_num, street, city, county, state, zip_code, country)
SELECT accident_id, house_num, street, city, county, state, zip_code, country
FROM us_accidents_mega;

INSERT INTO location (accident_id, start_lat, start_lng, end_lat, end_lng, distance, timezone, airport_code, side)
SELECT accident_id, start_lat, start_lng, end_lat, end_lng, distance, timezone, airport_code, side
FROM us_accidents_mega;





