SELECT r.number AS "Car Number",
	d.forename AS "First Name", 
	d.surname AS "Last Name", 
	d.nationality AS "Nationality",
	c.name AS "Constructor",
	r.position AS "Position",
	r.time AS "Time",
	s.status AS "Status"
	
    FROM drivers AS d
    JOIN results as r ON d.driver_id = r.driver_id
	JOIN constructors AS c ON c.constructor_id = r.constructor_id
	JOIN status AS s ON s.status_id = r.status_id
	WHERE r.race_id = 1




-- expanded race summary query

SELECT r.number AS "Car Number",
	d.forename AS "First Name", 
	d.surname AS "Last Name", 
	d.nationality AS "Nationality",
	c.name AS "Constructor",
	r.position AS "Position",
	r.time AS "Time",
	r.laps AS "Laps Completed",
	s.status AS "Status",
	r.points AS "Points",
	ds.points AS "Championship Points",
	r.grid AS "Starting Grid"
	
	
	
    FROM drivers AS d
    JOIN results as r ON d.driver_id = r.driver_id
	JOIN constructors AS c ON c.constructor_id = r.constructor_id
	JOIN status AS s ON s.status_id = r.status_id
	LEFT JOIN driver_standings AS ds ON (ds.race_id = r.race_id) AND (ds.driver_id = r.driver_id)
	WHERE r.race_id = 542