# Last Year and before
$cutoff = (Get-Date).adddays(-((Get-Date).DayOfYear)+1).Date
# Last Month and before
#$cutoff = (Get-Date).adddays(-((Get-Date).Day)+1).Date
# Last Week and before
#$cutoff = (Get-Date).adddays(-((Get-Date).DayOfWeek)).Date

Get-ChildItem -Path "C:\Windows\System32\config\systemprofile\AppData\Local\Temp" -Force -Recurse | 
    ForEach-Object { 
        if ( ( $_.CreationTime) -lt $cutoff ) { 
            $_ | Remove-Item -Force -Verbose -Recurse
        } 
    }

