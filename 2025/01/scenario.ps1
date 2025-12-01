$inputTxt = get-content ".\input.txt"

#Part1
$minDialNo = 0
$maxDialNo = 99
$startingPos = 50
$currentPos = $startingPos
$countOfZeroes = 0

foreach ($line in $inputTxt) {
    $instruction = $line[0]
    switch ($instruction) {
        {$instruction -eq "L"} {
            $currentPos -= (([regex]::Matches($line, '\d+')).value)
            if ($currentPos -lt $minDialNo) {
                do {
                    $currentPos += ($maxDialNo + 1)
                } Until ($currentPos -ge $minDialNo)
            }
            if ($currentPos -eq 0) {$countOfZeroes++}
        }
        {$instruction -eq "R"} {
            $currentPos += (([regex]::Matches($line, '\d+')).value)
            if ($currentPos -gt $maxDialNo) {
                do {
                    $currentPos -= ($maxDialNo + 1)
                } Until ($currentPos -le $maxDialNo)
            }
            if ($currentPos -eq 0) {$countOfZeroes++}
        }
    }
}

write-host "Part 1: $countOfZeroes"

#Part2
$minDialNo = 0
$maxDialNo = 99
$startingPos = 50
$currentPos = $startingPos
$countOfZeroes = 0

foreach ($line in $inputTxt) {
    $instruction = $line[0]
    $turnNumber = (([regex]::Matches($line, '\d+')).value)
    switch ($instruction) {
        {$instruction -eq "L"} {
            $currentPos -= $turnNumber
            if ($currentPos -lt $minDialNo) {
                do {
                    if (($currentPos + $turnNumber) -ne 0) {
                        $countOfZeroes++
                    }
                    $currentPos += ($maxDialNo + 1)
                } Until ($currentPos -ge $minDialNo)
            }
            if ($currentPos -eq 0) {$countOfZeroes++}
        }
        {$instruction -eq "R"} {
            $currentPos += $turnNumber
            if ($currentPos -gt $maxDialNo) {
                do {
                    $countOfZeroes++
                    $currentPos -= ($maxDialNo + 1)
                } Until ($currentPos -le $maxDialNo)
            }
        }
    }
}

write-host "Part 2: $countOfZeroes"
