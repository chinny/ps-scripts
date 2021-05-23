$Computers = #list of computers

foreach ($Computer in $Computers) {
    Copy-Item "C:\temp\anyconnect.msi" -Destination "\\$Computer\c$\temp"
    Invoke-Command -ComputerName $Computer -ScriptBlock { msiexec /package C:\temp\anyconnect.msi /norestart /passive /lvx* c:\temp\ACInstall.log }
}
