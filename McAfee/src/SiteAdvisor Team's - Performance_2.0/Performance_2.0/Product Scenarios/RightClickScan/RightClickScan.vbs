'
' RightClickScan.vbs
'
' Usage:
'	RightClickScan item1, item2, ...
'
' Example: 
'	RightClickScan C:\Windows
'	RightClickScan C:\EITV10.1 C:\EITV11
'
Option Explicit
On Error Resume Next
'
' Get scan list from command line parameters
'

Dim Unnamed
Dim WhatToScan
Dim	Index

Set Unnamed = WScript.Arguments.Unnamed

If Unnamed.Length = 0 Then
	WScript.Echo "RightClickScan item1, item2, ..."
	WScript.Quit(1)
End If



ReDim WhatToScan(Unnamed.Length)
For Index = 0 To Unnamed.Length - 1
	WhatToScan (Index) = Unnamed.Item (Index)
Next

'
' Create Helper Object
'
Dim Helper
Set Helper = CreateObject ("McTestHelper.TestUtils")

'
' Create Configuration Object
'
Dim OdsAx
Dim Config
Dim lResult
Const MCODS_SCANTYPE_RIGHT_CLICK = 2
Set OdsAx = Helper.GetDispInterface ( _
				"{162EFDC5-2957-465d-887B-590AF4A7E84D}", _
				"{4AEAB58D-9AB4-45ba-8140-9DF195C159B1}")

lResult = OdsAx.GetConfig (MCODS_SCANTYPE_RIGHT_CLICK, -1, Config)

If lResult <> 0 Then
	lResult = OdsAx.CreateNewConfig (MCODS_SCANTYPE_RIGHT_CLICK, Config)
End If

If lResult <> 0 Then
	WScript.Echo "GetConfig/CreateNewConfig=" & Hex (lResult)
	WScript.Quit(1)
End If


'
' Create ODS Object and get scan session and scanner
'
Dim ODS
Dim Session
Dim Scanner
Dim CreateNew
Dim ScanType
Set ODS = Helper.GetDispInterface ( _
				"{C98F04D7-CD30-4bb0-B7D7-8DD7448520F2}", _
				"{FF05BE55-95A5-4e80-8482-A56850C4A2FC}")

Const MCODS_FLAG_CREATE_NEW_SESSION = 1

lResult = ODS.GetScanSession (				_
			MCODS_FLAG_CREATE_NEW_SESSION,	_
			MCODS_SCANTYPE_RIGHT_CLICK,		_
			Session,						_
			CreateNew,						_
			ScanType)
If lResult <> 0 Then
	WScript.Echo Hex (lResult) & "-" & CreateNew & "-" & ScanType
	WScript.Quit(1)
End If
			
Set Scanner = Session.GetScanner ()


'
' Set Config Id and Config
'
Session.SetConfigId (0)

Scanner.SetConfig (Config)

'
' Start Scan
'
lResult = Scanner.Scan2 (Empty, Empty, WhatToScan)
If lResult <> 0 Then
	WScript.Echo "Scanner.Scan2=" & Hex (lResult)
	WScript.Quit(1)
End If

'
' wait until scan complete
'

Dim fso
Dim logg
Dim objWMIService
Dim colItems
Dim item
Dim mcodsPid_before
Dim mcodsPid_after
Dim strComputer
Dim fldrs
Dim subfldrs
Dim fld


Set fso=CreateObject("Scripting.FileSystemObject")
Set logg=fso.OpenTextFile("D:\LVTAutomation\Client\Logs\ODS.log",8,1)

strComputer = "."

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select *  from Win32_Process",,48)

For each item In colItems
If StrComp("mcods.exe",item.Name,1)=0 Then
mcodsPid_before=item.ProcessId

Set fldrs=fso.GetFolder("D:\test\odsrep")
Set subfldrs=fldrs.SubFolders
For Each fld In subfldrs
logg.WriteLine "Running ODS on : " & fld.Name
Next


WScript.Echo "McODS PID After ODS Started : " & mcodsPid_before
logg.WriteLine "McODS PID After ODS Started : " & mcodsPid_before
End If 
Next


Dim ID
Dim Info1
Dim Info2
Const ODS_PROG_SCAN_COMPLETED = 4
Const ODS_PROG_SESSION_CLOSED = &H10003
Do 
	ID = Empty
	Info1 = Empty
	Info2 = Empty
	lResult = Session.GetScanProgress (ID, Info1, Info2)
	If lResult <> 0 Then
		WScript.Echo "Session.GetScanProgress=" & Hex (lResult)
		'WScript.Quit(1)
	End If
	If ID = ODS_PROG_SCAN_COMPLETED Then
		Set colItems = objWMIService.ExecQuery("Select *  from Win32_Process",,48)
		For each item In colItems
			If StrComp("mcods.exe",item.Name,1)=0 Then
				mcodsPid_after=item.ProcessId
			End If 
		Next
		lResult = Session.CloseSession ()
		WScript.Echo "McODS PID After ODS finished : " & mcodsPid_after
		logg.WriteLine "McODS PID After ODS finished : " & mcodsPid_after
		logg.WriteLine "#############################################"
		If mcodsPid_before=mcodsPid_after Then
			WScript.Quit(0)
		Else
			WScript.Quit(2)
		End If 
	End If
	wscript.sleep 2000
Loop Until ID = ODS_PROG_SESSION_CLOSED

If Err.Number <> 0 Then
	WScript.Quit(1)
End if