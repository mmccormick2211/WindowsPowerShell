Write-Host -ForegroundColor Cyan -Object $MyInvocation.MyCommand.Definition
$env:PSModulePath = $env:PSModulePath + ";E:\TIS\PSModules"
Write-Host -ForegroundColor Cyan -Object "Added E:\TIS\PSModules to PSModulePath..."
Import-Module TISExtracts
Write-Host -ForegroundColor Cyan -Object "Imported Module TISExtracts..."
Set-Location -Path 'E:\TIS'