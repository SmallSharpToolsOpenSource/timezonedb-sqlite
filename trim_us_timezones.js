
var fs = require('fs');

var timezones = require('./us_timezones_all.json');

// extract just the current timezone based on start_time which will be
// the most highest value which is less than the current timestamp

var timestamp = Math.floor(Date.now() / 1000);
var data = {};

for (var t=0;t<timezones.length;t++) {
    var timezone = timezones[t];
    var dst = timezone.dst === '1';
    var gmt_offset = parseInt(timezone.gmt_offset, 10);
    var time_start = parseInt(timezone.time_start, 10);

    if (time_start > timestamp) {
        continue;
    }

    if (!data[timezone.zone_name]) {
        data[timezone.zone_name] = {
            dst_abbreviation : '',
            abbreviation : '',
            dst_time_start : 0,
            time_start : 0,
            dst_gmt_offset : 0,
            gmt_offset : 0
        };
    }

    if (dst) {
        if (data[timezone.zone_name].dst_time_start < time_start) {
            data[timezone.zone_name].dst_gmt_offset = gmt_offset;
            data[timezone.zone_name].dst_time_start = time_start;
            data[timezone.zone_name].dst_abbreviation = timezone.abbreviation;
        }
    }
    else {
        if (data[timezone.zone_name].time_start < time_start) {
            data[timezone.zone_name].gmt_offset = gmt_offset;
            data[timezone.zone_name].time_start = time_start;
            data[timezone.zone_name].abbreviation = timezone.abbreviation;
        }
    }
}

var keys = Object.keys(data);

for (var k=0;k<keys.length;k++) {
  var key = keys[k];
  delete data[key].time_start;
  delete data[key].dst_time_start;
}

fs.writeFile("us_timezones.json", JSON.stringify(data, null, 4), function(error) {
    if (error) {
        console.log('Error writing out JSON data: ' + error);
    }
});
