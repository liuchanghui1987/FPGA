@echo off & setlocal EnableDelayedExpansion
::ɾ���ϴ�·���ļ�
del package.f

::��ȡԭʼȫ·���б�
for /r ..\package %%a in (*.vhd) do (
    set var=%%~a
    echo !var! >> p.f
)
)

::��ȫ·���б��ڵ�\б���޸�Ϊ/б�ܣ�д������·���ļ���
(For /f "delims=" %%i in (p.f) do (Set str=%%i
����SetLocal EnableDelayedExpansion
����Set str=!Str:\=/!
����echo !str!
����EndLocal
))>package.f

::ɾ��ԭʼ·���б�
DEL p.f

::ɾ���ϴ�·���ļ�
del rtl.f

::��ȡԭʼȫ·���б�
for /r ..\rtl %%a in (*.vhd) do (
    set var=%%~a
    echo !var! >> vhdl.f
)
)

::��ȫ·���б��ڵ�\б���޸�Ϊ/б�ܣ�д������·���ļ���
(For /f "delims=" %%i in (vhdl.f) do (Set str=%%i
����SetLocal EnableDelayedExpansion
����Set str=!Str:\=/!
����echo !str!
����EndLocal
))>rtl.f

::ɾ��ԭʼ·���б�
DEL vhdl.f


::�������·�� 
SET debussy=C:\Novas\Debussy\bin\Debussy.exe 
SET vsim=C:\modeltech_10.1c\win32\vsim.exe 
::ModelSim Command 
%vsim% -c -do sim.do 
::ɾ��ModelSim���ɵ�����ļ� 
RD work /s /q 
DEL transcript vsim.wlf /q 
::Debussy Command 
%debussy% -f package.f -f rtl.f -ssf debussy.fsdb -2001 
::ɾ�������ļ� 
DEL debussy.fsdb /q 
::ɾ��Debussy���ɵ�����ļ� 
RD Debussy.exeLog  /s /q 
DEL novas.rc /q 
::�˳������� 
EXIT