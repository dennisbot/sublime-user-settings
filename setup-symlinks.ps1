param(
    [Parameter(Mandatory = $false)]
    [switch]$Confirm
)

function Create-Userfiles-Symlinks {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    # Define the source and destination directories
    $scriptDirectory = [System.IO.Path]::GetDirectoryName($PSCommandPath)
    # Get the current user's username
    $username = [Environment]::UserName
    $destDir = "C:\Users\$username\AppData\Roaming\Sublime Text\Packages\User"

    # Ensure the destination directory exists
    if (-not (Test-Path $destDir)) {
        Write-Error "Destination directory does not exist: $destDir"
        exit
    }

    $sourceDir = Join-Path -Path $scriptDirectory -ChildPath "User"
    # Get all items in the source directory
    $items = Get-ChildItem -Path $sourceDir

    # Loop through each item and create a symlink in the destination directory
    foreach ($item in $items) {
        $sourceItem = Join-Path -Path $sourceDir -ChildPath $item.Name
        $destItem = Join-Path -Path $destDir -ChildPath $item.Name

        # Check if a file/folder with the same name already exists in the destination
        if (Test-Path $destItem) {
            Write-Warning "Item already exists in the destination, skipping: $destItem"
            continue
        }

        # Create the symlink
        if ($item.PSIsContainer) {
            # It's a directory
            New-Item -ItemType Junction -Path $destItem -Value $sourceItem
        } else {
            # It's a file
            New-Item -ItemType SymbolicLink -Path $destItem -Value $sourceItem
        }
        Write-Output "Symlink created for: $item.Name"
    }
}

# Check if running as an administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Error "You need to run this script as an Administrator!"
  Exit
}

function Create-Env-Variable {
  # Path to the directory containing subl.exe
  $sublPath = "C:\Program Files\Sublime Text"

  # Get the current system PATH
  $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

  # Check if the sublPath is already in the system PATH
  if ($currentPath -notlike "*$sublPath*") {
      # Append the sublPath to the system PATH
      [Environment]::SetEnvironmentVariable("Path", $currentPath + ";" + $sublPath, "Machine")
      Write-Output "Path updated!"
  } else {
      Write-Output "Path already contains the specified directory."
  }
}

# Call the functions
Create-Env-Variable
Create-Userfiles-Symlinks -Confirm:$confirm