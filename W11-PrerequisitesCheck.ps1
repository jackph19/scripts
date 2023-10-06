#Variable
$Information = "https://www.microsoft.com/en-US/windows/windows-11-specifications"

#Architecture x64
$Arch = (Get-CimInstance -Class CIM_ComputerSystem).SystemType
$ArchValue = "x64-based PC"
if ($Arch -ne $ArchValue)
    #If Architecture is not OK
    {
    Write-Host "Architecture x64 : Not Compatible  " -foregroundcolor "red"
    }

else 

    #If Architecture is OK
    {
    }

#Screen Resolution
$ScreenInfo = (Get-CimInstance -ClassName Win32_VideoController).CurrentVerticalResolution
$ValueMin = 720 
if ($ScreenInfo -le $ValueMin)
    #If Screen resolution is not OK
    {
    Write-Host "Screen resolution support : Not Compatible  " -foregroundcolor "red"
    }

else 

    #If Screen resolution is OK
    {
    }
    
#CPU composition
$Core = (Get-CimInstance -Class CIM_Processor | Select-Object *).NumberOfCores
$CoreValue = 2
$Frequency = (Get-CimInstance -Class CIM_Processor | Select-Object *).MaxClockSpeed
$FrequencyValue = 1000
if (($Core -ge $CoreValue) -and ($Frequency -ge $FrequencyValue))
    {
    }

else

    {
    write-host "Processor is Not Compatible with Windows 11  " -foregroundcolor "red"
    }

#TPM
if ((Get-Tpm).ManufacturerVersionFull20) 
    {
    $TPM2 = -not (Get-Tpm).ManufacturerVersionFull20.Contains(“not supported”)
    }

if ($TPM2 -contains $False)
    #If TPM is not compatible 
    {
    write-host "TPM module is Not Compatible with Windows 11.  " -foregroundcolor "red"
    }

else 

    #If TPM is compatible
    {
    }

#Secure boot available and activated
$SecureBoot = Confirm-SecureBootUEFI
if ($SecureBoot -ne $True)
    #If Secure Boot is not OK
    {
    Write-Host "Secure boot : Not Compatible  " -foregroundcolor "red"
    }

else 

    #If Secure Boot is OK
    {
    }

#RAM available
$Memory = (Get-CimInstance -Class CIM_ComputerSystem).TotalPhysicalMemory
$SetMinMemory = 4294967296
if ($Memory -lt $SetMinMemory)
    #If RAM is not OK
    {
    Write-Host "RAM installed : Not Compatible  " -foregroundcolor "red"
    }

else 

    #If RAM is OK
    {
    }

#Storage available
$ListDisk = Get-CimInstance -Class Win32_LogicalDisk | where {$_.DriveType -eq "3"}
$SetMinSizeLimit = 64GB;
    #Scan Free Hard Drive Space
foreach($Disk in $ListDisk)
    {
   $DiskFreeSpace = ($Disk.freespace/1GB).ToString('F2')
    }

    #If free space is not OK
if ($disk.FreeSpace -lt $SetMinSizeLimit)
    {
    Write-Host "Available space on Hard drive : Not Compatible  " -foregroundcolor "red"
    }

else 

    #If the free space disk is OK
    {
    }
