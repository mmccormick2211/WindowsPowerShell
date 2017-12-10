$env:PSModulePath = $env:PSModulePath + ";E:\TIS\PSModules"
Write-Warning -Message "Added E:\TIS\PSModules to PSModulePath..."
Import-Module TISArchive
Write-Warning -Message "Imported Module TISArchive..."
