$inputTxt = get-content ".\input.txt"
#$inputTxt = get-content ".\example.txt"

#Part1

function check-neighbours {
    param (
        [System.Collections.ArrayList]$gridLayout,
        [int32]$inputX,
        [int32]$inputY
    )
    $flatGrid = $gridLayout | ForEach-Object {$_}
    $topLeft = ($flatGrid| where-object {($_.x -eq ($inputX -1)) -and ($_.y -eq ($inputY - 1))}).contents
    $topMid = ($flatGrid| where-object {($_.x -eq ($inputX)) -and ($_.y -eq ($inputY - 1))}).contents
    $topRight = ($flatGrid| where-object {($_.x -eq ($inputX +1)) -and ($_.y -eq ($inputY - 1))}).contents
    $midLeft = ($flatGrid| where-object {($_.x -eq ($inputX -1)) -and ($_.y -eq ($inputY))}).contents
    $midRight = ($flatGrid| where-object {($_.x -eq ($inputX +1)) -and ($_.y -eq ($inputY))}).contents
    $bottomLeft = ($flatGrid| where-object {($_.x -eq ($inputX -1)) -and ($_.y -eq ($inputY + 1))}).contents
    $bottomMid = ($flatGrid| where-object {($_.x -eq ($inputX)) -and ($_.y -eq ($inputY + 1))}).contents
    $bottomRight = ($flatGrid| where-object {($_.x -eq ($inputX + 1)) -and ($_.y -eq ($inputY + 1))}).contents
    $countVars = @($topLeft, $topMid, $topRight, $midLeft, $midRight, $bottomLeft, $bottomMid, $bottomRight)
    $count = ($countVars | where-object {$_ -eq "@"}).Count
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
        if ((check-neighbours -grid $flatGrid -inputX $($gridLoc.x) -inputY $($gridLoc.y)) -le 3) {$rollsCount++}
    }
}

write-host "Part 1: $rollsCount"

#Part2

#write-host "Part 2: "
