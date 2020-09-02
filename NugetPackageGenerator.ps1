param (
    [switch]$debug,
    [switch]$local,
    [int]$majorV,
    [int]$minorV,
    [int]$patchV
)

Import-Module -Name ".\NugetPackageGenerator.psm1"

$nuspecPath = "./file.nuspec"

$localPath = "C://localPath"
$serverPath = "//serverPath"

$files = 
    "fileName1",
    "fileName2"

if($local) {
    CopyFiles $localPath $files $extension
} else {
    CopyFiles $serverPath $files $extension
}
