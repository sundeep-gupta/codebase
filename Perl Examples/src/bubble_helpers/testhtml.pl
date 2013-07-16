use strict;
use HTML::TreeBuilder;
use HTML::Tree;
use HTML::Element;
use Data::Dumper;
use File::Basename;

my @files = recursive_ls('D:\Adsensewebsites\volume1');
foreach my $file (@files) {
	&fetch_and_store_article($file,$file.'.txt');
}

sub recursive_ls {
	my $dir = $_[0];
	return unless -d $dir;
	my @elements = ($dir);
	my @files = ();
	foreach my $elem (@elements) {

		if ( -f $elem) {
			push @files, $elem ;
			next;
		}elsif(-d $elem) {

			opendir(my $dh, $elem) ;
			my @subelems = readdir($dh);
			closedir($dh);

			foreach my $subelem (@subelems) {
				next if $subelem eq '.' or $subelem eq '..' or $subelem eq 'parsed';
				next if( -f $elem."\\".$subelem and $subelem !~ /\.html$/);
				push @elements, $elem.'\\'.$subelem;
			}
		}
	}
	return @files;
}



sub fetch_and_store_article {
	my ($infile, $outfile) = @_;

	print "$infile not found.\n" unless -e $infile;
    my $tree = HTML::TreeBuilder->new();
    $tree->parse_file($infile);
    $tree->elementify;
    my $elem_title = &lookup(
                    	&lookup(
                       	  &lookup(
                      	     &lookup(
                    		&lookup(
                    		   &lookup(
                      		     &lookup(
                    			&lookup(
                    			  &lookup( &lookup( &lookup( &lookup($tree, 'body'), 'div') , 'table'),'tr', 2),'td',2),'div'),'table'),'tr',2),'td'),'div'),'span'),'font');
    print "Failed $infile \n", return if (ref($elem_title) ne 'HTML::Element');

    my $ra_title = $elem_title->content;
    my $title = $$ra_title[0];


    my $elem_article = &lookup(
                  	&lookup(
                  	  &lookup(
                  	     &lookup(
                  		&lookup(
                  		   &lookup(
                  			  &lookup( &lookup( &lookup( &lookup($tree, 'body'), 'div') , 'table'),'tr', 2),'td',2),'div'),'table'),'tr',4),'td'),'span');

    my $ra_article = $elem_article->content;
    my $article = '';
    foreach my $el (@$ra_article) {
    	$article = $article . $el. ."\n\n" unless(ref($el) eq 'HTML::Element');
    }
    open(my $fh, ">$outfile");
    if($fh) {
    print $fh $title."\n\n";
    print $fh $article;
    close $fh;
    my $basedir = dirname($infile);
    my $filename = basename($infile);
    mkdir $basedir."\\parsed" unless -d $basedir;
    rename $infile, $basedir."\\parsed\\".$filename;
    } else {
    	print "Failed to write to $outfile\n";
    }

}
sub lookup {
    my ($tree, $tag, $which) = @_;
    $which = 1 unless $which;

    my $found = 0;
    return $tree if ref($tree) ne 'HTML::Element';
    my $content = $tree->content;


    foreach my $elem (@$content) {
    	next if ref($elem) ne 'HTML::Element';
    	if ( $elem->tag eq $tag) {
    		$found++;
    		return $elem if( $found eq $which);
    	}
    }
}