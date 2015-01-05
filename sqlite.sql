
-- create tables to import

CREATE TABLE country (
  country_code char(2) NOT NULL,
  country_name char(45) NOT NULL
);

CREATE TABLE timezone (
  zone_id integer NOT NULL,
  abbreviation char(6) NOT NULL,
  time_start integer(128) NOT NULL,
  gmt_offset integer(128) NOT NULL,
  dst char(1) NOT NULL
);

CREATE TABLE zone (
  zone_id integer PRIMARY KEY AUTOINCREMENT NOT NULL,
  country_code char(2) NOT NULL,
  zone_name char(35) NOT NULL
);

-- query for current timezone details
SELECT z.country_code, z.zone_name, tz.abbreviation, tz.gmt_offset, tz.dst
FROM `timezone` tz JOIN `zone` z
ON tz.zone_id=z.zone_id
WHERE tz.time_start < strftime('%s','now') AND z.zone_name='America/Los_Angeles'
ORDER BY tz.time_start DESC LIMIT 1;

-- query for current local time
SELECT datetime(strftime('%s','now') + tz.gmt_offset, 'unixepoch') AS local_time
FROM `timezone` tz JOIN `zone` z
ON tz.zone_id=z.zone_id
WHERE tz.time_start < strftime('%s','now') AND z.zone_name='America/Los_Angeles'
ORDER BY tz.time_start DESC LIMIT 1;
