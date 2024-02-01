Set-ExecutionPolicy RemoteSigned
Import-Module ServerManager
Add-WindowsFeature Web-Scripting-Tools
Import-Module WebAdministration



while($set -ne 3){
Get-Item IIS:\\Sites\iKnowClient
Get-Item IIS:\Sites\iKnowClient\api
$set = Read-Host 'Select:
 1-switch IIS pool "iKnowClient" to C:\WebSites\iKnowClient 
 2-switch IIS pool "iKnowClient" to C:\WebSites\iKnowClient2 
 3-exit
 '
if($set -eq 1){
    Set-ItemProperty IIS:\Sites\iKnowClient -name physicalPath -value "C:\WebSites\iKnowClient"
    Set-ItemProperty IIS:\Sites\iKnowClient\api -Name physicalPath -Value "C:\WebSites\iKnowAPI"
    
    Write-Host "+++++++++++   iKnowClient site was switched to path: C:\WebSites\iKnowClient iKnowAPI+++++++++++++++"
    }
if($set -eq 2){
    Set-ItemProperty IIS:\Sites\iKnowClient -name physicalPath -value "C:\WebSites\iKnowClient2"
    Set-ItemProperty IIS:\Sites\iKnowClient\api -Name physicalPath -Value "C:\WebSites\iKnowAPI2"

    Write-Host "+++++++++++   iKnowClient site was switched to path: C:\WebSites\iKnowClient2 iKnowAPI2+++++++++++++++"
    }

 }

