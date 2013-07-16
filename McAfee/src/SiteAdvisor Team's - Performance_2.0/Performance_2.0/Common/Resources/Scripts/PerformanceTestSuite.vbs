Set fso=CreateObject("scripting.filesystemobject")
Set wshell=CreateObject("wscript.shell")

Import ".\resources\scripts\Ini.vbs"

Sub Import(strFile)
		Set objFile = fso.OpenTextFile(strFile)
		strCode = objFile.ReadAll
		objFile.Close
		ExecuteGlobal strCode
End Sub


function GetCurrentDir

	Path=CStr(document.Location.href)
	NewPath=Replace(Path,"file:///","",1,-1,1)
	NewPath=Replace(NewPath,"%20"," ",1,-1,1)
	Basepath=fso.GetParentFolderName(NewPath)
	GetCurrentDir=Basepath

End function


Sub SaveConfig

	IniFile=GetCurrentDir & "/" & "Main.ini"
	Set Ini=fso.OpenTextFile(IniFile,2,True)
	Ini.WriteLine("[Config]")
	If form_main.chk_Product_Scenarios.checked=True Then Ini.WriteLine("Product Scenarios=1") Else Ini.WriteLine("Product Scenarios=0")
	If form_main.chk_user_scenarios.checked=True Then Ini.WriteLine("User Scenarios=1") Else Ini.WriteLine("User Scenarios=0")
	If form_main.chk_restart.checked=True Then Ini.WriteLine("Restart=1") Else Ini.WriteLine("Restart=0")
	Ini.WriteLine("Restarted=0")
	Ini.Close
	
	If MsgBox("Do you want to start test now?",4,"Confirmation") = 6 Then
		RunTest
	End if
End Sub


Sub RunTest

	return=wshell.Run("perl ./main.pl /setup",3,true)
	MsgBox "Test Completed !!!"
End Sub


Sub LoadSettings
	Window.resizeto 900,600
	If ReadIni("Main.ini","Config","Product Scenarios")=1 Then form_main.chk_Product_Scenarios.checked=True
	If ReadIni("Main.ini","Config","User Scenarios")=1 Then form_main.chk_user_scenarios.checked=True
	If ReadIni("Main.ini","Config","Restart")=1 Then form_main.chk_restart.checked=True
End Sub


