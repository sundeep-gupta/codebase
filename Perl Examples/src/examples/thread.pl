use threads;    

for($x=1;$x<=10;$x++) {
$thr[$x] = threads->new(\&sub1);    

@ReturnData = $thr[$x]->join; 

print "Thread returned @ReturnData";    
}

# Loop through all the threads 
foreach $thr (threads->list) { 
# Don't join the main thread or ourselves 
    if ($thr->tid && !threads::equal($thr, threads->self)) { 
          $thr->join; 
     } 
}



sub sub1 { 

	return "Fifty-six", "foo", 2; 
}