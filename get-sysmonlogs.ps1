{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 function Get-SysmonLogs\
\{\
<#\
.Synopsis\
Get-SysmonLogs\
.DESCRIPTION\
This cmd-let will make it possible to get the logs from sysmon which you can filter and search for malicious activity\
.EXAMPLE\
Get-SysmonLogs\
.EXAMPLE\
get-SysmonLogs | where \{($_.parentImage -like "*office*") -and ($_.CommandLine -like "*powershell*")\}\
#>\
 \
\
\
#Get ID (Process start)\
 \
$events = Get-WinEvent  -LogName "Microsoft-Windows-Sysmon/Operational" | where \{ $_.id -eq 1 \}\
 \
foreach ($event in $events)  \{\
 \
    $ev = $event.Message -split "`r`n"\
\
    $jsons="\{ "\
    foreach ($line in $ev) \{\
        $line=$line -replace "\\\\","\\\\" `\
               -replace "\\\{"," " `\
               -replace "\\\}"," " `\
               -replace '"','\\"' `\
               -replace "`n"," " \
\
        $line=$line -replace '(\\s*[\\w\\s]+):\\s*(.*)', '"$1":"$2",'\
        $jsons = $jsons + $line \} \
\
        $jsons =$jsons + '"blah" : "blah" \}' \
        ConvertFrom-Json -InputObject $jsons \
    \}\
  \
\
\}}