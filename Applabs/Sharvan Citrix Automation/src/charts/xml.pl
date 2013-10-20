#!/usr/bin/perl

my @values;
my @numbers;
my $xml = "<chart><axis_category size='14' color='000000' alpha='0' font='arial' bold='true' skip='0' orientation='horizontal' /><axis_ticks value_ticks='true' category_ticks='true' major_thickness='2' minor_thickness='1' minor_count='1' major_color='000000' minor_color='222222' position='outside' /><axis_value min='0' max='325742592' font='arial' bold='true' size='10' color='ffffff' alpha='50' steps='6' prefix='' suffix='' decimals='0' separator='' show_min='true' /><chart_border color='000000' top_thickness='2' bottom_thickness='2' left_thickness='2' right_thickness='2' />";
push(@values,$xml);

$xml = "<chart_data><row><null/>";
push(@values,$xml);

my $ctr=1;			
open(FHIN,"data.txt") or die "Can't open $!";

while (<FHIN>) {
	chop;
	$xml = "<string>$ctr</string>\n";
	push(@values,$xml);
	$xml = "<number>$_</number>\n";
	push(@numbers,$xml);
	$ctr = $ctr+1;
}
close(FHIN);
$xml = "</row><row><string>Region A</string>";
push(@values,$xml);
push(@values,@numbers);
$xml = "</row></chart_data><chart_grid_h alpha='10' color='000000' thickness='1' type='solid' /><chart_grid_v alpha='10' color='000000' thickness='1' type='solid' /><chart_pref line_thickness='2' point_shape='none' fill_shape='false' /><chart_rect x='40' y='25' width='335' height='200' positive_color='000000' positive_alpha='30' negative_color='ff0000' negative_alpha='10' /><chart_type>Line</chart_type><chart_value position='cursor' size='12' color='ffffff' alpha='75' /><draw><text color='ffffff' alpha='15' font='arial' rotation='-90' bold='true' size='50' x='-10' y='348' width='300' height='150' h_align='center' v_align='top'>hertz</text><text color='000000' alpha='15' font='arial' rotation='0' bold='true' size='60' x='0' y='0' width='320' height='300' h_align='left' v_align='bottom'>output</text></draw><legend_rect x='-100' y='-100' width='10' height='10' margin='10' /><series_color><color>77bb11</color><color>cc5511</color></series_color></chart>";
push(@values,$xml);
open(FHOUT,">data.xml");
print FHOUT @values;
close(FHOUT);