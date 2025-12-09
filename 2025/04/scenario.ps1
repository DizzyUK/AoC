$inputTxt = get-content ".\input.txt"

#Part1

function check-neighbours {
    param (
        [System.Collections.ArrayList]$grid,
        [int32]$inputX,
        [int32]$inputY
    )

    foreach ($xShift in -1..1) {
        foreach ($yShift in -1..1) {
            if (($xShift -eq 0) -and ($yShift -eq 0)) {continue}
            $cellX = $inputX + $xShift
            $cellY = $inputY + $yShift
            if ((($cellX -ge 0) -and ($cellY -lt $grid.count)) -and (($cellY -ge 0) -and ($cellN -lt $grid[$cellY].count))) {
                if ($grid[$cellY][$cellX].contents -eq "@") {
                    $count++
                }
            }
        }
    }
    return $count
}

$y = 0
$gridLayout = [System.Collections.ArrayList]::new()
do {
    $row = $inputTxt[$y]
    $x = 0
    $rowLayout = [System.Collections.ArrayList]::new()
    do {
        $locationObj = [PSCustomObject]@{
            x        = $x
            y        = $y
            contents = $row[$x]
        }
        [void]$rowLayout.add($locationObj)
        $x++
    } Until ($x -ge $row.length)
    [void]$gridLayout.add($rowLayout)
    $y++
} until ($y -ge $inputTxt.count)

$rollsCount = 0
$flatGrid = $gridLayout | ForEach-Object {$_}
foreach ($gridLoc in $flatgrid) {
    if ($gridLoc.contents -eq "@") {
        if ((check-neighbours -grid $gridLayout -inputX $($gridLoc.x) -inputY $($gridLoc.y)) -le 3) {$rollsCount++}
    }
}

write-host "Part 1: $rollsCount"

#Part2
$pt2RollsCount = 0
do {
    $loopDif = $pt2RollsCount
    foreach ($gridLoc in $flatgrid) {
        if ($gridLoc.contents -eq "@") {
            if ((check-neighbours -grid $gridLayout -inputX $($gridLoc.x) -inputY $($gridLoc.y)) -le 3) {
                $gridLoc.contents = "x"
                $pt2RollsCount++
            }
        }
    }
} until (($pt2RollsCount - $loopDif) -eq 0)

write-host "Part 2: $pt2RollsCount"
