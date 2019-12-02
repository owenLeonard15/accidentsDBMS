/*
	Procedures to be used by API when getting data for front end
*/
USE us_accidents;

DELIMITER $$
DROP PROCEDURE IF EXISTS insertRecord;

CREATE PROCEDURE insertRecord(	IN ID	VARCHAR(255),
								IN report_source VARCHAR(255),
								IN TMC VARCHAR(255),
								IN Severity	VARCHAR(255), 
								IN Start_Time	VARCHAR(255),
								IN End_Time VARCHAR(255),
								IN Start_Lat	VARCHAR(255),
								IN Start_Lng	VARCHAR(255),
								IN End_Lat VARCHAR(255),	
								IN End_Lng	VARCHAR(255),
								IN Distance VARCHAR(255),
								IN Description VARCHAR(500),
								IN House_Number VARCHAR(255),
								IN Street VARCHAR(255),
								IN Side	VARCHAR(255),
								IN City	VARCHAR(255),
								IN County	VARCHAR(255),
								IN State	VARCHAR(255),
								IN Zipcode	VARCHAR(255),
								IN Country	VARCHAR(255),
								IN Timezone	VARCHAR(255),
								IN Airport_Code	VARCHAR(255),
								IN Weather_Timestamp	VARCHAR(255),
								IN Temperature VARCHAR(255),
								IN Wind_Chill VARCHAR(255),
								IN Humidity VARCHAR(255),
								IN Pressure VARCHAR(255),
								IN Visibility VARCHAR(255),
								IN Wind_Direction	VARCHAR(255),
								IN Wind_Speed VARCHAR(255),
								IN Precipitation VARCHAR(255),
								IN Weather_Condition	VARCHAR(255),
								IN Amenity	VARCHAR(255),
								IN Bump	VARCHAR(255),
								IN Crossing VARCHAR(255),
								IN Give_Way	VARCHAR(255),
								IN Junction	VARCHAR(255),
								IN No_Exit	VARCHAR(255),
								IN Railway	VARCHAR(255),
								IN Roundabout	VARCHAR(255),
								IN Station	VARCHAR(255),
								IN is_stop	VARCHAR(255),
								IN Traffic_Calming	VARCHAR(255),
								IN Traffic_Signal	VARCHAR(255),
								IN Turning_Loop	VARCHAR(255)
)
BEGIN
	START TRANSACTION;
			#Accident Insert
		INSERT INTO accidents (accident_id, report_source, TMC, severity, start_time, end_time, description, Detail_ID)
		(SELECT ID, report_source, TMC, Severity, Start_time, End_time, description, Detail_ID
		FROM(
			(SELECT ID, report_source, TMC, Severity, Start_time, End_time, description)
			INNER JOIN 
			details 
			ON 
			Amenity = details.amenity AND
			Bump = details.bump AND
			Crossing = details.crossing AND
			Give_Way = details.give_way AND
			Junction = details.junction AND
			No_Exit = details.no_exit AND
			Railway = details.railway AND
			Roundabout = details.roundabout AND
			Station = details.station AND
			is_stop = details.is_stop AND
			Traffic_calming = details.traffic_calming AND
			Traffic_signal = details.traffic_signal AND
			Turning_loop = details.turning_loop)
		);
			#weather Insert
			# {Hummidity, Pressure, Visibility} Need to be passed in as NULL not ''
		INSERT INTO weather(accident_id, temperature, wind_chill, humidity, pressure, visibility, wind_direction, wind_speed, precipitation, weather_condition)
		(SELECT ID, Temperature, Wind_chill, Humidity, Pressure, Visibility, Wind_direction, Wind_speed, Precipitation, Weather_condition);
            #address Insert
            # {House_Number} Needs to be passed in as NULL not '' 
		INSERT INTO address (accident_id, house_num, street, city, county, state, zip_code, country)
		(SELECT ID, House_Number, Street, City, County, State, Zipcode, Country);
            #location Insert
            # {end_lat, end_lng} Need to be passed in as NULL not ''
		INSERT INTO location (accident_id, start_lat, start_lng, end_lat, end_lng, distance, timezone, airport_code, side)
		(SELECT ID, start_lat, start_lng, end_lat, end_lng, distance, timezone, airport_code, side);
			
			
	IF error THEN	
		ROLLBACK;	
	ELSE	
		COMMIT;	
	END	IF;	
END$$


