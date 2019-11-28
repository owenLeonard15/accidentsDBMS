/********************************************************
* This script creates the database named us_accidents
*********************************************************/
DROP DATABASE IF EXISTS us_accidents;
CREATE DATABASE us_accidents;
USE us_accidents;

DROP TABLE IF EXISTS us_accidents_mega;
CREATE TABLE us_accidents_mega(
ID	VARCHAR(255),
report_source VARCHAR(255),
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

DROP TRIGGER IF EXISTS weather_insert;
DELIMITER $$
CREATE TRIGGER weather_insert BEFORE INSERT ON us_accidents_mega
FOR EACH ROW
BEGIN
	IF NEW.wind_chill = '' THEN
    SET NEW.wind_chill = NULL;
    END IF;
    IF NEW.wind_speed = '' THEN
    SET NEW.wind_speed = 0;
    END IF;
    IF NEW.precipitation = '' THEN
    SET NEW.precipitation = 0;
    END IF;
    IF NEW.temperature = '' THEN
    SET NEW.temperature = NULL;
    END IF;
END $$
DELIMITER ; 

/********************************************
* Load data from the file into the mega table
*********************************************/
LOAD DATA INFILE 'C:/wamp64/tmp/us_accidents_full.csv' 
INTO TABLE us_accidents_mega
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';


-- create the normalized tables for the database
DROP TABLE IF EXISTS accidents;
CREATE TABLE accidents(
  accident_id			VARCHAR(255) PRIMARY KEY,
  report_source			VARCHAR(64) NOT NULL,
  TMC					DECIMAL(4, 1),
  severity				INT NOT NULL,
  # these times probably shouldn't be strings
  start_time			VARCHAR(255) NOT NULL,
  end_time 				VARCHAR(255) NOT NULL,
  description			VARCHAR(255),
  Detail_ID				INT,
  CONSTRAINT Valid_ID CHECK (accident_id LIKE "A-_%"),
  CONSTRAINT Valid_Severity CHECK (severity IN (1, 2, 3, 4))
);

DROP TABLE IF EXISTS weather;
CREATE TABLE weather(
  accident_id		 	VARCHAR(255) PRIMARY KEY,
  temperature			FLOAT,
  wind_chill			FLOAT,
  humidity				INT,
  pressure				DECIMAL(10,2),
  visibility			INT,
  wind_direction		VARCHAR(64),
  wind_speed			DECIMAL(10, 1),
  precipitation			FLOAT,
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
  zip_code				VARCHAR(10),
  country				VARCHAR(64),
  CONSTRAINT Valid_State CHECK (state IN ('AL', 'AK', 'AZ', 'AR', 'CA', 
											'CO', 'CT', 'DE', 'FL', 'GA', 
                                            'HI', 'ID', 'IL', 'IN', 'IA', 
                                            'KS', 'KY', 'LA', 'ME', 'MD',
                                            'MA', 'MI', 'MN', 'MS', 'MO', 
                                            'MT', 'NE', 'NV', 'NH', 'NJ', 
                                            'NM', 'NY', 'NC', 'ND', 'OH', 
                                            'OK', 'OR', 'PA', 'RI', 'SC', 
                                            'SC', 'TN', 'TX', 'UT', 'VT',
                                            'VA', 'WA', 'WV', 'WI', 'WY'))
);

DROP TABLE IF EXISTS location;
CREATE TABLE location(
  accident_id			VARCHAR(255) PRIMARY KEY,
  start_lat				FLOAT NOT NULL,
  start_lng				FLOAT NOT NULL,
  end_lat				FLOAT,
  end_lng				FLOAT,
  distance				DECIMAL(5,2) NOT NULL,
  timezone				VARCHAR(64),
  airport_code			VARCHAR(64),
  side					VARCHAR(64),
  CONSTRAINT Valid_Side CHECK (side IN ('L', 'R'))
);

DROP TABLE IF EXISTS details;
CREATE TABLE details(
Detail_ID			INT PRIMARY KEY AUTO_INCREMENT,
amenity				BOOLEAN NOT NULL,
bump 				BOOLEAN NOT NULL,
crossing			BOOLEAN NOT NULL,
give_way			BOOLEAN NOT NULL,
junction			BOOLEAN NOT NULL, 
no_exit				BOOLEAN NOT NULL, 
railway				BOOLEAN NOT NULL, 
roundabout			BOOLEAN NOT NULL, 
station				BOOLEAN NOT NULL, 
is_stop 			BOOLEAN NOT NULL,
traffic_calming  	BOOLEAN NOT NULL,
traffic_signal		BOOLEAN NOT NULL,
turning_loop		BOOLEAN NOT NULL
);


-- Adding Foreign Key Constraints

#Addding constraint for Details_Id in Accidents
ALTER TABLE accidents
ADD CONSTRAINT FK_DetailId
FOREIGN KEY (Detail_ID) REFERENCES details(Detail_ID);



