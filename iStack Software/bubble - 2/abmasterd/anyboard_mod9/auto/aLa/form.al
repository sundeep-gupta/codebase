# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 730 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/form.al)"
#Third a argument is a reference to an array of skipped fields, such as [ 'field1', 'field2']

sub form{
	my ($self, $yG, $zGz, $mark_inval) = @_; 
	if($aLa::_ml_mode eq 'wml') {
		my $str= $self->form_wap($yG, $zGz, $mark_inval); 
		return $str;

	}elsif($aLa::_ml_mode eq 'chtml') {
		my $str= $self->form_chtml($yG, $zGz, $mark_inval); 
		return $str;
 }
 my $nofile = $aLa::_ml_mode eq 'xhtmlmp';

	my $aJa = $self->{zKz};
	my $name = $aJa->{name}||"f".time();
	$aJa->{button_label} = $aLa::default_submit_label if not $aJa->{button_label};
	my $cgi  = $aJa->{cgi}; 
	my $method = $aJa->{method} || 'post';
 my %skips=();
	my @gHz;
 my $mvsep = $self->tGa('mvsep');
	if($zGz) {
		for(@$zGz) {
			$skips{$_} =1;
		}
	}
 $self->cBa(undef, undef, undef, "#f0f0f0") if not $aJa->{_colors};

 my ($bgh, $bgo, $bge, $bgb) = @{$aJa->{_colors}};
	if ($self->tGa("skip_undef") || not $self->{zKz}->{temp}) {
	       	 $self->aSa(\%skips);
	       	 $self->{zKz}->{temp} = $self->{zKz}->{wGa};
	}

 my $cmdstr;
 my $fcnt = $self->get_field_count();

 my $submit_btn = 
 	qq(<input type="submit" onmouseover="javascript:changeStyle(this, 'buttonover')" onmouseout="javascript:changeStyle(this,'buttonstyle')" onclick="javascript:return submitButtonClicked(this)" value="$aJa->{button_label}" class="buttonstyle">);
	if (not $yG) {
 if($self->tGa("flat")) {
 	$cmdstr=qq(<tr class="FormButtonRow">\n\n<td>$submit_btn</td>\n</tr>\n);
 }else {
		if($fcnt < 5) {
 		$cmdstr=qq(<tr class="FormButtonRow">\n<td></td><td>$submit_btn</td>\n</tr>\n);
		}else {
 		$cmdstr=qq(<tr class="FormButtonRow">\n<td><input type="reset" value="$aLa::default_reset_label" class="buttonstyle"></td>\n<td>$submit_btn</td>\n</tr>\n);
		}
 }
 }

 
	my $bZa;
 my $enc ="";
 my $has_file;
 my @fields;
 my @types;
 my $zDz;
	my $reqtag= $aJa->{gBa} || $aLa::req_tag;
	my $dup_cnt = $self->tGa('dupcnt')||1;

 my $idx=0;
 my @strs;

 for(; $idx<$dup_cnt; $idx++) {
	my $ftemp = $self->{zKz}->{temp};
 my $ksuffix="";
	if($idx>0) {
		$ksuffix ="_aef_ss_$idx";
 }
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 
		my $v;
		my ($k, $t, $a,  $d) = @{$ele}{qw(name type aJa desc)};
		next if ($nofile && ($t eq 'file' || $t eq 'ifile'));

		my $fk = "$k$ksuffix";
 push @fields, $fk;
 push @types, $t;

		if ($self->{$k}) {
		     $v = $self->{$k};
		}else {
 $v = $ele->{val};
 }
 
		$v="" if $t eq 'password';
 if($t eq 'hidden' || $t eq 'command') {
			next if $yG;
 			$zDz .=qq(<input type="hidden" name="$fk" value="$v">\n);
 		}

 if ((not $yG) && not $self->{_vokeys}->{$k}) {
		   if($t eq 'checkbox' || $t eq 'radio') {
 $bZa = $ele->aYa($v, $mvsep, $ksuffix);
 }else {
 $bZa = $ele->aYa($v, undef, $ksuffix);
 }
		     $bZa .= " $reqtag" if (not $ele->validate("")) && not $mark_inval;
		     $bZa .= qq( <font color="red">$ele->{_error}</font>) if $mark_inval && not $ele->validate(); 
 $has_file = 1 if ($t eq 'file' || $t eq 'ifile');
 if($self->{_pvkeys}->{$k}) {
		     $bZa .= "<br/>".sVa::cUz("javascript:ab_preview2(document.forms.$name.$fk)", "Preview");
 }
 }else {
 $bZa = $ele->bDa($v);
 }
 $bZa = '&nbsp;' if $bZa eq "";
 $ftemp =~ s/\{$k\}/$bZa/g;
	}
	if($idx<$dup_cnt -1) {
 	$ftemp =~ s/\{_COMMAND_\}//g;
	}
	push @strs, $ftemp;
 }
 my $ftemp = join("", @strs);
 my $fs = join('-', @fields);
 my $ts = join('-', @types);
 $ftemp =~ s/\{_COMMAND_\}/$cmdstr/g;
	return $ftemp if $yG;
	$method=$aJa->{method} || 'post';
 $enc= qq(ENCTYPE="multipart/form-data") if $has_file;
	my $aef_mult = qq(<input name="_aef_multi_kc" value="$dup_cnt" type="hidden">);
	my $tgt="";
	$tgt= qq( target="$aJa->{tgt}" ) if $aJa->{tgt};
	my $cls="";
	$cls= qq( class="$aJa->{cls}" ) if $aJa->{cls};
	return qq(<form name="$name" action="$aJa->{cgi}" $enc method="$method" $tgt$cls>\n$ftemp\n
$sVa::cYa
$zDz
$aef_mult
<input type="hidden" name="_af_xlist_" value="$fs">
<input type="hidden" name="_af_tlist_" value="$ts">
</form>);
}

# end of aLa::form
1;
