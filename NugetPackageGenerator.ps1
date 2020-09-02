param (
    [switch]$debug
)

Import-Module -Name ".\NugetPackageGenerator.psm1"

$files = 
    "fileName1",
    "fileName2"

CopyFiles $files $debug