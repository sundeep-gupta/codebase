package WANScaler::FTPLibrary;
use strict;
use warnings;
use Exporter;
use Win32::NetResource qw(:DEFAULT GetSharedResources GetError);
use Net::FTP;
use Time::HiRes qw(gettimeofday);

our @ISA = ('Exporter');
our @EXPORT = qw( share_directory unshare_directory
			  map_drive unmap_drive
			  get_unc $err_msg $err_code
			  copy_file copy_directory browse_directory delete_file);
use constant NW_CONN_NOT_EXIST => 2250;
use constant TIMEOUT 		   => 100;

our $err_code = undef;
our $err_msg = undef;

sub new {
	my $self = shift;
    my $host = shift;
    my $ftp = Net::FTP->new($host);
    my $this = {'FTP'=>$ftp};
    bless $this,$self;
    return $this;
}
sub login {
	my ($self,$username,$password) = @_;
    return $self->{'FTP'}->login($username,$password);
}
sub chdir {
	my ($self,$dir) = @_;
    return $self->{'FTP'}->cwd($dir);
}

sub get {
	my ($self,$file_name,$dest) = @_;
	my $ftp = $self->{'FTP'};
	my $size = $ftp->size($file_name);
	my @timer1 = gettimeofday();
    my $result;
	if ($dest) {
		$result = $ftp->get($file_name,$dest);
    } else {
		$result = $ftp->get($file_name);
    }
	my $return = {};
    if ($result) {
	    my @timer2 = gettimeofday();
	    my $timer = $timer2[0]-$timer1[0]+($timer2[1]-$timer1[1])/1000000;
	    $return = {'RESULT'=>'PASS',
	                  'TIME' => $timer,
	                  'SIZE' => $size
	                  };
	} else {
        $return = {'RESULT'=>'FAIL',
                    'REASON' => 'Get Failed'
                  };
    }
    return $return
}

sub put {
	my ($self,$file_name,$dest) = @_;
	my $ftp = $self->{'FTP'};
	my $size = $ftp->size($file_name);
	my @timer1 = gettimeofday();
    my $result = $ftp->put($file_name);
	my $return = {};
    if ($result) {
	    my @timer2 = gettimeofday();
	    my $timer = $timer2[0]-$timer1[0]+($timer2[1]-$timer1[1])/1000000;
	    $return = {'RESULT'=>'PASS',
	                  'TIME' => $timer,
	                  'SIZE' => $size
	                  };
	} else {
        $return = {'RESULT'=>'FAIL',
                    'REASON' => 'Get Failed'
                  };
    }
    return $return
}
sub close {
	my $self = shift;
    $self->{'FTP'}->close();
}
sub ls {
    my $self = shift;
  	my @timer1 = gettimeofday();
	my $result = $self->{'FTP'}->ls();
    my $return = {};
    if ($result) {
	    my @timer2 = gettimeofday();
	    my $timer = $timer2[0]-$timer1[0]+($timer2[1]-$timer1[1])/1000000;
	    $return = {'RESULT'=>'PASS',
	                  'TIME' => $timer,
	                  };
	} else {
        $return = {'RESULT'=>'FAIL',
                    'REASON' => 'Browsing Failed'
                  };
    }
    return $return

}
1;