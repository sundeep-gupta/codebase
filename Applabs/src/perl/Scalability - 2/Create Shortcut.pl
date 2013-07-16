#!/usr/bin/perl
# This code creates a shortcut.

# ---------------------------------------------------------------
# Adapted from VBScript code contained in the book:
#      "Windows Server Cookbook" by Robbie Allen
# ISBN: 0-596-00633-0
# ---------------------------------------------------------------

use Win32::OLE;
$Win32::OLE::Warn = 3;

$objWSHShell = Win32::OLE->new('WScript.Shell');

# Pass the path to the shortcut
$objSC = $objWSHShell->CreateShortcut('d:\\mylog.lnk');

# Description - Description of the shortcut
$objSC->{Description} = 'Shortcut to MyLog file';

# HotKey – hot key sequence to launch the shortcut
$objSC->{HotKey} = 'CTRL+ALT+SHIFT+X';

# IconLocation – Path of icon to use for the shortcut file
$objSC->{IconLocation} = 'notepad.exe, 0';
# 0 is the index

# TargetPath = Path to source file or folder
$objSC->{TargetPath} = 'c:\\windows\\notepad.exe';

# Arguments – Any additional parameters to pass to TargetPath
$objSC->{Arguments} = 'c:\\mylog.txt';

# WindowStyle – Type of window to create
$objSC->{WindowStyle} = 1;
# 1 = normal; 3 = maximize window; 7 = minimize

# WorkingDirectory – Location of the working directory for the source app
$objSC->{WorkingDirectory} = 'c:\\';
$objSC->Save();
print "Shortcut to mylog created\n";
