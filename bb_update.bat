@echo off

set INSTUSER=backburner
set UNST_VER=2015
set INST_VER=2016
set SVR_PATH=\\server01\Setup\backburner

set UNST_PATH=%SVR_PATH%\%UNST_VER%
set INST_PATH=%SVR_PATH%\%INST_VER%

set DEST_PATH=C:\Users\%INSTUSER%\Desktop
set USERNAME=backburner
set PASSWORD=backburner
set DOMNAME=MYDOMAIN

IF "%1"=="" GOTO NOHOST
IF NOT EXIST "%1" GOTO NOHOSTFILE

FOR /F %%A IN (%1) DO (
rem uninstall backburner %UNST_VER%

call psexec \\%%A -u %DOMNAME%\%USERNAME% -p %PASSWORD%  xcopy %UNST_PATH% %DEST_PATH%\%UNST_VER% /S /Y /I
call psexec \\%%A -u %DOMNAME%\%USERNAME% -p %PASSWORD% msiexec /x   %DEST_PATH%\%UNST_VER%\backburner.msi /qn

rem install backburner %INST_VER%

call psexec \\%%A -u %DOMNAME%\%USERNAME% -p %PASSWORD%  xcopy %INST_PATH% %DEST_PATH%\%INST_VER% /S /Y /I
call psexec \\%%A -u %DOMNAME%\%USERNAME% -p %PASSWORD% msiexec /i   %DEST_PATH%\%INST_VER%\backburner.msi /qn

)

GOTO END

:NOHOST
echo  ホストファイルを指定してください。
GOTO END

:NOHOSTFILE
echo ホストファイル%1が見つかりません。

:END
