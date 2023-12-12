$directions = get-content "E:\AoC\2021\Day2\a\input.txt" 
#$directions = get-content "E:\AoC\2021\Day2\a\example.txt" 

$xcoord = 0
$ycoord = 0

for ($i=0; $i -lt $directions.count; $i++) {
    $direction = $directions[$i]
    $direction = $direction.split(" ") 
    switch ($direction[0]) {
        'forward' {$xcoord = $xcoord + $direction[1]}
        'down' {$ycoord = $ycoord + $direction[1]}
        'up' {$ycoord = $ycoord - $direction[1]}
    }
}

$total = $xcoord * $ycoord
$total