use XML::Generator;

$gen = XML::Generator->new(':pretty');

open(FILE_HANDLE,"FTPPut_9TestCase3.pl.log");
@arr = <FILE_HANDLE>;
@words = split(/\s+/,@arr[8]);
$"="\n";
close(FILE_HANDLE);

print $gen->test_case(
            $gen->name("Bob"),
            $gen->age(34),
            $gen->job({Since=>"300"},"Accountant"),
            $gen->company({name=>"applabs",location=>"Hyderabad",Owner=>"Shashi Reddi"}),
            $gen->age(30)
         );
print $gen->person(
           $gen->name("Sundeep")
           );