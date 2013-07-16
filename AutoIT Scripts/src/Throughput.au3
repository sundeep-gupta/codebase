#include <file.au3> 
Global $i = 1
Global $v1, $v2

Dim $filePath = "C:\Documents and Settings\050332\Desktop\192.168.1.22_CIFSOpenClose\2.2.3-7BuildTestValues\"
Dim $fileSearchHandle = FileFindFirstFile ($filePath & "C*.txt" )
Global $count = 2
Opt("TrayIconDebug",1)
OpenLayoutSheet()
do 
	$fileName = FileFindNextFile($fileSearchHandle)
;	msgbox(0,"file opened",$fileName)
	if(@error = 1) Then
		ExitLoop
	EndIf
	$fHandle = FileOpen($filePath & $fileName,0)
	Throughput()
	ToolTip("Sleeping for 2 Seconds")
	Sleep(2000)
Until (@error = 1)



;msgbox(0,"a",$Hr & " Hours " & $Min/60 &" Minutes " & $Sec & " Seconds ")
Fileclose($fHandle)
Func WriteToExcel($Total_File_Size,$Total_Time)
	Send("{Home}")
	Send("{Down}")
	Send($fileName)
	Send("{RIGHT}")
	Send($Total_File_Size)
	Send("{RIGHT}")
	Send($Total_Time)
	Send("{RIGHT}")
	if($Total_File_Size = 0) Then
		Send("0")
	Else
		
	Send($Total_File_Size/$Total_Time)
	
	EndIf
EndFunc
Func Throughput()
	$Total_Time = 0
	$Total_File_Size = 0
	$timeStart = 0
	$fileLineCount = _FileCountLines($filePath & $fileName)
	$fileLineCounter = 1
	do 
		$line = FileReadLine($FHandle)
		$fileLineCounter = $fileLineCounter + 1
		;Msgbox(0,$line,$line)
		; If line is time and start time then record the time value
		if ( StringInStr($line,"The current time is") <> 0 ) Then
			$time = CalTime($line)
			if( $timeStart == 0) Then
				$timeStart = 1
			Else
				$timeStart = 0
			EndIf
		EndIf
		;Check if this line indicates the no of files copied
		
		$fileLine = StringInStr($line, " File(s) copied")
		;Msgbox(0,$fileLine,$line&" / "& $fileLineCounter &"/ "&$fileLineCount)
		;Msgbox(0,"Error","Error Value is :"&@error)
		If( $fileLine <> 0 ) Then
			;If yes then see if count is greater than 0
			$fileCount = StringLeft($line,$fileLine - 1)
		
			if($fileCount > 0) Then
				;Read next line which contains the time and calculate the time
				$line = FileReadLine($FHandle)
				$time = CalTime($line) - $time
				$Total_Time = $time + $Total_Time
				$Total_File_Size = $Total_File_Size + fileSize(FileReadLine($FHandle)) * $fileCount
				$timeStart = 0
				$time = 0
				$fileCount = 0
				$fileLineCounter = $fileLineCounter + 2
			EndIf
		EndIf
		; If line is time and end time and size is greater than 0 then
		; Calculate the time, add time to Total_Time , add size to Total_Size and reset size to 0
		
		;$type = getLineType($line)

	 Until ($fileLineCounter > $fileLineCount)
WriteToExcel($Total_File_Size,$Total_Time)	
;MsgBox(0,"Throughput", $Total_File_Size &"KBytes / " & $Total_Time &" = "&($Total_File_Size/$Total_Time))	
EndFunc
		
		
Func CalTime($line)
	Dim $posMilli,$valMilli
	Dim $posSec, $valSec
	Dim $posMin, $valMin
	Dim $posHr, $valHr
	
	;$line = FileReadLine($FHandle,$lineNo)
	
	$posMilli = StringInStr($line,".")
	$valMilli = StringRIght($line, stringlen($line) - $posMilli )
	
	$posSec = StringInStr($line,":",0,-1)
	$valSec = StringMid($line,$posSec+1,2)
	
	$posMin = StringInStr($line,":",0,-2)
	$valMin = StringMid($line,$posMin+1,2)
	
	$posHr = StringInStr($line,":",0,-3)
	$valHr = StringMid($line,$posHr+2,2)
	;msgbox(0,"a",$line)
	
	$total = ($valHr * 3600 + ($valMin*60) + $valSec ) + ($valMilli/100)
	Return $total

EndFunc

Func fileSize ($line)
	$Tot = 0
	$incr = 1
	$pos = StringInStr($line, '"')
	while(1)
		$num = StringMid($line,$pos+$incr,1)
		if($num >= "0" and $num <= "9") Then
			$Tot = $Tot * 10 + $num
		ElseIf($num == "M" Or $num == "m") Then
			$Tot = $Tot * 1024
		Else
			ExitLoop
		EndIf
		$incr = $incr + 1
	WEnd
	Return $Tot
EndFunc


Func OpenLayoutSheet()
Dim $i = 1
	;run the excel
	;Run("C:\Program Files\Microsoft Office\Office11\Excel.exe","",@SW_MAXIMIZE)
	;WinWait("Microsoft Excel")
	Opt("WinTitleMatchMode",2)
	WinActivate("Microsoft Excel ");
	Sleep(2000);
	Send("^{HOME}")
	for $i = 1 to $count 
		send("{DOWN}")
	Next
	
	;Sleep(2000)
EndFunc
