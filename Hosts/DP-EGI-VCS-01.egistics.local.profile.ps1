Write-Host $MyInvocation.MyCommand.Definition
$env:PSModulePath = $env:PSModulePath + ";E:\TIS\PSModules"
Write-Verbose -Message "Added E:\TIS\PSModules to PSModulePath..."
Import-Module TISVMWare
Write-Verbose -Message "Imported Module TISVMWare..."
Set-Location -Path 'E:\TIS'