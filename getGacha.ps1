Add-Type -AssemblyName System.Web
$ProgressPreference = 'SilentlyContinue'

#Find Game
Write-Output "Attempting to find game path automatically..."

$64 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$32 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$gamePath = (Get-ItemProperty -Path $32, $64 | Where-Object { $_.DisplayName -like "*wuthering*" } | Select InstallPath).PSObject.Properties.Value

if (!$gamePath) {
    Write-Output " "
    Write-Output "Couldn't automatically find game path. Please enter game path manually."
    Write-Output "Ex. E:\Wuthering Waves"
    Write-Output " "

    $path = read-host "Game path: "

    if ($path -And $path.ToLower() -like "*wuthering*") {
        $gamePath = $path
        Write-Output "Manually found game path."
    } else {
        Write-Output "Invalid game path. Please try again."
    }
} else {
    Write-Output "Automatically found game path."
}

Write-Output " "

$gachaLogPath = $gamePath + '\Wuthering Waves Game\Client\Binaries\Win64\ThirdParty\KrPcSdk_Global\KRSDKRes\KRSDKWebView'

#Find Gacha Url
Write-Output "Finding Gacha Url..."

if (Test-Path ($gachaLogPath + "\debug.log") -PathType Leaf) {
    Copy-Item -Path ($gachaLogPath + "\debug.log") -Destination ($gachaLogPath + "\debug_copy.log")
    $cacheData = Get-Content ($gachaLogPath + "\debug.log")
    Remove-Item -Path ($gachaLogPath + "\debug_copy.log")
    $cacheDataLines = $cacheData -split '1/0/'
    $url = ""

    for ($i = $cacheDataLines.Length - 1; $i -ge 0; $i--) {
        $line = $cacheDataLines[$i]

        if ($line.Contains("https://aki-gm-resources-oversea.aki-game.net/aki/gacha/index.html#/record")) {
            $url = ($line -split ': "')[1].replace('",', "")
        }
    }

    if ($url) {
        Write-Output " "
        Write-Output $url
        Set-Clipboard -Value $url
        Write-Output " "
        Write-Output "Gacha Url has been saved to clipboard."
    } else {
        Write-Output "Unable to find Gacha Url. Please open Convene Records in game."
    }
} else {
    Write-Output "Unable to find Gacha Url. Please open Convene Records in game."
}