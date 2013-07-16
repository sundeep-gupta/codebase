;The type of the system, i.e. 32-bit or 64-bit is checked for.

;Dim $OS=RegRead( "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment", "PROCESSOR_ARCHITECTURE")
Sleep(5000)
$OS=@ProcessorArch;
Dim $setup
Dim $username, $emailid, $password, $POP3server_ip, $SMTPserver_ip

$username=$CmdLine[1]
$emailid=$CmdLine[2]
$POP3server_ip=$CmdLine[3]
$SMTPserver_ip=$CmdLine[4]
$password=$CmdLine[5]


;These set of statements will open the Outlook setup screen.
If StringInStr( $OS , "x86" ,2) Then
	;MsgBox(0,"","test")
	Run(@ComSpec & " /c " & '"C:\Program Files\Common Files\System\MSMAPI\1033\MLCFG32.CPL"', "", @SW_HIDE)
	;$setup="RUNDLL32 SHELL32.DLL,Control_RunDLL C:\Progra~1\Micros~3\Office12\MLCFG32.CPL"
Else
	Run(@ComSpec & " /c " & '"C:\Program Files (x86)\Common Files\System\MSMAPI\1033\MLCFG32.CPL"', "", @SW_HIDE)
EndIf
;If StringInStr( $OS , "x86" ,2) Then
;	$setup="RUNDLL32 SHELL32.DLL,Control_RunDLL C:\Progra~1\Common~1\System\MSMAPI\1033\MLCFG32.CPL"
;Else
;	$setup="RUNDLL32 SHELL32.DLL,Control_RunDLL C:\Progra~2\Common~1\System\MSMAPI\1033\MLCFG32.CPL"
;EndIf

;Run ($setup)

Opt("WinTitleMatchMode",4)
WinWaitActive("[CLASS:#32770]")

;Click on EmailAccounts
ControlClick("[CLASS:#32770]", "", 1108)
Sleep(2000)

;Check if the account is already existing
WinWaitActive("[CLASS:#32770]")

If( ControlCommand ("[CLASS:#32770]", "", 420, "IsChecked", "")) Then
	
	;If new account is checked, then go to next screen in wizard using Alt N
	WinWaitActive("[CLASS:#32770]")
	ControlClick( "[CLASS:#32770]", "", 12324)
	Sleep(2000)
	
Else 
	;If there is an existing account, delete the same
	WinWaitActive( "[CLASS:#32770]")
	ControlClick( "[CLASS:#32770]", "", 12324)
	Sleep(2000)
	$x=ControlListView( "[CLASS:#32770]", "", 204, "GetItemCount")
	;MsgBox (0, "", $x)
	$i=0
	Do
		$i=$i+1
		;Click on Remove account settings button
		ControlClick( "[CLASS:#32770]", "", 425)
		Sleep(2000)
	
		;Click "Yes" on confirmation dialog
		ControlClick("[CLASS:#32770]", "", 6)
		Sleep(500)
	Until $i==$x
	
	;Click "Add" in the Email Accounts screen
	ControlClick( "[CLASS:#32770]", "", 431)
	Sleep(500)
	
EndIf	

;Click on POP3 in the next screen
ControlClick("[CLASS:#32770]", "", 441)
Sleep(2000)
ControlClick( "[CLASS:#32770]", "", 12324)
Sleep(2000)
	
;Write the given name from the config file.
ControlSetText( "[CLASS:#32770]", "", 357, $username)
Sleep(1000)

;Write the email address given in the config file.
ControlSetText( "[CLASS:#32770]", "", 358, $emailid)
Sleep(1000)

;Write the POP3 server IP from config file
ControlSetText( "[CLASS:#32770]", "", 370, $POP3server_ip)
Sleep(1000)	

;Write the SMTP server IP from config file
ControlSetText( "[CLASS:#32770]", "", 371, $SMTPserver_ip)
Sleep(1000)

;Write the username from the config file
ControlSetText( "[CLASS:#32770]", "", 355, $username)
Sleep(1000)

;Write the password from the config file
ControlSetText( "[CLASS:#32770]", "", 350, $password)
Sleep(1000)

;Click on More Settings
ControlClick( "[CLASS:#32770]", "", 354)
Sleep(1000)

;Go to advanced tab in Internet Email Settings screen
WinWaitActive("[CLASS:#32770]")
ControlCommand("[CLASS:#32770]", "", 12320, "TabRight", "")
ControlCommand("[CLASS:#32770]", "", 12320, "TabRight", "")
ControlCommand("[CLASS:#32770]", "", 12320, "TabRight", "")
Sleep(1000)

;Click on Leave a copy on Server after checking if it is not already checked
If (not ControlCommand("[CLASS:#32770]", "", 237, "IsChecked", "")) Then
	ControlCommand("[CLASS:#32770]", "", 237, "Check", "")
	Sleep(500)
EndIf

;Click on OK in the Internet e-mail settings screen
ControlClick("[CLASS:#32770]", "", 1)
Sleep(500)

;Click on Next in E-mail Accounts screen
ControlClick( "[CLASS:#32770]", "", 12324)
Sleep(500)

;Click on Finish in E-mail Accounts screen
ControlClick( "[CLASS:#32770]", "", 12325)
Sleep(500)

;Click on Close in Mail Setup screen
ControlClick( "[CLASS:#32770]", "", 1111)
Sleep(500)