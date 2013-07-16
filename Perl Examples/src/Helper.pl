#!/usr/bin/perl -w
use strict;
my $template_file = "UnitTestTmpl.java";
my ($source, $target, $package) = @ARGV;
unless(validate_arguments(@ARGV)) {
    print "Usage : $0 <src> <tests> <package>\n";
	exit;
}
my $package_dir = $package; $package_dir =~ s/\./\//g;
print "Package dir : $package_dir\n";
my $rh_src_files = {};
use File::Find;
&File::Find::find({ wanted => sub {
    next unless $_ =~ /\.java$/;
    my $class = $_;
	$class =~ s/\.java$//;
	$package = $File::Find::dir;
	$package =~ s/(.*\/)$package_dir/$package_dir/;
	my $test_class_dir = "$target/$package";
	$package =~ s/\//./g;
	$package =~ s/\.$//;
	$rh_src_files->{$class} = { 'path' => $File::Find::name,
	                            'package' => $package,
								'unittestdir' => $test_class_dir
							};
}}, "$source/$package_dir");

use Data::Dumper;
print Dumper($rh_src_files);

open(my $fh, $template_file);
my @tmpl = <$fh>; my $tmpl = join('',@tmpl);
close $fh;
foreach my $class (keys %$rh_src_files) {
   # Replace PACKAGE_NAME with package
    my $unit_test_class_name = $class."UnitTests";
	my $unit_test_content = $tmpl;
	my $package_name = $rh_src_files->{$class}->{'package'};
	$unit_test_content =~ s/package PACKAGE_NAME;/package $package_name;/sg;
	$unit_test_content =~ s/\bUNIT_TEST_CLASS_NAME\b/$unit_test_class_name/sg;
	$unit_test_content =~ s/\bCLASS_NAME\b/$class/sg;

	# Replacement done. Lets now Write the file.
	my $unit_test_dir = $rh_src_files->{$class}->{'unittestdir'};
	`mkdir -p $unit_test_dir` unless (-d $unit_test_dir);
    open(my $fh, ">$unit_test_dir/$unit_test_class_name.java");
	print $fh $unit_test_content;
	close $fh;
}

sub validate_arguments {
    my ($source, $target, $package) = @_;
    $package =~ s/\./\//g if $package;
    return ( ($source and ($source =~ /main$/) and (-d $source)) and 
	         ($target and ($target =~ /tests$/) and (-d $target)) and 
			 ($package) and (-d "$source/$package")
			 );
}

