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

    if($newMajorV -ne 0 -or $newMinorV -ne 0 -or $newPatchV -ne 0) {
        if($minorV) {
            $newMajorV = $currentMajorV
        } elseif($patchV) {
            $newMajorV = $currentMajorV
            $newMinorV = $currentMinorV
        }
    } else {
        if(!([int]$newMajorV = Read-Host "Major version ($currentMajorV)")) { $newMajorV = $currentMajorV}
        if(!([int]$newMinorV = Read-Host "Minor version ($currentMinorV)")) { $newMinorV = $currentMinorV}
        if(!([int]$newPatchV = Read-Host "Patch version ($currentPatchV)")) { $newPatchV = $currentPatchV}
    }
    [string]$preReleaseInfo = Read-Host "Pre-release info"
    
    return "" + $newMajorV + "." + $newMinorV + "." + $newPatchV + $preReleaseInfo
}

function SetVersion([string]$nuspecPath, [string]$newVersion) {
    [xml]$nuspecXml = Get-Content $nuspecPath
    
    $ns = new-object Xml.XmlNamespaceManager $nuspecXml.NameTable
    $ns.AddNamespace("msb", "http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd")
    
    $versionNode = $nuspecXml.SelectSingleNode('//msb:version', $ns)

    $oldVersion = $versionNode.InnerText
    $versionNode.InnerText = $newVersion

    $nuspecXml.Save($nuspecPath);

    Write-Host "$oldVersion -> $newVersion"
}

function SetReleaseNotes([string]$nuspecPath, [string]$releaseNotes) {
    [xml]$nuspecXml = Get-Content $nuspecPath
    
    $ns = new-object Xml.XmlNamespaceManager $nuspecXml.NameTable
    $ns.AddNamespace("msb", "http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd")
    
    $releaseNotesNode = $nuspecXml.SelectSingleNode('//msb:releaseNotes', $ns)

    $releaseNotesNode.InnerText = $releaseNotes

    $nuspecXml.Save($nuspecPath);
}