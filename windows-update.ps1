# Ensure the required module is installed
if (-not (Get-Module -ListAvailable -Name 'PSWindowsUpdate')) {
    Write-Host "Installing PSWindowsUpdate module..."
    Install-Module -Name PSWindowsUpdate -Force
}
# Import the PSWindowsUpdate module
Import-Module PSWindowsUpdate
Write-Host "Searching for updates..."
# Check for available updates
$Updates = Get-WindowsUpdate -AcceptAll -IgnoreReboot

# If updates are available, install them
if ($Updates) {
    Write-Host "Installing updates..."
    $Updates | Install-WindowsUpdate -AcceptAll -AutoReboot
} else {
    Write-Host "No updates available."
}