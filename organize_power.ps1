$path = "$($env:USERPROFILE)\Desktop\organized"
if (!(Test-Path $path)) {
New-Item $path -type directory | Out-Null
}
#listaa tiedostejen päätteet
$list = Get-Childitem  | foreach { $_.Extension.TrimStart(".") }  | Select-object -Unique #> file_ext.txt
echo $list
# Tee kansiot kaikille tiedoston tyypeille
ForEach($dir in ($list))
{
if (!(Test-Path $path\$dir)) {
    New-Item $path\$dir -type directory | Out-Null
}
}
#tee kansio kansioille
#siirrä kansiot 
#
if (!(Test-Path $path\kansiot)) {
New-Item $path\Kansiot -type directory | Out-Null
}
Get-ChildItem -Exclude "organized" | ?{ $_.PSIsContainer } | Move-Item -Destination $path\kansiot
#siirrä tiedostot ja kansiot omiin paikkoihin organize alle
foreach($dir in ($list))
{
if (!($dir -eq "ps1")) {
$oikea = "$path\$dir\"
move *.$dir $path\$dir\ -Exclude organize_powershell.ps1
}
}
