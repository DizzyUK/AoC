$inputTxt = get-content ".\input.txt"
function test-linesafety {
    Param (
        [int32[]]$readings
    )
    $readingLevels = [PSCustomObject]@{
        line = $line
        readingSafe = $true
        readingChange = ""
    }

    $index = 0
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
        if ($readingLevels.readingSafe -eq $false) {return $false}
        $index++
    } until ($index -ge ($readings.length -1))
    return $true
}

#Part1

$goodCounter = 0
foreach ($line in $inputTxt) {
    [int32[]]$readings = ($line.split(" ",[System.StringSplitOptions]::RemoveEmptyEntries))
    if (test-linesafety $readings) {$goodCounter++}
}

write-host "Part 1: $goodCounter"

#Part2

$advGoodCounter = 0
foreach ($line in $inputTxt) {
    [System.Collections.Generic.List[int]]$readings = ($line.split(" ",[System.StringSplitOptions]::RemoveEmptyEntries))
    if (test-linesafety $readings) {
        $advGoodCounter++
        continue
    }
    else {
        $i = 0
        do {
            if ($i -eq 0) {$tempReadings = $readings[1..($readings.count - 1)] }
            elseif (($i -gt 0) -and ($i -lt ($readings.count - 1))) {$tempReadings = $readings[0..($i - 1)] + $readings[($i + 1)..($readings.count - 1)]}
            else {$tempReadings = $readings[0..($readings.count -2)]}
            if (test-linesafety $tempReadings) {
                $advGoodCounter++
                break
            }
            $i++
        } until ($i -ge $readings.count)
    }
}

write-host "Part 2: $advGoodCounter"