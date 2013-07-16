use strict;
use Getopt::Long;
use Spreadsheet::WriteExcel;
use FindBin qw($Bin);
use lib "$Bin/../Lib";
use Config::INI::Simple;
use File::Path;



my $ReportFile;
my $workbook;
my $worksheet;
my $ReportINI=Config::INI::Simple->new();
my $ExcelRow=0;
my $ExcelCol=0;
my @Iterations;
my $format ;
my $SubKeys;
my @FilteredCategories;
my @ReportCategories;
my $TotalIterations=0;
my $HeaderFormat;
my @URL;
my $DataFormat;

mkpath "$Bin/../Reports";

$ReportFile="$Bin/../Reports/Performance Report.xls";
$workbook=Spreadsheet::WriteExcel->new($ReportFile);

#  Add and define a format
$format = $workbook->add_format();
$format->set_bold();
$format->set_color('black');
$format->set_bg_color('yellow');
$format->set_align('center');
$format->set_border();

$HeaderFormat=$workbook->add_format();
$HeaderFormat->set_bold();
$HeaderFormat->set_color('black');
$HeaderFormat->set_bg_color('Green');
$HeaderFormat->set_align('center');
$HeaderFormat->set_border();

$DataFormat=$workbook->add_format();
$DataFormat->set_color('black');
$DataFormat->set_align('center');
$DataFormat->set_border();


if(-f  "$Bin/../User Scenarios/Logs/Report.Ini"){

    print "Creating User Scenarios Report...\n";
    $worksheet=$workbook->add_worksheet("User Scenarios Report");
    $ReportINI->read("$Bin/../User Scenarios/Logs/Report.Ini");
    @Iterations=keys %$ReportINI;
    foreach(@Iterations){

        #Leave out the default keys eol,default,file and append
        unless(/(eol|default|append|file)/){

            $TotalIterations++;
        }
    }
    Report();
}


if(-f  "$Bin/../Product Scenarios/Logs/Report.Ini"){

    print "Creating Product Scenarios Report...\n";
    $worksheet=$workbook->add_worksheet("Product Scenarios Report");
    undef $ReportINI;
    $ReportINI=new Config::INI::Simple;
    $ReportINI->read("$Bin/../Product Scenarios/Logs/Report.Ini");
    @Iterations=keys %$ReportINI;
    foreach(@Iterations){

        #Leave out the default keys eol,default,file and append
        unless(/(eol|default|append|file)/){

            $TotalIterations++;
        }
    }
    Report();
}

print "The Report is at $ReportFile\n";

sub Report{

    my $Iteration=$ReportINI->{Iteration_1};
    my @CategoriesAll;
    my $Category;
    my $Data;

    #Get all the categories
    @CategoriesAll=sort keys %$Iteration;

    foreach(@CategoriesAll){

        if(/_TimeTaken/gi){

            #push the ones that have the timtaken keyword to another filtered array.
            push @FilteredCategories,$_;
            ($Category)=$_=~m/(.*?)_/;
            ($Data)=$_=~m/_(.*?)_/;
            push @ReportCategories,$Category;
            push @URL,$Data;

        }
    }
    $worksheet->set_column('A:B',30);
    $worksheet->set_column('C:Z',15);
    $worksheet->write($ExcelRow,$ExcelCol,"Test",$HeaderFormat);
    $ExcelRow++;
    $worksheet->write_col($ExcelRow,$ExcelCol,\@ReportCategories,$format);

    $ExcelCol++;
    $ExcelRow--;

    $worksheet->write($ExcelRow,$ExcelCol,"Data/URL",$HeaderFormat);
    $ExcelRow++;
    $worksheet->write_col($ExcelRow,$ExcelCol,\@URL,$format);


    $ExcelCol++;
    $ExcelRow--;

    for(my $i=1; $i<=$TotalIterations; $i++){

        $worksheet->write($ExcelRow,$ExcelCol,"Iteration $i",$HeaderFormat);
        $ExcelRow++;

        foreach(@FilteredCategories){

            $worksheet->write($ExcelRow,$ExcelCol,$ReportINI->{"Iteration_".$i}->{$_},$DataFormat);
            $ExcelRow++;
        }
        $ExcelRow=$ExcelRow-1-scalar @FilteredCategories;
        $ExcelCol++;
    }

    undef @FilteredCategories;
    undef @URL;
    undef @ReportCategories;
    $TotalIterations=0;
    $ExcelCol=0;
    $ExcelRow=0;
    undef @Iterations;
}