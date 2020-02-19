# Sysmon Visualizaton and Tools (work in progress)
A collection of useful PowerShell tools to collect, organize, and visualize Sysmon event data.
To get going with this, you'll need to:

1. Download Doug Finke's powershell alogithms: https://github.com/dfinke/powershell-algorithms
2. Install GraphViz and PSGraph:

     #install GraphViz from Chocately
     
      Find-Package graphviz | Install-Package -ForceBootstrap
      
     #install module PSGraph 
     
     Find-Module PSGraph | Install-Module
     
     #import module PSGraph
     
     Import-Module PSGraph

3. And finally install and import the delicious PSQuickGraph wrapper:

    Install-Module -Name PSQuickGraph
    
    Import-Module PSQuickGraph
 
 # Then download the Sysmon module and PS scripts
 5. import-module sysmon    
 6.  . .\threat-graph.ps1  # build $g
 7.  .\threat-graph-vi.ps1 # visualize!
 8. Try out threat_search.ps1 and other scripts in repository (random-rater ..)
