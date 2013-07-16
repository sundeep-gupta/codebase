#use strict;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';

@title = ("1MB Write","100KB Write","10KB Write","1MB Read","100KB Read","10KB Read");

@sum = (0,0,0,0,0,0);

for($i=1;$i<=@ARGV[0];$i++){
	$logfilestr = $i."cifs.txt";
	open(INFILE, $logfilestr);

	$start = 1;
	
	$j = 0;
	while($line = <INFILE>) {
		chomp($line);
		if(substr($line,length($line)-1,1) =~ /\d/) {
		
			$time = substr($line,length($line) - 11, 12);
			if ($start == 0){ 
				$start = 1;
				$time_in_sec = calcTime($time) - $time_in_sec;
				@sum[$j] = @sum[$j] + $time_in_sec;
				$j = $j + 1;
			} else {
				$start = 0;
				$time_in_sec = calcTime($time);
			}
		}
	} # End of While 
} # End of For

@average = (0,0,0,0,0,0);
for ($i=0;$i<@sum;$i++) {
	@average[$i] = @sum[$i]/@ARGV[0];
}

#writeToExcel("C:\\Perl\\","Rep.xls",1,1,"Averages",1,'A',2,6,$ref1);
@throughput = (0,0,0,0,0,0);
for ($i=0;$i<@average;$i++) {
	if(($i%3) == 0) {
		@throughput[$i] = 5*1024*@ARGV[0]/@average[$i];
	}elsif(($i%3) == 1){
		@throughput[$i] = 10*100*@ARGV[0]/@average[$i];
	}else {
		@throughput[$i] = 50*10*@ARGV[0]/@average[$i];
	}
}
@tiavg = (@title,@average); 
$ref1 = \@tiavg;
@tithr = (@title,@throughput); 
$ref2 = \@tithr;

$book = open_excel();
my $sheet1 = $book->Worksheets(1);
$sheet1->{Name}="Average";

my $sheet2 = $book->Worksheets(2);
$sheet2->{Name}="Throughput";
# THIS DOESNOT WORK $sheet1->{Font}->{Size}=40;
# Change the Background color
$sheet1->Range("A1:A6")->Interior->{ColorIndex} =27;
#Alignment of range
 $sheet1->Range("A1:A6")->{HorizontalAlignment} = xlHAlignCenter;

#change the text color

#$sheet1->Range("A1:A6")->Exterior->{ColorIndex} =27;
write_excel($sheet1,1,1,2,6,$ref1);

#Apply Italic
format_excel($sheet1,1,1,1,6,"FontStyle","Italic");

#Apply FonName
format_excel($sheet1,1,1,1,6,"Name","Times New Roman");

#size of font
format_excel($sheet1,1,1,1,6,"Size","18");

#Some borders

my @edges = qw (xlEdgeBottom xlEdgeLeft xlEdgeRight xlEdgeTop xlInsideHorizontal xlInsideVertical);
     $range = "b1:c56"; 
     foreach my $edge (@edges){
     with (my $Borders = $sheet1->Range($range)->Borders(eval($edge)), 
             LineStyle =>xlContinuous,
             Weight => xlThin ,
             ColorIndex => 1);
	 }
#Find the last row and last column
my $LastRow = $sheet1->UsedRange->Find({What=>"*",
    SearchDirection=>xlPrevious,
    SearchOrder=>xlByRows})->{Row};

my $LastCol = $sheet1->UsedRange->Find({What=>"*", 
                  SearchDirection=>xlPrevious,
                  SearchOrder=>xlByColumns})->{Column};

print "Last Row is:".$LastRow." Last Column is: ".$LastCol;

#Find some value in a range
$LastRow = $sheet1->UsedRange->Find({What=>"1MB Read",
    SearchDirection=>xlPrevious,
    SearchOrder=>xlByRows})->{Row};

$LastCol = $sheet1->UsedRange->Find({What=>"1MB Read", 
                  SearchDirection=>xlPrevious,
                  SearchOrder=>xlByColumns})->{Column};

print "\n 1MB Read is at Row :".$LastRow." Column is: ".$LastCol;
print "\nMergedCells: ".$sheet1->Cells(1,1)->MergedArea." is the merged Area";
#Add a worksheet After and BEFORE

my $Sheet = $book->Worksheets->Add({After=>$book->Worksheets($book->Worksheets->{Count})}) or die Win32::OLE->LastError();

$Sheet = $book->Worksheets->Add({Before=>$book->Worksheets(1)}) or die Win32::OLE->LastError();


#Specify the column width
$sheet1->Columns("c")->{ColumnWidth}=56;

#AutoFit 
$sheet1->Columns(1)->AutoFit();


write_excel($sheet2,1,1,2,6,$ref2);
format_excel($sheet2,1,1,1,6,"FontStyle","Bold");

$book->SaveAs("C:\\Rep.xls");

#subroutine to get no of seconds from given time string
sub calcTime {
	$valHr = substr(@_[0],0,2);
	if( substr($valHr,0,1) =~ /\D/) {
		$valHr = substr($valHr,1,1);
	}
	$posMin = index(@_[0], ":") + 1;
	$valMin = substr(@_[0],$posMin,2);
	$posSec = index(@_[0],":",$posMin) + 1;
	$valSec = substr(@_[0],$posSec,2);
	$valMilli = substr(@_[0], index(@_[0],".")+1,2);
	if($valMilli > 50) {
		$valSec = ($valSec + 1);
	}
	return eval($valHr*3600+$valMin*60+$valSec);
}

sub open_excel {
		eval{
				$ex = Win32::OLE->GetActiveObject('Excel.Application')
			};
        die "Excel not installed" if $@;
        unless (defined $ex) {
        $ex = Win32::OLE->new('Excel.Application', sub {$_[0]->Quit;}) or die "Oops, cannot start Excel";
        }

	$ex->{'Visible'} = 1;
	$ex->{DisplayAlerts}=0;
	return $ex->Workbooks->Add;
}

# Writes the Througput,average time to the specified Excel sheet.
sub write_excel {
#Takes the arguments to the subroutine in to local variables
	my($Sheet,$startRow,$startCol,$noRows,$noCols,$refValues) = @_;
#put the values into the cells starting from the $startRow,$startCol

	for($i=1;$i<=$noRows;$i++) {
		for($j=1;$j<=$noCols;$j++) {
			$Sheet->Cells($i,$j)->{'Value'} = $refValues->[($i-1)*$noCols+$j-1];
		}
	}
}
#format_excel($sheet1,1,1,1,6,"FontStyle","Bold");

sub format_excel {
		my ($Sheet,$startrow,$startcol,$noRows,$noCols,$fontstyle,$fontval) = @_;
		for($i=1;$i<=$noRows;$i++) {
		for($j=1;$j<=$noCols;$j++) {
			$Sheet->Cells($i,$j)->Font->{$fontstyle} = $fontval;
		}
	}
}