; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.0
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template AutoIt script.
;
; ----------------------------------------------------------------------------

; Script Start - Add your code below here

Run("Winword  "&$CmdLine[1]&".doc",$CmdLine[2])
;Sleep(3000)
WinWaitNotActive($CmdLine[1]+" - Microsoft Word")
Sleep(3000)
WinActivate($CmdLine[1]+" -Micosoft Word")
WinClose($CmdLine[1]&" - Microsoft Word")  