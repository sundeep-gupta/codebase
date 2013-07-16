# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 271 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/aYa.al)"
sub aYa{
 my  ($self, $vo, $mvsep, $ksuffix) = @_;
 my ($k, $v, $a, $t) = ($self->{name}, $self->{val}, $self->{aJa}, $self->{type});
 my $bZa;
 if($t eq 'fixed') {
	return $v;
 }
 my $dq = '&#34;';
 if($t eq 'label') {
	return $v;
 }

 sVa::encode_entities(\$v) if($t eq 'text' || $t eq 'hidden');
 if($t eq 'const' || $t eq 'fixed') {
	my $v2 = $v;
 	sVa::encode_entities(\$v2);
	return qq(<input type="hidden" name="$k$ksuffix" value="$v2"/>$v);
 }
 if($t eq 'htmltext') {
	$a = qq(rows="2" cols="60") if $a eq '';
	my $id="html$k$ksuffix";
	$bZa =  qq(<textarea $a name="$k$ksuffix" id="$id" class="htmltext">$v</textarea>);
 	if($self->{form} && $self->{form}->tGa('pvhtml')) {
		$bZa .= "<br/>". sVa::hFa("$self->{form}->{zKz}->{cgi}?htmlviewcmd=view&xZa=$k$ksuffix", "Edit HTML", "$k$ksuffix");
	}
 unless ($aLa::_ml_mode eq 'xhtmlmp' ) {
		if($k eq 'description' || $k eq 'content') {
			$bZa .= qq@<script> var oEdit1 = new InnovaEditor("oEdit1"); oEdit1.REPLACE("$id"); </script>\n@;
		}
	}
	return $bZa;
 }
 if($t eq 'icon') {
		my $img="";
		if($v) {
			$img =qq(<img id="img$k$ksuffix" src="$v"/>);
		}else {
			$img =qq(<img id="img$k$ksuffix" src="/images/blank.gif"/>);
		}
		$a = qq(size="64") if $a eq '';
 my $js= qq! onblur="(document.all? document.all.img$k$ksuffix: document.getElementById('img$k$ksuffix')).src=this.value;"!;
		$bZa =  qq($img <input type="text" $a name="$k$ksuffix" value="$v" $js/>);
		return $bZa;
 }
 if($t eq 'color') {
		$bZa =  qq(<input type="text" $a name="$k$ksuffix" value="$v" class="input_text"/>);
 }
		
 if($t eq 'textarea') {
		$a = qq(rows="2" cols="60") if $a eq '';
		$bZa =  qq(<textarea $a name="$k$ksuffix">$v</textarea>);
		return $bZa;
 }
 
 if($t eq 'date') {
	return wCz("$k$ksuffix", $v, 'date');
 }
 if($t eq 'time') {
	return wCz("$k$ksuffix", $v, 'time');
 }
 if($t eq 'ifile' || $t eq 'file') {
 	return qq(<input type="file" $a name="$k$ksuffix" class="input_file"/> $v);
 }
 $bZa=   qq(<input type="$t" $a name="$k$ksuffix" class="input_$t");
 if( $t eq "checkbox" ) {
 			$bZa .= qq( checked="checked") if $v;
 } else{
 			$bZa .= qq( value="$v");
 }
 $bZa .=  "/>";
 return $bZa;
}

# end of bAa::aYa
1;
