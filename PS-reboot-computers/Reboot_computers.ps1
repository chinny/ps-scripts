$Computers = #List of computers here

$RestartCommand = { shutdown /r /t 0 }

foreach ($Computer in $Computers)
{
    Invoke-Command -ComputerName $Computer -ScriptBlock $RestartCommand
}