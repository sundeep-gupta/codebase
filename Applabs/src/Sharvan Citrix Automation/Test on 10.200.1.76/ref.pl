my @l=("We","are","together");

my $l_ref=\@l;

#print @{$l_ref}[1];

my %h=(
	"Name"=>"Sharvan",
	"Age"=>29,
	"Nationality"=>"Indian"
      );

my $h_ref=\%h;

print ${$h_ref}{Name};