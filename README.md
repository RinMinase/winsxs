<h1 align="center"> Windows Compression Script </h1>

## Introduction
Compression using the compact command with the highest compression setting (`/exe:lzx`).

## About
This compresses everything these folders:
- `Windows\WinSxS`
- `Windows\System32\DriverStore\FileRepository`
- `Windows\InfusedApps`
- `Program Files\WindowsApps`

## Notes
As Windows 7 does not yet support `/exe` setting, compression on these folders will be compressed using the nomal compression setting.

## Built with
* <img width=20 height=20 src="https://www.learnshell.org/static/img/favicons/learnshell.org.ico"> [Shell](https://www.linux.org/) - Language syntax
