function CopyFiles([string[]]$files, [bool]$isDebug) {
    foreach ($file in $files) {
        Write-Host "Copy" $file
    }
}