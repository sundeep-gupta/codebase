#!/usr/bin/perl
my $max = 0;
my $tot = 0;
my $tot_mem = 0;
my $cnt = 0;
for($i = 0;$i < 60;$i++) {
        my @cpu_lines = `top -d 5 -n 1 | grep -E "orbital_server\|Mem:"`;
#print @cpu_lines;
        # Get memory in kbytes
        my $mem_line = $cpu_lines[0];
        my @mem_fields = split(' ',$mem_line);
        chop($mem_fields[4]);
#       print "Memory: $mem_fields[4]\n";
        my $cpu_line = $cpu_lines[1];
        my @fields = split(' ',$cpu_line);
        $max = ($max>$fields[9]?$max:$fields[9]) if $fields[9];
        $tot +=$fields[9] if $fields[9];
        print "\n".($fields[10]/100*$mem_fields[4]) if $fields[9];
        $tot_mem +=($fields[10]/100*$mem_fields[4]) if $fields[9];
        $cnt++ if $fields[9];

#       syswrite(\*STDOUT, $fields[9]);
        sleep(1)
}
syswrite(\*STDOUT,"\n$cnt");
syswrite(\*STDOUT,"\nMAX - $max\n");
syswrite(\*STDOUT,"Average - ".($tot/$cnt));
syswrite(\*STDOUT,"\nMemory Average - ".($tot_mem/$cnt));



