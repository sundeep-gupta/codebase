#!/usr/bin/perl -w

use strict;
use Stress::Config;
use Stress::Test;

# Delete every crontab entry for the root
`crontab -r`;

# Now create cron jobs as per the test case selected.

# Now run the test case

