#need to donwload Doug Finke's PS algorithms
. .\Graph.ps1
. .\GraphVertex.ps1
. .\GraphEdge.ps1

$g = New-Object Graph 1



get-sysmonlogs| %{
   $obj= New-Object -TypeName psobject
   if ($_.OriginalFileName -eq "?") { #fill in name from Image
       $key=$_.Image.Substring($_.Image.lastIndexOf('\') + 1) 
       $obj |add-Member -MemberType NoteProperty -Name Key   -Value $key
   }
   else {$obj |add-Member -MemberType NoteProperty -Name Key   -Value $_.OriginalFileName}
   $obj |add-Member -MemberType NoteProperty -Name Pid   -Value $_.ProcessId
   $obj |add-Member -MemberType NoteProperty -Name PPid  -Value $_.ParentProcessId
   $obj |add-Member -MemberType NoteProperty -Name Weight  -Value 0

   
   if (!$_.CommandLine -contains $_.OriginalFileName) {
      $cl = $_.OriginalFileName +" " + $_.CommandLine
      $obj |add-Member -MemberType NoteProperty -Name Cline -Value $cl 
   }
   else {$obj |add-Member -MemberType NoteProperty -Name Cline -Value $_.CommandLine}
   $pkey = $_.ParentImage.Substring($_.ParentImage.lastIndexOf('\') + 1)
   $obj |add-Member -MemberType NoteProperty -Name PKey  -Value $pkey
   $obj |add-Member -MemberType NoteProperty -Name User  -Value $_.User
   
   $Vertex = New-Object GraphVertex $obj
   $g.addVertex($Vertex)|Out-Null
   
   }

 
  #now build edges
  foreach ($v in $g.vertices.Keys) {



      $end = $g.vertices[$v]
      $start = $g.vertices[$end.value.PKey]

   
       if( $start -ne $null ) {
        
            if ($start.findEdge($end) -eq $null) {
                 $edge = New-Object GraphEdge $start,$end,1
                 $g.AddEdge($edge)|Out-Null
            }
           else {
              $e= $start.findEdge($end)
              $e.weight = $e.weight +1
           }
      }
   
  }

  
