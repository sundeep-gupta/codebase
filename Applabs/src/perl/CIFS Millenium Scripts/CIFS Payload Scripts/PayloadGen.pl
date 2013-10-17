use WANScaler::CIFSLibrary;
use Cwd;
my $start_dir   = 10;
my $end_dir     = 25;
my $large_dir   = 'LargeFile45';
my $l_dir2      = 'LargeFile1.5';
my $small_dir   = 'SmallFiles';
my $browse_dir  = 'Browse';
my $l_size      = 1024*1024*10;
my $l_size2     = 1024*1024;
my $s_size      = 512000;
my $b_file_name = 'File';
my $s_file_name = 'SmallFile';
my $l_file_name = 'LargeFile';
my $s_no        = 100;
my $b_no        = 5000;
my $dir_name    = "CIFS_Share";
$pwd            = cwd;

for($i= $start_dir;$i<$end_dir;$i++) {

	chdir($pwd);
	print cwd."\n";
	mkdir($dir_name.$i);
    next;

    mkdir(".\\".$dir_name.$i."\\".$large_dir);
    chdir(".\\".$dir_name.$i."\\".$large_dir);
    `perl ..\\..\\FileGen.pl -r -s $l_size -f $l_file_name`;
    `move ${l_file_name}1.dat $l_file_name.dat`;
    mkdir($pwd."\\".$dir_name.$i."\\".$l_dir2);

	chdir(".\\".$dir_name.$i."\\".$l_dir2);
	chdir($pwd."\\".$dir_name.$i."\\".$l_dir2);
    `perl ..\\..\\FileGen.pl -r -s $l_size2 -f $l_file_name`;
    `move ${l_file_name}1.dat $l_file_name.dat`;


    mkdir("..\\..\\".$dir_name.$i."\\".$browse_dir);
    chdir("..\\..\\".$dir_name.$i."\\".$browse_dir);
    `perl ..\\..\\FileGen.pl -s 1 -f $b_file_name -n $b_no`;

    mkdir("..\\..\\".$dir_name.$i."\\".$small_dir);
    chdir("..\\..\\".$dir_name.$i."\\".$small_dir);

    `perl ..\\..\\RFileGen.pl -s $s_size -f $s_file_name -n $s_no -r`;

    chdir($pwd);
}