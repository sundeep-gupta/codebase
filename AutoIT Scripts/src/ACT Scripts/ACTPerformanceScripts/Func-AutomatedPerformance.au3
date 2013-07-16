#include-once
#include <date.au3>
#include <String.au3>
#include "Func-Jets.au3"


;TrayTip Debugging on
Opt( "TrayIconDebug", 1 )


Func PerfTestSetup()
	;check screen resolution; must be 1024 x 768 for correct layouts to load and control ids to match
	Dim $aDisplay = display_resolution( )
	;If $aDisplay[0] < 1024 or $aDisplay[1] < 768 Then
	;	MsgBox(262144, "Adjust Resolution!", "You must set the display resolution to 1024 x 768 or higher." &@CRLF _
	;		&"Set the resolution, then click OK to continue.")
	;		$aDisplay = display_resolution( )
	;		If $aDisplay[0] < 1024 or $aDisplay[1] < 768 Then
	;			MsgBox(262144, "Test Aborted!", "The resolution has not been corrected." &@CRLF _
	;			&"The test will not continue.")
	;			Exit
	;		EndIf
	;EndIf
	
	
    Local $sResultsRegLog
    Local $sStatusRegLog
    
	
    ;Database path, user name and password
    Global Const $sDBZipFilePathLocal   = @ScriptDir &"\Databases\ACT! x175_1K.zip"
    Global Const $sDBName               = "TestonDBsecond1"
    Global Const $sDBUsername           = "User1"
    Global Const $sDBPassword           = "Password"
    Global Const $sDBPadDirectoryPath   = @MyDocumentsDir &"\ACT\ACT for Windows 8\Databases"
    Global Const $sDBPadFilePath        = @MyDocumentsDir &"\ACT\ACT for Windows 8\Databases\" &$sDBName &".pad"


    ;Windows login information (to auto-login and launch scripts)
    Global Const $sLogonUserName        = "050332"
    Global Const $sLogonUserPassword    = "sKGA@123"
    Global Const $sLogonDomain          = "applabs" ;Machine name if not connected to a domain
	
	
	
	
	
	;Include file path for reboot script
	Global Const $sIncludeFilePath_Jets = @ScriptDir &"\Func-Jets.au3"
	Global Const $sIncludeFilePath_Automation = @ScriptDir &"\Func-AutomatedPerformance.au3"
	
	;Database directory & path
	
	
    ;Read full build number from registry
    $sRegBuildNumber = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Act7Updater", "LastAppliedUpdateVersion" )
        If @Error Then 
            $sRegBuildNumber = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\ActUpdater", "LastAppliedUpdateVersion" )
            If @Error Then 
                MsgBox( 262160, "Error", "The build number could not be read from the registry." &@CRLF &"The script will NOT close.", 360 )
            EndIf
            ;Read the Devo version of the key
        EndIf
    Global Const $sBuildNumber = $sRegBuildNumber
    
    ;Replace '.' with '_' (for file name compatibility)
    Dim $sBuildNumberSpaces = StringReplace( $sBuildNumber, ".", "_" )
    
    ;Batch file path
    Global Const $sBatchPath = @ScriptDir&"\DisableAutoLogon.bat"
    
    ;Test Results Log files, first read from registry to determine if a test is in progress
    $sResultsRegLog = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentResultsLog" )
    $sStatusRegLog = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentStatusLog" )
    $sRegLogFile = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentLogFile" )
    
	
	;Log file declaration
    If $sResultsRegLog = "" Or $sStatusRegLog = "" Then 
        ;Local location
        Global Const $sResults_log = @ScriptDir &"\Log_Files\ACT_Perf_Times_" &@ComputerName &"_Build_" &$sBuildNumberSpaces &"_at_" &@HOUR &@MIN &".txt"
        Global Const $sStatus_log  = @ScriptDir &"\Log_Files\Memory_Usage_Logs\ACT_Perf_LOG_" &@ComputerName &"_Build_" &$sBuildNumberSpaces &"_at_" &@HOUR &@MIN &".txt"
        Global Const $sLogFile = @ScriptDir &"\Log_Files\ACT_Perf_LogFile_" &@ComputerName &"_Build_" &$sBuildNumberSpaces &"_at_" &@HOUR &@MIN &".log"
    Else
        ;Local location currently in progress
        Global Const $sResults_log = $sResultsRegLog
        Global Const $sStatus_log = $sStatusRegLog      
        Global Const $sLogFile = $sRegLogFile
    EndIf

    ;Specify Databases path according to installed release
;~     Select
;~         Case StringLeft( $sBuildNumber, 1 ) = 7 
;~             ;7.x is installed           
;~             Global Const $sDBPadFilePath = @MyDocumentsDir &"\ACT\ACT for Win 7\Databases\ACT1K.pad"
;~             Global Const $sDBPadDirectoryPath = @MyDocumentsDir &"\ACT\ACT for Win 7\Databases"
;~             Global Const $sProcessName = "Act7.exe"
;~ 			Global Const $sSpreadsheet_location = "\\logixdata\group\ACTQA\Performance\7.0.4\7_0_4 PerformanceLogs.xls"
;~ 			
;~         Case StringLeft( $sBuildNumber, 1 ) = 8 
            ;8.x is installed
            
            Global Const $sProcessName = "Act8.exe"
;~ 			Global Const $sSpreadsheet_location = "\\logixdata\group\ACTQA\Performance\8.0\8_0 PerformanceLogs.xls"
;~ 			
;~         Case Else
;~             MsgBox( 262192, "Notice", "Unable to determine install type." &@CRLF &$sBuildNumber &@CRLF &"Build may not be installed.", 360 )
;~     EndSelect
    
    ;Misc declarations
;~     Global Const $sDBZipFilePathNetwork = "\\logixdata\Group\ACTQA\PerformanceDatabase\Zipped\ACT! x175_1K.zip"
;~     Global Const $sNetworkPath          = "\\logixdata\Group\ACTQA"
;~     Global Const $sNetworkPathUser      = "acttest.local\smokeadmin"
;~     Global Const $sNetworkPathPassword  = "smokeadmin"
    
    
    Global Const $sRun_all_test_path    = @ScriptDir &"\AUTOMATION - Performance Launcher - Run all tests.au3"
    Global Const $sBatchFilePath        = @ScriptDir &"\ActRemoveReg.bat"
    Global Const $sPerfTestPostReboot   = @ScriptDir &"\ActAutoPerf.au3"
    
EndFunc


Func CheckForScheduler()
;---------------------------------------------------------------------------
; Script:   checkforscheduler
; Purpose:  Check for ACT Scheduler dialog
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------    
    
    If WinExists( "ACT! Scheduler", "Create a new scheduled task" ) Then
        ;Focus to dialog
        window( "ACT! Scheduler", "Create a new scheduled task" )
        ;Close dialog
        Send( "!e" )     
        TestingNote( "Closed the Scheduler" )
    EndIf   
    
EndFunc


Func write_header()
;---------------------------------------------------------------------------
; Script:   write_header
; Purpose:  Write header to log file
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------
    
    Dim $iResult 
    
    ;Write header to Results and Log file
    $iResult = FileWriteLine( $sResults_log, "ACT! Version: " &$sBuildNumber )
    
    ;If the log file can't be written, move to the desktop
    If $iResult = 0  Then 
        MsgBox(262160,"Error","Unable to write to the log file in: '" &$sResults_log &"'." & @CRLF & "" & @CRLF & "The script will not exit.")
    EndIf
    
    FileWriteLine( $sResults_log, "Test Date and Time: " &_now() )
    FileWriteLine( $sResults_log, "System Processor: " &processor_data() )
    FileWriteLine( $sResults_log, "System RAM: " &memory( 1 ) &" kb")
    FileWriteLine( $sResults_log, "Computer OS: " &@OSVersion &" - " &@OSServicePack )
    FileWriteLine( $sResults_log, "Computer Name: "&@ComputerName)
    FileWriteLine( $sResults_log, "" )
    
    FileWriteLine( $sStatus_log, "ACT! Version: " &$sBuildNumber )
    FileWriteLine( $sStatus_log, "Test Date and Time: " &_now() )
    FileWriteLine( $sStatus_log, "System Processor: " &processor_data() )
    FileWriteLine( $sStatus_log, "System RAM: " &memory( 2 ) &" kb")
    FileWriteLine( $sStatus_log, "Computer OS: " &@OSVersion &" - " &@OSServicePack )
    FileWriteLine( $sStatus_log, "Computer Name: "&@ComputerName)
    FileWriteLine( $sStatus_log, "" )
    
    FileWriteLine( $sLogFile, "ACT! Version: " &$sBuildNumber )
    FileWriteLine( $sLogFile, "Test Date and Time: " &_now() )
    FileWriteLine( $sLogFile, "System Processor: " &processor_data() )
    FileWriteLine( $sLogFile, "System RAM: " &memory( 2 ) &" kb")
    FileWriteLine( $sLogFile, "Computer OS: " &@OSVersion &" - " &@OSServicePack )
    FileWriteLine( $sLogFile, "Computer Name: "&@ComputerName)
    FileWriteLine( $sLogFile, "" )
    
EndFunc


Func AppVariable()
;---------------------------------------------------------------------------
; Script:   AppVariable
; Purpose:  Get Class List app# for use when referencing controls, only if act is running
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------
    
    If WinExists( "ACT!", "" ) Then
        If IsDeclared( "sLogFile" ) Then
			TestingNote( "Retrieve the APP variable" )
		EndIf
		
        ToolTip( "Retrieve the APP variable" )
        Dim $iLocation, $iStart, $iEnd
        Dim $sClassList = WinGetClassList( "ACT!", "" )
        If $sClassList = 1 Then 
            MsgBox(262144, "Error", "An error ocurred retrieving the class list from ACT." )
            Exit
        EndIf
        
        $iLocation = StringInStr ( $sClassList, @LF )
        $iEnd = $iLocation
        
        Do
            $iStart = $iStart + 1
            $iLocation = $iLocation - 1
        Until StringMid ( $sClassList, $iLocation, 1 ) = "."
        
        $iLocation = $iLocation + 1 
        $iStart = $iStart - 1
        Global $sApp = StringMid ( $sClassList, $iLocation, $iStart  )
        Sleep( 2000 )
        ToolTip( "" )
    Else
        If IsDeclared( "sLogFile" ) Then
			TestingNote( "ACT! was not found, unable to retreive the APP variable." )
		EndIf
    EndIf
EndFunc


Func ContactDetailFocus() ;Do not use inside of a timed test section
;---------------------------------------------------------------------------
; Script:  Contact Detail Focus
; Purpose:  Sets current view in ACT to the Contact Detail
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------
    window("ACT!", "Connected Menus" )
    Send( "{F11}" )
    TestingNote( "Focus to Contact Detail" )
    
    ;Wait for the contact detail to be active
    Do
        ToolTip( "Wait for Contact Detail to load" )
        $iA = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"2" )
        Sleep( 500 )
    Until $iA = "Company"
    
    ToolTip( "" )
    Sleep( 5000 )
    
EndFunc


Func LaunchACTTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Launch ACT Test
; Purpose:  Tests how long it takes for the ACT! application to start.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------

;#include <Libraries\LaunchACT.au3>
Dim $iC, $iF, $iI, $iTestIterations, $sTestName, $sInstallPath, $sFile
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Launch ACT!"
NowTesting( $sTestName )

;Wait for machine to finish loading
Sleep (10000)

    ;Set AutoIt to look for partial form titles
    AutoItSetOption( "WinTitleMatchMode", 2 )
    ;Set AutoIt to require explicit declaration of variables
    ;AutoItSetOption("MustDeclareVars", 1)
        
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    Do 
        ;Start the timer and Launch ACT!
        $sInstallPath = RegRead( "HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "InstallPath" )
        FileChangeDir( $sInstallPath )
        
        ;Verify file exists
        Select
            Case FileExists( $sInstallPath &"Act7.exe" )
                $sFile = "Act7.exe"
            Case FileExists( $sInstallPath &"Act8.exe" )
                $sFile = "Act8.exe"
        EndSelect
        
        ;Wait till the processor stabilizes
        processor_usage( 20, 500 )
        
        ;Start the timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        Run( $sFile )
        
        Sleep( 500 )
        
        ;Wait for ACT! to launch, look for the db login dialog
        WinWaitActive( "Log", "Enter your" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        Sleep(2000)
        ToolTip( "" )
        
        ;If Iterations is = to 1 then don't close ACT, or if it is the last iteration test
        If $iTestIterations = 1 OR $iTestIterations = ($iC + 1) Then
            ;Don't close ACT
            ToolTip( "Act will remain open." )
        Else        
            ;Close ACT
            ToolTip( "Close ACT" )
            window( "Log", "Enter your" )
            Send( "!c" )
            Sleep( 500 )
            window( "ACT!", "" )
            Send( "!fx" )
            While ProcessExists( $sFile )
                Sleep( 500 )
            WEnd
            ToolTip( "" )
        EndIf
        
        $iC = $iC + 1
    Until $iC = $iTestIterations  
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sFile ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )

    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    
    
;~ If $iTestIterations = 1 Then
;~  msgbox(262144, "TEST", $iTime[0] )
;~ Else
;~  msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1] )
;~ EndIf
    
    
    TestComplete( $sTestName )
EndFunc


Func OpenDBTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Open DB Test
; Purpose:  Tests how long it takes for the ACT! database to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------

;#include <Libraries\LaunchACT.au3>
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Local DB"
NowTesting( $sTestName )
    ;Set AutoIt to look for partial form titles
    AutoItSetOption("WinTitleMatchMode", 2)
    ;Set AutoIt to require explicit declaration of variables
    ;AutoItSetOption("MustDeclareVars", 1)

    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;ToolTip
        ToolTip( "Preparation: Open DB" )
    ;Check for Database Open Dialog
    
    ;Check for Authentication Dialog
    
    ;If Authentication Dialog is Found, Close it and Open the Open Database Window
    
    ;Check for Database Open Dialog
	If Not (WinExists("Log","Enter your")) Then
		send("^o")
		winwaitActive("Open","")
		send("!n")
		send($sDBPadFilePath)
		send("{ENTER}")
	EndIf
	
    
    ;If Open Database Window is Found Enter the PAD File for the Test Database
    
        ;Wait for the Authentication Dialog
        WinWaitActive( "Log", "Enter your" )
        window( "Log", "Enter your" )
        
        ;Enter the UserName and Password
        Send( "!n" )
        Send( $sDBUsername &"{TAB}" )
        Send( $sDBPassword )
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ()
        
        ;Click OK
        Send( "{ENTER}" )
        
        ;Wait for the Database to open
        Do
            Sleep( 250 )
                $iA = ControlGetText ( "ACT!", "", "WindowsForms10.EDIT." &$sApp &"4" )
        Until StringInStr( $iA, $sDBUsername ) <> 0
        
        
        
    ;iResult = SQAWaitForObject("\;Type=Form;Name=LoginStatusForm", 60000)
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;If this is the only iteration or the last iteration then don't close the db!
        If $iTestIterations = 1 OR $iTestIterations = $iC + 1 Then
            ;Don't close the db
            
        Else
            ;Close the DB and open the db
            ToolTip( "Close DB and open again up to the Login Dialog" )
            window( "ACT!", "Connected Menus" )
            $iA = WinGetTitle( "ACT!", "Connected Menus" )
            Send( "!fc" )
            Do
                Sleep( 200 )
            Until WinGetTitle( "ACT!", "Connected Menus" ) <> $iA
            Sleep(2000)
            
            ;Open the db again
            window( "ACT!", "Disconnected Menus" )
            Send( "!fo" )
            WinWaitActive( "Open", "Look " )
            window( "Open", "Look " )
            Send( "!n" )
;~             Send( "ACT1K.pad" )
Send( $sDBPadFilePath )
            Send( "{ENTER}" )
            
            WinWaitActive( "Log", "Enter your" )
            ToolTip( "" )
            
        EndIf   
        $iC = $iC + 1
    Until $iC = $iTestIterations      
    ToolTip( "" )
        
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )   
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    sleep( 190000 )
    
    TestComplete( $sTestName )
EndFunc


Func OpenPreferencesTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Open Preferences Test
; Purpose:  Opens the Preferences dialog from the Contact Detail View.
;           Tests how long it takes for the Preferences dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Preferences Dialog"
NowTesting( $sTestName )

 
;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;ToolTip
        ToolTip( "Preparation: Open Contact Detail View" )
        
        ;Make Sure we are on the Contact Detail View
        window("ACT!", "Connected Menus")
        Send( "{F11}" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 4000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Preferences
        Send("!tf")
        
        ;Wait for the Preferences Dialog to open
        ;Looking for (Preferences Window)
        ;$iT = 
        WinWaitActive( "Preferences", "General" );, 15 )
;~         If $iT = 0 Then 
;~             FileWriteLine( $sStatus_log, "***Failed to find the window: *** Preferences" )
;~         EndIf
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Let user see tooltip
        Sleep( 1000 )
        
        ;ToolTip
        ToolTip( "Close Preferences Dialog" )
        
        ;Close the Preferences Dialog
        While WinExists( "Preferences", "" )
            ;Focus to Preferences Dialog
            WinActivate( "Preferences", "" )
            WinClose( "Preferences" )
        WEnd
        
        ;ToolTip
        ToolTip( "" )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations      
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])

    TestComplete( $sTestName )
EndFunc


Func OpenDefineFieldsTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Define Fields Test
; Purpose:  Opens the Define Fields dialog from the Contact Detail View.
;           Tests how long it takes for the Define Fields dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Define Fields Dialog"
NowTesting( $sTestName )
 
;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
            
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Define Fields
        window( "ACT!", "Connected Menus" )
        Send("!td")
        
        ;Wait for the Define Fields Dialog to open
        $iT = WinWaitActive( "Define Fields", "", 10 )
        If $iT = 0 Then 
            FileWriteLine( $sStatus_log, "***Failed to find the window: *** Define Fields" )
        EndIf
            
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Close the Define Fields Dialog
        While WinExists( "Define Fields", "" )
            ;Focus to Define Fields Dialog
            WinActivate( "Define Fields", "" )
            WinClose( "Define Fields" )
        WEnd
        
        $iC = $iC + 1
    Until $iC = $iTestIterations      
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenTaskListTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Task List Test
; Purpose:  Opens the Task List View from the Contact Detail View.
;           Tests how long it takes for the Task List View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $sB, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Task List View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
Sleep( 190000 )

    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Task List
        window( "ACT!", "Connected Menus" )
        Send("{F7}")
        
        ;Wait for the Task List to open
        Do
            $sB = ControlGetText ( "ACT!", "Connected Menus", "WindowsForms10.STATIC." &$sApp &"1" )
            Sleep( 500 ) 
        Until $sB = "Task List"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenActivityDialogTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Activity Dialog Test
; Purpose:  Opens the Activity dialog from the Contact Detail View.
;           Tests how long it takes for the Activity dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Activity Dialog from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open an Activity
        window( "ACT!", "Connected Menus" )
        Send( "^l" )
        
        ;Wait for the Activity Dialog to open
        ;$iT = 
        WinWaitActive( "Schedule Activity", "" );, 10 )
        ;If $iT = 0 Then 
        ;    FileWriteLine( $sStatus_log, "***Failed to find the window: *** Schedule Activity" )
        ;EndIf
            
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Close the Activity Dialog
        While WinExists( "Schedule Activity", "" )
            ;Focus to Define Fields Dialog
            WinActivate( "Schedule Activity", "" )
            WinClose( "Schedule Activity" )
        WEnd
        
        $iC = $iC + 1
    Until $iC = $iTestIterations  
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
        Do
            FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
            $iI = $iI + 1
        Until $iI = $iTestIterations
        FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func AddNewActivityTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Add New Activity Test
; Purpose:  Creates a new Activity from the Contact Detail View.
;           Tests how long it takes for the Activity to save.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
;#include <date.au3> ;crashes

Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Add an Activity from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Disable Conflict Checking
            ;Open Preferences
            window( "ACT!", "Connected Menus" )
            Send("!tf")
            
            ;Wait for the Preferences Dialog to open
            ;Looking for (Preferences Window)
            window( "Preferences", "" )
            
            ;Click the Calendar & Scheduling Tab
            MouseClick( "left", 225, 47, 1, 1 )
            
            ;Click the Scheduling Preferences Button
            Do
                ;Looking for Scheduling Preferences Button
                $iT = ControlCommand ( "Preferences", "", "WindowsForms10.BUTTON." &$sApp &"11", "IsVisible", "" )
            Until $iT = 1
            Sleep( 250 )
            Send( "!s" )
            
            ;Disable Activity Conflict Checking if checked
            window( "Scheduling Preferences", "" )
            Do
                ;Looking for Conflict Checking
                $iT = ControlCommand ( "Scheduling Preferences", "", "WindowsForms10.BUTTON." &$sApp &"7", "IsVisible", "" )
            Until $iT = 1
            
            If ControlCommand( "Scheduling Preferences", "", "WindowsForms10.BUTTON." &$sApp &"7", "IsChecked", "" ) = 1 Then
                ControlClick( "Scheduling Preferences", "", "WindowsForms10.BUTTON." &$sApp &"7" )
            EndIf
            
            
            ;Close and Save Changes
            Send( "!o" )
            window( "Preferences", "" )
            Send( "!o" )
            
        ;Open a New Activity
        window( "ACT!", "Connected Menus" )
        Send( "^l" )
        
        ;Wait for the Activity Dialog to open
        $iT = WinWaitActive( "Schedule Activity", "", 10 )
        If $iT = 0 Then 
            FileWriteLine( $sStatus_log, "***Failed to find the window: *** Schedule Activity" )
        EndIf
        
        ;Add Activity Information, Set Regarding Field to Performance Test & Todays Date/Time Stamp
        window( "Schedule Activity", "General" )
        Send( "!r" )
        Send( "Performance Test " &@MON &"/" &@MDAY &"/" &@YEAR  &" at " &@HOUR &":" &@MIN &":" &@SEC )
        
      
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Save the Activity
        window( "Schedule Activity", "General" )
        Send( "!o" )
        
        ;Wait for the Activity Dialog to close
        WinWaitClose( "Schedule Activity", "General" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenExistingActivityTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Existing Activity Test
; Purpose:  Opens an existing Activity from the Contact Detail View Activities tab.
;           Tests how long it takes for the Activity to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>

Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName, $aPosition
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open an Existing Activity from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption( "WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption( "MustDeclareVars", 1 )
;Set Mouse Coordinate mode (to position mouse to open activities)
AutoItSetOption( "MouseCoordMode", 0 )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Open the Activities Tab
        window( "ACT!", "" )
        Send( "!{F9}" )
        
        ;Verify At least 1 Activity Exits to Open
        window( "ACT!", "Activities" )
        ;Get position of divider control for reference to location of first activity
        $aPosition = ControlGetPos( "ACT!", "Activities", "WindowsForms10.Window.8." &$sApp &"3" )
        Do
            ToolTip( "Preparation: Find a contact with an activity" &@CRLF &"Do not move the mouse!!!" )
            Sleep( 2250 )
                
            ;Start the Timer
            ToolTip( "TIMER START: " &$sTestName )
            $iTime_start[$iC] = TimerInit ( )
                
            ;Select the first Activity, and open it if it exists
            MouseClick( "left", $aPosition[0] + 48, $aPosition[1] + 105, 2, 2 )
            Sleep( 250 )
            $iA = WinWaitActive( "Schedule Activity", "General", 20 )
            If $iA = 1 Then
                ;Stop the timer, calculate elapsed time
                $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
                ToolTip( "TIMER END: " &$sTestName )
                Sleep( 750 )
                ExitLoop
            EndIf
            ;No activity found select the next contact and try again
            window( "ACT!", "Activities" )
            Send( "^{PGDN}")
        Until 1 ;Later add code to exit fcn if no activities are found after x contacts???
        
        ;Close the Activity Dialog
        ToolTip( "Close the Activity Dialog" )
        While WinExists( "Schedule Activity", "General" )
            ;Focus to Define Fields Dialog
            WinActivate( "Schedule Activity", "General" )
            WinClose( "Schedule Activity", "General" )
        WEnd
        
        $iC = $iC + 1
    Until $iC = $iTestIterations     
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    AutoItSetOption( "MouseCoordMode", 1 )
    
    TestComplete( $sTestName )
EndFunc


Func ClearExistingActivityTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Clear Existing Activity Test
; Purpose:  Opens the Clear an existing Activity from the Contact Detail View Activities tab.
;           Tests how long it takes for the Clear Activity dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Clear Activity Dialog from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
;Set Mouse Coordinate mode (to position mouse to open activities)
AutoItSetOption( "MouseCoordMode", 0 )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Open the Activities Tab
        window( "ACT!", "" )
        Send( "!{F9}" )
        
        ;Verify At least 1 Activity Exits to Open
        window( "ACT!", "Activities" )
        
        ;Get position of divider control for reference to location of first activity
        $aPosition = ControlGetPos( "ACT!", "Activities", "WindowsForms10.Window.8." &$sApp &"3" )
        Do
            ToolTip( "Preparation: Find a contact with an activity" &@CRLF &"Do not move the mouse!!!" )
            Sleep( 2250 )
                
            ;Start the Timer
            ToolTip( "TIMER START: " &$sTestName )
            $iTime_start[$iC] = TimerInit ( )
                
            ;Select the first Activity, and open it if it exists
            MouseClick( "left", $aPosition[0] + 28, $aPosition[1] + 105, 2, 2 )
            Sleep( 250 )
            $iA = WinWaitActive( "Clear Activity", "Type", 20 )
            If $iA = 1 Then
                ;Stop the timer, calculate elapsed time
                $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
                ToolTip( "TIMER END: " &$sTestName )
                ExitLoop
            EndIf
            ;No activity found select the next contact and try again
            window( "ACT!", "Activities" )
            Send( "^{PGDN}")
        Until 1 ;Later add code to exit fcn if no activities are found after x contacts???
        
        ;Close the Clear Activity Dialog
        ToolTip( "Close the Activity Dialog" )
        While WinExists( "Clear Activity", "Type" )
            ;Focus to Define Fields Dialog
            WinActivate( "Clear Activity", "Type" )
            WinClose( "Clear Activity", "Type" )
        WEnd
        
        $iC = $iC + 1
    Until $iC = $iTestIterations     
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    AutoItSetOption( "MouseCoordMode", 1 )
    
    TestComplete( $sTestName )
EndFunc


Func OpenHistoryDialogTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open History Dialog Test
; Purpose:  Opens the History Dialog from the Contact Detail View.
;           Tests how long it takes for the History dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open History Dialog from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)

    ;Set Mouse Coordinate mode (to position mouse to open activities)
AutoItSetOption( "MouseCoordMode", 0 )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Open the Activities Tab
        window( "ACT!", "" )
        Send( "+{F9}" )
        
        ;Verify At least 1 Activity Exits to Open
        window( "ACT!", "History" )
        
        ;Get position of divider control for reference to location of first activity
        $aPosition = ControlGetPos( "ACT!", "History", "WindowsForms10.Window.8." &$sApp &"3" )
        Do
            ToolTip( "Preparation: Find a contact with an history" &@CRLF &"Do not move the mouse!!!" )
            Sleep( 2250 )
                
            ;Start the Timer
            ToolTip( "TIMER START: " &$sTestName )
            $iTime_start[$iC] = TimerInit ( )
                
            ;Select the first history, and open it if it exists
            MouseClick( "left", $aPosition[0] + 28, $aPosition[1] + 105, 2, 2 )
            Sleep( 250 )
            $iA = WinWaitActive( "Edit History", "Type", 20 )
            If $iA = 1 Then
                ;Stop the timer, calculate elapsed time
                $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
                ToolTip( "TIMER END: " &$sTestName )
                ExitLoop
            EndIf
            ;No activity found select the next contact and try again
            window( "ACT!", "History" )
            Send( "^{PGDN}")
        Until 1 ;Later add code to exit fcn if no histories are found after x contacts???
        
        ;Close the Clear History Dialog
        ToolTip( "Close the History Dialog" )
        While WinExists( "Edit History", "Type" )
            ;Focus to Define Fields Dialog
            WinActivate( "Edit History", "Type" )
            WinClose( "Edit History", "Type" )
        WEnd
        
        $iC = $iC + 1
    Until $iC = $iTestIterations     
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    AutoItSetOption( "MouseCoordMode", 1 )
    
    TestComplete( $sTestName )
EndFunc


Func OpenNotesDialogTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Notes Dialog Test
; Purpose:  Opens the Notes Dialog from the Contact Detail View.
;           Tests how long it takes for the Notes dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Notes Dialog from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        window("ACT!", "Connected Menus")
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Notes Dialog
        Send( "{F9}" )
        
        ;Wait for the Notes Dialog to open
        WinWaitActive( "Insert Note", "Date" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Close the Note Dialog
        While WinExists( "Insert Note", "Format" )
            ;Focus to Define Fields Dialog
            WinActivate( "Insert Note", "Format" )
            WinClose( "Insert Note", "Format" )
        WEnd
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func AddNewNoteTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Add New Note Test
; Purpose:  Adds a new Note from the Contact Detail View.
;           Tests how long it takes for the Note to save.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Add Note from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
    
        ;Open Notes Dialog
        window("ACT!", "Connected Menus")
        Send( "{F9}" )
        
        ;Wait for the Notes Dialog to open
        WinWaitActive( "Insert Note", "Date" )
        
        ;Add Note Information
        ;Set Regarding Field to Performance Test & Todays Date/Time Stamp
        window( "Insert Note", "Date" )
        Send( "Performance Test " &@MON &"/" &@MDAY &"/" &@YEAR  &" at " &@HOUR &":" &@MIN &":" &@SEC )
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Save the Note      
        Send( "!o" )
        
        ;Wait for the Note Dialog to go away
        WinWaitClose( "Insert Note", "Date" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        Sleep( 2000 )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenOpportunityDialogTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Opportunity Dialog Test
; Purpose:  Opens the Opportunity Dialog from the Contact Detail View.
;           Tests how long it takes for the Opportunity dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iI, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Opportunity Dialog from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
;~ AutoItSetOption("WinTitleMatchMode", 2 )
AutoItSetOption( "WinTitleMatchMode", 4 )
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
Sleep ( 190 )

    ;--Script Start--
    $iC = 0
    Do
        $iI = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
		
		;focus to Opportunity tab
		Send("{ALTDOWN}v{ALTUP}y")
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 8000 ) ;Just to make sure
        window("ACT!", "Connected Menus")
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Opportunity Dialog
        Send( "^{F11}" )
        sleep( 1000 ) ;This is required, for some reason this test fails to find the opportunity window without it

        ;Wait for the Opportunity Dialog to open
;~      WinWait Active( "Opportunity" , "" )
        Do
            $sA = ControlGetText( "Opportunity", "", "WindowsForms10.STATIC." &$sApp &"2" )
            Sleep( 250 )
        Until $sA = "O&pportunity Name:"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        Sleep( 3000 )
        ToolTip( "" )
        
        ;Close the Opportunity Dialog
        ToolTip( "Close the opportunity dialog" )
        Do
            ;Focus to Opportunity Dialog
            WinActivate( "Opportunity", "" )
            WinClose( "Opportunity", "" )
            Sleep( 750 )
        Until WinExists( "Opportunity", "" ) = 0
        ToolTip( "Opportunity Dialog Closed" )
        Sleep( 5000 )
        
        ToolTip( "" )
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenLookupDialogTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Lookup Dialog Test
; Purpose:  Opens the Lookup Dialog from the Contact Detail View.
;           Tests how long it takes for the Lookup dialog to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Lookup Dialog from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        window( "ACT!", "Connected Menus" )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Lookup Contacts Dialog
        Send( "!ln" )
        
        ;Wait for the Lookup Dialog to open
        WinWaitActive( "Lookup Contacts", "&Search for" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Close the Lookup Dialog
        WinClose( "Lookup Contacts", "&Search for" )
        ToolTip( "" )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenGroupDetailViewTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Group Detail View Test
; Purpose:  Opens the Group Detail View from the Contact Detail View.
;           Tests how long it takes for the Group Detail View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Group Detail View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ToolTip( "Sleep for 60 seconds" )
        Sleep ( 60000 ) 
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Group Detail View
        window("ACT!", "Connected Menus")
        Send( "!vg" )
        
        ;Wait for the Group Detail View to open
        Do 
            ;Looking for (Group Detail Label)
            Sleep( 250 )
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"2" )
        Until $iT <> "Group"
        
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    TestComplete( $sTestName )
    
EndFunc


Func OpenCompanyDetailViewTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Company Detail View Test
; Purpose:  Opens the Company Detail View from the Contact Detail View.
;           Tests how long it takes for the Company Detail View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Company Detail View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        Sleep ( 60000 ) 
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Company Detail View
        window("ACT!", "Connected Menus")
        Send( "!vp" )
        
        ;Wait for the Company Detail View to open
        Do 
            ;Looking for Company Label
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"5" )
			If $it <> "Company" Then	
				$iT = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"7" )
			EndIf
        Until $iT = "Company"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenMonthlyCalendarTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Monthly Calendar Test
; Purpose:  Opens the Monthly Calendar View from the Contact Detail View.
;           Tests how long it takes for the Monthly Calendar View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $dA, $iTestIterations, $sTestName, $sNewDate, $sDateNow
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Monthly Calendar View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)

;Set the date to 10/1/2003
$sDateNow = _NowDate()
$sNewDate ="10/ 1/03"
;~ MsgBox(0, "Current  Date", _NowDate())
RunWait(@ComSpec & " /c " & "date " & $sNewDate, "", @SW_HIDE)
;MsgBox(262144, "New Date", _NowDate())
;MsgBox(262144, "NOTICE", "Set the date to 10/1/2003" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
Sleep ( 190000 )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Monthly Calendar View
        window("ACT!", "Connected Menus")
        Send( "{F5}" )
        
        ;Wait for the Monthly Calendar View to open
        Do 
            Sleep( 500 )
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.BUTTON." &$sApp &"8" )
        Until $iT = "Hide Filters"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
        Sleep( 5000 )
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
 
    ;Set the date back to today
    RunWait(@ComSpec & " /c " & "date " & $sDateNow, "", @SW_HIDE)
  
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenDailyCalendarTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Daily Calendar Test
; Purpose:  Opens the Daily Calendar View from the Contact Detail View.
;           Tests how long it takes for the Daily Calendar View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName, $sNewDate, $sDateNow
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Daily Calendar View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)

;Set the date to 10/1/2003
$sDateNow = _NowDate()
$sNewDate ="10/ 1/03"
;~ MsgBox(0, "Current  Date", _NowDate())
RunWait(@ComSpec & " /c " & "date " & $sNewDate, "", @SW_HIDE)
;~ MsgBox(262144, "New Date", _NowDate())
;~ MsgBox(262144, "NOTICE", "Set the date to 10/1/2003" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )

Sleep ( 190000 )

    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Daily Calendar View
        window("ACT!", "Connected Menus")
        Send( "+{F5}" )
        
        ;Wait for the Daily Calendar View to open
        Do 
            Sleep( 500 )
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.BUTTON." &$sApp &"8" )
        Until $iT = "Hide Filters"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
        Sleep( 5000 )
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Set the date back to today
    RunWait(@ComSpec & " /c " & "date " & $sDateNow, "", @SW_HIDE)
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenWeeklyCalendarTest( $iTestIterations )
;---------------------------------------------------------------------------
; Script:   Open Weekly Calendar Test
; Purpose:  Opens the Weekly Calendar View from the Contact Detail View.
;           Tests how long it takes for the Weekly Calendar View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName, $sDateNow, $sNewDate
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Weekly Calendar View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)

;Set the date to 10/1/2003
$sDateNow = _NowDate()
$sNewDate ="10/ 1/03"
;~ MsgBox(0, "Current  Date", _NowDate())
RunWait(@ComSpec & " /c " & "date " & $sNewDate, "", @SW_HIDE)
;~ MsgBox(262144, "New Date", _NowDate())
;~ ;MsgBox(262144, "NOTICE", "Set the date to 10/1/2003" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )

Sleep ( 190000 )

    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        window("ACT!", "Connected Menus")
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Weekly Calendar View
        window("ACT!", "Connected Menus")
        Send( "{F3}" )
        
        ;Wait for the Weekly Calendar View to open
        Do 
            Sleep( 500 )
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.BUTTON." &$sApp &"8" )
        Until $iT = "Hide Filters"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
        Sleep( 5000 )
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )

    ;Set the date back to today
    RunWait(@ComSpec & " /c " & "date " & $sDateNow, "", @SW_HIDE)
 
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func CreateNewDBTest( $iTestIterations, $sDatabaseName )
;---------------------------------------------------------------------------
; Script:   Create New DB Test
; Purpose:  Creates a new Empty database.
;           Tests how long it takes for the new database to be created.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>

Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName, $sDatabaseName, $sWinName, $iResult
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Create New DB"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption( "WinTitleMatchMode", 2 )
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    $iS = 0
    
    Sleep( 5000 ) ;Required 
    
    Do
        $iR = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
		;Check for ACT!
		If Not ProcessExists( $sProcessName ) Then
			MsgBox( 262144, "NOTICE", "ACT! could not be found." )
		EndIf
		
        ;Create and Open a New, Blank Database
        ToolTip( "Create new database" )
        Do 
            window( "ACT!", "" )
            Send( "^n" )
            Sleep( 2000 )
			
			;Check for Word Processor
			If WinExists( "ACT! Word Processor", "" ) Then WinKill( "ACT! Word Processor", "" )
			
		Until WinExists( "New Database", "The database" )
        
        ;Enter Database Name
        window( "New Database", "The database" )
        Send( $sDatabaseName &$iC &"{TAB 4}" )
        
        ;Enter User Name
        window( "New Database", "The database" )
        Send( $sDBUsername &"{TAB}" )
        
        ;Enter Password
        window( "New Database", "The database" )
        Send( $sDBPassword &"{TAB}" )
        
        ;Confirm Password
        window( "New Database", "The database" )
        Send( $sDBPassword )
        
        ;Disable Shared Database
        If ControlCommand( "New Database", "The database", "WindowsForms10.BUTTON." &$sApp &"1", "IsChecked", "" ) = 1 Then
            ControlCommand( "New Database", "The database", "WindowsForms10.BUTTON." &$sApp &"1", "UnCheck", "")
        EndIf
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        window( "New Database", "The database" )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Click OK
        Send( "!o" )
        
        ;Wait for Creating dialog to go away
        WinWaitClose( "", "Creating..." )
        
        ;Wait until ACT! is Ready
        Do 
            ;Looking for Window Title "$sDatabaseName &$iC"
            $sWinName = WinGetTitle( "ACT!", "" )
            Sleep( 250 )
        Until StringInStr( $sWinName, $sDatabaseName &$iC ) <> 0 
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Delete the Test Database
        Sleep( 5000 )
        ToolTip( "Delete Current Database" )
        DeleteCurrentDatabase()
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    ;Write Last opened db to registry 
    $iResult = RegWrite( "HKEY_CURRENT_USER\Software\ACT", "LastDBFileUsed", "REG_SZ", $sDBPadFilePath )
    If $iResult = 0 Then 
        MsgBox(262192,"Error","Unable to chage the last opened database value in the registry.")
    EndIf

    TestComplete( $sTestName )
EndFunc


Func OpenCompanyListTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Open Company List Test
; Purpose:  Opens the Company List View from the Contact Detail View.
;           Tests how long it takes for the Company List View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Company List View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Company List View
        window("ACT!", "Connected Menus")
        Send( "!{F10}" )
        
        ;Wait for the Company List View to open
        Do 
            ;Looking for (Company List Title Bar)
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"1" )
        Until $iT = "Company List"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenGroupListTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Open Group List Test
; Purpose:  Opens the Group List View from the Contact Detail View.
;           Tests how long it takes for the Group List View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Group List View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Group List View
        window("ACT!", "Connected Menus")
        Send( "{F10}" )
        
        ;Wait for the Group List View to open
        Do 
            ;Looking for (Group List Title Bar)
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"1" )
        Until $iT = "Group List"
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
    ;Return to the Contact Detail View
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenOpportunityListTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Open Opportunity List Test
; Purpose:  Opens the Opportunity List View from the Contact Detail View.
;           Tests how long it takes for the Opportunity List View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Opportunity List View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
Sleep ( 190000 )

    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Opportunity List View
        window("ACT!", "Connected Menus")
        Send( "+{F7}" )
        
        ;Wait for the Opportunity List View to open
        Do 
            ;Looking for (Opportunity List Title Bar)
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"8" )
        Until $iT = "Opportunity List"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenContactListTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   OpenC ontact List Test
; Purpose:  Opens the Contact List View from the Contact Detail View.
;           Tests how long it takes for the Contact List View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Contact List View from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 3000 ) ;Just to make sure
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Contact List View
        window("ACT!", "Connected Menus")
        Send( "{F8}" )
        
        ;Wait for the Contact List View to open
        Do 
            ;Looking for (Contact List Title Bar)
            $iT = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"1" )
        Until $iT = "Contact List"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenWriteEmailClientClosedTest( $iTestIterations ) ;need e-mail verification
;---------------------------------------------------------------------------
; Script:   Open Write Email Client Closed Test
; Purpose:  Opens Write Email from the Contact Detail View.
;           Tests how long it takes for the Write Email Dialog to open when the ACT! Email Client began closed.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Write Email Dialog (Client Closed) from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    $iI = 0
    Do
        $iS = 0
                
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
;Locks UP!!!                ContactDetailFocus()
window( "ACT", "" ) 
Send( "{F11}" )
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 2000 ) ;Just to make sure
        
;Verify Email is Set Up on this machine
;Open Preferences
;Open E-mail tab
;Open E-mail system setup
;Verify that Internet Mail is setup

        
        ;Return Context to ACT!
        window( "ACT!", "Contact Detail" )
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Write Email
        Send( "!ie" )
        
        ;Wait for the Write Email Dialog to open
        WinWaitActive( "New Message - ACT! E-mail", "Menu Bar" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Close the New Email Dialog
        ToolTip( "Close E-mail Message" )
        WinClose( "New Message - ACT! E-mail", "Menu Bar" )
        Sleep( 500 )
        ;Send( "!fc" )
        ToolTip( "" )
        
        ;Close ACT! Email
        ToolTip( "Close E-mail Client" )
        WinClose( "ACT! E-mail", "Subject:" )
        ;Send( "!fc" )
        
        Sleep( 2000 )
        
;Check for ACTEmail.EXE Application Error Window ;NEEDED????
;Check for SQA SPY: ACTEmail.EXE Application Error Window   ;NEEDED????
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenWriteEmailClientOpenTest( $iTestIterations ) ;need e-mail verification
;---------------------------------------------------------------------------
; Script:   Open Write Email Client Open Test
; Purpose:  Opens Write Email from the Contact Detail View.
;           Tests how long it takes for the Write Email Dialog to open when the ACT! Email Client began open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iI, $iS, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Write Email Dialog (Client Open) from Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2 )
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    $iI = 0
    Do
        $iS = 0
        
        
        ;Make Sure we are on the Contact Detail View
;~         ToolTip( "Preparation: Open Contact Detail View" )
;Locks UP!!!        ContactDetailFocus()
        ;Clear Tooltip
        ToolTip( "" )
        Sleep( 3000 ) ;Just to make sure
        
;Verify Email is Set Up on this machine
	
        ;Open Email Client
        ToolTip( "Preparation: Open E-mail Client" )
        window( "ACT!", "Contact Detail" )
        Sleep( 750 )
        Send( "!ve" )
        
        ;Wait for Email Client to Open
        WinWaitActive( "ACT! E-mail", "Subject:" )
        ToolTip( "" )
        
        ;Return Context to ACT!
        window( "ACT", "Contact Detail" )
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Write Email
        Send( "!ie" )
        
        ;Wait for the Write Email Dialog to open
        WinWaitActive( "New Message - ACT! E-mail", "Menu Bar" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
		
        ;Close the New Email Dialog
		AutoItSetOption("WinTitleMatchMode", 3 )
        ToolTip( "Close E-mail Message" )
        WinClose( "New Message - ACT! E-mail", "Menu Bar" )
        Sleep( 750 )
        ;Send( "!fc" )
        ToolTip( "" )
        
        ;Close ACT! Email
        ToolTip( "Close E-mail Client" )
        WinClose( "ACT! E-mail", "Subject:" )
        ;Send( "!fc" )
        
		AutoItSetOption("WinTitleMatchMode", 2 )
        Sleep( 5000 )
        
;Check for ACTEmail.EXE Application Error Window ;NEEDED????
;Check for SQA SPY: ACTEmail.EXE Application Error Window   ;NEEDED????
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
	
    TestComplete( $sTestName )
EndFunc


Func LookupContactDetailResultsTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Lookup Contact Detail Results Test
; Purpose:  Opens the Lookup Dialog from the Contact Detail View.
;           Performs a Last Name lookup of Stewart.
;           Tests how long it takes for the Lookup to resolve on the Contact Detail View.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Lookup Last Name - Contact Detail View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 3000 ) ;Just to make sure
        ;Make sure that 'stewart is not the current contact'
        If StringInStr( ControlGetText ( "ACT!", "Connected Menus", "WindowsForms10.EDIT." &$sApp &"4" ), "stewart" ) Then
            Send( "^{PGDN}" )
            Sleep( 2500 )
        EndIf
        
        ;Open Lookup Contacts Dialog
        ToolTip( "Preparation: Open Lookup Contacts Dialog" )
        window( "ACT!", "Connected Menus" )
        Send( "!ll" )
        
        ;Wait for the Lookup Dialog to open, wait for dialog to completely open,
        ;If the wait does not exist occasionally the lookup wil take > 10 seconds, 
        ;This was un-reproducible manually
        WinWaitActive( "Lookup Contacts", "For the &current lookup" )
        Sleep( 4000 )
        
        ;Enter the Last Name of Stewart
        window( "Lookup Contacts", "For the &current lookup" )
        Send( "Stewart" )
        Sleep( 2000 )
        
        ;Wait till the processor stabilizes
        processor_usage( 20, 500 )
        
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Click the OK Button
        Send( "{ENTER}" )
        
        ;Wait for Lookup Dialog to go away and Contact Detail View to appear
        Do
            $iT = ControlGetText ( "ACT!", "Connected Menus", "WindowsForms10.EDIT." &$sApp &"4" )
        Until StringInStr( $iT, "stewart" )
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Lookup All Contacts
        window( "ACT!", "Connected Menus" )
        Send( "!la" )
        Sleep( 4000 )        
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func LookupContactListResultsTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Lookup Contact List Results Test
; Purpose:  Opens the Lookup Dialog from the Contact Detail View.
;           Performs a Last Name lookup of Smith.
;           Tests how long it takes for the Lookup to resolve on the Contact List View.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Lookup Last Name - Contact List View"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        $iT = 0
        $iA = 0
        
        ;Make Sure we are on the Contact Detail View
        ToolTip( "Preparation: Open Contact Detail View" )
        ContactDetailFocus()
        ToolTip( "" )
        Sleep( 5000 ) ;Just to make sure
        
        ;Open Lookup Contacts Dialog
        ToolTip( "Preparation: Open Lookup Contacts Dialog" )
        window( "ACT!", "Connected Menus" )
        Send( "!ll" )
        
        
        ;Wait for the Lookup Dialog to open, wait for dialog to completely open,
        ;If the wait does not exist occasionally the lookup wil take > 10 seconds, 
        ;This was un-reproducible manually
        WinWaitActive( "Lookup Contacts", "For the &current lookup" )
        Sleep( 4000 )
        
        ;Enter the Last Name of Smith
        window( "Lookup Contacts", "For the &current lookup" )
        Send( "Smith" )
        Sleep( 3000 )
        
        ;Wait till the processor has stabilized
        processor_usage( 20, 500 )
        ;Start the Timer
        ToolTip( "TIMER START: " &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Click the OK Button
        window( "Lookup Contacts", "For the &current lookup" )
        Send( "{ENTER}" )
        
        ;Wait for Lookup Dialog to go away and Contact List View to appear
        Do
            $iT = ControlGetText ( "ACT!", "Connected Menus", "WindowsForms10.STATIC." &$sApp &"1" )
        Until $iT = "Contact List"
        
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        ;Lookup All Contacts
        ToolTip( "Preparation: Lookup All Contacts" )
        window( "ACT!", "Connected Menus" )
        Send( "!la" )
        Sleep( 5000 )
        
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func OpenContactDetailViewTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Open Contact Detail View Test
; Purpose:  Opens the Contact Detail View from the Daily Calendar View.
;           Tests how long it takes for the Contact Detail View to open.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Open Contact Detail View from Daily Calendar View"
NowTesting( $sTestName )
 
;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;--Script Start--
    $iC = 0
    Do
        $iR = 0
        $iS = 0
        $iI = 0
        ;Make sure we are on the Daily Calendar View
        window("ACT!", "Connected Menus" )
        Send( "+{F5}" )
        
        ;Wait till Daily Calendar View exists
        ToolTip( "Preparation: Open Daily Calendar View" )
        Do 
           ;Looking for (Calendar Title Bar (text: Calendar: 'date')
           $iR = ControlCommand ( "ACT!", "Connected Menus", "WindowsForms10.STATIC." &$sApp &"1", "IsVisible", "" )
        Until $iR = 1
        Sleep( 2000 ) ;Just to make sure
        ToolTip( "" )
        
        ;Wait till processor has stabilized
        processor_usage( 20, 500 )
        
        ;Start the Timer
        ToolTip( "TIMER START:" &$sTestName )
        $iTime_start[$iC] = TimerInit ( )
        
        ;Open Contact Detail View
        Send( "{F11}" )
        
        ;Wait for the Contact Detail View to open 
        Do
            ;Looking for Company Label
            $iA = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"2" )
        Until $iA = "Company"
        
        ;Stop the timer, calculate elapsed time
        $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        
        
        $iC = $iC + 1
    Until $iC = $iTestIterations  
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func UpdateDBTest( $iTestIterations ) 
;---------------------------------------------------------------------------
; Script:   Update DB Test
; Purpose:  Updates a test database to the 7.0x schema.
;           Tests how long it takes for the Database to Update.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
Dim $iC, $iR, $iS, $iI, $iT, $iA, $iTestIterations, $sTestName, $iWindow, $sA
Dim $sDBNameUpdateTest[$iTestIterations]
Dim $iTime_start[$iTestIterations]
Dim $iTime[$iTestIterations]
$sTestName = "Update Database"
NowTesting( $sTestName )

;Set AutoIt to look for partial form titles
AutoItSetOption( "WinTitleMatchMode", 2 )
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    
    ;Retrieve Memory Usage Statistics
    memorystatus_start( $sTestName )
    
    ;--Script Start--
    

    ;Check that Database Zip File Exists
    If NOT FileExists( $sDBZipFilePathLocal ) Then
        MsgBox(262144, "ERROR", "Database ZIP File doesn't exist, or is not accessable." &@CRLF &"'" &$sDBZipFilePathLocal &"'" )
        ;Copy DB ZIP file to local location
        ;FileCopy( $sDBZipFilePathNetwork, $sDBZipFilePathLocal )
    EndIf
  
    
    ;Close Current Database
    window( "ACT!", "Connected Menus" )
    $iA = WinGetTitle( "ACT!", "Connected Menus" )
    Send( "!fc" )
    Do
        Sleep( 200 )
    Until WinGetTitle( "ACT!", "Connected Menus" ) <> $iA
    Sleep(2000) ;may not be needed
    
    Do
        ;Restore the Test Database
            ToolTip( "Restore Test Database" )
            window( "ACT!", "Disconnected Menus" )
            Send( "!frd" )
            window( "Restore Database", "Select type" )
            ;Click restore as, and ok
            Send( "!a" )
            Send( "!o" )
            
            ;Enter zipped database file path
            window( "Restore Database", "Select database file to restore" )
            Send( "!r" )
            Send( $sDBZipFilePathLocal, 1 )
            Send( "!o" )
            
            ;Enter DB info
            window( "ACT!", "To location:" )
            
            ;Database name
            Send( $sDBName &"UpdateTest" &$iC &"{TAB}" )
            $sDBNameUpdateTest[$iC] = $sDBName &"UpdateTest" &$iC
            
            ;Database location
            Send( $sDBPadDirectoryPath &"{TAB 2}" )
            
            ;Database user name
            Send( $sDBUsername &"{TAB}" )
            
            ;Database password
            Send( $sDBPassword &"{TAB}" )
            
            ;Uncheck share DB, if checked
            If ControlCommand ( "ACT!", "To location:", "WindowsForms10.BUTTON." &$sApp &"1", "IsChecked", "" ) = 1 Then
                ControlCommand ( "ACT!", "To location:", "WindowsForms10.BUTTON." &$sApp &"1", "UnCheck", "" )
            EndIf
            ;Press ok
            Send( "!o" )
            
            ;Wait for DB to restore, and press ok
            WinWaitClose( "Restore Database", "Restoring database file." )
            WinWaitActive( "ACT!", "Restore completed successfully" )
            window( "ACT!", "Restore completed successfully" )
            Send( "{ENTER}" )
            Sleep( 3000 )
        ;Open Test Database
        window( "ACT!", "Disconnected Menus" )
        Send( "^o" )
        window( "Open", "Databases" )
        Send( $sDBNameUpdateTest[$iC] &".pad" )
        Sleep( 500 )
        Send( "{ENTER}" )
        
        
        ;Enter the UserName and Password & click OK
        window( "Log", "" )
        Send( "!n" &$sDBUsername &"{TAB}" )
        Send( $sDBPassword &"{ENTER}" )
        
            
            
;FINISH - ;Wait for the Update Database Dialog
            WinWaitActive( "ACT!", "The database you are attempting to open", 400 )
            window( "ACT!", "The database you are attempting to open" )
            
            ;Determine which button has enter focus, always press no
            Select
                Case StringLeft( $sBuildNumber, 1 ) = 7 
                    ;If 7.x is installed only need to press enter               
                    Send( "{ENTER}" )
                Case StringLeft( $sBuildNumber, 1 ) = 8 
                    ;If 8. is installed need to press Tab then enter 
                    Send( "{TAB}" )
                    Send( "{ENTER}" )
                    
                    ;Wait for new dialog
                    WinWaitActive( "ACT!", "ACT! will now update" )
                    window( "ACT!", "ACT! will now update" )
                    Send( "{ENTER}" )
                Case Else
                    MsgBox( 262144, "ERROR", "Unable to determine install type." )
            EndSelect
            
            
            
            ;Start the Timer
            ToolTip( "TIMER START: " &$sTestName )
            $iTime_start[$iC] = TimerInit ( )
            
            ;Click Yes to Start the Update of the Database
            Send( "{ENTER}" )
            
            ;Wait for Updated DB  Finished Dialog
;~             WinWait( "ACT", "The database has been updated.", 350 )
            
			Do
				$sA = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"2" )
				Select
					Case WinExists( "ACT", "The database has been updated." )
						$iWindow = 1
						
					Case $sA = "Company"
						$iWindow = 1
						
				EndSelect
				Sleep( 500 )
				
			Until $iWindow = 1
			
			
            ;Stop the timer, calculate elapsed time
            $iTime[$iC] = TimerDiff ( $iTime_start[$iC] ) / 1000
            ToolTip( "TIMER END: " &$sTestName )
			
            ;Click OK on the restored complete dialog
            If WinExists( "ACT", "The database has been updated." ) Then
				window( "ACT", "The database has been updated." )
				Send( "{ENTER}" )
			EndIf
			
            
            ;Wait for the Authentication Dialog
                ;Enter the UserName and Password
                ;Click OK
            ;Wait for the Database to open
            
            ;Make Sure we are on the Contact Detail View
            ;ToolTip( "Preparation: Open Contact Detail View" )
            Sleep( 10000 )
;~             ContactDetailFocus()
            ;Clear Tooltip
            ToolTip( "" )
            Sleep( 8000 ) ;Just to make sure
            
            ;Delete the Test Database
            DeleteCurrentDatabase()
            
            ;Open the ACT1K DB, so the 'the last db could not be found' doesn't appear
                window( "ACT!", "" )
                Send( "!fo" )
                window( "Open", "" )
                Sleep( 750 )
                Send( $sDBPadFilePath )
                Send( "{ENTER}" )
                
                ;Wait for the Authentication Dialog
                WinWaitActive( "Log", "Enter your" )
                window( "Log", "Enter your" )
                
                ;Enter the UserName and Password
                Send( "!n" )
                Send( $sDBUsername &"{TAB}" )
                Send( $sDBPassword )
                Send( "{ENTER}" )
                
                ;Wait for the Database to open
                Do
                    Sleep( 250 )
                    $iA = ControlGetText ( "ACT!", "", "WindowsForms10.EDIT." &$sApp &"4" )
                Until StringInStr( $iA, $sDBUsername ) <> 0
				;MsgBox(262144,"Username",$sDBUsername &@CRLF &$sApp &@crlf &$iA)
                Sleep( 5000 )
                
                ;Close the DB
                ToolTip( "Close the DB" )
                window( "ACT!", "Connected Menus" )
                $iA = WinGetTitle( "ACT!", "Connected Menus" )
                Send( "!fc" )
                Do
                    Sleep( 200 )
                Until WinGetTitle( "ACT!", "Connected Menus" ) <> $iA
                Sleep(2000)
                ToolTip( "" )
            ;END Open ACT1K DB
            
        $iC = $iC + 1
    Until $iC = $iTestIterations 
    ToolTip( "" )
    
    ;Retrieve Memory Usage Statistics
    memorystatus_end( $sTestName )
    
    ;Write the Timer to the log
    FileWriteLine( $sResults_log, "Completed " &$iTestIterations &" iterations of the following test." )
    Do
        FileWriteLine( $sResults_log, "Iteration " &$iI + 1 &": " &$sTestName &", " &$iTime[$iI] )
        $iI = $iI + 1
    Until $iI = $iTestIterations
    FileWriteLine( $sResults_log, "" )
    ;msgbox(262144, "TEST", $iTime[0] &@CRLF &$iTime[1])
    
    TestComplete( $sTestName )
EndFunc


Func GetStartupInformation()
;---------------------------------------------------------------------------
; Script:   Get Startup Information
; Purpose:  Asks user for Username, Password and Database PAD file
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)

    ;--Script Start--
    ;Get Path to Current Users My Documents
    ;Error Handling Code. Only executed if the Windows Scripting Host has not been installed.
    ;Dialog to Determine Setup Information
    ;Check if Database File Exists
    If NOT FileExists( $sDBPadFilePath ) Then
        MsgBox(262144, "ERROR", "File doesn't exist: " &@CRLF &$sDBPadFilePath )
    Else
        MsgBox(262144, "Sucess", "File does exist: " &@CRLF &$sDBPadFilePath )
    EndIf

EndFunc


Func EnableAntiVirus() 
;---------------------------------------------------------------------------
; Script:   Enable Anti Virus
; Purpose:  Enables the McAfee Anti Virus Services (McShield, McTaskManager, 
;           McAfeeFramework) using the Net Start command.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------

 
;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    If IsDeclared( "sLogFile" ) Then
		TestingNote( "Enable AntiVirus" )
	EndIf
    
    ;--Script Start--
    RunWait( "CMD /C Net Start McShield" )

    RunWait( "CMD /C Net Start McTaskManager" )

    RunWait( "CMD /C Net Start McAfeeFramework" )
        
EndFunc


Func DisableAntiVirus() 
;---------------------------------------------------------------------------
; Script:   Disable Anti Virus
; Purpose:  Disables the McAfee Anti Virus Services (McShield, McTaskManager,
;           McAfeeFramework) using the Net Stop command.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;Set AutoIt to look for partial form titles
AutoItSetOption("WinTitleMatchMode", 2)
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    If IsDeclared( "sLogFile" ) Then
		TestingNote( "Disable AntiVirus" )
    EndIf
	
    ;--Script Start--
    RunWait( "CMD /C Net Stop McShield" )
            
    RunWait( "CMD /C Net Stop McTaskManager" )
            
    RunWait( "CMD /C Net Stop McAfeeFramework" )
    

EndFunc


Func DeleteCurrentDatabase() 
;---------------------------------------------------------------------------
; Script:   Delete Current Database
; Purpose:  Deletes the Currently Opened Database.
;           Optionally Opens a different database after current DB is deleted.
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------

 
;Set AutoIt to look for partial form titles
AutoItSetOption( "WinTitleMatchMode", 2 )
;Set AutoIt to require explicit declaration of variables
;AutoItSetOption("MustDeclareVars", 1)
    TestingNote( "Delete Current Database" )
    
    ;--Script Start--
    ;Delete the Test Database   
    window( "ACT!", "Connected Menus" )
    Send( "!t" )
    Sleep( 150 )
    Send( "b" )
    Sleep( 150 )
    Send( "d" )
    Sleep( 150 )
    
    ;Check for Database Delete Dialog
    window( "Delete Database", "" )
    ;Send("!y")
    ControlClick( "Delete Database", "", "Button1", "left", 1 )
    
    ;Proceed with Delete?
    window( "Proceed With Delete?", "" )
    ControlClick( "Proceed With Delete?", "", "Button1", "left", 1 )
    
    ;Wait for ACT shell
    Sleep( 5000 )
    window( "ACT!", "" )
    

EndFunc


Func PrepareReboot()
;---------------------------------------------------------------------------
; Script:   Prepare Schema Reboot
; Purpose:  Prepare machine to reboot and restart the Scripts
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; ValidateContactCount($sUsername)
;---------------------------------------------------------------------------
 
;#include <Libraries\LaunchACT.au3>
 
 
;Set AutoIt to look for partial form titles
AutoItSetOption( "WinTitleMatchMode", 2 )
TestingNote( "Prepare Reboot" )

    ;--Script Start--
    ;Setup the Command Line
    ;Set the Registry Auto Logon information for smokeadmin
    ;Write user info to registry - IT WORKS!!!!!
    ToolTip( "Prepare machine to reboot and continue with the Performance Tests" )
    
    ;Save the logfiles to the registry
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentResultsLog", "REG_SZ", $sResults_log )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentStatusLog", "REG_SZ", $sStatus_log )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentLogFile", "REG_SZ", $sLogFile )
    
    ;Write login information
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "AutoAdminLogon", "REG_SZ", "1" )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DefaultUserName", "REG_SZ", $sLogonUserName )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DefaultDomainName", "REG_SZ", $sLogonDomain )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DefaultPassword", "REG_SZ", $sLogonUserPassword )

    ;Start the automation scripts using RunOnce
    ;Try these, they run last, appears to work better
    RegWrite( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce", "Delete user Password", "REG_SZ", $sBatchFilePath )
    RegWrite( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce", "RestartACTPerfTests", "REG_SZ", $sPerfTestPostReboot )
    
    ;Delete the file if they exist
    If FileExists( $sBatchFilePath ) Then FileDelete( $sBatchFilePath )
    If FileExists( $sPerfTestPostReboot ) Then FileDelete( $sPerfTestPostReboot )
    
#region --- Batch File ---
    ;Write batch file, used to delete password from registry after reboot
    FileWriteLine( $sBatchFilePath, '@Echo Off' )
    FileWriteLine( $sBatchFilePath, 'CLS' )
    FileWriteLine( $sBatchFilePath, 'c:' )
    FileWriteLine( $sBatchFilePath, 'cd ' &@ScriptDir&"\")
    FileWriteLine( $sBatchFilePath, 'reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f' )
    FileWriteLine( $sBatchFilePath, 'reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /f' )
    FileWriteLine( $sBatchFilePath, 'del ActRemoveReg.bat' )
    
    ;Create a au3 file that will run the last test after the restart
    FileWriteLine( $sPerfTestPostReboot, ';After Reboot, Launch this file to re-start the automated performance tests')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, '#include "' &$sIncludeFilePath_Jets &'"')
    FileWriteLine( $sPerfTestPostReboot, '#include "' &$sIncludeFilePath_Automation &'"')
	
    FileWriteLine( $sPerfTestPostReboot, '')
	
    FileWriteLine( $sPerfTestPostReboot, ';Start the last test, give the machine time to finish loading')
    FileWriteLine( $sPerfTestPostReboot, 'Sleep( 30000 )')      
    FileWriteLine( $sPerfTestPostReboot, 'DisableAntiVirus()')
    FileWriteLine( $sPerfTestPostReboot, 'Sleep( 5000 )')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'PerfTestSetup()')  
    FileWriteLine( $sPerfTestPostReboot, 'Sleep( 5000 )')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'LaunchACTTest( 1 )')
    FileWriteLine( $sPerfTestPostReboot, 'ToolTip( "Sleeping for 10 seconds" )')
    FileWriteLine( $sPerfTestPostReboot, 'Sleep( 10000 )')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'CheckForScheduler()')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'AppVariable()')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'OpenDBTest( 1 )')
    FileWriteLine( $sPerfTestPostReboot, 'ToolTip( "Sleeping for 10 seconds" )')
    FileWriteLine( $sPerfTestPostReboot, 'Sleep( 10000 )')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'UpdateDBTest( 2 ) ;Needs network connectivity test implemented')
    FileWriteLine( $sPerfTestPostReboot, 'ToolTip( "Sleeping for 10 seconds" )')
    FileWriteLine( $sPerfTestPostReboot, 'Sleep( 10000 )')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'EnableAntiVirus()')
    FileWriteLine( $sPerfTestPostReboot, '')
    FileWriteLine( $sPerfTestPostReboot, 'Msgbox(262144, "Done", "Section 9 Testing completed." )')
    FileWriteLine( $sPerfTestPostReboot, 'FileDelete( "' &$sPerfTestPostReboot &'" )' )
    FileWriteLine( $sPerfTestPostReboot, '')
	
    ;Copy the results file to the network location (when tests are complete)
;~     FileWriteLine( $sPerfTestPostReboot, 'FileCopy( "' &$sResults_log &'", "' &$sResults_log_temp &'" )' )
;~     FileWriteLine( $sPerfTestPostReboot, 'FileCopy( "' &$sStatus_log &'", "' &$sStatus_log_temp &'" )' )
;~     FileWriteLine( $sPerfTestPostReboot, 'FileCopy( "' &$sLogFile &'", "' &$sLogFile_temp &'" )' )
;~     FileWriteLine( $sPerfTestPostReboot, '')
	
    ;Clear out the registry log information
    FileWriteLine( $sPerfTestPostReboot, 'RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentResultsLog", "REG_SZ", "" )' )
    FileWriteLine( $sPerfTestPostReboot, 'RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentStatusLog", "REG_SZ", "" )' )
    FileWriteLine( $sPerfTestPostReboot, 'RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentLogFile", "REG_SZ", "" )' )
    FileWriteLine( $sPerfTestPostReboot, '')
	
    FileWriteLine( $sPerfTestPostReboot, 'Exit')
	FileWriteLine( $sPerfTestPostReboot, '')
	
#endregion --- Batch File ---

    ToolTip( "Rebooting the machine" )
    
    ;Shutdown the machine
    Shutdown( 2 )

EndFunc


Func process_memusage( $sProcess )
;---------------------------------------------------------------------------
; Script:   Process Memory Usage
; Purpose:  Returns the amount of memory in use by a system process
; Application:  Windows Task Manger
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------
Dim $iItem, $sProcess, $iCnt, $sItemtext, $sItemcount
;~     TestingNote( "Retrieve processor memory usage" )
    
    ;Verify taskmanager is running
    taskmanager()
    
    ;Find the process in the list
    $iItem = ControlListView( "Windows Task", "", "SysListView321", "FindItem", $sProcess )
        If $iItem  = -1 Then ;Check for errors
            Return "***The '" &$sProcess &"' process could not be found.***"
        EndIf
        
    ;Determine which column contains the memory usage info
    $iCnt = -1
    Do
        $iCnt = $iCnt + 1
        $sItemtext = ControlListView( "Windows Task", "", "SysListView321", "GetText", $iItem, $iCnt )
        If @error Then 
            Return "***Unable to retrieve subitem text.***"
        EndIf
    Until StringInStr( $sItemtext, "k" )
        
    Return $sItemtext
    
EndFunc


Func processor_usage( $desired_max, $delay )
;---------------------------------------------------------------------------
; Script:   Processor Usage
; Purpose:  Pauses script till processor usage drops below $desired_max, $delay in miliseconds between tests
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; taskmanager()
;---------------------------------------------------------------------------    

Dim $processor_usage
;~     TestingNote( "Wait till processor drops below " &$desired_max &"%" )
    
    ;Verify taskmanager is running
    taskmanager()
    
    ;Loop till processor drops below desired max, delay between each test
    Do  
        $processor_usage = StatusbarGetText( "Windows Task Manager", "", 2)
        ;Remove text to keep only the numberic value
        $processor_usage = StringTrimRight( $processor_usage, 1 )
        $processor_usage = StringReplace( $processor_usage, "CPU Usage: ", "" )
        Sleep( $delay )
    Until $processor_usage <= $desired_max

EndFunc


Func processor_status()
;---------------------------------------------------------------------------
; Script:   Processor Status
; Purpose:  Retrieves current processor usage, value range 0-100
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; taskmanager()
;---------------------------------------------------------------------------    
    Dim $processor_usage
;~     TestingNote( "Retrieve processor usage." )
    
    ;Verify taskmanager is running
    taskmanager()
    
    ;Retrieve usage state from taskmanager
    $processor_usage = StatusbarGetText( "Windows Task Manager", "", 2)
    ;Remove text to keep only the numberic value
    $processor_usage = StringTrimRight( $processor_usage, 1 )
    $processor_usage = StringReplace( $processor_usage, "CPU Usage: ", "" )
    
    Return $processor_usage
    
EndFunc


Func taskmanager()
;---------------------------------------------------------------------------
; Script:   taskmanager
; Purpose:  Launches the taskmanger (minimized) it it is not running 
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------    
;~     TestingNote( "Verify taskmanger is running" )
    
    ;Make sure that taskmanager is running, if not launch it
    If ProcessExists( "taskmgr.exe") = 0 Then
;~         TestingNote( "Taskmanger not running, and will be launched" )
        Run( "taskmgr.exe", "", @SW_MINIMIZE )
        
        ;Wait till taskmanager is running
        ProcessWait( "taskmgr.exe" )
    EndIf
    
EndFunc


Func memorystatus_start( $sTestName )
;---------------------------------------------------------------------------
; Script:   memorystatus_start
; Purpose:  Retrieves the current memory status of the programs, at the beginning of a test
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; process_memusage
;---------------------------------------------------------------------------  
    TestingNote( "Retrieve memory usage statistics at the start of a test" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Started: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
EndFunc


Func memorystatus_end( $sTestName )
;---------------------------------------------------------------------------
; Script:   memorystatus_start
; Purpose:  Retrieves the current memory status of the programs, at the end of a test
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; process_memusage
;---------------------------------------------------------------------------    
    TestingNote( "Retrieve memory usage statistics at the end of a test" )
    
    ;Retrieve Memory Usage Statistics
    FileWriteLine( $sStatus_log, "Test Ended: " &$sTestName )
    FileWriteLine( $sStatus_log, "    ACT Memory Status: " &process_memusage( $sProcessName ) )
    FileWriteLine( $sStatus_log, "    SQL Server Memory Status: " &process_memusage( "sqlservr.exe" ) )
    FileWriteLine( $sStatus_log, "" )
    
EndFunc


Func performance_db_setup()
;---------------------------------------------------------------------------
; Script:   performance_db_setup
; Purpose:  Setup the ACT1K Db, preparing for performance tests
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; process_memusage
;---------------------------------------------------------------------------    
;~     TestingNote( "Setup the performance database" )
    
    ;Database paths
    $desktop_db_path = $sDBZipFilePathLocal
;~     $network_db_path = "\\logixdata\group\actqa\performancedatabase\zipped\ACT! x175_1K.zip"
;~     $sDBPadDirectoryPath = 
    
    $db_user = $sDBUsername
    $db_password = $sDBPassword
    
    
    ;Launch ACT
    $sInstallPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\ACT\Install", "InstallPath")
    FileChangeDir( $sInstallPath )
;~     Select
;~         Case FileExists( $sInstallPath &"Act7.exe" )
;~             Run( "Act7.exe" )
;~         Case FileExists( $sInstallPath &"Act8.exe" )
            Run( "Act8.exe" )
;~         Case Else
;~             MsgBox( 262192, "Error", "ACT could not be launched, it may not be installed." )
;~     EndSelect
    
    Sleep( 20000 )
    
    ;Look for various windows that may appear when ACT is launched
    While 2
        Select
			Case WinExists( "ACT!", "The color setting")
				window( "ACT!", "The color setting")
				Send("!h")
				Send("!o")
			
			Case WinExists( "Log on", "Enter" )
				window( "Log on", "Enter" )
				Send( "!c" )
				
				window( "ACT" )
				Send( "^o" )
				
            Case WinExists( "ACT!", "ACT! Update allows" )
                window( "ACT!", "ACT! Update allows" )
                Send( "{TAB}{ENTER}" )
                
                ;Wait for the first page of the getting started wizard
                WinWaitActive( "ACT!", "Welcome to the ACT!" )
                window( "ACT!", "Welcome to the ACT!" ) 
                Send( "{ENTER}" )
                
                ;Select Word Processor Page
                WinWaitActive( "ACT!", "Word Processor" )
                window( "ACT!", "Word Processor" )
                Send( "{ENTER}" )
                
                ;E-mail setup page
                WinWaitActive( "ACT!", "Select E-mail" )
                window( "ACT!", "Select E-mail" )
                Send( "{TAB}{SPACE}{ENTER}" )
                
                ;Enter E-mail data
                WinWaitActive( "ACT!", "Internet Mail" )
                window( "ACT!", "Internet Mail" )
                Send( "!a" )
                
                ;Wait for Account information dialog
                WinWaitActive( "Internet Mail", "User Information" )
                window( "Internet Mail", "User Information" )
                
                ;Focus to User Info Tab
                MouseClick( "left",  60, 40, 1, 2 )
                
                ;Account Name
                Send( "{TAB}onecooldude")
                
                ;Real Name
                Send( "{TAB}onecooldude" )
                
                ;Organization
                Send( "{TAB}Tough Guys" )
                
                ;E-mail
                Send( "{TAB}onecooldude@toughguy.net" )
                
                ;Reply E-mail
                ;Send( "{TAB}jtaylor@act.com" )
                
                ;Focus to Outgoing Mail Server Tab
                MouseClick( "left",  155, 40, 1, 2 )
                
                ;SMTP Server
                Send( "{TAB}smtp.toughguy.net" )
                
                ;Focus to Dialog
                window( "Internet Mail", "" )
                
                ;Focus to Incoming Mail Server Tab
                MouseClick( "left",  265, 40, 1, 2 )
                
                ;POP
                Send( "{TAB}pop.toughguy.net" )
                
                ;User name
                Send( "{TAB}onecooldude@toughguy.net" )
                
                ;Password
                Send( "{TAB}adrian456" )
                
                ;Save password
                Send( "{TAB}{SPACE}" )
                
                ;Focus to Dialog
                window( "Internet Mail", "" )
                
                ;Focus to Advanced Tab
                MouseClick( "left",  355, 40, 1, 2 )
                
                ;Leave messages on server
                Send( "{TAB}{SPACE}" )
                
                ;Remove after
                Send( "{TAB}{SPACE}" )
                
                ;# of Days
                Send( "{TAB}{DEL}5" )
                
                ;Close dialog
                Send( "{ENTER}" )
                
                ;Press Next
                WinWaitActive( "ACT", "Internet Mail Settings" )
                window( "ACT", "Internet Mail Settings" )
                Send( "!n" )
                
                ;Press Next
                WinWaitActive( "ACT", "E-mail Setup" )
                window( "ACT", "E-mail Setup" )
                Send( "!n" )
                
                ;Press Next on database setup dialog
                WinWaitActive( "ACT", "Database Setup" )
                window( "ACT", "Database Setup" )
                Send( "!n" )
                
                ;Click Finish on last page
                WinWaitActive( "ACT", "Completing" )
                window( "ACT", "Completing" )
                Send( "{ENTER}" )
                
            Case WinExists( "ACT", "The last database" )
                window( "ACT", "The last database" )
                Send( "{ENTER}" )
                
                ;Open DB dialog appears, close it and restore the test database
                winwait( "Open", "ACT! Database" )
                WinClose( "Open", "ACT! Database" )
                
                ;Open the restore DB dialog
                winwait( "ACT", "" )
                window( "ACT", "" )
                Send( "!frd" )
                
                ;Select restore as
                winwait( "Restore Database", "" )
                window( "Restore Database", "" )
                Send( "{Down}{ENTER}" )
                
                WinWait( "Restore Database", "Select database" )
                
                ;Enter in the DB Path
                If FileExists( $desktop_db_path )Then
                    ;Enter in the desktop path to the restore as control    
                    window( "Restore Database", "Select database" )     
                    Send( $desktop_db_path, 1 )
                    Send( "!o" )
                Else
                    ;Copy the network file to the desktop and use it
;~                     If FileExists( $network_db_path ) Then
;~                         FileCopy( $network_db_path, @DesktopDir, 0 )
;~                         
;~                         ;Enter in the desktop path to the restore as control    
;~                         window( "Restore Database", "Select database" )             
;~                         Send( $desktop_db_path, 1 )
;~                         Send( "!o" )
;~                     EndIf
					MsgBox(262192,"ERROR","The database could not be found." &"The script will close." )
					Exit
                EndIf
                
                ;Enter in new DB information
                WinWait( "ACT!", "database name" )
                window( "ACT!", "database name" )
                Send( $sDBName &"{TAB}" ) ;DB Name
                Send( $sDBPadDirectoryPath &"{TAB 2}" ) ;DB Location
                Send( $sDBUsername &"{TAB}" ) ;User Name
                Send( $sDBPassword ) ;Password
                Send( "{ENTER}" )
				
				;check for create directory prompt
				Sleep( 1000 )
				While 1
					Select
						Case WinExists( "Create Directory", "The directory" )
							window( "Create Directory", "The directory" )
							Send ("!y" )
							ExitLoop
							
						Case WinExists( "Restore Database" )
							ExitLoop
					EndSelect
					Sleep( 250 )
				WEnd
    
    
    
                WinWaitClose( "Restore Database" )
                
                ;Check for Restore DB error
                Sleep( 500 )
                If WinExists( "ACT!", "ACT.Framework" ) Then
                    MsgBox( 262144, "ERROR", "The database was not restored." )
                    Exit
                EndIf
                
                ;Press enter on restore completed sucessfully dialog
                winwait("ACT!", "Restore completed" )
                window( "ACT!", "Restore completed" )
                Send( "{ENTER}" )
                
                ;Open the database
                Send( "^o" )
                Send( $sDBName &".pad" )
                Send( "{ENTER}" )
                
                ;Enter in the login info
                window( "Log", "" )
                Send( "+{TAB}" ) ;Focus to username field
                Send( $db_user &"{TAB}" )
                Send( $db_password &"{ENTER}" )
                
                ;Database verification appears
                window( "ACT!", "The database you are" )
                Send( "{TAB}{ENTER}" )
                
                ;Update starting dialog
                window( "ACT!", "ACT! will now" )
                Send( "{ENTER}" )
                
                WinWaitClose( "", "Updating" )
                
                ;Database has been verified
                WinWait( "ACT!", "The database has been" )
                window( "ACT!", "The database has been" )
                Send( "{ENTER}" )
                
    ;Act Loads DB
                
                ExitLoop
            Case WinExists( "Open", "ACT! Database" )
                ;Open DB dialog appears, close it and restore the test database
                WinClose( "Open", "ACT! Database" )
                
                ;Open the restore DB dialog
                winwait( "ACT", "" )
                window( "ACT", "" )
                Send( "!frd" )
                
                ;Select restore as
                winwait( "Restore Database", "" )
                window( "Restore Database", "" )
                Send( "{Down}{ENTER}" )
                
                WinWait( "Restore Database", "Select database" )
                
                ;Enter in the DB Path
                If FileExists( $desktop_db_path )Then
                    ;Enter in the desktop path to the restore as control    
                    window( "Restore Database", "Select database" )     
                    Send( $desktop_db_path, 1 )
                    Send( "!o" )
                Else
                    ;Copy the network file to the desktop and use it
;~                     If FileExists( $network_db_path ) Then
;~                         FileCopy( $network_db_path, @DesktopDir, 0 )
;~                         
;~                         ;Enter in the desktop path to the restore as control    
;~                         window( "Restore Database", "Select database" )             
;~                         Send( $desktop_db_path, 1 )
;~                         Send( "!o" )
;~                     EndIf
					MsgBox(262192,"ERROR","The database could not be found." &"The script will close." )
					Exit
                EndIf
                
                ;Enter in new DB information
                WinWait( "ACT!", "database name" )
                window( "ACT!", "database name" )
                Send( $sDBName &"{TAB}" ) ;DB Name
                Send( $sDBPadDirectoryPath &"{TAB 2}" ) ;DB Location
                Send( $sDBUsername &"{TAB}" ) ;User Name
                Send( $sDBPassword ) ;Password
                Send( "{ENTER}" )
                
				;check for create directory prompt
				Sleep( 1000 )
				While 1
					Select
						Case WinExists( "Create Directory", "The directory" )
							window( "Create Directory", "The directory" )
							Send ("!y" )
							ExitLoop
							
						Case WinExists( "Restore Database" )
							ExitLoop
					EndSelect
					Sleep( 250 )
				WEnd
				
				
				
                WinWaitClose( "Restore Database" )
                
                ;Check for Restore DB error
                Sleep( 500 )
                If WinExists( "ACT!", "ACT.Framework" ) Then
                    MsgBox( 262144, "ERROR", "The database was not restored." )
                    Exit
                EndIf
                
                ;Press enter on restore completed sucessfully dialog
                winwait("ACT!", "Restore completed" )
                window( "ACT!", "Restore completed" )
                Send( "{ENTER}" )
                
                ;Open the database
                Send( "^o" )
                Send( $sDBName &".pad" )
                Send( "{ENTER}" )
                
                ;Enter in the login info
                window( "Log", "" )
				Sleep( 5000 )
                Send( "+{TAB}" ) ;Focus to username field
                Send( $db_user &"{TAB}" )
                Send( $db_password &"{ENTER}" )
                
                ;Database verification appears
                window( "ACT!", "The database you are" )
                Send( "{TAB}{ENTER}" )
                
                window( "ACT!", "ACT! will now update the database." )
                Send( "{ENTER}" )
                
                WinWaitClose( "", "Updating" )
                
                ;Database has been verified
                WinWait( "ACT!", "The database has been" )
                window( "ACT!", "The database has been" )
                Send( "{ENTER}" )
                
                ExitLoop
        EndSelect   
		
        Sleep( 500 )    
    WEnd
    
    AppVariable()
    
    ;Wait for the contact detail to be active
        Do
            $iA = ControlGetText ( "ACT!", "", "WindowsForms10.STATIC." &$sApp &"2" )
        Until $iA = "Company"
        Sleep( 5000 )
    
;~     TestingNote( "Performance database has been prepared" )
    MsgBox( 262144, "Performance DB", "The performance database has been prepared for testing." &@CRLF &@CRLF &"Dialog will automatically close.", 50 )
EndFunc


Func start_all_performance_tests()
;---------------------------------------------------------------------------
; Script:   start_all_performance_tests
; Purpose:  Regboot the machine and start all performance tests
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------  
    ToolTip( "Reboot machine and start the Performance Tests" )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "AutoAdminLogon", "REG_SZ", "1" )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DefaultUserName", "REG_SZ", $sLogonUserName )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DefaultDomainName", "REG_SZ", $sLogonDomain )
    RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DefaultPassword", "REG_SZ", $sLogonUserPassword )

    ;Try these, they run last, appears to work better
    RegWrite( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce", "Delete user Password", "REG_SZ", $sBatchFilePath )
    RegWrite( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce", "StartACTPerfTests", "REG_SZ", $sRun_all_test_path )
    
    If FileExists( $sBatchFilePath ) Then FileDelete( $sBatchFilePath )
    
    ;Create a batch file that will delete the user name and password from the registry
    FileWriteLine( $sBatchFilePath, '@Echo Off' )
    FileWriteLine( $sBatchFilePath, 'CLS' )
    FileWriteLine( $sBatchFilePath, 'c:' )
    FileWriteLine( $sBatchFilePath, 'cd '&@ScriptDir&'\' )
    FileWriteLine( $sBatchFilePath, 'reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f' )
    FileWriteLine( $sBatchFilePath, 'reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /f' )
    FileWriteLine( $sBatchFilePath, 'del ActRemoveReg.bat' )
    
    ToolTip( "Rebooting the machine" )
    ;Restart the machine
    Shutdown( 2 )
    
EndFunc


Func NowTesting( $sText )
;---------------------------------------------------------------------------
; Script:   	NowTesting
; Purpose:  	Write to the log file the specified text, usually the test name
; Application:  Windows
; Author:       Justin Taylor (modifed from Sue's example)
;---------------------------------------------------------------------------

    FileWriteLine( $sLogFile, "" )
    $iLength = StringLen( $sText )
    $sString = _StringRepeat("|", $iLength )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, "Testing: " & $sText )
    FileWriteLine( $sLogFile, $sString )

EndFunc


Func PassedTest( $sText )
;---------------------------------------------------------------------------
; Script:   	PassedTest
; Purpose:  	Write to the log file the specified text, usually the test name
; Application:  Windows
; Author:       Justin Taylor (modifed from Sue's example)
;---------------------------------------------------------------------------

    $iLength = StringLen( $sText )
    $sString = _StringRepeat("*", $iLength )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, $sText & " -Passed" )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, "" )
    
EndFunc


Func FailedTest( $sText )
;---------------------------------------------------------------------------
; Script:   	FailedTest
; Purpose:  	Write to the log file the specified text, usually the test name
; Application:  Windows
; Author:       Justin Taylor (modifed from Sue's example)
;---------------------------------------------------------------------------
    $iLength = StringLen( $sText )
    $sString = _StringRepeat("#", $iLength )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, $sText & " -FAILED" )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, "" )
    
EndFunc


Func TestComplete( $sText )
;---------------------------------------------------------------------------
; Script:		TestComplete
; Purpose:  	Write to the log file the specified text, usually the test name
; Application:  Windows
; Author:       Justin Taylor (modifed from Sue's example)
;---------------------------------------------------------------------------

    $iLength = StringLen( $sText )
    $sString = _StringRepeat("/\", $iLength/2 )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, "Test Complete: " &$sText )
    $sString = _StringRepeat("\/", $iLength/2 )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, "" )
    
EndFunc


Func TestingNote( $sText )
;---------------------------------------------------------------------------
; Script:		TestingNote
; Purpose:  	Write to the log file the specified text, usually the test name
; Application:  Windows
; Author:       Justin Taylor (modifed from Sue's example)
;---------------------------------------------------------------------------
    $iLength = StringLen( $sText )
    $sString = _StringRepeat(".", $iLength )
    FileWriteLine( $sLogFile, $sString )
    FileWriteLine( $sLogFile, "Note: " &$sText )
    FileWriteLine( $sLogFile, $sString )
    
    
EndFunc

Func write_footer()
;---------------------------------------------------------------------------
; Script:   write_header
; Purpose:  Write header to log file
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------
    
    Dim $iResult 
    
    ;Write header to Results and Log file
    $iResult = FileWriteLine( $sResults_log, "ACT! Version: " &$sBuildNumber )
    
    ;If the log file can't be written, move to the desktop
    If $iResult = 0  Then 
        MsgBox(262160,"Error","Unable to write to the log file in: '" &$sResults_log &"'." & @CRLF & "" & @CRLF & "The script will not exit.")
    EndIf
    
    FileWriteLine( $sResults_log, "Test Date and Time: " &_now() )
    FileWriteLine( $sResults_log, "System Processor: " &processor_data() )
    FileWriteLine( $sResults_log, "System RAM: " &memory( 1 ) &" kb")
    FileWriteLine( $sResults_log, "Computer OS: " &@OSVersion &" - " &@OSServicePack )
    FileWriteLine( $sResults_log, "Computer Name: "&@ComputerName)
    FileWriteLine( $sResults_log, "" )
    
    FileWriteLine( $sStatus_log, "ACT! Version: " &$sBuildNumber )
    FileWriteLine( $sStatus_log, "Test Date and Time: " &_now() )
    FileWriteLine( $sStatus_log, "System Processor: " &processor_data() )
    FileWriteLine( $sStatus_log, "System RAM: " &memory( 2 ) &" kb")
    FileWriteLine( $sStatus_log, "Computer OS: " &@OSVersion &" - " &@OSServicePack )
    FileWriteLine( $sStatus_log, "Computer Name: "&@ComputerName)
    FileWriteLine( $sStatus_log, "" )
    
    FileWriteLine( $sLogFile, "ACT! Version: " &$sBuildNumber )
    FileWriteLine( $sLogFile, "Test Date and Time: " &_now() )
    FileWriteLine( $sLogFile, "System Processor: " &processor_data() )
    FileWriteLine( $sLogFile, "System RAM: " &memory( 2 ) &" kb")
    FileWriteLine( $sLogFile, "Computer OS: " &@OSVersion &" - " &@OSServicePack )
    FileWriteLine( $sLogFile, "Computer Name: "&@ComputerName)
    FileWriteLine( $sLogFile, "" )
    
EndFunc






Func Update_spreadsheet()
;---------------------------------------------------------------------------
; Script:   Update_spreadsheet
; Purpose:  Add the test results to the spreadsheet
; Application:  Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; process_memusage
;---------------------------------------------------------------------------    
;~     TestingNote( "Setup the performance database" )
	
	;Open the spreadsheet
	
	;move to correct tab
	
	;move to correct location
	
	;run the tool to copy the data to the spreadsheet
	
	;save the spreadsheet
	
	;show message to user that spreadsheet has been updated
	MsgBox(262208,"Completed","The performance tests have completed." & @CRLF & "The spreadsheet has been updated.")


	
EndFunc