$inputTxt = get-content ".\input.txt"

#Part1

$leftList = @()
$rightList = @()

foreach ($line in $inputTxt) {
    $leftValue,$rightValue = ($line | select-string -pattern '(\d+)' -AllMatches).matches.value
    $leftList += [int]$leftValue
    $rightList += [int]$rightValue

}

$leftList = $leftList | sort-object
$rightList = $rightList | sort-object

$runningTotal = 0
$index = 0
do {
    if ($leftList[$index] -gt $rightList[$index]) {$runningTotal += ($leftList[$index] - $rightList[$index])}
    if ($leftList[$index] -lt $rightList[$index]) {$runningTotal += ($rightList[$index] - $leftList[$index])}
    $index++
} until ($index -eq $leftList.length)

write-host "Part 1: $runningTotal"

#Part2

$listSimilarity = 0
$counts = @{}

foreach ($item in $rightList) {
    if ($counts.ContainsKey($item)) {
        $counts[$item]++
    } else {
        $counts[$item] = 1
    }
}

foreach ($line in $leftList) {
    if ($counts.ContainsKey($line)) {
        $listSimilarity += ($line * $counts.$line)
    }
}

write-host "Part 2: $listSimilarity"