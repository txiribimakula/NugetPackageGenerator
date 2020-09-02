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

[xml]$nuspecXml = Get-Content $nuspecPath
$ns = new-object Xml.XmlNamespaceManager $nuspecXml.NameTable
$ns.AddNamespace("msb", "http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd")
$versionNode = $nuspecXml.SelectSingleNode('//msb:version', $ns)
Write-Host $versionNode.InnerText