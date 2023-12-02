$inputtxt = get-content ".\input.txt"

#Part1

$totalcount = 0

foreach ($line in $inputtxt) {
    $digits = ($line | select-string -pattern '\d' -AllMatches)
    $firstdigit = $digits.matches[0].Value
    $lastdigit = $digits.matches[-1].Value
    [int]$fullnumber = $firstdigit + $lastdigit
    $totalcount += $fullnumber
}

write-host "$totalcount"



#Part2

$totalcount = 0

foreach ($line in $inputtxt) {
    $digits = ($line | select-string -pattern '(?=(\d|one|two|three|four|five|six|seven|eight|nine))' -AllMatches)
    [string]$firstdigit = $digits.matches[0].groups[1].Value
    [string]$lastdigit = $digits.matches[-1].groups[1].Value

    switch ($firstdigit){
        'one' {$firstdigit = 1}
        'two' {$firstdigit = 2}
        'three' {$firstdigit = 3}
        'four' {$firstdigit = 4}
        'five' {$firstdigit = 5}
        'six' {$firstdigit = 6}
        'seven' {$firstdigit = 7}
        'eight' {$firstdigit = 8}
        'nine' {$firstdigit = 9}
    }
    
    switch ($lastdigit){
        'one' {$lastdigit = 1}
        'two' {$lastdigit= 2}
        'three' {$lastdigit = 3}
        'four' {$lastdigit = 4}
        'five' {$lastdigit = 5}
        'six' {$lastdigit = 6}
        'seven' {$lastdigit = 7}
        'eight' {$lastdigit = 8}
        'nine' {$lastdigit = 9}
    }

    [int]$fullnumber = [string]$firstdigit + [string]$lastdigit
    $totalcount += [int]$fullnumber
}

write-host "$totalcount"