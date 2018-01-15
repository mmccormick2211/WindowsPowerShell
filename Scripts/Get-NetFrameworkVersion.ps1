#SOURCE:  https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed
function Get-NetFrameworkVersion {
    [CmdletBinding()]
    param(
        [string[]]$Computer = "localhost"
    )
    $ScriptBlockToRun = {
        $NetRegKey = Get-Childitem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'
        $Release = $NetRegKey.GetValue("Release")
        Switch ($Release) {
            378389 {$NetFrameworkVersion = "$Release = .NET Framework 4.5"}
            378675 {$NetFrameworkVersion = "$Release = .NET Framework 4.5.1 comes with Windows 8.1 or Windows Server 2012 R2"}
            378758 {$NetFrameworkVersion = "$Release = .NET Framework 4.5.1 installed on Windows 8, Windows 7 SP1, or Windows Vista SP2"}
            379893 {$NetFrameworkVersion = "$Release = .NET Framework 4.5.2"}
            393295 {$NetFrameworkVersion = "$Release = .NET Framework 4.6 installed on Windows 10 systems"}
            393297 {$NetFrameworkVersion = "$Release = .NET Framework 4.6 installed"}
            394254 {$NetFrameworkVersion = "$Release = .NET Framework 4.6.1 installed on Windows 10 November Update (1551) system"}
            394271 {$NetFrameworkVersion = "$Release = .NET Framework 4.6.1 installed"}
            394802 {$NetFrameworkVersion = "$Release = .NET Framework 4.6.2 installed on Windows 10 Anniversary Update (1607) system"}
            394806 {$NetFrameworkVersion = "$Release = .NET Framework 4.6.2 installed"}
            460798 {$NetFrameworkVersion = "$Release = .NET Framework 4.7 installed on Windows 10 Creators Update (1703) system"}
            460805 {$NetFrameworkVersion = "$Release = .NET Framework 4.7 installed"}
            461308 {$NetFrameworkVersion = "$Release = .NET Framework 4.7.1 installed on Windows 10 Fall Creators Update (1709) system"}
            461310 {$NetFrameworkVersion = "$Release = .NET Framework 4.7.1 installed"}
            Default {$NetFrameworkVersion = "$Release = Net Framework 4.5 or later is not installed."}
        }
        $Object = [PSCustomObject]@{
            Computername        = $Computer
            NETFrameworkVersion = $NetFrameworkVersion
        }
        $Object
    }

    Write-Debug -Message "Testing $Computer..." -Debug
    if ($Computer = "localhost") { $Computer = $env:COMPUTERNAME.ToString; . $ScriptBlockToRun }
    else { Invoke-Command -Session (New-PSSession $Computer) -ScriptBlock $ScriptBlockToRun }
}

Get-NetFrameworkVersion 127.0.0.1
Get-NetFrameworkVersion
