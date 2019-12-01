
/********************************************************
* This script Deals with the normalization of the data.
* The populating of 'details' table will be handled in another
* script (DetailsInsert) in order to save space, said script should be run before accidents is populated.
*********************************************************/

# Before work can be done on the table all "TRUE" and "FALSE" values must be turned to "1", and "0" so they can be used for comparison.
# This will allow for them to be quickly grouped into the details table 
# Also will help more quickly join accidents and details tables together

UPDATE us_accidents_mega 
SET amenity = 0
WHERE amenity = 'FALSE';

UPDATE us_accidents_mega 
SET amenity = 1
WHERE amenity = 'TRUE';

#bump
UPDATE us_accidents_mega 
SET bump = 0
WHERE bump = 'FALSE';

UPDATE us_accidents_mega 
SET bump = 1
WHERE bump = 'TRUE';

#crossing
UPDATE us_accidents_mega 
SET crossing = 0
WHERE crossing = 'FALSE';

UPDATE us_accidents_mega 
SET crossing = 1
WHERE crossing = 'TRUE';

#give_way
UPDATE us_accidents_mega 
SET give_way = 0
WHERE give_way = 'FALSE';

UPDATE us_accidents_mega 
SET give_way = 1
WHERE give_way = 'TRUE';

#junction
UPDATE us_accidents_mega 
SET junction = 0
WHERE junction = 'FALSE';

UPDATE us_accidents_mega 
SET junction = 1
WHERE junction = 'TRUE';

#no_exit
UPDATE us_accidents_mega 
SET no_exit = 0
WHERE no_exit = 'FALSE';

UPDATE us_accidents_mega 
SET no_exit = 1
WHERE no_exit = 'TRUE';

#railway
UPDATE us_accidents_mega 
SET railway = 0
WHERE railway = 'TRUE';

UPDATE us_accidents_mega 
SET railway = 1
WHERE railway = 'FALSE';

#roundabout
UPDATE us_accidents_mega 
SET roundabout = 0
WHERE roundabout = 'FALSE';

UPDATE us_accidents_mega 
SET roundabout = 1
WHERE roundabout = 'TRUE';

#station
UPDATE us_accidents_mega 
SET station = 0
WHERE station = 'FALSE';

UPDATE us_accidents_mega 
SET station = 1
WHERE station = 'TRUE';

#is_stop
UPDATE us_accidents_mega 
SET is_stop = 0
WHERE is_stop = 'FALSE';

UPDATE us_accidents_mega 
SET is_stop = 1
WHERE is_stop = 'TRUE';

#traffic_calming
UPDATE us_accidents_mega 
SET traffic_calming = 0
WHERE traffic_calming = 'FALSE';

UPDATE us_accidents_mega 
SET traffic_calming = 1
WHERE traffic_calming = 'TRUE';

#traffic_signal
UPDATE us_accidents_mega 
SET traffic_signal = 0
WHERE traffic_signal = 'FALSE';

UPDATE us_accidents_mega 
SET traffic_signal = 1
WHERE traffic_signal = 'TRUE';

#turning_loop
UPDATE us_accidents_mega 
SET turning_loop = 0
WHERE turning_loop = 'FALSE';

UPDATE us_accidents_mega 
SET turning_loop = 1
WHERE turning_loop = 'TRUE';

#	Adding to accidents should happen last b/c of foreign key, get the correct Detail_ID 
#by joining 
INSERT INTO accidents (accident_id, report_source, TMC, severity, start_time, end_time, description, Detail_ID)
( SELECT ID, report_source, TMC, Severity, Start_time, End_time, description, Detail_ID
FROM(us_accidents_mega INNER JOIN 
	details 
    ON 		us_accidents_mega.amenity = details.amenity AND
			us_accidents_mega.bump = details.bump AND
            us_accidents_mega.crossing = details.crossing AND
            us_accidents_mega.give_way = details.give_way AND
            us_accidents_mega.junction = details.junction AND
            us_accidents_mega.no_exit = details.no_exit AND
            us_accidents_mega.railway = details.railway AND
            us_accidents_mega.roundabout = details.roundabout AND
            us_accidents_mega.station = details.station AND
            us_accidents_mega.is_stop = details.is_stop AND
            us_accidents_mega.traffic_calming = details.traffic_calming AND
            us_accidents_mega.traffic_signal = details.traffic_signal AND
            us_accidents_mega.turning_loop = details.turning_loop
) LIMIT 200000) ;

# weather
UPDATE us_accidents_mega 
SET humidity = NULL
WHERE humidity = '';

UPDATE us_accidents_mega 
SET pressure = NULL
WHERE pressure = '';

UPDATE us_accidents_mega 
SET visibility = NULL
WHERE visibility = '';

INSERT INTO weather(accident_id, temperature, wind_chill, humidity, pressure, visibility, wind_direction, wind_speed, precipitation, weather_condition)
SELECT ID, Temperature, Wind_chill, Humidity, Pressure, Visibility, Wind_direction, Wind_speed, Precipitation, Weather_condition
FROM us_accidents_mega LIMIT 200000;


# address
UPDATE us_accidents_mega 
SET house_number = NULL
WHERE house_number = '';

INSERT INTO address (accident_id, house_num, street, city, county, state, zip_code, country)
SELECT ID, house_number, street, city, county, state, zipcode, country
FROM us_accidents_mega
LIMIT 200000;

# location
UPDATE us_accidents_mega 
SET end_lat = NULL
WHERE end_lat = '';

UPDATE us_accidents_mega 
SET end_lng = NULL
WHERE end_lng = '';

INSERT INTO location (accident_id, start_lat, start_lng, end_lat, end_lng, distance, timezone, airport_code, side)
SELECT ID, start_lat, start_lng, end_lat, end_lng, distance, timezone, airport_code, side
FROM us_accidents_mega LIMIT 200000;





