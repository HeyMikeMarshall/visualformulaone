CREATE TABLE "results" (
    "resultId" serial   NOT NULL,
    "raceId" int   NOT NULL,
    "driverId" int   NOT NULL,
    "constructorId" int   NOT NULL,
    "number" int   NOT NULL,
    "grid" int   NOT NULL,
    "position" int   NOT NULL,
    "positionText" varchar(255)   NOT NULL,
    "positionOrder" int   NOT NULL,
    "points" float   NOT NULL,
    "laps" int   NOT NULL,
    "time" varchar(255)   NOT NULL,
    "milliseconds" int   NOT NULL,
    "fastestLap" int   NOT NULL,
    "rank" int   NOT NULL,
    "fastestLapTime" varchar(255)   NOT NULL,
    "fastestLapSpeed" varchar(255)   NOT NULL,
    "statusId" int   NOT NULL,
    CONSTRAINT "pk_results" PRIMARY KEY (
        "resultId"
     )
);

CREATE TABLE "circuits" (
    "circuitID" serial   NOT NULL,
    "circuitRef" varchar(255)   NOT NULL,
    "name" varchar(255)   NOT NULL,
    "location" varchar(255)   NOT NULL,
    "country" varchar(255)   NOT NULL,
    "lat" float   NOT NULL,
    "lng" float   NOT NULL,
    "alt" int   NOT NULL,
    "url" varchar(255)   NOT NULL,
    CONSTRAINT "pk_circuits" PRIMARY KEY (
        "circuitID"
     ),
    CONSTRAINT "uc_circuits_url" UNIQUE (
        "url"
    )
);

CREATE TABLE "constructor_results" (
    "constructorResultsId" serial   NOT NULL,
    "raceId" int   NOT NULL,
    "constructorId" int   NOT NULL,
    "points" float   NOT NULL,
    "status" varchar(255)   NOT NULL,
    CONSTRAINT "pk_constructor_results" PRIMARY KEY (
        "constructorResultsId"
     )
);

CREATE TABLE "constructors" (
    "constructorId" serial   NOT NULL,
    "constructorRef" varchar(255)   NOT NULL,
    "name" varchar(255)   NOT NULL,
    "nationality" varchar(255)   NOT NULL,
    "url" varchar(255)   NOT NULL,
    CONSTRAINT "pk_constructors" PRIMARY KEY (
        "constructorId"
     )
);

CREATE TABLE "races" (
    "raceId" serial   NOT NULL,
    "year" int   NOT NULL,
    "round" int   NOT NULL,
    "circuitId" int   NOT NULL,
    "name" varchar(255)   NOT NULL,
    "date" date   NOT NULL,
    "time" time   NOT NULL,
    "url" varchar(255)   NOT NULL,
    CONSTRAINT "pk_races" PRIMARY KEY (
        "raceId"
     ),
    CONSTRAINT "uc_races_url" UNIQUE (
        "url"
    )
);

CREATE TABLE "constructor_standings" (
    "constructorStandingsId" serial   NOT NULL,
    "raceId" int   NOT NULL,
    "constructorId" int   NOT NULL,
    "points" float   NOT NULL,
    "position" int   NOT NULL,
    "positionText" varchar(255)   NOT NULL,
    "wins" int   NOT NULL,
    CONSTRAINT "pk_constructor_standings" PRIMARY KEY (
        "constructorStandingsId"
     )
);

CREATE TABLE "driver_standings" (
    "driverStandingsId" serial   NOT NULL,
    "raceId" int   NOT NULL,
    "driverId" int   NOT NULL,
    "points" float   NOT NULL,
    "position" int   NOT NULL,
    "positionText" varchar(255)   NOT NULL,
    "wins" int   NOT NULL,
    CONSTRAINT "pk_driver_standings" PRIMARY KEY (
        "driverStandingsId"
     )
);

CREATE TABLE "drivers" (
    "driverId" serial   NOT NULL,
    "driverRef" varchar(255)   NOT NULL,
    "number" int   NOT NULL,
    "code" varchar(3)   NOT NULL,
    "forename" varchar(255)   NOT NULL,
    "surname" varchar(255)   NOT NULL,
    "dob" date   NOT NULL,
    "nationality" varchar(255)   NOT NULL,
    "url" varchar(255)   NOT NULL,
    CONSTRAINT "pk_drivers" PRIMARY KEY (
        "driverId"
     )
);

CREATE TABLE "lap_times" (
    "raceId" int   NOT NULL,
    "driverId" int   NOT NULL,
    "lap" int   NOT NULL,
    "position" int   NOT NULL,
    "time" varchar(255)   NOT NULL,
    "milliseconds" int   NOT NULL,
    CONSTRAINT "pk_lap_times" PRIMARY KEY (
        "raceId","driverId","lap"
     )
);

CREATE TABLE "pit_stops" (
    "raceId" int   NOT NULL,
    "driverId" int   NOT NULL,
    "stop" int   NOT NULL,
    "lap" int   NOT NULL,
    "time" varchar(255)   NOT NULL,
    "duration" varchar(255)   NOT NULL,
    "milliseconds" int   NOT NULL,
    CONSTRAINT "pk_pit_stops" PRIMARY KEY (
        "raceId","driverId","stop"
     )
);





ALTER TABLE "results" ADD CONSTRAINT "fk_results_raceId" FOREIGN KEY("raceId")
REFERENCES "races" ("raceId");

ALTER TABLE "results" ADD CONSTRAINT "fk_results_driverId" FOREIGN KEY("driverId")
REFERENCES "drivers" ("driverId");

ALTER TABLE "results" ADD CONSTRAINT "fk_results_constructorId" FOREIGN KEY("constructorId")
REFERENCES "constructors" ("constructorId");

ALTER TABLE "results" ADD CONSTRAINT "fk_results_statusId" FOREIGN KEY("statusId")
REFERENCES "Table 13" ("...");

ALTER TABLE "constructor_results" ADD CONSTRAINT "fk_constructor_results_raceId" FOREIGN KEY("raceId")
REFERENCES "races" ("raceId");

ALTER TABLE "constructor_results" ADD CONSTRAINT "fk_constructor_results_constructorId" FOREIGN KEY("constructorId")
REFERENCES "constructors" ("constructorId");

ALTER TABLE "races" ADD CONSTRAINT "fk_races_year" FOREIGN KEY("year")
REFERENCES "Table 12" ("...");

ALTER TABLE "races" ADD CONSTRAINT "fk_races_circuitId" FOREIGN KEY("circuitId")
REFERENCES "circuits" ("circuitID");

ALTER TABLE "constructor_standings" ADD CONSTRAINT "fk_constructor_standings_raceId" FOREIGN KEY("raceId")
REFERENCES "races" ("raceId");

ALTER TABLE "driver_standings" ADD CONSTRAINT "fk_driver_standings_raceId" FOREIGN KEY("raceId")
REFERENCES "races" ("raceId");

ALTER TABLE "driver_standings" ADD CONSTRAINT "fk_driver_standings_driverId" FOREIGN KEY("driverId")
REFERENCES "drivers" ("driverId");

ALTER TABLE "lap_times" ADD CONSTRAINT "fk_lap_times_raceId" FOREIGN KEY("raceId")
REFERENCES "races" ("raceId");

ALTER TABLE "pit_stops" ADD CONSTRAINT "fk_pit_stops_raceId" FOREIGN KEY("raceId")
REFERENCES "races" ("raceId");

-- Free plan table limit reached. SUBSCRIBE for more.



-- Free plan table limit reached. SUBSCRIBE for more.



