use Tk;
$mw = new MainWindow;

$txt = $mw -> Scrolled('Text',-scrollbars=>"oe") -> pack;
$txt -> insert('end',"Do You Remember When...

A Computer Was Something On TV From A Science Fiction Show
A Window Was Something You Hated To Clean....
And Ram Was The Cousin Of A Goat.....

An Application Was For Employment
A Program Was A TV Show
A Cursor Used Profanity
A Keyboard Was A Piano
 
Compress Was Something You Did To The Garbage
Not Something You Did To A File
And If You Unzipped Anything In Public
You'd Be In Jail For A While

Log On Was Adding Wood To The Fire
Hard Drive Was A Long Trip On The Road
A Mouse Pad Was Where A Mouse Lived
And A Backup Happened To Your Commode

Cut You Did With A Pocket Knife
Paste You Did With Glue
A Web Was A Spider's Home
And A Virus Was The Flu

I Guess I'll Stick To My Pad And Paper
And The Memory In My Head
I Hear Nobody's Been Killed In A Computer Crash
But, When It Happens They Wish They Were Dead");

MainLoop;