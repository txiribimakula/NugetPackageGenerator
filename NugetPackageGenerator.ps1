param (
    [switch]$debug,
    [switch]$local,
    [int]$majorV,
    [int]$minorV,
    [int]$patchV,
    [string]$notes
)

Import-Module -Name ".\NugetPackageGenerator.psm1"

$nuspec = @{
    Path = ".\example.nuspec";
    Ns = "http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd";
}

$pathOptions = @{
    Local = "C://localPath";
    Server = "//serverPath";
}

$files = 
    "fileName1",
    "fileName2"
 

$path
if($local) {$path = $pathOptions.Local} else {$path = $pathOptions.Server}
$extension
if($debug) {$extension = ".*"} else {$extension = ".dll"}
CopyFiles $path $files $extension

$newVersion = AskForVersion $nuspec $majorV $minorV $patchV
SetVersion $nuspec $newVersion

if(!$notes) { $notes = Read-Host "Release notes" }
SetReleaseNotes $nuspec $notes