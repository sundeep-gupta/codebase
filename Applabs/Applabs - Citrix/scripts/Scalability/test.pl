#!/usr/bin/perl
use XMLRPC::Lite;
#use Frontier::Client;
     	my $server_response= XMLRPC::Lite
		  -> proxy("http://localhost/")
		  -> call('RPC.try_this')
		  -> result;
print $server_response;