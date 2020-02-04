#Let's graph it!!!
$gv = New-Graph -Type BiDirectionalGraph



foreach ($e in $g.getAllEdges() ) {
    $vs= $e.startvertex
    $ve= $e.endvertex
    PSQuickGraph\Add-Edge -From $vs.value.Key -To $ve.value.Key -Graph $gv |Out-Null

}

Show-GraphLayout -Graph $gv

