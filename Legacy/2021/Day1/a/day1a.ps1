$depths = get-content "E:\AoC\2021\Day1\a\input.txt" 
$increasecount = 0
for ($i=1; $i -le $depths.count; $i++) {
    $currentdepth = $depths[$i]
    $lastdepth = $depths[$i-1]
    if ($currentdepth -gt $lastdepth) {$increasecount++}
}

$increasecount