Write-Host $MyInvocation.MyCommand.Definition
#region  Location Vars
$vcenter    = 'DP-EGI-VCS-01.egistics.local'           
$termserver = 'DP-EGI-TER-01.egistics.local'
$smtpserver = '10.100.10.46'                                  
$userpath   = '\\DP-ESL-EFS-01.egistics.local\FTP\TIS'          # location of user folders
#endregion

#region  One-liner functions
#function whoami  { (Get-Content Env:\USERDOMAIN) + '\' + (Get-Content Env:\USERNAME); }
#function whoami2 { (Get-Content Env:\USERNAME) + '@' + (Get-Content Env:\USERDNSDOMAIN); }
function which ($cmd) { get-command $cmd | Select-Object path }
function exp { explorer.exe . }
#endregion


function script:append-path {
	$oldPath = get-content Env:\Path;
	$newPath = $oldPath + ";" + $args;
	set-content Env:\Path $newPath;
}


#region  Drive mappings
$DriveZ = @{'Name'         = 'Z';
            'PSProvider'   = 'FileSystem';
            'Root'         = 'prod.mmccormick@egistics.local';
            'Description'  = 'Z: Drive';
            'Scope'        = 'Global'; 
            'Persist'      = $true;
            'Credential'   = (& whoami.exe /UPN)
           }

if (!(Test-Path -Path 'Z:\')) { New-PSDrive @DriveZ }
#endregion