. ..\queue\Queue.ps1
#find anomalies - variation of BADGraph


function extend-subgraph($v, $t) {

  
$vertexQueue = New-Object Queue
$vertexQueue.enqueue($v)
$h=$v.value.Weight
$s=@() #subgraph
$s+=$v

$gotit=$false
 while (!$vertexQueue.isEmpty()) {
    $currentVertex = $vertexQueue.dequeue()
    
    $es= $currentVertex.getEdges()
    $extend=$false
    foreach($e in $es) {
                
        $ev= $e.endVertex
                      
       # if ( (($h + $ev.value.Weight) -gt .05*$GW) -and ($s.count -ne 1) -and ($h/$s.count -le $th) -and $extend) {  
       if ( ($h+ $ev.value.weight)/($s.count+1) -le $th ) {
           $s+=$ev
           $h =$h + $ev.value.weight         
           
           #queue it up     
           $vertexQueue.enqueue($ev) 
        }
       
     }

 }
 if($s.count -ge 2) {
     $global:mset.Add($s)|Out-Null
 }
 


}



$AW=0
$GW=0
#$ms = @() #list of abnormal sub-graphs
$mset = [System.Collections.ArrayList]@()

#calculate total "weight"
foreach ($e in $g.getAllEdges() ) {
    $GW = $GW + $e.weight
}

write-host "Weight of Graph: " $GW
$AW = $GW / $g.vertices.count
write-host "Average weight per vertex: " $AW


#assign weight to vertices
for ($i=0; $i -lt $g.vertices.count; $i++) {
  
  $w=0
  $v=$g.vertices[$i]
  foreach($e in $v.getEdges()) {
      if($e -eq $null) {continue}
      $w=$w + $e.weight
  }
  $v.value.Weight = $w

}


#Lets hunt for anomalies
$th=[single]($AW)*3  #threshold value

foreach ($k in $g.vertices.Keys) {

   
   $v=$g.vertices[$k]
   #worthy candidates  
   extend-subgraph $v $th 
      
}

for($i=0; $i -lt $mset.count; $i++) {
   write-host "---Subgraph" $i
   $w=0
   for($j=0; $j -lt $mset[$i].count; $j++) {
      write-host "------ "$mset[$i][$j].value.Key
      $w=$mset[$i][$j].value.Weight + $w

   }
   $a=$w/$mset[$i].count
   write-host "------ " "Weight:" $w  "Average weight:" $a
}




