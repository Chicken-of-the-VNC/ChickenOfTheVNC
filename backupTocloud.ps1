# Script:                       backupToCloud.ps1
# Author:                       Mario Pugh
# Date of latest revision:      8/21/20
# Purpose:                      Backup program to cloud

# Declare variables

# Declare functions

function backup {

# Will check if Google Cloud SDK is installed on system.
 if (Get-Command gcloud -errorAction SilentlyContinue)
 {
      "gcloud exists"

 }
 else
  {
 # Will install Google Cloud SDK if not on system
    (New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe")
    & $env:Temp\GoogleCloudSDKInstaller.exe
}

# File to copy from local system to cloud backup
gcloud compute scp "C:\Users\Mario\Desktop\heimdallDYNW.xlsm" dynw-ubuntu:/home/shared/

}

# Main

backup

# End
