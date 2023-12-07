$inputtxt = get-content ".\input.txt"

function get-cardvalue ($cardinput) {
    switch -Regex ($cardinput) {
        'A' {$value = 14}
        'K' {$value = 13}
        'Q' {$value = 12}
        'J' {$value = 11}
        'T' {$value = 10}
        '\d' {$value = [int]"$cardinput"}
        default {$value = 0}
    }
    return $value
}


function get-handtype ($handlist) {
    $fiveofakind = invoke-command {
        foreach ($card in $handlist.GetEnumerator()) {
            if ($card.value -eq 5) {
                $card | select key,value
            }
        }
    }

    if ($fiveofakind) {
        $outputobj = [PSCustomObject]@{
            Name = "FiveofaKind"
            Score = 7
        }
        return $outputobj
    }

    $fourofakind = invoke-command {
        foreach ($card in $handlist.GetEnumerator()) {
            if ($card.value -eq 4) {
                $card | select key,value
            }
        }
    }

    if ($fourofakind) {
        $outputobj = [PSCustomObject]@{
            Name = "FourofaKind"
            Score = 6
        }
        return $outputobj
    }

    $threeofakind = invoke-command {
        foreach ($card in $handlist.GetEnumerator()) {
            if ($card.value -eq 3) {
                $card | select key,value
            }
        }
    }
    
    $pairs = invoke-command {
        foreach ($card in $handlist.GetEnumerator()) {
            if ($card.value -eq 2) {
                $card | select key,value
            }
        }
    }

    if (($threeofakind) -and ($pairs)) {
        $outputobj = [PSCustomObject]@{
            Name = "FullHouse"
            Score = 5
        }
        return $outputobj
    }
    if (($threeofakind) -and (!$pairs)) {
        $outputobj = [PSCustomObject]@{
            Name = "ThreeofaKind"
            Score = 4
        }
        return $outputobj
    }
    if ($pairs -is [Array]) {
        $outputobj = [PSCustomObject]@{
            Name = "TwoPairs"
            Score = 3
        }
        return $outputobj
    }
    if (($pairs) -and ($pairs -isnot [Array])) {
        $outputobj = [PSCustomObject]@{
            Name = "Pair"
            Score = 2
        }
        return $outputobj
    }
    
    $outputobj = [PSCustomObject]@{
        Name = "HighCard"
        Score = 1
    }
    return $outputobj
}

$inputcardarray = New-Object System.Collections.ArrayList

foreach($hand in $inputtxt) {
    $cards,[int]$bid = ($hand | select-string -pattern '\S+' -AllMatches).matches.value
    
    remove-variable handlist -ErrorAction SilentlyContinue
    $handlist = @{}
    $handlist.add('A',0)
    $handlist.add('K',0)
    $handlist.add('Q',0)
    $handlist.add('J',0)
    $handlist.add('T',0)
    $handlist.add('9',0)
    $handlist.add('8',0)
    $handlist.add('7',0)
    $handlist.add('6',0)
    $handlist.add('5',0)
    $handlist.add('4',0)
    $handlist.add('3',0)
    $handlist.add('2',0)

    Remove-Variable cardhand -ErrorAction SilentlyContinue
    $cardhand = New-Object System.Collections.ArrayList

    $cardpos = 0
    do {
        $cardobj = [pscustomobject]@{
            cardpos = $cardpos
            card = $cards[$cardpos]
            cardvalue = get-cardvalue -cardinput $cards[$cardpos]
        }
        $handlist["$($cardobj.card)"]++
        [void]$cardhand.add($cardobj)
        $cardpos++
    }until ($cardpos -ge $cards.length)

    $handtype = get-handtype -handlist $handlist
    $handobj = [pscustomobject]@{
        typeofhand=$handtype.name
        score=$handtype.score
        cardzerovalue=$cardhand[0].cardvalue
        cardonevalue=$cardhand[1].cardvalue
        cardtwovalue=$cardhand[2].cardvalue
        cardthreevalue=$cardhand[3].cardvalue
        cardfourvalue=$cardhand[4].cardvalue
        hand=$cardhand
        bid=$bid
    }

    [void]$inputcardarray.add($handobj)
}

$inputcardarray | Add-Member "Rank" ""
$i = 1
$inputcardarray = $inputcardarray | sort-object -Property score,cardzerovalue,cardonevalue,cardtwovalue,cardthreevalue,cardfourvalue
$inputcardarray | % {
    $_.rank = $i
    $i++
}

$RunningTotal = 0
$inputcardarray | % {
    $Handtotal = $_.rank * $_.bid
    $RunningTotal += $handtotal
}

write-host "Part 1: $RunningTotal"

