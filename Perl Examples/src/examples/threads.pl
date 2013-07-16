 use threads ('yield',
                 'stack_size' => 64*4096,
                 'exit' => 'threads_only',
                 'stringify');
use strict;
    sub start_thread {
        my @args = @_;
        print('Thread started: ', join(' ', @args), "\n");
    }
    my $thr = threads->create('start_thread', 'argument');
    $thr->join();

    threads->create(sub { print("I am a thread\n"); })->join();

