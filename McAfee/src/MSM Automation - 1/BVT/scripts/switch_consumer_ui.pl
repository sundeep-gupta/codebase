# Copyright (c) 2010, McAfee Inc.  All rights reserved.
#!/usr/bin/perl -w
use strict;
BEGIN {
    use lib '../include';
    use Security::McAfee::Mac::Consumer;
}
#my $log = Log->new('../logs/switch_consumer_ui.log');
my $product = Security::McAfee::Mac::Consumer->new();
$product->launch();
$product->activate();
sleep 10;
$product->quit();
