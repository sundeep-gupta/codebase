On Error Resume next
Set fso=CreateObject("scripting.filesystemobject")
Set wshell=CreateObject("wscript.shell")

Import ".\resources\scripts\Ini.vbs"

Sub Import(strFile)
		Set objFile = fso.OpenTextFile(strFile)
		strCode = objFile.ReadAll
		objFile.Close
		ExecuteGlobal strCode
End Sub

IniFile=""

Sub GetINI

	Path=CStr(document.Location.href)
	NewPath=Replace(Path,"file:///","",1,-1,1)
	NewPath=Replace(NewPath,"%20"," ",1,-1,1)
	Basepath=fso.GetParentFolderName(NewPath)
	Basepath=fso.GetParentFolderName(Basepath)
	
	'Set Ini=fso.createtextfile(Basepath & "/Product Scenarios/" & "ProductScenariosConfig.ini")
	IniFile=Basepath & "/Product Scenarios/" & "ProductScenariosConfig.ini"
	
End Sub

Sub GetInstallDir
	
	On Error Resume Next
	InstallDir=wshell.RegRead("HKLM\SOFTWARE\McAfee\MSC\Install Dir")
	If fso.FileExists(InstallDir & "\mcshell.exe") Then
		form_productscenario.file_mcshellpath.value=InstallDir & "\mcshell.exe"
	Else
		form_productscenario.file_mcshellpath.value="MSC not installed"
		MsgBox "McAfee Consumer Products are not installed. Please Install and then run the test",,"Message"
		'form_productscenario.btn_save.disabled=True
		Exit sub
	End if
End Sub

Sub SaveConfig
	
	GetINI

	WriteIni IniFile,"Settings","Iterations",form_productscenario.cmb_iterations.value
	WriteIni IniFile,"Settings","IterationCounter",0
	WriteIni IniFile,"Settings","SleepTime",form_productscenario.cmb_sleeptime.value

	If form_productscenario.chk_runupdates.checked Then WriteIni IniFile,"Updates","Run",1	Else WriteIni IniFile,"Updates","Run",0
	If form_productscenario.chk_updates_init.checked Then WriteIni IniFile,"Updates","CheckInitTime",1 	Else WriteIni IniFile,"Updates","CheckInitTime",0
	
	If form_productscenario.chk_msc_updates.checked=True Then WriteIni IniFile,"Updates","MSC",1 Else WriteIni IniFile,"Updates","MSC",0
	If form_productscenario.chk_mpf_updates.checked=True Then WriteIni IniFile,"Updates","MPF",1 Else WriteIni IniFile,"Updates","MPF",0
	If form_productscenario.chk_mps_updates.checked=True Then WriteIni IniFile,"Updates","MPS",1 Else WriteIni IniFile,"Updates","MPS",0
	If form_productscenario.chk_mhn_updates.checked=True Then WriteIni IniFile,"Updates","MHN",1 Else WriteIni IniFile,"Updates","MHN",0
	If form_productscenario.chk_nmc_updates.checked=True Then WriteIni IniFile,"Updates","NMC",1 Else WriteIni IniFile,"Updates","NMC",0
	If form_productscenario.chk_mbk_updates.checked=True Then WriteIni IniFile,"Updates","MBK",1 Else WriteIni IniFile,"Updates","MBK",0
	If form_productscenario.chk_mqc_updates.checked=True Then WriteIni IniFile,"Updates","MQC",1 Else WriteIni IniFile,"Updates","MQC",0

	'Configuration for MSK
	If form_productscenario.chk_mskfilter_updates.checked=True And form_productscenario.chk_mskproduct_updates.checked=True Then 
		WriteIni IniFile,"Updates","MSK",CInt(form_productscenario.chk_mskfilter_updates.value) + CInt(form_productscenario.chk_mskproduct_updates.value)
	ElseIf form_productscenario.chk_mskfilter_updates.checked=True And form_productscenario.chk_mskproduct_updates.checked=false Then
		WriteIni IniFile,"Updates","MSK",CInt(form_productscenario.chk_mskfilter_updates.value)
	ElseIf form_productscenario.chk_mskfilter_updates.checked=false And form_productscenario.chk_mskproduct_updates.checked=true Then
		WriteIni IniFile,"Updates","MSK",CInt(form_productscenario.chk_mskproduct_updates.value)
	Else
		WriteIni IniFile,"Updates","MSK",0
	End If

	'Configuration for VSO
	If form_productscenario.chk_vsodat_updates.checked=True And form_productscenario.chk_vsoproduct_updates.checked=True Then 
		WriteIni IniFile,"Updates","VSO",CInt(form_productscenario.chk_vsodat_updates.value) + CInt(form_productscenario.chk_vsoproduct_updates.value)
	ElseIf form_productscenario.chk_vsodat_updates.checked=True And form_productscenario.chk_vsoproduct_updates.checked=false Then
		WriteIni IniFile,"Updates","VSO",CInt(form_productscenario.chk_vsodat_updates.value)
	ElseIf form_productscenario.chk_vsodat_updates.checked=false And form_productscenario.chk_vsoproduct_updates.checked=true Then
		WriteIni IniFile,"Updates","VSO",CInt(form_productscenario.chk_vsoproduct_updates.value)
	Else
		WriteIni IniFile,"Updates","VSO",0
	End If
	
	'For Email Scan
	If form_productscenario.chk_runemailscan.checked=True then

		WriteIni IniFile,"EmailScan","Run",1
		WriteIni IniFile,"EmailScan","FirstSendSuccess",0
		WriteIni IniFile,"EmailScan","RunOnce",0
		If form_productscenario.chk_deletemails.checked=True Then WriteIni IniFile,"EmailScan","DeleteOnServer",1 Else WriteIni IniFile,"EmailScan","DeleteOnServer",0
		If form_productscenario.radio_sendemails(0).checked=True then 
			WriteIni IniFile,"EmailScan","SendEmails",0
		Elseif form_productscenario.radio_sendemails(1).checked=True Then 
			WriteIni IniFile,"EmailScan","SendEmails",1
		Else 
			WriteIni IniFile,"EmailScan","SendEmails",2
		End if
		If form_productscenario.chk_cleanemails.checked=True Then
			WriteIni IniFile,"EmailScan","Clean",1
			WriteIni IniFile,"EmailScan","Clean_PopServer",form_productscenario.txt_cleanpopserver.value
			WriteIni IniFile,"EmailScan","Clean_UserName",form_productscenario.txt_cleanusername.value
			WriteIni IniFile,"EmailScan","Clean_ToEmailID",form_productscenario.txt_cleantoemailid.value
			WriteIni IniFile,"EmailScan","Clean_Password",form_productscenario.txt_cleanpassword.value
		Else
			WriteIni IniFile,"EmailScan","Clean",0
		End If
		
		If form_productscenario.chk_spamemails.checked=True Then
			WriteIni IniFile,"EmailScan","Spam",1
			WriteIni IniFile,"EmailScan","Spam_PopServer",form_productscenario.txt_spampopserver.value
			WriteIni IniFile,"EmailScan","Spam_UserName",form_productscenario.txt_spamusername.value
			WriteIni IniFile,"EmailScan","Spam_ToEmailID",form_productscenario.txt_spamtoemailid.value
			WriteIni IniFile,"EmailScan","Spam_Password",form_productscenario.txt_spampassword.value
		Else
			WriteIni IniFile,"EmailScan","Spam",0
		End if
	Else
		WriteIni IniFile,"EmailScan","Run",0
	End If

	'McShell startup
	If form_productscenario.chk_runmcshell.checked=True Then
		WriteIni IniFile,"McShell Startup","Run",1
		WriteIni IniFile,"McShell Startup","Path",form_productscenario.file_mcshellpath.value
	Else
		WriteIni IniFile,"McShell Startup","Run",0
	End If

	'System scan config
	If form_productscenario.chk_runsystemscan.checked=True Then
		WriteIni IniFile,"System Scan","Run",1
	Else
		WriteIni IniFile,"System Scan","Run",0
	End If

	'Incremental DAT update
	If form_productscenario.chk_runinrcmtlupdates.checked=True Then WriteIni IniFile,"IncrementalDATUpdates","Run",1 Else WriteIni IniFile,"IncrementalDATUpdates","Run",0
		
	'RightCLick Scan
	If form_productscenario.chk_runrightclickscan.checked=True Then WriteIni IniFile,"RightClickScan","Run",1 Else WriteIni IniFile,"RightClickScan","Run",0
	
	'RightCLick Scan
	If form_productscenario.chk_runscheduledscan.checked=True Then WriteIni IniFile,"ScheduledScan","Run",1 Else WriteIni IniFile,"ScheduledScan","Run",0

	'Artemis ON-ODS
	If form_productscenario.chk_runodsartemis.checked=True Then WriteIni IniFile,"ArtemisODS","Run",1 Else WriteIni IniFile,"ArtemisODS","Run",0
	
	MsgBox "Configuration file created successfully",0,"Configuration"
	
End Sub


Sub LoadConfig
	
	On Error Resume Next
	GetINI
	If Not fso.fileexists(IniFile) Then Exit Sub
	form_productscenario.cmb_iterations.value=ReadIni(IniFile,"Settings","Iterations")
	form_productscenario.cmb_sleeptime.value=ReadIni(IniFile,"Settings","SleepTime")
	If ReadIni(IniFile,"Updates","Run")=1 then form_productscenario.chk_runupdates.checked=True
	If ReadIni(IniFile,"Updates","CheckInitTime")=1 then form_productscenario.chk_updates_init.checked=True
	If ReadIni(IniFile,"Updates","MQC")=1 then form_productscenario.chk_mqc_updates.checked=True
	If ReadIni(IniFile,"Updates","MBK")=1 then form_productscenario.chk_mbk_updates.checked=True
	If ReadIni(IniFile,"Updates","NMC")=1 then form_productscenario.chk_nmc_updates.checked=True
	If ReadIni(IniFile,"Updates","MHN")=1 then form_productscenario.chk_mhn_updates.checked=True
	If ReadIni(IniFile,"Updates","MPS")=1 then form_productscenario.chk_mps_updates.checked=True
	If ReadIni(IniFile,"Updates","MPF")=1 then form_productscenario.chk_mpf_updates.checked=True
	If ReadIni(IniFile,"Updates","MSC")=1 then form_productscenario.chk_msc_updates.checked=True
	If ReadIni(IniFile,"Updates","VSO")=1 then form_productscenario.chk_vsodat_updates.checked=True
	If ReadIni(IniFile,"Updates","VSO")=2 Then form_productscenario.chk_vsoproduct_updates.checked=True
	If ReadIni(IniFile,"Updates","VSO")=3 Then
		form_productscenario.chk_vsoproduct_updates.checked=True
		form_productscenario.chk_vsodat_updates.checked=True
	End If
	If ReadIni(IniFile,"Updates","MSK")=1 then form_productscenario.chk_mskfilter_updates.checked=True
	If ReadIni(IniFile,"Updates","MSK")=2 Then form_productscenario.chk_mskproduct_updates.checked=True
	If ReadIni(IniFile,"Updates","MSK")=3 Then
		form_productscenario.chk_mskproduct_updates.checked=True
		form_productscenario.chk_mskfilter_updates.checked=True
	End If

	If ReadIni(IniFile,"EmailScan","Run")=1 Then form_productscenario.chk_runemailscan.checked=True
	If ReadIni(IniFile,"EmailScan","Spam")=1 Then form_productscenario.chk_spamemails.checked=True
	If ReadIni(IniFile,"EmailScan","Spam")=1 Then form_productscenario.chk_cleanemails.checked=True

	If ReadIni(IniFile,"McShell Startup","Run")=1 Then form_productscenario.chk_runmcshell.checked=True
	If ReadIni(IniFile,"System Scan","Run")=1 Then form_productscenario.chk_runsystemscan.checked=True

	'Incremental DAT update
	If 	ReadIni(IniFile,"IncrementalDATUpdates","Run")=1 Then form_productscenario.chk_runinrcmtlupdates.checked=True

	'RightCLick Scan
	If ReadIni(IniFile,"RightClickScan","Run")=1 Then form_productscenario.chk_runrightclickscan.checked=True
	
	'Scheduled Scan
	If ReadIni(IniFile,"ScheduledScan","Run")=1 Then form_productscenario.chk_runscheduledscan.checked=True

	'Artemis ON-ODS
	If ReadIni(IniFile,"ArtemisODS","Run") = 1 Then form_productscenario.chk_runodsartemis.checked=True Else form_productscenario.chk_runodsartemis.checked=False

End sub
