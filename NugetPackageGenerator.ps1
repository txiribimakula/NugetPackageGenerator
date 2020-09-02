param (
    [switch]$debug,
    [switch]$local
)

Import-Module -Name ".\NugetPackageGenerator.psm1"

$localPath = "C://localPath"
$serverPath = "//serverPath"

$files = 
    "fileName1",
    "fileName2"

$path
if($local) {
    $path = $localPath
} else {
    $path = $serverPath
}

CopyFiles $files $path $debug

