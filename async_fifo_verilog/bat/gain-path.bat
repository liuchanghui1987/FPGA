@echo off & setlocal EnableDelayedExpansion
::ɾ���ϴ�·���ļ�
del rtl.f

::��ȡԭʼȫ·���б�
for /r .. %%a in (*.v,*.vhd) do (
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