New-PSDrive -Name 'MyDocs' -PSProvider FileSystem -Root (Get-ItemProperty -Path 'HKCU:\software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders').Personal -ErrorAction SilentlyContinue | Out-Null
New-PSDrive -Name 'POSH' -PSProvider FileSystem -Root ($env:USERPROFILE + '\Documents\WindowsPowerShell') -Description 'PowerShell Drive' -Scope Global
