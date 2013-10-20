# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2489 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/htmla_code.al)"
sub htmla_code {
	my $img= $abmain::img_top;
return  qq!
<script>_editor_url="$img/htmlarea/";</script>
<script type="text/javascript" src="$img/htmlarea/htmlarea.js"></script>
<script type="text/javascript" src="$img/htmlarea/dialog.js"></script>
<script type="text/javascript" src="$img/htmlarea/lang/en.js"></script>
<style type="text/css">\@import url($img/htmlarea/htmlarea.css)</style>
!;
}

# end of abmain::htmla_code
1;
