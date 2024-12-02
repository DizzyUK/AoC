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
        for ($i = 0; $i -lt $readings.count; $i++) {
            if (test-linesafety ($readings | where-object {$readings.IndexOf($_) -ne $i})) {
                $advGoodCounter++
                break
            }
        }
    }
}

write-host "Part 2: $advgoodCounter"