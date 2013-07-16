#!/usr/bin/perl

use integer;
use IPC::SysV qw(S_IRWXU);
use IPC::Msg;

# Magic numbers
use constant MSG_OUT  =>  0x006f7574;
use constant MSG_IN   =>  0x0000696e;
use constant MSG_LIMIT => 256;

my $draw_msg_q = new IPC::Msg( MSG_IN, S_IRWXU );
if ( !defined($draw_msg_q) ) {
  print STDERR "Cannot open LCD input FIFO!  All panel i/o disabled\n";
}

my $keyb_msg_q = new IPC::Msg( MSG_OUT, S_IRWXU );
if ( !defined($keyb_msg_q) ) {
  print STDERR "Cannot open LCD output FIFO!  keys disabled\n";
}

# Clear screen
sendfui( "cls" );

return 1;

sub get_key
{
  my $key = "";
  $keyb_msg_q->rcv( $key, MSG_LIMIT, MSG_OUT );
  chomp($key);
  return uc($key);
}

sub Xcenter
{
  my( $text ) = @_;
  return( ( 21 - length( $text ) ) / 2 );
}

sub draw_menu
{
  my( $a, $b, $c, $d ) = @_;

  sendfui( "cls" );
  my $Xb = 19 - length( $b );
  my $Xd = 19 - length( $d );
  draw_box( 0, 8, 127, 54 );
  textxy( 2, 0, $a );
  textxy( $Xb, 0, $b );
  textxy( 2, 7, $c );
  textxy( $Xd, 7, $d );
}

sub textxyc
{
  my( $y, $text ) = @_;
  while( length( $text ) > 21 ) {
    $n = rindex( $text, " ", 21 );
    $n = 21 if( $n <= 0 );
    push @arr, substr $text, 0, $n, "";
  }
  push @arr, $text if( length( $text ) );

  foreach( @arr ) {
    my $str = $_;
    my $x = ( 21 - length( $str ) ) / 2;
    sendfui("text $x $y \"$text\"\n") if ( $text ne '');
    $y++;
  }
}

sub textxy
{
  my( $x, $y, $text ) = @_;
  sendfui("text $x $y \"$text\"\n") if ( $text ne '');
}

sub draw_box
{
  my( $x1, $y1, $x2, $y2 ) = @_;

  sendfui("box $x1 $y1 $x2 $y2 0");
}

sub put_image
{
  my( $x, $y, $image ) = @_;

  sendfui( "image $x $y $image" );
}

sub beep
{
  #  `echo %beep > /dev/fui0`;
}

sub cls
{
  sendfui( "cls" );
}

sub line
{
  my( $x1, $y1, $x2, $y2, $fill ) = @_;

  sendfui( "line $x1 $y1 $x2 $y2 $fill" );
}

sub box
{
  my( $x1, $y1, $x2, $y2, $fill ) = @_;

  sendfui( "box $x1 $y1 $x2 $y2 $fill" );
}

sub sendfui
{
  my ( $str ) = @_;

  $draw_msg_q->snd( MSG_IN, $str . "\n" );
}
