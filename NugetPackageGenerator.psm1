function GetInputData($local, $paths, $debug, $nuspec, $majorV, $minorV, $patchV, $notes) {
    $path
    if($local) {
        $path = $paths.Local
    } else {
        $path = $paths.Server
    }

    $extension
    if($debug) {
        $extension = ".*"
    } else
    {
        $extension = ".dll"
    }
    
    $newVersion = AskForVersion $nuspec $majorV $minorV $patchV

    $releaseNotes
    if(!$notes) {
        $releaseNotes = Read-Host "Release notes"
    } else {
        $releaseNotes = $notes
    }

    $inputData = @{
        Path = $path;
        Extension = $extension;
        Version = $newVersion;
        ReleaseNotes = $releaseNotes;
    }

    return $inputData
}

function CopyFiles($files) {
    foreach ($file in $files) {
        Write-Host "Copy" $file.Name "from" $file.Origin "to" $file.Destination
    }
}

function GetVersion($nuspec) {
    [xml]$nuspecXml = Get-Content $nuspec.Path
    
    $ns = new-object Xml.XmlNamespaceManager $nuspecXml.NameTable
    $ns.AddNamespace("msb", $nuspec.Ns)
    
    $versionNode = $nuspecXml.SelectSingleNode('//msb:version', $ns)
    
    return $versionNode.InnerText.split('.')
}

function AskForVersion($nuspec, [int]$newMajorV, [int]$newMinorV, [int]$newPatchV) {
    [int]$currentMajorV, [int]$currentMinorV, [int]$currentPatchV = GetVersion $nuspec

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

function SetVersion($nuspec, [string]$newVersion) {
    [xml]$nuspecXml = Get-Content (Resolve-Path $nuspec.Path)
    
    $ns = new-object Xml.XmlNamespaceManager $nuspecXml.NameTable
    $ns.AddNamespace("msb", $nuspec.Ns)
    
    $versionNode = $nuspecXml.SelectSingleNode('//msb:version', $ns)

    $oldVersion = $versionNode.InnerText
    $versionNode.InnerText = $newVersion

    $nuspecXml.Save((Resolve-Path $nuspec.Path));

    Write-Host "$oldVersion -> $newVersion"
}

function SetReleaseNotes($nuspec, [string]$releaseNotes) {
    [xml]$nuspecXml = Get-Content (Resolve-Path $nuspec.Path)
    
    $ns = new-object Xml.XmlNamespaceManager $nuspecXml.NameTable
    $ns.AddNamespace("msb", $nuspec.Ns)
    
    $releaseNotesNode = $nuspecXml.SelectSingleNode('//msb:releaseNotes', $ns)

    $releaseNotesNode.InnerText = $releaseNotes

    $nuspecXml.Save((Resolve-Path $nuspec.Path));

    Write-Host $releaseNotes
}