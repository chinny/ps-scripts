Get-ADComputer -Filter * -Property * | Select-Object Name,OperatingSystem,OperatingSystemVersion,ipv4Address | Export-CSV ADcomputerslist.csv -NoTypeInformation -Encoding UTF8