Import-Module ServerManager
add-pssnapin VMware.VimAutomation.Core

Connect-VIServer b6-vc-65.cloud.ucs

$VMs=Get-VM | Where-Object { $_.Name -like "*b6-IaC-lin*" -or $_.Name -like "*b6-IaC-win*"}

Set-VM $VMs -NumCPU 3  -confirm:$false | Out-Null 
Set-VM $VMs -MemoryGB 4  -confirm:$false | Out-Null 
Get-VM $VMs | New-HardDisk -CapacityGB 1 -StorageFormat Thin -Persistence persistent | Out-Null 
