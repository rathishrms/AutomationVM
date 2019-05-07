#Enable Containers
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All -NoRestart

#Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Assign Chocolatey Packages to Install
$Packages = 'googlechrome',`
            'docker-desktop',`
            'visualstudiocode',`
            'git'

#Install Chocolatey Packages
ForEach ($PackageName in $Packages)
{choco install $PackageName -y}

#Install Visual Studio Code Extensions
$Extensions = 'ms-vscode.azurecli',`
              'msazurermtools.azurerm-vscode-tools',`
              'ms-vscode.azure-account',`
              'ms-python.python',`
              'ms-vscode.powershell',`
              'ms-vsts.team',`
              'peterjausovec.vscode-docker'

#Install Packages
Set-ExecutionPolicy Bypass -Scope Process -Force
ForEach ($ExtensionName in $Extensions)
{cmd.exe /C "C:\Program Files\Microsoft VS Code\bin\code.cmd" --install-extension $ExtensionName}

#Install Python 3.6.4 and pylint
choco install python3 --version 3.6.4.20180116 -y
$command1 = @'
cmd.exe /C C:\Python36\python.exe -m pip install -U pylint --user
'@
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression -Command:$command1

#
# Functions
#

function Update-Environment-Path
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#
# Package Managers
#

#Visual Studio
choco install visualstudio2019community --yes
Update-Environment-Path

#Eclipse
choco install eclipse --yes
Update-Environment-Path

#IntelliJ
choco install intellijidea --yes
Update-Environment-Path

#OpenSSH
choco install openssh --yes
Update-Environment-Path

#Putty
choco install putty --yes
Update-Environment-Path

#JavaRunTime
choco install javaruntime --yes
Update-Environment-Path

#Tomcat
choco install tomcat --pre --yes
Update-Environment-Path

#Maven
choco install maven --yes
Update-Environment-Path

# File Management
choco install 7zip --yes

# Misc
choco install sysinternals --yes

Update-Environment-Path

#Add LABVM UserId to docker group
Add-LocalGroupMember -Member vdcadmin -Group docker-users

#Reboot
Restart-Computer
