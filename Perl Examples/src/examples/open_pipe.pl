#!/usr/bin/perl

open(FH, "| sh << TEST
ls -l 
ade
TEST
");
close(FH);
