$Computers = # Add computer names here


foreach ($Computer in $Computers) {
    Get-Service -Name WinRM -ComputerName $Computer | Set-Service -Status Running
    Copy-Item "C:\temp\amazon-corretto-8.302.08.1-windows-x86-jdk.msi" -Destination "\\$Computer\c$\temp"
    Invoke-Command -ComputerName $Computer -ScriptBlock { $app = Get-WmiObject -Class Win32_Product -Filter "Name = 'Java 8 Update 221'"; $app.uninstall() }
    Invoke-Command -ComputerName $Computer -ScriptBlock { msiexec /package C:\temp\amazon-corretto-8.302.08.1-windows-x86-jdk.msi /norestart /passive /lvx* c:\temp\CorrettoInstall.log }
}
