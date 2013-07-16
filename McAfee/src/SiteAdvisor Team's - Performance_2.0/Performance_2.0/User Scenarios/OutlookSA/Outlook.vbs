On Error Resume Next

Dim LoopCounter
Dim i
Dim j

i=0
'Get the command line params.
For Each arg In WScript.Arguments
	
	If StrComp(arg,"/Loop",1)=0 Then
		i=i+1
		LoopCounter=WScript.Arguments(i)
	End If
	
Next


Set Outlook=CreateObject("outlook.application")

If Outlook=NULL Then
	MsgBox "Outlook is not installed or corrupt. Please Install Outlook and run the test",16,"Error"
	WScript.Quit(1)
End If 

WScript.Echo "Running test on Outlook Version: " & Outlook.Version
Set MAPI=Outlook.GetNamespace("MAPI")
Set Inbox=MAPI.GetDefaultFolder(6)
MAPI.SendAndReceive(1)



EmailCount=Inbox.Items.Count
For j=1 To LoopCounter Step 1
	For i=1 To EmailCount Step 1
		WScript.Echo Inbox.Items(i).subject
		Inbox.Items(i).Display
		WScript.sleep(10000)
		Inbox.Items(i).Close(1)
	Next
Next

'Close Outlook.
Outlook.Quit()
