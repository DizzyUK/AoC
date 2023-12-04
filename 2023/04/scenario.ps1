$inputtxt = get-content ".\input.txt"

#Part1

$totalpoints = 0

foreach ($card in $inputtxt) {
    $cardscore = 0
    [int]$cardno = $card.split(':')[0].split(' ')[1]
    $winningdigits,$ourdigits = $card.split(':')[1].split('|')
    $winningdigits = ($winningdigits | select-string -pattern '\d+' -AllMatches).matches.value
    $ourdigits = ($ourdigits | select-string -pattern '\d+' -AllMatches).matches.value
    foreach ($winningdigit in $winningdigits) {
        if ($ourdigits -contains $winningdigit) {
            if ($cardscore -eq 0) {$cardscore = 1}
            Else {$cardscore = $cardscore * 2}
        }
    }

    $totalpoints += $cardscore 
}

$totalpoints

#part2#

Remove-Variable cardarray -ErrorAction SilentlyContinue
$cardarray = New-Object System.Collections.ArrayList

foreach ($card in $inputtxt) {
    $cardscore = 0
    [int]$cardno = $card.split(':')[0].split(' ')[-1]
    $winningdigits,$ourdigits = $card.split(':')[1].split('|')
    $winningdigits = ($winningdigits | select-string -pattern '\d+' -AllMatches).matches.value
    $ourdigits = ($ourdigits | select-string -pattern '\d+' -AllMatches).matches.value
    foreach ($winningdigit in $winningdigits) {
        if ($ourdigits -contains $winningdigit) {
            $cardscore++
        }
    }
    $cardobj = [pscustomobject]@{
        cardnumber = $cardno
        cardscore = $cardscore
        cardcount = 1
    }
    [void]$cardarray.add($cardobj)
}

foreach ($card in $cardarray) {
    $i = $card.cardnumber
    if (($card.cardscore -gt 0) -and ($i -le $cardarray.Count)) {
        do {
            $cardarray[$i].cardcount = $cardarray[$i].cardcount  + $card.cardcount
            $i++
        } until (($i -ge ($card.cardscore + $card.cardnumber)) -or ($i -ge $cardarray.count))
    }
}

$cardcounttotal = 0
foreach ($card in $cardarray) {
    $cardcounttotal += $card.cardcount
}

$cardcounttotal