Function Add-VMware {
    # This requires PowerCLI
    If (-not(Get-PSSnapin -Name 'VMware*' -ErrorAction SilentlyContinue)) {
        Add-PSSnapin -Name (Get-PSSnapin -Registered -Name 'VMware*')
        Function global:Connect-VMware {
            Get-AdminCred
            Connect-VIServer -Server $vcenter -Credential $admin
        }
        Function global:Enable-VMMemHotAdd($VM) {
            # Lets you enable Memory Hot Add on a VM while it's running. Requires a stun/unstun cycle to take effect
            $vmview = Get-VM -VM $vm | Get-View
            $vmConfigSpec = New-Object -TypeName VMware.Vim.VirtualMachineConfigSpec
            $extra = New-Object -TypeName VMware.Vim.optionvalue
            $extra.Key = 'mem.hotadd'
            $extra.Value = 'true'
            $vmConfigSpec.extraconfig += $extra
            $vmview.ReconfigVM($vmConfigSpec)
        }
        Function global:Update-VMHardwareVersion($VM) {
            # Schedules the VM hardware version upgrade for the next power cycle of the VM. vmx-10 is for vSphere 5.5
            $vm1 = Get-VM -Name $vm
            $spec = New-Object -TypeName VMware.Vim.VirtualMachineConfigSpec
            $spec.ScheduledHardwareUpgradeInfo = New-Object -TypeName VMware.Vim.ScheduledHardwareUpgradeInfo
            $spec.ScheduledHardwareUpgradeInfo.UpgradePolicy = 'onSoftPowerOff'
            $spec.ScheduledHardwareUpgradeInfo.VersionKey = 'vmx-10'
            $vm1.ExtensionData.ReconfigVM_Task($spec)
        }
        Function global:set-VMChangeBlockTracking($VM) {
            # Lets you enable Change Block Tracking on a VM while it's running. Requires a stun/unstun cycle to take effect
            $vmview = Get-VM $VM | Get-View
            $vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
            $vmConfigSpec.changeTrackingEnabled = $Enable
            $vmview.reconfigVM($vmConfigSpec)
        }
        Function global:Find-OutdatedVMTools {
            Get-VM | Where-Object {$_.ExtensionData.Guest.ToolsStatus -eq "toolsOld"} | Sort-Object name |Format-Table -AutoSize -Property name, powerstate
        }
        Update-PSTitleBar 'VMware'
    }
}
