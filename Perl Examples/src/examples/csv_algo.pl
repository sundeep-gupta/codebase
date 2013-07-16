#!/usr/bin/perl -w

sub split_line {
    my ($line) = @_;
    my @chars = split('',$line);
    
    foreach my $char ( @chars ) {
        if( $in_doublequote == 1) {
            if( $escape_next_char == 1) {
                $token = $token . $char;
                $escape_next_char = 0;
            } else {
                if( $char eq $escape_char ) {
                    $escape_next_char = 1;
                } else {
                    $token = $token . $char;
                }
            }   
        } else {
            if( $char eq $delimiter) {
                push @tokens, $token;
                $token = '';
            } else {
                if ( $char eq $double_quote ) {
		    $in_doublequote = 1;
                    # Push doublequuote character into the token for now
                    $token = $token . $char;
                } else {
                    $token = $token . $char;
                }
            }
            
        }
    }

}
