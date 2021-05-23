# Hosts File Entry Finder Script v0.01 [5/21/2020] 
# by Jeffrey Chin
# jeffreychin89@gmail.com

# Script to detect entry in \etc\hosts file
# for machines listed in C:\machines.txt.
# Results are printed in CSV format in C:\output.csv

# TODO: 
# 1) Detect when machine is offline -> output "Machine unreachable"
# 2) Output result of presence of hosts file entry as true or false.

$MachineList = @(Get-Content C:\machines.txt)
Clear-Content -Path C:\output.csv
$TableHeaders = "Computer,Results"
Add-Content -Path C:\output.csv -Value $TableHeaders

# hosts file entry to be found:
$FindEntry = testentry

foreach ($computer in  $MachineList)
{

    cd \\$computer\c$\Windows\System32\drivers\etc
    $result = cat hosts | Select-String -pattern $FindEntry

    
    $Content = "{0},{1}" -f $computer,$result
    Add-Content -Path C:\output.csv -Value $Content
}