package jEa;

use jFa;
use jPa;

BEGIN{
	@jEa::ISA= qw(jFa);
};

sub LOCK_SH {1}; sub LOCK_EX {2}; sub LOCK_UN {8};

use AutoLoader 'AUTOLOAD';
1;
