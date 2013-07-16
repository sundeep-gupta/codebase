# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 2305 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/fZaA.al)"
sub fZaA {
	my ($type, $xO) = @_;
	if($type eq 'TDIR') {
		return "$sVa::cQaA/back.gif" if $xO eq '..';
		return "$sVa::cQaA/folder.open.gif" if $xO eq '.';
		return "$sVa::cQaA/folder.gif";
	}
	if($xO eq 'README') {
		return "$sVa::cQaA/hand.right.gif";
	}
	if($xO eq 'core') {
		return "$sVa::cQaA/bomb.gif";
	}
	
my @iconmap = (
["layout.gif" => [ qw( .html .shtml .htm .asp .jsp .php)]],
["text.gif" => [ qw( .txt)]],
["image2.gif" => [ qw(.gif .jpg .bmp .png .jpeg)]],
["compressed.gif" => [ qw( .Z .z .tgz .gz .zip)]],
["binary.gif" => [".bin", ".exe"]],
["binhex.gif" => [ qw( .hqx)]],
["sound2.gif" => [ qw(.au .wave .mp3)]],
["movie.gif" => [qw(.mpeg .mpg .mov .avi .asf .rm)]],
["tar.gif" => [ qw( .tar)]],
["world2.gif" => [ qw( .wrl .wrl.gz .vrml .vrm .iv)]],
["a.gif" => [ qw( .ps .ai .eps)]],
["pdf.gif" => [ qw(.pdf)]],
["c.gif" => [ qw( .c)]],
["p.gif" => [ qw( .pl .py)]],
["f.gif" => [ qw( .for)]],
["dvi.gif" => [ qw( .dvi)]],
["uuencoded.gif" => [ qw( .uu)]],
["script.gif" => [ qw( .conf .sh .shar .csh .ksh .tcl)]],
["tex.gif" => [ qw( .tex)]],
["unknown.gif" => [ qw()]],
);
	$xO =~ /(\.[^\.]+)$/;
	my $ext = lc($1);
	for my $me (@iconmap) {
		my ($icon, $exts) = @$me;
		for my $e (@$exts) {
			return "$sVa::cQaA/$icon" if $e eq $ext;
		}
	}
	return "$sVa::cQaA/binary.gif";
}

# end of sVa::fZaA
1;
