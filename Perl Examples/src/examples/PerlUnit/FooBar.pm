   package FooBar;
    use base qw(Test::Unit::TestCase);

    sub new {
        my $self = shift()->SUPER::new(@_);
        # your state for fixture here
        return $self;
    }

    sub set_up {
        # provide fixture
    }
    sub tear_down {
        # clean up after test
    }
    sub test_foo {
        my $self = shift;
		my $obj = undef;
  #      $self->assert_not_null($obj);
		$obj = {'foo' => 'expected result', 'foobar' => 'pattern'} ; 
        $self->assert_equals('expected result', $obj->{'foo'});
        $self->assert(qr/pattern/, $obj->{'foobar'});
    }
    sub test_bar {
        # test the bar feature
    }
1;
