function CopyFiles([string]$path, [string[]]$files, [string]$extension) {
    foreach ($file in $files) {
        Write-Host "Copy" $path"/"$file
    }
}

function GetVersion([string]$nuspecPath) {
    [xml]$nuspecXml = Get-Content $nuspecPath
    
    $ns = new-object Xml.XmlNamespaceManager $nuspecXml.NameTable
    $ns.AddNamespace("msb", "http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd")
    
    $versionNode = $nuspecXml.SelectSingleNode('//msb:version', $ns)
    
    return $versionNode.InnerText.split('.')
}

function AskForVersion([string]$nuspecPath, [int]$newMajorV, [int]$newMinorV, [int]$newPatchV) {
    [int]$currentMajorV, [int]$currentMinorV, [int]$currentPatchV = GetVersion $nuspecPath

    if($majorV -ne 0 -or $minorV -ne 0 -or $patchV -ne 0) {
        if($minorV) {
            $majorV = $currentMajorV
        } elseif($patchV) {
            $majorV = $currentMajorV
            $minorV = $currentMinorV
        }
    } else {
        [int]$majorV = Read-Host "Major version ($currentMajorV)"
        [int]$minorV = Read-Host "Minor version ($currentMinorV)"
        [int]$patchV = Read-Host "Patch version ($currentPatchV)"
    }
    [string]$preReleaseInfo = Read-Host "Pre-release info"
    
    return "" + $majorV + "." + $minorV + "." + $patchV + $preReleaseInfo
}