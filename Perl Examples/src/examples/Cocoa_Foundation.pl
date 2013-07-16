#!/usr/bin/perl

use Foundation;

# These are the lines we care about:These
$s1 = NSString->stringWithCString_("Hello ");
$s2 = NSString->alloc()->initWithCString_("World");
$s3 = $s1->stringByAppendingString_($s2);
printf "%s\n", $s3->UTF8String();

$s2->release();

$file = "/Library/Preferences/SystemConfiguration/preferences.plist";
$plist = NSDictionary->dictionaryWithContentsOfFile_( $file );
print $plist->description()->UTF8String() . "\n";


