Option Explicit
Dim fEnableDelays
fEnableDelays = False
Dim strValue
'strValue=0
Dim g_arrData(),g_i

Sub SendRequest1()
    Dim oConnection, oRequest, oResponse, oHeaders, strStatusCode
	
    If fEnableDelays = True then Test.Sleep (0)
    Set oConnection = Test.CreateConnection("www.google.com", 80, false)
    If (oConnection is Nothing) Then
        Test.Trace "Error: Unable to create connection to www.google.com"
    Else
        Set oRequest = Test.CreateRequest
        oRequest.Path = "/"
        oRequest.Verb = "GET"
        oRequest.HTTPVersion = "HTTP/1.0"
        set oHeaders = oRequest.Headers
        oHeaders.RemoveAll
        oHeaders.Add "Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*"
        oHeaders.Add "Accept-Language", "en-us"
        'oHeaders.Add "Cookie", "PREF=ID=b7526269aabdaaa8:TB=2:TM=1135163956:LM=1135163956:S=PyosihWEJb3lggCz"
        oHeaders.Add "Cookie", "(automatic)"
        oHeaders.Add "User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)"
        'oHeaders.Add "Host", "www.google.com"
        oHeaders.Add "Host", "(automatic)"
        oHeaders.Add "Cookie", "(automatic)"
        Set oResponse = oConnection.Send(oRequest)
        If (oResponse is Nothing) Then
            Test.Trace "Error: Failed to receive response for URL to " + "/"
        Else
            strStatusCode = oResponse.ResultCode
        End If
        oConnection.Close
    End If 
End Sub

Sub SendRequest2()
    Dim oConnection, oRequest, oResponse, oHeaders, strStatusCode
    If fEnableDelays = True then Test.Sleep (1126)
    Set oConnection = Test.CreateConnection("www.google.co.in", 80, false)
    If (oConnection is Nothing) Then
        Test.Trace "Error: Unable to create connection to www.google.co.in"
    Else
        Set oRequest = Test.CreateRequest
        oRequest.Path = "/"
        oRequest.Verb = "GET"
        oRequest.HTTPVersion = "HTTP/1.0"
        set oHeaders = oRequest.Headers
        oHeaders.RemoveAll
        oHeaders.Add "Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*"
        oHeaders.Add "Accept-Language", "en-us"
        'oHeaders.Add "Cookie", "PREF=ID=bc83ed1336f346bc:TM=1136782058:LM=1136782058:S=7EiVq0AZeYIEzSbR"
        oHeaders.Add "Cookie", "(automatic)"
        oHeaders.Add "User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)"
        'oHeaders.Add "Host", "www.google.co.in"
        oHeaders.Add "Host", "(automatic)"
        oHeaders.Add "Cookie", "(automatic)"
        Set oResponse = oConnection.Send(oRequest)
        If (oResponse is Nothing) Then
            Test.Trace "Error: Failed to receive response for URL to " + "/"
        Else
            strStatusCode = oResponse.ResultCode
        End If
        oConnection.Close
    End If
End Sub

Sub SendRequest3(strSearch)
    Dim oConnection, oRequest, oResponse, oHeaders, strStatusCode

    If fEnableDelays = True then Test.Sleep (14750)
    Set oConnection = Test.CreateConnection("www.google.co.in", 80, false)
    If (oConnection is Nothing) Then
        Test.Trace "Error: Unable to create connection to www.google.co.in"
    Else
        Set oRequest = Test.CreateRequest
        oRequest.Path = "/search"+"?hl=en&q=" & strSearch &"btnG=Google+Search&meta="
        oRequest.Verb = "GET"
        oRequest.HTTPVersion = "HTTP/1.0"
        set oHeaders = oRequest.Headers
        oHeaders.RemoveAll
        oHeaders.Add "Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*"
        oHeaders.Add "Referer", "http://www.google.co.in/"
        oHeaders.Add "Accept-Language", "en-us"
        oHeaders.Add "User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)"
        'oHeaders.Add "Host", "www.google.co.in"
        oHeaders.Add "Host", "(automatic)"
        'oHeaders.Add "Cookie", "PREF=ID=bc83ed1336f346bc:TM=1136782058:LM=1136782058:S=7EiVq0AZeYIEzSbR"
        oHeaders.Add "Cookie", "(automatic)"
		Test.Trace oRequest.Path
                Set oResponse = oConnection.Send(oRequest)
        If (oResponse is Nothing) Then
            Test.Trace "Error: Failed to receive response for URL to " + "/search"
        Else
            strStatusCode = oResponse.ResultCode
        End If
        oConnection.Close
    End If
End Sub

Function GetDataFromFile ()
   ' declare local variables
    Dim oFileSys
   Dim oDataFile
   Dim strLine
   Dim lCount


   
   ' initialize variables
  strLine = ""
   lCount = 0
   
'strValue=strValue+1
' Test.Trace("Successfully sent: " + lSent + " requests from XML data\n");
'Test.Trace("strValue: " + strValue + "Row Data")
'Test.Trace(strValue)
   ' create an FSO
   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   ' open file for reading
   Set oDataFile = oFileSys.OpenTextFile("C:\ACT\abc.txt", 1)

   Do While (oDataFile.AtEndOfStream <> True)   
       ' read one line at a time
      strLine = oDataFile.ReadLine
      ' assign value from each line to an array element
      ' and check for empty lines
     
      If (strLine <> "") Then
		Redim preserve g_arrData(lCount)     

         g_arrData(lCount) = strLine
         lCount = lCount + 1
         
   '    Test.Trace arrData(1)
       'Test.GetNextUser()
      Else
         Test.Trace("E: Found empty line in data file" & vbCrLf)
      End If
   Loop

   Call oDataFile.Close()
   ' return the number of lines read


End Function



Function Main()


    call SendRequest1()
    call SendRequest2()
	Test.trace "The value is" +Cstr( g_i) + g_arrData(g_i)
    call SendRequest3(g_arrData(g_i))
	

End Function


GetDataFromFile()
for  g_i=0 to UBound(g_arrData) 

 Main()

next
