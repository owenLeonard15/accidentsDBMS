/*
	Procedures to be used by API when getting data for front end
*/
USE us_accidents;

DELIMITER $$
#Grabbing Location Info
DROP PROCEDURE IF EXISTS getLocation;
CREATE PROCEDURE getLocation(
#Fill
)
BEGIN
#Fill
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS getWeatherCondition;
CREATE PROCEDURE getWeatherCondition(
	SELECT accident_id, description, weather_condition
    FROM accidents INNER JOIN weather
)
