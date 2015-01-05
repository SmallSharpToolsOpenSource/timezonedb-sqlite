
select 
	zone.zone_id,
	zone.country_code,
	zone.zone_name,
	timezone.abbreviation,
	timezone.time_start,
	datetime(timezone.time_start, 'unixepoch') as 'date_start',
	timezone.gmt_offset,
	timezone.dst 
from zone, timezone
where 
	zone.zone_id = timezone.zone_id and 
	timezone.time_start > 0 and
	datetime(timezone.time_start, 'unixepoch') < datetime('now') and
	zone.country_code = 'US'
order by zone.zone_name,timezone.time_start
