#Requires -Version 4
cls

# Map the various jobs into a hashtable
# Code credit to cdituri
$jobMap = [Ordered]@{
  "DNS"    = "\VMware\set-dns.ps1";
  "NTP"    = "\VMware\set-ntp.ps1";
  "Syslog" = "\VMware\set-syslog.ps1";
  "SSH"    = "\VMware\set-ssh.ps1"
}

# Collect data and send to dashboard
# Code credit to cdituri
$jobMap.Keys | % {
  $scriptPath = Join-Path $PSScriptRoot $jobMap[$_]
  Start-Job -Name "$($_)" -ScriptBlock { Invoke-Expression $args[0] } -ArgumentList $scriptPath
}

Get-Job | Wait-Job
Get-Job | Remove-Job