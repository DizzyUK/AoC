$inputTxt = get-content ".\input.txt"

#Part1

$leftList = @()
$rightList = @()
foreach ($line in $inputTxt) {
    $leftValue,$rightValue = ($line.split(" ",[System.StringSplitOptions]::RemoveEmptyEntries))
    $leftList += [int]$leftValue
    $rightList += [int]$rightValue
}

$leftList = $leftList | sort-object
$rightList = $rightList | sort-object

$runningTotal = 0
$index = 0
do {
    $runningTotal += [Math]::Abs($leftList[$index] - $rightList[$index])
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