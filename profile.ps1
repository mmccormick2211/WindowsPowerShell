Write-Host $MyInvocation.MyCommand.Definition
$here = (Split-Path -parent $MyInvocation.MyCommand.Definition)
#region One-Liner Functions
function FQDN { (Get-Content Env:\COMPUTERNAME) + '.' + (Get-Content Env:\USERDNSDOMAIN); }
function reloadprofile { & $profile }
function which ($cmd) { get-command $cmd | Select-Object path }
function set-verbose ([bool]$onoff) { if ( $onoff ) { $PSDefaultParameterValues.Add("*:Verbose", $True) } else { $PSDefaultParameterValues.Remove("*:Verbose", $True) } }
#endregion

#region Aliases
Set-Alias -Name "git" -Value "hub" -Description "hub recommended replacement for git"
#endregion

#region Default Parameters
# set default parameters on various commands. See 'Help about_Parameters_Default_Values' for more info
$PSDefaultParameterValues.Add('Format-Table:Force', $True)
$PSDefaultParameterValues.Add('Format-Table:AutoSize', $True)
$PSDefaultParameterValues.Add('Send-MailMessage:SmtpServer', $smtpserver)
#endregion

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }

# Load host-specific profile scripts
$hostProfilePath = $here + "\Hosts\" + (FQDN) + ".profile.ps1"
if (Test-Path $hostProfilePath) { . $hostProfilePath }
