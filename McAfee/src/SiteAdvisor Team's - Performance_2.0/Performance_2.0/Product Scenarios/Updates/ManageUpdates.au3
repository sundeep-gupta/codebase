#Include <Date.au3>


; Use mouse clicks relative to current window
AutoItSetOption("MouseCoordMode", 0)
$download=0
$UpdateInit=0
$UpdateComplete=0
$timeout = 60*60*1000 ; 60 minute
$begin=0

if ($CmdLine[0] > 0) then 
	If($CmdLine[1] = "/download") Then
		$download=1
	endif
endif

; Load Environment Variables here
$ProgramFiles = EnvGet("ProgramFiles")
$StartUpdate = $ProgramFiles & "\McAfee.com\Agent\McUpdate.exe /schedule"

StartUpdateCheck()

Func StartUpdateCheck()
	
	$UpdateInitStartTime=_NowCalc()
	$begin = TimerInit()
	Run($StartUpdate)
	WaitForUpdateAlert()
	$UpdateInitEndTime=_NowCalc()
	$UpdateInit=TimerDiff($begin)
	

	if($download==1) Then
		SelectDownload()
		$UpdateDownloadStartTime=_NowCalc()
		$begin=TimerInit()
		WaitForUpdateComplete()
		$UpdateDownloadEndTime=_NowCalc()
		$UpdateComplete=TimerDiff($begin)
		$Iteration=IniRead(@ScriptDir & "\..\ProductScenariosConfig.ini","Settings","IterationCounter","Not Found")
		$Iteration=$Iteration+1
		IniWrite(@ScriptDir & "\..\Logs\Report.ini","Iteration_"&$Iteration,"Update_StartTime",$UpdateDownloadStartTime)
		IniWrite(@ScriptDir & "\..\Logs\Report.ini","Iteration_"&$Iteration,"Update_EndTime",$UpdateDownloadEndTime)
		IniWrite(@ScriptDir & "\..\Logs\Report.ini","Iteration_"&$Iteration,"Update_TimeTaken",$UpdateComplete/1000)
		Close()
	Else
		$Iteration=IniRead(@ScriptDir & "\..\ProductScenariosConfig.ini","Settings","IterationCounter","Not Found")
		IniWrite(@ScriptDir & "\..\Logs\Report.ini","Iteration_"&$Iteration,"UpdateInit_StartTime",$UpdateInitStartTime)
		IniWrite(@ScriptDir & "\..\Logs\Report.ini","Iteration_"&$Iteration,"UpdateInit_EndTime",$UpdateInitEndTime)
		IniWrite(@ScriptDir & "\..\Logs\Report.ini","Iteration_"&$Iteration,"UpdateInit_TimeTaken",$UpdateInit/1000)
		Close()
	EndIf
EndFunc

Func WaitForUpdateAlert()

	while(1)
		if (WinExists("McAfee Alert Window") == 1 ) then
			WinActivate("McAfee Alert Window")
			$strToasterText = ControlGetText("McAfee Alert Window", "", "McRichEditClass1")
			if @error then 
				sleep(100)
			elseif ( StringInStr($strToasterText, "Update", 1) ) then
				Return(0)
			EndIf
		else
			$diff = TimerDiff($begin)
			if ( $diff > $timeout ) then
				MsgBox(0,"Error","Updates Timed Out")
				Exit(100)
			endif
			sleep(1000)
		endif
	wend
EndFunc

Func WaitForUpdateComplete()
	
	while 1
		if ( WinExists("McAfee Alert Window") == 1 ) then
			WinActivate("McAfee Alert Window")
			$strToasterText = ControlGetText("McAfee Alert Window", "", "McAlertHeaderWndClass1")
			if ( StringInStr($strToasterText, "Installation Complete", 1) ) then
				Return
			EndIf
		else
			sleep(1000)
		endif
	wend
EndFunc

Func SelectDownload()
	
	WinActivate("McAfee Alert Window")
	ControlClick ("McAfee Alert Window", "", "McAlertButtonClass1")
	$pos = ControlGetPos("McAfee Alert Window", "", "McXpBtn21")
	MouseClick("left", $pos[0] + $pos[2]/2, $pos[1] + $pos[3]/2)
	
EndFunc

Func Close()
	
	WinActivate("McAfee Alert Window")
	ControlClick ("McAfee Alert Window", "", "McAlertButtonClass3")
	$pos = ControlGetPos("McAfee Alert Window", "", "McXpBtn21")
	MouseClick("left", $pos[0] + $pos[2]/2, $pos[1] + $pos[3]/2)
EndFunc