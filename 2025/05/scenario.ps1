$inputTxt = get-content ".\input.txt"
#$inputTxt = get-content ".\example.txt"

$blankIndex = $inputTxt.IndexOf("")

# Separate into two variables
$beforeBlank = $inputTxt[0..($blankIndex - 1)]
$afterBlank  = $inputTxt[($blankIndex + 1)..($inputTxt.Count - 1)]

#Part1

$freshCount = 0
$ranges = foreach ($range in $beforeBlank) {
    $min,$max = $range.Split("-")
    [PSCustomObject]@{
        Min = [int64]$min
        Max = [int64]$max
    }
}

$ranges = $ranges | Sort-Object Min
$freshList = [System.Collections.ArrayList]::new()
$currentRange = $ranges[0]
for ($i=1; $i -lt $ranges.count; $i++) {
    $nextRange = $ranges[$i]
    if ($nextRange.min -le $currentRange.max + 1) {
        if ($nextRange.max -gt $currentRange.max) {
            $currentRange.Max = $nextRange.Max
        }
    } else {
        [void]$freshList.Add($currentRange)
        $currentRange = $nextRange
    }
}
[void]$freshList.add($currentRange)

foreach ($ingredient in $afterBlank) {
    $value = [int64]$ingredient
    if ($freshList | Where-Object { $value -ge $_.Min -and $value -le $_.Max }) {
        $freshCount++
    }
}

write-host "Part 1: $freshCount"

#Part2


#write-host "Part 2: $pt2RollsCount"
