function get-neighbours {
    Param(
        [cmdletbinding()]
        $startposition
    )
    [int]$x,[int]$y = $startposition.split(',')
    
    $output = New-Object System.Collections.ArrayList

    [void]$output.add("$($x-1),$y")
    [void]$output.add("$($x-1),$($y+1)")
    [void]$output.add("$x,$($y+1)")
    [void]$output.add("$($x+1),$($y+1)")
    [void]$output.add("$($x+1),$y")
    [void]$output.add("$($x+1),$($y-1)")
    [void]$output.add("$x,$($y-1)")
    [void]$output.add("$($x-1),$($y-1)")

    return $output

}



$inputtxt = get-content ".\input.txt"
$y = 0

remove-variable numbers -ErrorAction SilentlyContinue
$numbers = new-object System.Collections.ArrayList

remove-variable specs -ErrorAction SilentlyContinue
$specs = new-object System.Collections.ArrayList

foreach ($line in $inputtxt) {
    $nomatches = $line | Select-String -Pattern '\d+' -AllMatches

    foreach ($match in $nomatches.matches) {
        $x = $match.index
        remove-variable coords -ErrorAction SilentlyContinue
        $coords = new-object system.collections.arraylist

        do {
            $coord = "$x,$y"
            [void]$coords.add($coord)
            $x++
        }until($x -eq ($match.index + $match.length))

        $matchobj = @{}
        $matchobj.add($match.value,$coords)
        [void]$numbers.add($matchobj)
    }

    $specmatches = $line | Select-String -Pattern '[^\d\.]' -AllMatches

    foreach ($match in $specmatches.matches) {
        $coord = "$($match.index),$y"
        $matchobj = @{}
        $matchobj.add($match.value,$coord)
        [void]$specs.add($matchobj)
    }

    $y++
}


$foundnumber = 0

foreach ($char in $specs) {

    $neighbours = get-neighbours -startposition $($char.values)

    foreach ($number in $numbers) {
        foreach ($neighbour in $neighbours) {
            if ($number.values.contains($neighbour)) {
                $foundnumber += [int]"$($number.keys)"
                break
            }
        }
    }
}

$foundnumber




#Day2#
$totalgearratio = 0

foreach ($char in $specs) {

    Remove-Variable gearnos -ErrorAction SilentlyContinue
    $gearnos = New-Object System.Collections.ArrayList

    $neighbours = get-neighbours -startposition $($char.values)

    foreach ($number in $numbers) {
        foreach ($neighbour in $neighbours) {
            if ($number.values.contains($neighbour)) {

                [void]$gearnos.add([int]"$($number.keys)")
                break
            }
        }
    }

    if ($gearnos.count -eq 2) {
        $gearratio = $gearnos[0] * $gearnos[1]
        $totalgearratio += $gearratio
    }
}

$totalgearratio