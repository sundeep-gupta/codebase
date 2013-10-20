;---------------------------------------------------------
;~ Download_Dialog_FF.au3
;  To handle the Download/save Dialogbox in Firefox
;~ Usage: Save_Dialog.exe "Dialog Title" "Operation" "Path"
;~ Author: Pjames
;----------------------------------------------------------

; set the select mode to select using substring
AutoItSetOption("WinTitleMatchMode","2") 

if $CmdLine[0] < 2 then 
	; Arguments are not enough
	;msgbox(0,"Error","Supply all the Arguments, Dialog title,Save/Cancel and Path to save(optional)")
	Exit
EndIf

; wait Until dialog box appears
WinWait($CmdLine[1]) ; match the window with substring 
$title = WinGetTitle($CmdLine[1]) ; retrives whole window title 
WinActive($title)
WinActivate($title)

	; If firefox is set the save the file on some specify location without asking to user. 
	; It will be save after this point.
	;If not A new Dialog will appear prompting for Path to save
	
	if WinExists($title) Then
		if($CmdLine[0] = 2) Then
			; Save File
			WinActivate($title)
			ControlClick($title,"","Button2")			
		Else
			;Set path and save file
			WinActive($title)
			WinActivate($title)
			WinWaitActive($title)
			ControlSetText($title,"","Edit1",$CmdLine[3])
			if (@OSVersion = "Win_XP") Then
				WinActive($title)
				WinActivate($title)
				ControlClick($title,"","Button2")
				Sleep(3000)
				; Click on Overwrite file if a copy of the downloaded file exists already.
				if WinExists("Enter name of file to save to…") Then
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
			Sleep(20000)
		EndIf

	Else
		;Firefox is configured to save file at specific location
		Exit
	EndIf	

; do not save the file
If (StringCompare($CmdLine[2],"Cancel",0) = 0) Then
	WinActive($title)
	WinWaitActive($title)
	Send("{ESCAPE}")
EndIf

While 1
		$var = WinGetTitle('')
		WinActive("Downloads")
		Sleep(10000)
		if StringInStr($var, "Downloads") Then
			WinClose("Downloads")
			Exit
		EndIf
		
WEnd
Exit







