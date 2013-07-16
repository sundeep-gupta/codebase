use strict;

my @dir_list = ('.', '..','.ade_path', 'sundeep', '.harsha');

my $regex = /^\.ade_path$/;
foreach my $file (@dir_list) {
	print $file,"\n" unless $file =~ /^(\.|\.\.|\.ade_path)$/;
}

my @new_list = @dir_list  - ( grep(/^(\.|\.\.|\.ade_path)$/, @dir_list));

print @new_list;