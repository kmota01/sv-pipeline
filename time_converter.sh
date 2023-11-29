#!/bin/bash

#This function converts the time from seconds to a format like days:hours:minutes:seconds

convert_seconds() {

seconds=$1

days=$((seconds / 86400))
hours=$((seconds / 3600))	
minutes=$((seconds / 60))

if [[ $minutes -ge 1 ]]; then
        seconds=$((seconds-minutes*60))
        if [[ $hours -ge 1 ]]; then
                minutes=$((minutes-hours*60))
                if [[ $days -ge 1 ]]; then
                        hours=$((hours-days*24))

                fi
        fi
fi
    
echo "$days days, $hours hours, $minutes "min", $seconds seconds"
}

