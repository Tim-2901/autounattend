Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
powershell.exe -WindowStyle Normal -NoProfile -Command "Get-Content -LiteralPath 'D:\winget-install.ps1' -Raw | Invoke-Expression;"
powershell.exe -WindowStyle Normal -NoProfile -Command "Get-Content -LiteralPath 'D:\windows-update.ps1' -Raw | Invoke-Expression;"