$inputTxt = get-content ".\input.txt"

#Part1
$joltageCount = 0

foreach ($bank in $inputTxt) {
    $bankChars = [char[]]$bank | Sort-Object -Descending
    $highestNo = $bankChars[0]
    $highestNoPos = $bank.IndexOf($highestNo)
    if ($highestNo -eq $bank[-1]) {
        $highestNo = $bankChars[1]
        $highestNoPos = $bank.IndexOf($highestNo)
    }
    $remainingChars = [char[]]$bank[($highestNoPos+1)..($bank.length)] | Sort-Object -Descending
    $secondNo = $remainingChars[0]
    [int32]$fullNumber = [string]$highestNo + [string]$secondNo
    $joltageCount += $fullNumber
}

write-host "Part 1: $joltageCount"

#Part2

function find-number {
    param(
        $bank,
        $startPos,
        $numberToFind
    )
    $numbersLeftToFind = 12 - $numberToFind
    $availableBank = [char[]]$bank[($startPos+1)..($bank.length - ($numbersLeftToFind+1))] 
    $bankChars = $availableBank | Sort-Object -Descending
    $currentPosition = $availableBank.IndexOf($bankChars[0]) + ($startPos+1)
    return $bankChars[0],$currentPosition
}

[int64]$joltageCountPt2 = 0
foreach ($bank in $inputTxt) {
    $i = 0
    $currentNoPos = -1
    [string]$bankJolts = ""
    do {
        $currentNo,$currentNoPos = find-number -bank $bank -startPos $currentNoPos -numberToFind ($i+1)
        $bankJolts = $bankJolts + $currentNo
        $i++
    } until ($i -ge 12)
    $joltageCountPt2 += [int64]$bankJolts
}

write-host "Part 2: $joltageCountPt2"
