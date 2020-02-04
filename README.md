# sysmon
A collection of useful PowerShell tools to collect, organize, and visualize Sysmon event data
To get going with this you'll need to:

1. Download Doug Finke's powershell alogithms: https://github.com/dfinke/powershell-algorithms
2. Install GraphViz and PSGraph:
      # Install GraphViz from the Chocolatey repo
      Find-Package graphviz | Install-Package -ForceBootstrap

      # Install PSGraph from the Powershell Gallery
     Find-Module PSGraph | Install-Module

     # Import Module
     Import-Module PSGraph

3. And finally install the delicious PSQuickGraph wrapper
    Install-Module -Name PSQuickGraph	
