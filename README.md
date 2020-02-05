# sysmon
A collection of useful PowerShell tools to collect, organize, and visualize Sysmon event data.
To get going with this you'll need to:

1. Download Doug Finke's powershell alogithms: https://github.com/dfinke/powershell-algorithms
2. Install GraphViz and PSGraph:

     #install GraphViz from Chocately
     
      Find-Package graphviz | Install-Package -ForceBootstrap
      
     #install moduel PSGraph 
     
     Find-Module PSGraph | Install-Module
     
     #import module PSGraph
     
     Import-Module PSGraph

3. And finally install and import the delicious PSQuickGraph wrapper:

    Install-Module -Name PSQuickGraph
    
    Import-Module PSQuickGraph
