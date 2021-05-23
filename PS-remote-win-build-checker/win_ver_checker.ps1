$Computers = # List of machines here


Out-File -FilePath C:\temp\verResults.csv -Encoding UTF8
$OutHeaders = "Hostname,OS Build"
Add-Content -Path C:\temp\verResults.csv -Value $OutHeaders

for ($i = 0; $i -lt $Computers.Count; $i++) {
    $verResult = (Get-WmiObject Win32_OperatingSystem -ComputerName $Computers[$i] -ErrorAction SilentlyContinue).Version
    if ($verResult -eq $null) {
        $res = $Computers[$i] + ", Error"
    }
    else {
        $res = $Computers[$i] + "," + $verResult
    }
    Add-Content -Path C:\temp\verResults.csv -Value $res
    $P = ((($i + 1) / $Computers.count) * 100)
    $P = $P -as [int]
    Write-Progress -Activity "Check in progress" -Status "$P% Complete:" -PercentComplete $P;
}
Write-Output "Check completed!"
