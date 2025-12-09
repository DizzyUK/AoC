$inputTxt = get-content ".\input.txt"
#$inputTxt = get-content ".\example.txt"

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

    # $topLeft = ($flatGrid| where-object {($_.x -eq ($inputX -1)) -and ($_.y -eq ($inputY - 1))}).contents
    # $topMid = ($flatGrid| where-object {($_.x -eq ($inputX)) -and ($_.y -eq ($inputY - 1))}).contents
    # $topRight = ($flatGrid| where-object {($_.x -eq ($inputX +1)) -and ($_.y -eq ($inputY - 1))}).contents
    # $midLeft = ($flatGrid| where-object {($_.x -eq ($inputX -1)) -and ($_.y -eq ($inputY))}).contents
    # $midRight = ($flatGrid| where-object {($_.x -eq ($inputX +1)) -and ($_.y -eq ($inputY))}).contents
    # $bottomLeft = ($flatGrid| where-object {($_.x -eq ($inputX -1)) -and ($_.y -eq ($inputY + 1))}).contents
    # $bottomMid = ($flatGrid| where-object {($_.x -eq ($inputX)) -and ($_.y -eq ($inputY + 1))}).contents
    # $bottomRight = ($flatGrid| where-object {($_.x -eq ($inputX + 1)) -and ($_.y -eq ($inputY + 1))}).contents
    # $countVars = @($topLeft, $topMid, $topRight, $midLeft, $midRight, $bottomLeft, $bottomMid, $bottomRight)
    # $count = ($countVars | where-object {$_ -eq "@"}).Count
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


