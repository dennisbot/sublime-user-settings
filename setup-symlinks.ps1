param(
    [Parameter(Mandatory = $false)]
    [switch]$Confirm
)

function Create-Userfiles-Symlinks {    
    param(
        [string]$TargetFolder
    )
    # Define the source and destination directories
    $scriptDirectory = [System.IO.Path]::GetDirectoryName($PSCommandPath)
    $destDir = "$TargetFolder\AppData\Roaming\Sublime Text\Packages\User"

    # Ensure the destination directory exists
    if (Test-Path $destDir) {
        Write-Warning "Item already exists in the destination, skipping: $destDir"
    }
    else {
        Write-Host "Destination directory does not exist. Creating: $destDir"
        New-Item -ItemType Directory -Path $destDir
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

function Create-Git-Plugin-Symlink {
    param(
        [string]$TargetFolder
    )
  
    $scriptDirectory = [System.IO.Path]::GetDirectoryName($PSCommandPath)
    $sourceDir = Join-Path -Path $scriptDirectory -ChildPath "Git"
    $destDir = "$TargetFolder\AppData\Roaming\Sublime Text\Packages\Git"

    if (Test-Path $destDir) {
        Write-Warning "Item already exists in the destination, skipping: $destDir"
    }
    else {
        New-Item -ItemType Junction -Path $destDir -Value $sourceDir
    }
}

$homeFolder = Read-Host "Enter the path to the home folder (leave blank to use $HOME):"
# Use the provided home folder or fall back to $HOME
if ($homeFolder -eq "") {
    $homeFolder = $HOME
  }

Write-Host "Home folder to be used is: $homeFolder"

# Call the functions
Create-Env-Variable
Create-Git-Plugin-Symlink -TargetFolder $homeFolder
Create-Userfiles-Symlinks -TargetFolder $homeFolder