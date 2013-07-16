#!/usr/bin/perl
my $label_name = $ARGV[0];
my $platform   = 'linux';
my $os         = '-rhel';
my $hostname   = 'stbcn01';
for ($i = 1; $i <= 2; $i++) {
    create_view($i);
    if(fork() == 0) {
        my $t_i = $i;
        print $t_i,"\n";    
        exit 0;
    } 
}

sub create_view {
    my $index = shift;
    my $cmd   = 'ade createview -label ' 
    print `$cmd $test_label ${platform}${os}_${hostname}_lrg$index`;
    # TODO: check if view created successfully

}
sub work {
    my $index = shift;
    $cmd = "ade useview $view_name << TEST
                ln -s /ade_autofs/ade_pledev/unix $ENV{HOME}/regress
                source $ENV{HOME}/regress/setup_mydb$index.csh
                echo oratst -initfile \$ADE_VIEW_ROOT/nde/ade/test/utl/ade_oratst.ini -d testini db_ground
                echo oratst -initfile \$ADE_VIEW_ROOT/nde/ade/test/utl/ade_oratst.ini -d tkmain_<t#> db_testini
                echo lfe results -label $label_name
                
TEST
";
}
