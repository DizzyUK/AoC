$depths = get-content "E:\AoC\2021\Day1\b\input.txt" 

$increasecount = 0
for ($i=0; $i -le $depths.count-4; $i++) {
    $Adepth = [int]$depths[$i] + [int]$depths[$i+1] + [int]$depths[$i+2]
    $Bdepth = [int]$depths[$i+1] + [int]$depths[$i+2] + [int]$depths[$i+3]
    if ($BDepth -gt $ADepth) {$increasecount++}

}

$increasecount