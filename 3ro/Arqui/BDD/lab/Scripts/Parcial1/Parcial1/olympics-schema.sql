DROP DATABASE  IF EXISTS `olympics`;
CREATE DATABASE `olympics` DEFAULT CHARACTER SET utf8mb4;

USE `olympics`;

DROP TABLE IF EXISTS olympics.medal;

CREATE TABLE olympics.medal (
  id INT NOT NULL AUTO_INCREMENT,
  medal_name varchar(50) DEFAULT NULL,
  CONSTRAINT pk_medal PRIMARY KEY (id)
);


DROP TABLE IF EXISTS olympics.noc_region;

CREATE TABLE olympics.noc_region (
  id INT NOT NULL AUTO_INCREMENT,
  noc VARCHAR(5) DEFAULT NULL,
  region_name VARCHAR(200) DEFAULT NULL,
  CONSTRAINT pk_nocregion PRIMARY KEY (id)
);


DROP TABLE IF EXISTS olympics.sport;

CREATE TABLE olympics.sport (
  id INT NOT NULL AUTO_INCREMENT,
  sport_name VARCHAR(200) DEFAULT NULL,
  CONSTRAINT pk_sport PRIMARY KEY (id)
);


DROP TABLE IF EXISTS olympics.city;

CREATE TABLE olympics.city (
  id INT NOT NULL AUTO_INCREMENT,
  city_name varchar(200) DEFAULT NULL,
  CONSTRAINT pk_city PRIMARY KEY (id)
);

DROP TABLE IF EXISTS olympics.event;

CREATE TABLE olympics.event (
  id INT NOT NULL AUTO_INCREMENT,
  sport_id INT DEFAULT NULL,
  event_name VARCHAR(200) DEFAULT NULL,
  CONSTRAINT pk_event PRIMARY KEY (id),
  CONSTRAINT fk_ev_sp FOREIGN KEY (sport_id) REFERENCES olympics.sport (id)
);

DROP TABLE IF EXISTS olympics.games;

CREATE TABLE olympics.games (
  id INT NOT NULL AUTO_INCREMENT,
  games_year INT DEFAULT NULL,
  games_name varchar(100) DEFAULT NULL,
  season varchar(100) DEFAULT NULL,
  CONSTRAINT pk_games PRIMARY KEY (id)
);

DROP TABLE IF EXISTS olympics.games_city;

CREATE TABLE olympics.games_city (
  games_id INT DEFAULT NULL,
  city_id INT DEFAULT NULL,
  CONSTRAINT fk_gci_city FOREIGN KEY (city_id) REFERENCES olympics.city (id),
  CONSTRAINT fk_gci_gam FOREIGN KEY (games_id) REFERENCES olympics.games (id)
);

DROP TABLE IF EXISTS olympics.person;

CREATE TABLE olympics.person (
  id INT NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(500) DEFAULT NULL,
  gender VARCHAR(10) DEFAULT NULL,
  height INT DEFAULT NULL,
  weight INT DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS olympics.person_region;

CREATE TABLE olympics.person_region (
  person_id INT DEFAULT NULL,
  region_id INT DEFAULT NULL,
  CONSTRAINT fk_per_per FOREIGN KEY (person_id) REFERENCES olympics.person (id),
  CONSTRAINT fk_per_reg FOREIGN KEY (region_id) REFERENCES olympics.noc_region (id)
);

DROP TABLE IF EXISTS olympics.person_region;

CREATE TABLE olympics.person_region (
  person_id INT DEFAULT NULL,
  region_id INT DEFAULT NULL,
  CONSTRAINT fk_per_per FOREIGN KEY (person_id) REFERENCES olympics.person (id),
  CONSTRAINT fk_per_reg FOREIGN KEY (region_id) REFERENCES olympics.noc_region (id)
);

DROP TABLE IF EXISTS olympics.games_competitor;

CREATE TABLE olympics.games_competitor (
  id INT NOT NULL AUTO_INCREMENT,
  games_id INT DEFAULT NULL,
  person_id INT DEFAULT NULL,
  age INT DEFAULT NULL,
  CONSTRAINT pk_gamescomp PRIMARY KEY (id),
  CONSTRAINT fk_gc_gam FOREIGN KEY (games_id) REFERENCES olympics.games (id),
  CONSTRAINT fk_gc_per FOREIGN KEY (person_id) REFERENCES olympics.person (id)
);


DROP TABLE IF EXISTS olympics.competitor_event;

CREATE TABLE olympics.competitor_event (
  event_id INT DEFAULT NULL,
  competitor_id INT DEFAULT NULL,
  medal_id INT DEFAULT NULL,
  CONSTRAINT fk_ce_com FOREIGN KEY (competitor_id) REFERENCES games_competitor (id),
  CONSTRAINT fk_ce_ev FOREIGN KEY (event_id) REFERENCES event (id),
  CONSTRAINT fk_ce_med FOREIGN KEY (medal_id) REFERENCES medal (id)
);


COMMIT;