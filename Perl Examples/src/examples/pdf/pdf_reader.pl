use strict;
use CAM::PDF;
my $pdf = CAM::PDF->new('D:\test.pdf', '007601517065',  '007601517065', {'prompt_for_password' => 1, 'fault_tolerant' => 1}) or die "Could not create CAM::PDF object : " . $CAM::PDF::errstr;
 my @prefs = $pdf->getPrefs();
        $prefs[$CAM::PDF::PREF_OPASS] = '';
        $prefs[$CAM::PDF::PREF_UPASS] = '';
        $pdf->setPrefs(@prefs);
$pdf->cleanoutput('d:\test2.pdf');
print $pdf->toPDF();

        