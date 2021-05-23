$Computers = #List of computers here


foreach ($Computer in $Computers)
{
    echo $Computer":"
    (Get-Date) - (Get-CimInstance Win32_OperatingSystem -ComputerName $Computer).LastBootupTime
}

Read-Host -Prompt "Press Enter to exit"