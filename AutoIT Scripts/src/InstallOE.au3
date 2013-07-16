; Author  : Sundeep Gupta & Razikh, Applabs Technologies, Hyderabad, India
; Date :    1st Feb '06
;
; Run Explorer with the specified address
;Run("iexplore.exe  https://10.0.1.135:8080/downloads/OrbitalEdge-Windows-0.8.11.51.12574-2006-01-27.exe","C:\Program Files\Internet Explorer\");
AutoItSetOption ( "TrayIconDebug", 1 )

Run("C:\Program Files\Internet Explorer\IEXPLORE.exe https://10.0.1.135:8080/downloads/OrbitalEdge-Windows-0.8.11.51.12574-2006-01-27.exe");
;Run("C:\Program Files\Internet Explorer\IEXPLORE.exe https://ims/intranet");
WinWait("Security Alert");
Send("Y");
; Wait for the file download window
WinWait("File Download", "Would you like to");
Send("{ENTER}")
;Wait for Orbital Edge Instller Window
Sleep(9000);
WinWait("OrbitalEdge")
Send("{ENTER}")
Sleep(2000);
Send("{ENTER}")
Sleep(2000);
Send("{ENTER}")
Sleep(2000);
Send("10.0.1.135");
Send("{ENTER}")
Sleep(2000);
WinWait("Hardware Installation");
Send("C");
WinWait("OrbitalEdge","Finish");
Send("{ENTER}");

