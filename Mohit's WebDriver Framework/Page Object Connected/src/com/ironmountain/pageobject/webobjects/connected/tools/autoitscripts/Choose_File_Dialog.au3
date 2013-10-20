;---------------------------------------------------------
;~ Choose_File_Dialog.au3
;~ To handle the Choose File Dialog on Windows
;~ Usage: Choose_File_Dialog.exe "file with path"
;~ Author: Pjames
;----------------------------------------------------------

AutoItSetOption("WinTitleMatchMode","2") ; set the select mode to select using substring

;MsgBox(0, "info", $CmdLine[2])
$title = WinGetTitle("Choose file") 
;$title = WinGetTitle("[active]") 
;Set path and select file
WinWaitActive($title)
$path = $CmdLine[1]
ControlSetText($title,"","Edit1",$path)
ControlClick($title,"","Button2")



