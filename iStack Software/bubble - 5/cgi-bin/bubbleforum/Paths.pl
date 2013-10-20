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
$lastdate = "1180718108";                                             ########## Directories ##########

$boardurl = "http://www.bubble.co.in/cgi-bin/bubbleforum";            # URL of your board's folder (without trailing '/')
$boarddir = ".";                                                      # The server path to the board's folder (usually can be left as '.')
$boardsdir = "./Boards";                                              # Directory with board data files
$datadir = "./Messages";                                              # Directory with messages
$memberdir = "./Members";                                             # Directory with member files
$sourcedir = "./Sources";                                             # Directory with YaBB source files
$admindir = "./Admin";                                                # Directory with YaBB admin source files
$vardir = "./Variables";                                              # Directory with variable files
$langdir = "./Languages";                                             # Directory with Language files and folders
$helpfile = "./Help";                                                 # Directory with Help files and folders
$templatesdir = "./Templates";                                        # Directory with template files and folders
$forumstylesdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/yabbfiles/Templates/Forum";
                                                                      # Directory with forum style files and folders
$adminstylesdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/yabbfiles/Templates/Admin";
                                                                      # Directory with admin style files and folders
$htmldir = "/home/httpd/vhosts/bubble.co.in/httpdocs/yabbfiles";      # Base Path for all html/css files and folders
$facesdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/yabbfiles/avatars";
                                                                      # Base Path for all avatar files
$smiliesdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/yabbfiles/Smilies";
                                                                      # Base Path for all smilie files
$modimgdir = "/home/httpd/vhosts/bubble.co.in/httpdocs/yabbfiles/ModImages";
                                                                      # Base Path for all mod images
$uploaddir = "/home/httpd/vhosts/bubble.co.in/httpdocs/yabbfiles/Attachments";
                                                                      # Base Path for all attachment files

########## URL's ##########

$forumstylesurl = "http://www.bubble.co.in/yabbfiles/Templates/Forum";# Default Forum Style Directory
$adminstylesurl = "http://www.bubble.co.in/yabbfiles/Templates/Admin";# Default Admin Style Directory
$ubbcjspath = "http://www.bubble.co.in/yabbfiles/ubbc.js";            # Default Location for the ubbc.js file
$faderpath = "http://www.bubble.co.in/yabbfiles/fader.js";            # Default Location for the fader.js file
$yabbcjspath = "http://www.bubble.co.in/yabbfiles/yabbc.js";          # Default Location for the yabbc.js file
$postjspath = "http://www.bubble.co.in/yabbfiles/post.js";            # Default Location for the post.js file
$html_root = "http://www.bubble.co.in/yabbfiles";                     # Base URL for all html/css files and folders
$facesurl = "http://www.bubble.co.in/yabbfiles/avatars";              # Base URL for all avatar files
$smiliesurl = "http://www.bubble.co.in/yabbfiles/Smilies";            # Base URL for all smilie files
$modimgurl = "http://www.bubble.co.in/yabbfiles/ModImages";           # Base URL for all mod images
$uploadurl = "http://www.bubble.co.in/yabbfiles/Attachments";         # Base URL for all attachment files

1;
