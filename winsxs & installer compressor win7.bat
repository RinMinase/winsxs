@echo off
echo This Compressor is made thanks to...
echo Author: Rin Minase
echo.
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

compact /c /s:"%windir%\winsxs" /a /i /f

icacls "%windir%" /restore "%windir%\winsxs.acl" /c

del "%windir%\winsxs.acl"


icacls "%windir%\System32\DriverStore\FileRepository" /save "%windir%\FileRepository.acl" /t /c

takeown /f "%windir%\System32\DriverStore\FileRepository" /r

icacls "%windir%\System32\DriverStore\FileRepository" /grant "%userdomain%\%username%":(F) /t /c

compact /c /s:"%windir%\System32\DriverStore\FileRepository" /a /i /f

icacls "%windir%\System32\DriverStore" /restore "%windir%\FileRepository.acl" /c

del "%windir%\FileRepository.acl"


sc config msiserver start= demand
sc config TrustedInstaller start= demand

@echo off
echo Compressing "Windows\Installer" Folder

@echo on
compact /c /s:"%windir%\installer" /a /i /f

pause
