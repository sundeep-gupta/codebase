#/usr/bin/env perl
package Bubble::FileUtils;
use strict;
use File::Find;
use File::Copy;
use Digest::MD5;


=head1 SYNOPSIS

Bubble::FileUtils - Utility methods to work on files.

=head1 Methods

=head2 change_extension 

Changes the extension of all files under the given directory

=over 12

=item C<dir>

Directory under which all file's extension has to be changed.

=item C<extn>

Extension to be added to all files (without '.').

=item C<recursive> :

Whether files under subdirectories has to be changed or not.

=item C<B<return>> :

C<undef> on failure. C<1> on success.

=back

=cut

sub change_extension {
    my ($dir, $extn, $recursive) = @_;
    return undef unless ($dir or not -d $dir);
    return undef unless $extn;
    $recursive = 0 unless $recursive;
    
    opendir my $dh, $dir;
    my @files = readdir($dh);;
    closedir $dh;
    foreach my $file (@files) {
        &File::Copy::move("$dir/$file","$dir/$file.$extn") if -f $dir.'/'. $file ;
    }


    ##########################################################
    # my $rh_map = {};
    # my $i = 1;
    # &File::Find::find( { 'no_chdir' => 1, 
    #              'wanted' => sub { 
    #         print $File::Find::name; print "\n";
    #         return unless -f $File::Find::name;
    #         $rh_map->{$File::Find::name} = "$dir/file-$i.flv" ;
    #         $i++;
    #    }}, $dir);

    # foreach my $src ( keys %$rh_map) {
    #      `mv '$src' '$rh_map->{$src}'`;
    # }
    ##########################################################
}

=head2 get_missing_files

Reads a file containing the list of files to be looked for and creates
an array containing list of files which are not existing in the file system.

B<TODO> : Enhance the function to take 'array' or 'filename' and should work for both.

=over 12

=item file 

File which has the list of files to be verified (One file in each line).

=item return 

A list of files (array reference) which are not present in file system.

=back

=cut

sub get_missing_files {
    my ($file) = shift;
    return undef if not $file or not -e $file;

    open (my $fh, "$file"); 
    return undef if not $fh;

    my @l_files = <$fh>;
    chomp @l_files;
    close $fh;
    my $ra_missing_files = [];
    foreach my $file (@l_files) {
        $file =~ s/^\s+//; $file =~ s/\s+$//;
        if ($file and $file ne '' and not -e $file) {
            push(@$ra_missing_files, $file);
        }
    }
    return $ra_missing_files;
}


=head2 folder_diff

Use this method when you want to do a diff on two directories. This function will give you detailed report
on which file is missing, which new files are added, what files contents are changed, files whose owner is different
files whose group is different.

=over 12 

=item param

The named parameters as below

o C<dir1> : represents the first directory under comparison.

o C<dir1> : represents the direcotry with which the comparison is done.

o C<perm> : Whether to check permissions or not (optional. default is false.)

o C<owner> : Whether to compare owners of file or not (default is 'no')

o C<group> : Whether to compare group of file or not (default is 'no')

=back

=cut
sub folder_diff {
    my $param = shift;
    my $dir_files = {};
    &File::Find::find( { 
        wanted => sub {
    my $file = $File::Find::name;
    my $dir = $File::Find::topdir;
    $file =~ s/^$dir//;
    $file =~ s/^\///;
    return unless $file;
    unless($dir_files->{$dir}) {
        $dir_files->{$dir} = {};
    }
    $dir_files->{$dir}->{$file}= {};
    if (-f $File::Find::name) {
        my ($mode, $uid, $gid, $size) = (stat $File::Find::name)[3,4,5,7];
        $dir_files->{$dir}->{$file}->{'perm'} = &Stat::lsMode::file_mode($File::Find::name) if ($param->{'perm'}); 
        $dir_files->{$dir}->{$file}->{'owner'}  = (getpwuid($uid))[0] if($param->{'owner'}); 
        $dir_files->{$dir}->{$file}->{'group'}  = (getgrgid($gid))[0] if($param->{'group'});
        $dir_files->{$dir}->{$file}->{'md5'} = get_md5($File::Find::name);
    }
},
        no_chdir => 1,
    }, ($param->{'dir1'}, $param->{'dir2'}));
    my $rh_report = &compare($dir_files);
    return $rh_report;
}
sub print_report {
    my $rh_report = shift;
    my $rh_options = shift;

    my $diff_perm = $rh_options->{'perm'};
    my $diff_owner = $rh_options->{'owner'};
    my $diff_group = $rh_options->{'group'};
    my $diff_content = $rh_options->{'md5'};
    my $diff_new = $rh_report->{'new'};
    my $diff_missing = $rh_report->{'missing'};
    &print_diff($diff_content, 'Total files mismatching with content  : ');
    &print_diff($diff_perm, 'Total files mismatching with permissions : ') if $diff_perm;
    &print_diff($diff_owner, 'Total files mismatching with owner : ') if $diff_owner;
    &print_diff($diff_group, 'Total files mismatching with group : ') if $diff_group;
    &print_file_info($diff_missing, 'Files missing in directory : '. $rh_options->{'dir2'}, $rh_options);
    &print_file_info($diff_new, 'New files in directory : '. $rh_options->{'dir2'}, $rh_options);

}

sub print_file_info {
    my $rh_files = shift;
    my $msg = shift;
    my $rh_options = shift;


    print $msg ." : " . scalar (keys (%$rh_files)) ."\n";
    print "=" x 120 ;
    print "\n";
    if (scalar keys %$rh_files) {
        for my $file (keys %$rh_files) {
           print $file . " : " .
                   $rh_files->{$file}->{'md5'};
           print " : " . $rh_files->{$file}->{'perm'} if $rh_options->{'perm'};
           print " : " . $rh_files->{$file}->{'owner'} if $rh_options->{'owner'};
           print " : " . $rh_files->{$file}->{'group'} if $rh_options->{'group'};
           print "\n";
       }
    }
    print "\n";


}

sub print_diff {
    my $rh_diff = shift;
    my $msg = shift;
    print $msg  . scalar (keys (%$rh_diff )) . "\n";
    if (scalar keys %$rh_diff) {
        for my $file (keys %$rh_diff) {
            print "$file : " . $rh_diff->{$file}->{'old'} . " : " . $rh_diff->{$file}->{'new'} ."\n";
        }
    }
    print "\n";
}


sub compare {
    my $rh_dirs = shift;
    my $rh_options = shift;
    unless (scalar keys(%$rh_dirs) == 2) {
        print "Only 2 entries I can compare\n";
        return undef;
    };
    my ($dir1, $dir2) = keys(%$rh_dirs);

    # Compare common files of both
    my $rh_common = { 'perm' => {},
            'owner' => {},
            'group' => {},
            'md5' => {},
            'new' => {},
            'missing' => {},
    };

    for my $file ( keys %{$rh_dirs->{$dir1}} ) {
        if($rh_dirs->{$dir2}->{$file}) {
            # These are directory entries 
            next unless (scalar keys %{$rh_dirs->{$dir1}->{$file}});
            $rh_common->{'md5'}->{$file} = {
                    'old' => $rh_dirs->{$dir1}->{$file}->{'md5'},
                    'new' => $rh_dirs->{$dir2}->{$file}->{'md5'},
            } if $rh_dirs->{$dir1}->{$file}->{'md5'} ne $rh_dirs->{$dir2}->{$file}->{'md5'};

            $rh_common->{'perm'}->{$file} = {
                    'old' => $rh_dirs->{$dir1}->{$file}->{'perm'},
                    'new' => $rh_dirs->{$dir2}->{$file}->{'perm'},
            } if $rh_options->{'perm'} and $rh_dirs->{$dir1}->{$file}->{'perm'} ne $rh_dirs->{$dir2}->{$file}->{'perm'};;

            $rh_common->{'owner'}->{$file} = {
                    'old' => $rh_dirs->{$dir1}->{$file}->{'owner'},
                    'new' => $rh_dirs->{$dir2}->{$file}->{'owner'},
            } if $rh_options->{'owner'} and $rh_dirs->{$dir1}->{$file}->{'owner'} ne $rh_dirs->{$dir2}->{$file}->{'owner'};;

            $rh_common->{'group'}->{$file} = {
                    'old' => $rh_dirs->{$dir1}->{$file}->{'group'},
                    'new' => $rh_dirs->{$dir2}->{$file}->{'group'},
            } if $rh_options->{'group'} and $rh_dirs->{$dir1}->{$file}->{'group'} ne $rh_dirs->{$dir2}->{$file}->{'group'};;


        } else {
            $rh_common->{'missing'}->{$file} = $rh_dirs->{$dir1}->{$file};
        }
        delete $rh_dirs->{$dir1}->{$file};
        delete $rh_dirs->{$dir2}->{$file};
    }

    for my $file ( keys %{$rh_dirs->{$dir2}} ) {
        next unless (scalar keys %{$rh_dirs->{$dir2}->{$file}});
        $rh_common->{'new'}->{$file} = $rh_dirs->{$dir2}->{$file};
    }
    return $rh_common;
}


sub get_md5 {
    my $file = shift;
    open(my $fh, $file );
    unless($fh) {
        warn "Failed : ". $file ."\n";
        return undef;
    }
    binmode($fh);
    my $md5_obj = Digest::MD5->new();
    while(<$fh>) {
        $md5_obj->add($_);
    }
    close($fh);
    return $md5_obj->hexdigest;
}




1;
=head1 AUTHOR

Sundeep - L<mailto:sundeep.techie@gmail.com>

=head1 COPYRIGHT

Copyright (C) 2007, 2011, Bubble Inc.,  All rights reserved.
=cut
