Import-Module ServerManager
add-pssnapin VMware.VimAutomation.Core

Connect-VIServer b6-vc-65.cloud.ucs -User 'shambhavi@cloud.ucs' -Password 'Acc1234$$'

$VMs=Get-VM | Where-Object { $_.Name -like '*b6-IaC-Win*'}

Get-VM $VMs | 
Select Name,
 @{N="Hostname";E={$_.Host.Name}},
 @{N="IP addr";E={[string]::Join(',',$_.Guest.IpAddress)}},
 NumCPU,MemoryMB,
 @{N="HD size allocated (GB)";E={[string]::Join(',',($_.HardDisks | Select -ExpandProperty CapacityGB))}},
 @{N="GuestOS";E={$_.Guest.OSFullName}},
 @{N="Datacenter";E={Get-Datacenter -VM $_ | Select -ExpandProperty Name}},
 @{N="Folder";E={$_.Folder.Name}} | 
Export-Csv C:\Scripts\report.csv -NoTypeInformation -UseCulture
