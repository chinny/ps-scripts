$Computers = # List of machines here


Out-File -FilePath C:\temp\wmi-rpc-results.csv -Encoding UTF8
$OutHeaders = "Hostname,Current IP,SMB Port Open (445),WMI Service,RPC Port Open (135),RPC Service"
Add-Content -Path C:\temp\wmi-rpc-results.csv -Value $OutHeaders

for ($i = 0; $i -lt $Computers.Count; $i++) {

    $a = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter 'IpEnabled=True' -ComputerName $Computers[$i] -ErrorAction SilentlyContinue

    $smbPort = tnc $Computers[$i] -p 445 | Select-Object -ExpandProperty TcpTestSucceeded
    $wmiServ = Get-Service -Name winmgmt -ComputerName $Computers[$i] -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Status
    $rpcPort = tnc $Computers[$i] -p 135 | Select-Object -ExpandProperty TcpTestSucceeded
    $rpcServ = Get-Service -Name rpcss -ComputerName $Computers[$i] -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Status

    $res = $Computers[$i] + "," + $a.IPAddress + "," + $smbPort + "," + $wmiServ + "," + $rpcPort + "," + $rpcServ
    
    Add-Content -Path C:\temp\wmi-rpc-results.csv -Value $res
    $P = ((($i + 1) / $Computers.count) * 100)
    $P = $P -as [int]
    Write-Progress -Activity "Check in progress" -Status "$P% Complete:" -PercentComplete $P;
}
Write-Output "Check completed!"
