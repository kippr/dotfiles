#!/bin/bash
start_date=$1
today=$(date "+%Y-%m-%d")
end_date=${2:-$today}
ms_in_day=86400

currentDateTs=$(date -j -f "%Y-%m-%d" $start_date "+%s")
endDateTs=$(date -j -f "%Y-%m-%d" $end_date "+%s")

start_weekday=$(date -j -f "%s" $currentDateTs "+%u")
if [ "$start_weekday" -gt 5 ]
then
    currentDateTs=$(($currentDateTs+($ms_in_day*(8 - $start_weekday))))
fi


while [ "$currentDateTs" -le "$endDateTs" ]
do
    date=$(date -j -f "%s" $currentDateTs "+%Y-%m-%d")
    echo $date
    weekday=$(date -j -f "%s" $currentDateTs "+%u")
    if [ "$weekday" -eq "5" ]
        then offset=$(($ms_in_day * 3))
        else offset=$ms_in_day
    fi
    currentDateTs=$(($currentDateTs+$offset))
done
