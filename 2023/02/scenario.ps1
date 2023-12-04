$inputtxt = get-content ".\input.txt"

#Rules

$redrule = 12
$greenrule = 13
$bluerule = 14

#Parse Puzzle Input

$matchinput = @{}

foreach ($game in $inputtxt) {
    [int]$gameno = $game.split(':')[0].split(' ')[1]
    $sets = $game.split(':')[1].split(';')
    $gamecubes = @{}
    $setno = 0
    foreach ($set in $sets) {
        $set = $set.split(',').trim()
        $setcubes = @{}
        foreach($cubegrp in $set) {
            $grpsplit = $cubegrp.split(' ')
            $setcubes.add($grpsplit[1],[int]$grpsplit[0])
        }
        
        $gamecubes.add($setno,$setcubes)
        $setno++
    }
    $matchinput.add($gameno,$gamecubes)
}


#### Part1 ####
$legalcount = 0
foreach ($gameplayed in $matchinput.GetEnumerator()) {

    $matchlegal = $true

    foreach ($setplayed in $gameplayed.Value.values) {
        if (($setplayed.red -gt $redrule) -or ($setplayed.blue -gt $bluerule) -or ($setplayed.green -gt $greenrule)) {
            $matchlegal = $false
        }
    }

    if ($matchlegal -eq $true) {
        $legalcount += $gameplayed.name
    }
}

write-host "Part 1: $legalcount"

###############

#### Part2 ####

$totalcubepower = 0
foreach ($gameplayed in $matchinput.GetEnumerator()) {
    $highestblue = 0
    $highestred = 0
    $highestgreen = 0
    foreach ($setplayed in $gameplayed.Value.values) {
        if ($setplayed.blue -gt $highestblue) {$highestblue = $setplayed.blue}
        if ($setplayed.red -gt $highestred) {$highestred = $setplayed.red}
        if ($setplayed.green -gt $highestgreen) {$highestgreen = $setplayed.green}
    }
    $gamecubepwr = $highestblue * $highestred * $highestgreen
    $totalcubepower += $gamecubepwr
}
write-host "Part 2: $totalcubepower"