Dim wshell : Set wshell = CreateObject("wscript.shell")
Dim strCwd : strCwd =wshell.CurrentDirectory
Dim strFileToOpen

If WScript.Arguments.length = 0 Then 
	WScript.Echo("No File to open")
	WScript.Quit(1)
Else
	strFileToOpen=WScript.Arguments.Item(0)
End If

Dim strStartTime : strStartTime = now
Dim strEndTime
Dim StartTime: StartTime=Timer()
Dim EndTime

Dim oWord: Set oWord=CreateObject("Word.application")
oWord.Documents.Open(strFileToOpen)
oWord.Visible=True
EndTime=Timer()
strEndTime=now
oWord.Quit
Set oWord=Nothing
Set wshell=Nothing


Import strCwd & "\..\..\Lib\Ini.vbs"
Dim Iteration: Iteration=ReadIni(strCwd & "\..\UserScenariosConfig.ini","Settings","Iterations")
WriteIni strCwd & "\..\Logs\Report.ini","Iteration_" & Iteration,"OpenDOC_StartTime",strStartTime
WriteIni strCwd & "\..\Logs\Report.ini","Iteration_" & Iteration,"OpenDOC_EndTime",strEndTime
WriteIni strCwd & "\..\Logs\Report.ini","Iteration_" & Iteration,"OpenDOC_TimeTaken",(EndTime-StartTime)




'-------------------------------------------------------------
' Imports an Ini file.
'-------------------------------------------------------------
Sub Import(strFile)
		Set fso=CreateObject("scripting.filesystemobject")
		Set objFile = fso.OpenTextFile(strFile)
		strCode = objFile.ReadAll
		objFile.Close
		ExecuteGlobal strCode
		Set fso=Nothing
End Sub
