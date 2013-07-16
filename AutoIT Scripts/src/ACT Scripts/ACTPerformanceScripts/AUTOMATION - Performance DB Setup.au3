;ScriptFunction: 
;----------------------------------------------------------------------------
;AutoIt Version: 3.1
;Language:       English
;Platform:       Win9x / NT / XP
;Author:         Justin Taylor
;---------------------------------------------------------------------------


#include "Func-Jets.au3"
#include "Func-AutomatedPerformance.au3"

;---------------------------------------------------------------------------
;Set up defaults
;---------------------------------------------------------------------------
Opt( "MouseCoordMode", 0 )
Opt( "SendKeyDelay", 1 )
Opt( "TrayIconDebug", 1 )


;Press Esc to terminate script
HotKeySet( "{ESC}", "Terminate" )
HotKeySet( "{PAUSE}", "TogglePause" )

;Allow only one instance of script
onescript( )

;---------------------------------------------------------------------------
;Script Start                               -Pressing ESC will cancel script
;---------------------------------------------------------------------------
PerfTestSetup()

performance_db_setup()

;Close Script
Exit
