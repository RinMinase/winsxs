@echo off
echo This Compressor is made thanks to...
echo Author: Rin Minase
echo Commpany: Minase Conglomerate
echo.
echo.
echo Compressing "Windows\WinSxS" or the Windows Side-by-Side Folder
echo.
echo Preparing compression algorithm in 10 seconds
timeout /t 10 /nobreak

@echo on
sc stop msiserver
sc stop TrustedInstaller

sc config msiserver start= disabled
sc config TrustedInstaller start= disabled

icacls "%windir%\winsxs" /save "%windir%\winsxs.acl" /t /c

takeown /f "%windir%\winsxs" /r

icacls "%windir%\winsxs" /grant "%userdomain%\%username%":(F) /t /c

compact /c /s:"%windir%\winsxs" /a /i /f /exe:lzx

icacls "%windir%" /restore "%windir%\winsxs.acl" /c

del "%windir%\winsxs.acl"

sc config msiserver start= demand
sc config TrustedInstaller start= demand

@echo off
echo Compressing "Windows\Installer" Folder

@echo on
compact /c /s:"%windir%\installer" /a /i /f /exe:lzx

pause