Add-Type -AssemblyName System.Web
$ProgressPreference = 'SilentlyContinue'

#Find Game
Write-Output "Finding game..."

$64 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$32 "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$launcher = Get-ItemProperty -Path $64, $32 | Where-Object { $_.DisplayName -like "*wuthering*" }

Write-Output $launcher

#Find Gacha Url