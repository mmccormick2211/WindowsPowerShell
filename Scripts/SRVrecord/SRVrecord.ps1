<#
The sample scripts are not supported under any Microsoft standard support 
program or service. The sample scripts are provided AS IS without warranty  
of any kind. Microsoft further disclaims all implied warranties including,  
without limitation, any implied warranties of merchantability or of fitness for 
a particular purpose. The entire risk arising out of the use or performance of  
the sample scripts and documentation remains with you. In no event shall 
Microsoft, its authors, or anyone else involved in the creation, production, or 
delivery of the scripts be liable for any damages whatsoever (including, 
without limitation, damages for loss of business profits, business interruption, 
loss of business information, or other pecuniary loss) arising out of the use 
of or inability to use the sample scripts or documentation, even if Microsoft 
has been advised of the possibility of such damages.
#> 

#requires -Version 2
param ([switch]$Reset)
$NetlogonDNSFile="c:\Windows\System32\config\netlogon.dns"
$NetlogonDNBFile="c:\Windows\System32\config\netlogon.dnb"

#region Reset SRV Record
	if ($Reset)
	{
		$date=Get-Date -Format "MMddyyyy"
		Rename-Item -Path $NetlogonDNSFile -NewName "OLDnetlogon$date.dns"
		Rename-Item -Path $NetlogonDNBFile -NewName "OLDnetlogon$date.dnb"
		Restart-Service netlogon
		if (Test-Path $NetlogonDNSFile) {Write-Host "Reset successful."}
		else {Write-Host "Reset fail.";return}
		
	}
#endregion

#region Get SRV Record
	Import-Module ServerManager
	if((Get-WindowsFeature "AD-Domain-Services").installed)
	{
		if (Test-Path $NetlogonDNSFile)
		{
			$SRVRecord= Get-Content $NetlogonDNSFile|?{$_ -match "IN SRV"}
			Write-Host "########## SRV record ##########"
			$SRVRecord
		}
	}
	else
	{
		Write-Host "Please run this script on a domain controller."
	}
#endregion



