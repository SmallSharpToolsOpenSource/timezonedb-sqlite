# Timezone Data

### Import

Create the tables in a SQLite database using the 3 table create statements in
`sqlite.sql`. Then use a tool like SQLite Professional to import the data from
[timezonedb.com](http://www.timezonedb.com).

### Querying

There are 2 sample queries in `sqlite.sql` which show how querying of this
database can be done. Each entry in the database for timezones includes a
time when rule defined came into effect. The one which is current is the first
one before now. The start time is a numerical value in unix time which can
be translated into a date value using datetime as shown below. Note that epoch
time starts at 0 on the first day of 1970. Negative and positive values are
valid.

```sql
select datetime(0, 'unixepoch') as epoch_time;
select datetime(-2147483648, 'unixepoch') as epoch_time;
select datetime(1420255959, 'unixepoch') as epoch_time;
```

### Sources

http://timezonedb.com

http://www.iana.org/time-zones

http://kml4earth.appspot.com/data.html
