$Computers = #List of computers here


foreach ($Computer in $Computers)
{
    echo $Computer":"
    Get-ADComputer -identity $Computer -Properties * | FT Name, LastLogonDate -Autosize
}

Read-Host -Prompt "Press Enter to exit"