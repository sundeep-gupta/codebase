<?php

/* SELECT image_name, image_filename, image_lang, image_height, image_width FROM bubb_styles_imageset_data WHERE imageset_id = 2 AND image_filename <> '' AND image_lang IN ('en', '') */

$expired = (time() > 1234236820) ? true : false;
if ($expired) { return; }

$this->sql_rowset[$query_id] = unserialize('a:81:{i:0;a:5:{s:10:"image_name";s:9:"site_logo";s:14:"image_filename";s:13:"site_logo.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"94";s:11:"image_width";s:3:"170";}i:1;a:5:{s:10:"image_name";s:10:"upload_bar";s:14:"image_filename";s:14:"upload_bar.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"16";s:11:"image_width";s:3:"280";}i:2;a:5:{s:10:"image_name";s:9:"poll_left";s:14:"image_filename";s:13:"poll_left.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"12";s:11:"image_width";s:1:"4";}i:3;a:5:{s:10:"image_name";s:11:"poll_center";s:14:"image_filename";s:15:"poll_center.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"12";s:11:"image_width";s:1:"0";}i:4;a:5:{s:10:"image_name";s:10:"poll_right";s:14:"image_filename";s:14:"poll_right.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"12";s:11:"image_width";s:1:"4";}i:5;a:5:{s:10:"image_name";s:10:"forum_link";s:14:"image_filename";s:14:"forum_link.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"25";s:11:"image_width";s:2:"46";}i:6;a:5:{s:10:"image_name";s:10:"forum_read";s:14:"image_filename";s:14:"forum_read.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"25";s:11:"image_width";s:2:"46";}i:7;a:5:{s:10:"image_name";s:17:"forum_read_locked";s:14:"image_filename";s:21:"forum_read_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"25";s:11:"image_width";s:2:"46";}i:8;a:5:{s:10:"image_name";s:19:"forum_read_subforum";s:14:"image_filename";s:23:"forum_read_subforum.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"25";s:11:"image_width";s:2:"46";}i:9;a:5:{s:10:"image_name";s:12:"forum_unread";s:14:"image_filename";s:16:"forum_unread.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"25";s:11:"image_width";s:2:"46";}i:10;a:5:{s:10:"image_name";s:19:"forum_unread_locked";s:14:"image_filename";s:23:"forum_unread_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"25";s:11:"image_width";s:2:"46";}i:11;a:5:{s:10:"image_name";s:21:"forum_unread_subforum";s:14:"image_filename";s:25:"forum_unread_subforum.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"25";s:11:"image_width";s:2:"46";}i:12;a:5:{s:10:"image_name";s:11:"topic_moved";s:14:"image_filename";s:15:"topic_moved.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:13;a:5:{s:10:"image_name";s:10:"topic_read";s:14:"image_filename";s:14:"topic_read.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:14;a:5:{s:10:"image_name";s:15:"topic_read_mine";s:14:"image_filename";s:19:"topic_read_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:15;a:5:{s:10:"image_name";s:14:"topic_read_hot";s:14:"image_filename";s:18:"topic_read_hot.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:16;a:5:{s:10:"image_name";s:19:"topic_read_hot_mine";s:14:"image_filename";s:23:"topic_read_hot_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:17;a:5:{s:10:"image_name";s:17:"topic_read_locked";s:14:"image_filename";s:21:"topic_read_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:18;a:5:{s:10:"image_name";s:22:"topic_read_locked_mine";s:14:"image_filename";s:26:"topic_read_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:19;a:5:{s:10:"image_name";s:12:"topic_unread";s:14:"image_filename";s:16:"topic_unread.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:20;a:5:{s:10:"image_name";s:17:"topic_unread_mine";s:14:"image_filename";s:21:"topic_unread_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:21;a:5:{s:10:"image_name";s:16:"topic_unread_hot";s:14:"image_filename";s:20:"topic_unread_hot.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:22;a:5:{s:10:"image_name";s:21:"topic_unread_hot_mine";s:14:"image_filename";s:25:"topic_unread_hot_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:23;a:5:{s:10:"image_name";s:19:"topic_unread_locked";s:14:"image_filename";s:23:"topic_unread_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:24;a:5:{s:10:"image_name";s:24:"topic_unread_locked_mine";s:14:"image_filename";s:28:"topic_unread_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:25;a:5:{s:10:"image_name";s:11:"sticky_read";s:14:"image_filename";s:15:"sticky_read.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:26;a:5:{s:10:"image_name";s:16:"sticky_read_mine";s:14:"image_filename";s:20:"sticky_read_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:27;a:5:{s:10:"image_name";s:18:"sticky_read_locked";s:14:"image_filename";s:22:"sticky_read_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:28;a:5:{s:10:"image_name";s:23:"sticky_read_locked_mine";s:14:"image_filename";s:27:"sticky_read_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:29;a:5:{s:10:"image_name";s:13:"sticky_unread";s:14:"image_filename";s:17:"sticky_unread.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:30;a:5:{s:10:"image_name";s:18:"sticky_unread_mine";s:14:"image_filename";s:22:"sticky_unread_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:31;a:5:{s:10:"image_name";s:20:"sticky_unread_locked";s:14:"image_filename";s:24:"sticky_unread_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:32;a:5:{s:10:"image_name";s:25:"sticky_unread_locked_mine";s:14:"image_filename";s:29:"sticky_unread_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:33;a:5:{s:10:"image_name";s:13:"announce_read";s:14:"image_filename";s:17:"announce_read.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:34;a:5:{s:10:"image_name";s:18:"announce_read_mine";s:14:"image_filename";s:22:"announce_read_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:35;a:5:{s:10:"image_name";s:20:"announce_read_locked";s:14:"image_filename";s:24:"announce_read_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:36;a:5:{s:10:"image_name";s:25:"announce_read_locked_mine";s:14:"image_filename";s:29:"announce_read_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:37;a:5:{s:10:"image_name";s:15:"announce_unread";s:14:"image_filename";s:19:"announce_unread.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:38;a:5:{s:10:"image_name";s:20:"announce_unread_mine";s:14:"image_filename";s:24:"announce_unread_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:39;a:5:{s:10:"image_name";s:22:"announce_unread_locked";s:14:"image_filename";s:26:"announce_unread_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:40;a:5:{s:10:"image_name";s:27:"announce_unread_locked_mine";s:14:"image_filename";s:31:"announce_unread_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:41;a:5:{s:10:"image_name";s:11:"global_read";s:14:"image_filename";s:17:"announce_read.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:42;a:5:{s:10:"image_name";s:16:"global_read_mine";s:14:"image_filename";s:22:"announce_read_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:43;a:5:{s:10:"image_name";s:18:"global_read_locked";s:14:"image_filename";s:24:"announce_read_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:44;a:5:{s:10:"image_name";s:23:"global_read_locked_mine";s:14:"image_filename";s:29:"announce_read_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:45;a:5:{s:10:"image_name";s:13:"global_unread";s:14:"image_filename";s:19:"announce_unread.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:46;a:5:{s:10:"image_name";s:18:"global_unread_mine";s:14:"image_filename";s:24:"announce_unread_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:47;a:5:{s:10:"image_name";s:20:"global_unread_locked";s:14:"image_filename";s:26:"announce_unread_locked.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:48;a:5:{s:10:"image_name";s:25:"global_unread_locked_mine";s:14:"image_filename";s:31:"announce_unread_locked_mine.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:49;a:5:{s:10:"image_name";s:7:"pm_read";s:14:"image_filename";s:14:"topic_read.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:50;a:5:{s:10:"image_name";s:9:"pm_unread";s:14:"image_filename";s:16:"topic_unread.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:51;a:5:{s:10:"image_name";s:16:"icon_post_target";s:14:"image_filename";s:20:"icon_post_target.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:1:"9";s:11:"image_width";s:2:"12";}i:52;a:5:{s:10:"image_name";s:23:"icon_post_target_unread";s:14:"image_filename";s:27:"icon_post_target_unread.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:1:"9";s:11:"image_width";s:2:"12";}i:53;a:5:{s:10:"image_name";s:17:"icon_topic_attach";s:14:"image_filename";s:21:"icon_topic_attach.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"14";}i:54;a:5:{s:10:"image_name";s:17:"icon_topic_latest";s:14:"image_filename";s:21:"icon_topic_latest.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:1:"9";s:11:"image_width";s:2:"18";}i:55;a:5:{s:10:"image_name";s:17:"icon_topic_newest";s:14:"image_filename";s:21:"icon_topic_newest.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:1:"9";s:11:"image_width";s:2:"18";}i:56;a:5:{s:10:"image_name";s:19:"icon_topic_reported";s:14:"image_filename";s:23:"icon_topic_reported.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:57;a:5:{s:10:"image_name";s:21:"icon_topic_unapproved";s:14:"image_filename";s:25:"icon_topic_unapproved.gif";s:10:"image_lang";s:0:"";s:12:"image_height";s:2:"18";s:11:"image_width";s:2:"19";}i:58;a:5:{s:10:"image_name";s:16:"icon_contact_aim";s:14:"image_filename";s:20:"icon_contact_aim.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:59;a:5:{s:10:"image_name";s:18:"icon_contact_email";s:14:"image_filename";s:22:"icon_contact_email.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:60;a:5:{s:10:"image_name";s:16:"icon_contact_icq";s:14:"image_filename";s:20:"icon_contact_icq.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:61;a:5:{s:10:"image_name";s:19:"icon_contact_jabber";s:14:"image_filename";s:23:"icon_contact_jabber.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:62;a:5:{s:10:"image_name";s:17:"icon_contact_msnm";s:14:"image_filename";s:21:"icon_contact_msnm.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:63;a:5:{s:10:"image_name";s:15:"icon_contact_pm";s:14:"image_filename";s:19:"icon_contact_pm.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:64;a:5:{s:10:"image_name";s:18:"icon_contact_yahoo";s:14:"image_filename";s:22:"icon_contact_yahoo.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:65;a:5:{s:10:"image_name";s:16:"icon_contact_www";s:14:"image_filename";s:20:"icon_contact_www.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:66;a:5:{s:10:"image_name";s:16:"icon_post_delete";s:14:"image_filename";s:20:"icon_post_delete.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:67;a:5:{s:10:"image_name";s:14:"icon_post_edit";s:14:"image_filename";s:18:"icon_post_edit.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:68;a:5:{s:10:"image_name";s:14:"icon_post_info";s:14:"image_filename";s:18:"icon_post_info.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:69;a:5:{s:10:"image_name";s:15:"icon_post_quote";s:14:"image_filename";s:19:"icon_post_quote.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:70;a:5:{s:10:"image_name";s:16:"icon_post_report";s:14:"image_filename";s:20:"icon_post_report.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:71;a:5:{s:10:"image_name";s:16:"icon_user_online";s:14:"image_filename";s:20:"icon_user_online.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:72;a:5:{s:10:"image_name";s:17:"icon_user_offline";s:14:"image_filename";s:21:"icon_user_offline.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:73;a:5:{s:10:"image_name";s:17:"icon_user_profile";s:14:"image_filename";s:21:"icon_user_profile.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:74;a:5:{s:10:"image_name";s:16:"icon_user_search";s:14:"image_filename";s:20:"icon_user_search.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:75;a:5:{s:10:"image_name";s:14:"icon_user_warn";s:14:"image_filename";s:18:"icon_user_warn.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:76;a:5:{s:10:"image_name";s:13:"button_pm_new";s:14:"image_filename";s:17:"button_pm_new.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:77;a:5:{s:10:"image_name";s:15:"button_pm_reply";s:14:"image_filename";s:19:"button_pm_reply.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:78;a:5:{s:10:"image_name";s:19:"button_topic_locked";s:14:"image_filename";s:23:"button_topic_locked.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:79;a:5:{s:10:"image_name";s:16:"button_topic_new";s:14:"image_filename";s:20:"button_topic_new.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}i:80;a:5:{s:10:"image_name";s:18:"button_topic_reply";s:14:"image_filename";s:22:"button_topic_reply.gif";s:10:"image_lang";s:2:"en";s:12:"image_height";s:1:"0";s:11:"image_width";s:1:"0";}}');

?>