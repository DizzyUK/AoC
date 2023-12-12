#$puzzleinput = get-content "E:\AoC\2021\Day4\a\input.txt"
$puzzleinput = get-content "E:\AoC\2021\Day4\a\example.txt"

$bingocallouts = $puzzleinput[0] -split (",")

$boardno = 1
$bingolinecnt = 1

for ($i=1; $i -eq $directions.count; $i++) {
    $line = $puzzleinput[$i]
    if (!$line) {
        Break
    }
    Else {        
        if ($bingolinecnt -ge 5) {
            $boardno++
            $bingolinecnt = 1
            clear-variable boardline -erroraction SilentlyContinue
            $boardline = new-object -TypeName [PSCustomObject]@{
                LineNumber = $boardlinecnt
                Board = $boardno
            }
            
        }

        foreach ($number in $line) {
            $linenum = new-object -TypeName [PSCustomObject]@{
                LineNumber = $boardlinecnt
                Board = $boardno
                Called = $False
            }
            $boardline += $linenum
        }
        //Need to finish
    }
}








$boardline = new-object -TypeName [PSCustomObject]@{
    LineNumber = $boardlinecnt
    Board = $boardno
}


$boardline = new-object -TypeName [PSCustomObject]@{
        LineNumber = $boardlinecnt
        Board = $boardno
        Called = $False
}