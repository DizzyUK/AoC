$inputTxt = get-content ".\input.txt"
$lines = $inputTxt.split(',')

function split-matchno {
    param(
        [String]$number
    )
    if ($number.length % 2 -eq 0) {
        $half1 = $Number.Substring(0,($Number.length/2))
        $half2 = $Number.Substring(($Number.length/2))
        if ($half1 -eq $half2) {
            return $true
        }
    } else {
        return $false
    }
}


#Part1
[int64]$invalidIDs = 0

foreach ($line in $lines) {
    [int64]$i,[int64]$sequenceEnd = (([regex]::Matches($line, '\d+')).value)
    do {
        if (split-matchno $i) {$invalidIDs += $i}
        $i++
    } until ($i -gt $sequenceEnd)
}

write-host "Part 1: $invalidIDs"

#Part2
[int64]$invalidIDsPt2 = 0

foreach ($line in $lines) {
    [int64]$i,[int64]$sequenceEnd = (([regex]::Matches($line, '\d+')).value)
    do {
        if (([regex]::Matches($i, '^(\d+)\1+$')).value) {$invalidIDsPt2 += $i}
        $i++
    } until ($i -gt $sequenceEnd)
}

write-host "Part 2: $invalidIDsPt2"
