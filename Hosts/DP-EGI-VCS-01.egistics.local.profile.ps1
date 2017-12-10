$env:PSModulePath = $env:PSModulePath + ";E:\TIS\PSModules"
Write-Warning -Message "Added E:\TIS\PSModules to PSModulePath..."
#Import-Module TISVMWare
#Write-Warning -Message "Imported Module TISVMWare..."
. "E:\APPS\VMware\PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1" $true
'Connecting to localhost...'
Connect-VIServer -Server localhost -Protocol https -Verbose
