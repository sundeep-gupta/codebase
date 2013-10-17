package Orbital::XML::Parse;

use 5.008004;
use strict;
use warnings;
use XML::Simple;
use XML::Twig;
use Data::Dumper;
require Exporter;
use vars qw( @ISA $VERSION);

############################################################################################
#                          Module creation related things.                                 #
############################################################################################
$VERSION = "1.0";
our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Orbital::Tests ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(

);

# Preloaded methods go here.
#
# Constructor : Create a new Orbital::Parser object
#
sub new() {
    my $self = ();
    shift();
    $self->{"XML_FILE_NAME"} = shift();
    if(defined($self->{"XML_FILE_NAME"})) {
        $self->{"XML_HANDLE"} = XML::Twig->new()->parsefile($self->{"XML_FILE_NAME"});
        $self->{"ROOT"} = $self->{"XML_HANDLE"}->root();
    }
    bless($self);
    return $self;
}

sub get_testcase_name {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("TestCaseName");
    return $elt->first_child()->pcdata() if(defined($elt) &&(defined($elt->first_child()) ) );
    return undef;
}
sub get_local_orbital_info {
    my $self = shift;
    my $info = {};
    my $elt = $self->{"ROOT"}->first_child("Orbital")->first_child("Local");
    $info->{'ip'} = $elt->first_child("IP")->first_child()->pcdata();
    $info->{'send_rate'} = $elt->first_child("SendRate")->first_child()->pcdata();
    $info->{'recv_rate'} = $elt->first_child("RecieveRate")->first_child()->pcdata();
    my $proxy_info = {};
    $proxy_info->{'vip'} = $elt->first_child("Proxy")->first_child("LocalIP")->first_child()->pcdata();
#    print $proxy_info->{'vip'};
    $proxy_info->{'targetIP'} = $elt->first_child("Proxy")->first_child("TargetIP")->first_child()->pcdata();
    $proxy_info->{'desc'} = $elt->first_child("Proxy")->first_child("Description")->first_child()->pcdata();
    $info->{'proxy'} =  $proxy_info;
    return $info;
}

sub get_remote_orbital_info {
    my $self = shift;
    my $info = {};
    my $elt = $self->{"ROOT"}->first_child("Orbital")->first_child("Remote");
    $info->{'ip'} = $elt->first_child("IP")->first_child()->pcdata();
    $info->{'send_rate'} = $elt->first_child("SendRate")->first_child()->pcdata();
    $info->{'recv_rate'} = $elt->first_child("RecieveRate")->first_child()->pcdata();
    return $info;
}

sub get_local_orbital_ip {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("Orbital")->first_child("Local")->first_child("IP");
    return $elt->first_child()->pcdata() if(defined($elt) &&(defined($elt->first_child()) ) );
    return undef;
}

sub get_remote_orbital_ip {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("Orbital")->first_child("Remote")->first_child("IP");
    return $elt->first_child()->pcdata() if(defined($elt) &&(defined($elt->first_child()) ) );
    return undef;
}
sub get_dr_ip {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("WanSIM")->first_child("IP");
    return $elt->first_child()->pcdata() if(defined($elt) &&(defined($elt->first_child()) ) );
    return undef;
}
sub get_dr_passwd {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("WanSIM")->first_child("Password");
    return $elt->first_child()->pcdata() if(defined($elt) &&(defined($elt->first_child()) ) );
    return undef;
}
sub get_dr_user {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("WanSIM")->first_child("UserName");
    return $elt->first_child()->pcdata() if(defined($elt) &&(defined($elt->first_child()) ) );
    return undef;
}
sub get_dr_info {
    my %var = ( "ip" => get_dr_ip(),
             "user" => get_dr_user(),
             "passwd" => get_dr_password()
             );
    return \%var;

}

sub get_proxy_IP {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("Orbital")->first_child("Local")->first_child("Proxy")->first_child("LocalIP");
    return $elt->first_child()->pcdata() if(defined($elt) &&(defined($elt->first_child()) ) );
    return undef;
}

sub get_ftp_params {
    my $self = shift;

    my $elt = $self->{"ROOT"}->first_child("FTP");
    my @arr = undef;
    my $params = undef;
    if(defined($elt)) {
        $params = {};
        my $sub_elt = $elt->first_child("DestIP");
        $params->{"dest_ip"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt->first_child()->pcdata()));
        $sub_elt = $elt->first_child("UserName");
        $params->{"username"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt->first_child()->pcdata()));
        $sub_elt = $elt->first_child("Password");
        $params->{"password"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt->first_child()->pcdata()));
        $sub_elt = $elt->first_child("Get");
        @arr = undef;

        if(defined($sub_elt)) {
            my $i = 0;
            do {
                $arr[$i] = $sub_elt->first_child()->pcdata();
                $i++;
                $sub_elt = $sub_elt->next_sibling("Get");
#                print "\n".$sub_e;
            }while(defined($sub_elt));

        }

        $params->{"get"} = \@arr;

       $sub_elt = $elt->first_child("Put");
        my @arr1 = undef;
        my $i= 0;
        while(defined($sub_elt) && defined($sub_elt->first_child()->pcdata())) {
              $arr1[$i++] = $sub_elt->first_child()->pcdata() if defined($sub_elt->first_child()->pcdata());
              $sub_elt = $sub_elt->next_sibling("Put");
        }


        $params->{"put"} = \@arr1;

    }
    return $params;
}

sub get_tcp_params {
    my $self = shift;
    my $type = 0; # 0 is for SIZE
    $type = shift if defined($_[0]);
    my $unaccel = shift if defined($_[0]);
    my $elt = $self->{"ROOT"}->first_child("TCP")->first_child("Accelerated");
    my $params = undef;
    my $sub_elt = undef;
    if(defined($elt)) {
        $params =  {"accelerated" => {}
                   };
        $sub_elt = $elt->first_child("DestIP");
        $params->{"accelerated"}->{"dest_ip"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));
        $sub_elt = $elt->first_child("size");
        $params->{"accelerated"}->{"size"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));
        $sub_elt = $elt->first_child("file");
        $params->{"accelerated"}->{"file"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));
    }
    $elt = $self->{"ROOT"}->first_child("TCP")->first_child("UnAccelerated");
    $params = undef;
    if(defined($elt)) {
        $params->{ "unaccelerated"} = ();

        $sub_elt = $elt->first_child("URL");
        $params->{"unaccelerated"}->{"url"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));
        $sub_elt = $elt->first_child("size");
        $params->{"unaccelerated"}->{"size"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));
    }
    return $params;
}

##############################################################################################
# Arguments : type (Opt) - type of transfer 0 = size and 1 = file Defaults to 0              #
#             vary (Opt) - 0 means No vary & 1 means Vary the UDP traffic. Default is 0      #
#             wait (Opt) - 1 means wait & other for  don't wait. Default is Don't wait.      #
##############################################################################################

sub get_udp_params {
    my $self = shift;
    my $type = 0; # 0 is for SIZE
    $type = shift if defined($_[0]);    # for SIZE or FILE
    my $vary = shift if defined($_[0]);    # for Varying of Transfer
    my $wait = shift if defined($_[0]);    # for Waiting time.

    my $elt = $self->{"ROOT"}->first_child("UDP");
    my $params = undef;

    if(defined($elt)) {
        $params =  {};

        my $sub_elt = undef;
        $sub_elt = $elt->first_child("DestIP");
        $params->{"dest_ip"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));

        $sub_elt = undef;
        $sub_elt = $elt->first_child("size");
        $params->{"size"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));

        $sub_elt = undef;
        $sub_elt = $elt->first_child("file");
        $params->{"file"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));

        $sub_elt = undef;

        $sub_elt = $elt->first_child("Wait") if (defined($wait) && $wait == 1);
        $params->{"wait"} = $sub_elt->first_child()->pcdata() if (defined($sub_elt));

        # if Varation needs to be made in UDP traffic.
        $sub_elt = undef;
        $sub_elt = $elt->first_child("Vary") if (defined($vary) && $vary == 1);
        if(defined($sub_elt)){
            $params->{"vary"}->{"interval"} = $sub_elt->first_child("Interval")->first_child()->pcdata() if (defined($sub_elt->first_child("Interval")->first_child()->pcdata()));
            $params->{"vary"}->{"start"} = $sub_elt->first_child("Start")->first_child()->pcdata() if (defined($sub_elt->first_child("Start")->first_child()->pcdata()));
            $params->{"vary"}->{"load"} = $sub_elt->first_child("Load")->first_child()->pcdata() if (defined($sub_elt->first_child("Load")->first_child()->pcdata()));
        }
   }
   return $params;
}


sub get_session_list {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("Iteration")->first_child("Sessions");
    my @arr = ();
    if(defined($elt)){
        my $i = 0;
        do {
            $arr[$i] = $elt->first_child()->pcdata();
            $i++;
            $elt = $elt->next_sibling();
        }while(defined($elt));
        return @arr;
    }
    return undef;
}

sub get_dr_config_list {
    my $self = shift;
    my $elt = $self->{"ROOT"}->first_child("WanSIM")->first_child("Config");
    my @myArr = ();
    if(defined($elt)) {
        my $i = 0;
        do {
            $myArr[$i] = { "bw" => $elt->first_child("bw")->first_child()->pcdata(),
                           "rtt" => $elt->first_child("rtt")->first_child()->pcdata(),
                           "plr" => $elt->first_child("plr")->first_child()->pcdata()
                     };
            $elt = $elt->next_sibling();
            $i++;
        }while(defined($elt));
        return @myArr;
    }
    return undef;
}


sub parse() {
   my $self = shift;
   my $fileName = shift;

   my $xmlin = XMLin($fileName);
   $self->{'XML_ROOT'} = $xmlin;
   $self->{'XML_FILE_NAME'} = $fileName;
   return 1;
}

sub get_node() {
    my $self = shift;
    my $nodePath = shift;
    my $current_node = $self->{'XML_ROOT'};
    my @arr = split(/\/|\\/,$nodePath);
    print "@arr";
    my $str = "";
    foreach my $ele (@arr) {
       $str = $str."\/$ele";
       $current_node = $current_node->{$ele};
       if(!defined($current_node)) {
         # Required NODE is not available :( so terminate the test here...
           return $current_node;
       }
   }
   return $current_node;
}
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Orbital::XML::Parse - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Orbital::XML::Parse;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Orbital::XML::Parse, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

L<Orbital::XMLRPC>
L<Orbital::Parse>
L<Net::Telnet>

http://www.orbitaldata.com/

=head1 AUTHOR

Sundeep Gupta, E<lt>sundeep.gupta@india.comaE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Applabs Technologies Private Limited.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.4 or,
at your option, any later version of Perl 5 you may have available.


=cut
