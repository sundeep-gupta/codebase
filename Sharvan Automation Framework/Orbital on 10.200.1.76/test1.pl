#!/usr/bin/perl -w
 
use strict;
# define the subclass
package IdentityParse;
use base "HTML::Parser";
sub text {
     my ($self, $text) = @_;
     # just print out the original text
     print $text;
  }
  
 sub comment {
      my ($self, $comment) = @_;
      # print out original text with comment marker
      print parse_file("http:\/\/www.foo.be\/docs\/tpj\/issues\/vol5_1\/tpj0501-0003.html");