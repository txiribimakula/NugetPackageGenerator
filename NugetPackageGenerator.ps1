param (
    [switch]$debug,
    [switch]$local,
    [int]$majorV,
    [int]$minorV,
    [int]$patchV
)

Import-Module -Name ".\NugetPackageGenerator.psm1"

$nuspecPath = ".\example.nuspec"

$localPath = "C://localPath"
$serverPath = "//serverPath"

$files = 
    "fileName1",
    "fileName2"

if($local) {
    CopyFiles $localPath $files ".*"
} else {
    CopyFiles $serverPath $files ".*"
}

[int]$currentMajorV, [int]$currentMinorV, [int]$currentPatchV = GetVersion $nuspecPath
if($majorV -ne 0 -or $minorV -ne 0 -or $patchV -ne 0) {
    if($minorV) {
        $majorV = $currentMajorV
    } elseif($patchV) {
        $majorV = $currentMajorV
        $minorV = $currentMinorV
    }
} else {
    [int]$majorV = Read-Host "Major version ($currentMajorV)"
    [int]$minorV = Read-Host "Minor version ($currentMinorV)"
    [int]$patchV = Read-Host "Patch version ($currentPatchV)"
}
[string]$preReleaseInfo = Read-Host "Pre-release info"
$newVersion = "" + $majorV + "." + $minorV + "." + $patchV + $preReleaseInfo
