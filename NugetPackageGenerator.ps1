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

$path = @{
    Local = "C://localPath";
    Server = "//serverPath";
}

$files = 
    "fileName1",
    "fileName2"

if($local) {
    CopyFiles $path.Local $files ".*"
} else {
    CopyFiles $path.Server $files ".*"
}

$newVersion = AskForVersion $nuspec $majorV $minorV $patchV
SetVersion $nuspec $newVersion

if(!$notes) { $notes = Read-Host "Release notes" }
SetReleaseNotes $nuspec $notes