$directions = get-content "E:\AoC\2021\Day2\b\input.txt" 
#$directions = get-content "E:\AoC\2021\Day2\b\example.txt" 

$xcoord = 0
$ycoord = 0
$aim = 0

for ($i=0; $i -lt $directions.count; $i++) {
    $direction = $directions[$i]
    $direction = $direction.split(" ") 
    switch ($direction[0]) {
        'forward' {
            $xcoord = $xcoord + $direction[1]
            $ycoord = $ycoord + ($aim * $direction[1])
        }
        'down' {$aim = $aim + $direction[1]}
        'up' {$aim = $aim - $direction[1]}
    }
}

$total = $xcoord * $ycoord
$total