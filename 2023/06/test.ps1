
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
get-winningrange -Racetime $longracetime -Racerecord $longracerecord