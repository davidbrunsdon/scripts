
#Created by david@darkivy.io

#User Values
$Server = "localhost\RCARCHIVE"
$Folder = "E:\SQL"

#System Values
$Date = Get-Date -Format "MM-dd-yyyy"

#Erase All Files older than 7 days
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-7)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName 
}

#Backup Each Database
$DB = Get-SqlDatabase -ServerInstance $Server | Where { $_.Name -ne 'tempdb' } |
foreach({
$BackupFile = $_.Name+"_"+$Date+".bak"
Backup-SqlDatabase -DatabaseObject $_ -BackupFile $BackupFile 
})
