#!/usr/bin/perl -w

#
# This code is take directly from Celestix, line-for-line
#

use FindBin;
use lib "$FindBin::Bin";

require "fui-lib.pl";
use integer;

my @months = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
my @pos = ( [ 0, 1 ],
            [ 3, 5 ],
            [ 7, 10 ],
            [ 12, 13 ],
            [ 15, 16 ],
          );

my ( $sec, $min, $hour, $mday, $mon, $year ) = localtime();
$year += 1900;
my $curpos = 0;
my @date = ( $mday, $months[$mon], $year, $hour, $min );
my $datestr = sprintf"%2d %3s %4d %2d:%02d", @date;

sub drawdate
{
  my ($x, $y, $date) = @_;
  my @idx = @{$pos[$curpos]};
  substr $date, $idx[0], $idx[1] - $idx[0] + 1, " " x ( $idx[1] - $idx[0] + 1 );
  sendfui("erasetext 2 3");
  textxy( shift, shift, $date );
}

sub draw
{
  draw_menu( "+", "Ok", "<", ">" );
  
  drawdate( 2, 3, $datestr );
  highlight( $curpos, 1 );
}

sub highlight
{
  my ( $num, $on ) = @_;

  my @idx = @{$pos[$num]};
  my $c = substr $datestr, $idx[0], $idx[1] - $idx[0] + 1;
  my $x = 2 + $idx[0];
  my $y = 3;
  sendfui("hitext $x $y \"$c\"") if ($on);
}

sub move
{
  my ( $dir ) = @_;

  $curpos = ( $curpos + $dir ) % 5;
  sendfui("erasetext 2 3");
  drawdate( 2, 3, $datestr );
  highlight( $curpos, 1 );
}

sub confirm
{
  draw_menu( "", "Cancel", "Yes", "No" );
  textxy( 2, 3, $datestr );
  my $str = "Confirm Update?";
  textxy( Xcenter( $str ), 4, "$str" );
  while (1) {
    my $key = get_key();
    return -1 if( $key eq 'B' );
    return 1 if( $key eq 'C' );
    return 0 if( $key eq 'D' );
  }
}

sub modify
{
  my $mod = shift;

  SWITCH: for ($curpos) {
    /0/     &&    do { 
                    $mday += $mod;
                    $mday = 1 if ( $mday > 31 );
                    $mday = 31 if ( $mday < 1 );
                    substr $datestr, 0, 2, sprintf "%2d", $mday;
                    last SWITCH;
                  };

    /1/     &&    do {
                    $mon = ( $mon + $mod ) % 12;
                    substr $datestr, 3, 3, "$months[$mon]";
                    last SWITCH;
                  };

    /2/     &&    do {
                    $year += $mod;
                    $year = 2000 if ( $year > 2030 );
                    $year = 2000 if ( $year < 1960 );
                    substr $datestr, 7, 4, sprintf "%4d", $year;
                    last SWITCH;
                  };
  
    /3/     &&    do {
                    $hour = ( $hour + $mod ) % 24;
            		    $hour = 23 if ( $hour < 0 );
                    substr $datestr, 12, 2, sprintf "%2d", $hour;
                    last SWITCH;
                  };

    /4/     &&    do {
                    $min = ( $min + $mod ) % 60;
		                $min = 59 if ( $min < 0 );
                    substr $datestr, 15, 2, sprintf "%02d", $min;
                    last SWITCH;
                  };

  }

  drawdate( 2, 3, $datestr );
  highlight( $curpos, 1);
  return;
}


draw();
while( 1 ) {
  my $key = get_key();
  if( $key eq 'C' or $key eq 'LEFT' ) {
    move( -1 );
  } elsif( $key eq 'D' or $key eq 'RIGHT' ) {
    move( 1 );
  } elsif( $key eq 'A' or $key eq 'UP') {
    modify( 1 );
  } elsif( $key eq 'DOWN' ) {
    modify( -1 );
  } elsif( $key eq 'B' ) {
    my $r = confirm();
    if( $r == 0 ) {
      # if answer was no
      draw();
    } elsif( $r == 1 ) {
      # if answer was yes
      last;
    } elsif( $r == -1 ) {
      # if answer was quit
      exit;
    } 
  }
}

# month is zero based, but not in setting system date 
$mon++;
system( "date --set \"$mon/$mday/$year $hour:$min\"" ) and die "date: $!";
#system( "hwclock --systohc" ) and die "hwclock: $!";
