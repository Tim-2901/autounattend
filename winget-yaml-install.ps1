# Ensure the required module is installed
if (-not (Get-Module -ListAvailable -Name 'powershell-yaml')) {
    Write-Host "Installing powershell-yaml module..."
    Install-Module -Name powershell-yaml -Force -Scope CurrentUser
}

# Load YAML module
Import-Module powershell-yaml

# Define the path to the YAML file
$yamlFilePath = "D:\packages.yaml"

# Read YAML file
$yamlContent = Get-Content -Path $yamlFilePath | Out-String | ConvertFrom-Yaml

# Extract default options and packages from YAML
$defaults = $yamlContent.defaults
$packages = $yamlContent.packages
$defaults
$packages
# Iterate over each package and install
foreach ($packageName in $packages.Keys) {
    $package = $packages[$packageName]

    # Initialize the install command with the package ID
    $installCommand = "winget install $($package.id)"

    # Apply defaults and package-specific options
    foreach ($key in $defaults.Keys) {
        # If the package doesn't define this option, use the default
        if (-not $package.ContainsKey($key)) {
            if(($key -ne 'silent') -or (-not $package.ContainsKey('interactive'))){
                $package[$key] = $defaults[$key]
            }
        }
    }

    # Add options to the install command
    foreach ($key in $package.Keys) {
        if ($key -ne 'id') {
            $value = $package[$key]
            # Only add valid options to the install command (assuming options are boolean for this example)
            if ($value -eq $true) {
                $installCommand += " --$key"
            } elseif ($value -ne $false) {
                $installCommand += " --$key $value"
            }
        }
    }

    # Output and execute the install command
    Write-Host "Installing $packageName with options: $installCommand"
    Invoke-Expression $installCommand
}