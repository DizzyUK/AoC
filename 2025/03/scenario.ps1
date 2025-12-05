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


#write-host "Part 2: $invalidIDsPt2"
