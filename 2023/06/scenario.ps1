$TimeInput,$DistanceInput = get-content ".\input.txt"

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