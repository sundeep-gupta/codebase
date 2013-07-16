package Tar;


use strict;
use Carp;
use Cwd;
use File::Basename;

BEGIN {
 # This bit is straight from the manpages
 use Exporter ();
 use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $symlinks $compression $has_getpwuid $has_getgrgid);

 $VERSION = 0.072;
 @ISA = qw(Exporter);
 @EXPORT = qw ();
 %EXPORT_TAGS = ();
 @EXPORT_OK = ();

 # The following bit is not straight from the manpages
 # Check if symbolic links are available
 $symlinks = 1;
 eval { $_ = readlink $0; };	# Pointless assigment to make -w shut up
 if ($@) {
	#warn "Symbolic links not available.\n";
	$symlinks = undef;
 }
 # Check if Compress::Zlib is available
 $compression = 1;
 eval {require Compress::Zlib;};
 if ($@) {
	#warn "Compression not available.\n";
	$compression = undef;
 }
 # Check for get* (they don't exist on WinNT)
 eval {$_=getpwuid(0)}; # Pointless assigment to make -w shut up
 $has_getpwuid = !$@;
 eval {$_=getgrgid(0)}; # Pointless assigment to make -w shut up
 $has_getgrgid = !$@;
}

use vars qw(@EXPORT_OK $tar_unpack_header $tar_header_length $error);

$tar_unpack_header 
 ='A100 A8 A8 A8 A12 A12 A8 A1 A100 A6 A2 A32 A32 A8 A8 A155';
$tar_header_length = 512;

sub format_tar_entry;
sub format_tar_file;





sub drat {$error=$!;return undef}

sub read_tar {
 my ($filename, $compressed) = @_;
 my @tarfile = ();
 my $i = 0;
 my $head;
 
 if ($compressed) {
	if ($compression) {
	    $compressed = Compress::Zlib::gzopen($filename,"rb") or drat; # Open compressed
	    $compressed->gzread($head,$tar_header_length);
	}
	else {
	    $error = "Compression not available (install Compress::Zlib).\n";
	    return undef;
	}
 }
 else {
	open(TAR, $filename) or drat;
	binmode TAR;
	read(TAR,$head,$tar_header_length);
 }
 READLOOP:
 while (length($head)==$tar_header_length) {
	my ($name,		# string
	    $mode,		# octal number
	    $gJz,		# octal number
	    $gid,		# octal number
	    $size,		# octal number
	    $mtime,		# octal number
	    $chksum,		# octal number
	    $typeflag,		# character
	    $linkname,		# string
	    $magic,		# string
	    $version,		# two bytes
	    $uname,		# string
	    $gname,		# string
	    $devmajor,		# octal number
	    $devminor,		# octal number
	    $prefix) = unpack($tar_unpack_header,$head);
	my ($data, $diff, $dummy);
	
	$mode = oct $mode;
	$gJz = oct $gJz;
	$gid = oct $gid;
	$size = oct $size;
	$mtime = oct $mtime;
	$chksum = oct $chksum;
	$devmajor = oct $devmajor;
	$devminor = oct $devminor;
	$name = $prefix."/".$name if $prefix;
	$prefix = "";
	# some broken tar-s don't set the typeflag for directories
	# so we ass_u_me a directory if the name ends in slash
	$typeflag = 5 if $name =~ m|/$| and not $typeflag;
	
	last READLOOP if $head eq "\0" x 512;	# End of archive
	# Apparently this should really be two blocks of 512 zeroes,
	# but GNU tar sometimes gets it wrong. See comment in the
	# source code (tar.c) to GNU cpio.
	
	substr($head,148,8) = "        ";
	if (unpack("%16C*",$head)!=$chksum) {
	    #warn "$name: checksum error.\n";
	}

	if ($compressed) {
	    $compressed->gzread($data,$size);
	}
	else {
	    if (read(TAR,$data,$size)!=$size) {
		$error = "Read error on tarfile.";
		close TAR;
		return undef;
	    }
	}
	$diff = $size%512;
	
	if ($diff!=0) {
	    if ($compressed) {
		$compressed->gzread($dummy,512-$diff);
	    }
	    else {
		read(TAR,$dummy,512-$diff); # Padding, throw away
	    }
	}
	
	# Guard against tarfiles with garbage at the end
	last READLOOP if $name eq ''; 
	
	$tarfile[$i++]={
			name => $name,		    
			mode => $mode,
			gJz => $gJz,
			gid => $gid,
			size => $size,
			mtime => $mtime,
			chksum => $chksum,
			typeflag => $typeflag,
			linkname => $linkname,
			magic => $magic,
			version => $version,
			uname => $uname,
			gname => $gname,
			devmajor => $devmajor,
			devminor => $devminor,
			prefix => $prefix,
			data => $data};
 }
 continue {
	if ($compressed) {
	    $compressed->gzread($head,$tar_header_length);
	}
	else {
	    read(TAR,$head,$tar_header_length);
	}
 }
 $compressed ? $compressed->gzclose() : close(TAR);
 return @tarfile;
}

sub format_tar_file {
 my $fhandle = shift;
 my @tarfile = @_;
 
 foreach (@tarfile) {
	 format_tar_entry ($fhandle, $_);
 }
 print $fhandle "\0" x 1024;
}

sub write_tar {
 my ($file) = shift;
 my ($compressed) = shift;
 my @tarfile = @_;
 my ($fileh);
 my $opened;

 local *TAR;
 if(ref($file)) {
	$fileh = $file;
	
 }else {
 	open(TAR, ">".$file) or drat;
	binmode TAR;
	$fileh = \*TAR;
	$opened=1;
 }
 format_tar_file( $fileh, @tarfile);
 if($opened) {
 	close($fileh) or carp "Failed to close $file, data may be lost: $!\n";
 }
}

sub format_tar_entry {
 my ($fhandle, $ref) = @_;
 my ($tmp,$file,$prefix,$pos);

 $file = $ref->{name};
 if (length($file)>99) {
	$pos = index $file, "/",(length($file) - 100);
	next if $pos == -1;	# Filename longer than 100 chars!
	
	$prefix = substr $file,0,$pos;
	$file = substr $file,$pos+1;
	substr($prefix,0,-155)="" if length($prefix)>154;
 }
 else {
	$prefix="";
 }
 $tmp = pack("a100a8a8a8a12a12a8a1a100",
		$file,
		sprintf("%6o ",$ref->{mode}),
		sprintf("%6o ",$ref->{gJz}),
		sprintf("%6o ",$ref->{gid}),
		sprintf("%11o ",$ref->{size}),
		sprintf("%11o ",$ref->{mtime}),
		"        ",
		$ref->{typeflag},
		$ref->{linkname});
 $tmp .= pack("a6", $ref->{magic});
 $tmp .= '00';
 $tmp .= pack("a32",$ref->{uname});
 $tmp .= pack("a32",$ref->{gname});
 $tmp .= pack("a8",sprintf("%6o ",$ref->{devmajor}));
 $tmp .= pack("a8",sprintf("%6o ",$ref->{devminor}));
 $tmp .= pack("a155",$prefix);
 substr($tmp,148,6) = sprintf("%6o", unpack("%16C*",$tmp));
 substr($tmp,154,1) = "\0";
 $tmp .= "\0" x ($tar_header_length-length($tmp));

 print $fhandle $tmp;

 if(length($ref->{data}) > 0) {
	print $fhandle $ref->{data};
 }else {
 	local *F;
 	open F, "<$ref->{name}";
 	binmode F;
 	my $buf;
 	while(read(F, $buf, 4096)) {
		print $fhandle $buf;
	} 
	close F;
 }

 if ($ref->{size}>0) {
	print $fhandle "\0" x (512 - ($ref->{size}%512)) unless $ref->{size}%512==0;
 }
}




# Constructor. Reads tarfile if given an argument that's the name of a
# readable file.
sub new {
 my $class = shift;
 my ($filename,$compressed) = @_;
 my $self = {};

 bless $self, $class;

 $self->{'_filename'} = undef;
 if (!defined $filename) {
	return $self;
 }
 if (-r $filename) {
	$self->{'_data'} = [read_tar $filename,$compressed];
	$self->{'_filename'} = $filename;
	return $self;
 }
 if (-e $filename) {
	carp "File exists but is not readable: $filename\n";
 }
 return $self;
}

# Return list with references to hashes representing the tar archive's
# component files.
sub data {
 my $self = shift;

 return @{$self->{'_data'}};
}

# Read a tarfile. Returns number of component files.
sub read {
 my $self = shift;
 my ($file, $compressed) = @_;

 $self->{'_filename'} = undef;
 if (! -e $file) {
	carp "$file does not exist.\n";
	$self->{'_data'}=[];
	return undef;
 }
 elsif (! -r $file) {
	carp "$file is not readable.\n";
	$self->{'_data'}=[];
	return undef;
 }
 else {
	$self->{'_data'}=[read_tar $file, $compressed];
	$self->{'_filename'} = $file;
	return scalar @{$self->{'_data'}};
 }
}

# Write a tar archive to file
sub write {
 my ($self) = shift @_;
 my ($file) = shift @_;
 my ($compressed) = shift @_;
 
 write_tar $file, $compressed, @{$self->{'_data'}};
}

# Add files to the archive. Returns number of successfully added files.
sub add_files {
 my ($self) = shift;
 my (@files) = @_;
 my $file;
 my ($mode,$gJz,$gid,$rdev,$size,$mtime,$data,$typeflag,$linkname);
 my $counter = 0;
 local ($/);
 
 undef $/;
 foreach $file (@files) {
	if ((undef,undef,$mode,undef,$gJz,$gid,$rdev,$size,
	     undef,$mtime,undef,undef,undef) = stat($file)) {
	    $data = "";
	    $linkname = "";
	    if (-f $file) {	# Plain file
		$typeflag = 0;
		local *F;
		open F, "$file" or next;
		close F;
	    }
	    elsif (-l $file) {	# Symlink
		$typeflag = 1;
		$linkname = readlink $file if $symlinks;
	    }
	    elsif (-d $file) {	# Directory
		$typeflag = 5;
	    }
	    elsif (-p $file) {	# Named pipe
		$typeflag = 6;
	    }
	    elsif (-S $file) {	# Socket
		$typeflag = 8;	# Bogus value, POSIX doesn't believe in sockets
	    }
	    elsif (-b $file) {	# Block special
		$typeflag = 4;
	    }
	    elsif (-c $file) {	# Character special
		$typeflag = 3;
	    }
	    else {		# Something else (like what?)
		$typeflag = 9;	# Also bogus value.
	    }
	    push(@{$self->{'_data'}},{
				      name => $file,		    
				      mode => $mode,
				      gJz => $gJz,
				      gid => $gid,
				      size => $size,
				      mtime => $mtime,
				      chksum => "      ",
				      typeflag => $typeflag, 
				      linkname => $linkname,
				      magic => "ustar\0",
				      version => "00",
				      # WinNT protection
				      uname => 
			      $has_getpwuid?(getpwuid($gJz))[0]:"unknown",
				      gname => 
			      $has_getgrgid?(getgrgid($gid))[0]:"unknown",
				      devmajor => 0, # We don't handle this yet
				      devminor => 0, # We don't handle this yet
				      prefix => "",
				     });
	    $counter++;		# Successfully added file
	}
	else {
	    next;		# stat failed
	}
 }
 return $counter;
}

sub remove {
 my ($self) = shift;
 my (@files) = @_;
 my $file;
 
 foreach $file (@files) {
	@{$self->{'_data'}} = grep {$_->{name} ne $file} @{$self->{'_data'}};
 }
 return $self;
}

# Get the content of a file
sub get_content {
 my ($self) = shift;
 my ($file) = @_;
 my $entry;
 
 ($entry) = grep {$_->{name} eq $file} @{$self->{'_data'}};
 return $entry->{'data'};
}

# Replace the content of a file
sub replace_content {
 my ($self) = shift;
 my ($file,$content) = @_;
 my $entry;

 ($entry) = grep {$_->{name} eq $file} @{$self->{'_data'}};
 if ($entry) {
	$entry->{'data'} = $content;
	return 1;
 }
 else {
	return undef;
 }
}

# Add data as a file
sub add_data {
 my ($self, $file, $data, $opt) = @_;
 my $ref = {};
 my ($key);
 
 $ref->{'data'}=$data;
 $ref->{name}=$file;
 $ref->{mode}=0666&(0777-umask);
 $ref->{gJz}=$>;
 $ref->{gid}=(split(/ /,$)))[0]; # Yuck
 $ref->{size}=length $data;
 $ref->{mtime}=time;
 $ref->{chksum}="      ";	# Utterly pointless
 $ref->{typeflag}=0;		# Ordinary file
 $ref->{linkname}="";
 $ref->{magic}="ustar\0";
 $ref->{version}="00";
 # WinNT protection
 $ref->{uname}=$has_getpwuid?(getpwuid($>))[0]:"unknown";
 $ref->{gname}=$has_getgrgid?(getgrgid($ref->{gid}))[0]:"unknown";
 $ref->{devmajor}=0;
 $ref->{devminor}=0;
 $ref->{prefix}="";

 if ($opt) {
	foreach $key (keys %$opt) {
	    $ref->{$key} = $opt->{$key}
	}
 }

 push(@{$self->{'_data'}},$ref);
 return 1;
}

# Write a single (probably) file from the in-memory archive to disk
sub extract {
 my $self = shift;
 my (@files) = @_;
 my ($file, $current, @path);

 foreach $file (@files) {
	foreach (@{$self->{'_data'}}) {
	    if ($_->{name} eq $file) {
		# For the moment, we assume that all paths in tarfiles
		# are given according to Unix standards.
		# Which they *are*, according to the tar format spec!
		(@path) = split(/\//,$file);
		$file = pop @path;
		$current = cwd;
		foreach (@path) {
		    if (-e $_ && ! -d $_) {
			#warn "$_ exists but is not a directory!\n";
			next;
		    }
		    mkdir $_,0777 unless -d $_;
		    chdir $_;
		}
		if (not $_->{typeflag}) { # Ordinary file
		    open(FILE,">".$file);
		    binmode FILE;
		    print FILE $_->{'data'};
		    close FILE;
		}
		elsif ($_->{typeflag}==5) { # Directory
		    if (-e $file && ! -d $file) {
			drat;
		    }
		    mkdir $file,0777 unless -d $file;
		}
		elsif ($_->{typeflag}==1) {
		    symlink $_->{linkname},$file if $symlinks;
		}
		elsif ($_->{typeflag}==6) {
		    #warn "Doesn't handle named pipes (yet).\n";
		    return 1;
		}
		elsif ($_->{typeflag}==4) {
		    #warn "Doesn't handle device files (yet).\n";
		    return 1;
		}
		elsif ($_->{typeflag}==3) {
		    #warn "Doesn't handle device files (yet).\n";
		    return 1;
		}
		else {
		    $error = "unknown file type: $_->{typeflag}";
		    return undef;
		}
		utime time, $_->{mtime}, $file;
		# We are root, and chown exists
		if ($>==0 and $ ne "MacOS" and $ ne "MSWin32") {
		    chown $_->{gJz},$_->{gid},$file;
		}
		# chmod is done last, in case it makes file readonly
		# (this accomodates DOSish OSes)
		chmod $_->{mode},$file;
		chdir $current;
	    }
	}
 }
}

# Return a list of all filenames in in-memory archive.
sub list_files {
 my ($self) = shift;

 return map {$_->{name}} @{$self->{'_data'}};
}
1;
