;---------------------------------------------------------
;~ Install_Agent.au3
;~ To handle the Agent Installation on Windows
;~ Usage: Install_Agent.exe "msi with path"
;~ Author: Pjames
;----------------------------------------------------------

AutoItSetOption("WinTitleMatchMode","2") ; set the select mode to select using substring

if $CmdLine[0] < 1 then 
	; Arguments are not enough
	msgbox(0,"Error","Supply the argument, msi with path")
	Exit
EndIf

ShellExecute($CmdLine[1])
While Not ControlCommand('Connected Backup/PC Agent Installer', '', 'Button1', 'IsEnabled', '')
		Sleep(500)
WEnd
$winText = WinGetText('')
if StringInStr($winText, 'Software already Installed') Then
	ControlClick("Connected Backup/PC Agent Installer", 'Next', "Button1")
	While Not ControlCommand('Connected Backup/PC Agent Installer', 'Ignore', 'Button2', 'IsVisible', '')
		Sleep(500)
	WEnd
	ControlClick("Connected Backup/PC Agent Installer", "", "Button2")
	While Not ControlCommand('Connected Backup/PC Agent Installer', 'Finish', 'Button1', 'IsVisible', '')
		Sleep(500)
	WEnd
	ControlClick("Connected Backup/PC Agent Installer", 'Finish', "Button1")
	ShellExecute($CmdLine[1])
	InstallScript()
Else
	InstallScript()
EndIf


Func InstallScript()
	While Not ControlCommand('Connected Backup/PC Agent Installer', 'Next', 'Button1', 'IsVisible', '')
		Sleep(500)
	WEnd
	ControlClick("Connected Backup/PC Agent Installer", 'Next', "Button1")
	While Not ControlCommand('Connected Backup/PC Agent Installer', 'Back', 'Button4', 'IsVisible', '')
		Sleep(500)
	WEnd
	ControlClick("Connected Backup/PC Agent Installer", 'Accept terms in license agreement', "Button3")
	ControlClick("Connected Backup/PC Agent Installer", 'Next', "Button5")
	While Not ControlCommand('Connected Backup/PC Agent Installer', 'Browse', 'Button1', 'IsVisible', '')
		Sleep(500)
	WEnd
	ControlClick("Connected Backup/PC Agent Installer", 'Next', "Button4")
	While Not ControlCommand('Connected Backup/PC Agent Installer', 'Finish', 'Button1', 'IsVisible', '')
		Sleep(500)
	WEnd
	ControlClick("Connected Backup/PC Agent Installer", 'Finish', "Button1")
	Sleep(10000)
	WinClose("Connected® Backup/PC")
	WinClose("Connected® Backup/PC Agent")
EndFunc	

