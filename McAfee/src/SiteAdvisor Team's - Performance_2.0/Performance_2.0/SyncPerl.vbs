
'If WScript.Arguments.Count = 0 Then
	'MsgBox "Not Enough Parameters. Please specify the server IP",16
	'WScript.Quit(1)
'End if

Continue=MsgBox("All existing folders will be deleted. Do you want to continue?",36)
If Continue=7 Then WScript.Quit(0)


'------------------------------------------
' Set the perl src and destination paths.
'------------------------------------------
Dim Server: Server="smemac"
Dim PerlSrc: PerlSrc="\\" & Server & "\Perl"
Dim PerlDst: PerlDst="C:\Perl"
Dim AutomationSrc : AutomationSrc= "\\" & Server & "\Automation\Performance_2.0"
Dim AutomationDst : AutomationDst= "D:\Performance"
Dim ErrCode

On Error Resume Next
Set fso=CreateObject("scripting.filesystemobject")
fso.CreateFolder ".\Setup"
fso.CopyFile "\\" & Server & "\Automation\Setup\robocopy.exe",".\Setup\robocopy.exe",True

Set wshell=CreateObject("wscript.shell")

'Copy the Perl Folder.
ErrCode=wshell.Run(".\setup\robocopy.exe " & PerlSrc & "\Bin " & PerlDst & "\Bin " & "/mir",1,true)
ErrCode=wshell.Run(".\setup\robocopy.exe " & PerlSrc & "\Lib " & PerlDst & "\Lib " & "/mir",1,true)
ErrCode=wshell.Run(".\setup\robocopy.exe " & PerlSrc & "\Site " & PerlDst & "\Site " & "/mir",1,true)
If ErrCode > 8 Then
	MsgBox "Perl Copying Failed",16
	WScript.Quit(1)
End If

'Set the Environment variable.
Set WshEnv=wshell.Environment("SYSTEM")
OldPath=WshEnv("PATH")
If  InStr(1,OldPath,"Perl\bin",1) = 0 Then
	WshEnv("PATH")="C:\perl\bin;" & OldPath
End if

'ErrCode=wshell.Run(".\setup\robocopy.exe " & AutomationSrc & " " & AutomationDst  & " /mir",1,true)
If ErrCode > 8 Then
	MsgBox "Automation scripts Copying Failed",16
	WScript.Quit(1)
End If

fso.DeleteFolder ".\Setup"
Set wshell=Nothing
Set fso=Nothing

MsgBox "Sync Complete"




