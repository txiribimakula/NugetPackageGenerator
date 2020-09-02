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

$newVersion = AskForVersion $nuspecPath $majorV $minorV $patchV
SetVersion $nuspecPath $newVersion