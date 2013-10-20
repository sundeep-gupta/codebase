use Win32::NetResource qw(:DEFAULT GetSharedResources GetError NetShareDel NetShareAdd);

my $ShareInfo = {
					'path' => "c:\\tshare",
					'netname' => "tshare",
					'remark' => "It is good to share",
					'passwd' => "",
					'current-users' =>0,
					'permissions' => 0,
					'maxusers' => -1,
					'type'  => 0,
				    };
    
	if (Win32::NetResource::NetShareAdd( $ShareInfo, $parm )) {
		open(FH,">c:/out.txt");
		print FH "Added";
		close(FH);
		exit 0;
	}else {
		exit 1;
	}

