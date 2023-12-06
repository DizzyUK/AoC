#!/usr/bin/env bash

set -eo pipefail

#Get first and second argument and set them up as the AoC year and day for later usage.
YEAR="${1}"
DAY="${2}"

if [ -e "/code/${YEAR}/`printf %02d $DAY`/" ]; then
    #Set location and pad day to 2 digits.
    cd /code/${YEAR}/`printf %02d $DAY`/

    #Run part1.ps1 and part2.ps1 from the above location and output to default while timing them.
    time pwsh -command "./scenario.ps1"
fi;