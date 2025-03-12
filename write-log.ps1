function write-log
{
	# Version 2.2
	param
	(
		[String]$Info = $false,
		[String]$Success = $false,
		[String]$Warning = $false,
		[String]$Critical = $false,
		[String]$Error = $false,
		[array]$Multi = $false,
		[String]$regpath = $null,
		# use $null to disable
		[String]$component = "COMPONENT",
		[int]$LogfileSizeMB = 2,
		[Switch]$CleanupLog,
		[Switch]$empty,
		[string]$logfolder = ($Settings.Variables.Logpath),
		[String]$CurrentLogFile = $Global:RunningLog,
		[String]$HistoryLogFile = $null
	)
	
	
	$CurrentLine = $MyInvocation.ScriptLineNumber
	$CurrentTime = (Get-Date -format "yyyy-MM-dd HH:mm:ss")
	if ($Info -ne $false)
	{
		"INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $Info | Write-Host
		if ($HistoryLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Info | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Info | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastInfoMessage" /t "REG_SZ" /d $Info /f | Out-Null }
		Remove-Variable -Name "Infolog" -Force
	}
	
	if ($Success -ne $false)
	{
		"SUCCESS: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $Success | Write-Host -ForegroundColor Green
		if ($HistoryLogFile.Length -gt 1) { "SUCCESS: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Success | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "SUCCESS: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Success | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastSuccessMessage" /t "REG_SZ" /d $Success /f | Out-Null }
		Remove-Variable -Name "SuccessLog" -Force
	}
	
	if ($Warning -ne $false)
	{
		"WARNING: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $Warning | Write-Host -ForegroundColor Yellow
		if ($HistoryLogFile.Length -gt 1) { "WARNING: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Warning | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "WARNING: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Warning | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastSuccessMessage" /t "REG_SZ" /d $Warning /f | Out-Null }
		Remove-Variable -Name "SuccessLog" -Force
	}
	
	if ($CriticalLog -ne $false)
	{
		"CRITICAL: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $CriticalLog | Write-Host -ForegroundColor Yellow
		if ($HistoryLogFile.Length -gt 1) { "CRITICAL: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CriticalLog | OUT-FILE $HistoryLogFile -Append -Force }
		if ($HistoryLogFile.Length -gt 1) { "CRITICAL: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CriticalLog | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastSuccessMessage" /t "REG_SZ" /d $CriticalLog /f | Out-Null }
		Remove-Variable -Name "SuccessLog" -Force
	}
	
	if ($Error -ne $false)
	{
		
		$CurrentError = $global:Error[0]
		
		"ERROR: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $Error | Write-Host -ForegroundColor Red
		"ERRORMSG: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $CurrentError | Write-Host -ForegroundColor Red
		if ($HistoryLogFile.Length -gt 1) { "ERROR: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Error | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "ERROR: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $Error | OUT-FILE $CurrentLogFile -Append -Force }
		if ($HistoryLogFile.Length -gt 1) { "ERRORMSG: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CurrentError | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "ERRORMSG: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CurrentError | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastErrorMessage" /t "REG_SZ" /d $Error /f | Out-Null }
		Remove-Variable -Name "CurrentError" -Force
		Remove-Variable -Name "ErrorLog" -Force
	}
	
	if ($Multi -ne $false)
	{
		$multi | ForEach-Object {
			if ($HistoryLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $_ | OUT-FILE $HistoryLogFile -Append -Force }
			if ($CurrentLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $_ | OUT-FILE $CurrentLogFile -Append -Force }
			"INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $_ | Write-Host
		}
		Remove-Variable -Name "multi", "regpath" -Force
	}
	
	Remove-Variable Currentline -Force
	
	if ($empty -eq $true)
	{
		" " | Write-Host
		" " | OUT-FILE $HistoryLogFile -Append -Force
	}
	if ($CleanupLog -eq $true)
	{
		try
		{
			if ((Test-Path $HistoryLogFile) -eq $true)
			{
				$HistoryLogFileProperties = (Get-ItemProperty $HistoryLogFile | Select-Object directory, fullname, name, length, basename)
				if (((($HistoryLogFileProperties).Length /1MB) -gt $LogfileSizeMB) -or ($LogfileSizeMB -eq 0))
				{
					write-log -component "Log" -Info "Logfile maximum size reached. New logfile has been started"
					Get-ChildItem $LogFolder -filter ($HistoryLogFileProperties.basename + "*.lo_") | Remove-Item -Force
					Rename-Item -Path $HistoryLogFile -NewName ($HistoryLogFileProperties.basename + "-" + (Get-Date -format "yyyyMMdd-HHmmss") + ".lo_") -Force
					write-log -component "Log" -Info "Log has been cleaned up! New logfile has been started."
				}
			}
		}
		catch
		{
			write-log -component "Log" -Error "Failed to cleanup logs"
		}
	}
}