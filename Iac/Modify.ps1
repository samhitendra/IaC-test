Import-Module ServerManager
add-pssnapin VMware.VimAutomation.Core

Connect-VIServer b6-vc-65.cloud.ucs -User 'shambhavi@cloud.ucs' -Password 'Acc1234$$'

$VMs=Get-VM | Where-Object { $_.Name -like '*b6-IaC-Win*'}

Get-VMGuestNetworkInterface $VMs |
Where-Object { $_.ip -ne $null} |
#Set-vmguestnetworkinterface -ip “192.168.15.120” -netmask “255.255.255.0” -gateway “192.168.15.2” | Out-Null

Set-VM $VMs -NumCPU 4  -confirm:$false | Out-Null 
Set-VM $VMs -MemoryGB 3  -confirm:$false | Out-Null 
Get-VM $VMs | New-HardDisk -CapacityGB 1 -StorageFormat Thin -Persistence persistent | Out-Null
