# Timezone Data

SQLite support for data from [timezonedb.com](http://www.timezonedb.com).

### Import

All data can be downloaded from timezonedb.com and
unzipped here. Then create the tables in a SQLite database using the 3 table
create statements in `sqlite.sql`. Use a tool like
[SQLite Professional](https://itunes.apple.com/us/app/sqlite-professional-sql-database/id586001240?mt=12)
to import the data.

The samples from timezonedb.com are for Postgres while the scripts here are
made for SQLite.

### Querying

There are 2 sample queries in `sqlite.sql` which show how querying of this
database can be done. Each entry in the database for timezones includes a
time when rule defined came into effect. The one which is current is the first
one before now. The start time is a numerical value in unix time which can
be translated into a date value using datetime as shown below. Note that epoch
time starts at 0 on the first day of 1970. Negative and positive values are
valid.

```sql
SELECT DATETIME(0, 'unixepoch') AS epoch_time;
SELECT DATETIME(-2147483648, 'unixepoch') AS epoch_time;
SELECT DATETIME(1420255959, 'unixepoch') AS epoch_time;

SELECT STRFTIME('%s','now') AS unix_time;
```

### Data Extraction

All of the data is quite large and only a subset may be needed. The script
named `us_timezones.sql` is used to extract just US timezones and the query
results can be exported to a JSON file which is then trimmed further with
`trim_us_timezones.js` to make the data file as small as possible and quick
to navigate.

### Sources

http://timezonedb.com

http://www.iana.org/time-zones

http://kml4earth.appspot.com/data.html
