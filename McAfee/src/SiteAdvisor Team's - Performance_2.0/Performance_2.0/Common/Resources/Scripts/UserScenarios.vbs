On Error Resume Next

Set fso=CreateObject("scripting.filesystemobject")
Set wshell=CreateObject("wscript.shell")
Dim IniFile
Import ".\resources\scripts\Ini.vbs"

Sub Import(strFile)
		Set objFile = fso.OpenTextFile(strFile)
		strCode = objFile.ReadAll
		objFile.Close
		ExecuteGlobal strCode
End Sub

function GetCwd
	
	Path=CStr(document.Location.href)
	NewPath=Replace(Path,"file:///","",1,-1,1)
	NewPath=Replace(NewPath,"%20"," ",1,-1,1)
	Basepath=fso.GetParentFolderName(NewPath)
	Basepath=fso.GetParentFolderName(Basepath)
	GetCwd=Basepath
	
End Function


Sub GetFileCopySrcDest
	Basepath=GetCwd()
'	Basepath=fso.GetParentFolderName(Basepath)
	frm_userscenarios.txt_copysrc.value=Basepath & "/User Scenarios/FileCopy/Source Data"
	frm_userscenarios.txt_copydst.value=Basepath & "/User Scenarios/FileCopy/Destination"
End Sub

Sub SetHomepagelist
	Basepath=GetCwd()
'	Basepath=fso.GetParentFolderName(Basepath)
	frm_userscenarios.txt_homepagefilelist.value=Basepath & "/User Scenarios/Homepage/Homepages.txt"
End Sub

Sub SetRGYSiteslist
	Basepath=GetCwd()
'	Basepath=fso.GetParentFolderName(Basepath)
	frm_userscenarios.txt_rgysitelist.value=Basepath & "/User Scenarios/RGY/RGYSites.txt"
End Sub

Sub SaveConfig
	
	Cwd=GetCwd()
	IniFile=Cwd & "/User Scenarios/" & "UserScenariosConfig.ini"
	WriteIni IniFile,"Settings","Iterations",frm_userscenarios.cmb_iterations.value
	WriteIni IniFile,"Settings","IterationCounter",0
	WriteIni IniFile,"Settings","SleepTime",frm_userscenarios.cmb_sleeptime.value

	'The Filecopying Test case
	If frm_userscenarios.chk_runfilecopy.checked Then
		WriteIni IniFile,"FileCopy","Run",1
		WriteIni IniFile,"FileCopy","Source",frm_userscenarios.txt_copysrc.value
		WriteIni IniFile,"FileCopy","Destination",frm_userscenarios.txt_copydst.value
	Else
		WriteIni IniFile,"FileCopy","Run",0
	End If

	'The Application opening test case
	If frm_userscenarios.chk_runapps.checked Then
		WriteIni IniFile,"Applications","Run",1
		If frm_userscenarios.chk_word.checked Then WriteIni IniFile,"Applications","Word",1 Else WriteIni IniFile,"Applications","Word",0
		If frm_userscenarios.chk_excel.checked Then WriteIni IniFile,"Applications","Excel",1 Else WriteIni IniFile,"Applications","Excel",0
		If frm_userscenarios.chk_ppt.checked Then WriteIni IniFile,"Applications","PPT",1 Else WriteIni IniFile,"Applications","PPT",0
		If frm_userscenarios.chk_pdf.checked Then WriteIni IniFile,"Applications","PDF",1 Else WriteIni IniFile,"Applications","PDF",0
		If frm_userscenarios.chk_mp3.checked Then WriteIni IniFile,"Applications","MP3",1 Else WriteIni IniFile,"Applications","MP3",0
	Else
		WriteIni IniFile,"Applications","Run",0
	End If

	'The IE blank page test case
	If frm_userscenarios.chk_ieblankrun.checked Then WriteIni IniFile,"IEblank","Run",1 Else WriteIni IniFile,"IEblank","Run",0

	'The home page test case
	If frm_userscenarios.chk_iehomepagerun.checked Then 
		WriteIni IniFile,"IEHomepage","Run",1
		WriteIni IniFile,"IEHomepage","Homepagelistfile",frm_userscenarios.txt_homepagefilelist.value
	Else 
		WriteIni IniFile,"IEHomepage","Run",0
	End if

	'The Red/Green and yellow website test cases.
	If frm_userscenarios.chk_iergysites.checked Then
		WriteIni IniFile,"RGY","Run",1
		WriteIni IniFile,"RGY","RGYList",frm_userscenarios.txt_rgysitelist.value
	Else
		WriteIni IniFile,"RGY","Run",0
	End if

	'The Website and Keyword filtering test case
	If frm_userscenarios.chk_runfiltering.checked Then WriteIni IniFile,"Filter","Run",1 Else WriteIni IniFile,"Filter","Run",0
	If frm_userscenarios.chk_websitefiltering.checked Then WriteIni IniFile,"Filter","WebSiteFilter",1 Else WriteIni IniFile,"Filter","WebSiteFilter",0
	If frm_userscenarios.chk_keywordfiltering.checked Then WriteIni IniFile,"Filter","KeywordFilter",1 Else WriteIni IniFile,"Filter","KeywordFilter",0
	If frm_userscenarios.chk_imagefiltering.checked Then WriteIni IniFile,"Filter","ImageFilter",1 Else WriteIni IniFile,"Filter","ImageFilter",0
	WriteIni IniFile,"Filter","Limited UserName",frm_userscenarios.txt_limitedusername.value
	WriteIni IniFile,"Filter","Limited Password",frm_userscenarios.txt_limpassword.value
	WriteIni IniFile,"Filter","Admin UserName",frm_userscenarios.txt_adminusername.value
	WriteIni IniFile,"Filter","Admin Password",frm_userscenarios.txt_adminpassword.value
	WriteIni IniFile,"Filter","Running",0

	'FireFox test
	If frm_userscenarios.chk_firefox.checked Then WriteIni IniFile,"Firefox","Run",1 Else WriteIni IniFile,"Firefox","Run",0

	
	MsgBox "Configuration file created successfully",0,"Configuration"
	
End Sub


Sub LoadConfig
	
	On Error Resume Next
	Cwd=GetCwd()
	IniFile=Cwd & "/User Scenarios/" & "UserScenariosConfig.ini"
	If Not fso.fileexists(IniFile) Then Exit Sub
	
	frm_userscenarios.cmb_iterations.value=ReadIni(IniFile,"Settings","Iterations")
	frm_userscenarios.cmb_sleeptime.value=ReadIni(IniFile,"Settings","SleepTime")
	
	If ReadIni(IniFile,"FileCopy","Run")=1 Then
		frm_userscenarios.chk_runfilecopy.checked=True
		frm_userscenarios.txt_copysrc.value=ReadIni(IniFile,"FileCopy","Source")
		frm_userscenarios.txt_copydst.value=ReadIni(IniFile,"FileCopy","Destination")
	End If
	
	If ReadIni(IniFile,"Applications","Run")=1 Then
		frm_userscenarios.chk_runapps.checked=true
		If ReadIni(IniFile,"Applications","Word")=1 Then frm_userscenarios.chk_word.checked=True
		If ReadIni(IniFile,"Applications","Excel")=1 Then frm_userscenarios.chk_excel.checked=True
		If ReadIni(IniFile,"Applications","PPT")=1 Then frm_userscenarios.chk_ppt.checked=True
		If ReadIni(IniFile,"Applications","PDF")=1 Then frm_userscenarios.chk_pdf.checked=True
		If ReadIni(IniFile,"Applications","MP3")=1 Then frm_userscenarios.chk_mp3.checked=True
	End If
	
	'The IE blank page test case
	If ReadIni(IniFile,"IEblank","Run")=1 Then frm_userscenarios.chk_ieblankrun.checked=true

	'The home page test case
	If ReadIni(IniFile,"IEHomepage","Run")=1 Then
		frm_userscenarios.chk_iehomepagerun.checked=True
		frm_userscenarios.txt_homepagefilelist.value=ReadIni(IniFile,"IEHomepage","Homepagelistfile")
	End if
		
	'The Red/Green and yellow website test cases.
	If ReadIni(IniFile,"RGY","Run")=1 Then
		frm_userscenarios.chk_iergysites.checked=True
		frm_userscenarios.txt_rgysitelist.value=ReadIni(IniFile,"RGY","RGYList")
	End If

	'The Website and Keyword filtering test case
	If ReadIni(IniFile,"Filter","Run")=1 Then frm_userscenarios.chk_runfiltering.checked=True
	If ReadIni(IniFile,"Filter","WebSiteFilter")=1 Then frm_userscenarios.chk_websitefiltering.checked=True
	If ReadIni(IniFile,"Filter","KeywordFilter")=1 Then frm_userscenarios.chk_keywordfiltering.checked=True
	If ReadIni(IniFile,"Filter","ImageFilter")=1 Then frm_userscenarios.chk_imagefiltering.checked=True
	frm_userscenarios.txt_limitedusername.value=ReadIni(IniFile,"Filter","Limited UserName")
	frm_userscenarios.txt_limpassword.value=ReadIni(IniFile,"Filter","Limited Password")
	frm_userscenarios.txt_adminusername.value=ReadIni(IniFile,"Filter","Admin UserName")
	frm_userscenarios.txt_adminpassword.value=ReadIni(IniFile,"Filter","Admin Password")

	'Firefox config
	If ReadIni(IniFile,"Firefox","Run")=1 Then frm_userscenarios.chk_firefox.checked=True
	
		
End sub





	
