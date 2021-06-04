$Computers = #List of computers here


Out-File -FilePath C:\temp\last-logon.csv -Encoding UTF8
$OutHeaders = "Hostname,LastLogonDate"
Add-Content -Path C:\temp\last-logon.csv -Value $OutHeaders

for ($i = 0; $i -lt $Computers.Count; $i++) {

    $lastLogon = Get-ADComputer -identity $Computers[$i] -Properties * | Select-Object -ExpandProperty LastLogonDate
    $res = $Computers[$i] + "," + $lastLogon
    Add-Content -Path C:\temp\last-logon.csv -Value $res

    $P = ((($i + 1) / $Computers.count) * 100)
    $P = $P -as [int]
    Write-Progress -Activity "Check in progress" -Status "$P% Complete:" -PercentComplete $P;
}
Write-Output "Check completed!"
Read-Host -Prompt "Press Enter to exit"
