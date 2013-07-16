use Test::Unit::TestRunner;
my $my_test_class = "FooBar";
my $testrunner = Test::Unit::TestRunner->new();
$testrunner->start($my_test_class);

