$Computers = #List of computers here


foreach ($Computer in $Computers)
{
    echo $Computer
    quser /server:$Computer
}

Read-Host -Prompt "Press Enter to exit"