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