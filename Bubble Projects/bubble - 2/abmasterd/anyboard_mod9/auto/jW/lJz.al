# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 210 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lJz.al)"
sub lJz{
 my ($self) = @_;
 my $eS =  $self->nDz('msglist'); 
 my $mnofile =  $self->nDz('cLaA'); 
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $len = $db->pXa();
 my $h = {};

 open F, "<".$self->nDz('cday');
 my @lA=<F>;
 close F;
 chomp @lA;
 
 $h->{cday}= $lA[0];
 $h->{list}= $lA[1];
 $h->{mcnt} = $len;
 $h->{lunixtime}= (lstat($eS))[9];
 $h->{lunixtime}= (lstat($mnofile))[9] if not $h->{lunixtime};
 $h->{ltime} = &abmain::dU('DAY', $h->{lunixtime}, 'oP');
 if(time() < $h->{lunixtime} + 60*$self->{kF} ) {
	      $h->{ltime} = qq(<font color="$self->{new_msg_color}"><b>).$h->{ltime}. qq(</b></font>);
 }
 $h->{ctime}= &abmain::dU('DAY', $h->{cday}, 'oP');
 $h->{desc} = $self->{forum_desc};
 $h->{name}= $self->{name};
 $h->{gAz} = $self->{gAz};
 $h->{name} =~ s/</\&lt;/g;
 $h->{name} =~ s/>/\&gt;/g;
 $h->{admin} = $self->{admin};
 $h->{admin} =~ s/</\&lt;/g;
 $h->{admin} =~ s/>/\&gt;/g;
 $h->{admin}= $self->fGz($h->{admin}, 'cRz');
 $h->{admin_email}= $self->{admin_email};
 $h->{admin_email} =~ s/</\&lt;/g;
 $h->{admin_email} =~ s/>/\&gt;/g;
 $h->{moders} = join(", \t",sort keys %{$self->{moders}}) if (keys %{$self->{moders}});
 $h->{nolistmoder} = $self->{no_list_moders};
 $h->{xIz} = $self->xIz();
 $h->{pL} = $self->{pL};
 $h->{fC} = $self->fC();
 $h->{no_list} = $self->{no_list_me};
 $h->{sort_idx} = $self->{forum_idx} || $self->{name};
 $h->{icon} = $self->{forum_logo};
 $h->{forum_cat} = $self->{forum_cat};
 return $h;
}

# end of jW::lJz
1;
