Add-Type -AssemblyName System.Web
$ProgressPreference = 'SilentlyContinue'

#Find Game
Write-Output "Finding game..."

$launcher = (Get-StartApps  | ?{$_.appid -match "Wuthering Waves\\launcher.exe"}).PSObject.Properties.Value[1]
$gachaLogPath = $launcher.replace("\launcher.exe", "") + '\Wuthering Waves Game\Client\Binaries\Win64\ThirdParty\KrPcSdk_Global\KRSDKRes\KRSDKWebView'

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
        Write-Output $url
    } else {
        Write-Output "Unable to find Gacha Url. Please open Convene Records in game."
    }
} else {
    Write-Output "Unable to find Gacha Url. Please open Convene Records in game."
}