;---------------------------------------------------------
;~ Download_Dialog_IE.au3
;~ To handle the Dowload/save Dialogbox in Internet Explorer
;~ Usage: Download_Dialog.exe "Dialog Title" "Operaion" "Path"
;~ Author : Pjames
;----------------------------------------------------------

AutoItSetOption("WinTitleMatchMode","2") ; set the select mode to select using substring

if $CmdLine[0] < 2 then 
	; Arguments are not enough
	msgbox(0,"Error","Supply all the arguments, Dialog title,Run/Save/Cancel and Path to save(optional)")
	Exit
EndIf

; wait Until dialog box appears
WinWait($CmdLine[1]) ; match the window with substring 
$title = WinGetTitle($CmdLine[1]) ; retrives whole window title 
WinActive($title)
WinActivate($title)

If (StringCompare($CmdLine[2],"Run",0) = 0) Then
	WinActivate($title)
	ControlClick($title,"","Button1")	
EndIf

If (StringCompare($CmdLine[2],"Save",0) = 0) Then
	WinActive($title)
	WinWaitActive($title)
	WinActivate($title)
	ControlClick($title,"","Button2")
	; Wait for the new dialogbox to open
	Sleep(2)
	WinWait("Save As")
	$title = WinGetTitle("Save As") 
	;$title = WinGetTitle("[active]") 
	if($CmdLine[0] = 2) Then
		;click on the save button 
		WinActivate($title)
		WinWaitActive($title)
		ControlClick($title,"","Button2")
	Else
		;Set path and save file
		WinActive($title)
		WinActivate($title)
		WinWaitActive($title)
		ControlSetText($title,"","Edit1",$CmdLine[3])
		sleep(3000)
		; Click on Overwrite file if a copy of the downloaded file exists already.
		if (@OSVersion = "Win_XP")  Then
			WinActive($title)
				WinActivate($title)
				Send("{ENTER}")
				Sleep(3000)
				; Click on Overwrite file if a copy of the downloaded file exists already.
				if WinExists("Save As") Then
					WinActive($title)
					WinActivate($title)
					ControlClick($title,"","Button1")
				EndIf
		ElseIf (@OSVersion = "Win_7") Then
				WinActive($title)
				WinActivate($title)
				ControlClick($title,"","Button1")
				Sleep(3000)
					if WinActive("Confirm Save As") Then
					WinActivate("Confirm Save As")
					ControlClick("Confirm Save As","",'[CLASS:Button; INSTANCE:1]')
					EndIf
		EndIf	
		;WinWait("Download Complete")
	EndIf
	
EndIf

If (StringCompare($CmdLine[2],"Cancel",0) = 0) Then
	WinActive($title)
	ControlClick($title,"","Button3")
EndIf

; Click on Download Complete Dialog
While 1
		$var = WinGetTitle('')
		WinActive("Download complete")
		WinActivate("Download complete")
		Sleep(10000)
		;MsgBox('', '', $var)
		if StringInStr($var, "Download complete") Then
			;Send("{TAB}")
			;Send("{ENTER}")
			ControlClick("Download complete", '', '[CLASS:Button; INSTANCE:4]')
			;ControlClick('', '', 'Button4')
			Exit
		EndIf
WEnd
Exit
	



