<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Extend-WindowsVolume {
    [CmdletBinding(DefaultParameterSetName = 'Parameter Set 1',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    [Alias()]
    [OutputType([String])]



    Param
    (
        # Parameter help description
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false,
            Position = 0,
            ParameterSetName = 'Parameter Set 1')]
        [string] $ComputerName = 'localhost',

        # Parameter help description
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $false,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false,
            Position = 1,
            ParameterSetName = 'Parameter Set 1')]
        [ValidatePattern("[a-zA-Z]")]
        [ValidateLength(0, 1)]
        [char] $DriveLetter
    )

    Begin {
    }
    Process {
        if ($pscmdlet.ShouldProcess("Target", "Operation")) {
            Get-Disk -CimSession $ComputerName | Update-Disk -Verbose
            Get-Partition -DriveLetter $DriveLetter -CimSession $ComputerName | Get-PartitionSupportedSize -OutVariable size
            Get-Partition -DriveLetter $DriveLetter -CimSession $ComputerName | Resize-Partition -Size $size.SizeMax -PassThru -Verbose
        }
    }
    End {
    }
}