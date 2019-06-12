SELECT ra.round AS "Round",
	ci.name AS "Circuit",
	ra.name AS "Name",
	ci.country AS "Country",
	ra.date AS "Date"
	
    FROM races AS ra
	JOIN circuits AS ci ON ci.circuit_id = ra.circuit_id
	WHERE ra.year = 1985