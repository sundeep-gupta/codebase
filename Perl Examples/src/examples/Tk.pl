   #!/usr/bin/perl -w
    use Tk;
    use strict;

    my $mw = MainWindow->new;
    $mw->Label(-text => 'Hello, world!')->pack;
    $mw->Button(
        -text    => 'Quit',
        -command => sub { exit },
    )->pack;
    MainLoop;