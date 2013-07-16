package Orbital::XML::Parse;
sub new() {
    my $self = ();
    shift();
    $self->{XML_FILE} = shift();;
   # if (::DEBUG) {
    #  print "Opening: " . $self->{XML_FILE} . "\n";
#    }
    bless($self);
    return $self;
}
sub parse() {
   my $self = shift;
   my $fileName = shift;

   my $xmlin = XMLin($fileName);
   $self->{'XML_ROOT'} = $xmlin;
   $self->{'XML_FILE_NAME'} = $fileName;
   return 1;
}

sub get_node() {
    $self = shift;
    $nodePath = shift;
    $current_node = $self->{'XML_ROOT'};
    @arr = split(/\/|\\/,$path);
    $str = "";
    foreach $ele (@arr) {
       $str = $str."\/$ele";
       $current_node = $current_node->{$ele};
       if(!defined($current_node)) {
         # Required NODE is not available :( so terminate the test here...
           return $current_node;
       }
   }
   return $current_node;
}

1;