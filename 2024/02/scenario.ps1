$inputTxt = get-content ".\input.txt"

#Part1
$goodCounter = 0
foreach ($line in $inputTxt) {
    [int32[]]$readings = ($line.split(" ",[System.StringSplitOptions]::RemoveEmptyEntries))
    $index = 0
    $readingLevels = [PSCustomObject]@{
        line = $line
        readingSafe = $true
        readingChange = ""
    }
    do {
        $readingDiff = ($readings[$index] - $readings[$index + 1])
        if ($readingDiff -lt 0) {
            if ($readingLevels.readingChange -eq "+") {
                $readingLevels.readingSafe = $false
            }
            $readingLevels.readingChange = "-"
        }
        Elseif ($readingDiff -gt 0) {
            if ($readingLevels.readingChange -eq "-") {
                $readingLevels.readingSafe = $false
            }
            $readingLevels.readingChange = "+"
        }
        Elseif ($readingDiff -eq 0) {$readingLevels.readingSafe =$false}
        if ([Math]::Abs($readingDiff) -gt 3) {$readingLevels.readingSafe = $false}
        if ($readingLevels.readingSafe -eq $false) {Break}
        $index++
    } until ($index -ge ($readings.length -1))
    if ($readingLevels.readingSafe -eq $true) {$goodCounter++}
}

write-host "Part 1: $goodCounter"

#Part2


#write-host "Part 2: $listSimilarity"