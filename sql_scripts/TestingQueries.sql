-- TESTING QUERIES --
USE us_accidents;

#Not Time efficient.
-- INSERT INTO details (Detail_ID, ammenity, bump, crossing, give_way, junction, no_exit, railway, roundabout, station, is_stop, traffic_calming, traffic_signal, turning_loop)
-- VALUES (-1, True, True, True, True, True, True, True, True, True, True, True, True, True);

-- DELETE FROM details WHERE Detail_ID = -1;

SELECT * FROM details;

SELECT ('1' = True);
SELECT ('0' = True);
SELECT ('1' = False);
SELECT ('0' = False);
