; Title : vssScript
; Function : To create the directry structure for each new project
; Author : Sundeep Kumar
; Company :	Applabs Technologies, Hyderabad

#include<GUIConstants.au3>

;Global Variable Declaration

;Local Variable Declaration
Dim $sGUITitle = "Add New Project"
Dim $iWidth = 400, $iHeight = 300
Dim $iLeft = -1, $iTop = -1
Dim $iStyle = $WS_MINIMIZEBOX + $WS_CAPTION + $WS_POPUP + $WS_SYSMENU 
Dim $iExStyle = -1

;Variables having Handles of Controls
Dim $hGUI,$hNameLabel,$hNameEdit,$hCancelButton,$hCreateButton

;Create the GUI Window

$hGUI = GUICreate($sGUITitle,$iWidth,$iHeight,$iLeft,$iTop,$iStyle,$iExStyle)

$hNameLabel = GUICtrlCreateLabel("Project :",20,30)

$hNameEdit = GUICtrlCreateEdit("",70,30,200)

$hCreateButton = GUICtrlCreateButton("C&reate",100,250,100,30)

$hCancelButton = GUICtrlCreateButton("&Cancel",220,250,100,30)
GUISetState ()
While 1
	$msg = GUIGetMsg($hGUI)
	Select
	Case $msg = $hCancelButton OR $msg = $GUI_EVENT_CLOSE
		ExitLoop
	Case $msg = $hCreateButton
		$sProjectName = GUICtrlRead($hNameEdit)
		$bRes = isProjectNameValid($sProjectName)
		if ($bRes = 0) Then
			MsgBox(0,"Error!","Cannot Create Project Structure")
		Else
			CreateProjectStructure($sProjectName)
			MsgBox(0,"Created","Successfully Created Project Structure")	
		EndIf
	EndSelect
WEnd
GUIDelete($hGUI)


;User Defined Functions

; Use : 	To create the Directory structure with 
;			"$sProjectName" as ROOT
;Working:	Creates a folder with the "PROJECT'S NAME"
;			Then uses a text file to create subdirectories
;			File contains the name of the subfolders to be created.
;Return :	None
Func CreateProjectStructure($sProjectName)

EndFunc


;Use :		To Check whether any folder with that name alread exists
;Return : 	0 if folder exists 1 otherwise
Func isProjectNameValid($sProjectName)
	return 1
EndFunc
