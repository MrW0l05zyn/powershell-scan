<#
.SYNOPSIS
    PowerShell Scan
.DESCRIPTION
    PowerShell tool that performs host discovery via "ping sweep" and performs TCP port scanning. Utility focused on the post-exploitation phase (pillaging / data harvesting).
.PARAMETER Networks
    Specifies the networks, example: 10.0.0, 172.16.0, 192.168.0
.PARAMETER Timeout
    Specifies the timeout (milliseconds)
.PARAMETER OnlyHostUp
    Show only active hosts
.INPUTS
.OUTPUTS
.EXAMPLE
    .\powershellScan.ps1
.EXAMPLE
    .\powershellScan.ps1 -Networks 10.0.0
.EXAMPLE    
    .\powershellScan.ps1 -Networks 10.0.0, 172.16.0, 192.168.0 -OnlyHostUp    
.NOTES
    - Author  : MrW0l05zyn
    - Date    : September 11, 2021
    - Version : 0.1
.LINK
    https://github.com/MrW0l05zyn/powershell-scan
#>

Param (      
    [Parameter()]  
    [string[]] $Networks = @("10.0.0","172.16.0","192.168.0"),
    [int] $Timeout = 1000,
    [switch] $OnlyHostUp = $false
)

# variables
$range = 1..254
$ping = new-object System.Net.NetworkInformation.Ping
[int] $hostCountNetworkUp = 0
[int] $hostCountNetworkDown = 0

# ping sweep
Foreach ($network in $Networks){
    Write-Host ("`n[+] Network: {0}.0/24`n" -f $network) -ForegroundColor Blue
    Foreach ($i in $range) {
        $ip =  $network+'.'+$i.ToString()        
        $pResult = $ping.send($ip, $Timeout)        
        if ($OnlyHostUp) {
            if ($pResult.Status -eq "Success") {
                Write-Host ("`t{0}" -f $ip)
                $hostCountNetworkUp++
            } else {
                $hostCountNetworkDown++
            }
        } else {
            if ($pResult.Status -eq "Success") {
                Write-Host ("`t{0} - Host is up" -f $ip) -ForegroundColor Green
                $hostCountNetworkUp++
            } else {
                Write-Host ("`t{0} - Host is down" -f $ip) -ForegroundColor Red
                $hostCountNetworkDown++
            }            
        }                
    }
    if ($OnlyHostUp) {        
        if ($hostCountNetworkUp -gt 0) {
            Write-Host ("`n`t[-] Total hosts up: {0}" -f $hostCountNetworkUp)
        } else {
            Write-Host ("`t[-] Total hosts up: {0}" -f $hostCountNetworkUp)
        }
    } else {
        Write-Host ("`n`t[-] Total hosts up: {0}" -f $hostCountNetworkUp)
        Write-Host ("`t[-] Total hosts down: {0}" -f $hostCountNetworkDown)
    }
    $hostCountNetworkUp = 0
    $hostCountNetworkDown = 0
}