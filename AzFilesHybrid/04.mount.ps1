#������Windows ����Ա�˻���ͨ��RDP���ʵ�AVD���������
#RUN in Azure PowerShell
$StorageAccountName = "leizhangavdstorage01"
$SAkey = "[YourStorageAccountKey]"
$sharename = "avduserprofile"
$DesiredDriveLetter = "z:"

#�����޸�
$ComputerName = "$StorageAccountName.file.core.chinacloudapi.cn"
$UNCPath = "\\$ComputerName\$sharename"

#��������ʾ��װ���ļ�����
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

#����������������� Windows ������û������Լ��������ļ�������ͬʱ��ֹ�����û������������ļ�����
icacls z: /grant avd01@leicorp.biz:(M)
icacls z: /grant "Creator Owner":(OI)(CI)(IO)(M)
icacls z: /remove "Authenticated Users"
icacls z: /remove "Builtin\Users"