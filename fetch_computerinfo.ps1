# Script: fetch_computerinfo.ps1
# Date of last revision: 8/18/2020
# Author: Jon Veach
# Purpose: This script will perform basic commands to fetch computer information, then export to a .CSV file to be later imported into the mastersheet for inventory purposes.

# Variables

# Functions

function main {
    $ws_name = (Get-WmiObject -Class Win32_ComputerSystem | Select Name -ExpandProperty Name)
    $ws_ipconf_IPV4 = (Test-Connection -ComputerName (hostname) -Count 1 | Select IPV4Address -ExpandProperty IPV4Address)
    $ws_ipconf_IPV6 = (Test-Connection -ComputerName (hostname) -Count 1 | Select IPV6Address -ExpandProperty IPV6Address)
    $ws_lastUpdate = (Get-WmiObject -Class Win32_QuickfixEngineering | Sort-Object -Property InstalledOn -Descending | Select -First 1 | Select InstalledOn -ExpandProperty InstalledOn)
    $saveLocation = "C:\ProgramData\DiscoverNW\$($ws_name).csv"

    $ObjData += [PSCustomObject]@{
       'Hostname' = $ws_name
       'IPv4' = $ws_ipconf_IPV4
       'IPv6' = $ws_ipconf_IPV6
       'Last_Update' = $ws_lastUpdate
    }

    Export-Csv -InputObject $ObjData -Path $saveLocation -NoTypeInformation
}

# Main

main

# End
