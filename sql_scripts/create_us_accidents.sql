/********************************************************
* This script creates the database named us_accidents
*********************************************************/
DROP DATABASE IF EXISTS us_accidents;
CREATE DATABASE us_accidents;
USE us_accidents;

DROP TABLE IF EXISTS us_accidents_mega;
CREATE TABLE us_accidents_mega(
ID	VARCHAR(255),
Source VARCHAR(255),
TMC VARCHAR(255),
Severity	VARCHAR(255), 
Start_Time	VARCHAR(255),
End_Time VARCHAR(255),
Start_Lat	VARCHAR(255),
Start_Lng	VARCHAR(255),
End_Lat VARCHAR(255),	
End_Lng	VARCHAR(255),
Distance VARCHAR(255),
Description VARCHAR(500),
House_Number VARCHAR(255),
Street VARCHAR(255),
Side	VARCHAR(255),
City	VARCHAR(255),
County	VARCHAR(255),
State	VARCHAR(255),
Zipcode	VARCHAR(255),
Country	VARCHAR(255),
Timezone	VARCHAR(255),
Airport_Code	VARCHAR(255),
Weather_Timestamp	VARCHAR(255),
Temperature VARCHAR(255),
Wind_Chill VARCHAR(255),
Humidity VARCHAR(255),
Pressure VARCHAR(255),
Visibility VARCHAR(255),
Wind_Direction	VARCHAR(255),
Wind_Speed VARCHAR(255),
Precipitation VARCHAR(255),
Weather_Condition	VARCHAR(255),
Amenity	VARCHAR(255),
Bump	VARCHAR(255),
Crossing VARCHAR(255),
Give_Way	VARCHAR(255),
Junction	VARCHAR(255),
No_Exit	VARCHAR(255),
Railway	VARCHAR(255),
Roundabout	VARCHAR(255),
Station	VARCHAR(255),
is_stop	VARCHAR(255),
Traffic_Calming	VARCHAR(255),
Traffic_Signal	VARCHAR(255),
Turning_Loop	VARCHAR(255),
Sunrise_Sunset	VARCHAR(255),
Civil_Twilight	VARCHAR(255),
Nautical_Twilight	VARCHAR(255),
Astronomical_Twilight VARCHAR(255)
);


/********************************************
* Load data from the file into the mega table
*********************************************/
LOAD DATA INFILE 'c:/wamp64/tmp/us_accidents_full.csv' 
INTO TABLE us_accidents_mega
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';


-- create the normalized tables for the database
DROP TABLE IF EXISTS accidents;
CREATE TABLE accidents(
  accident_id			VARCHAR(255)	PRIMARY KEY,
  report_source			VARCHAR(64),
  TMC					DECIMAL(4, 1),
  severity				INT,
  # these times probably shouldn't be strings
  start_time			VARCHAR(255),
  end_time 				VARCHAR(255),
  description			VARCHAR(255)
);

DROP TABLE IF EXISTS weather;
CREATE TABLE weather(
  accident_id		 	VARCHAR(255) PRIMARY KEY,
  temperature			DECIMAL(3,1),
  wind_chill			DECIMAL(3,1),
  humidity				DECIMAL(2,1),
  pressure				DECIMAL(10,2),
  visibility			INT,
  wind_direction		VARCHAR(64),
  wind_speed			DECIMAL(10, 1),
  precipitation			DECIMAL(3,2),
  weather_condition		VARCHAR(64)
);

DROP TABLE IF EXISTS address;
CREATE TABLE address(
  accident_id			VARCHAR(255) PRIMARY KEY,
  house_num				INT,
  street				VARCHAR(64),
  city					VARCHAR(64),
  county				VARCHAR(64),
  state					VARCHAR(64),
  zip_code				INT(5),
  country				VARCHAR(64)
);

DROP TABLE IF EXISTS location;
CREATE TABLE location(
  accident_id			VARCHAR(255) PRIMARY KEY,
  start_lat				FLOAT,
  start_lng				FLOAT,
  end_lat				FLOAT,
  end_lng				FLOAT,
  distance				DECIMAL(5,2),
  timezone				VARCHAR(64),
  airport_code			VARCHAR(64),
  side					VARCHAR(64)
);

DROP TABLE IF EXISTS details;
CREATE TABLE details(
accident_id			VARCHAR(255) PRIMARY KEY,
ammenity			BOOLEAN,
bump 				BOOLEAN,
crossing			BOOLEAN,
give_way			BOOLEAN,
junction			BOOLEAN, 
no_exit				BOOLEAN, 
railway				BOOLEAN, 
roundabout			BOOLEAN, 
station				BOOLEAN, 
is_stop 			BOOLEAN,
traffic_calming  	BOOLEAN, 
traffic_signal		BOOLEAN, 
turning_loop		BOOLEAN
);

-- insert values from mega table into normalized tables

INSERT INTO accidents (accident_id, report_source, TMC, severity, start_time, end_time, description)
SELECT ID, Source, TMC, Severity, Start_time, End_time, description 
FROM us_accidents_mega;

INSERT INTO weather(accident_id, temperature, wind_chill, humidity, pressure, visibility, wind_direction, wind_speed, precipitation, weather_condition)
SELECT ID, Temperature, Wind_chill, Humidity, Pressure, Visibility, Wind_direction, Wind_speed, Precipitation, Weather_condition
FROM us_accidents_mega;



