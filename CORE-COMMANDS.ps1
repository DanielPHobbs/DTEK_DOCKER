#set rdp enabled 

cscript %windir%\system32\scregedit.wsf /ar 0

cscript %windir%\system32\scregedit.wsf /ar /v


Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version, Release -ErrorAction 0 | where { $_.PSChildName -match '^(?!S)\p{L}'} | select PSChildName, Version, Release
