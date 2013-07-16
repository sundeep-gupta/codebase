;ScriptFunction: Automatically run performance tests on new builds
;----------------------------------------------------------------------------
;AutoIt Version: 3.1
;Language:       English
;Platform:       Win9x / NT / XP
;Author:         Justin Taylor
;---------------------------------------------------------------------------

#include <file.au3>
#include "Func-Jets.au3"
#include "Func-AutomatedPerformance.au3"
#include <GuiConstants.au3>

;---------------------------------------------------------------------------
;Set up defaults
;---------------------------------------------------------------------------
Opt( "MouseCoordMode", 0 )
Opt( "SendKeyDelay", 1 )
Opt( "TrayiconDebug", 1 )
Opt( "RunErrorsFatal", 0 )

;Press Esc to terminate script
;~ HotKeySet( "{ESC}", "Terminate" )
HotKeySet( "{PAUSE}", "TogglePause" )

If ProcessExists( "Act8.exe" ) Then 
	MsgBox(262144,"Close ACT!","Make sure ACT! is closed, and the procees does not exist, then click OK to continue." )
EndIf

;Allow only one instance of script
onescript( )

#region ---Variables---
;~ Dim $snetwork_path  = "\\azsbuilds2\Builds\AZSBUILDS1_Data\ACT!_Devo\AutoBld"
;~ Dim $sBuildServer = "\\azsbuilds2\Builds"
Dim $sfull_path, $icurrent_build, $inew_build, $icnt, $iline, $sbuild_log_handle
Dim $ainstall_options[5]
#endregion ---Variables---

;---------------------------------------------------------------------------
;Script Start                               -Pressing ESC will cancel script
;---------------------------------------------------------------------------

;Delete Registry Entries
RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentResultsLog", "REG_SZ", "" ) 
RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentStatusLog", "REG_SZ", "" )
RegWrite( "HKEY_LOCAL_MACHINE\SOFTWARE\Sage\Automation", "CurrentLogFile", "REG_SZ", "" )

PerfTestSetup() ;Do not comment out

;~ ;Verify connection to \\azsbuilds2
;~ If FileExists( $snetwork_path ) Then 
; Msgbox(262144, "Notice", "Connection Exists" )
;~ Else
; Msgbox(262144, "Notice", "No Connection" )
;~     RunWait( @ComSpec &" /c " &"net use " &$snetwork_path &" /user:testlogix\testadmin 2l84luv", "", @SW_HIDE )
;~ EndIf



;Setup the ACT1k DB
performance_db_setup()

Sleep( 15000 )

;Close ACT
WinClose( "ACT!", "" )

Sleep(30000)
;WinWaitClose( "ACT!", "" )

#endregion ---Setup ACT1K DB---


#region ---Prepare to reboot and start tests---

;Reboot & Start tests
start_all_performance_tests()

#endregion ---Prepare to reboot and start tests---


;Close Script
Exit
