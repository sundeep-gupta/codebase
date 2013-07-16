package McAfeeSecurity;
use strict;

# Factory Method to return the actual object of the 
# Security product under test.
sub get_product_object {
    my ($product_class, ) = @_;
    if ($product_class eq 'McAfeeSecurity::Mac::Consumer') {
        require McAfeeSecurity::Mac::Consumer;
    }
    if ($product_class eq 'McAfeeSecurity::Mac::Enterprise') {
        require McAfeeSecurity::Mac::Enterprise;
    }
     return $product_class->new();
}

1;
