# AutoUSB-FileTransfer

This PowerShell script automates the process of copying PowerPoint (PPT), Text(txt), PDF and Word (DOC, DOCX) files from a USB drive to a specific location on your computer when the USB drive is connected.

## Features

- Automatically detects when a USB drive is connected.
- Copies PPT, PDF, TEXT and DOC files from the USB drive to a specified folder.
- Customizable destination folder.

## Usage

1. **Requirements**: This script requires PowerShell to be installed on your system.

2. **Setup**: 
   - Clone or download this repository to your local machine.
   - Open the `script.ps1` script in a text editor.

3. **Configuration**:
   - Modify the `$destinationFolder` variable in the script to specify the destination folder where you want to copy the files.

4. **Execution**:
   - Connect your USB drive to your computer.
   - Open PowerShell and navigate to the directory where you saved the script.
   - Run the script using the following command:
     ```powershell
     PS C:\path\to\script> .\script.ps1
     ```

5. **Note**: Ensure that you have appropriate permissions to access the destination folder.


## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or create a pull request.

