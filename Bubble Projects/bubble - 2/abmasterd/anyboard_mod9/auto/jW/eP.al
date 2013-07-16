# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 278 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eP.al)"
sub eP {
 my($self, $gF, $nam, $adm, $cJz, $fU, $lic) = @_;
 eval 'use File::Path'; 
 abmain::error('sys', "Unable to load standard module File::Path ($@).") if $@;
 my $eD= $self->{eD};
 my @dirs= ($self->nDz('hM'),
	       $self->nDz('iC'),
 $self->nDz('mK'),
 $self->nDz('updir'),
 $self->nDz('qUz'),
 $self->nDz('evedir'),
 $self->nDz('chat'),
 $self->nDz('dbdir'),
 $self->nDz('grpdir'),
 );
 my $dVz = $self->nDz('passdir');

 if($gF eq 'rm' && not ($abmain::allow_board_deletion || $self->{allow_del_board} )) {
 abmain::error('deny', "This function must be enabled by setting the \$abmain::allow_board_deletion variable to 1");
 }
 my $hR = 'mkpath';
 if($gF eq 'rm') {
 $hR  = 'rmtree';
 }else {
 $gF = "create";
 }
 abmain::error('inval', "Directory $eD already exists. Please choose another directory name.") if (-d $eD && $gF ne 'rm');

 my $cL = abmain::cLz($fU);
 if(-f $cL) {
 $self->cOz($cL);
 }

 my $oA;
 if($gF ne 'rm' && $abmain::validate_admin_email){
 	abmain::jJz(\$adm);
 	$self->{name}=$nam;
 	$self->{admin}=$adm;
 	$self->{admin_email}=$cJz;
 	$self->{oA}="";
 	$self->{iGz}=$lic;
 	$self->{notifier}=$abmain::master_admin_email;
 	$oA = (int time()*rand())%100000 + 1;
 	$self->{oA} = abmain::lKz($oA);
 	$self->xI("Welcome to AnyBoard, $adm", qq(
I have created the forum: $self->{name}. The following are some important information.

Admin login URL: $self->{cgi_full}?@{[$abmain::cZa]}cmd=log
Admin login ID : $adm
Password       : $oA
URL to request new admin password:  $self->{cgi_full}?@{[$abmain::cZa]}cmd=lKa

Please login and change your password.
Best regards,

AnyBoard

)

) if $cJz; 
 	abmain::error('sys', "Error e-mail to $cJz: ". $abmain::wH)
 	    if ($cJz && $abmain::wH);
 }

 $eD =~ s#/$##;
 my $cmd = qq/File::Path::$hR(['$eD'])/;
 my @path=eval $cmd or abmain::error('sys', "When $gF directory $eD: $@");

 return if $gF eq 'rm';

 local $_;
 for(@dirs) {
 $_ =~ s#/$##;
 	mkdir ($_, 0755) or abmain::error('sys', "When $gF directory $_: $!, $@");
 open XFILE, ">$_/index.html";
 close XFILE;
 }
 $dVz =~ s#/$##;
 mkdir ($dVz, 0700) or abmain::error('sys', "When $gF directory $dVz: $!, $@");

 open F, ">".$self->nDz('cday') or abmain::error('sys', "When create file: $!");
 print F time(), "\n";
 print F "1\n";
 close F;
 $self->hL();
 $self->{qH} =0;
 $self->{_noreload_cfg} =1;
 $self->cCz("Welcome to $self->{name}, $adm!", "AnyBoard", 
	qq@
 <b>I will help you succeed in the 21st century.  Enjoy!</b><p>
	The following is a message from the AnyBoard development team:
<div style="background-image: Url(/abicons/hlbg.gif)">
	AnyBoard can be configured in almost any way you want.
	The default interface is kept to be very simple, to change it, please use the configuration functions in the admin panel,
 or load one of the templates come with your AnyBoard distribution.
</div>
 @,
 time());
 $self->cR();
 $self->eG();
 $self->nSa();
 
 $self->{notifier}=$cJz;
 $self->xI("Welcome to $self->{name}, $adm", "Admin login URL: $self->{cgi_full}?@{[$abmain::cZa]}cmd=log\n\nAdmin login ID=$adm\nPassword=$oA") 
	if $cJz && not $abmain::validate_admin_email; 
 return @path;
}

# end of jW::eP
1;
