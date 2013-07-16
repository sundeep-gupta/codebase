package Security;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# UID     YYMMDD : Comment
# -------------------------
# sgupta6 091116 : Created
##############################################################
use strict;
use Const;

# Factory Method to return the actual object of the 
# Security product under test.
$Security::product_instance = undef;
sub get_product_object {
    my ($product_class, ) = @_;

    unless ($Security::product_instance) {
        my $module_path = $product_class;
        $module_path =~ s/::/\//g; $module_path = "$INC_DIR/$module_path.pm";
        require $module_path;
        $Security::product_instance = $product_class->new();
    }
    return $Security::product_instance;
}

1;
