Add-Type -AssemblyName System.Web
$ProgressPreference = 'SilentlyContinue'

#Find Game
Write-Output "Attempting to find game path automatically..."

#Native Version
$64 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$32 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$gamePath = (Get-ItemProperty -Path $32, $64 | Where-Object { $_.DisplayName -like "*wuthering*" } | Select InstallPath).PSObject.Properties.Value
$gachaLogPath = $gamePath + '\Wuthering Waves Game\Client\Binaries\Win64\ThirdParty\KrPcSdk_Global\KRSDKRes\KRSDKWebView'
$gachaLogPathExists = Test-Path ($gachaLogPath )
$method = "automatic"

#EGS Version or Fallback to Manual
if (!$gamePath -or !$gachaLogPathExists) {
    $currentUserSID = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
    $muiCachePath = "Registry::HKEY_USERS\$currentUserSID\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache"
    $filteredEntries = (Get-ItemProperty -Path $muiCachePath).PSObject.Properties | Where-Object { $_.Value -like "*wuthering*" }
    if ($filteredEntries.Count -ne 0) {
        $gachaLogPath = ($filteredEntries[0].Name -split 'client-win64-shipping')[0] + "ThirdParty\KrPcSdk_Global\KRSDKRes\KRSDKWebView"
    }
    else {
        $method = "manual"
        Write-Output " "
        Write-Output "Couldn't automatically find game path. Please enter game path manually."
        Write-Output "Ex. E:\Wuthering Waves"
        Write-Output " "
    
        $path = read-host "Game path: "
    
        if ($path) {
            if ($path.EndsWith("Wuthering Waves")) {
                $gamePath = $path
                Write-Output "Manually found game path."
            }
            elseif ($path.EndsWith("Wuthering Waves Game")) {
                $gamePath = $path.replace("Wuthering Waves Game", "")
                Write-Output "Manually found game path."
            }
            else {
                Write-Output "Invalid game path. Please try again."
            }
        }
        else {
            Write-Output "Invalid game path. Please try again."
        }
        $gachaLogPath = $gamePath + '\Wuthering Waves Game\Client\Binaries\Win64\ThirdParty\KrPcSdk_Global\KRSDKRes\KRSDKWebView'
    }
    if (Test-Path ($gachaLogPath + "\debug.log") -PathType Leaf) {
        Write-Output "Finding Gacha Url..."

        Copy-Item -Path ($gachaLogPath + "\debug.log") -Destination ($gachaLogPath + "\debug_copy.log")
        $cacheData = Get-Content ($gachaLogPath + "\debug.log")
        Remove-Item -Path ($gachaLogPath + "\debug_copy.log")
        $cacheDataLines = $cacheData -split '1/0/'
        $url = ""

        for ($i = $cacheDataLines.Length - 1; $i -ge 0; $i--) {
            $line = $cacheDataLines[$i]

            if ($line.Contains("https://aki-gm-resources-oversea.aki-game.net/aki/gacha/index.html#/record")) {
                $url = (($line -split ': "')[1].replace('",', "")) + ("&wa_method=" + $method)

                break
            }
        }

        if ($url) {
            Write-Output " "
            Write-Output $url
            Set-Clipboard -Value $url
            Write-Output " "
            Write-Output "Gacha Url has been saved to clipboard."
        }
        else {
            Write-Output "Unable to find Gacha Url. Please open Convene Records in game."
        }
    }
    else {
        Write-Output "Unable to find Gacha Url. Please open Convene Records in game."
    }
}
