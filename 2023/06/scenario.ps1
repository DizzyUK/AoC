$TimeInput,$DistanceInput = get-content ".\input.txt"

function get-winningrange ([int64]$Racetime,[int64]$Racerecord) {
    [int64]$lowfailures = -1
    do {
        [void][int64]$lowfailures++
        [int64]$traveltime = $racetime - $lowfailures
        [int64]$traveldistance = $traveltime * $lowfailures
    } until ($traveldistance -gt $racerecord)

    [int64]$highfailures = $racetime+1
    do {
        [void][int64]$highfailures--
        [int64]$traveltime = $racetime - $highfailures
        [int64]$traveldistance = $traveltime * $highfailures
    } until ($traveldistance -gt $racerecord)

    [int64]$totalwins = ($highfailures - $lowfailures) +1
    return $totalwins
}


$RaceTime = ($TimeInput | select-string -pattern '\d+' -AllMatches).matches.value
$RaceRecord = ($DistanceInput | select-string -pattern '\d+' -AllMatches).matches.value

$Racecounter = 1

$racevictories = new-object System.Collections.ArrayList

do {
    
    $winningoptions = 0

    $raceoptions = 0..$racetime[$racecounter-1]
    foreach ($raceoption in $raceoptions) {
        $traveltime = $racetime[$racecounter-1] - $raceoption
        $traveldistance = $traveltime * $raceoption
        if ($traveldistance -gt [int]$racerecord[$racecounter-1]) {
            $winningoptions++
        }
    }
    [void]$racevictories.add($winningoptions)

    $racecounter++

}until($racetime.Length -lt $racecounter)

$Command=$racevictories -join "*";
$Result=Invoke-Expression -Command $Command;
write-host "Part 1: $result"

#Part2#

[int64]$LongRaceTime = ($TimeInput.replace(' ','') | select-string -pattern '\d+' -AllMatches).matches.value
[int64]$LongRaceRecord = ($DistanceInput.replace(' ','') | select-string -pattern '\d+' -AllMatches).matches.value

$longwinningoptions = get-winningrange -Racetime $longracetime -Racerecord $longracerecord
write-host "Part 2: $longwinningoptions"