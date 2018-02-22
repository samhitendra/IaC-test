Import-Module ServerManager
add-pssnapin VMware.VimAutomation.Core

Connect-VIServer b6-vc-65.cloud.ucs -User 'shambhavi@cloud.ucs' -Password 'Acc1234$$'

$VMs=Get-VM | Where-Object { $_.Name -like '*b6-IaC-*'}

Get-VMGuestNetworkInterface $VMs |
Where-Object { $_.ip -ne $null} |

Set-VM $VMs -NumCPU 2  -confirm:$false | Out-Null 
Set-VM $VMs -MemoryGB 3  -confirm:$false | Out-Null 
Get-VM $VMs | New-HardDisk -CapacityGB 1 -StorageFormat Thin -Persistence persistent | Out-Null
