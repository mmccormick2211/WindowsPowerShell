Write-Host $MyInvocation.MyCommand.Definition
#region  Location Vars
$vcenter = 'DP-EGI-VCS-01.egistics.local'
$termserver = 'DP-EGI-TER-01.egistics.local'
$smtpserver = '10.100.10.46'
$userpath = '\\DP-ESL-EFS-01.egistics.local\FTP\TIS'          # location of user folders
#endregion

#region  One-liner functions
function whoami { (& whoami.exe /UPN) }
function which ($cmd) { get-command $cmd | Select-Object path }
function exp { explorer.exe . }
function append-path { $oldPath = Get-Content Env:\Path; $newPath = $oldPath + ";" + $args; Set-Content Env:\Path $newPath; }
Function touch { $file = $args[0]; if ($file -eq $null) { throw "No filename supplied" }; if (Test-Path $file) { (Get-ChildItem $file).LastWriteTime = Get-Date } else { New-Item -force -type file $file } }
#endregion

#region  Drive mappings
$DriveZ = @{'Name'= 'Z';
    'PSProvider'  = 'FileSystem';
    'Root'        = Join-Path -Path $userpath -ChildPath whoami;
    'Description' = 'Z: Drive';
    'Scope'       = 'Global';
    'Persist'     = $true;
    'Credential'  = whoami
}

if (!(Test-Path -Path 'Z:\')) { New-PSDrive @DriveZ }
#endregion

##function New-ZDrive { if ( !( Test-Path -Path 'Z:\' ) ) { New-PSDrive -Name Z -PSProvider FileSystem -Root  -Scope Global -Persist -Verbose }}; New-ZDrive

