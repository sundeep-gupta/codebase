###############################################################################
# SubList.pl                                                                  #
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
#               Your source for web hosting, web design, and domains.         #
###############################################################################

$sublistplver = 'YaBB 2.1 $Revision: 1.1 $';
return 1 if($action eq 'detailedversion');

%director=(
    
    collapse_cat         => "BoardIndex.pl&Collapse_Cat",
    collapse_all         => "BoardIndex.pl&Collapse_All",
    markallasread        => "BoardIndex.pl&MarkAllRead",
    
    smilieput            => "DoSmilies.pl&SmiliePut",
    smilieindex          => "DoSmilies.pl&SmilieIndex",
    next                 => "Display.pl&NextPrev",
    prev                 => "Display.pl&NextPrev",
    setmsn               => "Display.pl&SetMsn",
    setgtalk             => "Display.pl&SetGtalk",
    display              => "Display.pl&Display",
    markunread           => "Display.pl&undumplog",
    threadpagedrop       => "Display.pl&ThreadPageindex",
    threadpagetext       => "Display.pl&ThreadPageindex",
    validate             => "Decoder.pl&convert",
    
    favorites            => "Favorites.pl&Favorites",
    addfav               => "Favorites.pl&AddFav",
    remfav               => "Favorites.pl&RemFav",
    multiremfav          => "Favorites.pl&MultiRemFav",
    
    help                 => "HelpCentre.pl&GetHelpFiles",
    
    deletemultimessages  => "InstantMessage.pl&Del_Some_IM",
    im                   => "InstantMessage.pl&IMIndex",              #done
    imcb                 => "InstantMessage.pl&CallBack",
    imgroups             => "InstantMessage.pl&IMGroups",
    imoutbox             => "InstantMessage.pl&IMIndex",
    imremove             => "InstantMessage.pl&IMRemove",
    imsend               => "InstantMessage.pl&IMPost",
    imsend2              => "InstantMessage.pl&IMPost2",
    imshow               => "InstantMessage.pl&IMShow",
    imstorage            => "InstantMessage.pl&IMIndex",
    imtostore            => "InstantMessage.pl&IMToStore",
    markims              => "InstantMessage.pl&MarkAll",

    login                => "LogInOut.pl&Login",
    login2               => "LogInOut.pl&Login2",
    logout               => "LogInOut.pl&Logout",
    reminder             => "LogInOut.pl&Reminder",
    reminder2            => "LogInOut.pl&Reminder2",
    resetpass            => "LogInOut.pl&Reminder3",
    
    checkboardpw         => "MBCoptions.pl&checkboardpw",
    
    messageindex         => "MessageIndex.pl&MessageIndex",
    markasread           => "MessageIndex.pl&MarkRead",
    messagepagedrop      => "MessageIndex.pl&MessagePageindex",
    messagepagetext      => "MessageIndex.pl&MessagePageindex",
    pages                => "MessageIndex.pl&ListPages",
    
    ml                   => "Memberlist.pl&Ml",
    mlall                => "Memberlist.pl&Ml",
    modify               => "ModifyMessage.pl&ModifyMessage",
    modify2              => "ModifyMessage.pl&ModifyMessage2",
    multidel             => "ModifyMessage.pl&MultiDel",
    movethread           => "MoveTopic.pl&MoveThread",
    movethread2          => "MoveTopic.pl&MoveThread2",
    
    boardnotify          => "Notify.pl&BoardNotify",
    boardnotify2         => "Notify.pl&BoardNotify2",
    boardnotify3         => "Notify.pl&BoardNotify2",
    notify               => "Notify.pl&Notify",
    notify2              => "Notify.pl&Notify2",
    notify3              => "Notify.pl&Notify3",
    notify4              => "Notify.pl&Notify4",
    shownotify           => "Notify.pl&ShowNotifications",    

    print                => "Printpage.pl&Print",
    imprint              => "Printpage.pl&Print_IM",
    profile              => "Profile.pl&ModifyProfile",             #done
    profile2             => "Profile.pl&ModifyProfile2",            #done
    profileAdmin         => "Profile.pl&ModifyProfileAdmin",        #done
    profileAdmin2        => "Profile.pl&ModifyProfileAdmin2",       #done
    profileCheck         => "Profile.pl&ProfileCheck",              #done
    profileCheck2        => "Profile.pl&ProfileCheck2",             #done
    profileContacts      => "Profile.pl&ModifyProfileContacts",     #done
    profileContacts2     => "Profile.pl&ModifyProfileContacts2",    #done
    profileIM            => "Profile.pl&ModifyProfileIM",           #done
    profileIM2           => "Profile.pl&ModifyProfileIM2",          #done
    profileOptions       => "Profile.pl&ModifyProfileOptions",      #done
    profileOptions2      => "Profile.pl&ModifyProfileOptions2",     #done
    usersrecentposts     => "Profile.pl&usersrecentposts",          #done
    viewprofile          => "Profile.pl&ViewProfile",               #done
    msn                  => "Profile.pl&MSN",
    post                 => "Post.pl&Post",                         #done
    post2                => "Post.pl&Post2",
    lockpoll             => "Poll.pl&LockPoll",    
    undovote             => "Poll.pl&UndoVote",
    vote                 => "Poll.pl&DoVote",    
    showvoters           => "Poll.pl&votedetails",

    activate             => "Register.pl&user_activation",
    recent               => "Recent.pl&RecentPosts",
    recentlist           => "Recent.pl&RecentTopicsList",
    register             => "Register.pl&Register",
    register2            => "Register.pl&Register2",
    removethread         => "RemoveTopic.pl&DeleteThread",
    multiadmin           => "RemoveTopic.pl&Multi",
    
    dereferer            => "Subs.pl&Dereferer",
    mailto               => "Subs.pl&MailTo",
    memberpagedrop       => "Subs.pl&MemberPageindex",
    memberpagetext       => "Subs.pl&MemberPageindex",
    revalidatesession    => "Sessions.pl&SessionReval",
    revalidatesession2   => "Sessions.pl&SessionReval2",
    
    search               => "Search.pl&plushSearch1",              # done
    search2              => "Search.pl&plushSearch2",              # done
    
    sendtopic            => "SendTopic.pl&SendTopic",
    sendtopic2           => "SendTopic.pl&SendTopic2",
    splice               => "SplitSplice.pl&Splice",
    splice2              => "SplitSplice.pl&Splice2",
    split                => "SplitSplice.pl&Split",
    split2               => "SplitSplice.pl&Split2",
    sticky               => "SetStatus.pl&SetStatus",
    hide                 => "SetStatus.pl&SetStatus",
    lock                 => "SetStatus.pl&SetStatus",
);

1;