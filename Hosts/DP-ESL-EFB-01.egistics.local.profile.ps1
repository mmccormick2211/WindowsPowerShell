Write-Host $MyInvocation.MyCommand.Definition
$env:PSModulePath = $env:PSModulePath + ";E:\TIS\PSModules"
Write-Verbose -Message "Added E:\TIS\PSModules to PSModulePath..." -Verbose
Import-Module TISArchive
Write-Verbose -Message "Imported Module TISArchive..." -Verbose
Set-Location -Path 'E:\TIS'