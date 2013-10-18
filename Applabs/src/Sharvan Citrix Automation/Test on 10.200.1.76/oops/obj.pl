use strict;
use warnings;
use diagnostics;
use Employee;

#create Employee class instance
my $khurt =  eval { new Employee(); }  or die ($@);
 
#set object attributes
$khurt->firstName('Khurt');
$khurt->lastName('Williams');
$khurt->id(1001);
$khurt->title('Executive Director');



#diplay Employee info
$khurt->print();