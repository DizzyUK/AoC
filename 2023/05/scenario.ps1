$inputtxt = get-content ".\input.txt"
$inputtxt = $inputtxt.split(':')

$fullMap = new-object System.Collections.ArrayList
$startingseeds = new-object System.Collections.ArrayList
$sectionno = -1



function get-sectionoutput ($sectionno,$sourceno) {
    $mapsearch = $fullMap | Where-Object {($_.sectionno -eq $sectionno) -and (($sourceno -ge $_.sourcestart) -and ($sourceno -lt $_.sourceend))}
    
    if (!$mapsearch) {
        $selectionmap = [pscustomobject]@{
            section = ($fullMap | Where-Object {($_.sectionno -eq $sectionno)} | select-object -First 1).section
            sectionno = $sectionno
            destination = $sourceno
            source = $sourceno
            sectionlength = 1
        }
    } Else {
        $selectionmap = [pscustomobject]@{
            section = ($fullMap | Where-Object {($_.sectionno -eq $sectionno)} | select-object -First 1).section
            sectionno = $sectionno
            destination = ($sourceno - $mapsearch.sourcestart) + $mapsearch.destinationstart
            source = $sourceno
            sectionlength = $mapsearch.sourceend - $mapsearch.sourcestart
        }
    }
    return $selectionmap
}

function get-seedtosection ($seedno,$sectionnorequired) {
    $section = 1
    $sourceno = $seedno
    do {

        $sourceno = (get-sectionoutput -sectionno $section -sourceno $sourceno).destination
        $section++

    }until ($section -gt $sectionnorequired)

    return $sourceno
}



foreach ($line in $inputtxt) {

    switch -regex  ($line) {
        '^[a-zA-Z-]+' {
            $section = $matches[0]
            $sectionno += 1
        }
        '\d+' {
            $inputline= ($line | select-string -pattern '\d+' -AllMatches).matches.value

            if ($section -eq "seeds") {
                foreach ($seed in $inputline) {
                    [void]$startingseeds.add([int64]$seed)
                }

            } Else {
                
                [int64]$destinationstart,[int64]$sourcestart,[int64]$locationlength = $inputline[0..2]
                
                $destinationend = $($destinationstart+$locationlength)
                $sourceend = $($sourcestart+$locationlength)
                
                $mappiece = [pscustomobject]@{
                    section = $section
                    sectionno = [int]$sectionno
                    destinationstart = [int64]$destinationstart
                    destinationend = [int64]$destinationend
                    sourcestart = [int64]$sourcestart
                    sourceend = [int64]$sourceend
                }
                [void]$fullMap.add($mappiece)

            }
        }
    }
}

$seedlocations = New-Object System.Collections.ArrayList

foreach ($seed in $startingseeds) {
    $seedlocno = get-seedtosection -seedno $seed -sectionnorequired 7
    $seedlocationmap = [pscustomobject]@{
        seedno = $seed
        seedlocation = $seedlocno
    }
    [void]$seedlocations.add($seedlocationmap)   
}

write-host "Part 1: $(($seedlocations | Sort-Object -Property Seedlocation)[0].seedlocation)"




#Part2#

remove-variable fullmap -ErrorAction SilentlyContinue
remove-variable startingseeds -ErrorAction SilentlyContinue

$fullMap = new-object System.Collections.ArrayList
$startingseeds = new-object System.Collections.ArrayList
$sectionno = -1

foreach ($line in $inputtxt) {

    switch -regex  ($line) {
        '^[a-zA-Z-]+' {
            $section = $matches[0]
            $sectionno += 1
        }
        '\d+' {

            if ($section -eq "seeds") {
                $inputline= ($line | select-string -pattern '\d+ \d+' -AllMatches).matches.value
                foreach ($seedpair in $inputline) {
                    [int64]$seedstart = [int64]$seedpair.split(' ')[0]
                    [int64]$seedlength = [int64]$seedpair.split(' ')[1]
                    $seedrange = [pscustomobject]@{
                        seedstart = [int64]$seedstart
                        seedend = [int64]$seedstart+[int64]$seedlength
                    }
                    [void]$startingseeds.add($seedrange)
                }
            } Else {
                $inputline= ($line | select-string -pattern '\d+' -AllMatches).matches.value
                [int64]$destinationstart,[int64]$sourcestart,[int64]$locationlength = $inputline[0..2]
                
                $destinationend = $($destinationstart+$locationlength)
                $sourceend = $($sourcestart+$locationlength)
                
                $mappiece = [pscustomobject]@{
                    section = $section
                    sectionno = [int]$sectionno
                    destinationstart = [int64]$destinationstart
                    destinationend = [int64]$destinationend
                    sourcestart = [int64]$sourcestart
                    sourceend = [int64]$sourceend
                }
                [void]$fullMap.add($mappiece)

            }
        }
    }
}

$seedlocations = New-Object System.Collections.ArrayList

foreach ($seedrange in $startingseeds) {
    [int64]$seed = $seedrange.seedstart
    do {
        #$startseedloc 

        $seed++
    } until ($seed -gt $seedrange.seedend)
    $seedlocno = get-seedtosection -seedno $seed -sectionnorequired 7
    $seedlocationmap = [pscustomobject]@{
        seedno = $seed
        seedlocation = $seedlocno
    }
    [void]$seedlocations.add($seedlocationmap)   
}

write-host "Part 2: $(($seedlocations | Sort-Object -Property Seedlocation)[0].seedlocation)"




function find-nextfloorbreak ($startno,$endno,$floortocheck) {
    $sectionstart = get-sectionoutput -sectionno $floortocheck -sourceno $startno
    $sectionend = get-sectionoutput -sectionno $floortocheck -sourceno $endno

}