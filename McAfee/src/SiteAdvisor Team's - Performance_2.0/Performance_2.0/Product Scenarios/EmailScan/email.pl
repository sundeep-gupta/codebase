use strict;
use Win32::OLE;
use Win32::OLE::Variant;
use Win32::OLE::Const 'Microsoft Outlook';

# use existing instance if Outlook is already running, or launce a new one
my $ol;
eval {$ol = Win32::OLE->GetActiveObject('Outlook.Application')};
die "Outlook not installed" if $@;
unless (defined $ol) {
  $ol = Win32::OLE->new('Outlook.Application', sub {$_[0]->Quit;})
    or die "Oops, cannot start Outlook";
}

#my $mailbox = seekFolder($ol->Session, 'Mailbox - Hanson, Robert');
my $inbox = seekFolder($ol->Session, 'Inbox');
my $folder = seekFolder($ol->Session, 'Inbox');

for (my $i = 1; $i <= $folder->Items->Count; $i++) {
  print $folder->Items->Item($i)->SenderName . ":";
  print $folder->Items->Item($i)->Subject . "\n";
  print $folder->Items->Item($i)->Body . "\n";
}

sub seekFolder {
  my $obj = shift;
  my $target = shift;

  for (my $i = 1; $i <= $obj->Folders->Count; $i++) {
    if ( $obj->Folders->Item($i)->Name eq $target ) {
      return $obj->Folders->Item($i);
    }
  }
}
