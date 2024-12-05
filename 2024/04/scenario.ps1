$inputTxt = get-content ".\input.txt"

#Part1
$target = "XMAS"
$part1 = 0
for ($y = 0; $y -lt $inputTxt.count ; $y++) {
    for ($x = 0; $x -lt $inputTxt[$y].length; $x++) {
        if ($inputTxt[$y][$x] -eq 'X') {
            if ($x -ge 3) { #Check Left
                if ($inputTxt[$y][$x..($x-3)] -join("") -eq $target) {
                    $part1++
                }
            }
            if (($x+3) -le $inputTxt[$y].length) { #Check Right
                if ($inputTxt[$y][$x..($x+3)] -join("") -eq $target) {
                    $part1++
                }
            }
            if (($y+3) -le ($inputTxt.count -1)) { #Check Down
                if ($inputTxt[$y][$x] + $inputTxt[($y+1)][$x] + $inputTxt[($y+2)][$x] + $inputTxt[($y+3)][$x] -eq $target) {
                    $part1++
                }
            }
            if (($y) -ge 3) { #Check Up
                if ($inputTxt[$y][$x] + $inputTxt[($y-1)][$x] + $inputTxt[($y-2)][$x] + $inputTxt[($y-3)][$x] -eq $target) {
                    $part1++
                }
            }
            if (($x -ge 3) -and ($y -ge 3)) { #Check Up-Left
                if ($inputTxt[$y][$x] + $inputTxt[($y-1)][($x-1)] + $inputTxt[($y-2)][($x-2)] + $inputTxt[($y-3)][($x-3)] -eq $target) {
                    $part1++
                }
            }
            if ((($x+3) -le $inputTxt[$y].length) -and ($y -ge 3)) { #Check Up-Right
                if ($inputTxt[$y][$x] + $inputTxt[($y-1)][($x+1)] + $inputTxt[($y-2)][($x+2)] + $inputTxt[($y-3)][($x+3)] -eq $target) {
                    $part1++
                }
            }
            if (($x -ge 3) -and (($y+3) -le ($inputTxt.count -1))) { #Check Down-Left
                if ($inputTxt[$y][$x] + $inputTxt[($y+1)][($x-1)] + $inputTxt[($y+2)][($x-2)] + $inputTxt[($y+3)][($x-3)] -eq $target) {
                    $part1++
                }
            }
            if ((($x+3) -le $inputTxt[$y].length) -and (($y+3) -le ($inputTxt.count -1))) { #Check Down-Right
                if ($inputTxt[$y][$x] + $inputTxt[($y+1)][($x+1)] + $inputTxt[($y+2)][($x+2)] + $inputTxt[($y+3)][($x+3)] -eq $target) {
                    $part1++
                }
            }
        }
    }
}

write-host "Part 1: $part1"

#Part2

$inputTxt = get-content ".\input.txt"

$part2 = 0
for ($y = 0; ($y -lt ($inputTxt.count-1)) ; $y++) {
    for ($x = 0; ($x -lt ($inputTxt[$y].length -1)); $x++) {
        if ($inputTxt[$y][$x] -eq 'A') {

            if (($x -ge 1) -and ($y -ge 1) -and (($x+1) -lt $inputTxt[$y].length) -and (($y+1) -lt ($inputTxt.count))) {
                $topLeftLetter = $inputTxt[($y -1)][($x -1)]
                $topRightLetter = $inputTxt[($y-1)][($x+1)]
                $bottomRightLetter = $inputTxt[($y+1)][($x+1)]
                $bottomLeftLetter = $inputTxt[($y+1)][($x-1)]
                if (((($topLeftLetter -eq "M") -and ($bottomRightLetter -eq "S")) -or ((($topLeftLetter -eq "S") -and ($bottomRightLetter -eq "M")))) -and ((($topRightLetter -eq "M") -and ($bottomLeftLetter -eq "S")) -or (($topRightLetter -eq "S") -and ($bottomLeftLetter -eq "M")))) {
                    $part2++
                }
            }
        }
    }
}

write-host "Part 2: $part2"