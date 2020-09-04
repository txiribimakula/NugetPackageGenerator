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
$paths = @{
    Local = "C:\localPath";
    Server = "\\serverPath";
}

$inputData = GetInputData $local $paths $debug $nuspec $majorV $minorV $patchV

$files = 
    @{Destination = ".\other-path"; Origin = $inputData.Path + "\relative-path"; Name = "filename" + $inputData.Extension; Condition = $true},
    @{Destination = ".\other-path"; Origin = $inputData.Path + "\relative-path"; Name = "filename" + $inputData.Extension; Condition = $true}

CopyFiles $files
SetVersion $nuspec $inputData.Version
SetReleaseNotes $nuspec $inputData.ReleaseNotes
GeneratePackage