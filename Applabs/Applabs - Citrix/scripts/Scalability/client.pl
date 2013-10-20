#!/usr/bin/perl
use XMLRPC::Lite;
use WANScaler::Client::Scalability::Config;


# read config file for constant values;

# Read the List of servers [remote machines] from file.
my @ip_list = get_ip_list(IP_LIST_FILE);

# Read list of actions to be performed from action file
my $action_ref = get_actions(ACTION_FILE);

# For each machine start a thread which must do all the actions in sequence

# If order is parallel then do the operation in Parallel...[ rather than sequence]



#use Frontier::Client;
#     	my $server_response= XMLRPC::Lite
#		  -> proxy("http://localhost/")
#		  -> call('RPC.try_this')
#		  -> result;
sub get_ip_list {
	my $file_name = shift;
	syswrite \*STDOUT,'TODO: IP List'.$file_name;
#	syswrite \*STDOUT, $server_response;
}

sub get_actions {
	my $file_name = shift;
    syswrite \*STDOUT, 'TODO: Actions'.$file_name;
}