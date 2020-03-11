. ..\queue\Queue.ps1
#Clustering Algorithm (Xu et. al)
$epsil = .1
$mu = 2

function v-index ( $n) {

for ($i=0; $i -lt $g.vertices.count; $i++) {

    if($g.vertices[$i].value.Key -eq $n) { return $i}

}

return -1   
}

#count neighbors in common 
function friend-count ($i, $j) {
 $vi = $A[$i]
 
 $count=0
 if ($vi -eq $null){ return 0}
 for($k=0; $k -lt $vi.count; $k++) {
   if ($A[$vi[$k]] -contains $j) { #got one
      $count++      
   }
 }
 write-host "Friend count " $i "|" $j "|" $count

 return $count


}

function jacquard($s, $e) {  #jacquard  metric
    $ex = v-index $e.value.Key
    $sx = v-index $s.value.Key
    if($s.value.EdgeCnt -eq 0) { return 0}
    $v=(friend-count $sx $ex) /$s.vaLue.EdgeCnt
   
    return $v

}

function seed ($v ) {


$sn = $v.value.Key
$sx = v-index $sn
#now we just have to see if $v has ge mu neighbors with a greater than <fill in metric> mu value
foreach ($e in $v.getNeighbors()) {

    if ( jacquard $v $e  -ge $mu) {return $true  }
}

return $false

}



function dir-reach ($v) {
$r=@()

foreach ($e in $v.getNeighbors()) {
    if($e.value.Visited -eq 1) {continue}
    if ( jacquard $v $e  -ge $mu) {
        $r+=$e
    }

}
return $r
}

#Let's create a sparse adjacency matrix for the heck of it :-)
$A=@{}

foreach ($v in $g.vertices.Keys) {
   $start = $g.vertices[$v]
   #lets build a row
   $row=@()
   $sx= v-index $start.value.Key
   $ecnt=0
   foreach($n in $start.getNeighbors()) {   
      #get index
       $ex = v-index $n.value.Key
       if($sx -eq $ex) {continue}
       if( $ex -ge 0 ) {
           $row+=$ex    
           $ecnt++   
       } 
   }
   $A[$sx] = $row
   $start.value.EdgeCnt = $ecnt #lets put edge/neighbor count on vertex
}





#Let's Identify Clusters and mark bridges/hubs


#load the queue
$unclassQueue = New-Object Queue
$clustercnt=1
foreach ($k in $g.vertices.Keys) {

    $v=$g.vertices[$K]
    if($v.value.Visted -eq 1) {continue}
    $v.value.Visited=1
    if (seed $v) {
        #now lets extend the seed
        $clustercnt++
        $v.value.Cluster = "Cluster$($clustercnt))"
        $r=dir-reach $v
        #load the queue
        for($i=0;$i -lt $r.count;$i++) {
            $unclassQueue.enqueue($r[$i]) 
        }
        while (!$unclassQueue.isempty()) {
            $currentVertex = $unclassQueue.dequeue()
            if( $currentVertex.Cluster -eq "") {$currentVertex.value.Cluster = "Cluster$($clustercnt))" }
            #add to cluster
            $r=dir-reach $currentVertex
            for($i=0;$i -lt $r.count;$i++) {
                $unclassQueue.enqueue($r[$i]) 
            }
        }
    }


}