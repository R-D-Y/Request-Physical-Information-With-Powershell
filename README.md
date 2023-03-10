# Request-Physical-Information-With-Powershell
Request physical information of your Windows computer with powershell

You can use the script to request few information of your computer with powershell

Information :
 
**Retrieving memory status :**
`Write-Host $memoryStatus`

**Retrieving disk status :**
`Write-Host $diskStatus`

**Retrieving CPU temperature :**
`Write-Host $cpuTemperature`

**Retrieving battery percentage** (-only for laptops) :
`Write-Host $batteryStatus`

**Retrieving OS version :**
`Write-Host $osVersion`

**Retrieving BIOS version :**
`Write-Host $biosVersion`

**Retrieving CPU model :**
`Write-Host $cpuModel`

**Retrieving amount of RAM :**
`Write-Host $memorySize`

**Retrieving amount of graphics memory :**
`Write-Host $gpuMemory`

**Retrieving network card status :**
`Write-Host $networkStatus`

**Retrieving status of disk number 2 :** (Only if you have 2 Disk or more)
`Write-Host $diskStatus2`

**Retrieving system errors :**
`Write-Host "Number of system errors: $($systemErrors.Count)"`

**Displaying number of applications open on the desktop :**
`Write-Host "Number of applications open on the desktop: $($openApplications.Count)"`

**Retrieving running programs :**
```Write-Host "Number of programs running: $($processes.Count)"
Write-Host "Number of pages open in Google Chrome: $($chrome.Count)"
Write-Host "Number of network drives: $($networkDrives.Count)"
Write-Host "Number of network drives: $($networkDrives.Count)"
```

**Displaying number of network drives and their usage**
```
foreach ($drive in $networkDrives) {
$usedSpace = $drive.Size - $drive.FreeSpace
$percentage = "{0:N2}%" -f ($usedSpace / $drive.Size * 100)
Write-Host "Usage of $($drive.Name): $percentage"
}
```
