$inputtxt = get-content ".\input.txt"

$totalcount = 0

foreach ($line in $inputtxt) {
    $digits = ($line | select-string -pattern '\d' -AllMatches)
    $firstdigit = $digits.matches[0].Value
    $lastdigit = $digits.matches[-1].Value
    [int]$fullnumber = $firstdigit + $lastdigit
    $totalcount += $fullnumber
}

write-host "$totalcount"