param (
    [switch]$debug,
    [switch]$local,
    [int]$majorV=-1,
    [int]$minorV=-1,
    [int]$patchV=-1
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

$version = GetVersion $nuspecPath