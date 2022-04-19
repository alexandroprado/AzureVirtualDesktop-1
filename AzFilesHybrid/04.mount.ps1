#必须用Windows 管理员账户，通过RDP访问到AVD的虚拟机上
#RUN in Azure PowerShell
$StorageAccountName = "leizhangavdstorage01"
$SAkey = "[YourStorageAccountKey]"
$sharename = "avduserprofile"
$DesiredDriveLetter = "z:"

#无需修改
$ComputerName = "$StorageAccountName.file.core.chinacloudapi.cn"
$UNCPath = "\\$ComputerName\$sharename"

#从命令提示符装载文件共享
$connectTestResult = Test-NetConnection -ComputerName $ComputerName -Port 445
if ($connectTestResult.TcpTestSucceeded)
{
  net use $DesiredDriveLetter $UNCPath /user:Azure\$StorageAccountName $SAkey
} 
else
{
  Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN,   Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}

#RUN in Azure PowerShell
$UNCPath


#RUN in Windows CMD
icacls $DesiredDriveLetter

#运行以下命令可允许 Windows 虚拟机用户创建自己的配置文件容器，同时阻止其他用户访问其配置文件容器
icacls z: /grant avd01@leicorp.biz:(M)
icacls z: /grant "Creator Owner":(OI)(CI)(IO)(M)
icacls z: /remove "Authenticated Users"
icacls z: /remove "Builtin\Users"