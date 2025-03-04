@Echo OFF
@Echo 本工具将自动为您完成以下设置:
@Echo.
@Echo 1.启用Guest用户
@Echo 2.删除组策略中,拒绝从网络访问此计算机中的Guest用户
@Echo 3.更改组策略中，网络访问: 本地帐户的共享和安全模型为仅来宾
@Echo 4.禁用IPsec Policy Agent(IP安全策略)服务
@Echo 5.启用Server(共享服务)
@Echo 6.启用Computer Browser(浏览服务)
@Echo 7.停用Windows Firewall(防火墙服务)
@Echo.
@Echo 设置完成后,您只需要在需要共享的盘符中,设置共享即可!
@Echo.
pause
cls

@Echo [Version] >"%temp%\share.inf"
@Echo signature="$CHICAGO$" >>"%temp%\share.inf"
@Echo Revision=1 >>"%temp%\share.inf"
@Echo [Privilege Rights] >>"%temp%\share.inf"
@Echo SeDenyNetworkLogonRight = >>"%temp%\share.inf"
secedit /configure /db "%temp%\share.sdb" /cfg "%temp%\share.inf"
del /f /q "%temp%\share.sdb"
del /f /q "%temp%\share.inf"

Reg Add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa /v forceguest /t REG_DWORD /d 1 /F
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet001\Control\Lsa /v forceguest /t REG_DWORD /d 1 /F
Net User Guest /Active:yes
sc config PolicyAgent start= demand
net stop PolicyAgent
sc config MpsSvc start= demand 1> nul
net stop MpsSvc 1> nul
sc config ShareAccess start= demand 1> nul
net stop ShareAccess 1> nul
sc config LanmanServer start= auto
net start LanmanServer
sc config Browser start= auto
net start Browser
gpupdate /force
cls
@Echo.
@Echo 设置完成,接下来请在需要共享的目录,设置共享即可!
pause 0 > nul