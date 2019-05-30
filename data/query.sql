Select driver_id, milliseconds, race_id from lap_times
where race_id in (select race_id from races
				 	where circuit_id = 7)