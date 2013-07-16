; Author  : Sundeep Gupta & Razikh, Applabs Technologies, Hyderabad, India
; Date :    1st Feb '06
;


; Run Explorer with the specified address

AutoItSetOption ( "TrayIconDebug", 1 )

Run("C:\Program Files\Orbital Data\OrbitalEdge\uninst.exe");
Sleep(5000);
;Run("C:\Program Files\Internet Explorer\IEXPLORE.exe https://ims/intranet");
WinWait("OrbitalEdge");
Sleep(5000);
Send("Y");
Sleep(35000);
; Wait for the file download window
WinWait("OrbitalEdge", "successfully removed");
Send("{ENTER}")
