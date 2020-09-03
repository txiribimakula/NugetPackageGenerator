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
 

$inputData = GetInputData $local $pathOptions $debug $nuspec $majorV $minorV $patchV

CopyFiles $inputData.Path $files $inputData.Extension

SetVersion $nuspec $inputData.Version

SetReleaseNotes $nuspec $inputData.ReleaseNotes