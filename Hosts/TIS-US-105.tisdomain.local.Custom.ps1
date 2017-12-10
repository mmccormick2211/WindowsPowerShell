#requires -runasadministrator
$hostname = 'TIS-US-105'
$domain   = 'TISDOMAIN.LOCAL'
$mycreds  = Get-Credential -Message 'Enter your admin login:' -UserName 'Michael.McCormick@TISDOMAIN.LOCAL' -Verbose

#Rename and join domain
#if (!($env:COMPUTERNAME -eq $hostname)) { Rename-Computer -PassThru -NewName $hostname -Force -Restart -Verbose -Confirm }

#If (!((Get-WMIObject win32_computersystem).partofdomain)) { Add-Computer -DomainName $domain -Credential $mycreds -PassThru }

#requires -modules CustomizeWindows10
# Execute settings
    Set-AppTheme -Dark
    Add-PowerShellWinX
    Enable-SnapAssist
    #Enable-CornerSnap
    Enable-SnapFill
    Enable-ShowFileExtension
    Enable-ShowHiddenFiles
    Enable-ShowSuperHiddenFiles
    Disable-StartMenuBingSearch
    Enable-ExplorerThisPC
    Disable-QuickAccessShowFrequent
    Disable-QuickAccessShowRecent
    Disable-Windows7VolumeMixer

..\Scripts\Disable-Cortana.ps1
..\Scripts\Initialize-Profiles.ps1

#Vagrant config 
[Environment]::SetEnvironmentVariable("VAGRANT_HOME", "D:\.vagrant.d", "User")
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-timezone
Set-Location D:\.vagrant.d; vagrant init


#TODO: Download and extract https://github.com/W4RH4WK/Debloat-Windows-10/archive/master.zip to POSH:\Scripts\

