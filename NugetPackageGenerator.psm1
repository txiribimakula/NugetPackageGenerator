function CopyFiles([string[]]$files, [string]$path, [bool]$isDebug) {
    foreach ($file in $files) {
        Write-Host "Copy" $path"/"$file
    }
}