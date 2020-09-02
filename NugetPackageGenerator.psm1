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
    
    return $versionNode.InnerText
}