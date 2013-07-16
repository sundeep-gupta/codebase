package Stress::Const;
use strict;

require Exporter;
our @ISA = qw(Exporter);

@EXPORT = qw( LOG_DIR 

            );
$Stress::Const::LOG_DIR = 'logs';

1;
