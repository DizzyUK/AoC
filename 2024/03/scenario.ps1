$inputTxt = get-content ".\input.txt"

function get-calc {
    Param (
        [string]$operation,
        [int32]$firstNo,
        [int32]$secondNo
    )
    if ($operation -eq "mul") {$firstNo * $secondNo}
}

#Part1
$validInputPattern = 'mul\(\d{1,3},\d{1,3}\)'
$part1 = 0
foreach ($line in $inputTxt) {
    [string[]]$instructions = [regex]::Matches($line, $validInputPattern)
    foreach ($instruction in $instructions) {
        $operation = $instruction.substring(0,3)
        $numbers = ([regex]::Matches($instruction, '\d{1,3}')).value
        $part1 += get-calc -operation $operation -firstNo $numbers[0] -secondNo $numbers[1]
    }   
}

write-host "Part 1: $part1"

#Part2

$removalPattern = "don't\(\).*?(do\(\)|$)"
$validInputPattern = 'mul\(\d{1,3},\d{1,3}\)'
$part2 = 0
[string]$inputStr = ($inputTxt -replace "`r`n", "")
[string[]]$forRemoval = [regex]::Matches($inputStr, $removalPattern)
if ($forRemoval) {
    foreach ($stringToRemove in $forRemoval) {
        $inputStr = $inputStr.replace($stringToRemove,"")
    }
}
[string[]]$instructions = [regex]::Matches($inputStr, $validInputPattern)
foreach ($instruction in $instructions) {
    $operation = $instruction.substring(0,3)
    $numbers = ([regex]::Matches($instruction, '\d{1,3}')).value
    $part2 += get-calc -operation $operation -firstNo $numbers[0] -secondNo $numbers[1]
}   


write-host "Part 2: $part2"