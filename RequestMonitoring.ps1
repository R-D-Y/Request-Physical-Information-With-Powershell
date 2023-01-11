# Recuperation de l'etat de la memoire
$memory = Get-WmiObject -Class Win32_OperatingSystem
$memoryStatus = "Utilisation de la memoire : {0:N2}%" -f ($memory.FreePhysicalMemory / $memory.TotalVisibleMemorySize * 100)

# Recuperation de l'etat du disque
$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'"
$diskStatus = "Utilisation du disque : {0:N2}%" -f ($disk.FreeSpace / $disk.Size * 100)

###############You can change the Logical Disk Letter by your Letter and uncomment this section
###### Recuperation de l'etat du disque numero 2
######$disk2 = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='P:'"
#####$diskStatus2 = "Utilisation du disque : {0:N2}%" -f ($disk2.FreeSpace / $disk2.Size * 100)

# Recuperation de la temperature du CPU (methode 1)#
$cpuTemperature = (Get-WmiObject -Class MSAcpi_ThermalZoneTemperature).CurrentTemperature
if ($cpuTemperature) {
    $cpuTemperature = "Temperature du CPU : {0}°C" -f ($cpuTemperature / 10 - 273)
}

# Recuperation de la temperature du CPU (methode 2)#
if (!$cpuTemperature) {
    $cpuTemperature = Get-WmiObject -Class Win32_TemperatureProbe | Select-Object -ExpandProperty CurrentReading
    if ($cpuTemperature) {
        $cpuTemperature = "Temperature du CPU : {0}°C" -f ($cpuTemperature / 10)
    }
}

# Recuperation de la temperature du CPU (methode 3)#
if (!$cpuTemperature) {
    $cpuTemperature = (Get-WmiObject -Class Win32_Processor).LoadPercentage
    $cpuTemperature = "Temperature du CPU : {0}°C (approximatif)" -f ($cpuTemperature / 100 * 70 + 30)
}

# Recuperation de l'etat de la batterie
$battery = Get-WmiObject -Class Win32_Battery
$batteryStatus = "Etat de la batterie : {0}%" -f $battery.EstimatedChargeRemaining

# Recuperation de la version de l'OS
$os = Get-WmiObject -Class Win32_OperatingSystem
$osVersion = "Version de l'OS : $($os.Caption)"

# Recuperation de la version du BIOS
$bios = Get-WmiObject -Class Win32_BIOS
$biosVersion = "Version du BIOS : $($bios.SMBIOSBIOSVersion)"

# Recuperation du modele du CPU
$cpu = Get-WmiObject -Class Win32_Processor
$cpuModel = "Modele du CPU : $($cpu.Name)"

# Recuperation de la quantite de memoire vive
$memory = Get-WmiObject -Class Win32_PhysicalMemory
$memorySize = "Memoire vive : {0:N2} Go" -f ($memory.Capacity / 1GB)

# Recuperation de la quantite de memoire graphique
$gpu = Get-WmiObject -Class Win32_VideoController
$gpuMemory = "Memoire graphique : {0:N2} Go" -f ($gpu.AdapterRAM / 1GB)

# Recuperation de l'etat de la carte reseau
$network = Get-WmiObject -Class Win32_NetworkAdapter | Where-Object {$_.NetConnectionStatus -eq 2}
$networkStatus = "Carte reseau : connectee"
if (!$network) {
    $networkStatus = "Carte reseau : deconnectee"
}

# Recuperation des programmes en cours d'execution
$processes = Get-Process

# Recuperation des pages ouvertes dans Google Chrome
$chrome = Get-Process chrome | Select-Object -ExpandProperty MainWindowTitle

# Recuperation des lecteurs reseaux
$networkDrives = Get-WmiObject -Class Win32_MappedLogicalDisk | Where-Object {$_.ProviderName -ne $null}

# Recuperation des erreurs systeme
$systemErrors = Get-EventLog -LogName System -EntryType Error

# Recuperation de toutes les fenêtres ouvertes sur le bureau
$openWindows = Get-Process | Where-Object {$_.MainWindowHandle -ne 0}

# Recuperation de toutes les applications ouvertes sur le bureau (en excluant les fenêtres de service)
$openApplications = $openWindows | Where-Object {$_.MainWindowTitle -ne ""} | Select-Object -ExpandProperty Name -Unique





####################################################
####################################################
######                                        ######
######  Affichage de toutes les informations  ######
######                                        ######
####################################################
####################################################


# Recuperation de l'etat de la memoire
Write-Host $memoryStatus

# Recuperation de l'etat du disque
Write-Host $diskStatus

# Recuperation de la temperature du CPU
Write-Host $cpuTemperature

# Recuperation du % de batterie (Laptop seulement)
Write-Host $batteryStatus

# Recuperation de la version de l'OS
Write-Host $osVersion

# Recuperation de la version du BIOS
Write-Host $biosVersion

# Recuperation du modele du CPU
Write-Host $cpuModel

# Recuperation de la quantite de memoire vive
Write-Host $memorySize

# Recuperation de la quantite de memoire graphique
Write-Host $gpuMemory

# Recuperation de l'etat de la carte reseau
Write-Host $networkStatus

# Recuperation de l'etat du disque numero 2
Write-Host $diskStatus2

# Recuperation des erreurs systeme
Write-Host "Nombre d'erreurs systeme : $($systemErrors.Count)"

# Affichage du nombre d'applications ouvertes sur le bureau
Write-Host "Nombre d'applications ouvertes sur le bureau : $($openApplications.Count)"

# Recuperation des programmes en cours d'execution
Write-Host "Nombre de programmes en cours d'execution : $($processes.Count)"
Write-Host "Nombre de pages ouvertes dans Google Chrome : $($chrome.Count)"
Write-Host "Nombre de lecteurs reseaux : $($networkDrives.Count)"
Write-Host "Nombre de lecteurs reseaux : $($networkDrives.Count)"

# Affichage du nombre de lecteurs reseaux et de leur utilisation
foreach ($drive in $networkDrives) {
    $usedSpace = $drive.Size - $drive.FreeSpace
    $percentage = "{0:N2}%" -f ($usedSpace / $drive.Size * 100)
    Write-Host "Utilisation de $($drive.Name) : $percentage"
}

