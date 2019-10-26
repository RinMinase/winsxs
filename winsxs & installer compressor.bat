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

compact /c /s:"%windir%\winsxs" /a /i /f /exe:lzx

icacls "%windir%" /restore "%windir%\winsxs.acl" /c

del "%windir%\winsxs.acl"


icacls "%windir%\System32\DriverStore\FileRepository" /save "%windir%\FileRepository.acl" /t /c

takeown /f "%windir%\System32\DriverStore\FileRepository" /r

icacls "%windir%\System32\DriverStore\FileRepository" /grant "%userdomain%\%username%":(F) /t /c

compact /c /s:"%windir%\System32\DriverStore\FileRepository" /a /i /f /exe:lzx

icacls "%windir%\System32\DriverStore" /restore "%windir%\FileRepository.acl" /c

del "%windir%\FileRepository.acl"



icacls "C:\Program Files\WindowsApps" /save "C:\WindowsApps.acl" /t /c

takeown /f "C:\Program Files\WindowsApps" /r

icacls "C:\Program Files\WindowsApps" /grant "%userdomain%\%username%":(F) /t /c

compact /c /s:"C:\Program Files\WindowsApps" /a /i /f /exe:lzx

icacls "C:\Program Files\WindowsApps" /setowner "NT SERVICE\TrustedInstaller" /t

icacls "C:\Program Files" /restore "C:\WindowsApps.acl" /c

del "C:\WindowsApps.acl"



icacls "%windir%\InfusedApps" /save "%windir%\InfusedApps.acl" /t /c

takeown /f "%windir%\InfusedApps" /r

icacls "%windir%\InfusedApps" /grant "%userdomain%\%username%":(F) /t /c

compact /c /s:"%windir%\InfusedApps" /a /i /f /exe:lzx

icacls "%windir%\InfusedApps" /setowner "NT SERVICE\TrustedInstaller" /t

icacls "%windir%" /restore "%windir%\InfusedApps.acl" /c

del "%windir%\InfusedApps.acl"


sc config msiserver start= demand
sc config TrustedInstaller start= demand

@echo off
echo Compressing "Windows\Installer" Folder

@echo on
compact /c /s:"%windir%\installer" /a /i /f /exe:lzx

pause
