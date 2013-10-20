use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;
use File::Path;

my $number_of_files = shift || 5;
my $inline_file = shift || "inline.txt";
my $working_folder = shift || "/tmp";
my $TYPE_OF_FILE = shift || 0;
my $size = shift || 10240000;

my (@files,$file);

if (!-d $working_folder) {
	if (!&create_directory($working_folder)) {
		exit 2;
	}
	else {
		if (!&create_directory("$working_folder$TYPE_OF_FILE")) {
			exit 2;
		}
		else {
			if (!&create_files($number_of_files,"$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)){
				exit 1;
			}
		}
	}
}
else {
	if(!-d "$working_folder$TYPE_OF_FILE") {
		if (!&create_directory("$working_folder$TYPE_OF_FILE")){
			exit 2;
		}
		else {
			if (($file = &create_files($number_of_files,"$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)) eq undef){
				exit 1;
			}
		}
	}
	else {
		#Search the matching file(s)
		if (&check_matching_file("$working_folder$TYPE_OF_FILE",$size)<$number_of_files-1) {
			if (!&create_files($number_of_files-$#files-1,"$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)){
				exit 1;
			}else {
				if (open(FH, ">$inline_file")){
					&print_message("Inline file couldn't be open for writing\n");
					exit 2;
				}else {
					print FH @files;
					close(FH);
					exit 0;
				}
			}
		}
	}
}




sub create_directory {
	my $dir_name = shift;

	&print_message("Creating directory [$dir_name]");
	if (mkdir($dir_name)) {
		&print_message("Directory created successfully");
		return 1
	}
	else {
		&print_message("Directory couldn't be created. Perl Message: $!");
		return 0;
	}
}

sub create_files {
	my $number_of_files = shift;
	my $path = shift;
	my $file_type = shift;
	my $size = shift;

	my $file_name = "File-".time;
	my ($ctr, $pid, @cpids, $loop);
	my $ppid = $$;
	&print_message("Creating files");

	for ($ctr=0;$ctr<$number_of_files;$ctr++) {
		if (!defined($pid = fork())) {
			&print_message("Can't fork!");
			exit 2;
		}elsif ($pid == 0) {
			if (!&create_file($path, $file_type, $size, "$file_name$ctr")) {
				kill 9,$ppid;
				kill 9,@cpids;
				exit 2;
			}
			exit 0;
			
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<$number_of_files;$loop++) {
		waitpid($cpids[$loop],0);
	}
}

sub create_file{
	my $path = shift;
	my $file_type = shift;
	my $size = shift;
	my $file_name = shift;

	&print_message("Creating file $file_name");
	if (open(FH, ">$path/$file_name")){
		if ($file_type == 0) {
			while ($size>=1048576) {
				print FH ("0" x 1048576);
				$size = $size - 1048576;
			}
			print FH "0" x $size;
		}
		elsif ($file_type == 1)  {
			print "Yet to be done\n";
			#return undef;
		}
		elsif ($file_type == 2)  {
			while ($size>=1048576) {
				print FH map (pack( "c",rand(255 )) ,  1..(1024*1024));
				$size = $size - 1048576;
			}
			print FH map (pack( "c",rand(255 )) ,  1..($size));
		}
		close(FH);
		&print_message("File [$file_name] created successfully");
		push(@files,"$path/$file_name");
		return 1;
	}
	else{
		&print_message("File couldn't be created. Perl Message: $!");
		return 0;
	}
}


sub check_matching_file {
	$path = shift;
	$size = shift;
	
	&print_message("Searching matching file");
	opendir(DIR, $path);
	while((defined ($file = readdir DIR)) && $#files<=$number_of_files){
		if (-s "$path/$file" == $size) {
			&print_message("Matching file found. File name: [$file]");
			push(@files,"$path/$file_name");
		}
	}
	if ($#files>=0) {
		return $#files;
	}else {
		&print_message("Couldn't find any matching file");
		return -1;
	}
}


#Today's Date
sub today
{
	my $date=strftime("%B %d, %Y", localtime(time()));
	return $date;
}

#Current Time
sub now
{
	my $time=strftime("%H:%M:%S", localtime(time()));
	return $time;
}

#Printing formatted output
sub print_message{
	my $msg = shift;

	print today()."-".now().": ".$msg."\n";
}