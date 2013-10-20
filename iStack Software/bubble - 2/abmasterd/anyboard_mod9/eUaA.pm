package eUaA;


use strict;
use vars qw(
%bK
$tabattr
);

use aLa;
use gAaA;
use jEa;
use sVa;
sub sVa::gYaA(@);

@eUaA::edit_file_form=(
["efhead", "head", "<b>Edit or create new file</b>"],
["filename", "text", "size=40", "File name"],
["filecontent", "textarea", "rows=12 cols=60", "Content"],
["filepermission", "text", "size=4", "File permission", "0644"],
["filenocr", "checkbox", "1=Yes", "Strip carrige return?", 1],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fBaA"],
);

@eUaA::confirm_delfile_form=(
["", "head", "<b>Confirm file deletion</b>"],
["filename", "const", "size=40", "File name"],
["confirm", "checkbox", "1=Yes", "Detele file?"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fAaA"],
);

@eUaA::upload_file_form=(
["", "head", "<b>Upload files</b>"],
["file1", "file", "size=40", "File 1"],
["file2", "file", "size=40", "File 2"],
["file3", "file", "size=40", "File 3"],
["file4", "file", "size=40", "File 4"],
["filepermission", "text", "size=4", "File permission", "0644"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "upload"],
);
@eUaA::replace_file_form=(
["", "head", "<b>Upload a new file to replace the file</b>"],
["oldfilename", "const", "size=40", "File name"],
["file1", "file", "size=40", "File 1"],
["filepermission", "text", "size=40", "File permission"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fSaA"],
);

@eUaA::chmod_file_form=(
["", "head", "<b>Change file permission</b>"],
["filename", "const", "size=40", "File name"],
["filepermission", "text", "size=40", "File permission"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fLaA"],
);

@eUaA::create_subdir_form=(
["", "head", "<b>Create new folder</b>"],
["subdir", "text", "size=40", "Sub folder name"],
["permission", "text", "size=4", "Permission", "0755"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fYaA"],
);

%bK = (
fVaA=> [\&fVaA, 'ADM'],
fDaA=> [\&fDaA, 'ADM'],
fBaA=> [\&fBaA, 'ADM'],
rA=> [\&rA, 'ADM'],
fHaA=> [\&fHaA, 'ADM'],
upload=> [\&upload, 'ADM'],
fGaA=> [\&fGaA, 'ADM'],
fSaA=> [\&fSaA, 'ADM'],
eZaA=> [\&eZaA, 'ADM'],
fLaA=> [\&fLaA, 'ADM'],
fFaA=>[\&fFaA, 'ADM'],
fAaA=>[\&fAaA, 'ADM'],
fNaA=>[\&fNaA, 'ADM'],
fYaA=>[\&fYaA, 'ADM'],
deletesubdir=>[\&deletesubdir, 'ADM'],
sinfo=>[\&wLz, 'ADM']
);

$tabattr= {width=>"100%", usebd=>0};
sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{rootdir}= $argh->{rootdir};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{home} = $argh->{home};
 $self->{header} = $argh->{header};
 $self->{footer} = $argh->{footer};
 $self->{jW} = $argh->{jW};
 $self->{kQz} = $argh->{kQz};
 return bless $self, $type;
}

sub cFaA{
	my ($self, $adm) = @_;
	$self->{uTa} = $adm;
}

sub cJaA{
	my ($self, $kQz) = @_;
	$self->{wOa} = $kQz;
}

sub bUaA{
	my ($self, $url) = @_;
	$self->{wCa} = $url;
}

sub setShortView {
	my ($self, $short) = @_;
	$self->{_short_view} = $short;
}

sub setNoPermission {
	my ($self, $nop) = @_;
	$self->{_no_permission} = $nop;
}

sub setQuota{
	my ($self, $q) = @_;
	$self->{_quota} = $q;
}

sub bTaA{
	my ($self, $url) = @_;
	$self->{uQa} = $url;
}

sub bWaA{
	my ($self, $link) = @_;
	$self->{vSa} = $link;
}

sub setPath{
	my ($self, $p) = @_;
	$p =~ s!^/?!/!;
	$p =~ s#/[^/]+/\.\./#/#g;
	$p =~ s#/[^/]+/\.\.$#/#g;
	$p =~ s#/\./#/#g;
	$p = "" if $p =~ m!^/\.\./!;
	$p = "" if $p =~ m!^/\.\.$!;
	$p = "" if $p eq '/';
	$self->{docdir} = gAaA->new($self->{rootdir}, $p);
}
sub getFreeSpace{
	my($self) = @_;
	return 1024*1024*99999 if $self->{_quota} eq '';
	my $rootd = gAaA->new($self->{rootdir});
	return $self->{_quota} - $rootd->get_size();
}

use AutoLoader 'AUTOLOAD';
1;
