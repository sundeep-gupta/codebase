# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1062 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wA.al)"
sub wA {
 my ($self, $n, $gIz) = @_;
 $self->fZz($n);
 if($self->{gFz}->{lc($n)}->[5] != $gIz) {
 	 &abmain::error('inval', "Invalid activation information");
 }
 sVa::gYaA "Content-type: text/html\n\n";
 my @rules;
 if($self->{rules}) {
 @rules = ($self->{rules});
 }elsif($self->{rule_file} ){
 if( open(RULEFILE, "<$self->{rule_file}")) {
 @rules = <RULEFILE>;
 close RULEFILE;
 }else {
 @rules=("<i>Can not open rule file $self->{rule_file}</i>");
 }
 }else {
 }
 $self->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head>\n$self->{sAz}\n<title>$self->{name}: Acceptance of the rules</title>$self->{other_header}
 <center>
 <h1>$self->{name}: Acceptance of the rules</h1>
 </center>
 <pre>@rules</pre>
 <p>
 <hr>
 <form action="$self->{cgi}" method="POST">
 @{[$abmain::cYa]}
 <center> 
 <input type="hidden" name="name" value="$n">
 <input type="hidden" name="vkey" value="$gIz">
 <input type="hidden" name="cmd" value="vO">
 <input type="checkbox" name="yJ" value="1">
 I have read the rules above carefully, 
 and <input type="submit" class="buttonstyle" name="accept" value="I accept the rules">
 </form>
 <br/> 
 <a href="/"> No thank you, goodbye</a> 
 </center>
 <hr>
$self->{other_footer}
 );
}

# end of jW::wA
1;
