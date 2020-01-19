function Get-SysmonLogs
{
<#
.Synopsis
Get-SysmonLogs
.DESCRIPTION
This cmd-let will make it possible to get the logs from sysmon which you can filter and search for malicious activity
.EXAMPLE
Get-SysmonLogs
.EXAMPLE
get-SysmonLogs | where {($_.parentImage -like "*office*") -and ($_.CommandLine -like "*powershell*")}
#>
 


#Get ID (Process start)
 
$events = Get-WinEvent  -LogName "Microsoft-Windows-Sysmon/Operational" | where { $_.id -eq 1 }
 
foreach ($event in $events)  {
 
    $ev = $event.Message -split "`r`n"

    $jsons="{ "
    foreach ($line in $ev) {
        $line=$line -replace "\\","\\" `
               -replace "\{"," " `
               -replace "\}"," " `
               -replace '"','\"' `
               -replace "`n"," " 

        $line=$line -replace '(\s*[\w\s]+):\s*(.*)', '"$1":"$2",'
        $jsons = $jsons + $line } 

        $jsons =$jsons + '"blah" : "blah" }' 
        ConvertFrom-Json -InputObject $jsons 
    }
  

}