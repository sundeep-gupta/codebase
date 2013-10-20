package aLa;

use bAa;
use bGa;
use bBa;
use bNa;
use cEa;

use vars qw(@cfgfs);
use strict;

BEGIN {
@cfgfs=qw(name jF cgi pk bBaA);
$aLa::req_tag = qq(<font color=red><b>*</b></font>);
$aLa::default_submit_label = qq(Submit);
$aLa::default_reset_label = qq(Reset);
}

#for radio button the  fU look like
#['key', 'radio', [option1=>"Label 1", option2=>"Label 2"], "Description for this key", "default"]
#or
#['key', 'radio', "option1=Label 1\noption2=Label 2", "Description for this key", "default"]

#for single selection the fU looks like
#['key', 'select', [option1=>"Label 1", option2=>"Label 2"], "Description for this key", "default"]
#['key', 'select', "option1=Label 1\noption2=Label 2", "Description for this key", "default"]

#for multi selection the fU looks like
#['key', 'kAa', [option1=>"Label 1", option2=>"Label 2"], "Description for this key", "option1"]

use AutoLoader 'AUTOLOAD';
1;
