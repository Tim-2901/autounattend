if( [System.Environment]::OSVersion.Version.Build -lt 26100 ) {
    'This script requires Windows 11 24H2 or later.' | Write-Warning;
    return;
}
$timeout = [datetime]::Now.AddMinutes( 5 );
$exe = "$env:LOCALAPPDATA\Microsoft\WindowsApps\winget.exe";

while( $true ) {
    if( $exe | Test-Path ) {
        powershell.exe -WindowStyle Normal -NoProfile -Command "Get-Content -LiteralPath 'D:\winget-yaml-install.ps1' -Raw | Invoke-Expression;"
        return;
    }
    if( [datetime]::Now -gt $timeout ) {
        'File {0} does not exist.' -f $exe | Write-Warning;
        return;
    }
    Start-Sleep -Seconds 1;
}