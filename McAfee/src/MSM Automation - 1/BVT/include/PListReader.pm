# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package PListReader;

use Foundation;
use strict;

sub new {
    my ($package, $plist_name) = @_;
    
    return undef unless -e $plist_name;
    my $object =  NSDictionary->dictionaryWithContentsOfFile_( $plist_name );
    my %keys   = &perlHashFromNSDict ( $object, 1);
    my $self = {
        'file'   => $plist_name,
        'object' => $object,
        'keys'   => \%keys,
    };

    bless $self, $package;
}
sub get_keys {
	my ($self, $ra_keys ) = @_;
	
	my $rh_ret = {};
	foreach my $key ( @$ra_keys) {
		$rh_ret->{$key} = $self->{'keys'}->{$key}
				if $self->{'keys'}->{$key};
	}
	
	return $rh_ret;
}
sub perlValue {
  my ( $object ) = @_;
  return $object->description()->UTF8String();
}

sub getPlistObject {
  my ( $object, @keysIndexes ) = @_;
    return unless @keysIndexes;

    foreach my $keyIndex ( @keysIndexes ) {
        unless ( $object and $$object ) {
            print STDERR "Got nil or other error for $keyIndex.\n";
            return;
        }
        
        if ( $object->isKindOfClass_( NSArray->class ) ) {
          $object = $object->objectAtIndex_( $keyIndex );
        } elsif ( $object->isKindOfClass_( NSDictionary->class ) ) {
          $object = $object->objectForKey_( $keyIndex );
        } else {
          print STDERR "Unknown type (not an array or a dictionary):\n";
          return;
        }
    }
    return $object;
}

sub perlHashFromNSDict {
  my ( $cocoaDict, $convertAll ) = ( @_ );
  my %perlHash = ();
  my $enumerator = $cocoaDict->keyEnumerator();
  my $key;
  while ( $key = $enumerator->nextObject() and $$key ) {
    my $value = $cocoaDict->objectForKey_($key);
    if ( $value ) { # check to make sure an object was set
      if ( substr ( ref ( $value ), 0,9 ) eq "NSCFArray" ) {
        my @newarray = perlArrayFromNSArray( $value, $convertAll );
        $perlHash{ perlValue( $key ) } = \@newarray;
      } elsif ( substr ( ref ( $value ), 0,14 ) eq "NSCFDictionary" ) {
        my %newHash = perlHashFromNSDict( $value, $convertAll );
        $perlHash{ perlValue( $key ) } = \%newHash;
      } else {
        $perlHash{ perlValue( $key ) } = 
        $convertAll ? perlValue( $value ) : $value;
      }
    }
  }
  return %perlHash;
}



sub perlArrayFromNSArray {
  my ( $cocoaArray, $convertAll ) = ( @_ );
  my @perlArray = ();
  my $enumerator = $cocoaArray->objectEnumerator();
  my $value;
  while ( $value = $enumerator->nextObject() and $$value ) {
    if ( substr ( ref ( $value ), 0,9 ) eq "NSCFArray" ) {
      my @newarray = perlArrayFromNSArray( $value, $convertAll );
      push (@perlArray, \@newarray);
    } elsif ( substr ( ref ( $value ), 0,14 ) eq "NSCFDictionary" ) {
      my %newhash = perlHashFromNSDict( $value, $convertAll );
      push (@perlArray, \%newhash);
    } else {
      push ( @perlArray, $convertAll ? perlValue( $value ) : $value );
    }
  }
  return @perlArray;
}

1;
