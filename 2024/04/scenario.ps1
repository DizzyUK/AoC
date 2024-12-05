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


#write-host "Part 2: $part2"