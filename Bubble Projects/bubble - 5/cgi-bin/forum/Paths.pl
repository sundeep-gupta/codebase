###############################################################################
# Paths.pl                                                                    #
###############################################################################
# YaBB: Yet another Bulletin Board                                            #
# Open-Source Community Software for Webmasters                               #
# Version:        YaBB 2.1                                                    #
# Released:       November 8, 2005                                            #
# Distributed by: http://www.yabbforum.com                                    #
# =========================================================================== #
# Copyright (c) 2000-2005 YaBB (www.yabbforum.com) - All Rights Reserved.     #
# Software by: The YaBB Development Team                                      #
#              with assistance from the YaBB community.                       #
# Sponsored by: Xnull Internet Media, Inc. - http://www.ximinc.com            #
###############################################################################

$lastsaved = "YaBB Administrator";
$lastdate = "1190831054";                                             ########## Directories ##########

$boardurl = "http://www.bubble.co.in/cgi-bin/forum";                         # URL of your board's folder (without trailing '/')
$boarddir = ".";                                                      # The server path to the board's folder (usually can be left as '.')
$boardsdir = "./boards";                                              # Directory with board data files
$datadir = "./messages";                                              # Directory with messages
$memberdir = "./members";                                             # Directory with member files
$sourcedir = "./sources";                                             # Directory with YaBB source files
$admindir = "./admin";                                                # Directory with YaBB admin source files
$vardir = "./variables";                                              # Directory with variable files
$langdir = "./languages";                                             # Directory with Language files and folders
$helpfile = "./help";                                                 # Directory with Help files and folders
$templatesdir = "./templates";                                        # Directory with template files and folders

$forumstylesdir = ""/home/httpd/vhosts/bubble.co.in/httpdocs/~forum/Templates/Forum";                        # Directory with forum style files and folders
$adminstylesdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/~forum/Templates/Admin";                        # Directory with admin style files and folders
$htmldir = "/home/httpd/vhosts/bubble.co.in/httpdocs/~forum";                                               # Base Path for all html/css files and folders
$facesdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/~forum/avatars";                         # Base Path for all avatar files
$smiliesdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/~forum/smilies";                                    # Base Path for all smilie files
$modimgdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/~forum/ModImages";                                   # Base Path for all mod images
$uploaddir = "/home/httpd/vhosts/bubble.co.in/httpdocs/~forum/Attachments";                                 # Base Path for all attachment files

########## URL's ##########

$forumstylesurl = "http://www.bubble.co.in/~forum/Templates/Forum";     # Default Forum Style Directory
$adminstylesurl = "http://www.bubble.co.in/~forum/Templates/Admin";     # Default Admin Style Directory
$ubbcjspath     = "http://www.bubble.co.in/~forum/ubbc.js";             # Default Location for the ubbc.js file
$faderpath      = "http://www.bubble.co.in/~forum/fader.js";            # Default Location for the fader.js file
$yabbcjspath    = "http://www.bubble.co.in/~forum/yabbc.js";            # Default Location for the yabbc.js file
$postjspath     = "http://www.bubble.co.in/~forum/post.js";             # Default Location for the post.js file
$html_root      = "http://www.bubble.co.in/~forum";                     # Base URL for all html/css files and folders
$facesurl       = "http://www.bubble.co.in/~forum/avatars";             # Base URL for all avatar files
$smiliesurl     = "http://www.bubble.co.in/~forum/Smilies";             # Base URL for all smilie files
$modimgurl      = "http://www.bubble.co.in/~forum/ModImages";           # Base URL for all mod images
$uploadurl      = "http://www.bubble.co.in/~forum/Attachments";         # Base URL for all attachment files
1;
