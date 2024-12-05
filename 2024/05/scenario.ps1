$inputTxt = get-content ".\input.txt"

#Part1
$instructions = @()
$part1 = 0
foreach ($line in $inputTxt) {
    if ($line.contains('|')) {
        $line = $line.split('|')
        $rule = [PSCustomObject]@{
            leftNo = $line[0] 
            rightNo = $line[1]
        }
        $instructions += $rule
    }
    elseif ($line.contains(',')) {
        $line = $line.split(',')
        $lineOK = $true
        for ($i = 1; $i -le ($line.count -1) ; $i++) {
            [int32[]]$followerNos = ($instructions | Where-Object { $_.leftNo -eq $line[$i] }).rightNo
            foreach ($follower in $followerNos) {
                if ($line[0..($i -1)] -contains $follower) {
                    $lineOK = $false
                    break
                }
                
            }
            if ($lineOK -eq $false) {
                break
            }
        }
        if ($lineOK -eq $true) {
            $part1 = $part1 + $line[($line.count-1)/2]
        }
    }
}

write-host "Part 1: $part1"

#Part2



#write-host "Part 2: $part2"