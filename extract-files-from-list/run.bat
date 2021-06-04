@ECHO OFF
powershell Write-Host "------------------------------------------------------------------------------------"
powershell Write-Host ""
powershell Write-Host "Suchstring zum manuellen Suchen:"
powershell .\concatList.ps1
powershell Write-Host ""
powershell Write-Host "------------------------------------------------------------------------------------"
powershell Write-Host ""

powershell Write-Host "Fuehre automatisches Entpacken aus..."
powershell Write-Host ""
powershell .\unzipFilesFromList.ps1
powershell Write-Host ""
powershell Write-Host "...fertig"
powershell Write-Host ""
powershell Write-Host "------------------------------------------------------------------------------------"

