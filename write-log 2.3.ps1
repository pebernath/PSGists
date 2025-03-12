function write-log
{
	# Version 2.3
	param
	(
		[String]$InfoLog = $false,
		[String]$SuccessLog = $false,
		[String]$WarningLog = $false,
		[String]$CriticalLog = $false,
		[String]$EErrorLog = $false,
		[array]$MultiLog = $false,
		[String]$regpath = $null, # use $null to disable
		[String]$component = "COMPONENT",
		[int]$LogfileSizeMB = 2,
		[Switch]$CleanupLog,
		[Switch]$empty,
		[Switch]$Silent,
		[string]$logfolder = ($Settings.Variables.Logpath),
		[String]$CurrentLogFile = $Global:RunningLog,
		[String]$HistoryLogFile = $null
	)
	
	
	$CurrentLine = $MyInvocation.ScriptLineNumber
	$CurrentTime = (Get-Date -format "yyyy-MM-dd HH:mm:ss")
	if ($InfoLog -ne $false)
	{
		if ($Silent -eq $false) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $InfoLog | Write-Host }
		if ($HistoryLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $InfoLog | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $InfoLog | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastInfoMessage" /t "REG_SZ" /d $InfoLog /f | Out-Null }
		Remove-Variable -Name "Infolog" -Force
	}
	
	if ($SuccessLog -ne $false)
	{
		if ($Silent -eq $false) {"SUCCESS: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $SuccessLog | Write-Host -ForegroundColor Green}
		if ($HistoryLogFile.Length -gt 1) { "SUCCESS: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $SuccessLog | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "SUCCESS: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $SuccessLog | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastSuccessMessage" /t "REG_SZ" /d $SuccessLog /f | Out-Null }
		Remove-Variable -Name "SuccessLog" -Force
	}
	
	if ($WarningLog -ne $false)
	{
		if ($Silent -eq $false) { "WARNING: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $WarningLog | Write-Host -ForegroundColor Yellow }
		if ($HistoryLogFile.Length -gt 1) { "WARNING: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $WarningLog | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "WARNING: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $WarningLog | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastSuccessMessage" /t "REG_SZ" /d $WarningLog /f | Out-Null }
		Remove-Variable -Name "SuccessLog" -Force
	}
	
	if ($CriticalLog -ne $false)
	{
		if ($Silent -eq $false) { "CRITICAL: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $CriticalLog | Write-Host -ForegroundColor Yellow }
		if ($HistoryLogFile.Length -gt 1) { "CRITICAL: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CriticalLog | OUT-FILE $HistoryLogFile -Append -Force }
		if ($HistoryLogFile.Length -gt 1) { "CRITICAL: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CriticalLog | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastSuccessMessage" /t "REG_SZ" /d $CriticalLog /f | Out-Null }
		Remove-Variable -Name "SuccessLog" -Force
	}
	
	if ($ErrorLog -ne $false)
	{
		
		$CurrentError = $global:Error[0]
		
		if ($Silent -eq $false) { "ERROR: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $EErrorLog | Write-Host -ForegroundColor Red }
		if ($Silent -eq $false) { "ERRORMSG: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $CurrentError | Write-Host -ForegroundColor Red }
		if ($HistoryLogFile.Length -gt 1) { "ERROR: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $EErrorLog | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "ERROR: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $EErrorLog | OUT-FILE $CurrentLogFile -Append -Force }
		if ($HistoryLogFile.Length -gt 1) { "ERRORMSG: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CurrentError | OUT-FILE $HistoryLogFile -Append -Force }
		if ($CurrentLogFile.Length -gt 1) { "ERRORMSG: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $CurrentError | OUT-FILE $CurrentLogFile -Append -Force }
		if ($regpath.Length -gt 1) { reg add $regpath /v "LastErrorMessage" /t "REG_SZ" /d $EErrorLog /f | Out-Null }
		Remove-Variable -Name "CurrentError" -Force
		Remove-Variable -Name "ErrorLog" -Force
	}
	
	if ($MultiLog -ne $false)
	{
		$MultiLog | ForEach-Object {
			if ($Silent -eq $false) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " " + $CurrentTime + " `t" + "[$component]" + " `t" + $_ | Write-Host }
			if ($HistoryLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $_ | OUT-FILE $HistoryLogFile -Append -Force }
			if ($CurrentLogFile.Length -gt 1) { "INFORMATION: " + "`t[" + $CurrentLine + "]`t " + $Env:COMPUTERNAME + " `t" + $CurrentTime + " `t" + "[$component]" + " `t" + $_ | OUT-FILE $CurrentLogFile -Append -Force }
		}
		Remove-Variable -Name "MultiLog", "regpath" -Force
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
				if (((($HistoryLogFileProperties).Length / 1MB) -gt $LogfileSizeMB) -or ($LogfileSizeMB -eq 0))
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