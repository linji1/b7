@Echo OFF
@Echo �����߽��Զ�Ϊ�������������:
@Echo.
@Echo 1.����Guest�û�
@Echo 2.ɾ���������,�ܾ���������ʴ˼�����е�Guest�û�
@Echo 3.����������У��������: �����ʻ��Ĺ���Ͱ�ȫģ��Ϊ������
@Echo 4.����IPsec Policy Agent(IP��ȫ����)����
@Echo 5.����Server(�������)
@Echo 6.����Computer Browser(�������)
@Echo 7.ͣ��Windows Firewall(����ǽ����)
@Echo.
@Echo ������ɺ�,��ֻ��Ҫ����Ҫ������̷���,���ù�����!
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
@Echo �������,������������Ҫ�����Ŀ¼,���ù�����!
pause 0 > nul