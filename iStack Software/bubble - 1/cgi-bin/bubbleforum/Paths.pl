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

$boardurl = "http://localhost/cgi-bin/forum";                         # URL of your board's folder (without trailing '/')
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

$forumstylesdir = "D:\bubbleweb\httpdocs/yabbfiles/Templates/Forum";                        # Directory with forum style files and folders
$adminstylesdir = "D:\bubbleweb\httpdocs/yabbfiles/Templates/Admin";                        # Directory with admin style files and folders
$htmldir = "D:\bubbleweb\httpdocs/yabbfiles";                                               # Base Path for all html/css files and folders
$facesdir = "D:\bubbleweb\httpdocs/yabbfiles/avatars";                                      # Base Path for all avatar files
$smiliesdir = "D:\bubbleweb\httpdocs/yabbfiles/smilies";                                    # Base Path for all smilie files
$modimgdir = "D:\bubbleweb\httpdocs/yabbfiles/ModImages";                                   # Base Path for all mod images
$uploaddir = "D:\bubbleweb\httpdocs/yabbfiles/Attachments";                                 # Base Path for all attachment files

########## URL's ##########

$forumstylesurl = "http://localhost/yabbfiles/Templates/Forum";     # Default Forum Style Directory
$adminstylesurl = "http://localhost/yabbfiles/Templates/Admin";     # Default Admin Style Directory
$ubbcjspath     = "http://localhost/yabbfiles/ubbc.js";             # Default Location for the ubbc.js file
$faderpath      = "http://localhost/yabbfiles/fader.js";            # Default Location for the fader.js file
$yabbcjspath    = "http://localhost/yabbfiles/yabbc.js";            # Default Location for the yabbc.js file
$postjspath     = "http://localhost/yabbfiles/post.js";             # Default Location for the post.js file
$html_root      = "http://localhost/yabbfiles";                     # Base URL for all html/css files and folders
$facesurl       = "http://localhost/yabbfiles/avatars";             # Base URL for all avatar files
$smiliesurl     = "http://localhost/yabbfiles/Smilies";             # Base URL for all smilie files
$modimgurl      = "http://localhost/yabbfiles/ModImages";           # Base URL for all mod images
$uploadurl      = "http://localhost/yabbfiles/Attachments";         # Base URL for all attachment files
1;
