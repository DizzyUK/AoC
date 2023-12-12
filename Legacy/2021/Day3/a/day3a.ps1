$puzzleinput = get-content "E:\AoC\2021\Day3\a\input.txt"
#$puzzleinput = get-content "E:\AoC\2021\Day3\a\example.txt"

$bin0array = [System.Collections.ArrayList]@()
$bin1array = [System.Collections.ArrayList]@()
$bin2array = [System.Collections.ArrayList]@()
$bin3array = [System.Collections.ArrayList]@()
$bin4array = [System.Collections.ArrayList]@()
$bin5array = [System.Collections.ArrayList]@()
$bin6array = [System.Collections.ArrayList]@()
$bin7array = [System.Collections.ArrayList]@()
$bin8array = [System.Collections.ArrayList]@()
$bin9array = [System.Collections.ArrayList]@()
$bin10array = [System.Collections.ArrayList]@()
$bin11array = [System.Collections.ArrayList]@()
$bin12array = [System.Collections.ArrayList]@()


foreach ($pinput in $puzzleinput) {
    $bin0array += $pinput[0]
    $bin1array += $pinput[1]
    $bin2array += $pinput[2]
    $bin3array += $pinput[3]
    $bin4array += $pinput[4]
    $bin5array += $pinput[5]
    $bin6array += $pinput[6]
    $bin7array += $pinput[7]
    $bin8array += $pinput[8]
    $bin9array += $pinput[9]
    $bin10array += $pinput[10]
    $bin11array += $pinput[11]
}

if (($bin0array | sort-object | group)[0].count -gt ($bin0array | sort-object | group)[1].count) { $gamma12 = "0"; $epsilon12 = "1" } ELSE { $gamma12 = "1"; $epsilon12 = "0" }
if (($bin1array | sort-object | group)[0].count -gt ($bin1array | sort-object | group)[1].count) { $gamma11 = "0"; $epsilon11 = "1" } ELSE { $gamma11 = "1"; $epsilon11 = "0" }
if (($bin2array | sort-object | group)[0].count -gt ($bin2array | sort-object | group)[1].count) { $gamma10 = "0"; $epsilon10 = "1" } ELSE { $gamma10 = "1"; $epsilon10 = "0" }
if (($bin3array | sort-object | group)[0].count -gt ($bin3array | sort-object | group)[1].count) { $gamma9 = "0"; $epsilon9 = "1" } ELSE { $gamma9 = "1"; $epsilon9 = "0" }
if (($bin4array | sort-object | group)[0].count -gt ($bin4array | sort-object | group)[1].count) { $gamma8 = "0"; $epsilon8 = "1" } ELSE { $gamma8 = "1"; $epsilon8 = "0" }
if (($bin5array | sort-object | group)[0].count -gt ($bin5array | sort-object | group)[1].count) { $gamma7 = "0"; $epsilon7 = "1" } ELSE { $gamma7 = "1"; $epsilon7 = "0" }
if (($bin6array | sort-object | group)[0].count -gt ($bin6array | sort-object | group)[1].count) { $gamma6 = "0"; $epsilon6 = "1" } ELSE { $gamma6 = "1"; $epsilon6 = "0" }
if (($bin7array | sort-object | group)[0].count -gt ($bin7array | sort-object | group)[1].count) { $gamma5 = "0"; $epsilon5 = "1" } ELSE { $gamma5 = "1"; $epsilon5 = "0" }
if (($bin8array | sort-object | group)[0].count -gt ($bin8array | sort-object | group)[1].count) { $gamma4 = "0"; $epsilon4 = "1" } ELSE { $gamma4 = "1"; $epsilon4 = "0" }
if (($bin9array | sort-object | group)[0].count -gt ($bin9array | sort-object | group)[1].count) { $gamma3 = "0"; $epsilon3 = "1" } ELSE { $gamma3 = "1"; $epsilon3 = "0" }
if (($bin10array | sort-object | group)[0].count -gt ($bin10array | sort-object | group)[1].count) { $gamma2 = "0"; $epsilon2 = "1" } ELSE { $gamma2 = "1"; $epsilon2 = "0" }
if (($bin11array | sort-object | group)[0].count -gt ($bin11array | sort-object | group)[1].count) { $gamma1 = "0"; $epsilon1 = "1" } ELSE { $gamma1 = "1"; $epsilon1 = "0" }



$gammabin = $gamma12 + $gamma11 + $gamma10 + $gamma9 + $gamma8 + $gamma7 + $gamma6 + $gamma5 + $gamma4 + $gamma3 + $gamma2 + $gamma1 
$gammadec = [convert]::ToInt32($gammabin, 2)

$epsilonbin = $epsilon12 + $epsilon11 + $epsilon10 + $epsilon9 + $epsilon8 + $epsilon7 + $epsilon6 + $epsilon5 + $epsilon4 + $epsilon3 + $epsilon2 + $epsilon1 
$epsilondec = [convert]::ToInt32($epsilonbin, 2)

$powerconsumption = $gammadec * $epsilondec
write-host "Power Consumption: $powerconsumption"