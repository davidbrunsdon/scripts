#This script recursively searches logs folders for a keyword.
#It's configured to find occurances of missing RC-Archive data.


$LogLocation = 'C:\ProgramData\Reliable Controls\RC-Archive\logs'
$UserPath = "$($env:UserProfile)\Desktop\filter_output.txt"
$String = @(
    'Device Offline'
    'Tasks That Lost Data'
    'Number of routable Addresses: 0'
)

Set-Location -Path $LogLocation

foreach ( $item in $String ){
    Write-Output $item | Out-file $UserPath -Append
    Get-ChildItem -Recurse | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-7)} | Select-String $item -List | Select Path | Out-File $UserPath -Append
}

