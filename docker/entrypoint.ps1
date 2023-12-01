#!/usr/bin/env pwsh

#Get first and second argument and set them up as the AoC year and day for later usage.  Pad Day to always have 2 digits.
$year = $args[0]
$day = $args[1].padleft(2, '0')

Set-Location "/code/$year/$day"

#Run part1.ps1 and part2.ps1 from the above location and output to default while timing them.
$timings = measure-command { ./part1.ps1; ./part2.ps1 | out-default }

#Format the timing so that Shane's script likes it <3
write-host "real`t$($timings.Minutes)m$($timings.Seconds).$('{0:d3}' -f $timings.Milliseconds)s"
