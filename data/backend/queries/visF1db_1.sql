DROP TABLE IF EXISTS "circuits";
CREATE TABLE "circuits" (
  "circuitId" int NOT NULL,
  "circuitRef" varchar(255) NOT NULL DEFAULT '',
  "name" varchar(255) NOT NULL DEFAULT '',
  "location" varchar(255) DEFAULT NULL,
  "country" varchar(255) DEFAULT NULL,
  "lat" float DEFAULT NULL,
  "lng" float DEFAULT NULL,
  "alt" int DEFAULT NULL,
  "url" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("circuitId")
);

DROP TABLE IF EXISTS "constructorResults";
CREATE TABLE "constructorResults" (
  "constructorResultsId" int NOT NULL,
  "raceId" int NOT NULL DEFAULT '0',
  "constructorId" int NOT NULL DEFAULT '0',
  "points" float DEFAULT NULL,
  "status" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("constructorResultsId")
);

DROP TABLE IF EXISTS "constructorStandings";
CREATE TABLE "constructorStandings" (
  "constructorStandingsId" int NOT NULL,
  "raceId" int NOT NULL DEFAULT '0',
  "constructorId" int NOT NULL DEFAULT '0',
  "points" float NOT NULL DEFAULT '0',
  "position" int DEFAULT NULL,
  "positionText" varchar(255) DEFAULT NULL,
  "wins" int NOT NULL DEFAULT '0',
  PRIMARY KEY ("constructorStandingsId")
);

DROP TABLE IF EXISTS "constructors";
CREATE TABLE "constructors" (
  "constructorId" int NOT NULL,
  "constructorRef" varchar(255) NOT NULL DEFAULT '',
  "name" varchar(255) NOT NULL DEFAULT '',
  "nationality" varchar(255) DEFAULT NULL,
  "url" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("constructorId")
);

DROP TABLE IF EXISTS "driverStandings";
CREATE TABLE "driverStandings" (
  "driverStandingsId" int NOT NULL,
  "raceId" int NOT NULL DEFAULT '0',
  "driverId" int NOT NULL DEFAULT '0',
  "points" float NOT NULL DEFAULT '0',
  "position" int DEFAULT NULL,
  "positionText" varchar(255) DEFAULT NULL,
  "wins" int NOT NULL DEFAULT '0',
  PRIMARY KEY ("driverStandingsId")
);

DROP TABLE IF EXISTS "drivers";
CREATE TABLE "drivers" (
  "driverId" int NOT NULL,
  "driverRef" varchar(255) NOT NULL DEFAULT '',
  "number" int DEFAULT NULL,
  "code" varchar(3) DEFAULT NULL,
  "forename" varchar(255) NOT NULL DEFAULT '',
  "surname" varchar(255) NOT NULL DEFAULT '',
  "dob" varchar(255) DEFAULT NULL,
  "nationality" varchar(255) DEFAULT NULL,
  "url" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("driverId")
);

DROP TABLE IF EXISTS "lapTimes";
CREATE TABLE "lapTimes" (
  "raceId" int NOT NULL,
  "driverId" int NOT NULL,
  "lap" int NOT NULL,
  "position" int DEFAULT NULL,
  "time" varchar(255) DEFAULT NULL,
  "milliseconds" int DEFAULT NULL,
  PRIMARY KEY ("raceId","driverId","lap")
);

DROP TABLE IF EXISTS "pitStops";
CREATE TABLE "pitStops" (
  "raceId" int NOT NULL,
  "driverId" int NOT NULL,
  "stop" int NOT NULL,
  "lap" int NOT NULL,
  "time" time NOT NULL,
  "duration" varchar(255) DEFAULT NULL,
  "milliseconds" int DEFAULT NULL,
  PRIMARY KEY ("raceId","driverId","stop")
);

DROP TABLE IF EXISTS "qualifying";
CREATE TABLE "qualifying" (
  "qualifyId" int NOT NULL,
  "raceId" int NOT NULL DEFAULT '0',
  "driverId" int NOT NULL DEFAULT '0',
  "constructorId" int NOT NULL DEFAULT '0',
  "number" int NOT NULL DEFAULT '0',
  "position" int DEFAULT NULL,
  "q1" varchar(255) DEFAULT NULL,
  "q2" varchar(255) DEFAULT NULL,
  "q3" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("qualifyId")
);

DROP TABLE IF EXISTS "races";
CREATE TABLE "races" (
  "raceId" int NOT NULL,
  "year" int NOT NULL DEFAULT '0',
  "round" int NOT NULL DEFAULT '0',
  "circuitId" int NOT NULL DEFAULT '0',
  "name" varchar(255) NOT NULL DEFAULT '',
  "date" varchar(255) NOT NULL DEFAULT '0000-00-00',
  "time" time DEFAULT NULL,
  "url" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("raceId")
);

DROP TABLE IF EXISTS "results";
CREATE TABLE "results" (
  "resultId" int NOT NULL,
  "raceId" int NOT NULL DEFAULT '0',
  "driverId" int NOT NULL DEFAULT '0',
  "constructorId" int NOT NULL DEFAULT '0',
  "number" int DEFAULT NULL,
  "grid" int NOT NULL DEFAULT '0',
  "position" int DEFAULT NULL,
  "positionText" varchar(255) NOT NULL DEFAULT '',
  "positionOrder" int NOT NULL DEFAULT '0',
  "points" float NOT NULL DEFAULT '0',
  "laps" int NOT NULL DEFAULT '0',
  "time" varchar(255) DEFAULT NULL,
  "milliseconds" int DEFAULT NULL,
  "fastestLap" int DEFAULT NULL,
  "rank" int DEFAULT '0',
  "fastestLapTime" varchar(255) DEFAULT NULL,
  "fastestLapSpeed" varchar(255) DEFAULT NULL,
  "statusId" int NOT NULL DEFAULT '0',
  PRIMARY KEY ("resultId")
);

DROP TABLE IF EXISTS "seasons";
CREATE TABLE "seasons" (
  "year" int NOT NULL DEFAULT '0',
  "url" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("year")
);

DROP TABLE IF EXISTS "status";
CREATE TABLE "status" (
  "statusId" int NOT NULL,
  "status" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("statusId")
);