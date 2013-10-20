package rNa;


use strict;
use vars qw(
@lXa
@fieldtypes
@mvfieldtypes
@dN
@root_login_form
@wFa
@vVa
%wMa
@uBa
@mail_merge_form
@iGz
%bK
$tabattr
);

@lXa=(
['', 'head', "Create New Form"],
['uVa', "text", "", "ID of the new form, must start with a letter and be alphanumeric", ""],
['_aefcmd_', 'hidden', '', "", "mkform"],
);

@fieldtypes=(
[""=>"Choose type"],
[text=>"One line text field"],
[textarea=>"Multi-line text box"],
[password=>"Password entry"],
[file=>"File upload entry"],
[ifile=>"File upload inlined"],
[hidden=>"Hidden field"],
[checkbox=>"Checkbox"],
[radio=>"Radio buttons"],
[select=>"Single selection list"],
[kAa=>"Multiple selection list"],
[date=>"Date value"],
[time=>"Time value"],
[head=>"Form heading"],
);

@mvfieldtypes=(
[""=>"Choose type"],
);
@wFa=(
["vJa", "head", "Add Form Element"],
["wEa", "text", "", "Field name. Use letters, digits and _ only.", ""],
[uLa=>"select", join("\n", map { join('=', @$_) } @fieldtypes), "Field type", ""],
["vRa", "textarea", "rows=2 cols=64", "Field description", ""],
["vKa", "textarea", "rows=2 cols=64", "Field attributes.<br>Examples: size=6; rows=4; cols=64.", ""],
["vDa", "text", "", "Default value", ""],
["fieldverifier", "select", "=None\nbe_url=URL\nbe_email=Email\nbe_deci=Number\nbe_card=Credit card number", "Value check", ""],
["fieldrequired", "checkbox", "1=Yes", "Field is required", ""],
["fieldsizemax", "text", "size=8", "Field size max", ""],
["fielddbtype", "select", "VARCHAR=VARCHAR\nCHAR=CHAR\nINT=INTEGER\nFLOAT=FLOAT\nBLOB=BLOB", "Field SQL Type", ""],
["fieldidxtype", "select", "=None\nindex=index\nunique=Unique Index\npk=Primary key", "Field SQL index type", ""],
[uVa=>"hidden", "", "", ""],
["wAa", "hidden", "", "Field id", ""],
["beforeid", "hidden", "", "Field id", ""],
['_aefcmd_', 'hidden', '', "", "vZa"],
);

@vVa=(
["", "head", "<b>Search data</b>"],
[srachpat=> "const", "", qq(Search pattern), qq(<input type="text" name="pat">)],
["time", "const", "", qq(Time), qq(<input type="text" size="3" name="vWa"> days ago to <input type="text" size="3" name="vHa"> days ago)],
["sortkey", "select"],
["sortorder", "radio", "a=Ascending\nd=Descending", "Sort order"],
["output_format", "select", "TEXT=TEXT\nHTML=HTML", "Output format", ""],
["extract_fields", "text", qq(size="40"), "Only show these fields"],
[uVa=>"hidden", "", "", ""],
['_aefcmd_', 'hidden', '', "", "findidx"],
);

%wMa =(
lXa=>[\@lXa, "Create New Form"],
wFa=>[\@wFa, "Add form element"],
create_adm_form=>[\@dN, "Create Administrator"],
root_login_form=>[\@root_login_form, "Admin Login"],
);
 

@uBa=(
["", "head", "Form processing settings"],
["name", "text", "size=60", "Name of the form", "A Form"],
["publish", "checkbox", "1=yes", "Activate the form", ""],
["vAa", "checkbox", "1=yes", "Submitted data can be viewed by anyone?", ""],
["wBa", "checkbox", "1=yes", "Submitted data can be viewed by registerd users", ""],
["vCa", "checkbox", "1=", "User must register to submit the form", ""],
["allowedusers", "textarea", "rows=2 cols=40", "Only these users can submit the form (names separated by comma)", ""],
["allowedreaders", "textarea", "rows=2 cols=40", "Only these users can view the form data (names separated by comma)", ""],
["extraeditors", "textarea", "rows=2 cols=40", "Allow these additional users to edit the form data (names separated by comma)", ""],
["modbyuser", "checkbox", "1=", "Allow user to modify submitted data", ""],
["fields", "const", "", "Available field names", ""],
["wJa", "textarea", "rows=2 cols=64", "Names of required fields", ""],
["uSa", "textarea", "rows=2 cols=64", "Names of indexed fields", ""],
["vQa", "text", "", "The http referer must match this pattern", ""],
["pagesize", "text", "size=4", "Number of submitted items to display per page", "20"],
[required_word=> "text", "size=48", "Label to signify that a field is required",  qq(<font color="#cc0000"><sup>*</sup></font>)],
["qDz", "checkbox", "1=yes", "Allow overriding uploaded file", "1"],
["usedb", "checkbox", "1=yes", "Use SQL DB", "0"],
["", "head", "Form reply settings"],
["finboard", "checkbox", "1=yes", "Make the form available in message area posting. When this is checked, users can post a forum message with this form attached.", ""],
["frepfids", "checkbox", "", "", ""],
["", "head", "Form notification settings"],
["notify", "checkbox", "1=yes", "Send notification when form is submitted", ""],
["wN", "text", "size=60", "Email address to notify when form is submitted", ""],
["bcc", "text", "size=60", "Email(s) notified via BCC field", ""],
["notifier", "text", "size=60", "Sender email address of the notification", ""],
["", "head", "Layout Form"],
["multientrycnt", "text", "", "Show this many form entries by default. By setting this to greater than 1, a user can submit multiple entries of this form on one screen.", "1"],
["uRa", "checkbox", "1=yes", "Use inherited headers and footers, ignore the following settings", "1"],
["uOa", "textarea", "rows=8 cols=64", "Header of the submit page", "<html><body>"],
["uZa", "textarea", "rows=8 cols=64", "Footer of the submit page", "</body></html>"],
["vBa", "textarea", "rows=8 cols=64", "Header of the confirmation page", "<html><body>"],
["vTa", "textarea", "rows=8 cols=64", "Footer of the confirmation page", "</body></html>"],
["vNa", "htmltext", "rows=20 cols=64", "Template for the submit form. You must manually update this if fields are updated", ""],
["vLa", "htmltext", "rows=8 cols=64", "Default template for the submit form. Do not edit this entry. Use this only as a reference. When additional fields are added, the other templates are not updated. You must manually change the templates to include the new fields. A field is represented in the template as \{a_field_id\}. The _COMMAND_ tag represents the reset and submit buttons. Hidden fields and FORM tags will be added automatically by the program.", ""],
["fullview", "htmltext", "rows=20 cols=64",  "Template for detail data view."],
["vFa", "htmltext", "rows=20 cols=64", "Template for data overview", ""],
["vPa", "htmltext", "rows=8 cols=64",  "Default template for data view."],
[uVa=>"hidden", "", "", ""],
['_aefcmd_', 'hidden', '', "", "vUa"],
); 

use aLa;
use jEa;
use sVa;

sub sVa::gYaA(@);
%bK = (
mkform => [\&rPa, 'ADM'],
delfield=>[\&uAa, 'ADM'],
uYa=>[\&uYa, 'PUB'],
wLa=>[\&wLa, 'ADM'],
cCaA=>[\&cBaA],
vZa=>[\&tMa],
submit=>[\&uDa, 'PUB'],
modify =>[\&tLa, 'REG'],
dataidx=>[\&tCa],
findidx=>[\&tOa, 'CHK'],
uGa=>[\&uGa, 'CHK'],
uBa=>[\&cGaA, 'ADM'],
vUa=>[\&sGa, 'ADM'],
rFa=>[\&rFa, 'REG'],
modfield=>[\&tAa, 'ADM'],
moddata=>[\&rHa],
cKaA=>[\&cKaA, 'PUB'],
login=>[\&tJa, 'PUB'],
logout=>[\&yFz],
lico=>[\&hZz, "ADM"],
cAaA=>[\&eYa, 'PUB'],
wIa=>[\&uCa, 'PUB'],
vGa=>[\&tBa],
retr=>[\&uEa],
bSaA=>[\&yJa, 'ADM'],
crsql=>[\&eAaA, 'ADM'],
crtable=>[\&eHaA, 'ADM'],
cDaA=>[\&yYa, 'ADM'],
sinfo=>[\&wLz, 'PUB']
);

$tabattr= {width=>"90%", usebd=>1};
sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{iC}= $argh->{iC};
 $self->{tmpldir}= $argh->{tmpldir};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{home} = $argh->{home};
 $self->{header} = $argh->{header};
 $self->{footer} = $argh->{footer};
 $self->{jW} = $argh->{jW};
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

sub bTaA{
	my ($self, $url) = @_;
	$self->{uQa} = $url;
}

sub bWaA{
	my ($self, $link) = @_;
	$self->{vSa} = $link;
}

sub cBaA{
 my ($self, $input) = @_;
 $self->sWa('wFa', {uVa=>$input->{uVa}, beforeid=>$input->{beforeid} }, undef, $input->{beforeid}?1:5) ;
}

sub uYa{
 my ($self, $input) = @_;
 $self->sWa($input->{uWa}) if $input->{uWa};
 $self->rZa($input) if $input->{uVa};
}

sub cGaA{
 my ($self, $input) = @_;
 $self->uBa($input) ;
}

sub wLa{
 my ($self, $input) = @_;
 $self->rVa($input->{uVa});
}

use AutoLoader 'AUTOLOAD';
1;
