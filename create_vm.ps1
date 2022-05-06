$f = Read-Host "Enter the path to the vm configuration file"

# Read configuration information from data
$SettingsObject = Get-Content -Path $f | ConvertFrom-Json

# Unpack configuration values
$VMName = $SettingsObject.name
$Switch = $SettingsObject.switch
$InstallMedia = $SettingsObject.isoPath
$StartupRAM = $SettingsObject.startupRAM_GB * 1GB
$Path = $SettingsObject.vmPath
$VHDName = $SettingsObject.name + ".vhdx"
$NewVHDPath = $Path + "\" + $VMName +"\Virtual Hard Disks\" + $VHDName
$VHDSize = $SettingsObject.diskSize_GB * 1GB
$NumProcessors = $SettingsObject.processors
$DynamicMemory = $SettingsObject.dynamicMemory
$MinMemory = $SettingsObject.minMemory_GB * 1GB
$MaxMemory = $SettingsObject.maxMemory_GB * 1GB

# Create New Virtual Machine
New-VM -Name $VMName -MemoryStartupBytes $StartupRAM -Generation 2 -NewVHDPath $NewVHDPath -NewVHDSizeBytes $VHDSize -Path $Path -SwitchName $Switch

# Set memory usage
Set-VMMemory $VMName -DynamicMemoryEnabled $DynamicMemory
if ( $DynamicMemory )
{
    Set-VMMemory $VMName -MinimumBytes $MinMemory -MaximumBytes $MaxMemory
}

# Add DVD Drive to Virtual Machine
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Configure Virtual Machine to Boot from DVD & Turn off Secure Boot
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive -EnableSecureBoot Off

# Settings
Set-VM -Name $VMName -ProcessorCount $NumProcessors -AutomaticStartAction Nothing -AutomaticStopAction Shutdown -CheckpointType ProductionOnly -AutomaticCheckpointsEnabled $false

# Start VM and connect
Start-VM -Name $VMName
VMConnect.exe localhost $VMName