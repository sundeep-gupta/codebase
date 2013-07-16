#!/usr/bin/perl
use OpenOffice::OODoc;
use XML::Simple;
use Data::Dumper;

#VALIDATION OF SCRIPT
if (! (-e "config.xml")) {
	print "Config.xml file not found";
	help();
	exit(1);
}
$c = @ARGV;

if($c>0) {
	$first = @ARGV[0];
	if($first eq "-h" or $first eq "-H") {
		help();
	} else {
		help_usage();
	}
	exit(1);
};

#Open XML file 
$xml = new XML::Simple;
$configdata = $xml->XMLin("config.xml");
$xsimple = XML::Simple->new();

($server_ip, $sharePath,  $fileName) = get_test_params($configdata);

#mount the remote machine
print `mount $server_ip:$sharePath /mntpt`;

for( $i = 0;$i<2;$i++) {
	#if Second time then check if go.txt exists or not
	if($i == 1) {
		$flag = 1;
		do {
			if(-e "/mntpt/go.txt") {
				print "File go.txt found";
				$flag = 0;
			}
		}while($flag);
	}

	#open the document and close it
	print "Hi"."\n";
	$time = time."\n";
        my $document = ooDocument(file => "/mntpt/$fileName");
	$time = time - $time;
	print $time."\n";

	if ($i == 0) {
	        my $newparagraph = $document->appendParagraph
                        (
                        text            => 'A new paragraph to be inserted',
                        style           => 'Text body'
                        );
                        # define a new graphic style, to display images
                        # with 20% extra luminance and color inversion
                        # save the modified document
	        $document->save;
		print 'Creating go.txt';
		print `touch /mntpt/go.txt`
	}
	write_xml($time,$i);
}
print "Out of Loop";




#####################################################################################################
#				User Defined Functions						    #
#####################################################################################################

#get the testcase parameters
sub get_test_params {
        my $testcase = shift;
        my $ip = $testcase->{'ip_address'};
        my $share = $testcase->{'share'};
        my $file = $testcase->{'file'};
	print "reading xml";
        @vals = ($ip,$share,$file);
        return @vals;
}



sub write_xml {
        my $time = shift;
        my $i = shift;
        %tags = (
                        $i => {
                                        copy_time   => $time,
                                        throughput => ($time == 0 ? 0 : (2048/$time))
                        },
        );


print Dumper(\%tags);
        if (open(LOGFILE, ">>DBC5.xml")) {

                print LOGFILE  $xsimple->XMLout(\%tags,noattr => 1, RootName => undef,xmldecl => ($i==0?'<?xml version="1.0"?>':undef));


            close(LOGFILE);
                print "In xml";
        }
}

sub help {
        print "\nPREREQUISITES:\n";
        print "1. OpenOffice::OODoc module must be installed for OpenOffice access using Perl.\n ";
	    print "2. XML::Twig, Compress::Zlib, and Archive::Zip modules must be installed to support OpenOffice::OODoc module\n";
	    print "3. XML::Simple module must be installed to read input and write XML files.\n";
        print "4. Config.XML file must be present in the same directory.\n";
        print "\nDESCRIPTION:\n";
        print "-> DBC4 mounts the remote machine in its local file system using the IP specified in the config.xml file.\n";
        print "-> Opens a OpenOffice document (~2MB), adds one paragraph and saves the document.
		print "-> Opens the same document for second time.\n";
        print "-> Writes the time taken for each file transfer into DBC4.XML file\n";
}
sub help_usage {
        print "Invalid argument\n";
        print;
        print "Usage : perl DBC4.pl [-h]\n";
}

