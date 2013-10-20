# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2512 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/kO.al)"
sub kO{
 my ($self, $cG, $body) = @_;
 my $entry = lB->new($cG, $cG, $cG);
 if($entry->load($self)) {
	$entry->{body} = $body;
	$entry->store($self);
 }else {
 	 my $all = $self->yO($cG);
 	 $all =~ s/<!--$cG\{-->(.*)<!--$cG\}-->/<!--$cG\{-->$body\n<!--$cG\}-->/s;
 	 $self->xB($cG, $all);
 	 return;
 }
}

# end of jW::kO
1;
