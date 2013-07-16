package bAa;

require sVa;
use vars qw(@fs);
use strict;
no strict "refs";
BEGIN {
 @fs=qw(name type aJa desc val verifiers required dbtype dbsize idxtype);
}

$bAa::missing_val_label = "missing value";
$bAa::invalid_val_label = "invalid value";
$bAa::invalid_id_label = "invalid id, must be alphanumeric";
$bAa::invalid_card_label = "invalid card number";
$bAa::invalid_email_label = "invalid email address";
$bAa::invalid_url_label = "invalid URL";

sub new {
 my $type = shift;
 my $self = {};
 @{$self}{@fs} = @_;
 bless $self, $type;
 $self->dLaA();
 return $self;
}

use AutoLoader 'AUTOLOAD';
1;
