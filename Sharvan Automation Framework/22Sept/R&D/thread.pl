
use Net::FTP;
use library;

$CONNECTIONS = 5;


&library::config_orbitals();

my ($ctr, $pid, @cpids, $loop);
my $ppid = $$;
for ($ctr=1;$ctr<=$CONNECTIONS;$ctr++) {
	if (!defined($pid = fork())) {
		print("Can't fork!");
		exit 2;
	}elsif ($pid == 0) {
		if (!&ftp_put("10.1.1.3", "Administrator", "ARS\!jr", "/tmp/testfile","testfile$ctr")){
			kill 9, $ppid;
			kill 9, @cpids;
			exit 2;
		}
		exit 0;
	}else {
		$cpids[$ctr] = $pid;
	}
}

for ($loop=1;$loop<=$CONNECTIONS;$loop++) {
	waitpid($cpids[$loop],0);
}
#Delete file from destination
system("del /q k:\\*.*");


for ($ctr=1;$ctr<=$CONNECTIONS;$ctr++) {
	if (!defined($pid = fork())) {
		print("Can't fork!");
		exit 2;
	}elsif ($pid == 0) {
		if (!&ftp_put("10.1.1.3", "Administrator", "ARS\!jr", "/tmp/testfile","testfile$ctr")){
			kill 9, $ppid;
			kill 9, @cpids;
			exit 2;
		}
		exit 0;
	}else {
		$cpids[$ctr] = $pid;
	}
}

for ($loop=1;$loop<=$CONNECTIONS;$loop++) {
	waitpid($cpids[$loop],0);
}
#Delete file from destination
system("del /q k:\\*.*");



sub ftp_put {
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $file = shift;
	my $remote_file = shift || $file;

	if (not defined($ftp = Net::FTP->new($url))) {
		print("Couldn't connect $url");
		return 0;
	}
	if (!$ftp->login($uid, $pwd)) {
		print("Couldn't authenticated");
		return 0;
	}
	print("Putting file [$remote_file] on FTP Server\n");
	if ($ftp->put($file, $remote_file)) {
		print("Put [$remote_file] successfully\n");
		$ftp->quit;
		return 1;
	}else {
		print("Couldn't put [$remote_file]");
		$ftp->quit;
		return 0;
	}
}


