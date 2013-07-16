;---------------------------------------------------------------------------
; Script:   Performance Test Automation
; Purpose:  Performance Test Automation on the Act Application
;           Calls individual test functions which reside in 
;           'Func-AutomatedPerformance.au3'
; Application:  Act for Windows
; Author:       Justin Taylor
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Functions in this script
; 
;---------------------------------------------------------------------------


#include "Func-Jets.au3"
#include "Func-AutomatedPerformance.au3"
#include <process.au3>

;---------------------------------------------------------------------------
;Set up defaults
;---------------------------------------------------------------------------
Opt( "MouseCoordMode", 0 )
Opt( "SendKeyDelay", 1 )


;Press Esc to terminate script
HotKeySet( "{ESC}", "Terminate" )
HotKeySet( "{PAUSE}", "TogglePause" )

;Allow only one instance of script
onescript( )

Dim $selection

;---------------------------------------------------------------------------
;Script Start                               -Pressing ESC will cancel script
;---------------------------------------------------------------------------

	
;Declare variables etc.
PerfTestSetup()

;Write header to log
write_header()

;SECTION 1
;GetStartupInformation()

	DisableAntiVirus()
	
	LaunchACTTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
		
	CheckForScheduler()
	
	AppVariable()
	
	MinimizeACT()
	
	OpenDBTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenPreferencesTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenDefineFieldsTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenTaskListTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenActivityDialogTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	AddNewActivityTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenExistingActivityTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	ClearExistingActivityTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenHistoryDialogTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenNotesDialogTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	AddNewNoteTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenOpportunityDialogTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )
;SECTION 2
;RESTART ACT!!!
	LaunchACTTest( 1 )
		Sleep( 10000 )
		ToolTip( "Sleeping for 10 seconds" )
		
	CheckForScheduler()
	
	AppVariable()
	
	OpenDBTest( 1 )
Sleep(35000) ;attempt to clean up lookups
	MinimizeACT()
	
	OpenLookupDialogTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	LookupContactDetailResultsTest( 2 ) 
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	LookupContactListResultsTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenContactDetailViewTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )

	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )
 
;SECTION 3
;RESTART ACT!!! - 60 second time out!!!!!!, make it an option????
	LaunchACTTest( 1 )
		Sleep( 10000 )
	
	CheckForScheduler()
	
	AppVariable()
	
	OpenDBTest( 1 )
	
	MinimizeACT()
	
	OpenGroupDetailViewTest( 2 )
		Sleep( 5000 )
	
	
	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )
	

;SECTION 4
;RESTART ACT!!! - 60 second time out!!!!!!, make it an option????
	LaunchACTTest( 1 )
		Sleep( 10000 )
	
	CheckForScheduler()
	
	AppVariable()
	
	OpenDBTest( 1 )
	
	MinimizeACT()
	
	OpenCompanyDetailViewTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	
	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )
	
	
;SECTION 5
;RESTART ACT!!!
	LaunchACTTest( 1 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	CheckForScheduler()
	
	AppVariable()
	
	OpenDBTest( 1 )
	
	MinimizeACT()
	
	OpenDailyCalendarTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )
	

;SECTION 6  
;RESTART ACT!!!
	LaunchACTTest( 1 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	CheckForScheduler()
	
	AppVariable()
	
	OpenDBTest( 1 )
	
	MinimizeACT()
	
	OpenWeeklyCalendarTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
			
	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )

;SECTION 7  
;RESTART ACT!!!        
	LaunchACTTest( 1 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	CheckForScheduler()
	
	AppVariable()
	
	OpenDBTest( 1 )
	
	MinimizeACT()
	
	OpenMonthlyCalendarTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenCompanyListTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenGroupListTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenOpportunityListTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	OpenContactListTest( 2 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
 
;need e-mail verification
	MinimizeACT()
	
	OpenWriteEmailClientClosedTest( 2 );also opens word processor, don't see why!!!!!
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	
	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )
	
	
;SECTION 8
;RESTART ACT!!!
	LaunchACTTest( 1 )
		Sleep( 10000 )
		ToolTip( "Sleeping for 10 seconds" )
	
	CheckForScheduler()
	
	AppVariable()
	
	OpenDBTest( 1 )

;need e-mail verification        
	MinimizeACT()
	
	OpenWriteEmailClientOpenTest( 2 )  ;also opens word processor, don't see why!!!!!
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	MinimizeACT()
	
	CreateNewDBTest( 2, "ACT1K" )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	ToolTip( "Close ACT" )
	WinClose( "ACT!", "" )
	$sProcess = WinGetProcess ( "ACT!", "" )
	Do
		Sleep( 500 )
	Until ProcessClose( $sProcess )
	ToolTip( "" )
	
	;msgbox(262144, "Reboot Required", "Test Reboot Functionality." )
	
	

;Reboot the machine, this will automatically launch section 9
PrepareReboot()
	
	
 #cs  
;SECTION 9 
	DisableAntiVirus()
		Sleep( 5000 )
		
	LaunchACTTest( 1 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
		
	AppVariable()
			
	OpenDBTest( 1 )
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
	
	UpdateDBTest( 2 ) ;Needs network connectivity test implemented
		ToolTip( "Sleeping for 10 seconds" )
		Sleep( 10000 )
  
	EnableAntiVirus() 
	
	write_header()


Msgbox(262144, "Done", "Section 9 Testing completed." )

#ce
;Close Script
Exit



Func MinimizeACT()  ;minimizes ACT!; calls LaunchIE; waits 5 minutes; call CloseIE; then maximizes ACT!
	Dim $IE_title
	$IE_title = "- Microsoft Internet Explorer"
	Dim $sTestName
	$sTestName = "Maximize ACT!"
	Dim $iTime_start
	Dim $iTime
	
	;minimize ACT if running  ;it would be best to look for the full title, but need to create gloabal variable for db name first
	Opt("WinTitleMatchMode", 1)
	If WinExists("ACT!","") Then
		WinSetState("ACT!","",@SW_MINIMIZE)
		WinWaitNotActive("ACT!",10000)
	EndIf
	
	;launch IE
	ActivateIE($IE_title)
	
	;wait five minutes
	TrayTip("Sleeping", "Sleeping for 5 minutes with Internet Explorer running in the foreground.",300000,1)
	Sleep(30000) ;this is really 5 seconds for debugging - need to change to 300000
	TrayTip("","",0,1)
	
	;close IE
	CloseIE($IE_title)
	
	;maximize ACT if running; time it too  ;it would be best to look for the full title, but need to create gloabal variable for db name first
	If WinExists("ACT!","") Then
		ToolTip( "TIMER START: " &$sTestName )
		;start the timer
        $iTime_start = TimerInit ( )
		Opt("WinTitleMatchMode", 1)
		WinSetState("ACT! by Sage","",@SW_MAXIMIZE)
		WinWaitActive("ACT!","")
		;Stop the timer, calculate elapsed time
        $iTime = TimerDiff ( $iTime_start ) / 1000
        ToolTip( "TIMER END: " &$sTestName )
        Sleep(2000)
        ToolTip( "" )
		;Write the Timer to the log
		FileWriteLine( $sResults_log, "Completed 1 iterations of the following test." )
		FileWriteLine( $sResults_log, "Iteration 1: " &$sTestName &", " &$iTime )
		FileWriteLine( $sResults_log, "" )
	EndIf
EndFunc



Func ActivateIE ($title)
	Opt("WinTitleMatchMode", 2) ;allow title matches on any substring
	If WinExists($title)= 0	Then
		;launch Internet Explorer to www.sage.com
		_RunDOS("start iexplore.exe www.sage.com")
		WinWait($title) ;wait for an IE window to exist
	EndIf
	WinActivate($title) ;activates the window
	WinSetState($title,"",@SW_MAXIMIZE)
EndFunc



Func CloseIE ($title)
	Opt("WinTitleMatchMode", 2) ;allow title matches on any substring
	If WinExists($title)= 1	Then
		;close Internet Explorer
		WinClose($title)
	EndIf
EndFunc




