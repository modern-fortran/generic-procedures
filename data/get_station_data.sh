#!/bin/bash

for station in $(cut -d' ' -f1 < stations.txt); do
    echo Getting $station
    url=https://mesonet.agron.iastate.edu/cgi-bin/request/asos.py?station=${station}\&data=all\&year1=2018\&month1=1\&day1=1\&year2=2018\&month2=12\&day2=31\&tz=Etc%2FUTC\&format=onlycomma\&latlon=yes\&direct=yes\&report_type=1\&report_type=2
    curl $url -o raw/${station}.txt
done
