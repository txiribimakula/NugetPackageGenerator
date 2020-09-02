function CopyFiles([string]$path, [string[]]$files, [string]$extension) {
    foreach ($file in $files) {
        Write-Host "Copy" $path"/"$file
    }
}