$path = "$($env:USERPROFILE)\Desktop\organized"
# Create folder if it's not already created
if (!(Test-Path $path)) {
New-Item $path -type directory | Out-Null
}
# Lists file extenstions of files and take out period from beginning of name
$list = Get-Childitem  | foreach { $_.Extension.TrimStart(".") }  | Select-object -Unique #> debug.txt
# echo $list -debug
# Create folder for each filetype inside organize folder if not already created
ForEach($dir in ($list))
{
if (!(Test-Path $path\$dir)) {
    New-Item $path\$dir -type directory | Out-Null
}
}
# Make folder for all folders to be moved if not already created
#
if (!(Test-Path $path\folders)) {
New-Item $path\folders -type directory | Out-Null
}
# Move all folders to "folders" folder
Get-ChildItem -Exclude "organized" | ?{ $_.PSIsContainer } | Move-Item -Destination $path\folders
# Create
foreach($dir in ($list))
{
if (!($dir -eq "ps1")) {
$oikea = "$path\$dir\"
move *.$dir $path\$dir\ -Exclude organize_powershell.ps1
}
}
