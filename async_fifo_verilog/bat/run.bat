@echo off & setlocal EnableDelayedExpansion
::ɾ���ϴ�·���ļ�
del rtl.f

::��ȡԭʼȫ·���б�
for /r .. %%a in (*.v) do (
    set var=%%~a
    echo !var! >> verilog.f
)
)

::��ȫ·���б��ڵ�\б���޸�Ϊ/б�ܣ�д������·���ļ���
(For /f "delims=" %%i in (verilog.f) do (Set str=%%i
����SetLocal EnableDelayedExpansion
����Set str=!Str:\=/!
����echo !str!
����EndLocal
))>rtl.f

::ɾ��ԭʼ·���б�
DEL verilog.f

::�������·�� 
SET debussy=C:\Novas\Debussy\bin\Debussy.exe 
SET vsim=C:\modeltech_10.1c\win32\vsim.exe 
::ModelSim Command 
%vsim% -c -do sim.do 
::ɾ��ModelSim���ɵ�����ļ� 
RD work /s /q 
DEL transcript vsim.wlf /q 
::Debussy Command 
%debussy% -f rtl.f -ssf debussy.fsdb -2001 
::ɾ�������ļ� 
DEL debussy.fsdb /q 
::ɾ��Debussy���ɵ�����ļ� 
RD Debussy.exeLog  /s /q 
DEL novas.rc /q 
::�˳������� 
EXIT
