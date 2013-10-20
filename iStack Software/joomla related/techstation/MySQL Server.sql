-- phpMyAdmin SQL Dump
-- version 2.9.2-Debian-1.one.com1
-- http://www.phpmyadmin.net
-- 
-- Host: MySQL Server
-- Generation Time: Jan 28, 2010 at 01:00 AM
-- Server version: 5.0.32
-- PHP Version: 5.2.0-8+etch16
-- 
-- Database: `techstation_in`
-- 
CREATE DATABASE `techstation_in` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `techstation_in`;

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_acajoom_lists`
-- 

CREATE TABLE `jos_acajoom_lists` (
  `id` int(10) NOT NULL auto_increment,
  `list_name` varchar(101) NOT NULL default '',
  `list_desc` text NOT NULL,
  `list_type` tinyint(2) NOT NULL default '0',
  `sendername` varchar(64) NOT NULL default '',
  `senderemail` varchar(64) NOT NULL default '',
  `bounceadres` varchar(64) NOT NULL default '',
  `layout` text NOT NULL,
  `template` int(9) NOT NULL default '0',
  `subscribemessage` text NOT NULL,
  `unsubscribemessage` text NOT NULL,
  `unsubscribesend` tinyint(1) NOT NULL default '1',
  `auto_add` tinyint(1) NOT NULL default '0',
  `user_choose` tinyint(1) NOT NULL default '0',
  `cat_id` varchar(250) NOT NULL default '',
  `delay_min` int(2) NOT NULL default '0',
  `delay_max` int(2) NOT NULL default '7',
  `follow_up` int(10) NOT NULL default '0',
  `html` tinyint(1) NOT NULL default '1',
  `hidden` tinyint(1) NOT NULL default '0',
  `published` tinyint(1) NOT NULL default '0',
  `createdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `acc_level` int(2) NOT NULL default '0',
  `acc_id` int(11) NOT NULL default '29',
  `notification` tinyint(1) NOT NULL default '0',
  `owner` int(11) NOT NULL default '0',
  `footer` tinyint(1) NOT NULL default '1',
  `notify_id` int(10) NOT NULL default '0',
  `next_date` int(11) NOT NULL default '0',
  `start_date` date NOT NULL,
  `params` text,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `list_name` (`list_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `jos_acajoom_lists`
-- 

INSERT INTO `jos_acajoom_lists` VALUES (1, 'test_newsletter', '<p>This is test news letter</p>', 1, 'Administrator', 'sundeep.753@gmail.com', 'sundeep.753@gmail.com', '<table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="#f1f1f1">\r\n<tbody>\r\n<tr>\r\n<td align="center" valign="top">\r\n<table border="0" cellspacing="0" cellpadding="0" width="530" bgcolor="#f1f1f1">\r\n<tbody>\r\n<tr>\r\n<td class="hbnr" colspan="3" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_top_header.jpg" border="0" alt="e Newsletter" width="530" height="137" /></td>\r\n</tr>\r\n<tr>\r\n<td colspan="3" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_underban.jpg" border="0" alt="." width="530" height="22" /></td>\r\n</tr>\r\n<tr>\r\n<!-- /// gutter \\\\\\ -->\r\n<td width="15" valign="top" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_spacer.gif" border="0" alt="1" width="15" height="1" /></td>\r\n<!-- \\\\\\ gutter /// --> <!-- /// content cell \\\\\\ -->\r\n<td width="500" valign="top" bgcolor="#ffffff"><br />\r\n<p> </p>\r\n<p>Your Subscription:<br /> [SUBSCRIPTIONS]</p>\r\n<p> </p>\r\n</td>\r\n<!-- \\\\\\ content cell /// --> <!-- /// gutter \\\\\\ -->\r\n<td width="15" valign="top" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_spacer.gif" border="0" alt="1" width="15" height="1" /></td>\r\n<!-- \\\\\\ gutter /// -->\r\n</tr>\r\n<!-- /// footer area with contact info and opt-out link \\\\\\ --> \r\n<tr>\r\n<td colspan="3" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_abovefooter.jpg" border="0" alt="." width="530" height="22" /></td>\r\n</tr>\r\n<tr>\r\n<td style="border-top: 1px solid #aeaeae;" colspan="3" align="center" valign="middle" bgcolor="#cacaca">\r\n<p class="footerText"><a href="http://www.ijoobi.com"><img src="components/com_acajoom/templates/default/tpl0_powered_by.gif" border="0" alt="Powered By Joobi" width="129" height="60" /></a></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<!-- \\\\\\ footer area with contact info and opt-out link /// --></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<!-- \\\\\\ Newsletter Powered by Acajoom!  /// -->\r\n<p> </p>', 0, '', '<p>This is a confirmation email that you have been unsubscribed from our list.  We are sorry that you decided to unsubscribe should you decide to re-subscribe you can always do so on our site.  Should you have any question please contact our webmaster.</p>', 1, 2, 0, '', 0, 0, 0, 1, 1, 1, '2009-09-25 07:49:04', 25, 29, 0, 62, 1, 0, 0, '0000-00-00', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_acajoom_mailings`
-- 

CREATE TABLE `jos_acajoom_mailings` (
  `id` int(11) NOT NULL auto_increment,
  `list_id` int(10) NOT NULL default '0',
  `list_type` tinyint(2) NOT NULL default '0',
  `issue_nb` int(10) NOT NULL default '0',
  `subject` varchar(120) NOT NULL default '',
  `fromname` varchar(64) NOT NULL default '',
  `fromemail` varchar(64) NOT NULL default '',
  `frombounce` varchar(64) NOT NULL default '',
  `htmlcontent` longtext NOT NULL,
  `textonly` longtext NOT NULL,
  `attachments` text NOT NULL,
  `images` text NOT NULL,
  `send_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `delay` int(10) NOT NULL default '0',
  `visible` tinyint(1) NOT NULL default '1',
  `html` tinyint(1) NOT NULL default '1',
  `published` tinyint(1) NOT NULL default '0',
  `createdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `acc_level` int(2) NOT NULL default '0',
  `author_id` int(11) NOT NULL default '0',
  `params` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- 
-- Dumping data for table `jos_acajoom_mailings`
-- 

INSERT INTO `jos_acajoom_mailings` VALUES (6, 1, 1, 1, 'with bharat martimony ad', 'Administrator', 'sundeep.753@gmail.com', 'sundeep.753@gmail.com', '<table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="#f1f1f1">\r\n<tbody>\r\n<tr>\r\n<td align="center" valign="top">\r\n<table border="0" cellspacing="0" cellpadding="0" width="530" bgcolor="#f1f1f1">\r\n<tbody>\r\n<tr>\r\n<td class="hbnr" colspan="3" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_top_header.jpg" border="0" alt="e Newsletter" width="530" height="137" /></td>\r\n</tr>\r\n<tr>\r\n<td colspan="3" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_underban.jpg" border="0" alt="." width="530" height="22" /> <a href="http://www.bharatmatrimony.com/register/addmatrimony.php?aff=sundeep.753" target="_blank"><img src="http://imgs.bharatmatrimony.com/matrimoney/matrimoneybanners/banner80.gif" border="0" /></a></td>\r\n</tr>\r\n<tr>\r\n<!-- /// gutter  -->\r\n<td width="15" valign="top" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_spacer.gif" border="0" alt="1" width="15" height="1" /></td>\r\n<!--  gutter /// --> <!-- /// content cell  -->\r\n<td width="500" valign="top" bgcolor="#ffffff"><br />\r\n<p> </p>\r\n<p>Your Subscription:<br /> [SUBSCRIPTIONS]</p>\r\n<p> </p>\r\n</td>\r\n<!--  content cell /// --> <!-- /// gutter  -->\r\n<td width="15" valign="top" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_spacer.gif" border="0" alt="1" width="15" height="1" /></td>\r\n<!--  gutter /// -->\r\n</tr>\r\n<!-- /// footer area with contact info and opt-out link  --> \r\n<tr>\r\n<td colspan="3" bgcolor="#ffffff"><img src="components/com_acajoom/templates/default/tpl0_abovefooter.jpg" border="0" alt="." width="530" height="22" /></td>\r\n</tr>\r\n<tr>\r\n<td style="border-top: 1px solid #aeaeae;" colspan="3" align="center" valign="middle" bgcolor="#cacaca">\r\n<p class="footerText"><a href="http://www.ijoobi.com"><img src="components/com_acajoom/templates/default/tpl0_powered_by.gif" border="0" alt="Powered By Joobi" width="129" height="60" /></a></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<!--  footer area with contact info and opt-out link /// --></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<!--  Newsletter Powered by Acajoom!  /// -->\r\n<p> </p>', '', '', '', '2009-09-25 12:19:45', 1440, 1, 1, 1, '2009-09-25 12:19:32', 29, 62, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_acajoom_queue`
-- 

CREATE TABLE `jos_acajoom_queue` (
  `qid` int(11) NOT NULL auto_increment,
  `type` tinyint(2) NOT NULL default '0',
  `subscriber_id` int(11) NOT NULL default '0',
  `list_id` int(10) NOT NULL default '0',
  `mailing_id` int(11) NOT NULL default '0',
  `issue_nb` int(10) NOT NULL default '0',
  `send_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `suspend` tinyint(1) NOT NULL default '0',
  `delay` int(10) NOT NULL default '0',
  `acc_level` int(2) NOT NULL default '0',
  `published` tinyint(1) NOT NULL default '0',
  `params` text,
  PRIMARY KEY  (`qid`),
  UNIQUE KEY `subscriber_id` (`subscriber_id`,`list_id`,`mailing_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `jos_acajoom_queue`
-- 

INSERT INTO `jos_acajoom_queue` VALUES (1, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', 0, 0, 29, 0, '');
INSERT INTO `jos_acajoom_queue` VALUES (2, 1, 2, 1, 0, 0, '0000-00-00 00:00:00', 0, 0, 29, 0, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_acajoom_stats_details`
-- 

CREATE TABLE `jos_acajoom_stats_details` (
  `id` int(11) NOT NULL auto_increment,
  `mailing_id` int(11) NOT NULL default '0',
  `subscriber_id` int(11) NOT NULL default '0',
  `sentdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `html` tinyint(1) NOT NULL default '0',
  `read` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sub_mail` (`mailing_id`,`subscriber_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- 
-- Dumping data for table `jos_acajoom_stats_details`
-- 

INSERT INTO `jos_acajoom_stats_details` VALUES (16, 4, 1, '0000-00-00 00:00:00', 1, 1);
INSERT INTO `jos_acajoom_stats_details` VALUES (18, 6, 2, '2009-09-25 12:19:43', 1, 0);
INSERT INTO `jos_acajoom_stats_details` VALUES (17, 5, 1, '0000-00-00 00:00:00', 1, 1);
INSERT INTO `jos_acajoom_stats_details` VALUES (15, 3, 1, '0000-00-00 00:00:00', 1, 1);
INSERT INTO `jos_acajoom_stats_details` VALUES (20, 6, 1, '0000-00-00 00:00:00', 1, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_acajoom_stats_global`
-- 

CREATE TABLE `jos_acajoom_stats_global` (
  `mailing_id` int(11) NOT NULL default '0',
  `sentdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `html_sent` int(11) NOT NULL default '0',
  `text_sent` int(11) NOT NULL default '0',
  `html_read` int(11) NOT NULL default '0',
  PRIMARY KEY  (`mailing_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_acajoom_stats_global`
-- 

INSERT INTO `jos_acajoom_stats_global` VALUES (6, '2009-09-25 12:21:38', 2, 0, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_acajoom_subscribers`
-- 

CREATE TABLE `jos_acajoom_subscribers` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `name` varchar(64) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `receive_html` tinyint(1) NOT NULL default '1',
  `confirmed` tinyint(1) NOT NULL default '0',
  `blacklist` tinyint(1) NOT NULL default '0',
  `timezone` time NOT NULL default '00:00:00',
  `language_iso` varchar(10) NOT NULL default 'eng',
  `subscribe_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `params` text,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `date` (`subscribe_date`),
  KEY `joomlauserid` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `jos_acajoom_subscribers`
-- 

INSERT INTO `jos_acajoom_subscribers` VALUES (1, 62, 'Administrator', 'sundeep.753@gmail.com', 1, 1, 0, '00:00:00', 'eng', '2009-08-11 09:21:33', NULL);
INSERT INTO `jos_acajoom_subscribers` VALUES (2, 63, 'Station Master', 'harshasanghi@gmail.com', 1, 1, 0, '00:00:00', 'eng', '2009-09-06 09:07:55', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_acajoom_xonfig`
-- 

CREATE TABLE `jos_acajoom_xonfig` (
  `akey` varchar(32) NOT NULL default '',
  `text` varchar(254) NOT NULL default '',
  `value` int(11) NOT NULL default '0',
  PRIMARY KEY  (`akey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_acajoom_xonfig`
-- 

INSERT INTO `jos_acajoom_xonfig` VALUES ('component', 'Acajoom', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('type', 'GPL', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('version', '3.2.7', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('level', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('emailmethod', 'mail', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('sendmail_from', 'sundeep.753@gmail.com', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('sendmail_name', 'Tech Station', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('sendmail_path', '/usr/sbin/sendmail', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('smtp_host', 'localhost', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('smtp_auth_required', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('smtp_username', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('smtp_password', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('embed_images', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('confirm_return', 'sundeep.753@gmail.com', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('upload_url', '/components/com_acajoom/upload', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('enable_statistics', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('statistics_per_subscriber', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_data', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('allow_unregistered', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('require_confirmation', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('redirectconfirm', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_login', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_logout', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_unsubcribe', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('confirm_fromname', 'Tech Station', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('confirm_fromemail', 'sundeep.753@gmail.com', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('confirm_html', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('time_zone', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_archive', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('pause_time', '20', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('emails_between_pauses', '65', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('wait_for_user', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('script_timeout', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('display_trace', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_log', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_auto_log', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_log_simple', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_log_closed', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('save_log', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_email', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('save_log_simple', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('save_log_file', '/administrator/components/com_acajoom/com_acajoom.log', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_log_address', '@ijoobi.com', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('option', 'com_sdonkey', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_log_name', 'Acajoom Mailing Report', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('homesite', 'http://www.ijoobi.com', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('report_site', 'http://www.ijoobi.com', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('integration', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_plugin', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_listIds', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_intro', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_showname', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_checkLists', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_showHTML', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_defaultHTML', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_integration', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cb_pluginInstalled', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cron_max_freq', '10', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cron_max_emails', '60', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('last_cron', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('last_sub_update', '1253873207', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('next_autonews', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_footer', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_signature', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('update_url', 'http://www.ijoobi.com/update/', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('date_update', '2009-09-25 06:49:44', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('update_message', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_guide', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('news1', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('news2', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('news3', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('cron_setup', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('queuedate', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('update_avail', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_tips', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('update_notification', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_lists', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('use_sef', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listHTMLeditor', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('mod_pub', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('firstmailing', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('nblist', '9', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('license', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('token', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('maintenance', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('admin_debug', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('send_error', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('report_error', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('fullcheck', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('frequency', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('nb_days', '7', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('date_type', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('arv_cat', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('arv_sec', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('maintenance_clear', '24', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('clean_stats', '90', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('maintenance_date', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('mail_format', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('showtag', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_author', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('addEmailRedLink', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('itemidAca', '999', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('show_jcalpro', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('disabletooltip', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('minisendmail', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('word_wrap', '0', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname0', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames0', 'All mailings', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype0', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow0', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes0', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo0', 'addedit.png', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist0', '', 1);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist0', '', 1);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing0', '', 6);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent0', '', 10);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing0', '', 1);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers0', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers0', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname1', '_ACA_NEWSLETTER', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames1', '_ACA_MENU_NEWSLETTERS', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype1', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow1', '1', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes1', 'newsletter', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo1', 'inbox.png', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist1', '', 1);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist1', '', 1);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing1', '', 6);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent1', '', 10);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing1', '', 1);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers1', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers1', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes2', 'autoresponder', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers2', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers3', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers4', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers5', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers6', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes7', 'autonews', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers7', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listname8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listnames8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listype8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listshow8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('classes8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('listlogo8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totallist8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totallist8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailing8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalmailingsent8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalmailing8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('totalsubcribers8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('act_totalsubcribers8', '', 0);
INSERT INTO `jos_acajoom_xonfig` VALUES ('activelist', '1', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_banner`
-- 

CREATE TABLE `jos_banner` (
  `bid` int(11) NOT NULL auto_increment,
  `cid` int(11) NOT NULL default '0',
  `type` varchar(30) NOT NULL default 'banner',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `imptotal` int(11) NOT NULL default '0',
  `impmade` int(11) NOT NULL default '0',
  `clicks` int(11) NOT NULL default '0',
  `imageurl` varchar(100) NOT NULL default '',
  `clickurl` varchar(200) NOT NULL default '',
  `date` datetime default NULL,
  `showBanner` tinyint(1) NOT NULL default '0',
  `checked_out` tinyint(1) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `editor` varchar(50) default NULL,
  `custombannercode` text,
  `catid` int(10) unsigned NOT NULL default '0',
  `description` text NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `tags` text NOT NULL,
  `params` text NOT NULL,
  PRIMARY KEY  (`bid`),
  KEY `viewbanner` (`showBanner`),
  KEY `idx_banner_catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_banner`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_bannerclient`
-- 

CREATE TABLE `jos_bannerclient` (
  `cid` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `contact` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `extrainfo` text NOT NULL,
  `checked_out` tinyint(1) NOT NULL default '0',
  `checked_out_time` time default NULL,
  `editor` varchar(50) default NULL,
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_bannerclient`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_bannertrack`
-- 

CREATE TABLE `jos_bannertrack` (
  `track_date` date NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_bannertrack`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_categories`
-- 

CREATE TABLE `jos_categories` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `image` varchar(255) NOT NULL default '',
  `section` varchar(50) NOT NULL default '',
  `image_position` varchar(30) NOT NULL default '',
  `description` text NOT NULL,
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `editor` varchar(50) default NULL,
  `ordering` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `count` int(11) NOT NULL default '0',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `cat_idx` (`section`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table `jos_categories`
-- 

INSERT INTO `jos_categories` VALUES (1, 0, 'SQL Queries', '', 'sql-queries', '', '1', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 1, 0, 0, '');
INSERT INTO `jos_categories` VALUES (2, 0, 'Perl', '', 'perl', '', '1', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 2, 0, 0, '');
INSERT INTO `jos_categories` VALUES (3, 0, 'Perl', '', 'articles-perl', '', '4', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 1, 0, 0, '');
INSERT INTO `jos_categories` VALUES (4, 0, 'Database', '', 'articles-database', '', '4', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 2, 0, 0, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_components`
-- 

CREATE TABLE `jos_components` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `link` varchar(255) NOT NULL default '',
  `menuid` int(11) unsigned NOT NULL default '0',
  `parent` int(11) unsigned NOT NULL default '0',
  `admin_menu_link` varchar(255) NOT NULL default '',
  `admin_menu_alt` varchar(255) NOT NULL default '',
  `option` varchar(50) NOT NULL default '',
  `ordering` int(11) NOT NULL default '0',
  `admin_menu_img` varchar(255) NOT NULL default '',
  `iscore` tinyint(4) NOT NULL default '0',
  `params` text NOT NULL,
  `enabled` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `parent_option` (`parent`,`option`(32))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=44 ;

-- 
-- Dumping data for table `jos_components`
-- 

INSERT INTO `jos_components` VALUES (1, 'Banners', '', 0, 0, '', 'Banner Management', 'com_banners', 0, 'js/ThemeOffice/component.png', 0, 'track_impressions=0\ntrack_clicks=0\ntag_prefix=\n\n', 1);
INSERT INTO `jos_components` VALUES (2, 'Banners', '', 0, 1, 'option=com_banners', 'Active Banners', 'com_banners', 1, 'js/ThemeOffice/edit.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (3, 'Clients', '', 0, 1, 'option=com_banners&c=client', 'Manage Clients', 'com_banners', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (4, 'Web Links', 'option=com_weblinks', 0, 0, '', 'Manage Weblinks', 'com_weblinks', 0, 'js/ThemeOffice/component.png', 0, 'show_comp_description=1\ncomp_description=\nshow_link_hits=1\nshow_link_description=1\nshow_other_cats=1\nshow_headings=1\nshow_page_title=1\nlink_target=0\nlink_icons=\n\n', 1);
INSERT INTO `jos_components` VALUES (5, 'Links', '', 0, 4, 'option=com_weblinks', 'View existing weblinks', 'com_weblinks', 1, 'js/ThemeOffice/edit.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (6, 'Categories', '', 0, 4, 'option=com_categories&section=com_weblinks', 'Manage weblink categories', '', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (7, 'Contacts', 'option=com_contact', 0, 0, '', 'Edit contact details', 'com_contact', 0, 'js/ThemeOffice/component.png', 1, 'contact_icons=0\nicon_address=\nicon_email=\nicon_telephone=\nicon_fax=\nicon_misc=\nshow_headings=1\nshow_position=1\nshow_email=0\nshow_telephone=1\nshow_mobile=1\nshow_fax=1\nbannedEmail=\nbannedSubject=\nbannedText=\nsession=1\ncustomReply=0\n\n', 1);
INSERT INTO `jos_components` VALUES (8, 'Contacts', '', 0, 7, 'option=com_contact', 'Edit contact details', 'com_contact', 0, 'js/ThemeOffice/edit.png', 1, '', 1);
INSERT INTO `jos_components` VALUES (9, 'Categories', '', 0, 7, 'option=com_categories&section=com_contact_details', 'Manage contact categories', '', 2, 'js/ThemeOffice/categories.png', 1, 'contact_icons=0\nicon_address=\nicon_email=\nicon_telephone=\nicon_fax=\nicon_misc=\nshow_headings=1\nshow_position=1\nshow_email=0\nshow_telephone=1\nshow_mobile=1\nshow_fax=1\nbannedEmail=\nbannedSubject=\nbannedText=\nsession=1\ncustomReply=0\n\n', 1);
INSERT INTO `jos_components` VALUES (10, 'Polls', 'option=com_poll', 0, 0, 'option=com_poll', 'Manage Polls', 'com_poll', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (11, 'News Feeds', 'option=com_newsfeeds', 0, 0, '', 'News Feeds Management', 'com_newsfeeds', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (12, 'Feeds', '', 0, 11, 'option=com_newsfeeds', 'Manage News Feeds', 'com_newsfeeds', 1, 'js/ThemeOffice/edit.png', 0, 'show_headings=1\nshow_name=1\nshow_articles=1\nshow_link=1\nshow_cat_description=1\nshow_cat_items=1\nshow_feed_image=1\nshow_feed_description=1\nshow_item_description=1\nfeed_word_count=0\n\n', 1);
INSERT INTO `jos_components` VALUES (13, 'Categories', '', 0, 11, 'option=com_categories&section=com_newsfeeds', 'Manage Categories', '', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (14, 'User', 'option=com_user', 0, 0, '', '', 'com_user', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (15, 'Search', 'option=com_search', 0, 0, 'option=com_search', 'Search Statistics', 'com_search', 0, 'js/ThemeOffice/component.png', 1, 'enabled=0\n\n', 1);
INSERT INTO `jos_components` VALUES (16, 'Categories', '', 0, 1, 'option=com_categories&section=com_banner', 'Categories', '', 3, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (17, 'Wrapper', 'option=com_wrapper', 0, 0, '', 'Wrapper', 'com_wrapper', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (18, 'Mail To', '', 0, 0, '', '', 'com_mailto', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (19, 'Media Manager', '', 0, 0, 'option=com_media', 'Media Manager', 'com_media', 0, '', 1, 'upload_extensions=bmp,csv,doc,epg,gif,ico,jpg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,EPG,GIF,ICO,JPG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\nupload_maxsize=10000000\nfile_path=images\nimage_path=images/stories\nrestrict_uploads=1\nallowed_media_usergroup=3\ncheck_mime=1\nimage_extensions=bmp,gif,jpg,png\nignore_extensions=\nupload_mime=image/jpeg,image/gif,image/png,image/bmp,application/x-shockwave-flash,application/msword,application/excel,application/pdf,application/powerpoint,text/plain,application/x-zip\nupload_mime_illegal=text/html\nenable_flash=0\n\n', 1);
INSERT INTO `jos_components` VALUES (20, 'Articles', 'option=com_content', 0, 0, '', '', 'com_content', 0, '', 1, 'show_noauth=0\nshow_title=1\nlink_titles=0\nshow_intro=1\nshow_section=1\nlink_section=0\nshow_category=1\nlink_category=0\nshow_author=1\nshow_create_date=0\nshow_modify_date=0\nshow_item_navigation=0\nshow_readmore=1\nshow_vote=0\nshow_icons=0\nshow_pdf_icon=0\nshow_print_icon=1\nshow_email_icon=1\nshow_hits=1\nfeed_summary=0\nfilter_tags=\nfilter_attritbutes=\n\n', 1);
INSERT INTO `jos_components` VALUES (21, 'Configuration Manager', '', 0, 0, '', 'Configuration', 'com_config', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (22, 'Installation Manager', '', 0, 0, '', 'Installer', 'com_installer', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (23, 'Language Manager', '', 0, 0, '', 'Languages', 'com_languages', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (24, 'Mass mail', '', 0, 0, '', 'Mass Mail', 'com_massmail', 0, '', 1, 'mailSubjectPrefix=\nmailBodySuffix=\n\n', 1);
INSERT INTO `jos_components` VALUES (25, 'Menu Editor', '', 0, 0, '', 'Menu Editor', 'com_menus', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (27, 'Messaging', '', 0, 0, '', 'Messages', 'com_messages', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (28, 'Modules Manager', '', 0, 0, '', 'Modules', 'com_modules', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (29, 'Plugin Manager', '', 0, 0, '', 'Plugins', 'com_plugins', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (30, 'Template Manager', '', 0, 0, '', 'Templates', 'com_templates', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (31, 'User Manager', '', 0, 0, '', 'Users', 'com_users', 0, '', 1, 'allowUserRegistration=1\nnew_usertype=Registered\nuseractivation=1\nfrontend_userparams=1\n\n', 1);
INSERT INTO `jos_components` VALUES (32, 'Cache Manager', '', 0, 0, '', 'Cache', 'com_cache', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (33, 'Control Panel', '', 0, 0, '', 'Control Panel', 'com_cpanel', 0, '', 1, '', 1);
INSERT INTO `jos_components` VALUES (34, 'googleSearch', 'option=com_googlesearch', 0, 0, 'option=com_googlesearch', 'googleSearch', 'com_googlesearch', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (35, 'MediQnA', 'option=com_mediqna', 0, 0, 'option=com_mediqna', 'MediQnA', 'com_mediqna', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (36, 'Acajoom', 'option=com_acajoom', 0, 0, 'option=com_acajoom', 'Acajoom', 'com_acajoom', 0, '../administrator/components/com_acajoom/images/acajoom_icon.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (37, 'Lists', '', 0, 36, 'option=com_acajoom&act=list', 'Lists', 'com_acajoom', 0, '../includes/js/ThemeOffice/edit.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (38, 'Subscribers', '', 0, 36, 'option=com_acajoom&act=subscribers', 'Subscribers', 'com_acajoom', 1, '../includes/js/ThemeOffice/users_add.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (39, 'Newsletters', '', 0, 36, 'option=com_acajoom&act=mailing&listype=1', 'Newsletters', 'com_acajoom', 2, '../includes/js/ThemeOffice/messaging_inbox.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (40, 'Statistics', '', 0, 36, 'option=com_acajoom&act=statistics', 'Statistics', 'com_acajoom', 3, '../includes/js/ThemeOffice/query.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (41, 'Configuration', '', 0, 36, 'option=com_acajoom&act=configuration', 'Configuration', 'com_acajoom', 4, '../includes/js/ThemeOffice/menus.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (42, 'Import', '', 0, 36, 'option=com_acajoom&act=update', 'Import', 'com_acajoom', 5, '../includes/js/ThemeOffice/restore.png', 0, '', 1);
INSERT INTO `jos_components` VALUES (43, 'About', '', 0, 36, 'option=com_acajoom&act=about', 'About', 'com_acajoom', 6, '../includes/js/ThemeOffice/credits.png', 0, '', 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_contact_details`
-- 

CREATE TABLE `jos_contact_details` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `con_position` varchar(255) default NULL,
  `address` text,
  `suburb` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `postcode` varchar(100) default NULL,
  `telephone` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `misc` mediumtext,
  `image` varchar(255) default NULL,
  `imagepos` varchar(20) default NULL,
  `email_to` varchar(255) default NULL,
  `default_con` tinyint(1) unsigned NOT NULL default '0',
  `published` tinyint(1) unsigned NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `params` text NOT NULL,
  `user_id` int(11) NOT NULL default '0',
  `catid` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `mobile` varchar(255) NOT NULL default '',
  `webpage` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_contact_details`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_content`
-- 

CREATE TABLE `jos_content` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `title_alias` varchar(255) NOT NULL default '',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL default '0',
  `sectionid` int(11) unsigned NOT NULL default '0',
  `mask` int(11) unsigned NOT NULL default '0',
  `catid` int(11) unsigned NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` int(11) unsigned NOT NULL default '0',
  `created_by_alias` varchar(255) NOT NULL default '',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified_by` int(11) unsigned NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` text NOT NULL,
  `version` int(11) unsigned NOT NULL default '1',
  `parentid` int(11) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(11) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '0',
  `metadata` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_section` (`sectionid`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

-- 
-- Dumping data for table `jos_content`
-- 

INSERT INTO `jos_content` VALUES (1, 'Trvial SQL Questions', 'trvial-sql-questions', '', '<p><strong>How can I delete all rows before a particular date?</strong></p>\r\n<p>With a WHERE condition in the DELETE statement.<strong><br /><br /></strong></p>\r\n<p><strong> I want only rows which have the same IDs in both tables</strong><br /> Use an INNER JOIN.</p>\r\n<p> </p>\r\n', '\r\n<p> </p>\r\n<p><strong>What is the difference between Distinct and Unique?</strong><br />They aren''t synonyms in  SQL, because each can be used only in very specific places in SQL  statements—DISTINCT in a SELECT clause or COUNT(DISTINCT)  expression, and UNIQUE when declaring a constraint. On the other   hand, they are synonyms when talking about SQL, because when you  use SELECT DISTINCT, you do get unique rows.</p>\r\n<p><br /> <strong>What is the difference between "inner" and "outer" joins?</strong><br /> Outer joins return unmatched rows. What more is there to  say?</p>\r\n<p> </p>\r\n<p><br /> <strong>What is the difference between GROUP BY and ORDER BY clauses?</strong><br />One does grouping, the other does ordering. That might  sound flippant, but it is not meant to be.<br /><br /></p>', 1, 4, 0, 4, '2009-08-17 15:23:24', 62, '', '2009-12-13 05:41:27', 62, 0, '0000-00-00 00:00:00', '2009-08-17 15:23:24', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 6, 0, 2, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (2, 'SQL Queries to Solve', 'sql-queries-to-solve', '', '<ol>\r\n<li>Write a query to get the second highest amount in the table</li>\r\n<li> List last name and hire date of any employee in the same department as Zlotkey </li>\r\n<li>The nth highest salary in the EMP table </li>\r\n<li>In SQL from two different tables select the first five highest salary \r\n', '\r\n</li>\r\n<li>How can we find the second highest salary from three departments named D1, D2 and D3</li>\r\n<li> How to select last ten max(sal) from EMP</li>\r\n<li> List the highest salary, the lowest salary, the average salary and the total salaries of employees</li>\r\n<li> What are the different way of selecting 3rd highest salary from EMP table?</li>\r\n<li> How to get Top 5th, 6th, Nth salary from emp table of oracle</li>\r\n<li> Get the doctor with the highest count of visits</li>\r\n<li> How to find the 2nd, 3rd, 4th, ... nth max of a column in a table</li>\r\n<li> How to find out the fifth max salary from employee table</li>\r\n<li>I want to know how to retrieve third highest and lowest from a column</li>\r\n<li> Need help finding the second largest pay and second smallest pay from the salary table</li>\r\n<li> How do I get the top 3 highest salary from the emp table</li>\r\n<li> How can I get the second maximum salary?</li>\r\n</ol>\r\n<p> </p>', 1, 4, 0, 4, '2009-08-17 15:44:13', 62, '', '2009-12-13 05:41:44', 62, 0, '0000-00-00 00:00:00', '2009-08-17 15:44:13', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 3, '', '', 0, 2, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (3, 'Database Concepts', 'database-concepts', '', '<p><strong>What is normalization? Explain different levels of normalization?</strong></p>\r\n<p> </p>\r\n<p>Check out the article Q100139 from Microsoft knowledge base and of course, there''s much more information available in the net. It''ll be a good idea to get a hold of any RDBMS fundamentals text book, especially the one by C. J. Date. Most of the times, it will be okay if you can explain till third normal form.</p>\r\n<p> </p>\r\n<p> </p>\r\n<p><strong>What is denormalization and when would you go for it?</strong></p>\r\n<p>Asthe name indicates, denormalization is the reverse process of normalization. It''s the controlled introduction of redundancy in to the database design. It helps improve the query performance as the number of joins could be reduced.</p>\r\n<p> </p>\r\n', '\r\n<p> </p>\r\n<p> </p>\r\n<p><strong>How do you implement one-to-one, one-to-many and many-to-many relationships while designing tables?</strong></p>\r\n<p>One-to-One relationship can be implemented as a single table and rarely as two tables with primary and foreign key relationships. One-to-Many relationships are implemented by splitting the data into two tables with primary key and foreign key relationships. Many-to-Many relationships are implemented using a junction table with the keys from both the tables forming the composite primary key of the junction table. It will be a good idea to read up a database designing fundamentals text book.</p>\r\n<p> </p>\r\n<p><strong>What''s the difference between a primary key and a unique key?</strong></p>\r\n<p>Both primary key and unique enforce uniqueness of the column on which they are defined. But by default primary key creates a clustered index on the column, where are unique creates a nonclustered index by default. Another major difference is that, primary key doesn''t allow NULLs, but unique key allows one NULL only.</p>\r\n<p> </p>\r\n<p><strong>What are user defined datatypes and when you should go for them?</strong></p>\r\n<p>User defined datatypes let you extend the base SQL Server datatypes by providing a descriptive name, and format to the database. Take for example, in your database, there is a column called Flight_Num which appears in many tables. In all these tables it should be varchar(8).</p>\r\n<p> </p>\r\n<p><strong>In this case you could create a user defined datatype called Flight_num_type of varchar(8) and use it across all your tables.</strong></p>\r\n<p>See sp_addtype, sp_droptype in books online.</p>\r\n<p> </p>\r\n<p><strong>What is bit datatype and what''s the information that can be stored inside a bit column?</strong></p>\r\n<p>Bit datatype is used to store boolean information like 1 or 0 (true or false). Untill SQL Server 6.5 bit datatype could hold either a 1 or 0 and there was no support for NULL. But from SQL Server 7.0 onwards, bit datatype can represent a third state, which is NULL.</p>\r\n<p> </p>\r\n<p><strong>Define candidate key, alternate key, composite key.</strong></p>\r\n<p>A candidate key is one that can identify each row of a table uniquely. Generally a candidate key becomes the primary key of the table. If the table has more than one candidate key, one of them will become the primarykey, and the rest are called alternate keys.  A key formed by combining at least two or more columns is called composite key.</p>\r\n<p> </p>\r\n<p><strong>What are defaults? Is there a column to which a default can''t be bound?</strong></p>\r\n<p>A default is a value that will be used by a column, if no value is supplied to that column while inserting data. IDENTITY columns and timestamp columns can''t have defaults bound to them. See CREATE DEFUALT in books online.</p>\r\n<p> </p>\r\n<p><strong>What is a transaction and what are ACID properties?</strong></p>\r\n<p>A transaction is a logical unit of work in which, all the steps must be performed or none. ACID stands for Atomicity, Consistency, Isolation, Durability. These are the properties of a transaction. For more information and explanation of these properties, see SQL Server books online or any RDBMS fundamentals text book.</p>\r\n<p> </p>\r\n<p><strong>Explain different isolation levels</strong></p>\r\n<p>An isolation level determines the degree of isolation of data between concurrent transactions. The default SQL Server isolation level is Read Committed. Here are the other isolation levels (in the ascending order of isolation): Read Uncommitted, Read Committed, Repeatable Read, Serializable. See SQL Server books online for an explanation of the isolation levels. Be sure to read about SET TRANSACTION ISOLATION LEVEL, which lets you customize the isolation level at the connection level.</p>\r\n<p> </p>\r\n<p><strong>CREATE INDEX myIndex ON myTable(myColumn)</strong></p>\r\n<p><strong>What type of Index will get created after executing the above statement?</strong></p>\r\n<p>Non-clustered index. Important thing to note: By default a clustered index gets created on the primary key, unless specified otherwise.</p>\r\n<p> </p>\r\n<p><strong>What''s the maximum size of a row?</strong></p>\r\n<p>8060 bytes. Don''t be surprised with questions like ''what is the maximum number of columns per table''. Check out SQL Server books online for the page titled: "Maximum Capacity Specifications".</p>\r\n<p> </p>\r\n<p><strong>Explain Active/Active and Active/Passive cluster configurations</strong></p>\r\n<p>Hopefully you have experience setting up cluster servers. But if you don''t, at least be familiar with the way clustering works and the two clusterning configurations Active/Active and Active/Passive. SQL Server books online has enough information on this topic and there is a good white paper available on Microsoft site.</p>\r\n<p> </p>\r\n<p><strong>Explain the architecture of SQL Server</strong></p>\r\n<p>This is a very important question and you better be able to answer it if consider yourself a DBA. SQL Server books online is the best place to read about SQL Server architecture. Read up the chapter dedicated to SQL Server Architecture.</p>\r\n<p> </p>\r\n<p><strong>What is lock escalation?</strong></p>\r\n<p>Lock escalation is the process of converting a lot of low level locks (like row locks, page locks) into higher level</p>\r\n<p>locks (like table locks). Every lock is a memory structure too many locks would mean, more memory being</p>\r\n<p>occupied by locks. To prevent this from happening, SQL Server escalates the many fine-grain locks to fewer</p>\r\n<p>coarse-grain locks. Lock escalation threshold was definable in SQL Server 6.5, but from SQL Server 7.0 onwards</p>\r\n<p>it''s dynamically managed by SQL Server.</p>\r\n<p>What''s the difference between DELETE TABLE and TRUNCATE TABLE commands?</p>\r\n<p>DELETE TABLE is a logged operation, so the deletion of each row gets logged in the transaction log, which</p>\r\n<p>makes it slow. TRUNCATE TABLE also deletes all the rows in a table, but it won''t log the deletion of each row,</p>\r\n<p>instead it logs the deallocation of the data pages of the table, which makes it faster. Of course, TRUNCATE</p>\r\n<p>TABLE can be rolled back.</p>\r\n<p>Explain the storage models of OLAP</p>\r\n<p>Check out MOLAP, ROLAP and HOLAP in SQL Server books online for more infomation.</p>\r\n<p>What are the new features introduced in SQL Server 2000 (or the latest release of SQL Server at the</p>\r\n<p>time of your interview)? What changed between the previous version of SQL Server and the current</p>\r\n<p>version?</p>\r\n<p>This question is generally asked to see how current is your knowledge. Generally there is a section in the</p>\r\n<p>beginning of the books online titled "What''s New", which has all such information. Of course, reading just that is</p>\r\n<p>not enough, you should have tried those things to better answer the questions. Also check out the section titled</p>\r\n<p>"Backward Compatibility" in books online which talks about the changes that have taken place in the new</p>\r\n<p>version.</p>\r\n<p>What are constraints? Explain different types of constraints.</p>\r\n<p>Constraints enable the RDBMS enforce the integrity of the database automatically, without needing you to</p>\r\n<p>create triggers, rule or defaults.</p>\r\n<p>Types of constraints: NOT NULL, CHECK, UNIQUE, PRIMARY KEY, FOREIGN KEY</p>\r\n<p>For an explanation of these constraints see books online for the pages titled: "Constraints" and "CREATE</p>\r\n<p>TABLE", "ALTER TABLE"</p>\r\n<p>What is an index? What are the types of indexes? How many clustered indexes can be created on a</p>\r\n<p>table? I create a separate index on each column of a table. what are the advantages and</p>\r\n<p>disadvantages of this approach?</p>\r\n<p>Indexes in SQL Server are similar to the indexes in books. They help SQL Server retrieve the data quicker.</p>\r\n<p>Indexes are of two types. Clustered indexes and non-clustered indexes. When you craete a clustered index on a</p>\r\n<p>table, all the rows in the table are stored in the order of the clustered index key. So, there can be only one</p>\r\n<p>clustered index per table. Non-clustered indexes have their own storage separate from the table data storage.</p>\r\n<p>Non-clustered indexes are stored as B-tree structures (so do clustered indexes), with the leaf level nodes</p>\r\n<p>having the index key and it''s row locater. The row located could be the RID or the Clustered index key,</p>\r\n<p>depending up on the absence or presence of clustered index on the table.</p>\r\n<p>If you create an index on each column of a table, it improves the query performance, as the query optimizer</p>\r\n<p>can choose from all the existing indexes to come up with an efficient execution plan. At the same t ime, data</p>\r\n<p>modification operations (such as INSERT, UPDATE, DELETE) will become slow, as every time data changes in the</p>\r\n<p>table, all the indexes need to be updated. Another disadvantage is that, indexes need disk space, the more</p>\r\n<p>indexes you have, more disk space is used.</p>\r\n<p>What is RAID and what are different types of RAID configurations?</p>\r\n<p>RAID stands for Redundant Array of Inexpensive Disks, used to provide fault tolerance to database servers.</p>\r\n<p>There are six RAID levels 0 through 5 offering different levels of performance, fault tolerance. MSDN has some</p>\r\n<p>information about RAID levels and for detailed information, check out the RAID advisory board''s homepage</p>\r\n<p>What are the steps you will take to improve performance of a poor performing query?</p>\r\n<p>This is a very open ended question and there could be a lot of reasons behind the poor performance of a query.</p>\r\n<p>But some general issues that you could talk about would be: No indexes, table scans, missing or out of date</p>\r\n<p>statistics, blocking, excess recompilations of stored procedures, procedures and triggers without SET NOCOUNT</p>\r\n<p>ON, poorly written query with unnecessarily complicated joins, too much normalization, excess usage of cursors</p>\r\n<p>and temporary tables.</p>\r\n<p>Some of the tools/ways that help you troubleshooting performance problems are: SET SHOWPLAN_ALL ON, SET</p>\r\n<p>SHOWPLAN_TEXT ON, SET STATISTICS IO ON, SQL Server Profiler, Windows NT /2000 Performance monitor,</p>\r\n<p>Graphical execution plan in Query Analyzer.</p>\r\n<p>Download the white paper on performance tuning SQL Server from Microsoft web site. Don''t forget to check out</p>\r\n<p>sql-server-performance.com</p>\r\n<p>What are the steps you will take, if you are tasked with securing an SQL Server?</p>\r\n<p>Again this is another open ended question. Here are some things you could talk about: Preferring NT</p>\r\n<p>authentication, using server, databse and application roles to control access to the data, securing the physical</p>\r\n<p>database files using NTFS permissions, using an unguessable SA password, restricting physical access to the</p>\r\n<p>SQL Server, renaming the Administrator account on the SQL Server computer, disabling the Guest account,</p>\r\n<p>enabling auditing, using multiprotocol encryption, setting up SSL, setting up firewalls, isolating SQL Server from</p>\r\n<p>the web server etc.</p>\r\n<p>Read the white paper on SQL Server security from Microsoft website. Also check out My SQL Server security</p>\r\n<p>best practices</p>\r\n<p>What is a deadlock and what is a live lock? How will you go about resolving deadlocks?</p>\r\n<p>Deadlock is a situation when two processes, each having a lock on one piece of data, attempt to acquire a lock</p>\r\n<p>on the other''s piece. Each process would wait indefinitely for the other to release the lock, unless one of the</p>\r\n<p>user processes is terminated. SQL Server detects deadlocks and terminates one user''s process.</p>\r\n<p>A livelock is one, where a request for an exclusive lock is repeatedly denied because a series of overlapping</p>\r\n<p>shared locks keeps interfering. SQL Server detects the situation after four denials and refuses further shared</p>\r\n<p>locks. A livelock also occurs when read transactions monopolize a table or page, forcing a write transaction to</p>\r\n<p>wait indefinitely.</p>\r\n<p>Check out SET DEADLOCK_PRIORITY and "Minimizing Deadlocks" in SQL Server books online. Also check out</p>\r\n<p>the article Q169960 from Microsoft knowledge base.</p>\r\n<p>What is blocking and how would you troubleshoot it?</p>\r\n<p>Blocking happens when one connection from an application holds a lock and a second connection requires a</p>\r\n<p>conflicting lock type. This forces the second connection to wait, blocked on the first.</p>\r\n<p>Read up the following topics in SQL Server books online: Understanding and avoiding blocking, Coding efficient</p>\r\n<p>transactions.</p>\r\n<p>Explain CREATE DATABASE syntax</p>\r\n<p>Many of us are used to craeting databases from the Enterprise Manager or by just issuing the command:</p>\r\n<p>CREATE DATABAE MyDB. But what if you have to create a database with two filegroups, one on drive C and the</p>\r\n<p>other on drive D with log on drive E with an initial size of 600 MB and with a growth factor of 15%? That''s why</p>\r\n<p>being a DBA you should be familiar with the CREATE DATABASE syntax. Check out SQL Server books online for</p>\r\n<p>more information.</p>\r\n<p>How to restart SQL Server in single user mode? How to start SQL Server in minimal configuration</p>\r\n<p>mode?</p>\r\n<p>SQL Server can be started from command line, using the SQLSERVR.EXE. This EXE has some very important</p>\r\n<p>parameters with which a DBA should be familiar with. -m is used for starting SQL Server in single user mode</p>\r\n<p>and -f is used to start the SQL Server in minimal confuguration mode. Check out SQL Server books online for</p>\r\n<p>more parameters and their explanations.</p>\r\n<p>As a part of your job, what are the DBCC commands that you commonly use for database</p>\r\n<p>maintenance?</p>\r\n<p>DBCC CHECKDB, DBCC CHECKTABLE, DBCC CHECKCATALOG, DBCC CHECKALLOC, DBCC SHOWCONTIG, DBCC</p>\r\n<p>SHRINKDATABASE, DBCC SHRINKFILE etc. But there are a whole load of DBCC commands which are very useful</p>\r\n<p>for DBAs.</p>\r\n<p>Check out SQL Server books online for more information.</p>\r\n<p>What are statistics, under what circumstances they go out of date, how do you update them?</p>\r\n<p>Statistics determine the selectivity of the indexes. If an indexed column has unique values then the selectivity</p>\r\n<p>of that index is more, as opposed to an index with non-unique values. Query optimizer uses these indexes in</p>\r\n<p>determining whether to choose an index or not while executing a query.</p>\r\n<p>Some situations under which you should update statistics:</p>\r\n<p>1) If there is significant change in the key values in the index</p>\r\n<p>2) If a large amount of data in an indexed column has been added, changed, or removed (that is, if the</p>\r\n<p>distribution of key values has changed), or the table has been truncated using the TRUNCATE TABLE statement</p>\r\n<p>and then repopulated</p>\r\n<p>3) Database is upgraded from a previous version</p>\r\n<p>Look up SQL Server books online for the following commands: UPDATE STATISTICS, STATS_DATE, DBCC</p>\r\n<p>SHOW_STATISTICS, CREATE STATISTICS, DROP STATISTICS, sp_autostats, sp_createstats, sp_updatestats</p>\r\n<p>What are the different ways of moving data/databases between servers and databases in SQL</p>\r\n<p>Server?</p>\r\n<p>There are lots of options available, you have to choose your option depending upon your requirements. Some of</p>\r\n<p>the options you have are: BACKUP/RESTORE, dettaching and attaching databases, replication, DTS, BCP,</p>\r\n<p>logshipping, INSERT...SELECT, SELECT...INTO, creating INSERT scripts to generate data.</p>\r\n<p>Explian different types of BACKUPs avaialabe in SQL Server? Given a particular scenario, how would</p>\r\n<p>you go about choosing a backup plan?</p>\r\n<p>Types of backups you can create in SQL Sever 7.0+ are Full database backup, differential database backup,</p>\r\n<p>transaction log backup, filegroup backup. Check out the BACKUP and RESTORE commands in SQL Server books</p>\r\n<p>online. Be prepared to write the commands in your interview. Books online also has information on detailed</p>\r\n<p>backup/restore architecture and when one should go for a particular kind of backup.</p>\r\n<p>What is database replication? What are the different types of replication you can set up in SQL</p>\r\n<p>Server?</p>\r\n<p>Replication is the process of copying/moving data between databases on the same or different servers. SQL</p>\r\n<p>Server supports the following types of replication scenarios:</p>\r\n<p>* Snapshot replication</p>\r\n<p>* Transactional replication (with immediate updating subscribers, with queued updating subscribers)</p>\r\n<p>* Merge replication</p>\r\n<p>See SQL Server books online for indepth coverage on replication. Be prepared to explain how different</p>\r\n<p>replication agents function, what are the main system tables used in replication etc.</p>\r\n<p>How to determine the service pack currently installed on SQL Server?</p>\r\n<p>The global variable @@Version stores the build number of the sqlservr.exe, which is used to determine the</p>\r\n<p>service pack installed. To know more about this process visit SQL Server service packs and</p>\r\n<p>versions.</p>\r\n<p>What are cursors? Explain different types of cursors. What are the disadvantages of cursors? How</p>\r\n<p>can you avoid cursors?</p>\r\n<p>Cursors allow row-by-row prcessing of the resultsets.</p>\r\n<p>Types of cursors: Static, Dynamic, Forward-only, Keyset-driven. See books online for more information.</p>\r\n<p>Disadvantages of cursors: Each time you fetch a row from the cursor, it results in a network roundtrip, where as</p>\r\n<p>a normal SELECT query makes only one rowundtrip, however large the resultset is. Cursors are also costly</p>\r\n<p>because they require more resources and temporary storage (results in more IO operations). Furthere, there</p>\r\n<p>are restrictions on the SELECT statements that can be used with some types of cursors.</p>\r\n<p>Most of the times, set based operations can be used instead of cursors. Here is an example:</p>\r\n<p>If you have to give a flat hike to your employees using the following criteria:</p>\r\n<p>Salary between 30000 and 40000 -- 5000 hike</p>\r\n<p>Salary between 40000 and 55000 -- 7000 hike</p>\r\n<p>Salary between 55000 and 65000 -- 9000 hike</p>\r\n<p>In this situation many developers tend to use a cursor, determine each employee''s salary and update his salary</p>\r\n<p>according to the above formula. But the same can be achieved by multiple update statements or can be</p>\r\n<p>combined in a single UPDATE statement as shown below:</p>\r\n<p>UPDATE tbl_emp SET salary =</p>\r\n<p>CASE WHEN salary BETWEEN 30000 AND 40000 THEN salary + 5000</p>\r\n<p>WHEN salary BETWEEN 40000 AND 55000 THEN salary + 7000</p>\r\n<p>WHEN salary BETWEEN 55000 AND 65000 THEN salary + 10000</p>\r\n<p>END</p>\r\n<p>Another situation in which developers tend to use cursors: You need to call a stored procedure when a column</p>\r\n<p>in a particular row meets certain condition. You don''t have to use cursors for this. This can be achieved using</p>\r\n<p>WHILE loop, as long as there is a unique key to identify each row. For examples of using WHILE loop for row by</p>\r\n<p>row processing, check out the ''My code library'' section of my site or search for WHILE.</p>\r\n<p>Write down the general syntax for a SELECT statements covering all the options.</p>\r\n<p>Here''s the basic syntax: (Also checkout SELECT in books online for advanced syntax).</p>\r\n<p>SELECT select_list</p>\r\n<p>[INTO new_table_]</p>\r\n<p>FROM table_source</p>\r\n<p>[WHERE search_condition]</p>\r\n<p>[GROUP BY group_by__expression]</p>\r\n<p>[HAVING search_condition]</p>\r\n<p>[ORDER BY order__expression [ASC | DESC] ]</p>\r\n<p>What is a join and explain different types of joins.</p>\r\n<p>Joins are used in queries to explain how different tables are related. Joins also let you select data from a table</p>\r\n<p>depending upon data from another table.</p>\r\n<p>Types of joins: INNER JOINs, OUTER JOINs, CROSS JOINs. OUTER JOINs are further classified as LEFT OUTER</p>\r\n<p>JOINS, RIGHT OUTER JOINS and FULL OUTER JOINS.</p>\r\n<p>For more information see pages from books online titled: "Join Fundamentals" and "Using Joins".</p>\r\n<p>Can you have a nested transaction?</p>\r\n<p>Yes, very much. Check out BEGIN TRAN, COMMIT, ROLLBACK, SAVE TRAN and @@TRANCOUNT</p>\r\n<p>What is an extended stored procedure? Can you instantiate a COM object by using T-SQL?</p>\r\n<p>An extended stored procedure is a function within a DLL (written in a programming language like C, C++ using</p>\r\n<p>Open Data Services (ODS) API) that can be called from T-SQL, just the way we call normal stored procedures</p>\r\n<p>using the EXEC statement. See books online to learn how to create extended stored procedures and how to add</p>\r\n<p>them to SQL Server.</p>\r\n<p>Yes, you can instantiate a COM (written in languages like VB, VC++) object from T-SQL by using sp_OACreate</p>\r\n<p>stored procedure. Also see books online for sp_OAMethod, sp_OAGetProperty, sp_OASetProperty,</p>\r\n<p>sp_OADestroy. For an example of creating a COM object in VB and calling it from T-SQL, see ''My code library''</p>\r\n<p>section of this site.</p>\r\n<p>What is the system function to get the current user''s user id?</p>\r\n<p>USER_ID(). Also check out other system functions like USER_NAME(), SYSTEM_USER, SESSION_USER,</p>\r\n<p>CURRENT_USER, USER, SUSER_SID(), HOST_NAME().</p>\r\n<p>What are triggers? How many triggers you can have on a table? How to invoke a trigger on demand?</p>\r\n<p>Triggers are special kind of stored procedures that get executed automatically when an INSERT, UPDATE or</p>\r\n<p>DELETE operation takes place on a table.</p>\r\n<p>In SQL Server 6.5 you could define only 3 triggers per table, one for INSERT, one for UPDATE and one for</p>\r\n<p>DELETE. From SQL Server 7.0 onwards, this restriction is gone, and you could create multiple triggers per each</p>\r\n<p>action. But in 7.0 there''s no way to control the order in which the triggers fire. In SQL Server 2000 you could</p>\r\n<p>specify which trigger fires first or fires last using sp_settriggerorder</p>\r\n<p>Triggers can''t be invoked on demand. They get triggered only when an Associated action (INSERT, UPDATE,</p>\r\n<p>DELETE) happens on the table on which they are defined.</p>\r\n<p>Triggers are generally used to implement business rules, auditing. Triggers can also be used to extend the</p>\r\n<p>referential integrity checks, but wherever possible, use constraints for this purpose, instead of triggers, as</p>\r\n<p>constraints are much faster.</p>\r\n<p>Till SQL Server 7.0, triggers fire only after the data modification operation happens. So in a way, they are called</p>\r\n<p>post triggers. But in SQL Server 2000 you could create pre triggers also. Search SQL Server 2000 books online</p>\r\n<p>for INSTEAD OF triggers.</p>\r\n<p>Also check out books online for ''inserted table'', ''deleted table'' and COLUMNS_UPDATED()</p>\r\n<p>There is a trigger defined for INSERT operations on a table, in an OLTP system. The trigger is written to</p>\r\n<p>instantiate a COM object and pass the newly insterted rows to it for some custom processing. What do you think</p>\r\n<p>of this implementation? Can this be implemented better?</p>\r\n<p>Instantiating COM objects is a time consuming process and since you are doing it from within a trigger, it slows</p>\r\n<p>down the data insertion process. Same is the case with sending emails from triggers. This scenario can be</p>\r\n<p>better implemented by logging all the necessary data into a separate table, and have a job which periodically</p>\r\n<p>checks this table and does the needful.</p>\r\n<p>What is a self join? Explain it with an example.</p>\r\n<p>Self join is just like any other join, except that two instances of the same table will be joined in the query. Here</p>\r\n<p>is an example:</p>\r\n<p>Employees table which contains rows for normal employees as well as managers. So, to find out the managers</p>\r\n<p>of all the employees, you need a self join.</p>\r\n<p>CREATE TABLE emp</p>\r\n<p>(</p>\r\n<p>empid int,</p>\r\n<p>mgrid int,</p>\r\n<p>empname char(10)</p>\r\n<p>)</p>\r\n<p>INSERT emp SELECT 1,2,''Vyas''</p>\r\n<p>INSERT emp SELECT 2,3,''Mohan''</p>\r\n<p>INSERT emp SELECT 3,NULL,''Shobha''</p>\r\n<p>INSERT emp SELECT 4,2,''Shridhar''</p>\r\n<p>INSERT emp SELECT 5,2,''Sourabh''</p>\r\n<p>SELECT t1.empname [Employee], t2.empname [Manager]</p>\r\n<p>FROM emp t1, emp t2</p>\r\n<p>WHERE t1.mgrid = t2.empid</p>\r\n<p>Here''s an advanced query using a LEFT OUTER JOIN that even returns the employees without managers (super</p>\r\n<p>bosses)</p>\r\n<p>SELECT t1.empname [Employee], COALESCE(t2.empname, ''No manager'') [Manager]</p>\r\n<p>FROM emp t1</p>\r\n<p>LEFT OUTER JOIN</p>\r\n<p>emp t2</p>\r\n<p>ON</p>\r\n<p>t1.mgrid = t2.empid</p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>', 1, 4, 0, 4, '2009-08-17 16:16:00', 62, '', '2009-12-13 05:41:03', 62, 0, '0000-00-00 00:00:00', '2009-08-17 16:16:00', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 1, '', '', 0, 3, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (4, 'How to debug perl programs', 'how-to-debug-perl-programs', '', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">\r\n<div style="margin-top: 0px; margin-bottom: 0px; text-align: center;"><strong>Perl Debugging Tutorial (perldoc perldebtut)</strong></div>\r\n<br /> \r\n<ul style="margin-top: 0px; margin-bottom: 0px;">\r\n<li style="margin-top: 0px; margin-bottom: 0px;">Invoked using -d option of Perl</li>\r\n</ul>\r\n<br /><strong>About Debugging Console:</strong><br /><br />Once you start the debugger using -d option, Perl takes you to the debugger prompt and you''ll see the screen something as below:<br /><br />\r\n<pre style="font-family: ''Courier New''; white-space: pre-wrap; margin: 0px;">        Default die handler restored.<br /><br />	Loading DB routines from perl5db.pl version 1.07<br />	Editor support available.<br /><br />	Enter h or `h h'' for help, or `<a href="http://www.perldoc.com/perl5.6/pod/perldebug.html">man perldebug</a>'' for more help.<br /><br />	main::(-e:1):   0<br />	  DB&lt;1&gt; <br /></pre>\r\n', '\r\n<br />\r\n<div style="margin-top: 0px; margin-bottom: 0px; margin-left: 40px;"><strong>Components :</strong><br />\r\n<div style="margin-top: 0px; margin-bottom: 0px; margin-left: 40px;"><strong>DB </strong>is the debugging module<br /><strong>main</strong>:: says that we are in main module, -e is the statement being executed and we are at<strong> line 1 </strong><br /><br />DB<strong>&lt;1&gt; </strong>is the prompt for the debugger where 1 indicates the command id (i.e., you will be entering first debugger command)</div>\r\n</div>\r\n<br /><strong>How to run the program in debugging mode</strong><br /><br />When you enter the debugger, nothing is still executed by the perl and it shows the first line which it will execute (upon your instruction)<br />\r\n<div style="margin-top: 0px; margin-bottom: 0px; margin-left: 40px;">n -&gt; This executes the next statement without stepping into it<br />s -&gt; This is ''step into'' command and is almost same as ''n'' but will go into the subroutines <br />r  -&gt; This is step out command, means if you are in a subroutine and enter this command, it executes the rest of the function and returns<br />c -&gt; executes till next breakpoint. If you specify the line or subrountine name, it will execute till that point<br />R -&gt; Restart the execution from beginning<br />&lt;CR&gt; - Run the previous ''s'' or ''n'' command <br />q -&gt; Quit the debugger</div>\r\n<br style="font-weight: bold;" /><strong>See the Dynamic Values:</strong><br /><br />x -&gt; Dumps the value of the given variable<br />p -&gt; prints the value of the given variable (same as print)<br />S -&gt; List subroutine names. You can give pattern of the subroutine to (or not to) be matched<br />V  - Displays all variables defaulting to main package. You can specify the package name also <br />X - Same as V but it defaults to current package. <br />M - Lists the modules that are loaded <br /><br style="font-weight: bold;" /><strong>Add breakpoints</strong><br />c &lt;line&gt; | &lt;sub&gt; - This is similar to one time breakpoint where the program will run till that point (if there are no other breakpoints defined before the specified point<br />b &lt;line&gt; - Define the breakpoint for the given line. Point to note is that when we see the code (with v or other commands), a colon (:) will appear before the statement for which we can put breakpoints. If you specify breakpoint on other line, it will fail <br />B &lt;line&gt; | * - Deletes a / all breakpoints<br />L - Lists the breakpoint / actions / events (don''t know about actions and events)<br /><br /><br /><br /><strong>See the source code:</strong><br />Although debugger displays the line it is going to run next, you can also check the source code with following commands<br /><br />hyphen (-) - Display the previous line<br />.               - display the current line of execution<br />l line-range - displays the line of code (range of lines)<br />v              - displays the next window of code<br />f               - Displays source in the file<br /><br /></span></p>', 1, 4, 0, 3, '2009-09-13 05:10:03', 63, '', '2009-12-13 05:42:59', 62, 0, '0000-00-00 00:00:00', '2009-09-13 05:10:03', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 3, 0, 5, '', '', 0, 3, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (5, 'Perl code to list IP address in windows', 'perl-code-to-list-ip-address-in-windows', '', '<div>Generally IPconfig does not list the ips in sequential order. So we can use this script. Infact it uses netsh command which lists the IP in the order they were added.</div>\r\n<pre>  <span style="font-family: courier new,monospace;"><strong>@addr = `netsh interface ip dump`;<br /> foreach (@addr) {<br />  $start = index($_, "addr = ") ;<br />  $end = index($_,"mask ",$start);<br />  if ($start != -1 and $end != -1) {<br />   $offset = $start + length("addr = ");<br />  $length = $end - $offset;<br />   print substr($_, $offset, $length);<br />   print "\\t";<br />  }<br /> }</strong></span> </pre>', '', 1, 4, 0, 3, '2009-12-07 20:19:02', 62, '', '2009-12-13 05:37:28', 62, 0, '0000-00-00 00:00:00', '2009-12-07 20:19:02', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 4, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (6, 'Perl Interpreter', 'i-perl-intepreter', '', '<ol>\r\n<li>What arguments do you frequently use for the Perl interpreter and what do they mean? </li>\r\n<li>What purpose does each of the following serve: -w, strict, -T ? </li>\r\n<li>What is -M option and -e option in Perl </li>\r\n<li>How do u execute single statement of perl directly on command prompt? </li>\r\n<li>Can you create an exe of .pl file? How?<ol>\r\n<li>Yes! you can easily create executable of perl file. use <strong>perlcc-o myExe.exe mainfile.pl </strong>type of syntax, where myExe.exe is the executable name and mainfile.pl, as name indicates, is the main file where the program execution begins. If your code uses other files, pp automatically includes them. If it does not you can add as <strong>perlcc-o myExe.exe mainfile.pl other1.pl other2.pl...</strong></li>\r\n</ol></li>\r\n<li>How do u create modules, create tests for them so that they can be installed using make?</li>\r\n</ol>', '', 1, 1, 0, 2, '2009-12-13 05:44:57', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-13 05:44:57', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 3, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (7, 'Perl Language', 'i-perl-language', '', '<ol>\r\n<li>What does the command ‘use strict’ do and why should you use </li>\r\n<li>What do the symbols $ @ and % mean when prefixing a variable? </li>\r\n<li>What elements of the Perl language could you use to structure your code to allow for maximum re-use and maximum readability? </li>\r\n<li>Explain the difference between <em>my</em> and <em>local</em>. </li>\r\n<li>Explain the <strong>difference between </strong><em><strong>use</strong></em><strong> and </strong><em><strong>require</strong></em><strong>.</strong> \r\n<ul>\r\n<li>use and require both are used to load the libraries (Modules). The difference is that require loads it at run time and does not do any syntax checking while compiling. Where as use loads and checks the (syntax and availability of) module at compile time.\r\n', '\r\n</li>\r\n</ul>\r\n</li>\r\n<li>What is a hash? what is tied hash?</li>\r\n<li>How to create multidimensional array? </li>\r\n<li>What is difference between "<strong>global</strong>" and "<strong>local</strong>" variables. </li>\r\n<li>What is the difference between for &amp; foreach, exec &amp; system? </li>\r\n<li>How do you open a file for writing?</li>\r\n<li>what is map function?</li>\r\n<li>How to identify if a scalar variable is integer, string or floating point value.</li>\r\n<li>localizing $_ with our doesnot work while with local keyword it works. Why?</li>\r\n<li>What is <strong>qw </strong>for? <br /> \r\n<ul>\r\n<li><strong>qw </strong>(I refer it as quote words) is a method that adds quotes to the words separated by whitespace (I think we can change the delimiter) automatically, thus avoiding those tedious typing of quotes to every word. e.g., @arr = ("1", "2","3") and @arr = qw(1 2 3) are same (avoid , and ").</li>\r\n</ul>\r\n</li>\r\n<li>How would you replace a char in string and how do you store the number of replacements? </li>\r\n<li>What is <strong>die </strong>? How it works? Can you redirect the <strong>die </strong>output to <strong>a file? </strong>Can <strong>die </strong>be <strong>used as a signal  (</strong>I wanna do a common cleaning when program terminates using <strong>die)? </strong>Does <strong>die </strong>kills whole <strong>process </strong>or single thread if called in <strong>thread</strong>?<br /> \r\n<ul>\r\n<li><strong>die </strong>is a function that terminates the execution of Perl program. Generally used with some condition (<strong>if </strong>or <strong>unless</strong>) </li>\r\n<li>When "\\n" is appended in the message, die does not display the line number.</li>\r\n</ul>\r\n</li>\r\n<li>What is <strong>pack</strong> in Perl?  \r\n<ul style="background-color: #ffffff;">\r\n<li>\r\n<p><span style="font-family: courier new,courier,mono;">Pack converts a list into a binary representation. Takes an array or list of values and packs it into a binary structure, returning the string containing the structure</span></p>\r\n</li>\r\n</ul>\r\n</li>\r\n<li><span style="font-family: courier new,courier,mono;">How to send reference to subroutine?</span></li>\r\n</ol> \r\n<ul>\r\n<li> \r\n<ul>\r\n<li><span style="font-family: courier new,courier,mono;">As with scalar, hash and array, subroutines have a prefix (optional), &amp;. So to store reference of a function we can use \\&amp;func_name. Mostly &amp; is used when function reference is needed, else it is called directly.</span></li>\r\n</ul>\r\n</li>\r\n</ul>', 1, 1, 0, 2, '2009-12-13 05:43:04', 62, '', '2009-12-13 05:48:36', 62, 0, '0000-00-00 00:00:00', '2009-12-13 05:43:04', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 2, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (8, 'Perl - Quick Reference', 'perl-qr', '', '<p><span style="font-size: large;"><br /><strong>Special Variables</strong></span></p>\r\n<ol>\r\n<li><span style="font-family: courier new,courier,mono;"><strong>General variables</strong><br /></span> \r\n<ul>\r\n<li><span style="font-family: courier new,courier,mono;">$_ - Default variable used by Perl, whose value is used (in Perl functions and loop constructs) if no other variable is specified.</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">@_ - variable that contains the arguments passed to the function. Also this is the default array variable of Perl inside functions. Perl functions that need arrays (like shift, split) uses this if no argument is passed to the function. It is also the default destination of the &lt;&gt; and other I/O operations.<br /></span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">@ARGV - array variable that contains command line arguments. Perl functions that need array arguments if called in <strong>main </strong>@ARGV is used (not @_)</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$ARGV - Name of the current file when reading from &lt;&gt;.<br /></span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$^O  - Readonly variable containing the Operating system name. \r\n', '\r\n</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$^</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$-</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$0 - called as program name, contains the <strong>name of the script </strong>that is running.<br /></span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$+</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$"</span></li>\r\n</ul>\r\n</li>\r\n<li><span style="font-family: courier new,courier,mono;"><strong>Formatting</strong><br /></span> \r\n<ul>\r\n<li><span style="font-family: courier new,courier,mono;"><strong>$,</strong> - Called as <strong>output field separator</strong>, contains the character to display between elements of list. Default value is a '' '' (whitespace). When <strong>IO::Handle</strong> module is used, <strong>output_field_separator</strong>() method can be used for the same purpose.</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$\\ - Called as <strong>output record separator, </strong>contains the character to print at end of every output line. Default value is none. Generally we can put ''\\n'' if we want every line to be in separate line.</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$/ - Called as <strong>input record separator, </strong>contains the character to be used as record separator. i.e., used when reading from file. Default value is ''\\n''.</span> </li>\r\n<li><span style="font-family: courier new,courier,mono;">$. - Called as <strong>input line number, </strong>Contains the current line number read from the input file handle, using &lt;&gt; or getline(). <strong>(Does that mean that whatever read using sysread or read is not included...???? ).</strong></span></li>\r\n</ul>\r\n</li>\r\n<li><strong>Perl Error handling</strong> \r\n<ul>\r\n<li>$? - Called as <strong>child error, </strong>contains the status returned by <strong>last pipe close, backtick </strong>or successful <strong>call to wait()</strong>; a status of 0 generally indicates the success. </li>\r\n<li>$! - called as <strong>errorno variable, </strong>Contains the error number (or error message in string context) from <strong>last system call.</strong> </li>\r\n<li><strong>$^E - </strong>Called as <strong>extended OS error, </strong>contains extended error message from <strong>non-UNIX</strong> operating systems.</li>\r\n</ul>\r\n</li>\r\n<li><strong>Process</strong> \r\n<ul>\r\n<li><strong>$$ - </strong>process ID of current process. </li>\r\n<li><strong>$&lt; </strong>- Real User ID of the current process. Generally used in UNIX/LINUX environment where we need to start a server using one user and change the user to other (lower privileged one). </li>\r\n<li><strong>$&gt; </strong>- Effective User ID of the current process. Corresponds to the effective privileges that a <strong>set-userid</strong> script runs under. </li>\r\n<li><strong>$( </strong>- Real group id (GID) of the current process. </li>\r\n<li><strong>$) </strong>- Effective GID of the current process. corresponds to the effective privileges that a <strong>set-groupid</strong> script runs under.</li>\r\n</ul>\r\n</li>\r\n<li><strong>Perl Environment</strong> \r\n<ul>\r\n<li><strong>%ENV - </strong>Hash containing environment variables (like OS name, Path, etc) </li>\r\n<li><strong>@INC -</strong> Include path. Contains the list of directories to search for Modules (externally referenced code). You can add your own path to it directly or using <strong>use lib </strong>pragma, which does exactly the same thing. </li>\r\n<li><strong>%SIG</strong> - Signal hash, contains the <strong>SIG =&gt; handler</strong> pairs. i.e., the specified subroutine will be called upon occurence of the signal. Commonly used Signal (key value for SIG hash) are INT, HUP, etc. <strong>SIG hash will be empty by default and contain only key/value pairs appended by the programmer.</strong></li>\r\n</ul>\r\n</li>\r\n</ol>\r\n<p><span style="font-family: courier new,courier,mono;"><br /></span></p>', 1, 4, 0, 3, '2009-12-13 05:52:19', 62, '', '2009-12-13 05:59:51', 62, 0, '0000-00-00 00:00:00', '2009-12-13 05:52:19', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 3, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (9, 'Perl General', 'i-perl-general', '', '<ol>\r\n<li>Why do you program in Perl? \r\n<ul>\r\n<li>When heavy text processing is required. </li>\r\n<li>For administrative tasks (System / Network) </li>\r\n<li>Network programming (Sockets) </li>\r\n<li>Web applications </li>\r\n<li>XMLRPC (remote procedures) </li>\r\n<li>Testing applications related to Networking.</li>\r\n</ul>\r\n</li>\r\n<li>What are the characteristics of a project that is well suited to Perl? </li>\r\n<li>Where do you go for Perl help?\r\n', '\r\n</li>\r\n</ol> \r\n<ul>\r\n<li> \r\n<ul>\r\n<li>perldoc (use -f option to get help related to specified function)</li>\r\n<li>CPAN</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n<ol>\r\n<li>Name an instance where you used a CPAN module. </li>\r\n<li>When would you <strong>not</strong> use Perl for a project?</li>\r\n</ol> \r\n<ul>\r\n<li> \r\n<ul>\r\n<li>For database loading </li>\r\n<li>Fast development of application </li>\r\n<li>GUI related</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n<ol>\r\n<li><strong>Which one is better Perl or Shell ? why? </strong> \r\n<ul>\r\n<li><strong>Generally Perl is preferred compared to shell scripts due to many advantages such as : </strong> \r\n<ul>\r\n<li><strong>C like syntax (more full fledged than Shell) </strong></li>\r\n<li><strong>Many modules (reusablility) and functions.<br /> </strong></li>\r\n<li><strong>Can handle complex task easily (like database interaction)</strong></li>\r\n</ul>\r\n</li>\r\n<li><strong>But Shell is faster than Perl as Shell directly interacts with Kernel.</strong></li>\r\n</ul>\r\n</li>\r\n<li>Disadvantages of Perl over C? \r\n<ul>\r\n<li>Perl is built using C. So all advantages available in C are available in Perl. </li>\r\n<li>C is faster than Perl. </li>\r\n<li>C can have executable whereas Perl does not</li>\r\n</ul>\r\n</li>\r\n<li><br /><br /><br /></li>\r\n</ol>', 1, 1, 0, 2, '2009-12-13 05:59:58', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-13 05:59:58', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 1, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (10, 'Perl API ', 'adv-perl-api', '', '<p><br /><strong><span style="text-decoration: underline;">Variables - Datatypes:</span></strong><br />Perl has three typedefs that handle Perl''s three main data types, viz Scalar, Array and Hash, named respectively as SV, AV and HV<br />Each typedef has specific routine to manipulate various data types<br /><br /><strong>What is IV?</strong><br />IV is a simple signed integer type, which is guaranteed to be large enough to hold integer value and pointer. <br />UV is similar to IV, but is unsigned<br />I32, I16, U32 and U16 are scaled versions of IV and UV to store 16 and 32 bit signed and unsigned data respectively</p>\r\n', '\r\n<p><br /><strong>Scalar Variables, SVs</strong></p>\r\n<p> </p>\r\n<ul>\r\n<li>An SV can be created and loaded with one command.</li>\r\n<li>Five types of values that can be loaded are  \r\n<ul>\r\n<li> Integer value (IV)</li>\r\n<li> Unsigneed Integer (UV)</li>\r\n<li> Double (NV)</li>\r\n<li> String (PV)</li>\r\n<li> Another Scalar (SV)</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n<p> </p>\r\n<div>\r\n<table id="k1ob" class="zeroBorder" style="height: 720px;" border="0" cellspacing="0" cellpadding="3" width="938">\r\n<tbody>\r\n<tr>\r\n<td style="background-color: #999999;" width="50%"><strong>Category / Purpose</strong><br /></td>\r\n<td style="background-color: #999999;" width="50%"><strong>Function(s)</strong><br /></td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Create New Scalar Variable<br /></td>\r\n<td style="font-family: Courier New;" width="50%">\r\n<ul>\r\n<li>SV* newSViv(IV)</li>\r\n<li>SV* newSVuv(UV)</li>\r\n<li>SV* newSVnv(double)</li>\r\n<li>SV* newSVpv(const char*, STRLEN)</li>\r\n<li>SV* newSVpvn(const char*, STRLEN)</li>\r\n<li>SV* newSVpvf(const char*, ...)</li>\r\n<li>SV* newSVsv(SV*)</li>\r\n</ul>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Modify existing Scalar Variable<br /></td>\r\n<td style="font-family: Courier New;" width="50%">\r\n<ul>\r\n<li>void sv_setiv(SV*, IV)</li>\r\n<li>void sv_setuv(SV*, UV)</li>\r\n<li>void sv_setnv(SV*, double)</li>\r\n<li>void sv_setpv(SV*, const char*)</li>\r\n<li>void sv_setpvn(SV*, const char*, STRLEN)</li>\r\n<li>void sv_setpvf(SV*, const char *, ...)</li>\r\n<li>void sv_vsetpvfn(SV*, const char *, STRLEN, va_list *, SV **, I32, bool *)</li>\r\n</ul>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Read / Access the value of Scalar Variable<br /></td>\r\n<td style="font-family: Courier New;" width="50%">\r\n<ul>\r\n<li>SvIV(SV*)</li>\r\n<li>SvUV(SV*)</li>\r\n<li>SvNV(SV*)</li>\r\n<li>SvPV(SV*, STRLEN len)</li>\r\n</ul>\r\n<ul>\r\n<li>SvPV_nolen(SV*)</li>\r\n</ul>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Identify Type of data in the SV<br /></td>\r\n<td style="font-family: Courier New;" width="50%">\r\n<ul>\r\n<li>SvIOK(SV*)</li>\r\n<li>SvNOK(SV*)</li>\r\n<li>SvPOK(SV*)</li>\r\n</ul>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Check if Scalar value is TRUE<br /></td>\r\n<td style="font-family: Courier New;" width="50%">SvTRUE(SV*)<br /></td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Force perl to allocate more memory to SV<br /></td>\r\n<td style="font-family: Courier New;" width="50%">SvGROW(SV*, STRLEN newlen)<br /></td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Get / Set current length of strings stored in SV<br /></td>\r\n<td style="font-family: Courier New;" width="50%">SvCUR(SV*)<br />SvCUR_set(SV*, I32 val)<br /></td>\r\n</tr>\r\n<tr>\r\n<td width="50%">To append something to end of string<br /></td>\r\n<td style="font-family: Courier New;" width="50%">\r\n<pre class="verbatim">    <span class="w">void</span>  <span class="i">sv_catpv</span><span class="s">(</span><span class="w">SV</span>*<span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>*<span class="s">)</span><span class="sc">;</span><br />    <span class="w">void</span>  <span class="i">sv_catpvn</span><span class="s">(</span><span class="w">SV</span>*<span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>*<span class="cm">,</span> <span class="w">STRLEN</span><span class="s">)</span><span class="sc">;</span><br />    <span class="w">void</span>  <span class="i">sv_catpvf</span><span class="s">(</span><span class="w">SV</span>*<span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>*<span class="cm">,</span> ...<span class="s">)</span><span class="sc">;</span><br />    <span class="w">void</span>  <span class="i">sv_vcatpvfn</span><span class="s">(</span><span class="w">SV</span>*<span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>*<span class="cm">,</span> <span class="w">STRLEN</span><span class="cm">,</span> <span class="w">va_list</span> *<span class="cm">,</span> <span class="w">SV</span> **<span class="cm">,</span> <span class="w">I32</span><span class="cm">,</span> <span class="w">bool</span><span class="s">)</span><span class="sc">;</span><br />    <span class="w">void</span>  <span class="i">sv_catsv</span><span class="s">(</span><span class="w">SV</span>*<span class="cm">,</span> <span class="w">SV</span>*<span class="s">)</span><span class="sc">;    </span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td width="50%">a pointer to its SV by using name of Scalar Variable<br /></td>\r\n<td style="font-family: Courier New;" width="50%">SV* get_sv(''variable name '', FALSE)<br /></td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Check if variable is defined or not<br /></td>\r\n<td style="font-family: Courier New;" width="50%">SvOK(SV*)<br /></td>\r\n</tr>\r\n<tr>\r\n<td width="50%">Remove character from beginning of string<br /></td>\r\n<td style="font-family: Courier New;" width="50%">sv_chop(SV*)<br /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n<p><br />TODO: flesh of SV <br /><br /><strong>Array Variables - AV <br /><br /></strong>Unlike SV which is created and loaded with one command, AVs can be created or created and loaded. That means there are two ways to create AV</p>\r\n<div>\r\n<table id="v57a" border="1" cellspacing="0" cellpadding="3" width="100%" bordercolor="#000000">\r\n<tbody>\r\n<tr>\r\n<td style="background-color: #999999;">Purpose / Category<br /></td>\r\n<td style="background-color: #999999;">Function Name<br /></td>\r\n</tr>\r\n<tr>\r\n<td>Create AV<br /></td>\r\n<td>\r\n<pre class="verbatim"> <span class="w">AV</span>*  <span class="i">newAV</span><span class="s">(</span><span class="s">)</span><span class="sc">; - Creates an Empty AV<br /></span> <span class="w">AV</span>*  <span class="i">av_make</span><span class="s">(</span><span class="w">I32</span> <span class="w">num</span><span class="cm">,</span> <span class="w">SV</span> **<span class="w">ptr</span><span class="s">)</span><span class="sc">; - Creates and populates the AV with SVs    </span><br /></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Manipulate AVs<br /></td>\r\n<td>void av_push(AV*, SV*)<br />SV* av_pop(AV*)<br />SV* av_shift(AV*)<br />void av_unshift(AV*, I32 num) - Adds num elements at front of array with undef as value<br />void av_clear(AV*)<br />void av_undef(AV*)<br />void av_extended(AV*, I32 key)<br /></td>\r\n</tr>\r\n<tr>\r\n<td>Manipulate element of AV<br /></td>\r\n<td>I32 av_len(AV*)<br />SV** av_fetch(AV*, I32 key, I32 lval)<br />SV** av_status(AV*, I32 key, SV* val)<br /><br /></td>\r\n</tr>\r\n<tr>\r\n<td>Pointer to AV given the name of variable<br /></td>\r\n<td>AV* get_av(''fully::scoped::var::name'', FALSE)<br /></td>\r\n</tr>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n<p><br /><br /></p>\r\n<ul>\r\n<li>The <span class="w">av_len</span> function returns the highest index value in array (just like $#array in Perl).</li>\r\n<li>The <span class="w">av_fetch</span> function returns the value at index <span class="w">key</span> , but if <span class="w">lval</span> is non-zero, then <span class="w">av_fetch</span> will store an undef value at that index.</li>\r\n<li>The <span class="w">av_store</span> function stores the value <span class="w">val</span> at index <span class="w">key</span> , and<strong> does not increment the reference count of </strong><span class="w">val</span>. The caller is responsible for taking care of that, and if <span class="w">av_store</span> returns <strong>NULL</strong>, the caller will have to decrement the reference count to avoid a memory leak.</li>\r\n<li>The <span class="w">av_clear</span> function <strong>deletes </strong>all the <strong>elements </strong>in the <strong>AV* </strong>array, but <strong>does not </strong>actually <strong>delete </strong>the <strong>array </strong>itself.  The <span class="w">av_undef</span> function will <strong>delete </strong>all the <strong>elements </strong>in the array <strong>plus the array </strong>itself. </li>\r\n<li><span class="w">av_extend</span> function extends the array so that it contains at least <span class="w">key</span>+<span class="n">1</span> elements.  If <span class="w">key</span>+<span class="n">1</span> is less than the currently allocated length of the array, then nothing is done.</li>\r\n</ul>\r\n<p><br /><strong>Working with Hash Variables - HVs</strong><br /><br /></p>\r\n<div>\r\n<table id="bzwz" border="1" cellspacing="0" cellpadding="3" width="100%" bordercolor="#000000">\r\n<tbody>\r\n<tr>\r\n<td style="background-color: #999999;">Category / Purpose<br /></td>\r\n<td style="background-color: #999999;">Function Signature<br /></td>\r\n</tr>\r\n<tr>\r\n<td>Create a HV<br /></td>\r\n<td>HV* newHV();<br /></td>\r\n</tr>\r\n<tr>\r\n<td>Manipulate HV<br /></td>\r\n<td>SV** hv_store(HV*, const char* key, U32 klen, SV* val, U32 hash)<br />SV** hv_fetch(HV*, const char* key, U32 klen, I32 lval)<br />\r\n<div style="margin-left: 40px;">klen - length of the key being passed<br />hash - precomputed hash value</div>\r\nbool hv_exists(HV*, const char* key, U32 klen)<br />SV* hv_delete(AV*, const char* key, U32 klen, I32 flags)<br />void hv_clear(AV* ) - Similar to AV Counterpart<br />void hv_undef(AV* ) - <br /></td>\r\n</tr>\r\n<tr>\r\n<td>Pointer to HV given the name of variable</td>\r\n<td>\r\n<pre class="verbatim">    <span class="w">HV</span>*  <span class="i">get_hv</span><span class="s">(</span><span class="q">"package::varname"</span><span class="cm">,</span> <span class="w">FALSE</span><span class="s">)</span><span class="sc">;</span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Hash API Extensions<br /></td>\r\n<td>\r\n<pre class="verbatim"><span class="w">HE</span>*     <span class="w">hv_fetch_ent</span>  <span class="s">(</span><span class="w">HV</span>* <span class="w">tb</span><span class="cm">,</span> <span class="w">SV</span>* <span class="w">key</span><span class="cm">,</span> <span class="w">I32</span> <span class="w">lval</span><span class="cm">,</span> <span class="w">U32</span> <span class="w">hash</span><span class="s">)</span><span class="sc">;</span><br /><span class="w">HE</span>*     <span class="w">hv_store_ent</span>  <span class="s">(</span><span class="w">HV</span>* <span class="w">tb</span><span class="cm">,</span> <span class="w">SV</span>* <span class="w">key</span><span class="cm">,</span> <span class="w">SV</span>* <span class="w">val</span><span class="cm">,</span> <span class="w">U32</span> <span class="w">hash</span><span class="s">)</span><span class="sc">;<br /></span><span class="w">bool</span>    <span class="w">hv_exists_ent</span> <span class="s">(</span><span class="w">HV</span>* <span class="w">tb</span><span class="cm">,</span> <span class="w">SV</span>* <span class="w">key</span><span class="cm">,</span> <span class="w">U32</span> <span class="w">hash</span><span class="s">)</span><span class="sc">;</span><br /><span class="w">SV</span>*     <span class="w">hv_delete_ent</span> <span class="s">(</span><span class="w">HV</span>* <span class="w">tb</span><span class="cm">,</span> <span class="w">SV</span>* <span class="w">key</span><span class="cm">,</span> <span class="w">I32</span> <span class="w">flags</span><span class="cm">,</span> <span class="w">U32</span> <span class="w">hash</span><span class="s">)</span><span class="sc">;<br /></span><span class="w">SV</span>*     <span class="w">hv_iterkeysv</span>  <span class="s">(</span><span class="w">HE</span>* <span class="w">entry</span><span class="s">)</span><span class="sc">;</span><span class="sc"><br /></span></pre>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n<p> </p>\r\n<ul>\r\n<li>For hv_fetch(), the <span class="w">lval</span> parameter indicates whether this fetch is actually a part of a store operation, in which case a new undefined value will be added to the HV with the supplied key and <span class="w">hv_fetch</span> will return as if the value had already existed.</li>\r\n<li>In hv_delete() if flag does not contain G_DISCARD flag, the mortal value of the element will be returned. </li>\r\n</ul>\r\n<p> </p>\r\n<ul>\r\n<li>Some AV and HV functions return SV** and not SV*. This means to access the scalar value, you have to dereference the return value. Also you''ve to make sure that the value is not NULL before dereferencing</li>\r\n<li>The hash algorithm is defined in the <span class="i">PERL_HASH</span><span class="s">(</span><span class="w">hash</span><span class="cm">,</span> <span class="w">key</span><span class="cm">,</span> <span class="w">klen</span><span class="s">)</span> macro</li>\r\n<li>Perl keeps the actual data in linked list of structures with a typedef of HE. These contain the actual key and value pointers (plus extra administrative overhead).  The key is a string pointer; the value is an <span class="w">SV</span>* .  However, once you have an <span class="w">HE</span>* , to get the actual key and value, use the routines specified below</li>\r\n</ul>\r\n<p><br /><br /></p>\r\n<pre class="verbatim">    I32    hv_iterinit(HV*);<br />            /* Prepares starting point to traverse hash table */<br />    HE*    hv_iternext(HV*);<br />            /* Get the next entry, and return a pointer to a<br />               structure that has both the key and value */<br />    char*  hv_iterkey(HE* entry, I32* retlen);<br />            /* Get the key from an HE structure and also return<br />               the length of the key string */<br />    SV*    hv_iterval(HV*, HE* entry);<br />            /* Return an SV pointer to the value of the HE<br />               structure */<br />    SV*    hv_iternextsv(HV*, char** key, I32* retlen);<br />            /* This convenience routine combines hv_iternext,<br />	       hv_iterkey, and hv_iterval.  The key and retlen<br />	       arguments are return values for the key and its<br />	       length.  The value is returned in the SV* argument */</pre>\r\n<p><br /><br /></p>\r\n<p>The following macros must always be used to access the contents of hash entries.  Note that the arguments to these macros must be simple variables, since they may get evaluated more than once.  See <a href="http://perldoc.perl.org/perlapi.html">perlapi</a> for detailed descriptions of these macros.</p>\r\n<pre class="verbatim">    HePV(HE* he, STRLEN len)<br />    HeVAL(HE* he)<br />    HeHASH(HE* he)<br />    HeSVKEY(HE* he)<br />    HeSVKEY_force(HE* he)<br />    HeSVKEY_set(HE* he, SV* sv)</pre>\r\n<p> </p>\r\n<p>These two lower level macros are defined, but must only be used when dealing with keys that are not <span class="w">SV</span>* s:</p>\r\n<pre class="verbatim">    HeKEY(HE* he)<br />    HeKLEN(HE* he)<br /><br />Note that both <span class="w">hv_store</span> and <span class="w">hv_store_ent</span> do not increment thereference count of the stored <span class="w">val</span>, which is the caller''s responsibility.<br />If these functions return a NULL value, the caller will usually have todecrement the reference count of <span class="w">val</span> to avoid a memory leak.<br /><br /></pre>\r\n<p><strong>AV, HV and undefined variables</strong><br /><br />Sometimes you have to store undefined values in AVs or HVs. Although this may be a rare case, it can be tricky. That''s because you''re used to using <span class="i">&amp;PL_sv_undef</span> if you need an undefined SV.<br /><br /></p>\r\n<pre class="verbatim">   <span class="w">AV</span> *<span class="w">av</span> = <span class="i">newAV</span><span class="s">(</span><span class="s">)</span><span class="sc">;</span><br />    <span class="i">av_store</span><span class="s">(</span> <span class="w">av</span><span class="cm">,</span> <span class="n">0</span><span class="cm">,</span> <span class="i">&amp;PL_sv_undef</span> <span class="s">)</span><span class="sc">;<br /><br /></span></pre>\r\n<p>is equivalent to this Perl code:</p>\r\n<p><a class="l_k" href="http://perldoc.perl.org/functions/my.html">my</a> <span class="i">@av</span><span class="sc">;</span> <span class="i">$av</span>[<span class="n">0</span>] = <a class="l_k" href="http://perldoc.perl.org/functions/undef.html">undef</a><span class="sc">;<br /><br /></span>Unfortunately, this isn''t true. AVs use <span class="i">&amp;PL_sv_undef</span> as a marker for indicating that an array element has not yet been initialized. Thus, <a class="l_k" href="http://perldoc.perl.org/functions/exists.html">exists</a> <span class="i">$av</span>[<span class="n">0</span>]  would be true for the above Perl code, but false for the array generated by the XS code.<br />Other problems can occur when storing <span class="i">&amp;PL_sv_undef</span> in HVs:</p>\r\n<pre class="verbatim">    <span class="i">hv_store</span><span class="s">(</span> <span class="w">hv</span><span class="cm">,</span> <span class="q">"key"</span><span class="cm">,</span> <span class="n">3</span><span class="cm">,</span> <span class="i">&amp;PL_sv_undef</span><span class="cm">,</span> <span class="n">0</span> <span class="s">)</span><span class="sc">;</span></pre>\r\n<p>This will indeed make the value <a class="l_k" href="http://perldoc.perl.org/functions/undef.html">undef</a>, but if you try to modify the value of <span class="w">key</span> , you''ll get the following error:</p>\r\n<pre class="verbatim">    <span class="w">Modification</span> <span class="w">of</span> <span class="w">non</span>-<span class="w">creatable</span> <span class="w">hash</span> <span class="w">value</span> <span class="w">attempted</span></pre>\r\n<p>In perl 5.8.0, <span class="i">&amp;PL_sv_undef</span> was also used to mark placeholders in restricted hashes. This caused such hash entries not to appear when iterating over the hash or when checking for the keys with the <span class="w">hv_exists</span> function.</p>\r\n<p>You can run into similar problems when you store <span class="i">&amp;PL_sv_true</span> or <span class="i">&amp;PL_sv_false</span> into AVs or HVs. Trying to modify such elements will give you the following error:</p>\r\n<pre class="verbatim">    <span class="w">Modification</span> <span class="w">of</span> <span class="w">a</span> <a class="l_k" href="http://perldoc.perl.org/functions/read.html">read</a>-<span class="w">only</span> <span class="w">value</span> <span class="w">attempted<br /><br /></span></pre>\r\n<p>Generally, if you want to store an undefined value in an AV or HV, you should not use <span class="i">&amp;PL_sv_undef</span> , but rather create a new undefined value using the <span class="w">newSV</span> function, for example:</p>\r\n<p><span class="i">av_store</span><span class="s">(</span> <span class="w">av</span><span class="cm">,</span> <span class="n">42</span><span class="cm">,</span> <span class="i">newSV</span><span class="s">(</span><span class="n">0</span><span class="s">)</span> <span class="s">)</span><span class="sc">;</span> <br /><span class="i">hv_store</span><span class="s">(</span> <span class="w">hv</span><span class="cm">,</span> <span class="q">"foo"</span><span class="cm">,</span> <span class="n">3</span><span class="cm">,</span> <span class="i">newSV</span><span class="s">(</span><span class="n">0</span><span class="s">)</span><span class="cm">,</span> <span class="n">0</span> <span class="s">)</span><span class="sc">;</span></p>\r\n<pre class="verbatim"><br /></pre>\r\n<p><strong>References</strong></p>\r\n<pre class="verbatim"><div><table id="h_8w" class="zeroBorder" border="0" cellspacing="0" cellpadding="3" width="100%"><tbody><tr><td><br /></td><td><br /></td></tr><tr><td>Create Reference variable<br /></td><td><pre class="verbatim">SV* newRV_inc((SV*) thing);<br />SV* newRV_noinc((SV*) thing);<br /><pre class="verbatim">SV* newRV_inc((AV*) thing);<br />SV* newRV_noinc((AV*) thing);</pre>\r\n<br />SV* newRV_inc((HV*) thing);<br />SV* newRV_noinc((HV*) thing);    <br /><span class="w"><br />newRV_inc </span>increments the reference count of the <span class="w">thing</span><br /><span class="w">newRV_noinc </span>does no</pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Dereference the reference<br /></td>\r\n<td>\r\n<pre class="verbatim"> <span class="i">SvRV</span><span class="s">(</span><span class="w">SV</span>*<span class="s">)</span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Check if SV is a reference<br /></td>\r\n<td>\r\n<pre class="verbatim"><span class="i">SvROK</span><span class="s">(</span><span class="w">SV</span>*<span class="s">)        </span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>To check what type of value a reference refer to <br /></td>\r\n<td>\r\n<pre class="verbatim">    <span class="i">SvTYPE</span><span class="s">(</span><span class="i">SvRV</span><span class="s">(</span><span class="w">SV</span>*<span class="s">)</span><span class="s">)<br />Types returned are (common)<br /></span>    SVt_IV    Scalar<br />    SVt_NV    Scalar<br />    SVt_PV    Scalar<br />    SVt_RV    Scalar<br />    SVt_PVAV  Array<br />    SVt_PVHV  Hash<br />    SVt_PVCV  Code<br />    SVt_PVGV  Glob (possible a file handle)<br />    SVt_PVMG  Blessed or Magical Scalar<br /></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Bless the reference into a package<br /></td>\r\n<td>\r\n<pre class="verbatim"> <span class="w">SV</span>* <span class="i">sv_bless</span><span class="s">(</span><span class="w">SV</span>* <span class="w">sv</span><span class="cm">,</span> <span class="w">HV</span>* <span class="w">stash</span><span class="s">)</span><span class="sc">;    <br />sv is the reference value, and stash specifies which class the reference belongs to<br /></span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n<br /><br /></pre>\r\n<p><strong>Class Objects (Blessed References)</strong><br /><br />In perl''s OO lexicon, an object is simply a reference that has been blessed into a package (or class).<br /><br /></p>\r\n<div>\r\n<table id="hwdr" class="zeroBorder" border="0" cellspacing="0" cellpadding="3" width="100%">\r\n<tbody>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n<tr>\r\n<td>new class objects<br /></td>\r\n<td>\r\n<pre class="verbatim"><span class="w">SV</span>* <span class="i">newSVrv</span><span class="s">(</span><span class="w">SV</span>* <span class="w">rv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">classname</span><span class="s">)</span><span class="sc">;</span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Other functions<br /></td>\r\n<td>\r\n<pre class="verbatim">	<span class="w">SV</span>* <span class="i">sv_setref_iv</span><span class="s">(</span><span class="w">SV</span>* <span class="w">rv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">classname</span><span class="cm">,</span> <span class="w">IV</span> <span class="w">iv</span><span class="s">)</span><span class="sc">;</span><br />	<span class="w">SV</span>* <span class="i">sv_setref_uv</span><span class="s">(</span><span class="w">SV</span>* <span class="w">rv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">classname</span><span class="cm">,</span> <span class="w">UV</span> <span class="w">uv</span><span class="s">)</span><span class="sc">;</span><br />	<span class="w">SV</span>* <span class="i">sv_setref_nv</span><span class="s">(</span><span class="w">SV</span>* <span class="w">rv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">classname</span><span class="cm">,</span> <span class="w">NV</span> <span class="w">iv</span><span class="s">)</span><span class="sc">;<br /><br />These copy IV, UV, or NV into SV whose reference is in rv. SV is blessed <br />if classname is not-null.</span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Copies the pointer value (<em>the address, not the string!</em>) <br />into an SV whose reference is rv.  SV is blessed if <span class="w">classname</span> is non-null.</td>\r\n<td>\r\n<pre class="verbatim"><span class="w">SV</span>* <span class="i">sv_setref_pv</span><span class="s">(</span><span class="w">SV</span>* <span class="w">rv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">classname</span><span class="cm">,</span> <span class="w">PV</span> <span class="w">iv</span><span class="s">)</span><span class="sc">;</span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>\r\n<pre class="verbatim">Copies string into an SV whose reference is <span class="w">rv</span>. <br />Set length to 0 to let Perl calculate the string length.<br />SV is blessed if <span class="w">classname</span> is non-null.      <br />            </pre>\r\n</td>\r\n<td>\r\n<pre class="verbatim"><span class="w">SV</span>* <span class="i">sv_setref_pvn</span><span class="s">(</span><span class="w">SV</span>* <span class="w">rv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">classname</span><span class="cm">,</span> <span class="w">PV</span> <span class="w">iv</span><span class="cm">,</span> <span class="w">STRLEN</span> <a class="l_k" href="http://perldoc.perl.org/functions/length.html">length</a><span class="s">)</span><span class="sc">;</span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Tests whether the SV is blessed into the specified class.  It does not check inheritance relationships</td>\r\n<td>\r\n<pre class="verbatim"><a class="l_k" href="http://perldoc.perl.org/functions/int.html">int</a>  <span class="i">sv_isa</span><span class="s">(</span><span class="w">SV</span>* <span class="w">sv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">name</span><span class="s">)</span><span class="sc">;</span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Tests whether the SV is a reference to a blessed object</td>\r\n<td>\r\n<pre class="verbatim"><a class="l_k" href="http://perldoc.perl.org/functions/int.html">int</a>  <span class="i">sv_isobject</span><span class="s">(</span><span class="w">SV</span>* <span class="w">sv</span><span class="s">)</span><span class="sc">;    </span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>Tests whether the SV is derived from the specified class.</td>\r\n<td>\r\n<pre class="verbatim"><span class="w">bool</span> <span class="i">sv_derived_from</span><span class="s">(</span><span class="w">SV</span>* <span class="w">sv</span><span class="cm">,</span> <span class="w">const</span> <span class="w">char</span>* <span class="w">name</span><span class="s">)</span><span class="sc">;    <br /></span>SV can be either a reference to a blessed object or<br /> a string containing a class name. <br /></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n<p><br /><br /><strong>Creating New Variables</strong></p>\r\n<div>\r\n<table id="c_1e" class="zeroBorder" border="0" cellspacing="0" cellpadding="3" width="100%">\r\n<tbody>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n<tr>\r\n<td>Create new perl variable with undef value<br /></td>\r\n<td>\r\n<pre class="verbatim"><span class="w">SV</span>*  <span class="i">get_sv</span><span class="s">(</span><span class="q">"package::varname"</span><span class="cm">,</span> <span class="w">TRUE</span><span class="s">)</span><span class="sc">;</span><br />    <span class="w">AV</span>*  <span class="i">get_av</span><span class="s">(</span><span class="q">"package::varname"</span><span class="cm">,</span> <span class="w">TRUE</span><span class="s">)</span><span class="sc">;</span><br />    <span class="w">HV</span>*  <span class="i">get_hv</span><span class="s">(</span><span class="q">"package::varname"</span><span class="cm">,</span> <span class="w">TRUE</span><span class="s">)</span><span class="sc">;<br /><br />Note: functions are same... but second parameter have<br />TRUE    <br /></span></pre>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n<tr>\r\n<td><br /></td>\r\n<td><br /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n<p><br />There are additional macros whose values may be bitwise OR''ed with the <span class="w">TRUE</span> argument to enable certain extra features.  <br /><br /><strong>GV_ADDMULTI </strong>Marks the variable as multiply defined, thus preventing the "Name &lt;varname&gt; used only once: possible typo" warning<br /><strong>GV_ADDWARN </strong>Issues the warning: "Had to create &lt;varname&gt; unexpectedly" if the variable did not exist before the function was called<br /><br />If you do not specify a package name, the variable is created in the current package.<br /><br /><br /><strong>Reference Counts and Mortality<br /><br /></strong>Perl uses a reference count-driven garbage collection mechanism. SVs, AVs, or HVs (xV for short in the following) start their life with a reference count of 1.  If the reference count of an xV ever drops to 0, then it will be destroyed and its memory made available for reuse.<br />This normally doesn''t happen at the Perl level unless a variable is undef''ed or the last variable holding a reference to it is changed or overwritten.  At the internal level, however, reference counts can be manipulated with the following macros:</p>\r\n<pre class="verbatim">    <a class="l_k" href="http://perldoc.perl.org/functions/int.html">int</a> <span class="i">SvREFCNT</span><span class="s">(</span><span class="w">SV</span>* <span class="w">sv</span><span class="s">)</span><span class="sc">;</span><br />    <span class="w">SV</span>* <span class="i">SvREFCNT_inc</span><span class="s">(</span><span class="w">SV</span>* <span class="w">sv</span><span class="s">)</span><span class="sc">;</span><br />    <span class="w">void</span> <span class="i">SvREFCNT_dec</span><span class="s">(</span><span class="w">SV</span>* <span class="w">sv</span><span class="s">)</span><span class="sc">;<br /><br />Also </span><span class="w">newRV_inc function manipulates the reference count (as seen above).<br /><br /><br /></span></pre>\r\n<p><br /><strong>Mortal Variables</strong><br /><br />There are some convenience functions available that can help with the destruction of xVs.  These functions introduce the concept of "mortality". An xV that is mortal has had its reference count marked to be decremented, but not actually decremented, until "a short time later".  Generally the term "short time later" means a single Perl statement, such as a call to an XSUB function.  The actual determinant for when mortal xVs have their reference count decremented depends on two macros, SAVETMPS and FREETMPS<br /><br /></p>\r\n<p>"Mortalization" then is at its simplest a deferred <span class="w">SvREFCNT_dec</span> . However, if you mortalize a variable twice, the reference count will later be decremented twice.</p>\r\n<p>"Mortal" SVs are mainly used for SVs that are placed on perl''s stack.To create a mortal variable, use the functions:</p>\r\n<pre class="verbatim">    SV*  sv_newmortal()<br />    SV*  sv_2mortal(SV*)<br />    SV*  sv_mortalcopy(SV*)</pre>\r\n<p>The first call creates a mortal SV (with no value), the second converts an existing SV to a mortal SV (and thus defers a call to <span class="w">SvREFCNT_dec</span> ), and the third creates a mortal copy of an existing SV. Because <span class="w">sv_newmortal</span> gives the new SV no value,it must normally be given one via <span class="w">sv_setpv</span> , <span class="w">sv_setiv</span> , etc. :<br /><br /><br /></p>\r\n<p>You should be careful about creating mortal variables.  Strange things can happen if you make the same value mortal within multiple contexts, or if you make a variable mortal multiple times. Thinking of "Mortalization" as deferred <span class="w">SvREFCNT_dec</span> should help to minimize such problems. For example if you are passing an SV which you <em>know</em> has high enough REFCNT to survive its use on the stack you need not do any mortalization. If you are not sure then doing an <span class="w">SvREFCNT_inc</span> and <span class="w">sv_2mortal</span> , or making a <span class="w">sv_mortalcopy</span> is safer.</p>\r\n<p>The mortal routines are not just for SVs -- AVs and HVs can be made mortal by passing their address (type-casted to <span class="w">SV</span>* ) to the <span class="w">sv_2mortal</span> or <span class="w">sv_mortalcopy</span> routines.</p>\r\n<p> </p>\r\n<p><strong>Stashes and Globs</strong></p>\r\n<p>A <strong>stash</strong> is a hash that contains all variables that are defined within a package.  Each key of the stash is a symbol name (shared by all the different types of objects that have the same name), and each value in the hash table is a GV (Glob Value).  This GV in turn contains references to the various objects of that name, including (but not limited to) the following:</p>\r\n<pre class="verbatim">    <span class="w">Scalar</span> <span class="w">Value</span><br />    <span class="w">Array</span> <span class="w">Value</span><br />    <span class="w">Hash</span> <span class="w">Value</span><br />    <span class="w">I</span>/<span class="w">O</span> <span class="w">Handle</span><br />    <span class="w">Format</span><br />    <span class="w">Subroutine</span></pre>\r\n<p>There is a single stash called <span class="w">PL_defstash</span> that holds the items that exist in the <span class="w">main</span> package.  To get at the items in other packages, append the string "::" to the package name.  The items in the <span class="w">Foo</span> package are in the stash <span class="w">Foo::</span> in PL_defstash.</p>\r\n<p>To get the stash pointer for a particular package, use the function:</p>\r\n<pre class="verbatim">    HV*  gv_stashpv(const char* name, I32 flags)<br />    HV*  gv_stashsv(SV*, I32 flags)</pre>\r\n<p>The first function takes a literal string, the second uses the string stored in the SV.  Remember that a stash is just a hash table, so you get back an <span class="w">HV</span>* .  The <span class="w">flags</span> flag will create a new package if it is set to GV_ADD.</p>\r\n<p>The name that <span class="w">gv_stash</span>*<span class="w">v</span> wants is the name of the package whose symbol table you want.  The default package is called <span class="w">main</span> .  If you have multiply nested packages, pass their names to <span class="w">gv_stash</span>*<span class="w">v</span> , separated by <span class="w">::</span> as in the Perl language itself.</p>\r\n<p> </p>\r\n<p> </p>\r\n<p>if you have an SV that is a blessed reference, you can find out the stash pointer by using:</p>\r\n<pre class="verbatim">    <span class="w">HV</span>*  <span class="i">SvSTASH</span><span class="s">(</span><span class="i">SvRV</span><span class="s">(</span><span class="w">SV</span>*<span class="s">)</span><span class="s">)</span><span class="sc">;</span></pre>\r\n<p>then use the following to get the package name itself:</p>\r\n<pre class="verbatim">    <span class="w">char</span>*  <span class="i">HvNAME</span><span class="s">(</span><span class="w">HV</span>* <span class="w">stash</span><span class="s">)</span><span class="sc">;</span></pre>\r\n<p>If you need to bless or re-bless an object you can use the following function:</p>\r\n<pre class="verbatim">    <span class="w">SV</span>*  <span class="i">sv_bless</span><span class="s">(</span><span class="w">SV</span>*<span class="cm">,</span> <span class="w">HV</span>* <span class="w">stash</span><span class="s">)</span></pre>\r\n<p>where the first argument, an <span class="w">SV</span>* , must be a reference, and the second argument is a stash.  The returned <span class="w">SV</span>*  can now be used in the same way as any other SV.</p>\r\n<p> </p>\r\n<p> </p>\r\n<p>Double-Typed SVs</p>', 1, 4, 0, 3, '2009-12-13 06:21:59', 62, '', '2009-12-13 06:30:57', 62, 0, '0000-00-00 00:00:00', '2009-12-13 06:21:59', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 2, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (11, 'Perl XS ', 'adv-perl-xs', '', '<p>SWIG and XS are two toolsets used to bind C and Perl code together. While XS comes built with Perl, it has its own downsides. SWIG is built by Dave <a class="indexterm" name="ch18-idx-971889-0"></a>Beazley at University of Utah. SWIG is acronym for Simplified Wrapper and Interface Generator. <br /><br />XS and SWIG both tools create glue files for interfacing C with Perl. Both create a Perl package and a C wrapper file to address the following issues:</p>\r\n<ul>\r\n<li>Data type translations</li>\r\n<li>Memory management</li>\r\n<li>Perl convinience ( multiple returns, wantarray, etc to give feel @ home for Perl programmers)</li>\r\n<li>Bootstrapping and Initialization </li>\r\n</ul>\r\n<p><br />The perl package created handles the bootstrapping and initialization, while other tasks are part of the c file.<br /><br /><strong><span style="text-decoration: underline;">Learning XS:</span></strong><br /><br />The program h2xs is the starting point for creating extensions.  It creates number of files in the extension directory<br /><br /><strong>Basic Steps:<br /></strong></p>\r\n<ol>\r\n<li>Create the extension using ''h2xs -A -n &lt;extension_name&gt;</li>\r\n<li>cd &lt;extension_name&gt;</li>\r\n<li>Write the code in &lt;extension_name&gt;.xs file</li>\r\n<li>Author your test cases (optional) in t/ directory</li>\r\n<li>run <span style="font-family: Courier New;">perl Makefile.PL</span></li>\r\n<li style="font-family: Courier New;">make</li>\r\n<li><span style="font-family: Courier New;">make test </span>(optional)</li>\r\n<li><span style="font-family: Courier New;">make install (</span>you can specify the exact directory to place the extension''s files by placing a <span style="font-family: Courier New;"><strong>"PREFIX=/destination/directory"</strong></span> after the make install).</li>\r\n<li>Now you can use the extension as <span style="font-family: Courier New;"><strong>use &lt;extension_name&gt; </strong></span>in your perl scripts.</li>\r\n</ol>\r\n<p><br /><strong>Files created by h2xs<br /><br /></strong></p>\r\n<ul>\r\n<li>The file <strong>Makefile.PL</strong> is a perl script which will generate a true Makefile to build the extension.</li>\r\n<li>The &lt;<strong>Extension&gt;.pm</strong> and &lt;<strong>Extension&gt;.xs</strong> files contain the meat of the extension.  The .xs file holds the C routines that make up the extension.  The .pm file contains routines that tell Perl how to load your extension.</li>\r\n<li><strong>ppport.h </strong>is the header file written by h2xs (using <strong>Devel::PPPort</strong> module) to bring some of the newer features of perl API into older versions. This file contains a series of macros and, if explicitly requested, functions that allow XS modules to be built using older versions of Perl. Currently Perl versions from 5.003 to 5.9.2 are supported. Ppport is for Perl/Pollution/Portability</li>\r\n</ul>\r\n<p><br /><br /><strong>Working <br /><br /></strong></p>\r\n<ul>\r\n<li>Generating the Makefile (by running <span style="font-family: Courier New;"><strong>perl Makefile.PL</strong></span>) and running <span class="w"><strong>make</strong></span> creates a directory called <span style="font-family: Courier New;"><strong>blib </strong></span>(which stands for "build library") in the current working directory. This directory contains the shared library that we will build. This will be the library which will get installed when we run make install (after testing it)</li>\r\n</ul>\r\n<ul>\r\n<li>Invoking the test script via "<span class="w"><strong>make</strong></span> <span class="w"><strong>test</strong></span> " does something very important. It invokes perl with all those -<span class="w">I</span> arguments so that it could find the various files that are part of the extension (-I is used to specify @INC directory). When Perl sees a <strong>use </strong><span class="w"><strong>extension</strong></span><span class="sc"><strong>;</strong></span> , it searches for a file with the same name as the <span style="color: #000000;"><strong>use</strong></span><strong>''</strong>d extension that has a .pm suffix.  If that file cannot be found, Perl dies with a fatal error.  The default search path is contained in the <span class="i">@INC</span> array. The code in the <span style="font-family: Courier New;"><strong>extension.pm</strong></span> (created by h2xs) <br /> \r\n<ul>\r\n<li>Tells perl that it will need the <strong>Exporter </strong>and <strong>Dynamic Loader</strong> extensions. </li>\r\n<li>It then sets the <span class="i"><strong>@ISA</strong></span> and <span class="i"><strong>@EXPORT</strong></span> arrays and the <span class="i"><strong>$VERSION</strong></span> scalar; </li>\r\n<li>Finally it tells perl to bootstrap the module. </li>\r\n<li>Perl will call its dynamic loader routine (if there is one) and load the shared library.</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n<p> </p>\r\n<p><strong>Best Practices</strong></p>\r\n<p> </p>\r\n<ul>\r\n<li>It is <em>very</em> important that while you are still testing extensions that you use "<span class="w"><strong>make</strong></span> <span class="w"><strong>test</strong></span> ".  If you try to run the test script all by itself, you will get a fatal error. </li>\r\n<li>Another reason it is important to use "<span class="w">make</span> <span class="w">test</span> " to run your test script is that if you are testing an upgrade to an already-existing version, using "<span class="w">make</span> <span class="w">test</span> " ensures that you will test your new extension, not the already-existing version.</li>\r\n<li>You should closely follow the "<strong>ok/not ok</strong>" style that Perl itself uses, so that it is very easy and unambiguous to determine the outcome of each test case.</li>\r\n<li> If you have many test cases, <strong>save your test files in the "t" directory </strong>and use the suffix ".t". When you run "<span class="w">make</span> <span class="w">test</span> ", all of these test files will be executed.</li>\r\n<li>In general, it''s not a good idea to write extensions that modify their input parameters. However, in order to better accommodate calling pre-existing C routines, which often do modify their input parameters, this behavior is tolerated.</li>\r\n<li>Sometimes we also need to create a <strong>typemap</strong> file because the default Perl doesn''t currently support some types (e.g., const char * )</li>\r\n<li>To help ease understanding, it is suggested that you place a "&amp;" next to the variable name (and away from the variable type), and place a "*" near the variable type, but away from the variable name (in .xs file)</li>\r\n</ul>\r\n<p> </p>\r\n<p><br /><br /><strong><span style="text-decoration: underline;">More on ppport.h</span></strong></p>\r\n<ul>\r\n<li>\r\n<pre style="font-family: Verdana;"><strong>When:</strong> You should use <em>ppport.h</em> in modern code so that your code will work with the widest range of Perl interpreters possible, without significant additional work.</pre>\r\n</li>\r\n<li><strong>How:</strong> Don''t direct the users of your module to download "Devel::PPPort". Also, don''t make <em>ppport.h</em> optional. Rather, just take the most recent copy of <em>ppport.h</em> that you can find , copy it into your project, adjust your project to use it, and distribute the header along with your module.</li>\r\n<li><strong>More </strong>: <em>ppport.h</em> is more than just a C header. It''s also a <strong>Perl script</strong> that can check your source code. It will suggest hints and portability notes, and can even make suggestions on how to change your code. You can run it like any other Perl program: </li>\r\n</ul>\r\n<pre style="font-family: Verdana;"><br />           perl ppport.h [options] [files]<br /></pre>\r\n<div style="margin-left: 40px;">It also has embedded documentation, so you can use <strong>perldoc ppport.h </strong>to find out more about how to use it.</div>\r\n<ul>\r\n<li>Ppport is for Perl/Pollution/Portability</li>\r\n</ul>\r\n<p><br /><strong>Makefile.PL</strong></p>\r\n<pre class="verbatim"><span class="q">When you are using the external functions in C (XS code), let the make know by mentioing it as LIBS key in Makefile.PL<br />e.g., ''LIBS''</span>      <span class="cm">=&gt;</span> <span class="s">[</span><span class="q">''-lm''</span><span class="s">]</span><span class="cm">,</span>   <span class="c"># e.g., ''-lm''<br /><br /><br style="font-family: Verdana;" /><span style="font-family: Verdana;"><strong>Digging into xs file</strong></span><br /></span></pre>\r\n<ul>\r\n<li>\r\n<pre class="verbatim"><span class="w">"MODULE</span> = <span class="w">Mytest2</span>		<span class="w">PACKAGE</span> = <span class="w">Mytest2". </span><span style="font-family: Verdana;">Anything before this line is plain C code which describes <br />include, and defines some convenience functions.  No translations are </span><span style="font-family: Verdana;">performed on this part, apart from having embedded POD documentation <br /></span><span style="font-family: Verdana;">skipped over, </span><span style="font-family: Verdana;">it goes into the generated output C file as is.</span></pre>\r\n</li>\r\n</ul>\r\n<ul>\r\n<li>Anything after this line is the description of XSUB functions. These descriptions are translated by <strong>xsubpp</strong> into C code which implements these functions using Perl calling conventions, and which makes these functions visible from Perl interpreter.</li>\r\n<li>Usually the .xs file provides an interface to an existing C function.  Then this C function is defined somewhere (either in an external library, or in the first part of .xs file), and a Perl interface to this function (i.e. "Perl glue") is described in the second part of .xs file.</li>\r\n<li>Its good to differentiate glue part with the actual C code. That means second part of xs file should contain only definitions of the functions defined in the first part (#include files or the .xs file itself).</li>\r\n<li>While isolating C and the glue code is good practice, it wants you to change the code in two place (C and xs) if there is any functionality change.</li>\r\n<li>When you specify arguments to routines in the .xs file, you are really passing three pieces of information for each argument listed. <br /><ol>\r\n<li>The order of that argument relative to the others (first, second, etc). </li>\r\n<li>The type of argument, and consists of the type declaration of the argument (e.g., int, char*, etc). </li>\r\n<li>The calling convention for the argument in the call to the library function.</li>\r\n</ol></li>\r\n<li><strong>Pass by ref or Pass by Value: </strong>While Perl passes arguments to functions by reference, C passes arguments by value; to implement a C function which modifies data of one of the "arguments", the actual argument of this C function would be a pointer to the data.  Thus two C functions with declarations below may have completely different semantics</li>\r\n</ul>\r\n<pre class="verbatim">        int string_length(char *s);<br />	int upper_case_char(char *cp);</pre>\r\n<p> </p>\r\n<p style="margin-left: 40px;">The first one may inspect an array of chars pointed by s, and the second one may immediately dereference <span class="w">cp</span> and manipulate <span class="i">*cp</span> only (using the return value as, say, a success indicator).  From Perl one would use these functions in a completely different manner. One conveys this info to <strong>xsubpp</strong> by <strong>replacing </strong><span class="i"><strong>*</strong></span><strong> before the argument by </strong><span class="i"><strong>&amp;</strong></span> .  <span class="i">&amp;</span> means that the argument should be passed to a library function by its address.  The above two function may be XSUB-ified as</p>\r\n<pre class="verbatim">	int<br />	string_length(s)<br />		char *	s</pre>\r\n<pre class="verbatim">	int<br />	upper_case_char(cp)<br />		char	&amp;cp<br /><br /><span style="font-family: Verdana;">    In the first case, s, is considered as string. In the second example cp is considered as char and assigned</span><span style="font-family: Verdana;"> to the variable a, and its address <br />    would be passed into the function<br /></span></pre>\r\n<ul>\r\n<li>\r\n<pre class="verbatim">char	&amp;a, char&amp;a and char	&amp; a, <span style="font-family: Verdana;">all are evaluated by xsubpp identically</span></pre>\r\n</li>\r\n</ul>\r\n<ul>\r\n<li> When using  <span>C</span> pointers the indirection operator * should be considered part of the type and the address operator &amp; should be considered part of the variable</li>\r\n</ul>\r\n<p><br /><strong><span style="text-decoration: underline;">XS Coding Style<br /><br /></span></strong></p>\r\n<div style="margin-left: 40px;"><strong>Input and Output Parameters</strong></div>\r\n<ul style="margin-left: 40px;">\r\n<li>The parameters that will be passed into the XSUB are specified on the line(s) after declaring the function''s return value and name. </li>\r\n<li>Each input parameter line starts with optional whitespace, and may have an optional terminating semicolon.</li>\r\n<li>The list of output parameters occurs at the very end of the function, just before after the OUTPUT: directive.  The use of RETVAL tells Perl that you wish to send this value back as the return value of the XSUB function.</li>\r\n</ul>\r\n<p><br /><strong><span style="text-decoration: underline;">XSUBPP compiler<br /></span></strong>The <strong>xsubpp</strong> program takes the XS code in the .xs file and translates it into C code, placing it in a file whose suffix is .c.  The C code created makes heavy use of the C functions within Perl.<br /><br /></p>\r\n<p>The <strong>xsubpp</strong> program uses rules to convert from Perl''s data types (scalar, array, etc.) to C''s data types (int, char, etc.).  These rules are stored in the typemap file ($PERLLIB/ExtUtils/typemap).  This file is split into three parts. The first section maps various C data types to a name, which corresponds somewhat with the various Perl types.  The second section contains C code which <strong>xsubpp</strong> uses to handle input parameters.  The third section contains C code which <strong>xsubpp</strong> uses to handle output parameters.</p>\r\n<p><br /><br /><strong><span style="text-decoration: underline;">Sample XS Code(s)<br /><br /></span></strong><strong>Hello World - Code the world writes :)</strong><br />#include "EXTERN.h"<br />#include "perl.h"<br />#include "XSUB.h"<br />#include "ppport.h"<br /><br />MODULE = Mytest         PACKAGE = Mytest<br /><br />void<br />hello()<br /> CODE:<br /> printf("Hello, world!\\n");<br /><br /><br /><strong>Code with params<br /><br style="font-family: Courier New;" /></strong><span style="font-family: Courier New;">#include "EXTERN.h"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "perl.h"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "XSUB.h"</span><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "ppport.h"</span><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><span style="font-family: Courier New;">MODULE = Mytest2                PACKAGE = Mytest2</span><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><span style="font-family: Courier New;">int</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">is_even (input)</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> int input</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> CODE:</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> printf("Sunny gave %d\\n",input);</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> RETVAL = (input % 2 == 0);</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> OUTPUT:</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> RETVAL</span><strong><br /></strong><br /><strong>Code using external library</strong><br /><span style="font-family: Courier New;">#include "EXTERN.h"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "perl.h"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "XSUB.h"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "ppport.h"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "const-c.inc"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">#include "mylib/mylib.h"</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">MODULE = Mytest2                PACKAGE = Mytest2</span><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><span style="font-family: Courier New;">INCLUDE: const-xs.inc</span><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><span style="font-family: Courier New;">double</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">foo(a,b,c)</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> int             a</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> long            b</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> const char *    c</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> OUTPUT:</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> RETVAL<br /><br /></span></p>\r\n<div style="margin-left: 40px;">Notes on the code: <br />\r\n<div style="margin-left: 40px;">\r\n<ul>\r\n<li>When you want to use external library (i.e., you are not the one who created C code as in earlier cases), then you include the header file (see #include "mylib/mylib.h" and then you provide signature of the methods that you want to use from mylib.h)</li>\r\n</ul>\r\n</div>\r\n</div>\r\n<p><br /><strong>More Indepth points</strong><br /><br /></p>\r\n<ul>\r\n<li>If you have constants in .h file (your C Lib), and you want to use them in Perl using &lt;Extension&gt;::Const_Name syntax, then you have to have <span style="font-family: Courier New;">#include "const-c.inc" </span>in your .xs file. Normally h2xs will include it unless you use -c or -A options</li>\r\n<li>Its good practice to use @EXPORT_OK in place of @EXPORT (to avoid name clashes)</li>\r\n<li>If our include file (the file which we specify for h2xs command) had contained #include directives, these would not have been processed by h2xs.  There is no good solution to this right now.</li>\r\n<li>To tell about the external library, we create ''<strong>MYEXTLIB</strong>'' variable/ key in the <strong>Makefile.PL</strong>. Also we rewrite postamble subroutine to make ''<strong>make</strong>'' cd to our library and run ''<strong>make</strong>''. And the Makefile.PL of your library (not the one created by h2xs) should contain instructions to build the library. e.g., (this will build mylib, as static library. This is one of the example in perldoc ... perlxstut)</li>\r\n</ul>\r\n<p> </p>\r\n<div style="margin-left: 80px;"><span style="font-family: Courier New;">use ExtUtils::MakeMaker;</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">$Verbose = 1;</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">WriteMakefile(</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> NAME   =&gt; ''Mytest2::mylib'',</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> SKIP   =&gt; [qw(all static static_lib dynamic dynamic_lib)],</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> clean  =&gt; {''FILES'' =&gt; ''libmylib$(LIB_EXT)''},</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> );</span><br style="font-family: Courier New;" /><br style="font-family: Courier New;" /><span style="font-family: Courier New;">sub MY::top_targets {</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> ''</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">all :: static</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">pure_all :: static</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">static ::       libmylib$(LIB_EXT)</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">libmylib$(LIB_EXT): $(O_FILES)</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> $(AR) cr libmylib$(LIB_EXT) $(O_FILES)</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> $(RANLIB) libmylib$(LIB_EXT)</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;">'';</span><br style="font-family: Courier New;" /><span style="font-family: Courier New;"> }<br /></span></div>\r\n<ul>\r\n<li>You can have the POD style document in the .pm file. This file will be fed to pod2man, and the embedded documentation will be converted to the manpage format, then placed in the blib directory.  It will be copied to Perl''s manpage directory when the extension is installed.</li>\r\n<li>Though the &lt;Extension&gt;.pm is primarily used as glue to C code, you can always have Perl methods in it, as a regular module. They generally assist in making the interface between Perl and your extension simpler or easier to understand.</li>\r\n</ul>\r\n<p><br /><br /><br /><strong><span style="text-decoration: underline;">The Argument Stack</span></strong><br /><br /></p>\r\n<ul>\r\n<li>The C code generated by xsubpp contains a number of references to ST(n). "ST" is actually a macro that points to the n''th argument on the argument stack. ST(0) is thus the first argument on the stack and therefore the first argument passed to the XSUB, and so on. When you list the arguments to the XSUB in the .xs file, that tells <strong>xsubpp</strong> which argument corresponds to which of the argument stack . Thus you must always specify arguments in the way they are expected by the library method.</li>\r\n<li>The actual values on the argument stack are pointers to the values passed in.  When an argument is listed as being an OUTPUT value, its corresponding value on the stack (i.e., ST(0) if it was the first argument) is changed. </li>\r\n<li>XSUBs are also allowed to return lists, not just scalars.  This must be done by manipulating stack values ST(0), ST(1), etc, in a subtly different way (How... don''t know yet).</li>\r\n<li>Some people prefer manual conversion by inspecting <span class="i">ST</span><span class="s">(</span><span class="w">i</span><span class="s">)</span> even in the cases when automatic conversion will do. XSUBs are also allowed to avoid automatic conversion of Perl function arguments to C function arguments (How ... Don''t know yet).</li>\r\n<li>The XSUB''s incoming parameters and outgoing return values always begin at  ST(0).</li>\r\n</ul>\r\n<p><br /><br /><br /><br /><strong>TODO:</strong><br style="font-weight: bold;" /></p>\r\n<ul>\r\n<li>Read Examples 5 to 9 to get some more info like how to return arrays, how to pass hash, how to return hash ref...etc... Happy XS''ing :)</li>\r\n<li>Lets start off with Adv Perl Prg''in ... </li>\r\n<li>Then move to perlxs for detailed knowledge of XS coding...</li>\r\n<li>And then perlguts... for some Autoloading ... perl API stuff ... and it goes on n on n on... </li>\r\n</ul>\r\n<p><br /><strong><span style="text-decoration: underline;">And now the meat out of XS (from perlxs)</span></strong><br /><br /></p>\r\n<ul>\r\n<li>An  <strong>XSUB</strong> is a function in the  <span>XS</span> language and is the core component of the Perl application interface.</li>\r\n<li> The  <span>XS</span> compiler is called <strong>xsubpp</strong>.This compiler will embed the constructs necessary to let an  <span>XSUB,</span> which is really a  <span>C</span> function in disguise, manipulate Perl values and creates the glue necessary to let Perl access the  <span>XSUB.</span> </li>\r\n<li>The compiler uses  <strong>typemaps</strong> to determine how to map  <span>C</span><span>C</span> types.  <span>A</span> supplement typemap must be created to handle special structures and types for the library being linked.function parameters and variables to Perl values. The default typemap handles many common </li>\r\n</ul>\r\n<p><br /><strong><span style="text-decoration: underline;">Components of XS Code</span></strong><br /><br style="font-weight: bold;" /><strong>RETVAL variable</strong></p>\r\n<ul>\r\n<li> The  <span>RETVAL</span> variable is a magic variable which always matches the return type of the  <span>C</span> library function. The  <strong>xsubpp</strong> compiler will supply this variable in each  <span>XSUB</span> and by default will use it to hold the return value of the  <span>C</span> library function being called. In simple cases the value of  <span>RETVAL</span>ST(0) of the argument stack where it can be received by Perl as the return value of the  <span>XSUB.</span></li>\r\n<li> If the  <span>XSUB</span> has a return type of void then the compiler will not supply a  <span>RETVAL</span> variable for that function. When using the  <span>PPCODE:</span> directive the  <span>RETVAL</span> variable is not needed, unless used explicitly. </li>\r\n<li> If  <span>PPCODE:</span> directive is not used, void return value should be used only for subroutines which do not return a value, <em>even if</em> <span>CODE:</span> directive is used which sets  ST(0) explicitly.</li>\r\n</ul>\r\n<p><br /><strong>MODULE Keyword</strong><br /><br /></p>\r\n<ul>\r\n<li> The  <span>MODULE</span> keyword is used to start the  <span>XS</span> code and to specify the package of the functions which are being defined. </li>\r\n<li>All text preceding the first  <span>MODULE</span> keyword is considered  <span>C</span> code and is passed through to the output untouched. </li>\r\n<li>Every  <span>XS</span> module will have a bootstrap function which is used to hook the XSUBs into Perl. </li>\r\n<li>The package name of this bootstrap function will match the value of the last <span>MODULE</span> statement in the  <span>XS</span> source files. The value of  <span>MODULE</span> should always remain constant within the same  <span>XS</span> file, though this is not required.</li>\r\n</ul>\r\n<p><br /><strong>PACKAGE Keyword</strong><br /><br /></p>\r\n<ul>\r\n<li> When functions within an  <span>XS</span> source file must be separated into packages the  <span>PACKAGE</span> keyword should be used. This keyword is used with the  <span>MODULE</span> keyword and must follow immediately after it when used.</li>\r\n</ul>\r\n<p><br />Example:</p>\r\n<pre>     MODULE = RPC  PACKAGE = RPC<br /></pre>\r\n<p> </p>\r\n<pre>     [ XS code in package RPC ]<br /></pre>\r\n<p> </p>\r\n<pre>     MODULE = RPC  PACKAGE = RPCB<br /></pre>\r\n<p> </p>\r\n<pre>     [ XS code in package RPCB ]<br /></pre>\r\n<p> </p>\r\n<pre>     MODULE = RPC  PACKAGE = RPC<br /></pre>\r\n<p> </p>\r\n<pre>     [ XS code in package RPC ]<br /></pre>\r\n<p><br /><strong>PREFIX Keyword</strong><br /><br /></p>\r\n<ul>\r\n<li> The  <span>PREFIX</span> keyword designates prefixes which should be removed from the Perl function names. </li>\r\n<li> This keyword should follow the  <span>PACKAGE</span> keyword when used. If  <span>PACKAGE</span> is not used then  <span>PREFIX</span> should follow the  <span>MODULE</span> keyword.</li>\r\n<li>Example, If the  <span>C</span> function is  rpcb_gettime() and the  <span>PREFIX</span> value is rpcb_ then Perl will see this function as gettime().</li>\r\n</ul>\r\n<p><br /><strong>OUTPUT Keyword<br /><br /></strong></p>\r\n<ul>\r\n<li>Indicates that certain function parameters should be updated (new values made visible to Perl) when the  <span>XSUB</span> terminates.</li>\r\n<li>Indicates that certain values should be returned to the calling Perl function. </li>\r\n<li>Used to tell the compiler (xsubpp) that  <span>RETVAL</span> really is an output variable (The  <span>RETVAL</span> variable is not recognized as an output variable when the  <span>CODE:</span> keyword is present).</li>\r\n<li>Used to indicate that function parameters are output variables.</li>\r\n<li> Also allows an output parameter to be mapped to a matching piece of code rather than to a typemap.</li>\r\n</ul>\r\n<pre style="margin-left: 40px;"> bool_t<br />     rpcb_gettime(host,timep)<br />          char *host<br />          time_t &amp;timep<br />          OUTPUT:<br />          timep sv_setnv(ST(1), (double)timep);</pre>\r\n<p> </p>\r\n<p> </p>\r\n<ul>\r\n<li><strong>xsubpp</strong> emits an automatic SvSETMAGIC() for all parameters in the  <span>OUTPUT</span> section of the  <span>XSUB,</span> except  <span>RETVAL. </span>If for some reason, this behavior is not desired, the  <span>OUTPUT</span> section may contain a  SETMAGIC: DISABLE line to disable it for the remainder of the parameters in the  <span>OUTPUT</span> section. Likewise,  SETMAGIC: ENABLE can be used to reenable it for the remainder of the  <span>OUTPUT</span> section (perlguts for more details).</li>\r\n</ul>\r\n<p> </p>\r\n<p><br /><strong>CODE: Keyword<br /><br /></strong></p>\r\n<ul>\r\n<li>Used in more complicated XSUBs which require special handling for the  <span>C</span> function.</li>\r\n<li>The  <span>RETVAL</span> variable is available but will not be returned unless it is specified under the  <span>OUTPUT:</span> keyword.</li>\r\n</ul>\r\n<p> </p>\r\n<pre>    Example using CODE to manipulate the parameters passed by Perl to C lib function.<br /><br />     bool_t<br />     rpcb_gettime(host,timep)<br />          char *host<br />          time_t timep<br />          CODE:<br />               RETVAL = rpcb_gettime( host, &amp;timep );<br />          OUTPUT:<br />          timep<br />          RETVAL</pre>\r\n<p><br /><strong>INIT: Keyword</strong><br /><br /></p>\r\n<ul>\r\n<li>Allows initialization to be inserted into the  <span>XSUB</span> before the compiler generates the call to the  <span>C</span> function.</li>\r\n<li>Does not affect the way the compiler handles  <span>RETVAL (as it happens in CODE:).</span></li>\r\n</ul>\r\n<p> </p>\r\n<pre><strong>    Example:</strong><br />    bool_t<br />    rpcb_gettime(host,timep)<br />          char *host<br />          time_t &amp;timep<br />          INIT:<br />          printf("# Host is %s\\n", host );<br />          OUTPUT:<br />          timep</pre>\r\n<p><br /><strong>NO_INIT: Keyword</strong></p>\r\n<ul>\r\n<li> Used to indicate that a function parameter is being used only as an output value. </li>\r\n<li><span>NO_INIT</span> will tell the compiler that some parameters will be used for output rather than for input and that they will be handled before the function terminates (The <strong>xsubpp</strong> compiler will normally generate code to read the values of all function parameters from the argument stack and assign them to  <span>C</span> variables upon entry to the function.)</li>\r\n<li></li>\r\n</ul>\r\n<p><br /><br /><br /><br />will be placed in  <br /> The function name and the return type must be placed on separate lines.<br />XS is whitespace sensitive<br /> The function body may be indented or left-adjusted. <br /><br /><br /><br />What does #line directive in .c file created by XS mean?</p>\r\n<div class="title">The #line Directive</div>\r\n<div class="introduction">\r\n<p>The <span class="keyword">#line</span> directive tells the preprocessor to change the compiler''s internally stored line number and filename to a given line number and filename.</p>\r\n<br />\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n</div>\r\n<p> </p>\r\n', '\r\n<p> </p>\r\n<p> </p>', 1, 4, 0, 3, '2009-12-13 06:31:03', 63, '', '2009-12-13 06:33:49', 62, 0, '0000-00-00 00:00:00', '2009-12-13 06:31:03', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 1, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (12, 'Firefox Tips', 'firefox-tips', '', '<p><span style="font-weight: bold;"><a href="http://www.forevergeek.com/" target="_blank">www.forevergeek.com</a> has a useful guide on speeding up firefox for broadband users. basically after getting to the hidden config settings you set the browser to request more data that it usually does.</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">1.Type "about:config" into the address bar and hit return. Scroll down and look for the following entries:</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">network.http.pipelining network.http.proxy.pipelining network.http.pipelining.maxrequests</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">Normally the browser will make one request to a web page at a time. When you enable pipelining it will make several at once, which really speeds up page loading.</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">2. Alter the entries as follows:</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">Set "network.http.pipelining" to "true"</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">Set "network.http.proxy.pipelining" to "true"</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">Set "network.http.pipelining.maxrequests" to some number like 30. This means it will make 30 requests at once.</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">3. Lastly right-click anywhere and select New-&gt; Integer. Name it "nglayout.initialpaint.delay" and set its value to "0". This value is the amount of time the browser waits before it acts on information it receives.</span><br style="font-weight: bold;" /><br style="font-weight: bold;" /><span style="font-weight: bold;">If you''re using a broadband  connection you''ll load pages MUCH faster now!</span><br style="font-weight: bold;" /></p>', '', 0, 0, 0, 0, '2009-12-29 18:15:59', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-29 18:15:59', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 12, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (13, 'Protecting password @ cyber cafe', 'protecting-password--cyber-cafe', '', '<div><span style="color: #007f7f; font-size: small;">Dear Brothers and sisters,</span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Privacy being under attack these days from all and sundry places and people (what with surreptitiosly placed webcams, keylogging software, computer hacking, its almost as if ones whole life is now on show for whoever is ready to pay the big bucks for perverted voyeuristic pursuits and pleasures... </span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">But many times, it is we ourselves who do not take even the most basic precautions ... sometimes out of ignorance .. at other times due to laziness .. </span></div>\r\n<div><span style="color: #007f7f; font-size: small;">I can do nothing about the latter, but so far as ignorance is concerned, we can all chip in with whatever awareness can make  our lives better and more in tune with the will of God.</span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">In the light of the above, this week, I am offering the following ..</span></div>\r\n<div><span style="color: #007f7f; font-size: small;">A way to protect your passwords in cyber cafes and other public computers and an anti-hacking software to secure your PC from unwanted attacks .. </span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Here goes with the first part ..</span></div>\r\n<div></div>\r\n<div><a href="http://www.foolzparadize.org/" target="_blank" rel="nofollow"><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;"><strong><span style="color: #0000ff;">Protect your password in cyber cafe and on public computers</span></strong></span></span></a></div>\r\n<div></div>\r\n<div><a href="http://www.foolzparadize.org/" target="_blank" rel="nofollow"><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">Some time or the other, you must have used cyber dafe or public computers to access internet or mail. Public computers are most prone to password hacking. Anyone can simply install a keylogger software to hack your password. <br /></span></span></a></div>\r\n<div></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">Keylogging is one of the most insidious threats to a user''s personal information. Passwords, credit card numbers etc.  <br /></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">It is now very easy for the keylogger to harvest passwords.  Each and every keystroke (whatever you type on the keyboard) gets recorded in the keylogger software and the person installing it can easily view what you have typd in. <br /></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">For example, if you go to </span></span><span style="font-family: Arial;"><a href="http://hotmail.com/" target="_blank" rel="nofollow"><span style="font-family: Palatino Linotype; color: blue;"><span style="text-decoration: underline;">hotmail.com</span></span></a><span style="font-family: Palatino Linotype; color: #bf5f00;"> and check your mails. Say your ID is </span><a href="http://us.f525.mail.yahoo.com/ym/Compose?To=sarahj7@hotmail.com" target="_blank" rel="nofollow"><span style="font-family: Palatino Linotype; color: #bf5f00;"><span style="text-decoration: underline;">sarahj7@hotmail. com </span></span></a><span style="font-family: Palatino Linotype; color: #bf5f00;">and password is "snoopy2", the keylogger  software records your usename and password in its log file as <br /></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">Microsoft Internet Explorer :</span><span style="font-family: Times New Roman;"> </span><span style="color: blue;"><span style="text-decoration: underline;"><br /></span></span><a href="http://www%2Ehotmail%2E%20comsarahj7@%20hotmail.comsnoop%20y2/" target="_blank" rel="nofollow"><span style="font-family: Palatino Linotype; color: blue;"><span style="text-decoration: underline;">www.hotmail. comsarahj7@ hotmail.comsnoop y2 </span></span></a><span style="font-family: Palatino Linotype; color: #bf5f00;"><br /></span></span></div>\r\n<div></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">Or in the case of </span></span><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">Firefox:</span><span style="font-family: Times New Roman;"> </span><span style="color: blue;"><span style="text-decoration: underline;"><br /></span></span><a href="http://www%2Ehotmail%2Ecomsarahj7@hotmail.comsnoopy2/" target="_blank" rel="nofollow"><span style="font-family: Palatino Linotype; color: blue;"><span style="text-decoration: underline;">www.hotmail. comsarahj7@ hotmail.comsnoop y2 </span></span></a><br /><span style="font-family: Times New Roman;"> </span><span style="font-family: Palatino Linotype; color: #bf5f00;"><br />Risky isnt it???!!!</span><span style="font-family: Times New Roman;"> <img src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/05.gif" border="0" /></span><span style="font-family: Palatino Linotype; color: #bf5f00;"><br /></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf5f00;">There''s solution to this problem and you can easily fool the hacker.</span><span style="font-family: Times New Roman;"> </span><span style="font-family: Palatino Linotype; color: #bf5f00;"><br />The keylogger software sees and records everything,but it doesn''t understand what it sees. I</span><span style="font-family: Palatino Linotype; color: #bf5f00;">t does not know what to do with keys that are typed anywhere other than the password or user name fields. </span><span style="font-family: Times New Roman;"> <br /> <br /></span><span style="font-family: Palatino Linotype;">So, in between successive keys of the password if you enter random keys, the keylogger software won''t ever come to know where you typed in what..</span><span style="font-family: Times New Roman;"> <br /></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype;">In the process of recording the keys, the string that the keylogger receives will contain the password, but embedded in so much random junk that discovering it is infeasible. <br /></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype;">So...</span><span style="font-family: Times New Roman;"> e.g.<br /> <br /></span><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>1.Go to </strong></span><a href="http://hotmail.com/" target="_blank" rel="nofollow"><span style="font-family: Palatino Linotype; color: blue;"><strong><span style="text-decoration: underline;">hotmail.com</span></strong></span></a><span style="font-family: Palatino Linotype; color: #bf005f;"> <strong>or </strong></span><a href="http://yahoo.com/" target="_blank" rel="nofollow"><span style="font-family: Palatino Linotype; color: blue;"><strong><span style="text-decoration: underline;">yahoo.com</span></strong></span></a><span style="font-family: Palatino Linotype; color: #bf005f;"> <strong>or any of the site where you need to insert a password or PIN. <br /></strong></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>2.Type in your user ID. <br /></strong></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>3. Type in the first character of the password. <br /></strong></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>4. Click on the address bar in the internet explorer or Firefox. Type in some 3/4 random characters. <br /></strong></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>5. Again go to password field and type in the second character of the password. And probably third too.</strong></span><span style="font-family: Times New Roman;"> </span><span style="font-family: Palatino Linotype; color: #bf005f;"><strong><br /></strong></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>6. Again go to the addressbar and type in a few mroe random character. <br /></strong></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>7. Back to the password field and the next characters of the password.</strong></span><span style="font-family: Times New Roman;"> </span><span style="font-family: Palatino Linotype; color: #bf005f;"><strong><br /></strong></span></span></div>\r\n<div><span style="font-family: Arial;"><span style="font-family: Palatino Linotype; color: #bf005f;"><strong>Keep on repeatin the process till you type in the full password in the password field.</strong></span><span style="font-family: Times New Roman;"> <br /> </span><span style="font-family: Palatino Linotype; color: blue;"><br />Instead of the password <br />snoopy2 the keylogger now gets: <br />hotmail.<strong><em>comspqmlainsdgsosdg fsodgfdpuouuyhdg 2</em></strong></span><span style="font-family: Times New Roman;"> </span><span style="font-family: Palatino Linotype; color: blue;"><br />Here a total of 26  random characters have been inserted among the 7 characters of the actual password!!!</span><span style="font-family: Times New Roman;"> </span><span style="font-family: Palatino Linotype; color: blue;"><br /> </span><br /><span style="font-family: Times New Roman;"> </span><span style="font-family: Palatino Linotype; color: blue;"><br />No doubt it takes a little bit of more time than the usual process, but you''re safe and secure that way!!!</span></span></div>\r\n<div></div>\r\n<div><span style="font-family: Palatino Linotype; color: #0000ff;">Never hurts to be a little more secure eh?<img src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/13.gif" border="0" /></span></div>\r\n<div></div>\r\n<div><span style="font-family: Palatino Linotype; color: #007f7f;"><strong>and here''s the anti-hacking software I was talking about .. </strong></span></div>\r\n<div><span style="font-family: Palatino Linotype; color: #007f7f; font-size: small;"><strong></strong></span></div>\r\n<div><span style="font-family: arial; color: #007f7f; font-size: small;"><strong>For those who don''t know what is hacking .... </strong></span></div>\r\n<div><span style="font-family: arial; color: #007f7f; font-size: small;"><strong>Here''s a short explanation .. </strong></span></div>\r\n<div><span style="font-family: arial; color: #007f7f; font-size: small;"><strong></strong></span></div>\r\n<div><span style="font-family: arial; color: #007f7f; font-size: small;"><strong>Your computer communicates with the net and cyberworld and other computers in a LAN network through portals (or doorways) known as ports .. </strong></span><strong><span style="font-family: arial; color: #007f7f; font-size: small;">There are around 65000 ports .. through which your computer can communicate ..</span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">Relax, most of them are system .. and not for you to mess with .. unless you are a pro . <img src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif" border="0" /></span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">Like port 80 is used to access the internet websites .. </span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">Port 25 for SMTP email (outgoing) etc.. etc.. </span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">Now a hacker typically enters your computer through a port ... an open port that allows him access .. windows does have a password option .. but there is no limit on the number of tries .. so a hacker can theoretically try all possible combinations until he gains an entry into your system and once He/she does (Yes, hackers can be females too ..<img src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/04.gif" border="0" /> .. don''t underestimate them) then they pretty much own your computer and can do whatsoever  they wish ... </span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">create files,</span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">delete files,''</span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">modify files ..</span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">What an anti-hacking software does is prevent exactly that ..  and different ones use different ways of doing that ... </span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">The one I am telling you about is Zonealarm ..</span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">(URL - </span><a href="http://www.zonelabs.com/" target="_blank" rel="nofollow"><span style="font-family: arial; color: #007f7f; font-size: small;">www.zonelabs.com</span></a><span style="font-family: arial; color: #007f7f; font-size: small;">)</span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">Just go to the website and download their free version .. for Home use .. </span></strong><strong><span style="font-family: arial; color: #007f7f; font-size: small;">To know more about hacking ... also visit the site </span><a href="http://www.grisoft.com/" target="_blank" rel="nofollow"><span style="font-family: arial; color: #007f7f; font-size: small;">www.grisoft.com</span></a></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">As an aside, I would also like to add that even with the above software, we still have the age old dilemma of "Who will guard the Guardians?"</span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">IN the above context, the anti-hacking software will protect you from hackers ... </span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">But </span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">How well can you trust that the company owning the anti-hacking software won''t misuse it to gain access to your computer and use it for their own benefit ... good or bad .. eh? </span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">See .. security ..?</span></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">It works  ... rather cuts both ways .. <img src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/05.gif" border="0" /></span></strong></div>\r\n<div><strong></strong></div>\r\n<div><strong><span style="color: #003399;"><span style="font-family: arial; color: #007f7f; font-size: small;">By the way, the said software (zonealarm) has been  acquired by an Israeli company last I heard .. </span>\r\n<div><strong></strong></div>\r\n<div><strong><span style="font-family: arial; color: #007f7f; font-size: small;">Just giving you both sides of the picture ... you decide what you wanna work with or around ... </span></strong></div>\r\n<div><span style="color: #007f7f; font-size: small;">You can also search on google for more freeware versions ... </span></div>\r\n<div><span style="color: #007f7f; font-size: small;">But the above problem would remain with any software that you install on your computer ... </span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Happy surfing .. and </span></div>\r\n<div><span style="color: #007f7f; font-size: small;">Be safe, (At least try to)</span></div>\r\n</span></strong></div>', '', 1, 0, 0, 0, '2009-12-29 18:21:45', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-29 18:21:45', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 11, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (14, 'data recovery - junk', 'data-recovery-junk', '', '<p> </p>\r\n<div><span style="color: #007f7f; font-size: small;">In continuing with the same vein, this time its  about a software that is useful for <strong>recovering deleted files</strong> ... accidentally deleted files mostly, but you can still use it to recover files if not much time has elapsed.</span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">The software is called <strong>REST 2514. Its by Brian Kato</strong> ..</span></div>\r\n<div><span style="color: #007f7f; font-size: small;"><strong>(Its another must have software like the iIsystem wiper)</strong></span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">You just enter the file name or its extension and it shows you the list of files it has recovered .. Its very effective if not much time has elapsed since you deleted the file, although I have recovered files even a week, sometimes even a month after it was deleted .. </span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">It also depends upon How exhaustively you use the computer or the particular drive from where the file was deleted .. If the drive has been subjected to a lot of deleting and writing files or saving files on it, then it may not recover the file that well .. </span></div>\r\n<div><span style="color: #007f7f; font-size: small;">That''s why I said it in the beginning ... </span></div>\r\n<div><span style="color: #007f7f; font-size: small;">Its great for recovering files that have been accicentally deleted ..</span></div>\r\n<div><span style="color: #007f7f; font-size: small;">But Hey, it does what it does and it does it very well ... </span></div>\r\n<div><span style="color: #007f7f; font-size: small;">So who''s complaining ..</span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Yuo know what? You could test it by creating a dummy file .. deleting it and then trying to recover/undelete it .. <img src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/05.gif" border="0" /></span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Go ahead .. try it ..</span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Here''s the link to the website from where you can download it .. </span></div>\r\n<div></div>\r\n<div><span style="color: #003399; font-size: small;"><a href="http://www.snapfiles.com/get/restoration.html" target="_blank" rel="nofollow">http://www.snapfiles.com/get/restoration.html</a></span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Or here''s the direct link to directly download the software ...</span></div>\r\n<div></div>\r\n<div><a href="http://www.downloadtaxi.com/d/104/REST2514.EXE" target="_blank" rel="nofollow"><span style="color: #003399; font-size: small;">http://www.downloadtaxi.com/d/104/REST2514.EXE</span></a></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Another thing about this software is its not required  to be installed ..</span></div>\r\n<div><span style="color: #007f7f; font-size: small;">Just extract or unzip the file into a folder and you are ready to run it ... No installation means no cluttering up the registry and if you don''t want it, just delete the folder and its gone .. </span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">plus, its size ... just 200 KB .. Huh!!!!!</span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">AND, its freeware!!!!!!!!!!!!!!! Hooray ...</span></div>\r\n<div><span style="color: #007f7f; font-size: small;">I love freeware stuff .. </span></div>\r\n<div><span style="color: #007f7f; font-size: small;">No demos, no 15 days working and then having to buy ..</span></div>\r\n<div><span style="color: #007f7f; font-size: small;">Just use it and if you feel inclined, many of these developers also give you their emails or addresses to send them money .. <img src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/04.gif" border="0" />.</span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f; font-size: small;">Well, Hope this one works for you just as well </span></div>\r\n<div></div>\r\n<div><span style="color: #007f7f;"><span style="font-size: small;">And here''s your computer tip for today ...</span> </span></div>\r\n<div><span style="font-family: Arial,Helvetica,sans-serif; color: #000099; font-size: x-small;"><strong></strong></span></div>\r\n<div><span style="font-family: Arial,Helvetica,sans-serif; color: #000099; font-size: x-small;"><strong><span style="text-decoration: underline;">COMPUTER TIP</span></strong></span></div>\r\n<div>\r\n<div>\r\n<div></div>\r\n</div>\r\n</div>\r\n<div><strong><span style="font-family: Arial,Helvetica,sans-serif; color: #ff0000; font-size: x-small;"><img src="http://worldstart.com/tips/images/TOD.gif" border="0" alt="Tip of the Day" width="234" height="54" /></span></strong></div>\r\n<div><span style="font-family: Arial,Helvetica,sans-serif; color: #000099; font-size: x-small;"><strong>Desktop Web Shortcuts </strong></span></div>\r\n<div></div>\r\n<div><span style="font-family: Arial,Helvetica,sans-serif; font-size: x-small;">Do you have a web site you visit often? Wouldn''t it be cool to have a shortcut on your desktop for it? Here''s a quick way to do it:</span></div>\r\n<div></div>\r\n<div><span style="font-family: Arial,Helvetica,sans-serif; font-size: x-small;">First, head to the web page with either Explorer or Netscape.</span></div>\r\n<div></div>\r\n<div><span style="font-family: Arial,Helvetica,sans-serif; color: #000066; font-size: x-small;"><strong>~ With Internet Explorer:</strong></span></div>\r\n<div></div>\r\n<div><span style="font-family: Arial,Helvetica,sans-serif; color: #000066; font-size: x-small;">You''ll see next to the site''s URL (address) a small icon with a blue "e" on it. Drag that to your desktop. Instant shortcut!</span></div>\r\n<div></div>', '', 0, 0, 0, 0, '2009-12-29 18:22:29', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-29 18:22:29', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 10, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (15, 'OSX - Console messages not appear', 'osx-console-messages-not-appear', '', '<p>When system is shutdown forcibly, your console log database can get corrupted and may not show up the ''console messages''</p>\r\n<p>The solution is to remove /var/log/asl/* and then it starts working. No need to restart the machine after rm</p>\r\n<p> </p>', '', 0, 0, 0, 0, '2009-12-30 05:33:35', 62, '', '2009-12-30 05:35:34', 62, 0, '0000-00-00 00:00:00', '2009-12-30 05:33:35', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 9, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (16, 'Firefox - GSpace', 'firefox-gspace', '', '<p><span><span><span style="font-family: Comic Sans MS;"><span style="color: #000000; font-size: x-small;"><span style="font-size: 10pt; color: black;">This extension <a href="http://groups.yahoo.com/group/funlok/" target="_blank"> <span style="color: black; text-decoration: none;">allows you to use your Gmail Space (2 GB) for file storage. It acts as a remote machine. You can transfer files between your hard drive and gmail. Your gmail account looks like a FTP host and you can upload and download your files. After you install, you get an option called "GSpace" in your "tools" menu clicking on which opens the window for transfer of files/folders.Works great for storing/sharing files with your friends. Also very good for backup of photos and music files, actually any kind of file. </span></a></span></span></span></span></span></p>', '', 0, 0, 0, 0, '2009-12-30 16:50:48', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 16:50:48', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 8, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (17, 'Recover Disc', 'recover-disc', '', '<div></div>\r\n<div><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"><img border="0" /> </a></div>\r\n<div></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">Don''t you feel like crying every time you add another disc to your pile of scratched discs. Trashing that disc which contained your favorite songs, pics, files, games or videos is not easy. </span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">Read-on, if you find yourself wishing for a miracle every time your fav </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">CD </span></a><span style="font-family: Comic Sans MS; color: #515151;">is scratched:</span></div>\r\n<div></div>\r\n<div><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"><span style="font-family: Comic Sans MS; color: #0080ff;"> Home Remedy </span></a><span style="font-family: Comic Sans MS; color: #0080ff;">:<br /></span></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">here''s an easy home remedy, which might give you the desired results. Rub a small amount of toothpaste on the scratch and polish the </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">CD </span></a><span style="font-family: Comic Sans MS; color: #515151;">with a soft cloth and any petroleum-based polishing solution (like clear shoe polish). Squirt a drop of Brasso and wipe it with a clean cloth. </span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS;"><br /></span></div>\r\n<div><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"><span style="font-family: Comic Sans MS; color: #0080ff;"> Technology to the rescue</span></a></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">There are many softwares available on the net, which enable the recovery of the </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">CD </span></a><span style="font-family: Comic Sans MS; color: #515151;">data. BadCopy Pro is one such software, which can be used to recover destroyed data and files from a range of media.</span></div>\r\n<div><br /><span style="font-family: Comic Sans MS; color: #515151;">Just a few clicks is all it requires to recover the disc from almost all kind of damage situation; be it corrupted, lost data, unreadable or defective.</span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">DiskDoctors is another popular company, which offers both software and solutions to recover data from a scratched </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">CDs </span></a><span style="font-family: Comic Sans MS; color: #515151;">and </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">DVDs</span></a><span style="font-family: Comic Sans MS; color: #515151;">.</span></div>\r\n<div></div>\r\n<div></div>\r\n<div></div>\r\n<div><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"><span style="font-family: Comic Sans MS; color: #0080ff;"> General Tips</span></a><span style="font-family: Comic Sans MS; color: #0080ff;">:</span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">* Always wipe the </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">CD </span></a><span style="font-family: Comic Sans MS; color: #515151;">from the center outward with stratight spoke-like strokes. Wiping </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">CDs </span></a><span style="font-family: Comic Sans MS; color: #515151;">in circles will create more scratches.</span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">* Do not scratch the graphics layer as you cannot repair the disc. HINT: Hold the disc up to a light with the graphics layer facing the light source. If you can see light thru the scratches at any point then the disc may be irreparable and or exhibit loading or playing errors. </span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">* Clean your Disc players lens regularly with a suitable product to ensure optimal viewing pleasure.</span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">* Make sure to use a soft, lint-free cloth to clean both sides of the disc. Wipe in a straight line from the centre of the disc to the outer edge.</span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">* If wiping with a cloth does not remove a fingerprint or smudge, use a specialized </span><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"> <span style="font-family: Comic Sans MS; color: #515151;">DVD </span></a><span style="font-family: Comic Sans MS; color: #515151;">disc polishing spray to clean the disc.</span></div>\r\n<div></div>\r\n<div><span style="font-family: Comic Sans MS; color: #515151;">* Only handle the disc by its outer edge and the empty hole in the middle. This will help prevent fingerprints, smudges or scratches.</span></div>\r\n<div></div>\r\n<div></div>\r\n<div><br /><a href="http://www.funlok.com/modules.php?name=News&amp;file=article&amp;sid=574&amp;mode=&amp;order=0&amp;thold=0" target="_blank"><span style="font-family: Comic Sans MS; color: #0080ff;"> Statistics</span></a><span style="font-family: Comic Sans MS; color: #0080ff;">:</span></div>\r\n<div><br /><span style="font-family: Comic Sans MS; color: #804040;">*Fingermarks/prints cause 43% of disc problems!<br />* General wear &amp; tear causes 25% of disc problems!<br />* Player-related issues cause 15% of disc problems!<br />* User-related issues cause 12% of disc problems!  <br />* PlayStation 2 machine scratches cause 3% of disc problems!<br />* Laser rot (a manufacturer error) causes 2% of disc problems!</span></div>', '', 1, 0, 0, 0, '2009-12-30 17:45:44', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 17:45:44', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 7, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (18, 'DVD Basics', 'dvd-basics', '', '<p><br /><span><strong>ABCs of DVD Drive Abbreviations</strong></span> <br /> <br /><span> The number of different formats available in DVD drives can be confusing to anyone in the market for one. The list is much longer, but to address a few of the common formats, we have DVD-ROM, DVD-R, DVD-RW, DVD+R, DVD+RW, DVD-RAM ,DVD+R DL and DVD±RW. Wow! This list of common formats is long enough, no wonder it’s confusing!</span> <br /> <br /><span><strong>What''s with all the Formats?!</strong></span> <br /><span> </span> <br /><span> The reason for various recordable DVD formats is that no one group owns the technology and different groups have chosen to support one technology over another. There is no industrial standard for manufacturers to reference, so for the time being consumers will have a few choices.</span> <br /><span>The first thing to address is DVD itself, which stands for Digital Versatile Disc. Some may argue that the V stands for Video, but with the capability to store video, audio, and data files, Versatile is definitely the keyword.</span> <br /> <br /><span><strong>Start with the Basics</strong></span> <br /> <br /><span> A DVD-ROM drive is the only one we will address that does not record. ROM stands for Read Only Memory, and refers to the typical drive that can merely read DVDs, as well as CDs (all DVD drives can read CDs). The Lite-On LTD-163-DO-R has attributes representative of your typical DVD-ROM drive, and features a maximum DVD read speed of 16x and a maximum CD read speed of 48x. Before getting into the different recordable formats, let’s address the basics of what the R and RW stand for, regardless of whether there is a + or – in the middle. R stands for Recordable, which indicates that the disk may be recorded to only once. RW stands for ReWritable, which indicates that the disc may be recorded to more than once, and are generally rated for 1000 rewrites under good conditions. The DVD-R/-RW format was developed by Pioneer, and was the first format compatible with stand alone DVD players. The group that promotes the technology calls itself the DVD Forum, which is “an international association of hardware manufacturers, software firms, content providers, and other users” with notable members such as Hitachi, Samsung, and Toshiba. The DVD-R/-RW format is based on CD-RW technology and uses a similar approach to burning discs.</span> <br /> <br /><span> The DVD+R/+RW format is a newer format, also based on CD-RW technology, and compatible with a large percentage of stand alone DVD players. The +R/+RW technology is not supported by the DVD Forum, and its main backing comes from a group called the DVD+RW Alliance. The Alliance “is a voluntary group of industry-leading personal computing manufacturers, optical storage and electronics manufacturers” with members such as Dell, Hewlett Packard, Sony, and Phillips Electronics.</span> <br /><span>The DVD-RAM format is based on PD-RW (Phase-Differential) drives, and actually uses a cartridge to hold the media (just like its PD-RW predecessor). Some DVD-RAM cartridges are double sided, making them ideal for companies to use as system backup, hence DVD-RAM is usually found only in commercial applications, and most end-users won’t ever need to use or see this type of drive. The DVD-RAM standard is also supported by the DVD Forum just like the DVD-R/RW format. However, because of its use of a cartridge (limiting it’s compatibility), and the scarcity and price of the media used, DVD-RAM is a distant third when compared to the DVD+R/+RW and DVD-R/–RW technology. </span> <br /> <br /><span> The +R/+RW and –R/-RW formats are similar, and the main difference DVD+R technology has is the ability to record to multiple layers (with its new DVD+R DL format), where DVD-R can only record to one layer (not all +R drives are capable of dual layer burning, but no -R drives are). The Plextor PX-504U is an example of an external DVD+R/+RW drive capable of recording single layer discs in the +R/+RW format, but also able to read discs recorded by a DVD-R drive.</span> <br /> <br /><span><strong>What is DVD±RW?</strong></span> <br /><span> </span> <br /><span> DVD±RW is not actually a separate format, but the designation given to drives capable of both –R/–RW and +R/+RW operation. This type of drive is typically called a “Dual Drive” (not to be confused with a “Double Layer” drive) since it can write to both the +R/+RW and –R/–RW formats. The Samsung TS-H552 is a DVD±RW drive capable of reading and writing every format discussed so far, and then some. It takes advantage of DVD+R DL (Double Layer) technology available with the +R format, allowing the appropriate media to store virtually double the 4.37 GB capacity of a typical single layer disc.</span> <br /> <br /><span> The other main thing to consider with DVD burners is selecting the correct media. Media for DVD-R, DVD-RW, DVD+R and DVD+RW media may all look the same, but they are slightly different in order to match the specific recording formats. The price of media for either format is generally the same, with RW media costing a good deal more than R media of either format. Double Layer media is even more expensive, and is the only way for an owner of DVD+R DL drive to take advantage of the tremendous capacity increase. As the amount of Double Layer drives increase in the market, the price of the DVD+R DL media is expected to fall with increased production of the media. DVD Burners (as these drive are often referred to) can be picky about the media supported, so be sure to choose your media wisely.</span> <br /> <br /><span><strong>DVD in a Nutshell</strong></span> <br /> <br /><span>DVD-ROM : Reads DVD discs </span> <br /> <br /><span>DVD+R : Writes to DVD+R media (will also typically write to CD-R and CD-RW media) </span> <br /> <br /><span>DVD+RW : Writes to DVD+RW media (will also typically write to DVD+R, CD-R and CD-RW media) </span> <br /> <br /><span>DVD+R DL : Writes to DVD+R DL (Double Layer) media (will also typically write to DVD+R, DVD+RW, CD-R and CD-RW media; many Double Layer drives are ALSO dual drives – that is, able to write to BOTH +R/RW and –R/RW media) </span> <br /> <br /><span>DVD-RAM : Writes to DVD-RAM cartridges (not in wide use on consumer market – mainly a business format; can also read PD-RW discs. Will not usually be able to write to any other format including CD-R or CD-RW)</span> <br /> <br /><span>DVD-R : Writes to DVD-R media (will also typically write to CD-R and CD-RW media) DVD-RW : Writes to DVD-RW media (will also typically write to DVD-R, CD-R and CD-RW media) </span> <br /> <br /><span>DVD±RW : Writes to DVD-RW and DVD+RW media (will also typically write to DVD-R, DVD+R, CD-R and CD-RW media; typically called “Dual Drives” since it can burn to two different DVD formats)</span> <br /> <br /><span><strong>Final Words</strong></span> <br /> <br /><span> This article took a look at the more common formats of DVD drives in order to shed some light on all the choices available. The differences between them all may be subtle, but the compatibility issues can be quite frustrating. The simple answer to anyone considering a drive is to forget about + and – by themselves, and shoot for universal compatibility with a good DVD±RW with DVD+R DL support.</span></p>', '', 1, 0, 0, 0, '2009-12-30 17:52:28', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 17:52:28', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 6, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (19, 'OS Glimpse', 'os-glimpse', '', '<p> </p>\r\n<p><br /><span style="font-size: medium;"><strong>Windows</strong>: A family of operating systems for personal computers, Windows dominates the personal computer world, running, by some estimates, on 90% of all personal computers. Like the Macintosh operating environment, Windows provides a graphical user interface (GUI), virtual memory management, multitasking, and support for many peripheral devices. In addition to Windows 3.x and Windows 95, which run on Intel -based machines, Microsoft also sells Windows NT, a more advanced operating system that runs on a variety of hardware platforms.</span> <br /> <br /><span style="font-size: medium;"><strong>Windows CE</strong>: Windows CE is a version of the Windows operating system designed for small devices such as personal digital assistants (PDAs) (or Handheld PCs in the Microsoft vernacular). The Windows CE graphical user interface (GUI) is very similar to Windows 95 so devices running Windows CE should be easy to operate for anyone familiar with Windows 95.</span> <br /> <br /><span style="font-size: medium;"><strong>Windows 98</strong>: The heir apparent to Windows 95, Windows 95 was released in mid-1998. Originally it was called Memphis, and then Windows 97, but Microsoft changed the name when it realized that it was going to miss its target 1997 release date. Windows 98 offers support for a number of new technologies, including FAT32, AGP, MMX, USB, DVD and ACPI. Its most visible feature, though, is the Active Desktop, which internet explorer with the operating system. From the user''s point of view, there is no difference between accessing a document residing locally on the user''s hard disk or on a web server halfway around the world. </span> <br /> <br /><span style="font-size: medium;"><strong>Windows NT</strong>: The most advanced version of the Windows operating system, Windows NT is a 32-bit operating system that supports preemptive multitasking. There are actually two versions of Windows NT: Windows NT Server, designed to act as a server in networks, and Windows NT Workstation for stand-alone or client workstations.</span> <br /> <br /><span style="font-size: medium;"><strong>Windows 2000:</strong> Windows 2000 is the name given to the next version of Microsoft''s line of operating systems, formerly know as Windows NT 5.0. In the future, the core code of NT will serve as the basis for all of Microsoft''s PC operating systems--from consumer PCs to the highest performance servers. In fact, the next major release for consumers to follow Windows 98 will be based on the Windows NT code base. This name will encompass all future business and consumer releases of Windows. </span> <br /> <br /><span style="font-size: medium;"><strong>Windows 2000 Professional</strong>: Windows 2000 Professional will be Microsoft''s mainstream desktop operating system for businesses of all sizes, replacing Windows NT Workstation 4.0, which many people are using today as the standard business desktop. Windows 2000 Professional will deliver the easiest Windows yet, the highest level of security, state-of-the-art features for mobile users, industrial-strength reliability, and better performance while lowering the total cost of ownership through improved manageability. </span> <br /> <br /><span style="font-size: medium;"><strong>Windows 2000 Server</strong>: Windows 2000 Server will offer industry-leading functionality and support new systems with up to two-way symmetric multi-processing (SMP). Ideal for small to medium enterprise application deployments, Web servers, workgroups, and branch offices, this version of Windows 2000 is expected to be the most popular server version. Existing Windows NT Server 4.0 systems with up to four-way SMP can be upgraded to this product. </span> <br /> <br /><span style="font-size: medium;"><strong>Windows 2000 Advanced Server</strong>: Windows 2000 Advanced Server will be a more powerful departmental and application server, also providing rich network operating system (NOS) and Internet services. Supporting new systems with up to four-way SMP, and/or large physical memories, this new product offering will be ideal for database-intensive work, and will integrate clustering and load balancing support to provide excellent system and application availability. Existing Windows NT 4.0 Enterprise Edition servers with up to eight-way SMP can install this product, which will be priced below today''s Windows NT Server Enterprise Edition product.</span> <br /> <br /><span style="font-size: medium;"><strong>Windows 2000 Datacenter Server</strong>: Windows 2000 Datacenter Server will be the most powerful and functional server operating system ever offered by Microsoft. It supports up to 16-way SMP and up to 64GB of physical memory (depending on system architecture). Like Windows 2000 Advanced Server, it will provide both clustering and load balancing services as standard features. It is optimized for large data warehouses, econometric analysis, large-scale simulations in science and engineering, OLTP, and server consolidation projects.</span> <br /> <br /><span style="font-size: medium;"><strong>Windows XP</strong>: An upgraded client version of Windows 2000, Windows XP provides numerous changes to the user interface, including the Start menu, Taskbar and control panels. XP adds improved support for gaming, digital photography, instant messaging and wireless networking. XP Home Edition is designed for the consumer, and XP Professional is aimed at the office worker with added security and administrative options. XP supports the ClearType display technology for improved sharpness on LCD screens. Internet enhancements include Internet Explorer 6, improved connection sharing and a built-in firewall. A 64-bit version is also provided. Originally code named Whistler, Windows XP is .NET enabled.</span> <br /> <br /><span style="font-size: medium;"><strong>UNIX:</strong> UNIX is a multiuser, multitasking operating system that is widely used as the master control program in workstations and especially servers. A myriad of commercial applications run on UNIX servers, and most Web sites run under UNIX. There are many versions of UNIX, and, except for the PC world, where Windows dominates, almost every hardware vendor offers it either as its primary or secondary operating system. UNIX is written in C.</span> <br /> <br /><span style="font-size: medium;"><strong>Linux:</strong> A version of UNIX that runs on a variety of hardware platforms including x86 PCs, Alpha, PowerPC and IBM''s product line. Linux is open source software, which is freely available; however, the full distribution of Linux along with technical support and training are available for a fee from vendors such as Red Hat Software and Caldera. Due to its stability, Linux has gained popularity with ISPs as the OS for hosting Web servers.</span> <br /> <br /><span style="font-size: medium;"><strong>Solaris:</strong> Solaris is a multitasking, multiprocessing operating system and distributed computing environment for Sun''s SPARC computers from SunSoft. It provides an enterprise-wide UNIX environment that can manage up to 40,000 nodes from one central station. Solaris is known for its robustness and scalability, which is expected in UNIX-based SMP systems. An x86 version of Solaris is available that can also run applications written for Sun''s Interactive UNIX.</span></p>', '', 1, 0, 0, 0, '2009-12-30 17:58:31', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 17:58:31', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 5, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (20, 'Jargons', 'jargons', '', '<p> </p>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>Net</strong> - The Net is a common term for the Internet. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Netiquette</strong> - The ethical and cultural rules of using the Internet, such as not posting advertisements to Usenet discussion groups (unless they allow them), not posting the same message to several newsgroups, avoidance of ''shouting'' in e-mails (using nothing but capital letters), avoiding sending unsolicited e-mails, etc.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Networking</strong> - A network is nothing more than two or more computers joined together by a cable and software. They can then share information, like a customer database, and peripherals, like printers and CD-ROM writers. They can share software programs, such as work processing packages, and communicate using e-mail. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Network card</strong> - A wafer-shaped piece of hardware that enables a computer to be linked up, via cabling, to other machines in the network. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Newsgroups</strong> - General discussion forums, rather like global electronic blackboards, covering every subject imaginable. There are more than 45,000 such groups.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Palmtop</strong> - A palmtop (or PDA, personal digital assistant) is basically a computer in the form of an electronic organiser. They are becoming increasingly powerful and can be used as an alternative to laptops, though their keyboards and displays are much smaller. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Password</strong> - A string of digits or characters providing confidential authentication information.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Payment Gateway</strong> - A system that provides online e-commerce facilities to merchants on the Internet that links directly into a bank''s financial system. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>PC</strong> - Personal computer. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>PCN</strong> (personal communications network) - A digital network technology operated by some of the mobile phone operators. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>PDA</strong> - See palmtop. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Peer-to-peer</strong> (P2P) - One of the simplest network arrangements, involving linking a series of computers together without the use of a server. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Peripheral</strong> - A peripheral is anything that is not part of the main computer unit, such as the keyboard, monitor or printer.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>PERL</strong> ( Practical Extraction and Reporting Language) - A popular language for web scripting (used to create web pages and web sites). Although Perl can be used on any system, it is usually associated with Unix/Linux. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>PHP</strong> (Hypertext Preprocessor) - A popular scripting language supported by Unix/Linux and Windows systems. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Plug and play</strong> - A Windows option that allows multimedia peripherals, such as a CD-ROM drive, to be automatically recognised and set up by the operating system.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Portal</strong> - A web site that is used to get to another site and a range of services. Scottish-Enterprise.com is a </span> <br /><span style="font-family: sans-serif; font-size: small;">portal site.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>POP</strong> - It is important, when use a dial-up connection to the Internet, that you do so though a local Point-of-Presence (POP). This means that all your connections are charged as local rate calls. If you had to call long-distance, your phone bill would soon mount up. Most internet providers now charge a flat monthly fee and waive call charges (within limits).</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Portal</strong> - A website that acts as a comprehensive information source covering a specific sector or subject, and which is used to get to another site and a range of services. Scottish-Enterprise.com is a portal site. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Proxy server</strong> - An intermediary application that sits between a client and a server, and which stores and forwards requests and information. Often used in conjunction with a firewall to monitor Internet traffic and activity.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Proprietary</strong> - A proprietary operating system is one that can only be used on one brand of computer and uses software especially written for that system, for instance Apple OS can only be used on Apple Macintosh computers.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Protocol</strong> - The set of rules governing the format and control of messages being sent around a network. </span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>RAM</strong> (Random Access Memory) - The main memory of a computer. Upgrading the available RAM will often dramatically improve a PC''s performance. 128 MB of RAM is often standard for new PCs, although double this figure is much better. RAM is now very cheap.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Real Time Transaction</strong> - An Internet payment system in which credit card details are authenticated and verified within a matter of seconds.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Reciprocal Link</strong> - When two (or more) websites exchange URLs by mentioning each other on their own sites.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>ROM</strong> (Read Only Memory) - Where PCs store important information that they need to run the operating system and other software. Unlike RAM, ROM is permanent and its contents cannot be changed, replaced or deleted.</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>Scanner</strong> - A scanner is a device that captures text or images from a document for storage in a computer system. Scanners can be used to grab photographs for desktop publishing or to store copies of incoming letters, invoices and so on. Once you have digital copies of documents, you can cut the amount of paper you need to store, access their contents from anywhere on your network an, with the right software, search for information faster and more accurately. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Script</strong> - A program which is executed by the web server. ASP and PHP are two popular scripting languages as they allow program instructions to be mixed with HTML.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>SCSI</strong> - Pronounced ''scizzy'', a SCSI (small computer system interface) port is a specification for connecting hard disks, CD-ROMs, printers and other devices to a computer.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Search engines</strong> - Search engine software (on sites such as Google, Yahoo! Alta Vista or Lycos) helps you find what you are looking for on the World Wide Web. When you type in a word or phrase to describe what you are looking for, the search engine matches this against its index, to offer a list of likely matches. Getting an e-commerce site listed on the major search engines is vital for attracting visitors and business. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Secure server</strong> - A web server offering e-commerce facilities via a secure web site by use of technologies such as encryption and digital certificates.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Shareware</strong> - Shareware software is distributed free, usually via the Internet. You can use it for evaluation purposes, but are trusted to send money to the authors if you want to use it regularly. Sometimes sending a payment brings a more powerful version of the software, together with access to technical support and future upgrades. For small software firms, shareware can provide access to markets without the need to invest heavily in marketing and distribution. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Shopping Basket</strong> - A software system used by websites that allows visitors to place their goods and products in an electronic shopping cart. Items can be added and removed very easily before proceeding to the ''checkout'' at the website to pay for the goods purchased.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Signatures</strong> - When a file is passed through a message digest, the resulting output number is encrypted with your private key to create a digital signature. This can then be attached to the original file so recipients can decrypt your signature and check the message digest number to ensure the file has not been tampered with in transit.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Software</strong> - Software is the program, or set of instructions, that tells a computer what to do. There are two basic types of software. The ''operating system'' - such as Windows XP - controls the basic workings of a computer, while ''application software'' - such as Microsoft Word, Sun''s Star Office and Adobe Photoshop - allows you to do particular jobs. There are also other types of software - for example, network software, which enables a group of computers to communicate with one another, and language software, which helps programmers to write other software. </span> <br /><span style="font-family: sans-serif; font-size: small;"><strong><br /> Sound card</strong> - A device that allows a computer to play sophisticated audio files. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Spam</strong> - Unsolicited email advertising which targets many recipients simultaneously. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Spider</strong> -  Search engine software that automatically scans the Internet, collecting information as they go, which is then indexed and stored on the search engine''s query database.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Spreadsheet</strong> - Software that allows you to store, compare and analyse large amounts of numerical data. Spreadsheets are commonly used for budgets, forecasting and accounts. One distinctive feature of a spreadsheet is its ability to project possibilities and answer ''what-if?'' questions. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>SSL</strong> (Secure Socket Layers) - Netscape''s de facto standard for encrypting TCP/IP applications, but used mainly for encrypting communications over the web. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Surfing</strong> - Slang term for the process of moving around the web. Now out of favour, because of its implications of directionless wandering. </span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>Tags</strong> - Elements within web pages that describe how the information in that web page should be structured and displayed.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>TCP/IP</strong> - Transmission Control Protocol/Internet Protocol - the fundamental communication mechanism used on the Internet. Invented by Robert Kahn and Vint Cerf. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Teleworking</strong> - What happens when people use technology such as video and data conferencing to work with each other at a distance.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Telnet</strong> - An application allowing remote login between computers located anywhere on the Internet.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Terminal Adapter</strong> - A device allowing data to be sent over an ISDN line, much like a conventional modem does over a telephone line.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Topology</strong> - A network''s topology is a description of the kind of layout that has been used to cable the computers together. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Twisted pair</strong> - Twisted pair is a networking cabling system that uses the same kind of cabling as ordinary phone wires. </span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>UPS</strong> (Uninterruptible Power Supply) -  A system which allows computers to keep running for a limited time during a power failure. It gives you the chance to save data before your system crashes. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>URL</strong> (uniform resource locator) - is the address of a file accessible on the Internet, such as a website address. The unique identification of a web site or web resource, such as </span> <br /></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>VAN</strong> - Companies using EDI (electronic data interchange) usually exchange transactions through a third party VAN (value added network). These VANs enable their customers to send electronic messages to any number of trading partners, whenever they choose. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Video and data conferencing</strong> - Video and data conferencing lets you see and speak to a customer anywhere in the world, work on documents together, present your products or discuss new ideas. It can save fares and travel time, improve customer relationships, allow quicker decision making and cut time to market. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Visitors</strong> - The number of people arriving at your website. Can be measured over an hour, day, week, month, etc. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Voicemail</strong> - Voicemail is effectively a personal answering machine, which allows callers to leave you messages that can then be stored, copied or forwarded. </span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>WAN</strong> (Wide Area Network) - WANs offer ways of linking computers at different office sites, perhaps hundreds of miles apart, so that they can share information and specialised peripherals. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Web</strong> - The web is the common shorthand term for the World Wide Web. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Web browser</strong> - A software program that enables someone to surf the web. The two most common browsers are Microsoft''s Internet Explorer and Netscape.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Web server</strong> -  A software program that manages a web site, fulfilling user requests, monitoring web site usage, checking access controls, etc.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Web page</strong> - A web page is a ''page'' of information - though it can be almost any length - made available via the Internet. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Website</strong> - A website is an organised and structured collection of web pages. A clear, interesting, well-planned website is the cornerstone of any e-commerce operation. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>WiFi</strong> (Wireless Fidelity) - A radio frequency standard that is used to connect devices, such as computers, together using a wireless connection.  Instead of computers being connected with network cables, signals are sent over radio frequencies using wireless network cards and hubs.</span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>World Wide Web</strong> - The web gives you user-friendly access to millions of pages of business information and thousands of sources of supply you never knew about before. It also offers the opportunity to access customers and markets you could never have hoped to reach in the past. Having your own website lets you promote and sell your products and services to the world. Customers can potentially look through your catalogue, place orders and pay by credit card - all on-line, 24 hours a day. The web can also provide cheap, effective ways to beef up your after-sales service and to work more closely with all your trading partners. </span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<table border="0" align="center">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-family: sans-serif; font-size: small;"><strong>XML</strong> (eXtensible Markup Language) - A modern, very flexible language that is increasingly being used to send all kinds of data across the Internet. XML''s uses include the exchange of critical financial data, as well as serving Web pages in a similar way to HTML.</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>', '', 1, 0, 0, 0, '2009-12-30 17:59:56', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 17:59:56', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 4, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (21, 'Virtual Memory', 'virtual-memory', '', '<p><br /><span style="font-family: Times New Roman; font-size: medium;"><strong><span style="text-decoration: underline;">Tutorial Introduction &amp; Background</span></strong></span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> Today application is getting bigger and bigger. Therefore, it requires a bigger system memory in order for the system to hold the application data, instruction, and thread and to load it. The system needs to copy the application data from the HDD into the system memory in order for it to process and execute the data. Once the memory gets filled up with data, the system will stop loading the program. In this case, users need to add more memory onto their system to support that intense application. However, adding more system memory costs the money and the normal user only needs to run the the intense application that requires the memory only for one or two days. Therefore, virtual memory is introduced to solve that type of problem.</span> <br /> <br /> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"><strong><span style="text-decoration: underline;">There are two types of memory, which are as follows:</span></strong></span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"><strong> * System Memory</strong> is a memory that is used to store the application data and instruction in order for the system to process and execute that application data and instruction. When you install the memory sticks to increase the system RAM, you are adding more system memory. System Memory can be known as either the physical memory or the main memory.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"><strong> * Virtual Memory </strong>is a memory that uses a portion of HDD space as the memory to store the application data and instruction that the system deemed it doesn''t need to process for now. Virtual Memory can be known as the logical memory, and it controls by the Operating System, which is Microsoft Windows. Adding the Virtual Memory can be done in system configuration.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> Virtual Memory is a HDD space that uses some portion of it as the memory. It is used to store application data and instruction that is currently not needed to be process by the system.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> During the program loading process, the system will copy the application data and its instruction from the HDD into the main memory (system memory). Therefore the system can use its resources such as CPU to process and execute it. Once the system memory gets filled up, the system will start moving some of the data and instruction that don''t need to process anymore into the Virtual Memory until those data and instruction need to process again. So the system can call the next application data and instruction and copy it into the main memory in order for the system to process the rest and load the program. When the data and instruction that is in the Virtual Memory needs to process again, the system will first check the main memory for its space. If there is space, it will simply swap those into the main memory. If there are not any space left for the main memory, the system will first check the main memory and move any data and instructions that doesn''t need to be process into the Virtual Memory. And then swap the data and instruction that need to be process by the system from the Virtual Memory into the main memory.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> Having too low of Virtual Memory size or large Virtual Memory size (meaning the size that is above double of the system memory) is not a good idea. If you set the Virtual Memory too low, then the OS will keep issuing an error message that states either Not enough memory or Virtual too low. This is because some portion of the system memory are used to store the OS Kernel, and it requires to be remain in the main memory all the time. Therefore the system needs to have a space to store the not currently needed process data and instruction when the main memory get filled up. If you set the Virtual Memory size too large to support the intensive application, it is also not a good idea. Because it will create the performance lagging, and even it will take the HDD free space. The system needs to transfer the application data and instruction back and forth between the Virtual Memory and the System Memory. Therefore, that is not a good idea. The ideal size for the Virtual Memory is the default size of Virtual Memory, and it should not be exceed the value of the triple size of system memory.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> To determine how much virtual memory you need, since the user''s system contains the different amount of RAM, it is based on the system. By default, the OS will set the appropriate size for Virtual Memory. The default and appropriate size of Virtual Memory is:</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">CODE</span> <br /><span style="font-family: Times New Roman; font-size: medium;">&lt;Amount_Of_System_Memory&gt; * 1.5 = &lt;Default_Appropriate_Size_Of_Virtual Memory&gt;</span> <br /><span style="font-family: Times New Roman; font-size: medium;">.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">For example, if your system contains 256 MB of RAM, you should set 384 MB for Virtual Memory.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">CODE</span> <br /><span style="font-family: Times New Roman; font-size: medium;">256 MB of RAM (Main Memory) * 1.5 = 384 MB for Virtual Memory</span> <br /> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> If you would like to determine how much the Virtual Memory is for your system and/or would like to configure and add more virtual memory, follow the procedure that is shown below. The following procedure is based on windows XP Professional.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">1-1) Go to right-click My Computer and choose Properties</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">1-2) In the System Properties dialog box, go to Advanced tab</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">1-3) Click Settings button that is from the Performance frame</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">1-4) Once the Performance Options shows up on the screen, go to Advanced tab</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">1-5) Under the Advanced tab, click the Change button from the Virtual Memory frame to access to the Virtual Memory setting</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> Then the Virtual Memory dialog box appears on the screen. In there, you are able to check how much the Virtual Memory you set. If you would like to modify the size of Virtual Memory, follow the procedure that is shown below.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">2-1) In there, select the drive letter that is used to install the Operating System</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">2-2) Choose the option that says, "Custom Size:"</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">Once you choose that option, the setting for Initial Size and Maximum Size become available for you to set. Initial Size (MB) means the actual size of Virtual Memory, and Maximum Size (MB) means the maximum size of Virtual Memory that is allowed to use.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">Let''s say if your system contains 512 MB of RAM, then the ideal setting for the Virtual Memory is as follows:</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">CODE</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">Initial Size (MB):  768</span> <br /><span style="font-family: Times New Roman; font-size: medium;">Maximum Size (MB):  1500</span> <br /> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">Once you are happy with that Virtual Memory size, click the Set button from Paging file size for selected drive to apply the setting for the Virtual Memory size. Then click the OK button to apply the setting.</span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;">That''s where you can manage and configure for the size of Virtual Memory.</span> <br /> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"><strong><span style="text-decoration: underline;">Additional Information</span></strong></span> <br /> <br /><span style="font-family: Times New Roman; font-size: medium;"> * To maintain the good overall system performance, you should be using the default size of actual size for Virtual Memory and the triple the value of the size of the main memory for the maximum size of Virtual Memory. If you find that main memory plus virtual memory is not big enough to load the intensive application, then you will need to add more main memory onto your system.</span> <br /> <br /></p>', '', 1, 0, 0, 0, '2009-12-30 18:10:11', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 18:10:11', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 3, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (22, 'Firewall', 'firewall', '', '<p><br /><span style="font-family: sans-serif; font-size: small;"><strong>What is a firewall? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> A firewall protects networked computers from intentional hostile intrusion that could compromise confidentiality or result in data corruption or denial of service. It may be a hardware device running on a secure host computer. In either case, it must have at least two network interfaces, one for the network it is intended to protect, and one for the network it is exposed to. A firewall sits at the junction point or gateway between the two networks, usually a private network and a public network such as the Internet. The earliest firewalls were simply routers. The term firewall comes from the fact that by segmenting a network into different physical subnetworks, they limited the damage that could spread from one subnet to another just like firedoors or firewalls.</span> <br /><span style="font-family: sans-serif; font-size: small;"> </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>What does a firewall do? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> A firewall examines all traffic routed between the two networks to see if it meets certain criteria. If it does, it is routed between the networks, otherwise it is stopped. A firewall filters both inbound and outbound traffic. It can also manage public access to private networked resources such as host applications. It can be used to log all attempts to enter the private network and trigger alarms when hostile or unauthorized entry is attempted. Firewalls can filter packets based on their source and destination addresses and port numbers. This is known as address filtering. Firewalls can also filter specific types of network traffic. This is also known as protocol filtering because the decision to forward or reject traffic is dependant upon the protocol used, for example HTTP, ftp or telnet. Firewalls can also filter traffic by packet attribute or state. </span> <br /><span style="font-family: sans-serif; font-size: small;"> </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>What can''t a firewall do? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> A firewall cannot prevent individual users with modems from dialling into or out of the network, bypassing the firewall altogether. Employee misconduct or carelessness cannot be controlled by firewalls. Policies involving the use and misuse of passwords and user accounts must be strictly enforced. These are management issues that should be raised during the planning of any security policy but that cannot be solved with firewalls alone. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> The arrest of the Phonemasters cracker ring brought these security issues to light. Although they were accused of breaking into information systems run by AT&amp;T Corp., British Telecommunications Inc., GTE Corp., MCI WorldCom, Southwestern Bell, and Sprint Corp, the group did not use any high tech methods such as IP spoofing (see question 10). They used a combination of social engineering and dumpster diving. Social engineering involves skills not unlike those of a confidence trickster. People are tricked into revealing sensitive information. Dumpster diving or garbology, as the name suggests, is just plain old looking through company trash. Firewalls cannot be effective against either of these techniques. </span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Who needs a firewall? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Anyone who is responsible for a private network that is connected to a public network needs firewall protection. Furthermore, anyone who connects so much as a single computer to the Internet via modem should have personal firewall software. Many dial-up Internet users believe that anonymity will protect them. They feel that no malicious intruder would be motivated to break into their computer. Dial up users who have been victims of malicious attacks and who have lost entire days of work, perhaps having to reinstall their operating system, know that this is not true. Irresponsible pranksters can use automated robots to scan random IP addresses and attack whenever the opportunity presents itself. </span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>How does a firewall work? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> There are two access denial methodologies used by firewalls. A firewall may allow all traffic through unless it meets certain criteria, or it may deny all traffic unless it meets certain criteria . The type of criteria used to determine whether traffic should be allowed through varies from one type of firewall to another. Firewalls may be concerned with the type of traffic, or with source or destination addresses and ports. They may also use complex rule bases that analyse the application data to determine if the traffic should be allowed through. How a firewall determines what traffic to let through depends on which network layer it operates at. A discussion on network layers and architecture follows. </span> <br /><span style="font-family: sans-serif; font-size: small;"> </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>What are the OSI and TCP/IP Network models? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> To understand how firewalls work it helps to understand how the different layers of a network interact. Network architecture is designed around a seven layer model. Each layer has its own set of responsibilities, and handles them in a well-defined manner. This enables networks to mix and match network protocols and physical supports. In a given network, a single protocol can travel over more than one physical support (layer one) because the physical layer has been dissociated from the protocol layers (layers three to seven). Similarly, a single physical cable can carry more than one protocol. The TCP/IP model is older than the OSI industry standard model which is why it does not comply in every respect. The first four layers are so closely analogous to OSI layers however that interoperability is a day to day reality. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Firewalls operate at different layers to use different criteria to restrict traffic. The lowest layer at which a firewall can work is layer three. In the OSI model this is the network layer. In TCP/IP it is the Internet Protocol layer. This layer is concerned with routing packets to their destination. At this layer a firewall can determine whether a packet is from a trusted source, but cannot be concerned with what it contains or what other packets it is associated with. Firewalls that operate at the transport layer know a little more about a packet, and are able to grant or deny access depending on more sophisticated criteria. At the application level, firewalls know a great deal about what is going on and can be very selective in granting access. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> It would appear then, that firewalls functioning at a higher level in the stack must be superior in every respect. This is not necessarily the case. The lower in the stack the packet is intercepted, the more secure the firewall. If the intruder cannot get past level three, it is impossible to gain control of the operating system. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Professional firewall products catch each network packet before the operating system does, thus, there is no direct path from the Internet to the operating system''s TCP/IP stack. It is therefore very difficult for an intruder to gain control of the firewall host computer then "open the doors" from the inside. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> According To Byte Magazine*, traditional firewall technology is susceptible to misconfiguration on non-hardened OSes. More recently, however, "...firewalls have moved down the protocol stack so far that the OS doesn''t have to do much more than act as a bootstrap loader, file system and GUI". The author goes on to state that newer firewall code bypasses the operating system''s IP layer altogether, never permitting "potentially hostile traffic to make its way up the protocol stack to applications running on the system". </span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>What different types of firewalls are there? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Firewalls fall into four broad categories: packet filters, circuit level gateways, application level gateways and stateful multilayer inspection firewalls. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Packet filtering firewalls work at the network level of the OSI model, or the IP layer of TCP/IP. They are usually part of a router. A router is a device that receives packets from one network and forwards them to another network. In a packet filtering firewall each packet is compared to a set of criteria before it is forwarded. Depending on the packet and the criteria, the firewall can drop the packet, forward it or send a message to the originator. Rules can include source and destination IP address, source and destination port number and protocol used. The advantage of packet filtering firewalls is their low cost and low impact on network performance. Most routers support packet filtering. Even if other firewalls are used, implementing packet filtering at the router level affords an initial degree of security at a low network layer. This type of firewall only works at the network layer however and does not support sophisticated rule based models . Network Address Translation (NAT) routers offer the advantages of packet filtering firewalls but can also hide the IP addresses of computers behind the firewall, and offer a level of circuit-based filtering. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Circuit level gateways work at the session layer of the OSI model, or the TCP layer of TCP/IP. They monitor TCP handshaking between packets to determine whether a requested session is legitimate. Information passed to remote computer through a circuit level gateway appears to have originated from the gateway. This is useful for hiding information about protected networks. Circuit level gateways are relatively inexpensive and have the advantage of hiding information about the private network they protect. On the other hand, they do not filter individual packets. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Application level gateways, also called proxies, are similar to circuit-level gateways except that they are application specific. They can filter packets at the application layer of the OSI model. Incoming or outgoing packets cannot access services for which there is no proxy. In plain terms, an application level gateway that is configured to be a web proxy will not allow any ftp, gopher, telnet or other traffic through. Because they examine packets at application layer, they can filter application specific commands such as http:post and get, etc. This cannot be accomplished with either packet filtering firewalls or circuit level neither of which know anything about the application level information. Application level gateways can also be used to log user activity and logins. They offer a high level of security, but have a significant impact on network performance. This is because of context switches that slow down network access dramatically. They are not transparent to end users and require manual configuration of each client computer. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Stateful multilayer inspection firewalls combine the aspects of the other three types of firewalls. They filter packets at the network layer, determine whether session packets are legitimate and evaluate contents of packets at the application layer. They allow direct connection between client and host, alleviating the problem caused by the lack of transparency of application level gateways. They rely on algorithms to recognize and process application layer data instead of running application specific proxies. Stateful multilayer inspection firewalls offer a high level of security, good performance and transparency to end users. They are expensive however, and due to their complexity are potentially less secure than simpler types of firewalls if not administered by highly competent personnel. </span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Is a firewall sufficient to secure my network or do I need anything else? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> The firewall is an integral part of any security program, but it is not a security program in and of itself. Security involves data integrity (has it been modified?), service or application integrity (is the service available, and is it performing to spec?), data confidentiality (has anyone seen it?) and authentication (are they really who they say they are?). Firewalls only address the issues of data integrity, confidentiality and authentication of data that is behind the firewall. Any data that transits outside the firewall is subject to factors out of the control of the firewall. It is therefore necessary for an organization to have a well planned and strictly implemented security program that includes but is not limited to firewall protection. </span> <br /><span style="font-family: sans-serif; font-size: small;"> </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>What is IP spoofing? </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Many firewalls examine the source IP addresses of packets to determine if they are legitimate. A firewall may be instructed to allow traffic through if it comes from a specific trusted host. A malicious cracker would then try to gain entry by "spoofing" the source IP address of packets sent to the firewall. If the firewall thought that the packets originated from a trusted host, it may let them through unless other criteria failed to be met. Of course the cracker would need to know a good deal about the firewall''s rule base to exploit this kind of weakness. This reinforces the principle that technology alone will not solve all security problems. Responsible management of information is essential. One of Courtney''s laws sums it up: "There are management solutions to technical problems, but no technical solutions to management problems". </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> An effective measure against IP spoofing is the use of a Virtual Private Network (VPN) protocol such as IPSec. This methodology involves encryption of the data in the packet as well as the source address. The VPN software or firmware decrypts the packet and the source address and performs a checksum. If either the data or the source address have been tampered with, the packet will be dropped. Without access to the encryption keys, a potential intruder would be unable to penetrate the firewall. </span> <br /><span style="font-family: sans-serif; font-size: small;"> </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Firewall related problems </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Firewalls introduce problems of their own. Information security involves constraints, and users don''t like this. It reminds them that Bad Things can and do happen. Firewalls restrict access to certain services. The vendors of information technology are constantly telling us "anything, anywhere, any time", and we believe them naively. Of course they forget to tell us we need to log in and out, to memorize our 27 different passwords, not to write them down on a sticky note on our computer screen and so on. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Firewalls can also constitute a traffic bottleneck. They concentrate security in one spot, aggravating the single point of failure phenomenon. The alternatives however are either no Internet access, or no security, neither of which are acceptable in most organizations. </span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: small;"><strong>Benefits of a firewall </strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Firewalls protect private local area networks from hostile intrusion from the Internet. Consequently, many LANs are now connected to the Internet where Internet connectivity would otherwise have been too great a risk. </span> <br /> <br /><span style="font-family: sans-serif; font-size: small;"> Firewalls allow network administrators to offer access to specific types of Internet services to selected LAN users. This selectivity is an essential part of any information management program, and involves not only protecting private information assets, but also knowing who has access to what. Privileges can be granted according to job description and need rather than on an all-or-nothing basis. </span> <br /><span style="font-family: sans-serif; font-size: small;"> </span></p>', '', 1, 0, 0, 0, '2009-12-30 18:14:11', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 18:14:11', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 2, '', '', 0, 0, 'robots=\nauthor=');
INSERT INTO `jos_content` VALUES (23, 'Regedit', 'regedit', '', '<p><br /><span style="font-family: sans-serif; font-size: x-small;"><strong><span style="text-decoration: underline;">What is the Registry?</span></strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"> The Registry is a database used to store settings and options for the 32 bit versions of Microsoft Windows including Windows 95, 98, ME and NT/2000/XP. It contains information and settings for all the hardware, software, users, and preferences of the PC. Whenever a user makes changes to a Control Panel settings, or File Associations, System Policies, or installed software, the changes are reflected and stored in the Registry.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"> The physical files that make up the registry are stored differently depending on your version of Windows; under Windows 95 &amp; 98 it is contained in two hidden files in your Windows directory, called USER.DAT and SYSTEM.DAT, for Windows Me there is an additional CLASSES.DAT file, while under Windows NT/2000 the files are contained seperately in the %SystemRoot%\\System32\\Config directory. You can not edit these files directly, you must use a tool commonly known as a "Registry Editor" to make any changes (using registry editors will be discussed later in the article).</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong><span style="text-decoration: underline;">The Structure of The Registry</span></strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"> The Registry has a hierarchal structure, although it looks complicated the structure is similar to the directory structure on your hard disk, with Regedit being similar to Windows Explorer.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Each main branch (denoted by a folder icon in the Registry Editor, see left) is called a Hive, and Hives contains Keys. Each key can contain other keys (sometimes referred to as sub-keys), as well as Values. The values contain the actual information stored in the Registry. There are three types of values; String, Binary, and DWORD - the use of these depends upon the context.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">There are six main branches, each containing a specific portion of the information stored in the Registry. They are as follows:</span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* HKEY_CLASSES_ROOT</strong> - This branch contains all of your file association mappings to support the drag-and-drop feature, OLE information, Windows shortcuts, and core aspects of the Windows user interface.</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* HKEY_CURRENT_USER</strong> - This branch links to the section of HKEY_USERS appropriate for the user currently logged onto the PC and contains information such as logon names, desktop settings, and Start menu settings.</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* HKEY_LOCAL_MACHINE</strong> - This branch contains computer specific information about the type of hardware, software, and other preferences on a given PC, this information is used for all users who log onto this computer.</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* HKEY_USERS</strong> - This branch contains individual preferences for each user of the computer, each user is represented by a SID sub-key located under the main branch.</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* HKEY_CURRENT_CONFIG</strong> - This branch links to the section of HKEY_LOCAL_MACHINE appropriate for the current hardware configuration.</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* HKEY_DYN_DATA</strong> - This branch points to the part of HKEY_LOCAL_MACHINE, for use with the Plug-&amp;-Play features of Windows, this section is dymanic and will change as devices are added and removed from the system.</span> <br /> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>Each registry value is stored as one of five main data types:</strong></span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* REG_BINARY </strong>- This type stores the value as raw binary data. Most hardware component information is stored as binary data, and can be displayed in an editor in hexadecimal format.</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* REG_DWORD </strong>- This type represents the data by a four byte number and is commonly used for boolean values, such as "0" is disabled and "1" is enabled. Additionally many parameters for device driver and services are this type, and can be displayed in REGEDT32 in binary, hexadecimal and decimal format, or in REGEDIT in hexadecimal and decimal format.</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* REG_EXPAND_SZ</strong> - This type is an expandable data string that is string containing a variable to be replaced when called by an application. For example, for the following value, the string "%SystemRoot%" will replaced by the actual location of the directory containing the Windows NT system files. (This type is only available using an advanced registry editor such as REGEDT32)</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* REG_MULTI_SZ</strong> - This type is a multiple string used to represent values that contain lists or multiple values, each entry is separated by a NULL character. (This type is only available using an advanced registry editor such as REGEDT32)</span> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>* REG_SZ </strong>- This type is a standard string, used to represent human readable text values.</span> <br /> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>Other data types not available through the standard registry editors include:</strong></span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">* REG_DWORD_LITTLE_ENDIAN - A 32-bit number in little-endian format.</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* REG_DWORD_BIG_ENDIAN - A 32-bit number in big-endian format.</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* REG_LINK - A Unicode symbolic link. Used internally; applications should not use this type.</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* REG_NONE - No defined value type.</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* REG_QWORD - A 64-bit number.</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* REG_QWORD_LITTLE_ENDIAN - A 64-bit number in little-endian format.</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* REG_RESOURCE_LIST - A device-driver resource list.</span> <br /> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong><span style="text-decoration: underline;">Editing The Registry</span></strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">The Registry Editor (REGEDIT.EXE) is included with most version of Windows (although you won''t find it on the Start Menu) it enables you to view, search and edit the data within the Registry. There are several methods for starting the Registry Editor, the simplest is to click on the Start button, then select Run, and in the Open box type "regedit", and if the Registry Editor is installed it should now open and look like the image below.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">An alternative Registry Editor (REGEDT32.EXE) is available for use with Windows NT/2000, it includes some additional features not found in the standard version, including; the ability to view and modify security permissions, and being able to create and modify the extended string values REG_EXPAND_SZ &amp; REG_MULTI_SZ.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong><span style="text-decoration: underline;">Create a Shortcut to Regedit</span></strong></span> <br /><span style="font-family: sans-serif; font-size: x-small;">This can be done by simply right-clicking on a blank area of your desktop, selecting New, then Shortcut, then in the Command line box enter "regedit.exe" and click Next, enter a friendly name (e.g. ''Registry Editor'') then click Finish and now you can double click on the new icon to launch the Registry Editor.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong><span style="text-decoration: underline;">Using Regedit to modify your Registry</span></strong></span> <br /><span style="font-family: sans-serif; font-size: x-small;">Once you have started the Regedit you will notice that on the left side there is a tree with folders, and on the right the contents (values) of the currently selected folder.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Like Windows explorer, to expand a certain branch (see the structure of the registry section), click on the plus sign [+] to the left of any folder, or just double-click on the folder. To display the contents of a key (folder), just click the desired key, and look at the values listed on the right side. You can add a new key or value by selecting New from the Edit menu, or by right-clicking your mouse. And you can rename any value and almost any key with the same method used to rename files; right-click on an object and click rename, or click on it twice (slowly), or just press F2 on the keyboard. Lastly, you can delete a key or value by clicking on it, and pressing Delete on the keyboard, or by right-clicking on it, and choosing Delete.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Note: it is always a good idea to backup your registry before making any changes to it. It can be intimidating to a new user, and there is always the possibility of changing or deleting a critical setting causing you to have to reinstall the whole operating system. It''s much better to be safe than sorry!</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Importing and Exporting Registry Settings</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">A great feature of the Registry Editor is it''s ability to import and export registry settings to a text file, this text file, identified by the .REG extension, can then be saved or shared with other people to easily modify local registry settings. You can see the layout of these text files by simply exporting a key to a file and opening it in Notepad, to do this using the Registry Editor select a key, then from the "Registry" menu choose "Export Registry File...", choose a filename and save. If you open this file in notepad you will see a file similar to the example below:</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Quote:</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">REGEDIT4</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">[HKEY_LOCAL_MACHINE\\SYSTEM\\Setup]</span> <br /><span style="font-family: sans-serif; font-size: x-small;">"SetupType"=dword:00000000</span> <br /><span style="font-family: sans-serif; font-size: x-small;">"CmdLine"="setup -newsetup"</span> <br /><span style="font-family: sans-serif; font-size: x-small;">"SystemPrefix"=hex:c5,0b,00,00,00,40,36,02</span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">The layout is quite simple, REGEDIT4 indicated the file type and version, [HKEY_LOCAL_MACHINE\\SYSTEM\\Setup] indicated the key the values are from, "SetupType"=dword:00000000 are the values themselves the portion after the "=" will vary depending on the type of value they are; DWORD, String or Binary.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">So by simply editing this file to make the changes you want, it can then be easily distributed and all that need to be done is to double-click, or choose "Import" from the Registry menu, for the settings to be added to the system Registry.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Deleting keys or values using a REG file</span> <br /><span style="font-family: sans-serif; font-size: x-small;">It is also possible to delete keys and values using REG files. To delete a key start by using the same format as the the REG file above, but place a "-" symbol in front of the key name you want to delete. For example to delete the [HKEY_LOCAL_MACHINE\\SYSTEM\\Setup] key the reg file would look like this:</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Quote:</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">REGEDIT4</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">[-HKEY_LOCAL_MACHINE\\SYSTEM\\Setup]</span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">The format used to delete individual values is similar, but instead of a minus sign in front of the whole key, place it after the equal sign of the value. For example, to delete the value "SetupType" the file would look like:</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Quote:</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">REGEDIT4</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">[HKEY_LOCAL_MACHINE\\SYSTEM\\Setup]</span> <br /><span style="font-family: sans-serif; font-size: x-small;">"SetupType"=-</span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Use this feature with care, as deleting the wrong key or value could cause major problems within the registry, so remember to always make a backup first.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Regedit Command Line Options</span> <br /><span style="font-family: sans-serif; font-size: x-small;">Regedit has a number of command line options to help automate it''s use in either batch files or from the command prompt. Listed below are some of the options, please note the some of the functions are operating system specific.</span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">* regedit.exe [options] [filename] [regpath]</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* [filename] Import .reg file into the registry</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* /s [filename] Silent import, i.e. hide confirmation box when importing files</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* /e [filename] [regpath] Export the registry to [filename] starting at [regpath]</span> <br /><span style="font-family: sans-serif; font-size: x-small;">e.g. regedit /e file.reg HKEY_USERS\\.DEFAULT</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* /L:system Specify the location of the system.dat to use</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* /R:user Specify the location of the user.dat to use</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* /C [filename] Compress (Windows 98)</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* /D [regpath] Delete the specified key (Windows 98)</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>Maintaining the Registry</strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>How can you backup and restore the Registry?</strong></span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>Windows 95</strong></span> <br /><span style="font-family: sans-serif; font-size: x-small;">Microsoft included a utility on the Windows 95 CD-ROM that lets you create backups of the Registry on your computer. The Microsoft Configuration Backup program, CFGBACK.EXE, can be found in the \\Other\\Misc\\Cfgback directory on the Windows 95 CD-ROM. This utility lets you create up to nine different backup copies of the Registry, which it stores, with the extension RBK, in your \\Windows directory. If your system is set up for multiple users, CFGBACK.EXE won''t back up the USER.DAT file.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">After you have backed up your Registry, you can copy the RBK file onto a floppy disk for safekeeping. However, to restore from a backup, the RBK file must reside in the \\Windows directory. Windows 95 stores the backups in compressed form, which you can then restore only by using the CFGBACK.EXE utility.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>Windows 98</strong></span> <br /><span style="font-family: sans-serif; font-size: x-small;">Microsoft Windows 98 automatically creates a backup copy of the registry every time Windows starts, in addition to this you can manually create a backup using the Registry Checker utility by running SCANREGW.EXE from Start | Run menu.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">What to do if you get a Corrupted Registry</span> <br /><span style="font-family: sans-serif; font-size: x-small;">Windows 95, 98 and NT all have a simple registry backup mechanism that is quite reliable, although you should never simply rely on it, remember to always make a backup first!</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>Windows 95</strong></span> <br /><span style="font-family: sans-serif; font-size: x-small;">In the Windows directory there are several hidden files, four of these will be SYSTEM.DAT &amp; USER.DAT, your current registry, and SYSTEM.DA0 &amp; USER.DA0, a backup of your registry. Windows 9x has a nice reature in that every time it appears to start successfully it will copy the registry over these backup files, so just in case something goes wrong can can restore it to a known good state. To restore the registry follow these instruction:</span> <br /><span style="font-family: sans-serif; font-size: x-small;">[list=1]</span> <br /><span style="font-family: sans-serif; font-size: x-small;">* Click the Start button, and then click Shut Down.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">* Click Restart The Computer In MS-DOS Mode, then click Yes.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">* Change to your Windows directory. For example, if your Windows directory is c:\\windows, you would type the following:</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">cd c:\\windows</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">* Type the following commands, pressing ENTER after each one. (Note that SYSTEM.DA0 and USER.DA0 contain the number zero.)</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">attrib -h -r -s system.dat</span> <br /><span style="font-family: sans-serif; font-size: x-small;">attrib -h -r -s system.da0</span> <br /><span style="font-family: sans-serif; font-size: x-small;">copy system.da0 system.dat</span> <br /><span style="font-family: sans-serif; font-size: x-small;">attrib -h -r -s user.dat</span> <br /><span style="font-family: sans-serif; font-size: x-small;">attrib -h -r -s user.da0</span> <br /><span style="font-family: sans-serif; font-size: x-small;">copy user.da0 user.dat</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">* Restart your computer.</span> <br /> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Following this procedure will restore your registry to its state when you last successfully started your computer.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">If all else fails, there is a file on your hard disk named SYSTEM.1ST that was created when Windows 95 was first successfully installed. If necessary you could also change the file attributes of this file from read-only and hidden to archive to copy the file to C:\\WINDOWS\\SYSTEM.DAT.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;"><strong>Windows NT</strong></span> <br /><span style="font-family: sans-serif; font-size: x-small;">On Windows NT you can use either the "Last Known Good" option or RDISK to restore to registry to a stable working configuration.</span> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">How can I clean out old data from the Registry?</span> <br /><span style="font-family: sans-serif; font-size: x-small;">Although it''s possible to manually go through the Registry and delete unwanted entries, Microsoft provides a tool to automate the process, the program is called RegClean. RegClean analyzes Windows Registry keys stored in a common location in the Windows Registry. It finds keys that contain erroneous values, it removes them from the Windows Registry after having recording those entries in the Undo.Reg file.</span> <br /> <br /> <br /><span style="font-family: sans-serif; font-size: x-small;">Best Regards,<br /> Harisha K</span></p>', '', 1, 0, 0, 0, '2009-12-30 18:20:35', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-12-30 18:20:35', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 1, '', '', 0, 0, 'robots=\nauthor=');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_content_frontpage`
-- 

CREATE TABLE `jos_content_frontpage` (
  `content_id` int(11) NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_content_frontpage`
-- 

INSERT INTO `jos_content_frontpage` VALUES (1, 2);
INSERT INTO `jos_content_frontpage` VALUES (5, 1);
INSERT INTO `jos_content_frontpage` VALUES (4, 3);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_content_rating`
-- 

CREATE TABLE `jos_content_rating` (
  `content_id` int(11) NOT NULL default '0',
  `rating_sum` int(11) unsigned NOT NULL default '0',
  `rating_count` int(11) unsigned NOT NULL default '0',
  `lastip` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_content_rating`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_core_acl_aro`
-- 

CREATE TABLE `jos_core_acl_aro` (
  `id` int(11) NOT NULL auto_increment,
  `section_value` varchar(240) NOT NULL default '0',
  `value` varchar(240) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jos_section_value_value_aro` (`section_value`(100),`value`(100)),
  KEY `jos_gacl_hidden_aro` (`hidden`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- 
-- Dumping data for table `jos_core_acl_aro`
-- 

INSERT INTO `jos_core_acl_aro` VALUES (10, 'users', '62', 0, 'Administrator', 0);
INSERT INTO `jos_core_acl_aro` VALUES (11, 'users', '63', 0, 'Station Master', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_core_acl_aro_groups`
-- 

CREATE TABLE `jos_core_acl_aro_groups` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `lft` int(11) NOT NULL default '0',
  `rgt` int(11) NOT NULL default '0',
  `value` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `jos_gacl_parent_id_aro_groups` (`parent_id`),
  KEY `jos_gacl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

-- 
-- Dumping data for table `jos_core_acl_aro_groups`
-- 

INSERT INTO `jos_core_acl_aro_groups` VALUES (17, 0, 'ROOT', 1, 22, 'ROOT');
INSERT INTO `jos_core_acl_aro_groups` VALUES (28, 17, 'USERS', 2, 21, 'USERS');
INSERT INTO `jos_core_acl_aro_groups` VALUES (29, 28, 'Public Frontend', 3, 12, 'Public Frontend');
INSERT INTO `jos_core_acl_aro_groups` VALUES (18, 29, 'Registered', 4, 11, 'Registered');
INSERT INTO `jos_core_acl_aro_groups` VALUES (19, 18, 'Author', 5, 10, 'Author');
INSERT INTO `jos_core_acl_aro_groups` VALUES (20, 19, 'Editor', 6, 9, 'Editor');
INSERT INTO `jos_core_acl_aro_groups` VALUES (21, 20, 'Publisher', 7, 8, 'Publisher');
INSERT INTO `jos_core_acl_aro_groups` VALUES (30, 28, 'Public Backend', 13, 20, 'Public Backend');
INSERT INTO `jos_core_acl_aro_groups` VALUES (23, 30, 'Manager', 14, 19, 'Manager');
INSERT INTO `jos_core_acl_aro_groups` VALUES (24, 23, 'Administrator', 15, 18, 'Administrator');
INSERT INTO `jos_core_acl_aro_groups` VALUES (25, 24, 'Super Administrator', 16, 17, 'Super Administrator');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_core_acl_aro_map`
-- 

CREATE TABLE `jos_core_acl_aro_map` (
  `acl_id` int(11) NOT NULL default '0',
  `section_value` varchar(230) NOT NULL default '0',
  `value` varchar(100) NOT NULL,
  PRIMARY KEY  (`acl_id`,`section_value`,`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_core_acl_aro_map`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_core_acl_aro_sections`
-- 

CREATE TABLE `jos_core_acl_aro_sections` (
  `id` int(11) NOT NULL auto_increment,
  `value` varchar(230) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(230) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jos_gacl_value_aro_sections` (`value`),
  KEY `jos_gacl_hidden_aro_sections` (`hidden`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- 
-- Dumping data for table `jos_core_acl_aro_sections`
-- 

INSERT INTO `jos_core_acl_aro_sections` VALUES (10, 'users', 1, 'Users', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_core_acl_groups_aro_map`
-- 

CREATE TABLE `jos_core_acl_groups_aro_map` (
  `group_id` int(11) NOT NULL default '0',
  `section_value` varchar(240) NOT NULL default '',
  `aro_id` int(11) NOT NULL default '0',
  UNIQUE KEY `group_id_aro_id_groups_aro_map` (`group_id`,`section_value`,`aro_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_core_acl_groups_aro_map`
-- 

INSERT INTO `jos_core_acl_groups_aro_map` VALUES (25, '', 10);
INSERT INTO `jos_core_acl_groups_aro_map` VALUES (25, '', 11);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_core_log_items`
-- 

CREATE TABLE `jos_core_log_items` (
  `time_stamp` date NOT NULL default '0000-00-00',
  `item_table` varchar(50) NOT NULL default '',
  `item_id` int(11) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_core_log_items`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_core_log_searches`
-- 

CREATE TABLE `jos_core_log_searches` (
  `search_term` varchar(128) NOT NULL default '',
  `hits` int(11) unsigned NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_core_log_searches`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_googleSearch_conf`
-- 

CREATE TABLE `jos_googleSearch_conf` (
  `id` int(11) NOT NULL,
  `google_id` char(16) NOT NULL,
  `width` int(11) NOT NULL,
  `width_searchfield` int(11) NOT NULL,
  `search_button_label` varchar(100) NOT NULL,
  `channel` char(10) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `domain_name` varchar(100) NOT NULL,
  `domain_as_default` char(1) NOT NULL,
  `site_language` varchar(10) NOT NULL,
  `site_encoding` varchar(36) NOT NULL,
  `country` varchar(255) NOT NULL,
  `web_only` char(1) NOT NULL,
  `safesearch` char(1) NOT NULL,
  `display_last_search` char(1) NOT NULL,
  `intitle` char(1) NOT NULL,
  `title_color` varchar(7) NOT NULL,
  `bg_color` varchar(7) NOT NULL,
  `text_color` varchar(7) NOT NULL,
  `url_color` varchar(7) NOT NULL,
  `google_logo_pos` varchar(20) NOT NULL,
  `radio_pos` varchar(20) NOT NULL,
  `button_pos` varchar(20) NOT NULL,
  `google_logo_img` char(2) NOT NULL,
  `button_img` varchar(255) NOT NULL,
  `ad_pos` varchar(20) NOT NULL,
  `watermark_type` varchar(10) NOT NULL,
  `watermark_color_on_blur` varchar(10) NOT NULL,
  `watermark_color_on_focus` varchar(10) NOT NULL,
  `watermark_bg_color_on_blur` varchar(10) NOT NULL,
  `watermark_bg_color_on_focus` varchar(10) NOT NULL,
  `watermark_str` varchar(255) NOT NULL,
  `watermark_img` varchar(255) NOT NULL,
  `mod_width_searchfield` int(11) NOT NULL,
  `display_searchform` char(1) NOT NULL,
  `mod_display_last_search` char(1) NOT NULL,
  `mod_google_logo_pos` varchar(20) NOT NULL,
  `mod_radio_pos` varchar(20) NOT NULL,
  `mod_button_pos` varchar(20) NOT NULL,
  `mod_google_logo_img` char(2) NOT NULL,
  `mod_button_img` varchar(255) NOT NULL,
  `mod_watermark_type` varchar(10) NOT NULL,
  `mod_watermark_color_on_blur` varchar(10) NOT NULL,
  `mod_watermark_color_on_focus` varchar(10) NOT NULL,
  `mod_watermark_bg_color_on_blur` varchar(10) NOT NULL,
  `mod_watermark_bg_color_on_focus` varchar(10) NOT NULL,
  `mod_watermark_str` varchar(255) NOT NULL,
  `mod_watermark_img` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_googleSearch_conf`
-- 

INSERT INTO `jos_googleSearch_conf` VALUES (1, '8770780017522867', 600, 30, 'Search', '', 'techstation.in', 'this website', '1', 'en', 'ISO-8859-1', '', '2', '1', '1', '0', '#0000FF', '#FFFFFF', '#000000', '#008000', 'left', 'below', 'right', '2', '', 'top_bottom', 'text', '#AAAAAA', '#000000', '#FFFFFF', '#FFFFFF', 'search...', '', 16, '1', '0', 'none', 'below', 'below', '2', '', 'google', '#AAAAAA', '#000000', '#FFFFFF', '#FFFFFF', 'search...', '');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_groups`
-- 

CREATE TABLE `jos_groups` (
  `id` tinyint(3) unsigned NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_groups`
-- 

INSERT INTO `jos_groups` VALUES (0, 'Public');
INSERT INTO `jos_groups` VALUES (1, 'Registered');
INSERT INTO `jos_groups` VALUES (2, 'Special');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_menu`
-- 

CREATE TABLE `jos_menu` (
  `id` int(11) NOT NULL auto_increment,
  `menutype` varchar(75) default NULL,
  `name` varchar(255) default NULL,
  `alias` varchar(255) NOT NULL default '',
  `link` text,
  `type` varchar(50) NOT NULL default '',
  `published` tinyint(1) NOT NULL default '0',
  `parent` int(11) unsigned NOT NULL default '0',
  `componentid` int(11) unsigned NOT NULL default '0',
  `sublevel` int(11) default '0',
  `ordering` int(11) default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `pollid` int(11) NOT NULL default '0',
  `browserNav` tinyint(4) default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `utaccess` tinyint(3) unsigned NOT NULL default '0',
  `params` text NOT NULL,
  `lft` int(11) unsigned NOT NULL default '0',
  `rgt` int(11) unsigned NOT NULL default '0',
  `home` int(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `componentid` (`componentid`,`menutype`,`published`,`access`),
  KEY `menutype` (`menutype`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- 
-- Dumping data for table `jos_menu`
-- 

INSERT INTO `jos_menu` VALUES (1, 'mainmenu', 'Home', 'home', 'index.php?option=com_content&view=frontpage', 'component', 1, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 3, 'num_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=front\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 1);
INSERT INTO `jos_menu` VALUES (2, 'mainmenu', 'Perl', 'articles-perl', 'index.php?option=com_content&view=category&layout=blog&id=3', 'component', 1, 0, 20, 0, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_description=0\nshow_description_image=0\nnum_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=\nmulti_column_order=0\nshow_pagination=1\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` VALUES (3, 'examcenter', 'Database', 'database', 'index.php?option=com_mediqna&view=mediqna', 'component', 1, 0, 35, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'page_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` VALUES (4, 'mainmenu', 'test_nl_on_page', 'testnlonpage', 'index.php?option=com_acajoom', 'component', 0, 0, 36, 0, 3, 62, '2009-09-25 08:54:14', 0, 0, 0, 0, 'page_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` VALUES (5, 'interviewstation', 'Database', 'articles-database', 'index.php?option=com_content&view=category&layout=blog&id=1', 'component', 1, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_description=0\nshow_description_image=0\nnum_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=\nmulti_column_order=1\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` VALUES (6, 'interviewstation', 'Perl', 'interview-perl', 'index.php?option=com_content&view=category&layout=blog&id=2', 'component', 1, 0, 20, 0, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_description=0\nshow_description_image=0\nnum_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=\nmulti_column_order=0\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` VALUES (7, 'mainmenu', 'Database', 'article-database', 'index.php?option=com_content&view=category&layout=blog&id=4', 'component', 1, 0, 20, 0, 4, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_description=0\nshow_description_image=0\nnum_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=\nmulti_column_order=0\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` VALUES (8, 'mainmenu', 'Database', 'article-database', 'index.php?option=com_content&view=category&layout=blog&id=4', 'component', 1, 0, 20, 0, 5, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_description=0\nshow_description_image=0\nnum_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=\nmulti_column_order=0\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_menu_types`
-- 

CREATE TABLE `jos_menu_types` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `menutype` varchar(75) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `menutype` (`menutype`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table `jos_menu_types`
-- 

INSERT INTO `jos_menu_types` VALUES (1, 'mainmenu', 'Articles', 'The main menu for the site');
INSERT INTO `jos_menu_types` VALUES (2, 'interviewstation', 'Interview Station', 'Interview questions here');
INSERT INTO `jos_menu_types` VALUES (3, 'examcenter', 'Exam Center', 'All Exams go here');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_messages`
-- 

CREATE TABLE `jos_messages` (
  `message_id` int(10) unsigned NOT NULL auto_increment,
  `user_id_from` int(10) unsigned NOT NULL default '0',
  `user_id_to` int(10) unsigned NOT NULL default '0',
  `folder_id` int(10) unsigned NOT NULL default '0',
  `date_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `state` int(11) NOT NULL default '0',
  `priority` int(1) unsigned NOT NULL default '0',
  `subject` text NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY  (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_messages`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_messages_cfg`
-- 

CREATE TABLE `jos_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL default '0',
  `cfg_name` varchar(100) NOT NULL default '',
  `cfg_value` varchar(255) NOT NULL default '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_messages_cfg`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_migration_backlinks`
-- 

CREATE TABLE `jos_migration_backlinks` (
  `itemid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` text NOT NULL,
  `sefurl` text NOT NULL,
  `newurl` text NOT NULL,
  PRIMARY KEY  (`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_migration_backlinks`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_modules`
-- 

CREATE TABLE `jos_modules` (
  `id` int(11) NOT NULL auto_increment,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL default '0',
  `position` varchar(50) default NULL,
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL default '0',
  `module` varchar(50) default NULL,
  `numnews` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `showtitle` tinyint(3) unsigned NOT NULL default '1',
  `params` text NOT NULL,
  `iscore` tinyint(4) NOT NULL default '0',
  `client_id` tinyint(4) NOT NULL default '0',
  `control` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

-- 
-- Dumping data for table `jos_modules`
-- 

INSERT INTO `jos_modules` VALUES (1, 'Main Menu', '', 0, 'left', 62, '2009-12-17 14:50:17', 1, 'mod_mainmenu', 0, 0, 1, 'menutype=mainmenu\nmenu_style=list_flat\nstartLevel=0\nendLevel=0\nshowAllChildren=1\nwindow_open=\nshow_whitespace=0\ncache=1\ntag_id=\nclass_sfx=\nmoduleclass_sfx=_menu\nmaxdepth=10\nmenu_images=0\nmenu_images_align=0\nmenu_images_link=0\nexpand_menu=0\nactivate_parent=0\nfull_active_id=0\nindent_image=0\nindent_image1=\nindent_image2=\nindent_image3=\nindent_image4=\nindent_image5=\nindent_image6=\nspacer=\nend_spacer=\n\n', 1, 0, '');
INSERT INTO `jos_modules` VALUES (2, 'Login', '', 1, 'login', 0, '0000-00-00 00:00:00', 1, 'mod_login', 0, 0, 1, '', 1, 1, '');
INSERT INTO `jos_modules` VALUES (3, 'Popular', '', 3, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_popular', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` VALUES (4, 'Recent added Articles', '', 4, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_latest', 0, 2, 1, 'ordering=c_dsc\nuser_id=0\ncache=0\n\n', 0, 1, '');
INSERT INTO `jos_modules` VALUES (5, 'Menu Stats', '', 5, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_stats', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` VALUES (6, 'Unread Messages', '', 1, 'header', 0, '0000-00-00 00:00:00', 1, 'mod_unread', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` VALUES (7, 'Online Users', '', 2, 'header', 0, '0000-00-00 00:00:00', 1, 'mod_online', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` VALUES (8, 'Toolbar', '', 1, 'toolbar', 0, '0000-00-00 00:00:00', 1, 'mod_toolbar', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` VALUES (9, 'Quick Icons', '', 1, 'icon', 0, '0000-00-00 00:00:00', 1, 'mod_quickicon', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` VALUES (10, 'Logged in Users', '', 2, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_logged', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` VALUES (11, 'Footer', '', 0, 'footer', 0, '0000-00-00 00:00:00', 1, 'mod_footer', 0, 0, 1, '', 1, 1, '');
INSERT INTO `jos_modules` VALUES (12, 'Admin Menu', '', 1, 'menu', 0, '0000-00-00 00:00:00', 1, 'mod_menu', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` VALUES (13, 'Admin SubMenu', '', 1, 'submenu', 0, '0000-00-00 00:00:00', 1, 'mod_submenu', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` VALUES (14, 'User Status', '', 1, 'status', 0, '0000-00-00 00:00:00', 1, 'mod_status', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` VALUES (15, 'Title', '', 1, 'title', 0, '0000-00-00 00:00:00', 1, 'mod_title', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` VALUES (16, 'Google Ads', '', 3, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_adsense_joomlaspan_3_ClickSafe', 0, 0, 0, 'moduleclass_sfx=\njoomlaspan_ad_css=text-align:center;\njoomlaspan_ad_client=8770780017522867\njoomlaspan_ad_channel=\njoomlaspan_ad_type=text_image\njoomlaspan_ad_uifeatures=6\njoomlaspan_ad_format=180x90_0ads_al\njoomlaspan_color_border1=D5D5D5\njoomlaspan_color_bg1=FFFFFF\njoomlaspan_color_link1=0033FF\njoomlaspan_color_text1=333333\njoomlaspan_color_url1=008000\njoomlaspan_ip_block1=10.176.87.134\njoomlaspan_ip_block2=\njoomlaspan_ip_block3=\njoomlaspan_ip_block4=\njoomlaspan_ip_block5=\nip_block_alt_code=\njoomlaspan_alternate_ad_url=\njoomlaspan_alternate_color=\njoomlaspan_color_border2=\njoomlaspan_color_border3=\njoomlaspan_color_border4=\njoomlaspan_color_bg2=\njoomlaspan_color_bg3=\njoomlaspan_color_bg4=\njoomlaspan_color_link2=\njoomlaspan_color_link3=\njoomlaspan_color_link4=\njoomlaspan_color_text2=\njoomlaspan_color_text3=\njoomlaspan_color_text4=\njoomlaspan_color_url2=\njoomlaspan_color_url3=\njoomlaspan_color_url4=\n\n', 0, 0, '');
INSERT INTO `jos_modules` VALUES (17, 'Google Search', '', 5, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_googlesearch', 0, 0, 0, 'moduleclass_sfx=\n\n', 0, 0, '');
INSERT INTO `jos_modules` VALUES (18, 'Concept Station', '', 6, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_mainmenu', 0, 0, 1, 'menutype=mainmenu\nmenu_style=list\nstartLevel=0\nendLevel=0\nshowAllChildren=0\nwindow_open=\nshow_whitespace=0\ncache=1\ntag_id=\nclass_sfx=\nmoduleclass_sfx=\nmaxdepth=10\nmenu_images=0\nmenu_images_align=0\nmenu_images_link=0\nexpand_menu=0\nactivate_parent=0\nfull_active_id=0\nindent_image=0\nindent_image1=\nindent_image2=\nindent_image3=\nindent_image4=\nindent_image5=\nindent_image6=\nspacer=\nend_spacer=\n\n', 0, 0, '');
INSERT INTO `jos_modules` VALUES (19, 'Interview Station', '', 0, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_mainmenu', 0, 0, 0, 'menutype=interviewstation\nmenu_style=list_flat\nstartLevel=0\nendLevel=0\nshowAllChildren=1\nwindow_open=\nshow_whitespace=0\ncache=1\ntag_id=\nclass_sfx=\nmoduleclass_sfx=\nmaxdepth=10\nmenu_images=0\nmenu_images_align=0\nmenu_images_link=0\nexpand_menu=0\nactivate_parent=0\nfull_active_id=0\nindent_image=0\nindent_image1=\nindent_image2=\nindent_image3=\nindent_image4=\nindent_image5=\nindent_image6=\nspacer=\nend_spacer=\n\n', 0, 0, '');
INSERT INTO `jos_modules` VALUES (20, 'Acajoom Subscriber Module', '', 7, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_acajoom', 0, 0, 1, '', 0, 0, '');
INSERT INTO `jos_modules` VALUES (21, 'Exam Center', '', 2, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_mainmenu', 0, 0, 1, 'menutype=examcenter', 0, 0, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_modules_menu`
-- 

CREATE TABLE `jos_modules_menu` (
  `moduleid` int(11) NOT NULL default '0',
  `menuid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`moduleid`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_modules_menu`
-- 

INSERT INTO `jos_modules_menu` VALUES (1, 0);
INSERT INTO `jos_modules_menu` VALUES (16, 0);
INSERT INTO `jos_modules_menu` VALUES (17, 0);
INSERT INTO `jos_modules_menu` VALUES (18, 0);
INSERT INTO `jos_modules_menu` VALUES (19, 0);
INSERT INTO `jos_modules_menu` VALUES (21, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_newsfeeds`
-- 

CREATE TABLE `jos_newsfeeds` (
  `catid` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL auto_increment,
  `name` text NOT NULL,
  `alias` varchar(255) NOT NULL default '',
  `link` text NOT NULL,
  `filename` varchar(200) default NULL,
  `published` tinyint(1) NOT NULL default '0',
  `numarticles` int(11) unsigned NOT NULL default '1',
  `cache_time` int(11) unsigned NOT NULL default '3600',
  `checked_out` tinyint(3) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `rtl` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `published` (`published`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_newsfeeds`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_plugins`
-- 

CREATE TABLE `jos_plugins` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '',
  `element` varchar(100) NOT NULL default '',
  `folder` varchar(100) NOT NULL default '',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `published` tinyint(3) NOT NULL default '0',
  `iscore` tinyint(3) NOT NULL default '0',
  `client_id` tinyint(3) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_folder` (`published`,`client_id`,`access`,`folder`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

-- 
-- Dumping data for table `jos_plugins`
-- 

INSERT INTO `jos_plugins` VALUES (1, 'Authentication - Joomla', 'joomla', 'authentication', 0, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (2, 'Authentication - LDAP', 'ldap', 'authentication', 0, 2, 0, 1, 0, 0, '0000-00-00 00:00:00', 'host=\nport=389\nuse_ldapV3=0\nnegotiate_tls=0\nno_referrals=0\nauth_method=bind\nbase_dn=\nsearch_string=\nusers_dn=\nusername=\npassword=\nldap_fullname=fullName\nldap_email=mail\nldap_uid=uid\n\n');
INSERT INTO `jos_plugins` VALUES (3, 'Authentication - GMail', 'gmail', 'authentication', 0, 4, 0, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (4, 'Authentication - OpenID', 'openid', 'authentication', 0, 3, 0, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (5, 'User - Joomla!', 'joomla', 'user', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', 'autoregister=1\n\n');
INSERT INTO `jos_plugins` VALUES (6, 'Search - Content', 'content', 'search', 0, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\nsearch_content=1\nsearch_uncategorised=1\nsearch_archived=1\n\n');
INSERT INTO `jos_plugins` VALUES (7, 'Search - Contacts', 'contacts', 'search', 0, 3, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` VALUES (8, 'Search - Categories', 'categories', 'search', 0, 4, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` VALUES (9, 'Search - Sections', 'sections', 'search', 0, 5, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` VALUES (10, 'Search - Newsfeeds', 'newsfeeds', 'search', 0, 6, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` VALUES (11, 'Search - Weblinks', 'weblinks', 'search', 0, 2, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` VALUES (12, 'Content - Pagebreak', 'pagebreak', 'content', 0, 10000, 1, 1, 0, 0, '0000-00-00 00:00:00', 'enabled=1\ntitle=1\nmultipage_toc=1\nshowall=1\n\n');
INSERT INTO `jos_plugins` VALUES (13, 'Content - Rating', 'vote', 'content', 0, 4, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (14, 'Content - Email Cloaking', 'emailcloak', 'content', 0, 5, 1, 0, 0, 0, '0000-00-00 00:00:00', 'mode=1\n\n');
INSERT INTO `jos_plugins` VALUES (15, 'Content - Code Hightlighter (GeSHi)', 'geshi', 'content', 0, 5, 0, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (16, 'Content - Load Module', 'loadmodule', 'content', 0, 6, 1, 0, 0, 0, '0000-00-00 00:00:00', 'enabled=1\nstyle=0\n\n');
INSERT INTO `jos_plugins` VALUES (17, 'Content - Page Navigation', 'pagenavigation', 'content', 0, 2, 1, 1, 0, 0, '0000-00-00 00:00:00', 'position=1\n\n');
INSERT INTO `jos_plugins` VALUES (18, 'Editor - No Editor', 'none', 'editors', 0, 0, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (19, 'Editor - TinyMCE', 'tinymce', 'editors', 0, 0, 1, 1, 0, 0, '0000-00-00 00:00:00', 'theme=advanced\ncleanup=1\ncleanup_startup=0\nautosave=0\ncompressed=0\nrelative_urls=1\ntext_direction=ltr\nlang_mode=0\nlang_code=en\ninvalid_elements=applet\ncontent_css=1\ncontent_css_custom=\nnewlines=0\ntoolbar=top\nhr=1\nsmilies=1\ntable=1\nstyle=1\nlayer=1\nxhtmlxtras=0\ntemplate=0\ndirectionality=1\nfullscreen=1\nhtml_height=550\nhtml_width=750\npreview=1\ninsertdate=1\nformat_date=%Y-%m-%d\ninserttime=1\nformat_time=%H:%M:%S\n\n');
INSERT INTO `jos_plugins` VALUES (20, 'Editor - XStandard Lite 2.0', 'xstandard', 'editors', 0, 0, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (21, 'Editor Button - Image', 'image', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (22, 'Editor Button - Pagebreak', 'pagebreak', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (23, 'Editor Button - Readmore', 'readmore', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (24, 'XML-RPC - Joomla', 'joomla', 'xmlrpc', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (25, 'XML-RPC - Blogger API', 'blogger', 'xmlrpc', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', 'catid=1\nsectionid=0\n\n');
INSERT INTO `jos_plugins` VALUES (27, 'System - SEF', 'sef', 'system', 0, 1, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (28, 'System - Debug', 'debug', 'system', 0, 2, 1, 0, 0, 0, '0000-00-00 00:00:00', 'queries=1\nmemory=1\nlangauge=1\n\n');
INSERT INTO `jos_plugins` VALUES (29, 'System - Legacy', 'legacy', 'system', 0, 3, 0, 1, 0, 0, '0000-00-00 00:00:00', 'route=0\n\n');
INSERT INTO `jos_plugins` VALUES (30, 'System - Cache', 'cache', 'system', 0, 4, 0, 1, 0, 0, '0000-00-00 00:00:00', 'browsercache=0\ncachetime=15\n\n');
INSERT INTO `jos_plugins` VALUES (31, 'System - Log', 'log', 'system', 0, 5, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (32, 'System - Remember Me', 'remember', 'system', 0, 6, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (33, 'System - Backlink', 'backlink', 'system', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` VALUES (34, 'Acajoom Content Bot', 'acajoombot', 'acajoom', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_poll_data`
-- 

CREATE TABLE `jos_poll_data` (
  `id` int(11) NOT NULL auto_increment,
  `pollid` int(11) NOT NULL default '0',
  `text` text NOT NULL,
  `hits` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pollid` (`pollid`,`text`(1))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_poll_data`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_poll_date`
-- 

CREATE TABLE `jos_poll_date` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `vote_id` int(11) NOT NULL default '0',
  `poll_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `poll_id` (`poll_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_poll_date`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_poll_menu`
-- 

CREATE TABLE `jos_poll_menu` (
  `pollid` int(11) NOT NULL default '0',
  `menuid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`pollid`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_poll_menu`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_polls`
-- 

CREATE TABLE `jos_polls` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `voters` int(9) NOT NULL default '0',
  `checked_out` int(11) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL default '0',
  `access` int(11) NOT NULL default '0',
  `lag` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_polls`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_sections`
-- 

CREATE TABLE `jos_sections` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `image` text NOT NULL,
  `scope` varchar(50) NOT NULL default '',
  `image_position` varchar(30) NOT NULL default '',
  `description` text NOT NULL,
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `count` int(11) NOT NULL default '0',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_scope` (`scope`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table `jos_sections`
-- 

INSERT INTO `jos_sections` VALUES (1, 'Interview Questions', '', 'interview-questions', '', 'content', 'left', '', 1, 0, '0000-00-00 00:00:00', 1, 0, 3, '');
INSERT INTO `jos_sections` VALUES (2, 'Fun', '', 'fun', '', 'content', 'left', '', 1, 0, '0000-00-00 00:00:00', 2, 0, 0, '');
INSERT INTO `jos_sections` VALUES (4, 'Articles', '', 'articles', '', 'content', 'left', '', 1, 0, '0000-00-00 00:00:00', 3, 0, 3, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_session`
-- 

CREATE TABLE `jos_session` (
  `username` varchar(150) default '',
  `time` varchar(14) default '',
  `session_id` varchar(200) NOT NULL default '0',
  `guest` tinyint(4) default '1',
  `userid` int(11) default '0',
  `usertype` varchar(50) default '',
  `gid` tinyint(3) unsigned NOT NULL default '0',
  `client_id` tinyint(3) unsigned NOT NULL default '0',
  `data` longtext,
  PRIMARY KEY  (`session_id`(64)),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_session`
-- 

INSERT INTO `jos_session` VALUES ('', '1264610641', 'd328ac40664c16fcc030320404901f0b', 1, 0, '', 0, 0, '__default|a:7:{s:15:"session.counter";i:1;s:19:"session.timer.start";i:1264610641;s:18:"session.timer.last";i:1264610641;s:17:"session.timer.now";i:1264610641;s:22:"session.client.browser";s:50:"CJNetworkQuality; http://www.cj.com/networkquality";s:8:"registry";O:9:"JRegistry":3:{s:17:"_defaultNameSpace";s:7:"session";s:9:"_registry";a:1:{s:7:"session";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:4:"user";O:5:"JUser":19:{s:2:"id";i:0;s:4:"name";N;s:8:"username";N;s:5:"email";N;s:8:"password";N;s:14:"password_clear";s:0:"";s:8:"usertype";N;s:5:"block";N;s:9:"sendEmail";i:0;s:3:"gid";i:0;s:12:"registerDate";N;s:13:"lastvisitDate";N;s:10:"activation";N;s:6:"params";N;s:3:"aid";i:0;s:5:"guest";i:1;s:7:"_params";O:10:"JParameter":7:{s:4:"_raw";s:0:"";s:4:"_xml";N;s:9:"_elements";a:0:{}s:12:"_elementPath";a:1:{i:0;s:90:"/customers/techstation.in/techstation.in/httpd.www/libraries/joomla/html/parameter/element";}s:17:"_defaultNameSpace";s:8:"_default";s:9:"_registry";a:1:{s:8:"_default";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:9:"_errorMsg";N;s:7:"_errors";a:0:{}}}');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_stats_agents`
-- 

CREATE TABLE `jos_stats_agents` (
  `agent` varchar(255) NOT NULL default '',
  `type` tinyint(1) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_stats_agents`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_templates_menu`
-- 

CREATE TABLE `jos_templates_menu` (
  `template` varchar(255) NOT NULL default '',
  `menuid` int(11) NOT NULL default '0',
  `client_id` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`menuid`,`client_id`,`template`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `jos_templates_menu`
-- 

INSERT INTO `jos_templates_menu` VALUES ('themza_j15_06', 0, 0);
INSERT INTO `jos_templates_menu` VALUES ('khepri', 0, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_users`
-- 

CREATE TABLE `jos_users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `username` varchar(150) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `password` varchar(100) NOT NULL default '',
  `usertype` varchar(25) NOT NULL default '',
  `block` tinyint(4) NOT NULL default '0',
  `sendEmail` tinyint(4) default '0',
  `gid` tinyint(3) unsigned NOT NULL default '1',
  `registerDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL default '',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `gid_block` (`gid`,`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=64 ;

-- 
-- Dumping data for table `jos_users`
-- 

INSERT INTO `jos_users` VALUES (62, 'Administrator', 'admin', 'sundeep.753@gmail.com', 'b04c60ba958c48546762ee7f8423961e:fEwuLZMF39X4wPCzrjNnP8mU4e7q0Dex', 'Super Administrator', 0, 1, 25, '2009-08-11 09:21:33', '2009-12-30 17:45:40', '', 'admin_language=\nlanguage=\neditor=\nhelpsite=\ntimezone=0\n\n');
INSERT INTO `jos_users` VALUES (63, 'Station Master', 'stationmaster', 'sundeep.techie@gmail.com', 'c6f8ff6e38cd325b780f28ed25d066e3:krJYcygPXpYHKpDHY3aS95AHBtpU7ci6', 'Super Administrator', 0, 0, 25, '2009-09-06 09:07:55', '2009-09-25 01:10:39', '', 'admin_language=en-GB\nlanguage=en-GB\neditor=tinymce\nhelpsite=\ntimezone=0\n\n');

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_weblinks`
-- 

CREATE TABLE `jos_weblinks` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `sid` int(11) NOT NULL default '0',
  `title` varchar(250) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `url` varchar(250) NOT NULL default '',
  `description` text NOT NULL,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` int(11) NOT NULL default '0',
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `archived` tinyint(1) NOT NULL default '0',
  `approved` tinyint(1) NOT NULL default '1',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`,`published`,`archived`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_weblinks`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `qna_QuestionSets`
-- 

CREATE TABLE `qna_QuestionSets` (
  `RecID` int(6) NOT NULL auto_increment,
  `SetName` varchar(32) NOT NULL default 'set-name',
  `SetDesc` varchar(64) NOT NULL default 'set-description',
  `Status` char(3) NOT NULL default 'on',
  `DateAdded` varchar(10) NOT NULL default '00-00-0000',
  PRIMARY KEY  (`RecID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- 
-- Dumping data for table `qna_QuestionSets`
-- 

INSERT INTO `qna_QuestionSets` VALUES (10, 'Database', 'Database questions', 'on', '24-09-2009');
INSERT INTO `qna_QuestionSets` VALUES (11, 'SQL', 'All SQL related stuff', 'off', '24-09-2009');

-- --------------------------------------------------------

-- 
-- Table structure for table `qna_Questions`
-- 

CREATE TABLE `qna_Questions` (
  `RecID` int(6) NOT NULL auto_increment,
  `Status` char(3) default 'on',
  `DateAdded` varchar(10) NOT NULL default '00-00-0000',
  `Question` text,
  `Answer` text,
  `AssignedSet` int(11) NOT NULL default '0',
  `QAlias` varchar(32) NOT NULL default 'Alias',
  PRIMARY KEY  (`RecID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

-- 
-- Dumping data for table `qna_Questions`
-- 

INSERT INTO `qna_Questions` VALUES (26, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;"> Explain the difference between a <span style="text-decoration: underline;"><span style="color: #22229c !important; font-size: x-small;"><span class="kLink" style="color: #22229c !important;"><span style="font-size: x-small;">database </span></span><span class="kLink" style="color: #22229c !important;"><span style="font-size: x-small;">administrator</span></span></span></span> and a data administrator.</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">Database Administrator :- A person (or group of people) responsible for the maintenance and performance of a database and responsible for the planning, implementation, configuration, and administration of relational <a class="kLink" href="http://www.go4expert.com/forums/showthread.php?t=322#" target="undefined"><span style="text-decoration: underline;"><span style="color: #22229c !important; font-weight: 400; font-size: x-small;"><span class="kLink" style="color: #22229c !important; font-weight: 400;"><span style="font-size: x-small;">database </span></span><span class="kLink" style="color: #22229c !important; font-weight: 400;"><span style="font-size: x-small;">management </span></span><span class="kLink" style="color: #22229c !important; font-weight: 400;"><span style="font-size: x-small;">systems</span></span></span></span></a>. <br /><br />Data Administrator :- The individual or organization responsible for the specification, acquisition, and maintenance of data management <a class="kLink" href="http://www.go4expert.com/forums/showthread.php?t=322#" target="undefined"><span style="text-decoration: underline;"><span style="color: #22229c !important; font-weight: 400; font-size: x-small;"><span class="kLink" style="color: #22229c !important; font-weight: 400;"><span style="font-size: x-small;">software</span></span></span></span></a> and the design, validation, and <a class="kLink" href="http://www.go4expert.com/forums/showthread.php?t=322#" target="undefined"><span style="text-decoration: underline;"><span style="color: #22229c !important; font-weight: 400; font-size: x-small;"><span class="kLink" style="color: #22229c !important; font-weight: 400;"><span style="font-size: x-small;">security</span></span></span></span></a> of files or databases. The DA is in charge of the data dictionary and data model.</span></p>', 10, 'dba vs data administrator');
INSERT INTO `qna_Questions` VALUES (27, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">Explain the difference between an explicit and an implicit lock.</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">Explicit Lock :- Lock is explicitly requested for a record or table.<br />Implicit Lock :- Lock is implied but is not acquired</span></p>', 10, 'locks');
INSERT INTO `qna_Questions` VALUES (28, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">What is lock granularity?</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">There are many locks available for the database system to have like Intent Shared, Shared, Intent exclusive, exclusive and Shared Intent exclusive. Locking granularity refers to the size and hence the number of locks used to ensure the consistency of a database during multiple concurrent updates.</span></p>', 10, 'locks');
INSERT INTO `qna_Questions` VALUES (29, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">In general, how should the boundaries of a transaction be defined?</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">A transaction ensures that one or more operations execute as an atomic unit of work. If one of the operations within a transaction fails, then all of them are rolled-back so that the application is returned to its prior state. The boundaries that define a group of operations done within a single transaction. </span></p>', 10, 'transaction');
INSERT INTO `qna_Questions` VALUES (30, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;"> Explain the meaning of the expression ACID transaction.</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">ACID means Atomic, Consistency, Isolation, Durability, so when any transaction happen it should be Atomic that is it should either be complete or fully incomplete. There should not be anything like Semi complete. The Database State should remain consistent after the completion of the transaction. If there are more than one Transaction then the transaction should be scheduled in such a fashion that they remain in Isolation of one another.Durability means that Once a transaction commits, its effects will persist even if there are system failures.</span></p>', 10, 'transaction');
INSERT INTO `qna_Questions` VALUES (31, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">Explain the necessity of defining processing rights and responsibilities. How are such responsibilities enforced?</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">One of the reason to define rights is the security in the database system. If any user is allowed to define the data or alter the data then the database would just be of no use and so processing rights and responsibilities are clearly defined in any database system. The resposibilities are enforced using the table space provided by the database system.</span></p>', 10, 'access control');
INSERT INTO `qna_Questions` VALUES (32, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">Describe the advantages and disadvantages of DBMS-provided and application-provided security.</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">DBMS provided security :- Any database system requires you to login and then process the data depending on the rights given by the <a class="kLink" href="http://www.go4expert.com/forums/showthread.php?t=322#" target="undefined"><span style="text-decoration: underline;"><span style="color: #22229c !important; font-weight: 400; font-size: x-small;"><span class="kLink" style="color: #22229c !important; font-weight: 400;"><span style="font-size: x-small;">DBA</span></span></span></span></a> to the user who has logged in. The advatage of such a system is securing the data and providing the user and the DBA the secured platform. Any user who logs in cannot do whatever he want but his role can be defined very easily. There is no major disadvantage about the DBMS provided security apart from overhead of storing the rights and priviledges about the users.<br /><br />Application-provided security :- It is much similar to the DBMS provided security but the only difference is that its the duty of the programmer creating the application to provide all the seurities so that the data is not mishandled.</span></p>', 10, 'basics');
INSERT INTO `qna_Questions` VALUES (33, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">Explain how a database could be recovered via reprocessing. Why is this generally not feasible?</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">If we reprocess the transaction then the database can be made to come to a state where the database is consistent and so reprocessing the log can recover the database. Reprocessing is not very feasible for a very simple reason that its very costly from time point of view and requires lots of rework and many transaction are even rollback giving more and more rework.</span></p>', 10, 'transaction');
INSERT INTO `qna_Questions` VALUES (34, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">Define rollback and roll forward.</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">Rollback :- Undoing the changes made by a transaction before it commits or to cancel any changes to a database made during the current transaction<br />RollForward :- Re-doing the changes made by a transaction after it commits or to overwrite the chnaged calue again to ensure consistency</span></p>', 10, 'transaction');
INSERT INTO `qna_Questions` VALUES (35, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">Why is it important to write to the log before changing the database values?</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">The most important objective to write the log before the database is changed is if there is any need to rollback or rollforward any transaction then if the log are not present then the rollback rollforward cannot be done accurately.</span></p>', 10, 'transaction');
INSERT INTO `qna_Questions` VALUES (36, 'on', '24-09-2009', '<p><span style="color: #cc6600; font-family: Verdana; font-size: 13px; line-height: normal; font-weight: bold;">How do I eliminate the duplicate rows ?</span></p>', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;"> SQL&gt; delete from table_name where rowid not in (select max(rowid) from table group by duplicate_values_field_name); <br />or <br />SQL&gt; delete duplicate_values_field_name dv from table_name ta where rowid &lt;(select min(rowid)  from table_name tb where ta.dv=tb.dv); <br />Example. <br />Table Emp <br />Empno Ename <br />101               Scott <br />102               Jiyo <br />103               Millor <br />104               Jiyo <br />105               Smith <br />delete ename from emp a where rowid &lt; ( select min(rowid) from emp b where a.ename = b.ename); <br />The output like, <br />Empno Ename <br />101               Scott <br />102               Millor <br />103               Jiyo <br />104               Smith</span></p>', 11, 'DML');
INSERT INTO `qna_Questions` VALUES (37, 'on', '24-09-2009', '<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;"><strong><span style="color: #cc6600;">How do I display row number with records?</span></strong> </span></p>', '<p><span style="white-space: pre;"> </span><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">To achive this use rownum pseudocolumn with query, like SQL&gt; SQL&gt; select rownum, ename from emp; </span></p>\r\n<p><span style="color: #000000; font-family: Verdana; font-size: 13px; line-height: normal;">Output: <br />1                    Scott <br />2                    Millor <br />3                    Jiyo <br />4                    Smith</span></p>', 11, 'query');

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_acl_groups`
-- 

CREATE TABLE `ts_acl_groups` (
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_option_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_role_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_setting` tinyint(2) NOT NULL default '0',
  KEY `group_id` (`group_id`),
  KEY `auth_opt_id` (`auth_option_id`),
  KEY `auth_role_id` (`auth_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_acl_groups`
-- 

INSERT INTO `ts_acl_groups` VALUES (1, 0, 85, 0, 1);
INSERT INTO `ts_acl_groups` VALUES (1, 0, 93, 0, 1);
INSERT INTO `ts_acl_groups` VALUES (1, 0, 111, 0, 1);
INSERT INTO `ts_acl_groups` VALUES (5, 0, 0, 5, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 0, 0, 1, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 0, 0, 6, 0);
INSERT INTO `ts_acl_groups` VALUES (3, 0, 0, 6, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 0, 0, 5, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 0, 0, 10, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 15, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 15, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 15, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 14, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 14, 0, 21, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 14, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 14, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 14, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 13, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 13, 0, 21, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 13, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 13, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 13, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 11, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 11, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 11, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 11, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 11, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 12, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 12, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 12, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 12, 0, 21, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 12, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 18, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 18, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 18, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 18, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 18, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 15, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 15, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 16, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 16, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 16, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 16, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 16, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 17, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 17, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 17, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 17, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 17, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 19, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 19, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 19, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 19, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 19, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 20, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 20, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 20, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 20, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 20, 0, 22, 0);
INSERT INTO `ts_acl_groups` VALUES (5, 21, 0, 14, 0);
INSERT INTO `ts_acl_groups` VALUES (6, 21, 0, 19, 0);
INSERT INTO `ts_acl_groups` VALUES (4, 21, 0, 20, 0);
INSERT INTO `ts_acl_groups` VALUES (1, 21, 0, 17, 0);
INSERT INTO `ts_acl_groups` VALUES (2, 21, 0, 22, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_acl_options`
-- 

CREATE TABLE `ts_acl_options` (
  `auth_option_id` mediumint(8) unsigned NOT NULL auto_increment,
  `auth_option` varchar(50) collate utf8_bin NOT NULL default '',
  `is_global` tinyint(1) unsigned NOT NULL default '0',
  `is_local` tinyint(1) unsigned NOT NULL default '0',
  `founder_only` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`auth_option_id`),
  KEY `auth_option` (`auth_option`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=118 ;

-- 
-- Dumping data for table `ts_acl_options`
-- 

INSERT INTO `ts_acl_options` VALUES (1, 0x665f, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (2, 0x665f616e6e6f756e6365, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (3, 0x665f617474616368, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (4, 0x665f6262636f6465, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (5, 0x665f62756d70, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (6, 0x665f64656c657465, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (7, 0x665f646f776e6c6f6164, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (8, 0x665f65646974, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (9, 0x665f656d61696c, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (10, 0x665f666c617368, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (11, 0x665f69636f6e73, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (12, 0x665f69676e6f7265666c6f6f64, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (13, 0x665f696d67, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (14, 0x665f6c697374, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (15, 0x665f6e6f617070726f7665, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (16, 0x665f706f6c6c, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (17, 0x665f706f7374, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (18, 0x665f706f7374636f756e74, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (19, 0x665f7072696e74, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (20, 0x665f72656164, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (21, 0x665f7265706c79, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (22, 0x665f7265706f7274, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (23, 0x665f736561726368, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (24, 0x665f73696773, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (25, 0x665f736d696c696573, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (26, 0x665f737469636b79, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (27, 0x665f737562736372696265, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (28, 0x665f757365725f6c6f636b, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (29, 0x665f766f7465, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (30, 0x665f766f7465636867, 0, 1, 0);
INSERT INTO `ts_acl_options` VALUES (31, 0x6d5f, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (32, 0x6d5f617070726f7665, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (33, 0x6d5f636867706f73746572, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (34, 0x6d5f64656c657465, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (35, 0x6d5f65646974, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (36, 0x6d5f696e666f, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (37, 0x6d5f6c6f636b, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (38, 0x6d5f6d65726765, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (39, 0x6d5f6d6f7665, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (40, 0x6d5f7265706f7274, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (41, 0x6d5f73706c6974, 1, 1, 0);
INSERT INTO `ts_acl_options` VALUES (42, 0x6d5f62616e, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (43, 0x6d5f7761726e, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (44, 0x615f, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (45, 0x615f6161757468, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (46, 0x615f617474616368, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (47, 0x615f6175746867726f757073, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (48, 0x615f617574687573657273, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (49, 0x615f6261636b7570, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (50, 0x615f62616e, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (51, 0x615f6262636f6465, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (52, 0x615f626f617264, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (53, 0x615f626f7473, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (54, 0x615f636c6561726c6f6773, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (55, 0x615f656d61696c, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (56, 0x615f6661757468, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (57, 0x615f666f72756d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (58, 0x615f666f72756d616464, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (59, 0x615f666f72756d64656c, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (60, 0x615f67726f7570, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (61, 0x615f67726f7570616464, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (62, 0x615f67726f757064656c, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (63, 0x615f69636f6e73, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (64, 0x615f6a6162626572, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (65, 0x615f6c616e6775616765, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (66, 0x615f6d61757468, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (67, 0x615f6d6f64756c6573, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (68, 0x615f6e616d6573, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (69, 0x615f706870696e666f, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (70, 0x615f70726f66696c65, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (71, 0x615f7072756e65, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (72, 0x615f72616e6b73, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (73, 0x615f726561736f6e73, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (74, 0x615f726f6c6573, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (75, 0x615f736561726368, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (76, 0x615f736572766572, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (77, 0x615f7374796c6573, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (78, 0x615f7377697463687065726d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (79, 0x615f7561757468, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (80, 0x615f75736572, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (81, 0x615f7573657264656c, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (82, 0x615f7669657761757468, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (83, 0x615f766965776c6f6773, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (84, 0x615f776f726473, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (85, 0x755f, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (86, 0x755f617474616368, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (87, 0x755f636867617661746172, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (88, 0x755f63686763656e736f7273, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (89, 0x755f636867656d61696c, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (90, 0x755f636867677270, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (91, 0x755f6368676e616d65, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (92, 0x755f636867706173737764, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (93, 0x755f646f776e6c6f6164, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (94, 0x755f686964656f6e6c696e65, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (95, 0x755f69676e6f7265666c6f6f64, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (96, 0x755f6d617373706d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (97, 0x755f6d617373706d5f67726f7570, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (98, 0x755f706d5f617474616368, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (99, 0x755f706d5f6262636f6465, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (100, 0x755f706d5f64656c657465, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (101, 0x755f706d5f646f776e6c6f6164, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (102, 0x755f706d5f65646974, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (103, 0x755f706d5f656d61696c706d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (104, 0x755f706d5f666c617368, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (105, 0x755f706d5f666f7277617264, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (106, 0x755f706d5f696d67, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (107, 0x755f706d5f7072696e74706d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (108, 0x755f706d5f736d696c696573, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (109, 0x755f72656164706d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (110, 0x755f73617665647261667473, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (111, 0x755f736561726368, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (112, 0x755f73656e64656d61696c, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (113, 0x755f73656e64696d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (114, 0x755f73656e64706d, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (115, 0x755f736967, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (116, 0x755f766965776f6e6c696e65, 1, 0, 0);
INSERT INTO `ts_acl_options` VALUES (117, 0x755f7669657770726f66696c65, 1, 0, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_acl_roles`
-- 

CREATE TABLE `ts_acl_roles` (
  `role_id` mediumint(8) unsigned NOT NULL auto_increment,
  `role_name` varchar(255) collate utf8_bin NOT NULL default '',
  `role_description` text collate utf8_bin NOT NULL,
  `role_type` varchar(10) collate utf8_bin NOT NULL default '',
  `role_order` smallint(4) unsigned NOT NULL default '0',
  PRIMARY KEY  (`role_id`),
  KEY `role_type` (`role_type`),
  KEY `role_order` (`role_order`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=23 ;

-- 
-- Dumping data for table `ts_acl_roles`
-- 

INSERT INTO `ts_acl_roles` VALUES (1, 0x524f4c455f41444d494e5f5354414e44415244, 0x524f4c455f4445534352495054494f4e5f41444d494e5f5354414e44415244, 0x615f, 1);
INSERT INTO `ts_acl_roles` VALUES (2, 0x524f4c455f41444d494e5f464f52554d, 0x524f4c455f4445534352495054494f4e5f41444d494e5f464f52554d, 0x615f, 3);
INSERT INTO `ts_acl_roles` VALUES (3, 0x524f4c455f41444d494e5f5553455247524f5550, 0x524f4c455f4445534352495054494f4e5f41444d494e5f5553455247524f5550, 0x615f, 4);
INSERT INTO `ts_acl_roles` VALUES (4, 0x524f4c455f41444d494e5f46554c4c, 0x524f4c455f4445534352495054494f4e5f41444d494e5f46554c4c, 0x615f, 2);
INSERT INTO `ts_acl_roles` VALUES (5, 0x524f4c455f555345525f46554c4c, 0x524f4c455f4445534352495054494f4e5f555345525f46554c4c, 0x755f, 3);
INSERT INTO `ts_acl_roles` VALUES (6, 0x524f4c455f555345525f5354414e44415244, 0x524f4c455f4445534352495054494f4e5f555345525f5354414e44415244, 0x755f, 1);
INSERT INTO `ts_acl_roles` VALUES (7, 0x524f4c455f555345525f4c494d49544544, 0x524f4c455f4445534352495054494f4e5f555345525f4c494d49544544, 0x755f, 2);
INSERT INTO `ts_acl_roles` VALUES (8, 0x524f4c455f555345525f4e4f504d, 0x524f4c455f4445534352495054494f4e5f555345525f4e4f504d, 0x755f, 4);
INSERT INTO `ts_acl_roles` VALUES (9, 0x524f4c455f555345525f4e4f415641544152, 0x524f4c455f4445534352495054494f4e5f555345525f4e4f415641544152, 0x755f, 5);
INSERT INTO `ts_acl_roles` VALUES (10, 0x524f4c455f4d4f445f46554c4c, 0x524f4c455f4445534352495054494f4e5f4d4f445f46554c4c, 0x6d5f, 3);
INSERT INTO `ts_acl_roles` VALUES (11, 0x524f4c455f4d4f445f5354414e44415244, 0x524f4c455f4445534352495054494f4e5f4d4f445f5354414e44415244, 0x6d5f, 1);
INSERT INTO `ts_acl_roles` VALUES (12, 0x524f4c455f4d4f445f53494d504c45, 0x524f4c455f4445534352495054494f4e5f4d4f445f53494d504c45, 0x6d5f, 2);
INSERT INTO `ts_acl_roles` VALUES (13, 0x524f4c455f4d4f445f5155455545, 0x524f4c455f4445534352495054494f4e5f4d4f445f5155455545, 0x6d5f, 4);
INSERT INTO `ts_acl_roles` VALUES (14, 0x524f4c455f464f52554d5f46554c4c, 0x524f4c455f4445534352495054494f4e5f464f52554d5f46554c4c, 0x665f, 7);
INSERT INTO `ts_acl_roles` VALUES (15, 0x524f4c455f464f52554d5f5354414e44415244, 0x524f4c455f4445534352495054494f4e5f464f52554d5f5354414e44415244, 0x665f, 5);
INSERT INTO `ts_acl_roles` VALUES (16, 0x524f4c455f464f52554d5f4e4f414343455353, 0x524f4c455f4445534352495054494f4e5f464f52554d5f4e4f414343455353, 0x665f, 1);
INSERT INTO `ts_acl_roles` VALUES (17, 0x524f4c455f464f52554d5f524541444f4e4c59, 0x524f4c455f4445534352495054494f4e5f464f52554d5f524541444f4e4c59, 0x665f, 2);
INSERT INTO `ts_acl_roles` VALUES (18, 0x524f4c455f464f52554d5f4c494d49544544, 0x524f4c455f4445534352495054494f4e5f464f52554d5f4c494d49544544, 0x665f, 3);
INSERT INTO `ts_acl_roles` VALUES (19, 0x524f4c455f464f52554d5f424f54, 0x524f4c455f4445534352495054494f4e5f464f52554d5f424f54, 0x665f, 9);
INSERT INTO `ts_acl_roles` VALUES (20, 0x524f4c455f464f52554d5f4f4e5155455545, 0x524f4c455f4445534352495054494f4e5f464f52554d5f4f4e5155455545, 0x665f, 8);
INSERT INTO `ts_acl_roles` VALUES (21, 0x524f4c455f464f52554d5f504f4c4c53, 0x524f4c455f4445534352495054494f4e5f464f52554d5f504f4c4c53, 0x665f, 6);
INSERT INTO `ts_acl_roles` VALUES (22, 0x524f4c455f464f52554d5f4c494d495445445f504f4c4c53, 0x524f4c455f4445534352495054494f4e5f464f52554d5f4c494d495445445f504f4c4c53, 0x665f, 4);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_acl_roles_data`
-- 

CREATE TABLE `ts_acl_roles_data` (
  `role_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_option_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_setting` tinyint(2) NOT NULL default '0',
  PRIMARY KEY  (`role_id`,`auth_option_id`),
  KEY `ath_op_id` (`auth_option_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_acl_roles_data`
-- 

INSERT INTO `ts_acl_roles_data` VALUES (1, 44, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 46, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 47, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 48, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 50, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 51, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 52, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 56, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 57, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 58, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 59, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 60, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 61, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 62, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 63, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 66, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 68, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 70, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 71, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 72, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 73, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 79, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 80, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 81, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 82, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 83, 1);
INSERT INTO `ts_acl_roles_data` VALUES (1, 84, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 44, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 47, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 48, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 56, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 57, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 58, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 59, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 66, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 71, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 79, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 82, 1);
INSERT INTO `ts_acl_roles_data` VALUES (2, 83, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 44, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 47, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 48, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 50, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 60, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 61, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 62, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 72, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 79, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 80, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 82, 1);
INSERT INTO `ts_acl_roles_data` VALUES (3, 83, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 44, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 45, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 46, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 47, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 48, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 49, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 50, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 51, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 52, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 53, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 54, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 55, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 56, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 57, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 58, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 59, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 60, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 61, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 62, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 63, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 64, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 65, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 66, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 67, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 68, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 69, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 70, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 71, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 72, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 73, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 74, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 75, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 76, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 77, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 78, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 79, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 80, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 81, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 82, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 83, 1);
INSERT INTO `ts_acl_roles_data` VALUES (4, 84, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 85, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 86, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 87, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 88, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 89, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 90, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 91, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 92, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 93, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 94, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 95, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 96, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 97, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 98, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 99, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 100, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 101, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 102, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 103, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 104, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 105, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 106, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 107, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 108, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 109, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 110, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 111, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 112, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 113, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 114, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 115, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 116, 1);
INSERT INTO `ts_acl_roles_data` VALUES (5, 117, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 85, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 86, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 87, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 88, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 89, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 92, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 93, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 94, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 96, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 97, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 98, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 99, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 100, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 101, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 102, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 103, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 106, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 107, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 108, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 109, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 110, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 111, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 112, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 113, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 114, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 115, 1);
INSERT INTO `ts_acl_roles_data` VALUES (6, 117, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 85, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 87, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 88, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 89, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 92, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 93, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 94, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 99, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 100, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 101, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 102, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 105, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 106, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 107, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 108, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 109, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 114, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 115, 1);
INSERT INTO `ts_acl_roles_data` VALUES (7, 117, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 85, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 87, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 88, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 89, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 92, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 93, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 94, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 115, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 117, 1);
INSERT INTO `ts_acl_roles_data` VALUES (8, 96, 0);
INSERT INTO `ts_acl_roles_data` VALUES (8, 97, 0);
INSERT INTO `ts_acl_roles_data` VALUES (8, 109, 0);
INSERT INTO `ts_acl_roles_data` VALUES (8, 114, 0);
INSERT INTO `ts_acl_roles_data` VALUES (9, 85, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 88, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 89, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 92, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 93, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 94, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 99, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 100, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 101, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 102, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 105, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 106, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 107, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 108, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 109, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 114, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 115, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 117, 1);
INSERT INTO `ts_acl_roles_data` VALUES (9, 87, 0);
INSERT INTO `ts_acl_roles_data` VALUES (9, 96, 0);
INSERT INTO `ts_acl_roles_data` VALUES (9, 97, 0);
INSERT INTO `ts_acl_roles_data` VALUES (10, 31, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 32, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 42, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 33, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 34, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 35, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 36, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 37, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 38, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 39, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 40, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 41, 1);
INSERT INTO `ts_acl_roles_data` VALUES (10, 43, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 31, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 32, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 34, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 35, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 36, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 37, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 38, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 39, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 40, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 41, 1);
INSERT INTO `ts_acl_roles_data` VALUES (11, 43, 1);
INSERT INTO `ts_acl_roles_data` VALUES (12, 31, 1);
INSERT INTO `ts_acl_roles_data` VALUES (12, 34, 1);
INSERT INTO `ts_acl_roles_data` VALUES (12, 35, 1);
INSERT INTO `ts_acl_roles_data` VALUES (12, 36, 1);
INSERT INTO `ts_acl_roles_data` VALUES (12, 40, 1);
INSERT INTO `ts_acl_roles_data` VALUES (13, 31, 1);
INSERT INTO `ts_acl_roles_data` VALUES (13, 32, 1);
INSERT INTO `ts_acl_roles_data` VALUES (13, 35, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 2, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 3, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 4, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 5, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 6, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 8, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 9, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 10, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 11, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 12, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 13, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 15, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 16, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 17, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 18, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 21, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 22, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 23, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 24, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 25, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 26, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 27, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 28, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 29, 1);
INSERT INTO `ts_acl_roles_data` VALUES (14, 30, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 3, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 4, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 5, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 6, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 8, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 9, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 11, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 13, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 15, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 17, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 18, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 21, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 22, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 23, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 24, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 25, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 27, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 29, 1);
INSERT INTO `ts_acl_roles_data` VALUES (15, 30, 1);
INSERT INTO `ts_acl_roles_data` VALUES (16, 1, 0);
INSERT INTO `ts_acl_roles_data` VALUES (17, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (17, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (17, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (17, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (17, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (17, 23, 1);
INSERT INTO `ts_acl_roles_data` VALUES (17, 27, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 4, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 8, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 9, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 13, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 15, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 17, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 18, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 21, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 22, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 23, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 24, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 25, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 27, 1);
INSERT INTO `ts_acl_roles_data` VALUES (18, 29, 1);
INSERT INTO `ts_acl_roles_data` VALUES (19, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (19, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (19, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (19, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (19, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 3, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 4, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 8, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 9, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 13, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 17, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 18, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 21, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 22, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 23, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 24, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 25, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 27, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 29, 1);
INSERT INTO `ts_acl_roles_data` VALUES (20, 15, 0);
INSERT INTO `ts_acl_roles_data` VALUES (21, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 3, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 4, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 5, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 6, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 8, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 9, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 11, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 13, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 15, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 16, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 17, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 18, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 21, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 22, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 23, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 24, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 25, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 27, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 29, 1);
INSERT INTO `ts_acl_roles_data` VALUES (21, 30, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 1, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 4, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 7, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 8, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 9, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 13, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 14, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 15, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 16, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 17, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 18, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 19, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 20, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 21, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 22, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 23, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 24, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 25, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 27, 1);
INSERT INTO `ts_acl_roles_data` VALUES (22, 29, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_acl_users`
-- 

CREATE TABLE `ts_acl_users` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_option_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_role_id` mediumint(8) unsigned NOT NULL default '0',
  `auth_setting` tinyint(2) NOT NULL default '0',
  KEY `user_id` (`user_id`),
  KEY `auth_option_id` (`auth_option_id`),
  KEY `auth_role_id` (`auth_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_acl_users`
-- 

INSERT INTO `ts_acl_users` VALUES (2, 0, 0, 5, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_attachments`
-- 

CREATE TABLE `ts_attachments` (
  `attach_id` mediumint(8) unsigned NOT NULL auto_increment,
  `post_msg_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `in_message` tinyint(1) unsigned NOT NULL default '0',
  `poster_id` mediumint(8) unsigned NOT NULL default '0',
  `is_orphan` tinyint(1) unsigned NOT NULL default '1',
  `physical_filename` varchar(255) collate utf8_bin NOT NULL default '',
  `real_filename` varchar(255) collate utf8_bin NOT NULL default '',
  `download_count` mediumint(8) unsigned NOT NULL default '0',
  `attach_comment` text collate utf8_bin NOT NULL,
  `extension` varchar(100) collate utf8_bin NOT NULL default '',
  `mimetype` varchar(100) collate utf8_bin NOT NULL default '',
  `filesize` int(20) unsigned NOT NULL default '0',
  `filetime` int(11) unsigned NOT NULL default '0',
  `thumbnail` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`attach_id`),
  KEY `filetime` (`filetime`),
  KEY `post_msg_id` (`post_msg_id`),
  KEY `topic_id` (`topic_id`),
  KEY `poster_id` (`poster_id`),
  KEY `is_orphan` (`is_orphan`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_attachments`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_banlist`
-- 

CREATE TABLE `ts_banlist` (
  `ban_id` mediumint(8) unsigned NOT NULL auto_increment,
  `ban_userid` mediumint(8) unsigned NOT NULL default '0',
  `ban_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `ban_email` varchar(100) collate utf8_bin NOT NULL default '',
  `ban_start` int(11) unsigned NOT NULL default '0',
  `ban_end` int(11) unsigned NOT NULL default '0',
  `ban_exclude` tinyint(1) unsigned NOT NULL default '0',
  `ban_reason` varchar(255) collate utf8_bin NOT NULL default '',
  `ban_give_reason` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`ban_id`),
  KEY `ban_end` (`ban_end`),
  KEY `ban_user` (`ban_userid`,`ban_exclude`),
  KEY `ban_email` (`ban_email`,`ban_exclude`),
  KEY `ban_ip` (`ban_ip`,`ban_exclude`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_banlist`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_bbcodes`
-- 

CREATE TABLE `ts_bbcodes` (
  `bbcode_id` tinyint(3) NOT NULL default '0',
  `bbcode_tag` varchar(16) collate utf8_bin NOT NULL default '',
  `bbcode_helpline` varchar(255) collate utf8_bin NOT NULL default '',
  `display_on_posting` tinyint(1) unsigned NOT NULL default '0',
  `bbcode_match` text collate utf8_bin NOT NULL,
  `bbcode_tpl` mediumtext collate utf8_bin NOT NULL,
  `first_pass_match` mediumtext collate utf8_bin NOT NULL,
  `first_pass_replace` mediumtext collate utf8_bin NOT NULL,
  `second_pass_match` mediumtext collate utf8_bin NOT NULL,
  `second_pass_replace` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`bbcode_id`),
  KEY `display_on_post` (`display_on_posting`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_bbcodes`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_bookmarks`
-- 

CREATE TABLE `ts_bookmarks` (
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`topic_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_bookmarks`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_bots`
-- 

CREATE TABLE `ts_bots` (
  `bot_id` mediumint(8) unsigned NOT NULL auto_increment,
  `bot_active` tinyint(1) unsigned NOT NULL default '1',
  `bot_name` varchar(255) collate utf8_bin NOT NULL default '',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `bot_agent` varchar(255) collate utf8_bin NOT NULL default '',
  `bot_ip` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`bot_id`),
  KEY `bot_active` (`bot_active`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=51 ;

-- 
-- Dumping data for table `ts_bots`
-- 

INSERT INTO `ts_bots` VALUES (1, 1, 0x416473426f74205b476f6f676c655d, 3, 0x416473426f742d476f6f676c65, '');
INSERT INTO `ts_bots` VALUES (2, 1, 0x416c657861205b426f745d, 4, 0x69615f6172636869766572, '');
INSERT INTO `ts_bots` VALUES (3, 1, 0x416c7461205669737461205b426f745d, 5, 0x53636f6f7465722f, '');
INSERT INTO `ts_bots` VALUES (4, 1, 0x41736b204a6565766573205b426f745d, 6, 0x41736b204a6565766573, '');
INSERT INTO `ts_bots` VALUES (5, 1, 0x4261696475205b5370696465725d, 7, 0x42616964757370696465722b28, '');
INSERT INTO `ts_bots` VALUES (6, 1, 0x457861626f74205b426f745d, 8, 0x457861626f742f, '');
INSERT INTO `ts_bots` VALUES (7, 1, 0x4641535420456e7465727072697365205b437261776c65725d, 9, 0x4641535420456e746572707269736520437261776c6572, '');
INSERT INTO `ts_bots` VALUES (8, 1, 0x4641535420576562437261776c6572205b437261776c65725d, 10, 0x464153542d576562437261776c65722f, '');
INSERT INTO `ts_bots` VALUES (9, 1, 0x4672616e636973205b426f745d, 11, 0x687474703a2f2f7777772e6e656f6d6f2e64652f, '');
INSERT INTO `ts_bots` VALUES (10, 1, 0x47696761626f74205b426f745d, 12, 0x47696761626f742f, '');
INSERT INTO `ts_bots` VALUES (11, 1, 0x476f6f676c6520416473656e7365205b426f745d, 13, 0x4d65646961706172746e6572732d476f6f676c65, '');
INSERT INTO `ts_bots` VALUES (12, 1, 0x476f6f676c65204465736b746f70, 14, 0x476f6f676c65204465736b746f70, '');
INSERT INTO `ts_bots` VALUES (13, 1, 0x476f6f676c65204665656466657463686572, 15, 0x46656564666574636865722d476f6f676c65, '');
INSERT INTO `ts_bots` VALUES (14, 1, 0x476f6f676c65205b426f745d, 16, 0x476f6f676c65626f74, '');
INSERT INTO `ts_bots` VALUES (15, 1, 0x48656973652049542d4d61726b74205b437261776c65725d, 17, 0x68656973652d49542d4d61726b742d437261776c6572, '');
INSERT INTO `ts_bots` VALUES (16, 1, 0x4865726974726978205b437261776c65725d, 18, 0x68657269747269782f312e, '');
INSERT INTO `ts_bots` VALUES (17, 1, 0x49424d205265736561726368205b426f745d, 19, 0x69626d2e636f6d2f63732f637261776c6572, '');
INSERT INTO `ts_bots` VALUES (18, 1, 0x4943437261776c6572202d2049436a6f6273, 20, 0x4943437261776c6572202d2049436a6f6273, '');
INSERT INTO `ts_bots` VALUES (19, 1, 0x69636869726f205b437261776c65725d, 21, 0x69636869726f2f32, '');
INSERT INTO `ts_bots` VALUES (20, 1, 0x4d616a65737469632d3132205b426f745d, 22, 0x4d4a3132626f742f, '');
INSERT INTO `ts_bots` VALUES (21, 1, 0x4d657461676572205b426f745d, 23, 0x4d657461676572426f742f, '');
INSERT INTO `ts_bots` VALUES (22, 1, 0x4d534e204e657773426c6f6773, 24, 0x6d736e626f742d4e657773426c6f67732f, '');
INSERT INTO `ts_bots` VALUES (23, 1, 0x4d534e205b426f745d, 25, 0x6d736e626f742f, '');
INSERT INTO `ts_bots` VALUES (24, 1, 0x4d534e626f74204d65646961, 26, 0x6d736e626f742d6d656469612f, '');
INSERT INTO `ts_bots` VALUES (25, 1, 0x4e472d536561726368205b426f745d, 27, 0x4e472d5365617263682f, '');
INSERT INTO `ts_bots` VALUES (26, 1, 0x4e75746368205b426f745d, 28, 0x687474703a2f2f6c7563656e652e6170616368652e6f72672f6e757463682f, '');
INSERT INTO `ts_bots` VALUES (27, 1, 0x4e757463682f435653205b426f745d, 29, 0x4e757463684356532f, '');
INSERT INTO `ts_bots` VALUES (28, 1, 0x4f6d6e694578706c6f726572205b426f745d, 30, 0x4f6d6e694578706c6f7265725f426f742f, '');
INSERT INTO `ts_bots` VALUES (29, 1, 0x4f6e6c696e65206c696e6b205b56616c696461746f725d, 31, 0x6f6e6c696e65206c696e6b2076616c696461746f72, '');
INSERT INTO `ts_bots` VALUES (30, 1, 0x7073626f74205b5069637365617263685d, 32, 0x7073626f742f30, '');
INSERT INTO `ts_bots` VALUES (31, 1, 0x5365656b706f7274205b426f745d, 33, 0x5365656b626f742f, '');
INSERT INTO `ts_bots` VALUES (32, 1, 0x53656e736973205b437261776c65725d, 34, 0x53656e7369732057656220437261776c6572, '');
INSERT INTO `ts_bots` VALUES (33, 1, 0x53454f20437261776c6572, 35, 0x53454f2073656172636820437261776c65722f, '');
INSERT INTO `ts_bots` VALUES (34, 1, 0x53656f6d61205b437261776c65725d, 36, 0x53656f6d61205b53454f20437261776c65725d, '');
INSERT INTO `ts_bots` VALUES (35, 1, 0x53454f536561726368205b437261776c65725d, 37, 0x53454f7365617263682f, '');
INSERT INTO `ts_bots` VALUES (36, 1, 0x536e61707079205b426f745d, 38, 0x536e617070792f312e31202820687474703a2f2f7777772e75726c7472656e64732e636f6d2f2029, '');
INSERT INTO `ts_bots` VALUES (37, 1, 0x537465656c6572205b437261776c65725d, 39, 0x687474703a2f2f7777772e746b6c2e6969732e752d746f6b796f2e61632e6a702f7e637261776c65722f, '');
INSERT INTO `ts_bots` VALUES (38, 1, 0x53796e6f6f205b426f745d, 40, 0x53796e6f6f426f742f, '');
INSERT INTO `ts_bots` VALUES (39, 1, 0x54656c656b6f6d205b426f745d, 41, 0x637261776c657261646d696e2e742d696e666f4074656c656b6f6d2e6465, '');
INSERT INTO `ts_bots` VALUES (40, 1, 0x5475726e6974696e426f74205b426f745d, 42, 0x5475726e6974696e426f742f, '');
INSERT INTO `ts_bots` VALUES (41, 1, 0x566f7961676572205b426f745d, 43, 0x766f79616765722f312e30, '');
INSERT INTO `ts_bots` VALUES (42, 1, 0x5733205b536974657365617263685d, 44, 0x5733205369746553656172636820437261776c6572, '');
INSERT INTO `ts_bots` VALUES (43, 1, 0x573343205b4c696e6b636865636b5d, 45, 0x5733432d636865636b6c696e6b2f, '');
INSERT INTO `ts_bots` VALUES (44, 1, 0x573343205b56616c696461746f725d, 46, 0x5733435f2a56616c696461746f72, '');
INSERT INTO `ts_bots` VALUES (45, 1, 0x576973654e7574205b426f745d, 47, 0x687474703a2f2f7777772e574953456e7574626f742e636f6d, '');
INSERT INTO `ts_bots` VALUES (46, 1, 0x59614379205b426f745d, 48, 0x79616379626f74, '');
INSERT INTO `ts_bots` VALUES (47, 1, 0x5961686f6f204d4d437261776c6572205b426f745d, 49, 0x5961686f6f2d4d4d437261776c65722f, '');
INSERT INTO `ts_bots` VALUES (48, 1, 0x5961686f6f20536c757270205b426f745d, 50, 0x5961686f6f2120444520536c757270, '');
INSERT INTO `ts_bots` VALUES (49, 1, 0x5961686f6f205b426f745d, 51, 0x5961686f6f2120536c757270, '');
INSERT INTO `ts_bots` VALUES (50, 1, 0x5961686f6f5365656b6572205b426f745d, 52, 0x5961686f6f5365656b65722f, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_config`
-- 

CREATE TABLE `ts_config` (
  `config_name` varchar(255) collate utf8_bin NOT NULL default '',
  `config_value` varchar(255) collate utf8_bin NOT NULL default '',
  `is_dynamic` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`config_name`),
  KEY `is_dynamic` (`is_dynamic`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_config`
-- 

INSERT INTO `ts_config` VALUES (0x6163746976655f73657373696f6e73, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6174746163686d656e7473, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6175746f6c6f67696e, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6176617461725f6c6f63616c, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6176617461725f72656d6f7465, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6176617461725f75706c6f6164, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6262636f6465, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f626972746864617973, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f626f6f6b6d61726b73, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f656d61696c7265757365, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f666f72756d5f6e6f74696679, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6d6173735f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6e616d655f6368617273, 0x555345524e414d455f43484152535f414e59, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6e616d656368616e6765, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f6e6f63656e736f7273, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f706d5f617474616368, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f706f73745f666c617368, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f706f73745f6c696e6b73, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f707269766d7367, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f736967, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f7369675f6262636f6465, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f7369675f666c617368, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f7369675f696d67, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f7369675f6c696e6b73, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f7369675f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f7369675f736d696c696573, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f736d696c696573, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x616c6c6f775f746f7069635f6e6f74696679, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6174746163686d656e745f71756f7461, 0x3532343238383030, 0);
INSERT INTO `ts_config` VALUES (0x617574685f6262636f64655f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x617574685f666c6173685f706d, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x617574685f696d675f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x617574685f6d6574686f64, 0x6462, 0);
INSERT INTO `ts_config` VALUES (0x617574685f736d696c6965735f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f66696c6573697a65, 0x36313434, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f67616c6c6572795f70617468, 0x696d616765732f617661746172732f67616c6c657279, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f6d61785f686569676874, 0x3930, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f6d61785f7769647468, 0x3930, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f6d696e5f686569676874, 0x3230, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f6d696e5f7769647468, 0x3230, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f70617468, 0x696d616765732f617661746172732f75706c6f6164, 0);
INSERT INTO `ts_config` VALUES (0x6176617461725f73616c74, 0x3236356364323532346435633663303735323831353533323338616633646537, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f636f6e74616374, 0x6465616e407465636873746174696f6e2e696e, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f64697361626c65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f64697361626c655f6d7367, '', 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f647374, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f656d61696c, 0x6465616e407465636873746174696f6e2e696e, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f656d61696c5f666f726d, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f656d61696c5f736967, 0x5468616e6b732c20546865204d616e6167656d656e74, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f686964655f656d61696c73, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x626f6172645f74696d657a6f6e65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x62726f777365725f636865636b, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x62756d705f696e74657276616c, 0x3130, 0);
INSERT INTO `ts_config` VALUES (0x62756d705f74797065, 0x64, 0);
INSERT INTO `ts_config` VALUES (0x63616368655f6763, 0x37323030, 0);
INSERT INTO `ts_config` VALUES (0x636170746368615f6764, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x636170746368615f67645f666f726567726f756e645f6e6f697365, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x636170746368615f67645f785f67726964, 0x3235, 0);
INSERT INTO `ts_config` VALUES (0x636170746368615f67645f795f67726964, 0x3235, 0);
INSERT INTO `ts_config` VALUES (0x636865636b5f6174746163686d656e745f636f6e74656e74, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x636865636b5f646e73626c, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6368675f70617373666f726365, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x636f6f6b69655f646f6d61696e, 0x2e7465636873746174696f6e2e696e, 0);
INSERT INTO `ts_config` VALUES (0x636f6f6b69655f6e616d65, 0x7068706262335f3538663736, 0);
INSERT INTO `ts_config` VALUES (0x636f6f6b69655f70617468, 0x2f, 0);
INSERT INTO `ts_config` VALUES (0x636f6f6b69655f736563757265, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x636f7070615f656e61626c65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x636f7070615f666178, '', 0);
INSERT INTO `ts_config` VALUES (0x636f7070615f6d61696c, '', 0);
INSERT INTO `ts_config` VALUES (0x64617461626173655f6763, 0x363034383030, 0);
INSERT INTO `ts_config` VALUES (0x64626d735f76657273696f6e, 0x352e302e33322d44656269616e5f3765746368382d6c6f67, 0);
INSERT INTO `ts_config` VALUES (0x64656661756c745f64617465666f726d6174, 0x44204d20642c205920673a692061, 0);
INSERT INTO `ts_config` VALUES (0x64656661756c745f7374796c65, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x646973706c61795f6c6173745f656469746564, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x646973706c61795f6f72646572, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x656469745f74696d65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x656d61696c5f636865636b5f6d78, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x656d61696c5f656e61626c65, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x656d61696c5f66756e6374696f6e5f6e616d65, 0x6d61696c, 0);
INSERT INTO `ts_config` VALUES (0x656d61696c5f7061636b6167655f73697a65, 0x3530, 0);
INSERT INTO `ts_config` VALUES (0x656e61626c655f636f6e6669726d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x656e61626c655f706d5f69636f6e73, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x656e61626c655f706f73745f636f6e6669726d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x656e61626c655f71756575655f74726967676572, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x666c6f6f645f696e74657276616c, 0x3135, 0);
INSERT INTO `ts_config` VALUES (0x666f7263655f7365727665725f76617273, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x666f726d5f746f6b656e5f6c69666574696d65, 0x37323030, 0);
INSERT INTO `ts_config` VALUES (0x666f726d5f746f6b656e5f6d696e74696d65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x666f726d5f746f6b656e5f7369645f677565737473, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x666f72776172645f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x666f727761726465645f666f725f636865636b, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x66756c6c5f666f6c6465725f616374696f6e, 0x32, 0);
INSERT INTO `ts_config` VALUES (0x66756c6c746578745f6d7973716c5f6d61785f776f72645f6c656e, 0x323534, 0);
INSERT INTO `ts_config` VALUES (0x66756c6c746578745f6d7973716c5f6d696e5f776f72645f6c656e, 0x34, 0);
INSERT INTO `ts_config` VALUES (0x66756c6c746578745f6e61746976655f636f6d6d6f6e5f7468726573, 0x35, 0);
INSERT INTO `ts_config` VALUES (0x66756c6c746578745f6e61746976655f6c6f61645f757064, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x66756c6c746578745f6e61746976655f6d61785f6368617273, 0x3134, 0);
INSERT INTO `ts_config` VALUES (0x66756c6c746578745f6e61746976655f6d696e5f6368617273, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x677a69705f636f6d7072657373, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x686f745f7468726573686f6c64, 0x3235, 0);
INSERT INTO `ts_config` VALUES (0x69636f6e735f70617468, 0x696d616765732f69636f6e73, 0);
INSERT INTO `ts_config` VALUES (0x696d675f6372656174655f7468756d626e61696c, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x696d675f646973706c61795f696e6c696e6564, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x696d675f696d616769636b, '', 0);
INSERT INTO `ts_config` VALUES (0x696d675f6c696e6b5f686569676874, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x696d675f6c696e6b5f7769647468, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x696d675f6d61785f686569676874, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x696d675f6d61785f7468756d625f7769647468, 0x343030, 0);
INSERT INTO `ts_config` VALUES (0x696d675f6d61785f7769647468, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x696d675f6d696e5f7468756d625f66696c6573697a65, 0x3132303030, 0);
INSERT INTO `ts_config` VALUES (0x69705f636865636b, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x6a61625f656e61626c65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6a61625f686f7374, '', 0);
INSERT INTO `ts_config` VALUES (0x6a61625f70617373776f7264, '', 0);
INSERT INTO `ts_config` VALUES (0x6a61625f7061636b6167655f73697a65, 0x3230, 0);
INSERT INTO `ts_config` VALUES (0x6a61625f706f7274, 0x35323232, 0);
INSERT INTO `ts_config` VALUES (0x6a61625f7573655f73736c, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6a61625f757365726e616d65, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f626173655f646e, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f656d61696c, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f70617373776f7264, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f706f7274, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f736572766572, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f756964, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f75736572, '', 0);
INSERT INTO `ts_config` VALUES (0x6c6461705f757365725f66696c746572, '', 0);
INSERT INTO `ts_config` VALUES (0x6c696d69745f6c6f6164, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6c696d69745f7365617263685f6c6f6164, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f616e6f6e5f6c61737472656164, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f626972746864617973, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6370665f6d656d6265726c697374, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6370665f7669657770726f66696c65, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6370665f76696577746f706963, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f64625f6c61737472656164, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f64625f747261636b, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6a756d70626f78, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6d6f64657261746f7273, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6f6e6c696e65, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6f6e6c696e655f677565737473, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6f6e6c696e655f74696d65, 0x35, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f6f6e6c696e65747261636b, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f736561726368, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f74706c636f6d70696c65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6c6f61645f757365725f6163746976697479, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f6174746163686d656e7473, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f6174746163686d656e74735f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f6175746f6c6f67696e5f74696d65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f66696c6573697a65, 0x323632313434, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f66696c6573697a655f706d, 0x323632313434, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f6c6f67696e5f617474656d707473, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f6e616d655f6368617273, 0x3230, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706173735f6368617273, 0x3330, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706f6c6c5f6f7074696f6e73, 0x3130, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706f73745f6368617273, 0x3630303030, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706f73745f666f6e745f73697a65, 0x323030, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706f73745f696d675f686569676874, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706f73745f696d675f7769647468, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706f73745f736d696c696573, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f706f73745f75726c73, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f71756f74655f6465707468, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f7265675f617474656d707473, 0x35, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f7369675f6368617273, 0x323535, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f7369675f666f6e745f73697a65, 0x323030, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f7369675f696d675f686569676874, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f7369675f696d675f7769647468, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f7369675f736d696c696573, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x6d61785f7369675f75726c73, 0x35, 0);
INSERT INTO `ts_config` VALUES (0x6d696e5f6e616d655f6368617273, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x6d696e5f706173735f6368617273, 0x36, 0);
INSERT INTO `ts_config` VALUES (0x6d696e5f7365617263685f617574686f725f6368617273, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x6d696d655f7472696767657273, 0x626f64797c686561647c68746d6c7c696d677c706c61696e746578747c6120687265667c7072657c7363726970747c7461626c657c7469746c65, 0);
INSERT INTO `ts_config` VALUES (0x6f766572726964655f757365725f7374796c65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x706173735f636f6d706c6578, 0x504153535f545950455f414e59, 0);
INSERT INTO `ts_config` VALUES (0x706d5f656469745f74696d65, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x706d5f6d61785f626f786573, 0x34, 0);
INSERT INTO `ts_config` VALUES (0x706d5f6d61785f6d736773, 0x3530, 0);
INSERT INTO `ts_config` VALUES (0x706d5f6d61785f726563697069656e7473, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x706f7374735f7065725f70616765, 0x3130, 0);
INSERT INTO `ts_config` VALUES (0x7072696e745f706d, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x71756575655f696e74657276616c, 0x363030, 0);
INSERT INTO `ts_config` VALUES (0x71756575655f747269676765725f706f737473, 0x33, 0);
INSERT INTO `ts_config` VALUES (0x72616e6b735f70617468, 0x696d616765732f72616e6b73, 0);
INSERT INTO `ts_config` VALUES (0x726571756972655f61637469766174696f6e, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x726566657265725f76616c69646174696f6e, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x7363726970745f70617468, 0x2f, 0);
INSERT INTO `ts_config` VALUES (0x7365617263685f626c6f636b5f73697a65, 0x323530, 0);
INSERT INTO `ts_config` VALUES (0x7365617263685f6763, 0x37323030, 0);
INSERT INTO `ts_config` VALUES (0x7365617263685f696e646578696e675f7374617465, '', 0);
INSERT INTO `ts_config` VALUES (0x7365617263685f696e74657276616c, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x7365617263685f616e6f6e796d6f75735f696e74657276616c, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x7365617263685f74797065, 0x66756c6c746578745f6e6174697665, 0);
INSERT INTO `ts_config` VALUES (0x7365617263685f73746f72655f726573756c7473, 0x31383030, 0);
INSERT INTO `ts_config` VALUES (0x7365637572655f616c6c6f775f64656e79, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x7365637572655f616c6c6f775f656d7074795f72656665726572, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x7365637572655f646f776e6c6f616473, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x7365727665725f6e616d65, 0x7777772e7465636873746174696f6e2e696e, 0);
INSERT INTO `ts_config` VALUES (0x7365727665725f706f7274, 0x3830, 0);
INSERT INTO `ts_config` VALUES (0x7365727665725f70726f746f636f6c, 0x687474703a2f2f, 0);
INSERT INTO `ts_config` VALUES (0x73657373696f6e5f6763, 0x33363030, 0);
INSERT INTO `ts_config` VALUES (0x73657373696f6e5f6c656e677468, 0x33363030, 0);
INSERT INTO `ts_config` VALUES (0x736974655f64657363, 0x776865726520616c6c2074656368696527732073746f70212121, 0);
INSERT INTO `ts_config` VALUES (0x736974656e616d65, 0x7465636873746174696f6e2e696e, 0);
INSERT INTO `ts_config` VALUES (0x736d696c6965735f70617468, 0x696d616765732f736d696c696573, 0);
INSERT INTO `ts_config` VALUES (0x736d74705f617574685f6d6574686f64, 0x504c41494e, 0);
INSERT INTO `ts_config` VALUES (0x736d74705f64656c6976657279, 0x31, 0);
INSERT INTO `ts_config` VALUES (0x736d74705f686f7374, 0x637573746f6d65722d736d74702e6f6e652e636f6d, 0);
INSERT INTO `ts_config` VALUES (0x736d74705f70617373776f7264, '', 0);
INSERT INTO `ts_config` VALUES (0x736d74705f706f7274, 0x3235, 0);
INSERT INTO `ts_config` VALUES (0x736d74705f757365726e616d65, '', 0);
INSERT INTO `ts_config` VALUES (0x746f706963735f7065725f70616765, 0x3235, 0);
INSERT INTO `ts_config` VALUES (0x74706c5f616c6c6f775f706870, 0x30, 0);
INSERT INTO `ts_config` VALUES (0x75706c6f61645f69636f6e735f70617468, 0x696d616765732f75706c6f61645f69636f6e73, 0);
INSERT INTO `ts_config` VALUES (0x75706c6f61645f70617468, 0x66696c6573, 0);
INSERT INTO `ts_config` VALUES (0x76657273696f6e, 0x332e302e34, 0);
INSERT INTO `ts_config` VALUES (0x7761726e696e67735f6578706972655f64617973, 0x3930, 0);
INSERT INTO `ts_config` VALUES (0x7761726e696e67735f6763, 0x3134343030, 0);
INSERT INTO `ts_config` VALUES (0x63616368655f6c6173745f6763, 0x31323335383334343839, 1);
INSERT INTO `ts_config` VALUES (0x63726f6e5f6c6f636b, 0x30, 1);
INSERT INTO `ts_config` VALUES (0x64617461626173655f6c6173745f6763, 0x31323335383334383138, 1);
INSERT INTO `ts_config` VALUES (0x6c6173745f71756575655f72756e, 0x30, 1);
INSERT INTO `ts_config` VALUES (0x6e65776573745f757365725f636f6c6f7572, 0x414130303030, 1);
INSERT INTO `ts_config` VALUES (0x6e65776573745f757365725f6964, 0x32, 1);
INSERT INTO `ts_config` VALUES (0x6e65776573745f757365726e616d65, 0x6465616e, 1);
INSERT INTO `ts_config` VALUES (0x6e756d5f66696c6573, 0x30, 1);
INSERT INTO `ts_config` VALUES (0x6e756d5f706f737473, 0x30, 1);
INSERT INTO `ts_config` VALUES (0x6e756d5f746f70696373, 0x30, 1);
INSERT INTO `ts_config` VALUES (0x6e756d5f7573657273, 0x31, 1);
INSERT INTO `ts_config` VALUES (0x72616e645f73656564, 0x3835653761633563373838306637313233363833633265373439316239363163, 1);
INSERT INTO `ts_config` VALUES (0x72616e645f736565645f6c6173745f757064617465, 0x31323530303137343431, 1);
INSERT INTO `ts_config` VALUES (0x7265636f72645f6f6e6c696e655f64617465, 0x31323337323038333034, 1);
INSERT INTO `ts_config` VALUES (0x7265636f72645f6f6e6c696e655f7573657273, 0x33, 1);
INSERT INTO `ts_config` VALUES (0x7365617263685f6c6173745f6763, 0x31323335383334383239, 1);
INSERT INTO `ts_config` VALUES (0x73657373696f6e5f6c6173745f6763, 0x31323335383338353331, 1);
INSERT INTO `ts_config` VALUES (0x75706c6f61645f6469725f73697a65, 0x30, 1);
INSERT INTO `ts_config` VALUES (0x7761726e696e67735f6c6173745f6763, 0x31323335383334363733, 1);
INSERT INTO `ts_config` VALUES (0x626f6172645f737461727464617465, 0x31323335383238343431, 0);
INSERT INTO `ts_config` VALUES (0x64656661756c745f6c616e67, 0x656e, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_confirm`
-- 

CREATE TABLE `ts_confirm` (
  `confirm_id` char(32) collate utf8_bin NOT NULL default '',
  `session_id` char(32) collate utf8_bin NOT NULL default '',
  `confirm_type` tinyint(3) NOT NULL default '0',
  `code` varchar(8) collate utf8_bin NOT NULL default '',
  `seed` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`session_id`,`confirm_id`),
  KEY `confirm_type` (`confirm_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_confirm`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_disallow`
-- 

CREATE TABLE `ts_disallow` (
  `disallow_id` mediumint(8) unsigned NOT NULL auto_increment,
  `disallow_username` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`disallow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_disallow`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_drafts`
-- 

CREATE TABLE `ts_drafts` (
  `draft_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `save_time` int(11) unsigned NOT NULL default '0',
  `draft_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `draft_message` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`draft_id`),
  KEY `save_time` (`save_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_drafts`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_extension_groups`
-- 

CREATE TABLE `ts_extension_groups` (
  `group_id` mediumint(8) unsigned NOT NULL auto_increment,
  `group_name` varchar(255) collate utf8_bin NOT NULL default '',
  `cat_id` tinyint(2) NOT NULL default '0',
  `allow_group` tinyint(1) unsigned NOT NULL default '0',
  `download_mode` tinyint(1) unsigned NOT NULL default '1',
  `upload_icon` varchar(255) collate utf8_bin NOT NULL default '',
  `max_filesize` int(20) unsigned NOT NULL default '0',
  `allowed_forums` text collate utf8_bin NOT NULL,
  `allow_in_pm` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=10 ;

-- 
-- Dumping data for table `ts_extension_groups`
-- 

INSERT INTO `ts_extension_groups` VALUES (1, 0x496d61676573, 1, 1, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (2, 0x4172636869766573, 0, 1, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (3, 0x506c61696e2054657874, 0, 0, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (4, 0x446f63756d656e7473, 0, 0, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (5, 0x5265616c204d65646961, 3, 0, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (6, 0x57696e646f7773204d65646961, 2, 0, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (7, 0x466c6173682046696c6573, 5, 0, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (8, 0x517569636b74696d65204d65646961, 6, 0, 1, '', 0, '', 0);
INSERT INTO `ts_extension_groups` VALUES (9, 0x446f776e6c6f616461626c652046696c6573, 0, 0, 1, '', 0, '', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_extensions`
-- 

CREATE TABLE `ts_extensions` (
  `extension_id` mediumint(8) unsigned NOT NULL auto_increment,
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `extension` varchar(100) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`extension_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=67 ;

-- 
-- Dumping data for table `ts_extensions`
-- 

INSERT INTO `ts_extensions` VALUES (1, 1, 0x676966);
INSERT INTO `ts_extensions` VALUES (2, 1, 0x706e67);
INSERT INTO `ts_extensions` VALUES (3, 1, 0x6a706567);
INSERT INTO `ts_extensions` VALUES (4, 1, 0x6a7067);
INSERT INTO `ts_extensions` VALUES (5, 1, 0x746966);
INSERT INTO `ts_extensions` VALUES (6, 1, 0x74696666);
INSERT INTO `ts_extensions` VALUES (7, 1, 0x746761);
INSERT INTO `ts_extensions` VALUES (8, 2, 0x67746172);
INSERT INTO `ts_extensions` VALUES (9, 2, 0x677a);
INSERT INTO `ts_extensions` VALUES (10, 2, 0x746172);
INSERT INTO `ts_extensions` VALUES (11, 2, 0x7a6970);
INSERT INTO `ts_extensions` VALUES (12, 2, 0x726172);
INSERT INTO `ts_extensions` VALUES (13, 2, 0x616365);
INSERT INTO `ts_extensions` VALUES (14, 2, 0x746f7272656e74);
INSERT INTO `ts_extensions` VALUES (15, 2, 0x74677a);
INSERT INTO `ts_extensions` VALUES (16, 2, 0x627a32);
INSERT INTO `ts_extensions` VALUES (17, 2, 0x377a);
INSERT INTO `ts_extensions` VALUES (18, 3, 0x747874);
INSERT INTO `ts_extensions` VALUES (19, 3, 0x63);
INSERT INTO `ts_extensions` VALUES (20, 3, 0x68);
INSERT INTO `ts_extensions` VALUES (21, 3, 0x637070);
INSERT INTO `ts_extensions` VALUES (22, 3, 0x687070);
INSERT INTO `ts_extensions` VALUES (23, 3, 0x64697a);
INSERT INTO `ts_extensions` VALUES (24, 3, 0x637376);
INSERT INTO `ts_extensions` VALUES (25, 3, 0x696e69);
INSERT INTO `ts_extensions` VALUES (26, 3, 0x6c6f67);
INSERT INTO `ts_extensions` VALUES (27, 3, 0x6a73);
INSERT INTO `ts_extensions` VALUES (28, 3, 0x786d6c);
INSERT INTO `ts_extensions` VALUES (29, 4, 0x786c73);
INSERT INTO `ts_extensions` VALUES (30, 4, 0x786c7378);
INSERT INTO `ts_extensions` VALUES (31, 4, 0x786c736d);
INSERT INTO `ts_extensions` VALUES (32, 4, 0x786c7362);
INSERT INTO `ts_extensions` VALUES (33, 4, 0x646f63);
INSERT INTO `ts_extensions` VALUES (34, 4, 0x646f6378);
INSERT INTO `ts_extensions` VALUES (35, 4, 0x646f636d);
INSERT INTO `ts_extensions` VALUES (36, 4, 0x646f74);
INSERT INTO `ts_extensions` VALUES (37, 4, 0x646f7478);
INSERT INTO `ts_extensions` VALUES (38, 4, 0x646f746d);
INSERT INTO `ts_extensions` VALUES (39, 4, 0x706466);
INSERT INTO `ts_extensions` VALUES (40, 4, 0x6169);
INSERT INTO `ts_extensions` VALUES (41, 4, 0x7073);
INSERT INTO `ts_extensions` VALUES (42, 4, 0x707074);
INSERT INTO `ts_extensions` VALUES (43, 4, 0x70707478);
INSERT INTO `ts_extensions` VALUES (44, 4, 0x7070746d);
INSERT INTO `ts_extensions` VALUES (45, 4, 0x6f6467);
INSERT INTO `ts_extensions` VALUES (46, 4, 0x6f6470);
INSERT INTO `ts_extensions` VALUES (47, 4, 0x6f6473);
INSERT INTO `ts_extensions` VALUES (48, 4, 0x6f6474);
INSERT INTO `ts_extensions` VALUES (49, 4, 0x727466);
INSERT INTO `ts_extensions` VALUES (50, 5, 0x726d);
INSERT INTO `ts_extensions` VALUES (51, 5, 0x72616d);
INSERT INTO `ts_extensions` VALUES (52, 6, 0x776d61);
INSERT INTO `ts_extensions` VALUES (53, 6, 0x776d76);
INSERT INTO `ts_extensions` VALUES (54, 7, 0x737766);
INSERT INTO `ts_extensions` VALUES (55, 8, 0x6d6f76);
INSERT INTO `ts_extensions` VALUES (56, 8, 0x6d3476);
INSERT INTO `ts_extensions` VALUES (57, 8, 0x6d3461);
INSERT INTO `ts_extensions` VALUES (58, 8, 0x6d7034);
INSERT INTO `ts_extensions` VALUES (59, 8, 0x336770);
INSERT INTO `ts_extensions` VALUES (60, 8, 0x336732);
INSERT INTO `ts_extensions` VALUES (61, 8, 0x7174);
INSERT INTO `ts_extensions` VALUES (62, 9, 0x6d706567);
INSERT INTO `ts_extensions` VALUES (63, 9, 0x6d7067);
INSERT INTO `ts_extensions` VALUES (64, 9, 0x6d7033);
INSERT INTO `ts_extensions` VALUES (65, 9, 0x6f6767);
INSERT INTO `ts_extensions` VALUES (66, 9, 0x6f676d);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_forums`
-- 

CREATE TABLE `ts_forums` (
  `forum_id` mediumint(8) unsigned NOT NULL auto_increment,
  `parent_id` mediumint(8) unsigned NOT NULL default '0',
  `left_id` mediumint(8) unsigned NOT NULL default '0',
  `right_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_parents` mediumtext collate utf8_bin NOT NULL,
  `forum_name` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_desc` text collate utf8_bin NOT NULL,
  `forum_desc_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_desc_options` int(11) unsigned NOT NULL default '7',
  `forum_desc_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `forum_link` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_password` varchar(40) collate utf8_bin NOT NULL default '',
  `forum_style` mediumint(8) unsigned NOT NULL default '0',
  `forum_image` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_rules` text collate utf8_bin NOT NULL,
  `forum_rules_link` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_rules_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_rules_options` int(11) unsigned NOT NULL default '7',
  `forum_rules_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `forum_topics_per_page` tinyint(4) NOT NULL default '0',
  `forum_type` tinyint(4) NOT NULL default '0',
  `forum_status` tinyint(4) NOT NULL default '0',
  `forum_posts` mediumint(8) unsigned NOT NULL default '0',
  `forum_topics` mediumint(8) unsigned NOT NULL default '0',
  `forum_topics_real` mediumint(8) unsigned NOT NULL default '0',
  `forum_last_post_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_last_poster_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_last_post_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_last_post_time` int(11) unsigned NOT NULL default '0',
  `forum_last_poster_name` varchar(255) collate utf8_bin NOT NULL default '',
  `forum_last_poster_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `forum_flags` tinyint(4) NOT NULL default '32',
  `display_subforum_list` tinyint(1) unsigned NOT NULL default '1',
  `display_on_index` tinyint(1) unsigned NOT NULL default '1',
  `enable_indexing` tinyint(1) unsigned NOT NULL default '1',
  `enable_icons` tinyint(1) unsigned NOT NULL default '1',
  `enable_prune` tinyint(1) unsigned NOT NULL default '0',
  `prune_next` int(11) unsigned NOT NULL default '0',
  `prune_days` mediumint(8) unsigned NOT NULL default '0',
  `prune_viewed` mediumint(8) unsigned NOT NULL default '0',
  `prune_freq` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`forum_id`),
  KEY `left_right_id` (`left_id`,`right_id`),
  KEY `forum_lastpost_id` (`forum_last_post_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=22 ;

-- 
-- Dumping data for table `ts_forums`
-- 

INSERT INTO `ts_forums` VALUES (11, 0, 1, 8, '', 0x44424120466f72756d73, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '', '', 48, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (12, 11, 2, 3, 0x613a313a7b693a31313b613a323a7b693a303b733a31303a2244424120466f72756d73223b693a313b693a303b7d7d, 0x4f7261636c652044617461626173652041646d696e697374726174696f6e, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (13, 11, 4, 5, 0x613a313a7b693a31313b613a323a7b693a303b733a31303a2244424120466f72756d73223b693a313b693a303b7d7d, 0x4f7261636c65204170706c69636174696f6e7320444241, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (14, 11, 6, 7, 0x613a313a7b693a31313b613a323a7b693a303b733a31303a2244424120466f72756d73223b693a313b693a303b7d7d, 0x4f7261636c65204442412043657274696669636174696f6e, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (15, 0, 17, 22, '', 0x44424120436172656572, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '', '', 48, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (16, 15, 18, 19, '', 0x44424120496e74657276696577205175657374696f6e73, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (17, 15, 20, 21, '', 0x444241204a6f6273, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (19, 18, 10, 11, '', 0x53514c20616e6420504c2f53514c, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (20, 18, 12, 13, '', 0x446174616261736520496e7374616c6c6174696f6e, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (21, 18, 14, 15, '', 0x4d697363656c6c656e656f7573, 0x4f74686572206461746162617365206973737565732e, '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 1, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);
INSERT INTO `ts_forums` VALUES (18, 0, 9, 16, '', 0x4f7261636c65204461746162617365, '', '', 7, '', '', '', 0, '', '', '', '', 7, '', 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '', '', 32, 1, 0, 1, 0, 0, 0, 7, 7, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_forums_access`
-- 

CREATE TABLE `ts_forums_access` (
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `session_id` char(32) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`forum_id`,`user_id`,`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_forums_access`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_forums_track`
-- 

CREATE TABLE `ts_forums_track` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `mark_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_forums_track`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_forums_watch`
-- 

CREATE TABLE `ts_forums_watch` (
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `notify_status` tinyint(1) unsigned NOT NULL default '0',
  KEY `forum_id` (`forum_id`),
  KEY `user_id` (`user_id`),
  KEY `notify_stat` (`notify_status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_forums_watch`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_groups`
-- 

CREATE TABLE `ts_groups` (
  `group_id` mediumint(8) unsigned NOT NULL auto_increment,
  `group_type` tinyint(4) NOT NULL default '1',
  `group_founder_manage` tinyint(1) unsigned NOT NULL default '0',
  `group_name` varchar(255) collate utf8_bin NOT NULL default '',
  `group_desc` text collate utf8_bin NOT NULL,
  `group_desc_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `group_desc_options` int(11) unsigned NOT NULL default '7',
  `group_desc_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `group_display` tinyint(1) unsigned NOT NULL default '0',
  `group_avatar` varchar(255) collate utf8_bin NOT NULL default '',
  `group_avatar_type` tinyint(2) NOT NULL default '0',
  `group_avatar_width` smallint(4) unsigned NOT NULL default '0',
  `group_avatar_height` smallint(4) unsigned NOT NULL default '0',
  `group_rank` mediumint(8) unsigned NOT NULL default '0',
  `group_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `group_sig_chars` mediumint(8) unsigned NOT NULL default '0',
  `group_receive_pm` tinyint(1) unsigned NOT NULL default '0',
  `group_message_limit` mediumint(8) unsigned NOT NULL default '0',
  `group_max_recipients` mediumint(8) unsigned NOT NULL default '0',
  `group_legend` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`group_id`),
  KEY `group_legend_name` (`group_legend`,`group_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

-- 
-- Dumping data for table `ts_groups`
-- 

INSERT INTO `ts_groups` VALUES (1, 3, 0, 0x475545535453, '', '', 7, '', 0, '', 0, 0, 0, 0, '', 0, 0, 0, 5, 0);
INSERT INTO `ts_groups` VALUES (2, 3, 0, 0x52454749535445524544, '', '', 7, '', 0, '', 0, 0, 0, 0, '', 0, 0, 0, 5, 0);
INSERT INTO `ts_groups` VALUES (3, 3, 0, 0x524547495354455245445f434f505041, '', '', 7, '', 0, '', 0, 0, 0, 0, '', 0, 0, 0, 5, 0);
INSERT INTO `ts_groups` VALUES (4, 3, 0, 0x474c4f42414c5f4d4f44455241544f5253, '', '', 7, '', 0, '', 0, 0, 0, 0, 0x303041413030, 0, 0, 0, 0, 1);
INSERT INTO `ts_groups` VALUES (5, 3, 1, 0x41444d494e4953545241544f5253, '', '', 7, '', 0, '', 0, 0, 0, 0, 0x414130303030, 0, 0, 0, 0, 1);
INSERT INTO `ts_groups` VALUES (6, 3, 0, 0x424f5453, '', '', 7, '', 0, '', 0, 0, 0, 0, 0x394538444137, 0, 0, 0, 5, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_icons`
-- 

CREATE TABLE `ts_icons` (
  `icons_id` mediumint(8) unsigned NOT NULL auto_increment,
  `icons_url` varchar(255) collate utf8_bin NOT NULL default '',
  `icons_width` tinyint(4) NOT NULL default '0',
  `icons_height` tinyint(4) NOT NULL default '0',
  `icons_order` mediumint(8) unsigned NOT NULL default '0',
  `display_on_posting` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`icons_id`),
  KEY `display_on_posting` (`display_on_posting`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=11 ;

-- 
-- Dumping data for table `ts_icons`
-- 

INSERT INTO `ts_icons` VALUES (1, 0x6d6973632f666972652e676966, 16, 16, 1, 1);
INSERT INTO `ts_icons` VALUES (2, 0x736d696c652f726564666163652e676966, 16, 16, 9, 1);
INSERT INTO `ts_icons` VALUES (3, 0x736d696c652f6d72677265656e2e676966, 16, 16, 10, 1);
INSERT INTO `ts_icons` VALUES (4, 0x6d6973632f68656172742e676966, 16, 16, 4, 1);
INSERT INTO `ts_icons` VALUES (5, 0x6d6973632f737461722e676966, 16, 16, 2, 1);
INSERT INTO `ts_icons` VALUES (6, 0x6d6973632f726164696f6163746976652e676966, 16, 16, 3, 1);
INSERT INTO `ts_icons` VALUES (7, 0x6d6973632f7468696e6b696e672e676966, 16, 16, 5, 1);
INSERT INTO `ts_icons` VALUES (8, 0x736d696c652f696e666f2e676966, 16, 16, 8, 1);
INSERT INTO `ts_icons` VALUES (9, 0x736d696c652f7175657374696f6e2e676966, 16, 16, 6, 1);
INSERT INTO `ts_icons` VALUES (10, 0x736d696c652f616c6572742e676966, 16, 16, 7, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_lang`
-- 

CREATE TABLE `ts_lang` (
  `lang_id` tinyint(4) NOT NULL auto_increment,
  `lang_iso` varchar(30) collate utf8_bin NOT NULL default '',
  `lang_dir` varchar(30) collate utf8_bin NOT NULL default '',
  `lang_english_name` varchar(100) collate utf8_bin NOT NULL default '',
  `lang_local_name` varchar(255) collate utf8_bin NOT NULL default '',
  `lang_author` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`lang_id`),
  KEY `lang_iso` (`lang_iso`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_lang`
-- 

INSERT INTO `ts_lang` VALUES (1, 0x656e, 0x656e, 0x4272697469736820456e676c697368, 0x4272697469736820456e676c697368, 0x70687042422047726f7570);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_log`
-- 

CREATE TABLE `ts_log` (
  `log_id` mediumint(8) unsigned NOT NULL auto_increment,
  `log_type` tinyint(4) NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `reportee_id` mediumint(8) unsigned NOT NULL default '0',
  `log_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `log_time` int(11) unsigned NOT NULL default '0',
  `log_operation` text collate utf8_bin NOT NULL,
  `log_data` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`log_id`),
  KEY `log_type` (`log_type`),
  KEY `forum_id` (`forum_id`),
  KEY `topic_id` (`topic_id`),
  KEY `reportee_id` (`reportee_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=38 ;

-- 
-- Dumping data for table `ts_log`
-- 

INSERT INTO `ts_log` VALUES (1, 2, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235828468, 0x4c4f475f4552524f525f454d41494c, 0x613a313a7b693a303b733a3436363a223c7374726f6e673e454d41494c2f534d54503c2f7374726f6e673e3c6272202f3e3c656d3e2f696e7374616c6c2f696e6465782e7068703c2f656d3e3c6272202f3e3c6272202f3e436f756c64206e6f7420636f6e6e65637420746f20736d747020686f7374203a20313130203a20436f6e6e656374696f6e2074696d6564206f75743c6272202f3e3c6272202f3e266c743b622667743b5b70687042422044656275675d20504850204e6f74696365266c743b2f622667743b3a20696e2066696c6520266c743b622667743b2f696e636c756465732f66756e6374696f6e735f6d657373656e6765722e706870266c743b2f622667743b206f6e206c696e6520266c743b622667743b383436266c743b2f622667743b3a20266c743b622667743b66736f636b6f70656e2829205b266c743b6120687265663d2766756e6374696f6e2e66736f636b6f70656e272667743b66756e6374696f6e2e66736f636b6f70656e266c743b2f612667743b5d3a20756e61626c6520746f20636f6e6e65637420746f20637573746f6d65722d736d74702e6f6e652e636f6d3a32352028436f6e6e656374696f6e2074696d6564206f757429266c743b2f622667743b266c743b6272202f2667743b0a3c6272202f3e223b7d);
INSERT INTO `ts_log` VALUES (2, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235828468, 0x4c4f475f494e5354414c4c5f494e5354414c4c4544, 0x613a313a7b693a303b733a353a22332e302e34223b7d);
INSERT INTO `ts_log` VALUES (3, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235834927, 0x4c4f475f41444d494e5f415554485f53554343455353, '');
INSERT INTO `ts_log` VALUES (4, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235838664, 0x4c4f475f464f52554d5f45444954, 0x613a313a7b693a303b733a31383a22496e7465727669657720506c6174666f726d223b7d);
INSERT INTO `ts_log` VALUES (5, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235838885, 0x4c4f475f464f52554d5f45444954, 0x613a313a7b693a303b733a32313a22545330313031202d20485220496e74657276696577223b7d);
INSERT INTO `ts_log` VALUES (6, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235839028, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a32373a22545330313032202d204170746974756465205175657374696f6e73223b7d);
INSERT INTO `ts_log` VALUES (7, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235839213, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a32363a22545330313033202d20436f6d707574657220436f6e6365707473223b7d);
INSERT INTO `ts_log` VALUES (8, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235839252, 0x4c4f475f464f52554d5f45444954, 0x613a313a7b693a303b733a31383a225046203031202d20496e7465727669657773223b7d);
INSERT INTO `ts_log` VALUES (9, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235839564, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31373a225046203032202d204c616e677561676573223b7d);
INSERT INTO `ts_log` VALUES (10, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235839657, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31363a22545330323031202d2043202f20432b2b223b7d);
INSERT INTO `ts_log` VALUES (11, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235839715, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31333a22545330323032202d204a617661223b7d);
INSERT INTO `ts_log` VALUES (12, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235840229, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31333a22545330323033202d205065726c223b7d);
INSERT INTO `ts_log` VALUES (13, 0, 2, 0, 0, 0, 0x3132312e3234362e3233342e323033, 1235840316, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a333a22504850223b7d);
INSERT INTO `ts_log` VALUES (14, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237207718, 0x4c4f475f41444d494e5f415554485f53554343455353, '');
INSERT INTO `ts_log` VALUES (15, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237207752, 0x4c4f475f464f52554d5f44454c5f464f52554d53, 0x613a313a7b693a303b733a31373a225046203032202d204c616e677561676573223b7d);
INSERT INTO `ts_log` VALUES (16, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237207765, 0x4c4f475f464f52554d5f44454c5f464f52554d53, 0x613a313a7b693a303b733a31383a225046203031202d20496e7465727669657773223b7d);
INSERT INTO `ts_log` VALUES (17, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237207872, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a373a224d79466f72756d223b7d);
INSERT INTO `ts_log` VALUES (18, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237207981, 0x4c4f475f41434c5f4144445f464f52554d5f4c4f43414c5f465f, 0x613a323a7b693a303b733a373a224d79466f72756d223b693a313b733a34313a223c7370616e20636c6173733d22736570223e526567697374657265642075736572733c2f7370616e3e223b7d);
INSERT INTO `ts_log` VALUES (19, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237208492, 0x4c4f475f41434c5f4144445f464f52554d5f4c4f43414c5f465f, 0x613a323a7b693a303b733a373a224d79466f72756d223b693a313b733a3134373a223c7370616e20636c6173733d22736570223e4775657374733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e476c6f62616c206d6f64657261746f72733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e41646d696e6973747261746f72733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e426f74733c2f7370616e3e223b7d);
INSERT INTO `ts_log` VALUES (20, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266027, 0x4c4f475f41444d494e5f415554485f53554343455353, '');
INSERT INTO `ts_log` VALUES (21, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266247, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31303a2244424120466f72756d73223b7d);
INSERT INTO `ts_log` VALUES (22, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266257, 0x4c4f475f464f52554d5f4d4f56455f5550, 0x613a323a7b693a303b733a31303a2244424120466f72756d73223b693a313b733a373a224d79466f72756d223b7d);
INSERT INTO `ts_log` VALUES (23, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266311, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a33303a224f7261636c652044617461626173652041646d696e697374726174696f6e223b7d);
INSERT INTO `ts_log` VALUES (24, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266370, 0x4c4f475f41434c5f4144445f464f52554d5f4c4f43414c5f465f, 0x613a323a7b693a303b733a33303a224f7261636c652044617461626173652041646d696e697374726174696f6e223b693a313b733a3139303a223c7370616e20636c6173733d22736570223e4775657374733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e526567697374657265642075736572733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e476c6f62616c206d6f64657261746f72733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e41646d696e6973747261746f72733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e426f74733c2f7370616e3e223b7d);
INSERT INTO `ts_log` VALUES (25, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266402, 0x4c4f475f41434c5f4144445f464f52554d5f4c4f43414c5f465f, 0x613a323a7b693a303b733a31303a2244424120466f72756d73223b693a313b733a3139303a223c7370616e20636c6173733d22736570223e4775657374733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e526567697374657265642075736572733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e476c6f62616c206d6f64657261746f72733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e41646d696e6973747261746f72733c2f7370616e3e2c203c7370616e20636c6173733d22736570223e426f74733c2f7370616e3e223b7d);
INSERT INTO `ts_log` VALUES (26, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266474, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a32333a224f7261636c65204170706c69636174696f6e7320444241223b7d);
INSERT INTO `ts_log` VALUES (27, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266543, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a32343a224f7261636c65204442412043657274696669636174696f6e223b7d);
INSERT INTO `ts_log` VALUES (28, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266616, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31303a2244424120436172656572223b7d);
INSERT INTO `ts_log` VALUES (29, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266685, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a32333a2244424120496e74657276696577205175657374696f6e73223b7d);
INSERT INTO `ts_log` VALUES (30, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266731, 0x4c4f475f464f52554d5f45444954, 0x613a313a7b693a303b733a32333a2244424120496e74657276696577205175657374696f6e73223b7d);
INSERT INTO `ts_log` VALUES (31, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266795, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a383a22444241204a6f6273223b7d);
INSERT INTO `ts_log` VALUES (32, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266858, 0x4c4f475f464f52554d5f44454c5f504f535453, 0x613a313a7b693a303b733a373a224d79466f72756d223b7d);
INSERT INTO `ts_log` VALUES (33, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266984, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31353a224f7261636c65204461746162617365223b7d);
INSERT INTO `ts_log` VALUES (34, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237266995, 0x4c4f475f464f52554d5f4d4f56455f5550, 0x613a323a7b693a303b733a31353a224f7261636c65204461746162617365223b693a313b733a31303a2244424120436172656572223b7d);
INSERT INTO `ts_log` VALUES (35, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237267035, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31343a2253514c20616e6420504c2f53514c223b7d);
INSERT INTO `ts_log` VALUES (36, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237267084, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a32313a22446174616261736520496e7374616c6c6174696f6e223b7d);
INSERT INTO `ts_log` VALUES (37, 0, 2, 0, 0, 0, 0x3134382e38372e312e313732, 1237267155, 0x4c4f475f464f52554d5f414444, 0x613a313a7b693a303b733a31333a224d697363656c6c656e656f7573223b7d);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_moderator_cache`
-- 

CREATE TABLE `ts_moderator_cache` (
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `username` varchar(255) collate utf8_bin NOT NULL default '',
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `group_name` varchar(255) collate utf8_bin NOT NULL default '',
  `display_on_index` tinyint(1) unsigned NOT NULL default '1',
  KEY `disp_idx` (`display_on_index`),
  KEY `forum_id` (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_moderator_cache`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_modules`
-- 

CREATE TABLE `ts_modules` (
  `module_id` mediumint(8) unsigned NOT NULL auto_increment,
  `module_enabled` tinyint(1) unsigned NOT NULL default '1',
  `module_display` tinyint(1) unsigned NOT NULL default '1',
  `module_basename` varchar(255) collate utf8_bin NOT NULL default '',
  `module_class` varchar(10) collate utf8_bin NOT NULL default '',
  `parent_id` mediumint(8) unsigned NOT NULL default '0',
  `left_id` mediumint(8) unsigned NOT NULL default '0',
  `right_id` mediumint(8) unsigned NOT NULL default '0',
  `module_langname` varchar(255) collate utf8_bin NOT NULL default '',
  `module_mode` varchar(255) collate utf8_bin NOT NULL default '',
  `module_auth` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`module_id`),
  KEY `left_right_id` (`left_id`,`right_id`),
  KEY `module_enabled` (`module_enabled`),
  KEY `class_left_id` (`module_class`,`left_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=190 ;

-- 
-- Dumping data for table `ts_modules`
-- 

INSERT INTO `ts_modules` VALUES (1, 1, 1, '', 0x616370, 0, 1, 60, 0x4143505f4341545f47454e4552414c, '', '');
INSERT INTO `ts_modules` VALUES (2, 1, 1, '', 0x616370, 1, 4, 17, 0x4143505f515549434b5f414343455353, '', '');
INSERT INTO `ts_modules` VALUES (3, 1, 1, '', 0x616370, 1, 18, 39, 0x4143505f424f4152445f434f4e46494755524154494f4e, '', '');
INSERT INTO `ts_modules` VALUES (4, 1, 1, '', 0x616370, 1, 40, 47, 0x4143505f434c49454e545f434f4d4d554e49434154494f4e, '', '');
INSERT INTO `ts_modules` VALUES (5, 1, 1, '', 0x616370, 1, 48, 59, 0x4143505f5345525645525f434f4e46494755524154494f4e, '', '');
INSERT INTO `ts_modules` VALUES (6, 1, 1, '', 0x616370, 0, 61, 78, 0x4143505f4341545f464f52554d53, '', '');
INSERT INTO `ts_modules` VALUES (7, 1, 1, '', 0x616370, 6, 62, 67, 0x4143505f4d414e4147455f464f52554d53, '', '');
INSERT INTO `ts_modules` VALUES (8, 1, 1, '', 0x616370, 6, 68, 77, 0x4143505f464f52554d5f42415345445f5045524d495353494f4e53, '', '');
INSERT INTO `ts_modules` VALUES (9, 1, 1, '', 0x616370, 0, 79, 102, 0x4143505f4341545f504f5354494e47, '', '');
INSERT INTO `ts_modules` VALUES (10, 1, 1, '', 0x616370, 9, 80, 91, 0x4143505f4d45535341474553, '', '');
INSERT INTO `ts_modules` VALUES (11, 1, 1, '', 0x616370, 9, 92, 101, 0x4143505f4154544143484d454e5453, '', '');
INSERT INTO `ts_modules` VALUES (12, 1, 1, '', 0x616370, 0, 103, 156, 0x4143505f4341545f5553455247524f5550, '', '');
INSERT INTO `ts_modules` VALUES (13, 1, 1, '', 0x616370, 12, 104, 135, 0x4143505f4341545f5553455253, '', '');
INSERT INTO `ts_modules` VALUES (14, 1, 1, '', 0x616370, 12, 136, 143, 0x4143505f47524f555053, '', '');
INSERT INTO `ts_modules` VALUES (15, 1, 1, '', 0x616370, 12, 144, 155, 0x4143505f555345525f5345435552495459, '', '');
INSERT INTO `ts_modules` VALUES (16, 1, 1, '', 0x616370, 0, 157, 204, 0x4143505f4341545f5045524d495353494f4e53, '', '');
INSERT INTO `ts_modules` VALUES (17, 1, 1, '', 0x616370, 16, 160, 169, 0x4143505f474c4f42414c5f5045524d495353494f4e53, '', '');
INSERT INTO `ts_modules` VALUES (18, 1, 1, '', 0x616370, 16, 170, 179, 0x4143505f464f52554d5f42415345445f5045524d495353494f4e53, '', '');
INSERT INTO `ts_modules` VALUES (19, 1, 1, '', 0x616370, 16, 180, 189, 0x4143505f5045524d495353494f4e5f524f4c4553, '', '');
INSERT INTO `ts_modules` VALUES (20, 1, 1, '', 0x616370, 16, 190, 203, 0x4143505f5045524d495353494f4e5f4d41534b53, '', '');
INSERT INTO `ts_modules` VALUES (21, 1, 1, '', 0x616370, 0, 205, 218, 0x4143505f4341545f5354594c4553, '', '');
INSERT INTO `ts_modules` VALUES (22, 1, 1, '', 0x616370, 21, 206, 209, 0x4143505f5354594c455f4d414e4147454d454e54, '', '');
INSERT INTO `ts_modules` VALUES (23, 1, 1, '', 0x616370, 21, 210, 217, 0x4143505f5354594c455f434f4d504f4e454e5453, '', '');
INSERT INTO `ts_modules` VALUES (24, 1, 1, '', 0x616370, 0, 219, 238, 0x4143505f4341545f4d41494e54454e414e4345, '', '');
INSERT INTO `ts_modules` VALUES (25, 1, 1, '', 0x616370, 24, 220, 229, 0x4143505f464f52554d5f4c4f4753, '', '');
INSERT INTO `ts_modules` VALUES (26, 1, 1, '', 0x616370, 24, 230, 237, 0x4143505f4341545f4441544142415345, '', '');
INSERT INTO `ts_modules` VALUES (27, 1, 1, '', 0x616370, 0, 239, 264, 0x4143505f4341545f53595354454d, '', '');
INSERT INTO `ts_modules` VALUES (28, 1, 1, '', 0x616370, 27, 240, 243, 0x4143505f4155544f4d4154494f4e, '', '');
INSERT INTO `ts_modules` VALUES (29, 1, 1, '', 0x616370, 27, 244, 255, 0x4143505f47454e4552414c5f5441534b53, '', '');
INSERT INTO `ts_modules` VALUES (30, 1, 1, '', 0x616370, 27, 256, 263, 0x4143505f4d4f44554c455f4d414e4147454d454e54, '', '');
INSERT INTO `ts_modules` VALUES (31, 1, 1, '', 0x616370, 0, 265, 266, 0x4143505f4341545f444f545f4d4f4453, '', '');
INSERT INTO `ts_modules` VALUES (32, 1, 1, 0x6174746163686d656e7473, 0x616370, 3, 19, 20, 0x4143505f4154544143484d454e545f53455454494e4753, 0x617474616368, 0x61636c5f615f617474616368);
INSERT INTO `ts_modules` VALUES (33, 1, 1, 0x6174746163686d656e7473, 0x616370, 11, 93, 94, 0x4143505f4154544143484d454e545f53455454494e4753, 0x617474616368, 0x61636c5f615f617474616368);
INSERT INTO `ts_modules` VALUES (34, 1, 1, 0x6174746163686d656e7473, 0x616370, 11, 95, 96, 0x4143505f4d414e4147455f455854454e53494f4e53, 0x657874656e73696f6e73, 0x61636c5f615f617474616368);
INSERT INTO `ts_modules` VALUES (35, 1, 1, 0x6174746163686d656e7473, 0x616370, 11, 97, 98, 0x4143505f455854454e53494f4e5f47524f555053, 0x6578745f67726f757073, 0x61636c5f615f617474616368);
INSERT INTO `ts_modules` VALUES (36, 1, 1, 0x6174746163686d656e7473, 0x616370, 11, 99, 100, 0x4143505f4f525048414e5f4154544143484d454e5453, 0x6f727068616e, 0x61636c5f615f617474616368);
INSERT INTO `ts_modules` VALUES (37, 1, 1, 0x62616e, 0x616370, 15, 145, 146, 0x4143505f42414e5f454d41494c53, 0x656d61696c, 0x61636c5f615f62616e);
INSERT INTO `ts_modules` VALUES (38, 1, 1, 0x62616e, 0x616370, 15, 147, 148, 0x4143505f42414e5f495053, 0x6970, 0x61636c5f615f62616e);
INSERT INTO `ts_modules` VALUES (39, 1, 1, 0x62616e, 0x616370, 15, 149, 150, 0x4143505f42414e5f555345524e414d4553, 0x75736572, 0x61636c5f615f62616e);
INSERT INTO `ts_modules` VALUES (40, 1, 1, 0x6262636f646573, 0x616370, 10, 81, 82, 0x4143505f4242434f444553, 0x6262636f646573, 0x61636c5f615f6262636f6465);
INSERT INTO `ts_modules` VALUES (41, 1, 1, 0x626f617264, 0x616370, 3, 21, 22, 0x4143505f424f4152445f53455454494e4753, 0x73657474696e6773, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (42, 1, 1, 0x626f617264, 0x616370, 3, 23, 24, 0x4143505f424f4152445f4645415455524553, 0x6665617475726573, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (43, 1, 1, 0x626f617264, 0x616370, 3, 25, 26, 0x4143505f4156415441525f53455454494e4753, 0x617661746172, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (44, 1, 1, 0x626f617264, 0x616370, 3, 27, 28, 0x4143505f4d4553534147455f53455454494e4753, 0x6d657373616765, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (45, 1, 1, 0x626f617264, 0x616370, 10, 83, 84, 0x4143505f4d4553534147455f53455454494e4753, 0x6d657373616765, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (46, 1, 1, 0x626f617264, 0x616370, 3, 29, 30, 0x4143505f504f53545f53455454494e4753, 0x706f7374, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (47, 1, 1, 0x626f617264, 0x616370, 3, 31, 32, 0x4143505f5349474e41545552455f53455454494e4753, 0x7369676e6174757265, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (48, 1, 1, 0x626f617264, 0x616370, 3, 33, 34, 0x4143505f52454749535445525f53455454494e4753, 0x726567697374726174696f6e, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (49, 1, 1, 0x626f617264, 0x616370, 4, 41, 42, 0x4143505f415554485f53455454494e4753, 0x61757468, 0x61636c5f615f736572766572);
INSERT INTO `ts_modules` VALUES (50, 1, 1, 0x626f617264, 0x616370, 4, 43, 44, 0x4143505f454d41494c5f53455454494e4753, 0x656d61696c, 0x61636c5f615f736572766572);
INSERT INTO `ts_modules` VALUES (51, 1, 1, 0x626f617264, 0x616370, 5, 49, 50, 0x4143505f434f4f4b49455f53455454494e4753, 0x636f6f6b6965, 0x61636c5f615f736572766572);
INSERT INTO `ts_modules` VALUES (52, 1, 1, 0x626f617264, 0x616370, 5, 51, 52, 0x4143505f5345525645525f53455454494e4753, 0x736572766572, 0x61636c5f615f736572766572);
INSERT INTO `ts_modules` VALUES (53, 1, 1, 0x626f617264, 0x616370, 5, 53, 54, 0x4143505f53454355524954595f53455454494e4753, 0x7365637572697479, 0x61636c5f615f736572766572);
INSERT INTO `ts_modules` VALUES (54, 1, 1, 0x626f617264, 0x616370, 5, 55, 56, 0x4143505f4c4f41445f53455454494e4753, 0x6c6f6164, 0x61636c5f615f736572766572);
INSERT INTO `ts_modules` VALUES (55, 1, 1, 0x626f7473, 0x616370, 29, 245, 246, 0x4143505f424f5453, 0x626f7473, 0x61636c5f615f626f7473);
INSERT INTO `ts_modules` VALUES (56, 1, 1, 0x63617074636861, 0x616370, 3, 35, 36, 0x4143505f56435f53455454494e4753, 0x76697375616c, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (57, 1, 0, 0x63617074636861, 0x616370, 3, 37, 38, 0x4143505f56435f434150544348415f444953504c4159, 0x696d67, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (58, 1, 1, 0x6461746162617365, 0x616370, 26, 231, 232, 0x4143505f4241434b5550, 0x6261636b7570, 0x61636c5f615f6261636b7570);
INSERT INTO `ts_modules` VALUES (59, 1, 1, 0x6461746162617365, 0x616370, 26, 233, 234, 0x4143505f524553544f5245, 0x726573746f7265, 0x61636c5f615f6261636b7570);
INSERT INTO `ts_modules` VALUES (60, 1, 1, 0x646973616c6c6f77, 0x616370, 15, 151, 152, 0x4143505f444953414c4c4f575f555345524e414d4553, 0x757365726e616d6573, 0x61636c5f615f6e616d6573);
INSERT INTO `ts_modules` VALUES (61, 1, 1, 0x656d61696c, 0x616370, 29, 247, 248, 0x4143505f4d4153535f454d41494c, 0x656d61696c, 0x61636c5f615f656d61696c202626206366675f656d61696c5f656e61626c65);
INSERT INTO `ts_modules` VALUES (62, 1, 1, 0x666f72756d73, 0x616370, 7, 63, 64, 0x4143505f4d414e4147455f464f52554d53, 0x6d616e616765, 0x61636c5f615f666f72756d);
INSERT INTO `ts_modules` VALUES (63, 1, 1, 0x67726f757073, 0x616370, 14, 137, 138, 0x4143505f47524f5550535f4d414e414745, 0x6d616e616765, 0x61636c5f615f67726f7570);
INSERT INTO `ts_modules` VALUES (64, 1, 1, 0x69636f6e73, 0x616370, 10, 85, 86, 0x4143505f49434f4e53, 0x69636f6e73, 0x61636c5f615f69636f6e73);
INSERT INTO `ts_modules` VALUES (65, 1, 1, 0x69636f6e73, 0x616370, 10, 87, 88, 0x4143505f534d494c494553, 0x736d696c696573, 0x61636c5f615f69636f6e73);
INSERT INTO `ts_modules` VALUES (66, 1, 1, 0x696e616374697665, 0x616370, 13, 107, 108, 0x4143505f494e4143544956455f5553455253, 0x6c697374, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (67, 1, 1, 0x6a6162626572, 0x616370, 4, 45, 46, 0x4143505f4a41424245525f53455454494e4753, 0x73657474696e6773, 0x61636c5f615f6a6162626572);
INSERT INTO `ts_modules` VALUES (68, 1, 1, 0x6c616e6775616765, 0x616370, 29, 249, 250, 0x4143505f4c414e47554147455f5041434b53, 0x6c616e675f7061636b73, 0x61636c5f615f6c616e6775616765);
INSERT INTO `ts_modules` VALUES (69, 1, 1, 0x6c6f6773, 0x616370, 25, 221, 222, 0x4143505f41444d494e5f4c4f4753, 0x61646d696e, 0x61636c5f615f766965776c6f6773);
INSERT INTO `ts_modules` VALUES (70, 1, 1, 0x6c6f6773, 0x616370, 25, 223, 224, 0x4143505f4d4f445f4c4f4753, 0x6d6f64, 0x61636c5f615f766965776c6f6773);
INSERT INTO `ts_modules` VALUES (71, 1, 1, 0x6c6f6773, 0x616370, 25, 225, 226, 0x4143505f55534552535f4c4f4753, 0x7573657273, 0x61636c5f615f766965776c6f6773);
INSERT INTO `ts_modules` VALUES (72, 1, 1, 0x6c6f6773, 0x616370, 25, 227, 228, 0x4143505f435249544943414c5f4c4f4753, 0x637269746963616c, 0x61636c5f615f766965776c6f6773);
INSERT INTO `ts_modules` VALUES (73, 1, 1, 0x6d61696e, 0x616370, 1, 2, 3, 0x4143505f494e444558, 0x6d61696e, '');
INSERT INTO `ts_modules` VALUES (74, 1, 1, 0x6d6f64756c6573, 0x616370, 30, 257, 258, 0x414350, 0x616370, 0x61636c5f615f6d6f64756c6573);
INSERT INTO `ts_modules` VALUES (75, 1, 1, 0x6d6f64756c6573, 0x616370, 30, 259, 260, 0x554350, 0x756370, 0x61636c5f615f6d6f64756c6573);
INSERT INTO `ts_modules` VALUES (76, 1, 1, 0x6d6f64756c6573, 0x616370, 30, 261, 262, 0x4d4350, 0x6d6370, 0x61636c5f615f6d6f64756c6573);
INSERT INTO `ts_modules` VALUES (77, 1, 1, 0x7065726d697373696f6e5f726f6c6573, 0x616370, 19, 181, 182, 0x4143505f41444d494e5f524f4c4553, 0x61646d696e5f726f6c6573, 0x61636c5f615f726f6c65732026262061636c5f615f6161757468);
INSERT INTO `ts_modules` VALUES (78, 1, 1, 0x7065726d697373696f6e5f726f6c6573, 0x616370, 19, 183, 184, 0x4143505f555345525f524f4c4553, 0x757365725f726f6c6573, 0x61636c5f615f726f6c65732026262061636c5f615f7561757468);
INSERT INTO `ts_modules` VALUES (79, 1, 1, 0x7065726d697373696f6e5f726f6c6573, 0x616370, 19, 185, 186, 0x4143505f4d4f445f524f4c4553, 0x6d6f645f726f6c6573, 0x61636c5f615f726f6c65732026262061636c5f615f6d61757468);
INSERT INTO `ts_modules` VALUES (80, 1, 1, 0x7065726d697373696f6e5f726f6c6573, 0x616370, 19, 187, 188, 0x4143505f464f52554d5f524f4c4553, 0x666f72756d5f726f6c6573, 0x61636c5f615f726f6c65732026262061636c5f615f6661757468);
INSERT INTO `ts_modules` VALUES (81, 1, 1, 0x7065726d697373696f6e73, 0x616370, 16, 158, 159, 0x4143505f5045524d495353494f4e53, 0x696e74726f, 0x61636c5f615f617574687573657273207c7c2061636c5f615f6175746867726f757073207c7c2061636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (82, 1, 0, 0x7065726d697373696f6e73, 0x616370, 20, 191, 192, 0x4143505f5045524d495353494f4e5f5452414345, 0x7472616365, 0x61636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (83, 1, 1, 0x7065726d697373696f6e73, 0x616370, 18, 171, 172, 0x4143505f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f666f72756d5f6c6f63616c, 0x61636c5f615f6661757468202626202861636c5f615f617574687573657273207c7c2061636c5f615f6175746867726f75707329);
INSERT INTO `ts_modules` VALUES (84, 1, 1, 0x7065726d697373696f6e73, 0x616370, 18, 173, 174, 0x4143505f464f52554d5f4d4f44455241544f5253, 0x73657474696e675f6d6f645f6c6f63616c, 0x61636c5f615f6d61757468202626202861636c5f615f617574687573657273207c7c2061636c5f615f6175746867726f75707329);
INSERT INTO `ts_modules` VALUES (85, 1, 1, 0x7065726d697373696f6e73, 0x616370, 17, 161, 162, 0x4143505f55534552535f5045524d495353494f4e53, 0x73657474696e675f757365725f676c6f62616c, 0x61636c5f615f617574687573657273202626202861636c5f615f6161757468207c7c2061636c5f615f6d61757468207c7c2061636c5f615f756175746829);
INSERT INTO `ts_modules` VALUES (86, 1, 1, 0x7065726d697373696f6e73, 0x616370, 13, 109, 110, 0x4143505f55534552535f5045524d495353494f4e53, 0x73657474696e675f757365725f676c6f62616c, 0x61636c5f615f617574687573657273202626202861636c5f615f6161757468207c7c2061636c5f615f6d61757468207c7c2061636c5f615f756175746829);
INSERT INTO `ts_modules` VALUES (87, 1, 1, 0x7065726d697373696f6e73, 0x616370, 18, 175, 176, 0x4143505f55534552535f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f757365725f6c6f63616c, 0x61636c5f615f617574687573657273202626202861636c5f615f6d61757468207c7c2061636c5f615f666175746829);
INSERT INTO `ts_modules` VALUES (88, 1, 1, 0x7065726d697373696f6e73, 0x616370, 13, 111, 112, 0x4143505f55534552535f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f757365725f6c6f63616c, 0x61636c5f615f617574687573657273202626202861636c5f615f6d61757468207c7c2061636c5f615f666175746829);
INSERT INTO `ts_modules` VALUES (89, 1, 1, 0x7065726d697373696f6e73, 0x616370, 17, 163, 164, 0x4143505f47524f5550535f5045524d495353494f4e53, 0x73657474696e675f67726f75705f676c6f62616c, 0x61636c5f615f6175746867726f757073202626202861636c5f615f6161757468207c7c2061636c5f615f6d61757468207c7c2061636c5f615f756175746829);
INSERT INTO `ts_modules` VALUES (90, 1, 1, 0x7065726d697373696f6e73, 0x616370, 14, 139, 140, 0x4143505f47524f5550535f5045524d495353494f4e53, 0x73657474696e675f67726f75705f676c6f62616c, 0x61636c5f615f6175746867726f757073202626202861636c5f615f6161757468207c7c2061636c5f615f6d61757468207c7c2061636c5f615f756175746829);
INSERT INTO `ts_modules` VALUES (91, 1, 1, 0x7065726d697373696f6e73, 0x616370, 18, 177, 178, 0x4143505f47524f5550535f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f67726f75705f6c6f63616c, 0x61636c5f615f6175746867726f757073202626202861636c5f615f6d61757468207c7c2061636c5f615f666175746829);
INSERT INTO `ts_modules` VALUES (92, 1, 1, 0x7065726d697373696f6e73, 0x616370, 14, 141, 142, 0x4143505f47524f5550535f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f67726f75705f6c6f63616c, 0x61636c5f615f6175746867726f757073202626202861636c5f615f6d61757468207c7c2061636c5f615f666175746829);
INSERT INTO `ts_modules` VALUES (93, 1, 1, 0x7065726d697373696f6e73, 0x616370, 17, 165, 166, 0x4143505f41444d494e4953545241544f5253, 0x73657474696e675f61646d696e5f676c6f62616c, 0x61636c5f615f6161757468202626202861636c5f615f617574687573657273207c7c2061636c5f615f6175746867726f75707329);
INSERT INTO `ts_modules` VALUES (94, 1, 1, 0x7065726d697373696f6e73, 0x616370, 17, 167, 168, 0x4143505f474c4f42414c5f4d4f44455241544f5253, 0x73657474696e675f6d6f645f676c6f62616c, 0x61636c5f615f6d61757468202626202861636c5f615f617574687573657273207c7c2061636c5f615f6175746867726f75707329);
INSERT INTO `ts_modules` VALUES (95, 1, 1, 0x7065726d697373696f6e73, 0x616370, 20, 193, 194, 0x4143505f564945575f41444d494e5f5045524d495353494f4e53, 0x766965775f61646d696e5f676c6f62616c, 0x61636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (96, 1, 1, 0x7065726d697373696f6e73, 0x616370, 20, 195, 196, 0x4143505f564945575f555345525f5045524d495353494f4e53, 0x766965775f757365725f676c6f62616c, 0x61636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (97, 1, 1, 0x7065726d697373696f6e73, 0x616370, 20, 197, 198, 0x4143505f564945575f474c4f42414c5f4d4f445f5045524d495353494f4e53, 0x766965775f6d6f645f676c6f62616c, 0x61636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (98, 1, 1, 0x7065726d697373696f6e73, 0x616370, 20, 199, 200, 0x4143505f564945575f464f52554d5f4d4f445f5045524d495353494f4e53, 0x766965775f6d6f645f6c6f63616c, 0x61636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (99, 1, 1, 0x7065726d697373696f6e73, 0x616370, 20, 201, 202, 0x4143505f564945575f464f52554d5f5045524d495353494f4e53, 0x766965775f666f72756d5f6c6f63616c, 0x61636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (100, 1, 1, 0x7068705f696e666f, 0x616370, 29, 251, 252, 0x4143505f5048505f494e464f, 0x696e666f, 0x61636c5f615f706870696e666f);
INSERT INTO `ts_modules` VALUES (101, 1, 1, 0x70726f66696c65, 0x616370, 13, 113, 114, 0x4143505f435553544f4d5f50524f46494c455f4649454c4453, 0x70726f66696c65, 0x61636c5f615f70726f66696c65);
INSERT INTO `ts_modules` VALUES (102, 1, 1, 0x7072756e65, 0x616370, 7, 65, 66, 0x4143505f5052554e455f464f52554d53, 0x666f72756d73, 0x61636c5f615f7072756e65);
INSERT INTO `ts_modules` VALUES (103, 1, 1, 0x7072756e65, 0x616370, 15, 153, 154, 0x4143505f5052554e455f5553455253, 0x7573657273, 0x61636c5f615f7573657264656c);
INSERT INTO `ts_modules` VALUES (104, 1, 1, 0x72616e6b73, 0x616370, 13, 115, 116, 0x4143505f4d414e4147455f52414e4b53, 0x72616e6b73, 0x61636c5f615f72616e6b73);
INSERT INTO `ts_modules` VALUES (105, 1, 1, 0x726561736f6e73, 0x616370, 29, 253, 254, 0x4143505f4d414e4147455f524541534f4e53, 0x6d61696e, 0x61636c5f615f726561736f6e73);
INSERT INTO `ts_modules` VALUES (106, 1, 1, 0x736561726368, 0x616370, 5, 57, 58, 0x4143505f5345415243485f53455454494e4753, 0x73657474696e6773, 0x61636c5f615f736561726368);
INSERT INTO `ts_modules` VALUES (107, 1, 1, 0x736561726368, 0x616370, 26, 235, 236, 0x4143505f5345415243485f494e444558, 0x696e646578, 0x61636c5f615f736561726368);
INSERT INTO `ts_modules` VALUES (108, 1, 1, 0x7374796c6573, 0x616370, 22, 207, 208, 0x4143505f5354594c4553, 0x7374796c65, 0x61636c5f615f7374796c6573);
INSERT INTO `ts_modules` VALUES (109, 1, 1, 0x7374796c6573, 0x616370, 23, 211, 212, 0x4143505f54454d504c41544553, 0x74656d706c617465, 0x61636c5f615f7374796c6573);
INSERT INTO `ts_modules` VALUES (110, 1, 1, 0x7374796c6573, 0x616370, 23, 213, 214, 0x4143505f5448454d4553, 0x7468656d65, 0x61636c5f615f7374796c6573);
INSERT INTO `ts_modules` VALUES (111, 1, 1, 0x7374796c6573, 0x616370, 23, 215, 216, 0x4143505f494d41474553455453, 0x696d616765736574, 0x61636c5f615f7374796c6573);
INSERT INTO `ts_modules` VALUES (112, 1, 1, 0x757064617465, 0x616370, 28, 241, 242, 0x4143505f56455253494f4e5f434845434b, 0x76657273696f6e5f636865636b, 0x61636c5f615f626f617264);
INSERT INTO `ts_modules` VALUES (113, 1, 1, 0x7573657273, 0x616370, 13, 105, 106, 0x4143505f4d414e4147455f5553455253, 0x6f76657276696577, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (114, 1, 0, 0x7573657273, 0x616370, 13, 117, 118, 0x4143505f555345525f464545444241434b, 0x666565646261636b, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (115, 1, 0, 0x7573657273, 0x616370, 13, 119, 120, 0x4143505f555345525f50524f46494c45, 0x70726f66696c65, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (116, 1, 0, 0x7573657273, 0x616370, 13, 121, 122, 0x4143505f555345525f5052454653, 0x7072656673, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (117, 1, 0, 0x7573657273, 0x616370, 13, 123, 124, 0x4143505f555345525f415641544152, 0x617661746172, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (118, 1, 0, 0x7573657273, 0x616370, 13, 125, 126, 0x4143505f555345525f52414e4b, 0x72616e6b, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (119, 1, 0, 0x7573657273, 0x616370, 13, 127, 128, 0x4143505f555345525f534947, 0x736967, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (120, 1, 0, 0x7573657273, 0x616370, 13, 129, 130, 0x4143505f555345525f47524f555053, 0x67726f757073, 0x61636c5f615f757365722026262061636c5f615f67726f7570);
INSERT INTO `ts_modules` VALUES (121, 1, 0, 0x7573657273, 0x616370, 13, 131, 132, 0x4143505f555345525f5045524d, 0x7065726d, 0x61636c5f615f757365722026262061636c5f615f7669657761757468);
INSERT INTO `ts_modules` VALUES (122, 1, 0, 0x7573657273, 0x616370, 13, 133, 134, 0x4143505f555345525f415454414348, 0x617474616368, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (123, 1, 1, 0x776f726473, 0x616370, 10, 89, 90, 0x4143505f574f524453, 0x776f726473, 0x61636c5f615f776f726473);
INSERT INTO `ts_modules` VALUES (124, 1, 1, 0x7573657273, 0x616370, 2, 5, 6, 0x4143505f4d414e4147455f5553455253, 0x6f76657276696577, 0x61636c5f615f75736572);
INSERT INTO `ts_modules` VALUES (125, 1, 1, 0x67726f757073, 0x616370, 2, 7, 8, 0x4143505f47524f5550535f4d414e414745, 0x6d616e616765, 0x61636c5f615f67726f7570);
INSERT INTO `ts_modules` VALUES (126, 1, 1, 0x666f72756d73, 0x616370, 2, 9, 10, 0x4143505f4d414e4147455f464f52554d53, 0x6d616e616765, 0x61636c5f615f666f72756d);
INSERT INTO `ts_modules` VALUES (127, 1, 1, 0x6c6f6773, 0x616370, 2, 11, 12, 0x4143505f4d4f445f4c4f4753, 0x6d6f64, 0x61636c5f615f766965776c6f6773);
INSERT INTO `ts_modules` VALUES (128, 1, 1, 0x626f7473, 0x616370, 2, 13, 14, 0x4143505f424f5453, 0x626f7473, 0x61636c5f615f626f7473);
INSERT INTO `ts_modules` VALUES (129, 1, 1, 0x7068705f696e666f, 0x616370, 2, 15, 16, 0x4143505f5048505f494e464f, 0x696e666f, 0x61636c5f615f706870696e666f);
INSERT INTO `ts_modules` VALUES (130, 1, 1, 0x7065726d697373696f6e73, 0x616370, 8, 69, 70, 0x4143505f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f666f72756d5f6c6f63616c, 0x61636c5f615f6661757468202626202861636c5f615f617574687573657273207c7c2061636c5f615f6175746867726f75707329);
INSERT INTO `ts_modules` VALUES (131, 1, 1, 0x7065726d697373696f6e73, 0x616370, 8, 71, 72, 0x4143505f464f52554d5f4d4f44455241544f5253, 0x73657474696e675f6d6f645f6c6f63616c, 0x61636c5f615f6d61757468202626202861636c5f615f617574687573657273207c7c2061636c5f615f6175746867726f75707329);
INSERT INTO `ts_modules` VALUES (132, 1, 1, 0x7065726d697373696f6e73, 0x616370, 8, 73, 74, 0x4143505f55534552535f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f757365725f6c6f63616c, 0x61636c5f615f617574687573657273202626202861636c5f615f6d61757468207c7c2061636c5f615f666175746829);
INSERT INTO `ts_modules` VALUES (133, 1, 1, 0x7065726d697373696f6e73, 0x616370, 8, 75, 76, 0x4143505f47524f5550535f464f52554d5f5045524d495353494f4e53, 0x73657474696e675f67726f75705f6c6f63616c, 0x61636c5f615f6175746867726f757073202626202861636c5f615f6d61757468207c7c2061636c5f615f666175746829);
INSERT INTO `ts_modules` VALUES (134, 1, 1, '', 0x6d6370, 0, 1, 10, 0x4d43505f4d41494e, '', '');
INSERT INTO `ts_modules` VALUES (135, 1, 1, '', 0x6d6370, 0, 11, 18, 0x4d43505f5155455545, '', '');
INSERT INTO `ts_modules` VALUES (136, 1, 1, '', 0x6d6370, 0, 19, 26, 0x4d43505f5245504f525453, '', '');
INSERT INTO `ts_modules` VALUES (137, 1, 1, '', 0x6d6370, 0, 27, 32, 0x4d43505f4e4f544553, '', '');
INSERT INTO `ts_modules` VALUES (138, 1, 1, '', 0x6d6370, 0, 33, 42, 0x4d43505f5741524e, '', '');
INSERT INTO `ts_modules` VALUES (139, 1, 1, '', 0x6d6370, 0, 43, 50, 0x4d43505f4c4f4753, '', '');
INSERT INTO `ts_modules` VALUES (140, 1, 1, '', 0x6d6370, 0, 51, 58, 0x4d43505f42414e, '', '');
INSERT INTO `ts_modules` VALUES (141, 1, 1, 0x62616e, 0x6d6370, 140, 52, 53, 0x4d43505f42414e5f555345524e414d4553, 0x75736572, 0x61636c5f6d5f62616e);
INSERT INTO `ts_modules` VALUES (142, 1, 1, 0x62616e, 0x6d6370, 140, 54, 55, 0x4d43505f42414e5f495053, 0x6970, 0x61636c5f6d5f62616e);
INSERT INTO `ts_modules` VALUES (143, 1, 1, 0x62616e, 0x6d6370, 140, 56, 57, 0x4d43505f42414e5f454d41494c53, 0x656d61696c, 0x61636c5f6d5f62616e);
INSERT INTO `ts_modules` VALUES (144, 1, 1, 0x6c6f6773, 0x6d6370, 139, 44, 45, 0x4d43505f4c4f47535f46524f4e54, 0x66726f6e74, 0x61636c5f6d5f207c7c2061636c665f6d5f);
INSERT INTO `ts_modules` VALUES (145, 1, 1, 0x6c6f6773, 0x6d6370, 139, 46, 47, 0x4d43505f4c4f47535f464f52554d5f56494557, 0x666f72756d5f6c6f6773, 0x61636c5f6d5f2c246964);
INSERT INTO `ts_modules` VALUES (146, 1, 1, 0x6c6f6773, 0x6d6370, 139, 48, 49, 0x4d43505f4c4f47535f544f5049435f56494557, 0x746f7069635f6c6f6773, 0x61636c5f6d5f2c246964);
INSERT INTO `ts_modules` VALUES (147, 1, 1, 0x6d61696e, 0x6d6370, 134, 2, 3, 0x4d43505f4d41494e5f46524f4e54, 0x66726f6e74, '');
INSERT INTO `ts_modules` VALUES (148, 1, 1, 0x6d61696e, 0x6d6370, 134, 4, 5, 0x4d43505f4d41494e5f464f52554d5f56494557, 0x666f72756d5f76696577, 0x61636c5f6d5f2c246964);
INSERT INTO `ts_modules` VALUES (149, 1, 1, 0x6d61696e, 0x6d6370, 134, 6, 7, 0x4d43505f4d41494e5f544f5049435f56494557, 0x746f7069635f76696577, 0x61636c5f6d5f2c246964);
INSERT INTO `ts_modules` VALUES (150, 1, 1, 0x6d61696e, 0x6d6370, 134, 8, 9, 0x4d43505f4d41494e5f504f53545f44455441494c53, 0x706f73745f64657461696c73, 0x61636c5f6d5f2c246964207c7c2028212469642026262061636c665f6d5f29);
INSERT INTO `ts_modules` VALUES (151, 1, 1, 0x6e6f746573, 0x6d6370, 137, 28, 29, 0x4d43505f4e4f5445535f46524f4e54, 0x66726f6e74, '');
INSERT INTO `ts_modules` VALUES (152, 1, 1, 0x6e6f746573, 0x6d6370, 137, 30, 31, 0x4d43505f4e4f5445535f55534552, 0x757365725f6e6f746573, '');
INSERT INTO `ts_modules` VALUES (153, 1, 1, 0x7175657565, 0x6d6370, 135, 12, 13, 0x4d43505f51554555455f554e415050524f5645445f544f50494353, 0x756e617070726f7665645f746f70696373, 0x61636c665f6d5f617070726f7665);
INSERT INTO `ts_modules` VALUES (154, 1, 1, 0x7175657565, 0x6d6370, 135, 14, 15, 0x4d43505f51554555455f554e415050524f5645445f504f535453, 0x756e617070726f7665645f706f737473, 0x61636c665f6d5f617070726f7665);
INSERT INTO `ts_modules` VALUES (155, 1, 1, 0x7175657565, 0x6d6370, 135, 16, 17, 0x4d43505f51554555455f415050524f56455f44455441494c53, 0x617070726f76655f64657461696c73, 0x61636c5f6d5f617070726f76652c246964207c7c2028212469642026262061636c665f6d5f617070726f766529);
INSERT INTO `ts_modules` VALUES (156, 1, 1, 0x7265706f727473, 0x6d6370, 136, 20, 21, 0x4d43505f5245504f5254535f4f50454e, 0x7265706f727473, 0x61636c665f6d5f7265706f7274);
INSERT INTO `ts_modules` VALUES (157, 1, 1, 0x7265706f727473, 0x6d6370, 136, 22, 23, 0x4d43505f5245504f5254535f434c4f534544, 0x7265706f7274735f636c6f736564, 0x61636c665f6d5f7265706f7274);
INSERT INTO `ts_modules` VALUES (158, 1, 1, 0x7265706f727473, 0x6d6370, 136, 24, 25, 0x4d43505f5245504f52545f44455441494c53, 0x7265706f72745f64657461696c73, 0x61636c5f6d5f7265706f72742c246964207c7c2028212469642026262061636c665f6d5f7265706f727429);
INSERT INTO `ts_modules` VALUES (159, 1, 1, 0x7761726e, 0x6d6370, 138, 34, 35, 0x4d43505f5741524e5f46524f4e54, 0x66726f6e74, 0x61636c665f6d5f7761726e);
INSERT INTO `ts_modules` VALUES (160, 1, 1, 0x7761726e, 0x6d6370, 138, 36, 37, 0x4d43505f5741524e5f4c495354, 0x6c697374, 0x61636c665f6d5f7761726e);
INSERT INTO `ts_modules` VALUES (161, 1, 1, 0x7761726e, 0x6d6370, 138, 38, 39, 0x4d43505f5741524e5f55534552, 0x7761726e5f75736572, 0x61636c665f6d5f7761726e);
INSERT INTO `ts_modules` VALUES (162, 1, 1, 0x7761726e, 0x6d6370, 138, 40, 41, 0x4d43505f5741524e5f504f5354, 0x7761726e5f706f7374, 0x61636c5f6d5f7761726e2026262061636c5f665f726561642c246964);
INSERT INTO `ts_modules` VALUES (163, 1, 1, '', 0x756370, 0, 1, 12, 0x5543505f4d41494e, '', '');
INSERT INTO `ts_modules` VALUES (164, 1, 1, '', 0x756370, 0, 13, 22, 0x5543505f50524f46494c45, '', '');
INSERT INTO `ts_modules` VALUES (165, 1, 1, '', 0x756370, 0, 23, 30, 0x5543505f5052454653, '', '');
INSERT INTO `ts_modules` VALUES (166, 1, 1, '', 0x756370, 0, 31, 42, 0x5543505f504d, '', '');
INSERT INTO `ts_modules` VALUES (167, 1, 1, '', 0x756370, 0, 43, 48, 0x5543505f5553455247524f555053, '', '');
INSERT INTO `ts_modules` VALUES (168, 1, 1, '', 0x756370, 0, 49, 54, 0x5543505f5a45425241, '', '');
INSERT INTO `ts_modules` VALUES (169, 1, 1, 0x6174746163686d656e7473, 0x756370, 163, 10, 11, 0x5543505f4d41494e5f4154544143484d454e5453, 0x6174746163686d656e7473, 0x61636c5f755f617474616368);
INSERT INTO `ts_modules` VALUES (170, 1, 1, 0x67726f757073, 0x756370, 167, 44, 45, 0x5543505f5553455247524f5550535f4d454d424552, 0x6d656d62657273686970, '');
INSERT INTO `ts_modules` VALUES (171, 1, 1, 0x67726f757073, 0x756370, 167, 46, 47, 0x5543505f5553455247524f5550535f4d414e414745, 0x6d616e616765, '');
INSERT INTO `ts_modules` VALUES (172, 1, 1, 0x6d61696e, 0x756370, 163, 2, 3, 0x5543505f4d41494e5f46524f4e54, 0x66726f6e74, '');
INSERT INTO `ts_modules` VALUES (173, 1, 1, 0x6d61696e, 0x756370, 163, 4, 5, 0x5543505f4d41494e5f53554253435249424544, 0x73756273637269626564, '');
INSERT INTO `ts_modules` VALUES (174, 1, 1, 0x6d61696e, 0x756370, 163, 6, 7, 0x5543505f4d41494e5f424f4f4b4d41524b53, 0x626f6f6b6d61726b73, 0x6366675f616c6c6f775f626f6f6b6d61726b73);
INSERT INTO `ts_modules` VALUES (175, 1, 1, 0x6d61696e, 0x756370, 163, 8, 9, 0x5543505f4d41494e5f445241465453, 0x647261667473, '');
INSERT INTO `ts_modules` VALUES (176, 1, 0, 0x706d, 0x756370, 166, 32, 33, 0x5543505f504d5f56494557, 0x76696577, 0x6366675f616c6c6f775f707269766d7367);
INSERT INTO `ts_modules` VALUES (177, 1, 1, 0x706d, 0x756370, 166, 34, 35, 0x5543505f504d5f434f4d504f5345, 0x636f6d706f7365, 0x6366675f616c6c6f775f707269766d7367);
INSERT INTO `ts_modules` VALUES (178, 1, 1, 0x706d, 0x756370, 166, 36, 37, 0x5543505f504d5f445241465453, 0x647261667473, 0x6366675f616c6c6f775f707269766d7367);
INSERT INTO `ts_modules` VALUES (179, 1, 1, 0x706d, 0x756370, 166, 38, 39, 0x5543505f504d5f4f5054494f4e53, 0x6f7074696f6e73, 0x6366675f616c6c6f775f707269766d7367);
INSERT INTO `ts_modules` VALUES (180, 1, 0, 0x706d, 0x756370, 166, 40, 41, 0x5543505f504d5f504f5055505f5449544c45, 0x706f707570, 0x6366675f616c6c6f775f707269766d7367);
INSERT INTO `ts_modules` VALUES (181, 1, 1, 0x7072656673, 0x756370, 165, 24, 25, 0x5543505f50524546535f504552534f4e414c, 0x706572736f6e616c, '');
INSERT INTO `ts_modules` VALUES (182, 1, 1, 0x7072656673, 0x756370, 165, 26, 27, 0x5543505f50524546535f504f5354, 0x706f7374, '');
INSERT INTO `ts_modules` VALUES (183, 1, 1, 0x7072656673, 0x756370, 165, 28, 29, 0x5543505f50524546535f56494557, 0x76696577, '');
INSERT INTO `ts_modules` VALUES (184, 1, 1, 0x70726f66696c65, 0x756370, 164, 14, 15, 0x5543505f50524f46494c455f50524f46494c455f494e464f, 0x70726f66696c655f696e666f, '');
INSERT INTO `ts_modules` VALUES (185, 1, 1, 0x70726f66696c65, 0x756370, 164, 16, 17, 0x5543505f50524f46494c455f5349474e4154555245, 0x7369676e6174757265, '');
INSERT INTO `ts_modules` VALUES (186, 1, 1, 0x70726f66696c65, 0x756370, 164, 18, 19, 0x5543505f50524f46494c455f415641544152, 0x617661746172, '');
INSERT INTO `ts_modules` VALUES (187, 1, 1, 0x70726f66696c65, 0x756370, 164, 20, 21, 0x5543505f50524f46494c455f5245475f44455441494c53, 0x7265675f64657461696c73, '');
INSERT INTO `ts_modules` VALUES (188, 1, 1, 0x7a65627261, 0x756370, 168, 50, 51, 0x5543505f5a454252415f465249454e4453, 0x667269656e6473, '');
INSERT INTO `ts_modules` VALUES (189, 1, 1, 0x7a65627261, 0x756370, 168, 52, 53, 0x5543505f5a454252415f464f4553, 0x666f6573, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_poll_options`
-- 

CREATE TABLE `ts_poll_options` (
  `poll_option_id` tinyint(4) NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `poll_option_text` text collate utf8_bin NOT NULL,
  `poll_option_total` mediumint(8) unsigned NOT NULL default '0',
  KEY `poll_opt_id` (`poll_option_id`),
  KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_poll_options`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_poll_votes`
-- 

CREATE TABLE `ts_poll_votes` (
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `poll_option_id` tinyint(4) NOT NULL default '0',
  `vote_user_id` mediumint(8) unsigned NOT NULL default '0',
  `vote_user_ip` varchar(40) collate utf8_bin NOT NULL default '',
  KEY `topic_id` (`topic_id`),
  KEY `vote_user_id` (`vote_user_id`),
  KEY `vote_user_ip` (`vote_user_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_poll_votes`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_posts`
-- 

CREATE TABLE `ts_posts` (
  `post_id` mediumint(8) unsigned NOT NULL auto_increment,
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `poster_id` mediumint(8) unsigned NOT NULL default '0',
  `icon_id` mediumint(8) unsigned NOT NULL default '0',
  `poster_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `post_time` int(11) unsigned NOT NULL default '0',
  `post_approved` tinyint(1) unsigned NOT NULL default '1',
  `post_reported` tinyint(1) unsigned NOT NULL default '0',
  `enable_bbcode` tinyint(1) unsigned NOT NULL default '1',
  `enable_smilies` tinyint(1) unsigned NOT NULL default '1',
  `enable_magic_url` tinyint(1) unsigned NOT NULL default '1',
  `enable_sig` tinyint(1) unsigned NOT NULL default '1',
  `post_username` varchar(255) collate utf8_bin NOT NULL default '',
  `post_subject` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL default '',
  `post_text` mediumtext collate utf8_bin NOT NULL,
  `post_checksum` varchar(32) collate utf8_bin NOT NULL default '',
  `post_attachment` tinyint(1) unsigned NOT NULL default '0',
  `bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `bbcode_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `post_postcount` tinyint(1) unsigned NOT NULL default '1',
  `post_edit_time` int(11) unsigned NOT NULL default '0',
  `post_edit_reason` varchar(255) collate utf8_bin NOT NULL default '',
  `post_edit_user` mediumint(8) unsigned NOT NULL default '0',
  `post_edit_count` smallint(4) unsigned NOT NULL default '0',
  `post_edit_locked` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`post_id`),
  KEY `forum_id` (`forum_id`),
  KEY `topic_id` (`topic_id`),
  KEY `poster_ip` (`poster_ip`),
  KEY `poster_id` (`poster_id`),
  KEY `post_approved` (`post_approved`),
  KEY `tid_post_time` (`topic_id`,`post_time`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_posts`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_privmsgs`
-- 

CREATE TABLE `ts_privmsgs` (
  `msg_id` mediumint(8) unsigned NOT NULL auto_increment,
  `root_level` mediumint(8) unsigned NOT NULL default '0',
  `author_id` mediumint(8) unsigned NOT NULL default '0',
  `icon_id` mediumint(8) unsigned NOT NULL default '0',
  `author_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `message_time` int(11) unsigned NOT NULL default '0',
  `enable_bbcode` tinyint(1) unsigned NOT NULL default '1',
  `enable_smilies` tinyint(1) unsigned NOT NULL default '1',
  `enable_magic_url` tinyint(1) unsigned NOT NULL default '1',
  `enable_sig` tinyint(1) unsigned NOT NULL default '1',
  `message_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `message_text` mediumtext collate utf8_bin NOT NULL,
  `message_edit_reason` varchar(255) collate utf8_bin NOT NULL default '',
  `message_edit_user` mediumint(8) unsigned NOT NULL default '0',
  `message_attachment` tinyint(1) unsigned NOT NULL default '0',
  `bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `bbcode_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `message_edit_time` int(11) unsigned NOT NULL default '0',
  `message_edit_count` smallint(4) unsigned NOT NULL default '0',
  `to_address` text collate utf8_bin NOT NULL,
  `bcc_address` text collate utf8_bin NOT NULL,
  PRIMARY KEY  (`msg_id`),
  KEY `author_ip` (`author_ip`),
  KEY `message_time` (`message_time`),
  KEY `author_id` (`author_id`),
  KEY `root_level` (`root_level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_privmsgs`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_privmsgs_folder`
-- 

CREATE TABLE `ts_privmsgs_folder` (
  `folder_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `folder_name` varchar(255) collate utf8_bin NOT NULL default '',
  `pm_count` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`folder_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_privmsgs_folder`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_privmsgs_rules`
-- 

CREATE TABLE `ts_privmsgs_rules` (
  `rule_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `rule_check` mediumint(8) unsigned NOT NULL default '0',
  `rule_connection` mediumint(8) unsigned NOT NULL default '0',
  `rule_string` varchar(255) collate utf8_bin NOT NULL default '',
  `rule_user_id` mediumint(8) unsigned NOT NULL default '0',
  `rule_group_id` mediumint(8) unsigned NOT NULL default '0',
  `rule_action` mediumint(8) unsigned NOT NULL default '0',
  `rule_folder_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`rule_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_privmsgs_rules`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_privmsgs_to`
-- 

CREATE TABLE `ts_privmsgs_to` (
  `msg_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `author_id` mediumint(8) unsigned NOT NULL default '0',
  `pm_deleted` tinyint(1) unsigned NOT NULL default '0',
  `pm_new` tinyint(1) unsigned NOT NULL default '1',
  `pm_unread` tinyint(1) unsigned NOT NULL default '1',
  `pm_replied` tinyint(1) unsigned NOT NULL default '0',
  `pm_marked` tinyint(1) unsigned NOT NULL default '0',
  `pm_forwarded` tinyint(1) unsigned NOT NULL default '0',
  `folder_id` int(11) NOT NULL default '0',
  KEY `msg_id` (`msg_id`),
  KEY `author_id` (`author_id`),
  KEY `usr_flder_id` (`user_id`,`folder_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_privmsgs_to`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_profile_fields`
-- 

CREATE TABLE `ts_profile_fields` (
  `field_id` mediumint(8) unsigned NOT NULL auto_increment,
  `field_name` varchar(255) collate utf8_bin NOT NULL default '',
  `field_type` tinyint(4) NOT NULL default '0',
  `field_ident` varchar(20) collate utf8_bin NOT NULL default '',
  `field_length` varchar(20) collate utf8_bin NOT NULL default '',
  `field_minlen` varchar(255) collate utf8_bin NOT NULL default '',
  `field_maxlen` varchar(255) collate utf8_bin NOT NULL default '',
  `field_novalue` varchar(255) collate utf8_bin NOT NULL default '',
  `field_default_value` varchar(255) collate utf8_bin NOT NULL default '',
  `field_validation` varchar(20) collate utf8_bin NOT NULL default '',
  `field_required` tinyint(1) unsigned NOT NULL default '0',
  `field_show_on_reg` tinyint(1) unsigned NOT NULL default '0',
  `field_show_profile` tinyint(1) unsigned NOT NULL default '0',
  `field_hide` tinyint(1) unsigned NOT NULL default '0',
  `field_no_view` tinyint(1) unsigned NOT NULL default '0',
  `field_active` tinyint(1) unsigned NOT NULL default '0',
  `field_order` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`field_id`),
  KEY `fld_type` (`field_type`),
  KEY `fld_ordr` (`field_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_profile_fields`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_profile_fields_data`
-- 

CREATE TABLE `ts_profile_fields_data` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_profile_fields_data`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_profile_fields_lang`
-- 

CREATE TABLE `ts_profile_fields_lang` (
  `field_id` mediumint(8) unsigned NOT NULL default '0',
  `lang_id` mediumint(8) unsigned NOT NULL default '0',
  `option_id` mediumint(8) unsigned NOT NULL default '0',
  `field_type` tinyint(4) NOT NULL default '0',
  `lang_value` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`field_id`,`lang_id`,`option_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_profile_fields_lang`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_profile_lang`
-- 

CREATE TABLE `ts_profile_lang` (
  `field_id` mediumint(8) unsigned NOT NULL default '0',
  `lang_id` mediumint(8) unsigned NOT NULL default '0',
  `lang_name` varchar(255) collate utf8_bin NOT NULL default '',
  `lang_explain` text collate utf8_bin NOT NULL,
  `lang_default_value` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`field_id`,`lang_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_profile_lang`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_ranks`
-- 

CREATE TABLE `ts_ranks` (
  `rank_id` mediumint(8) unsigned NOT NULL auto_increment,
  `rank_title` varchar(255) collate utf8_bin NOT NULL default '',
  `rank_min` mediumint(8) unsigned NOT NULL default '0',
  `rank_special` tinyint(1) unsigned NOT NULL default '0',
  `rank_image` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`rank_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_ranks`
-- 

INSERT INTO `ts_ranks` VALUES (1, 0x536974652041646d696e, 0, 1, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_reports`
-- 

CREATE TABLE `ts_reports` (
  `report_id` mediumint(8) unsigned NOT NULL auto_increment,
  `reason_id` smallint(4) unsigned NOT NULL default '0',
  `post_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `user_notify` tinyint(1) unsigned NOT NULL default '0',
  `report_closed` tinyint(1) unsigned NOT NULL default '0',
  `report_time` int(11) unsigned NOT NULL default '0',
  `report_text` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`report_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_reports`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_reports_reasons`
-- 

CREATE TABLE `ts_reports_reasons` (
  `reason_id` smallint(4) unsigned NOT NULL auto_increment,
  `reason_title` varchar(255) collate utf8_bin NOT NULL default '',
  `reason_description` mediumtext collate utf8_bin NOT NULL,
  `reason_order` smallint(4) unsigned NOT NULL default '0',
  PRIMARY KEY  (`reason_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table `ts_reports_reasons`
-- 

INSERT INTO `ts_reports_reasons` VALUES (1, 0x776172657a, 0x54686520706f737420636f6e7461696e73206c696e6b7320746f20696c6c6567616c206f72207069726174656420736f6674776172652e, 1);
INSERT INTO `ts_reports_reasons` VALUES (2, 0x7370616d, 0x546865207265706f7274656420706f73742068617320746865206f6e6c7920707572706f736520746f2061647665727469736520666f7220612077656273697465206f7220616e6f746865722070726f647563742e, 2);
INSERT INTO `ts_reports_reasons` VALUES (3, 0x6f66665f746f706963, 0x546865207265706f7274656420706f7374206973206f666620746f7069632e, 3);
INSERT INTO `ts_reports_reasons` VALUES (4, 0x6f74686572, 0x546865207265706f7274656420706f737420646f6573206e6f742066697420696e746f20616e79206f746865722063617465676f72792c20706c656173652075736520746865206675727468657220696e666f726d6174696f6e206669656c642e, 4);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_search_results`
-- 

CREATE TABLE `ts_search_results` (
  `search_key` varchar(32) collate utf8_bin NOT NULL default '',
  `search_time` int(11) unsigned NOT NULL default '0',
  `search_keywords` mediumtext collate utf8_bin NOT NULL,
  `search_authors` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`search_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_search_results`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_search_wordlist`
-- 

CREATE TABLE `ts_search_wordlist` (
  `word_id` mediumint(8) unsigned NOT NULL auto_increment,
  `word_text` varchar(255) collate utf8_bin NOT NULL default '',
  `word_common` tinyint(1) unsigned NOT NULL default '0',
  `word_count` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`word_id`),
  UNIQUE KEY `wrd_txt` (`word_text`),
  KEY `wrd_cnt` (`word_count`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=59 ;

-- 
-- Dumping data for table `ts_search_wordlist`
-- 

INSERT INTO `ts_search_wordlist` VALUES (1, 0x74686973, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (2, 0x6578616d706c65, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (3, 0x706f7374, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (4, 0x796f7572, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (5, 0x706870626233, 0, 2);
INSERT INTO `ts_search_wordlist` VALUES (6, 0x696e7374616c6c6174696f6e, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (7, 0x65766572797468696e67, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (8, 0x7365656d73, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (9, 0x776f726b696e67, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (10, 0x796f75, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (11, 0x6d6179, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (12, 0x64656c657465, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (13, 0x6c696b65, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (14, 0x616e64, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (15, 0x636f6e74696e7565, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (16, 0x736574, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (17, 0x626f617264, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (18, 0x647572696e67, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (19, 0x746865, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (20, 0x70726f63657373, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (21, 0x6669727374, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (22, 0x63617465676f7279, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (23, 0x666f72756d, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (24, 0x617265, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (25, 0x61737369676e6564, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (26, 0x617070726f707269617465, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (27, 0x7065726d697373696f6e73, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (28, 0x666f72, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (29, 0x707265646566696e6564, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (30, 0x7573657267726f757073, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (31, 0x61646d696e6973747261746f7273, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (32, 0x626f7473, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (33, 0x676c6f62616c, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (34, 0x6d6f64657261746f7273, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (35, 0x677565737473, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (36, 0x72656769737465726564, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (37, 0x7573657273, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (38, 0x636f707061, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (39, 0x616c736f, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (40, 0x63686f6f7365, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (41, 0x6e6f74, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (42, 0x666f72676574, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (43, 0x61737369676e, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (44, 0x616c6c, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (45, 0x7468657365, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (46, 0x6e6577, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (47, 0x63617465676f72696573, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (48, 0x666f72756d73, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (49, 0x637265617465, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (50, 0x7265636f6d6d656e646564, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (51, 0x72656e616d65, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (52, 0x636f7079, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (53, 0x66726f6d, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (54, 0x7768696c65, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (55, 0x6372656174696e67, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (56, 0x68617665, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (57, 0x66756e, 0, 1);
INSERT INTO `ts_search_wordlist` VALUES (58, 0x77656c636f6d65, 0, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_search_wordmatch`
-- 

CREATE TABLE `ts_search_wordmatch` (
  `post_id` mediumint(8) unsigned NOT NULL default '0',
  `word_id` mediumint(8) unsigned NOT NULL default '0',
  `title_match` tinyint(1) unsigned NOT NULL default '0',
  UNIQUE KEY `unq_mtch` (`word_id`,`post_id`,`title_match`),
  KEY `word_id` (`word_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_search_wordmatch`
-- 

INSERT INTO `ts_search_wordmatch` VALUES (1, 1, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 2, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 3, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 4, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 5, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 5, 1);
INSERT INTO `ts_search_wordmatch` VALUES (1, 6, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 7, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 8, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 9, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 10, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 11, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 12, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 13, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 14, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 15, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 16, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 17, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 18, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 19, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 20, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 21, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 22, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 23, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 24, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 25, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 26, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 27, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 28, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 29, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 30, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 31, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 32, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 33, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 34, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 35, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 36, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 37, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 38, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 39, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 40, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 41, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 42, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 43, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 44, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 45, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 46, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 47, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 48, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 49, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 50, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 51, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 52, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 53, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 54, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 55, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 56, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 57, 0);
INSERT INTO `ts_search_wordmatch` VALUES (1, 58, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_sessions`
-- 

CREATE TABLE `ts_sessions` (
  `session_id` char(32) collate utf8_bin NOT NULL default '',
  `session_user_id` mediumint(8) unsigned NOT NULL default '0',
  `session_forum_id` mediumint(8) unsigned NOT NULL default '0',
  `session_last_visit` int(11) unsigned NOT NULL default '0',
  `session_start` int(11) unsigned NOT NULL default '0',
  `session_time` int(11) unsigned NOT NULL default '0',
  `session_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `session_browser` varchar(150) collate utf8_bin NOT NULL default '',
  `session_forwarded_for` varchar(255) collate utf8_bin NOT NULL default '',
  `session_page` varchar(255) collate utf8_bin NOT NULL default '',
  `session_viewonline` tinyint(1) unsigned NOT NULL default '1',
  `session_autologin` tinyint(1) unsigned NOT NULL default '0',
  `session_admin` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`session_id`),
  KEY `session_time` (`session_time`),
  KEY `session_user_id` (`session_user_id`),
  KEY `session_fid` (`session_forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_sessions`
-- 

INSERT INTO `ts_sessions` VALUES (0x3466333433343762653262626637653634313532366331653763343464353035, 1, 0, 1235842769, 1235842769, 1235842769, 0x37342e3132352e37352e3532, 0x476f6f676c65467269656e64436f6e6e6563742f312e30, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x3230383965343632356165663734643465653733393637393637306564653462, 2, 5, 1235828477, 1235834927, 1235840316, 0x3132312e3234362e3233342e323033, 0x4d6f7a696c6c612f352e30202857696e646f77733b20553b2057696e646f7773204e5420352e313b20656e2d55533b2072763a312e392e302e3629204765636b6f2f323030393031313931332046697265666f782f332e302e36, '', 0x61646d2f696e6465782e7068703f693d666f72756d7326696361743d37266d6f64653d6d616e61676526706172656e745f69643d3526616374696f6e3d61646426663d35, 1, 0, 1);
INSERT INTO `ts_sessions` VALUES (0x3438313863626439643335616462386437393834386438393438343731666437, 1, 0, 1235842768, 1235842768, 1235842768, 0x37342e3132352e37352e3230, 0x476f6f676c65467269656e64436f6e6e6563742f312e30, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x3961333734653435663434323962313739346336336639656563363536633362, 1, 0, 1236007744, 1236007744, 1236007744, 0x3132342e3132332e3230312e313836, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520372e303b2057696e646f7773204e5420362e303b20475442353b20534c4343313b202e4e455420434c5220322e302e35303732373b202e4e455420434c5220332e302e303435303629, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x6230303532666165333030643933663762373339353131386165623530663963, 1, 0, 1249956288, 1249956288, 1249956288, 0x3134382e38372e312e313732, 0x4d6f7a696c6c612f352e30202857696e646f77733b20553b2057696e646f7773204e5420352e313b20656e2d55533b2072763a312e392e312e3229204765636b6f2f32303039303732392046697265666f782f332e352e32, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x6236313063313733313962306262336131393830653039343433313635336363, 1, 0, 1237208304, 1237208304, 1237208304, 0x3231372e3136392e34362e3938, 0x4d6f7a696c6c612f342e30, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x3963626335396461376464646238333635633538346630346262613137613463, 1, 0, 1237208304, 1237208304, 1237208304, 0x3231372e3136392e33382e313236, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520372e303b2057696e646f7773204e5420352e313b202e4e455420434c5220312e312e343332323b202e4e455420434c5220322e302e35303732373b204f66666963654c697665436f6e6e6563746f722e312e333b204f66666963654c69766550617463682e302e303b204d415854484f4e20322e3029, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x6138643262663735663033653466323136643135643961626132363730643131, 2, 0, 1235828477, 1237207718, 1237208448, 0x3134382e38372e312e313732, 0x4d6f7a696c6c612f352e3020285831313b20553b204c696e757820693638363b20656e2d55533b2072763a312e392e302e3729204765636b6f2f323030393032313930362046697265666f782f332e302e37, '', 0x61646d2f696e6465782e7068703f693d7065726d697373696f6e73266d6f64653d73657474696e675f666f72756d5f6c6f63616c, 1, 0, 1);
INSERT INTO `ts_sessions` VALUES (0x6561393262326661626536633563356238613965303534396265633338343161, 1, 0, 1237208305, 1237208305, 1237208305, 0x3231372e3136392e33382e313236, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b29, '', 0x63726f6e2e7068703f63726f6e5f747970653d746964795f636163686526616d703b7369643d3963626335396461376464646238333635633538346630346262613137613463, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x3664623064656434316462333261303337366630623362326432623162326164, 2, 0, 1235828477, 1237266027, 1237267389, 0x3134382e38372e312e313732, 0x4d6f7a696c6c612f352e3020285831313b20553b204c696e757820693638363b20656e2d55533b2072763a312e392e302e3729204765636b6f2f323030393032313930362046697265666f782f332e302e37, '', 0x61646d2f696e6465782e7068703f693d6d6f64756c6573266d6f64653d6d6370, 1, 0, 1);
INSERT INTO `ts_sessions` VALUES (0x3764626363323462636161366562656333336539613132333764356430373634, 1, 0, 1237378017, 1237378017, 1237378017, 0x3139362e31352e31362e3230, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520362e303b2057696e646f7773204e5420352e313b205356313b202e4e455420434c5220322e302e35303732373b202e4e455420434c5220332e302e30343530362e33303b202e4e455420434c5220332e302e30343530362e36343829, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x6639343838356564353835323961323833326334373731353837616234333561, 1, 0, 1246701624, 1246701624, 1246701624, 0x3139362e31352e31362e3230, 0x4d6f7a696c6c612f352e3020285831313b20553b204c696e757820693638363b20656e2d55533b2072763a312e392e302e313129204765636b6f2f323030393036303231342046697265666f782f332e302e3131, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x6135656239303566323661653366336539633631313235656464643932323436, 1, 0, 1237706681, 1237706681, 1237706681, 0x35392e39392e32342e3534, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520362e303b2057696e646f7773204e5420352e313b205356313b204754423529, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x6537363130636166303162366130663038643361363662353639396331326165, 1, 14, 1240228362, 1240228362, 1240228388, 0x3139362e31352e31362e3230, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520362e303b2057696e646f7773204e5420352e313b205356313b202e4e455420434c5220322e302e35303732373b202e4e455420434c5220332e302e30343530362e33303b202e4e455420434c5220332e302e30343530362e36343829, '', 0x76696577666f72756d2e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x6361306633383831613238363661383961323864663766633735313539646333, 1, 0, 1241415751, 1241415751, 1241415751, 0x37362e3136312e3235312e313830, 0x4d6e6f676f7365617263682d332e312e3231, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x3938343164636261646139633435363833393337316135336362306233316238, 1, 0, 1249387563, 1249387563, 1249387563, 0x36342e3130332e3138362e323030, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520372e303b2057696e646f7773204e5420352e313b202e4e455420434c5220312e312e3433323229, '', 0x696e6465782e706870, 1, 0, 0);
INSERT INTO `ts_sessions` VALUES (0x3762333435313765396163616532623339383938343266653537326131363835, 1, 0, 1250017441, 1250017441, 1250017441, 0x3131352e3234302e3132322e313437, 0x4d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520372e303b2057696e646f7773204e5420362e303b2054726964656e742f342e303b204d6f7a696c6c612f342e302028636f6d70617469626c653b204d53494520362e303b2057696e646f7773204e5420352e313b2053563129203b20534c4343313b202e4e455420434c5220322e302e35303732373b, '', 0x696e6465782e706870, 1, 0, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_sessions_keys`
-- 

CREATE TABLE `ts_sessions_keys` (
  `key_id` char(32) collate utf8_bin NOT NULL default '',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `last_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `last_login` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`key_id`,`user_id`),
  KEY `last_login` (`last_login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_sessions_keys`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_sitelist`
-- 

CREATE TABLE `ts_sitelist` (
  `site_id` mediumint(8) unsigned NOT NULL auto_increment,
  `site_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `site_hostname` varchar(255) collate utf8_bin NOT NULL default '',
  `ip_exclude` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_sitelist`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_smilies`
-- 

CREATE TABLE `ts_smilies` (
  `smiley_id` mediumint(8) unsigned NOT NULL auto_increment,
  `code` varchar(50) collate utf8_bin NOT NULL default '',
  `emotion` varchar(50) collate utf8_bin NOT NULL default '',
  `smiley_url` varchar(50) collate utf8_bin NOT NULL default '',
  `smiley_width` smallint(4) unsigned NOT NULL default '0',
  `smiley_height` smallint(4) unsigned NOT NULL default '0',
  `smiley_order` mediumint(8) unsigned NOT NULL default '0',
  `display_on_posting` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`smiley_id`),
  KEY `display_on_post` (`display_on_posting`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=43 ;

-- 
-- Dumping data for table `ts_smilies`
-- 

INSERT INTO `ts_smilies` VALUES (1, 0x3a44, 0x56657279204861707079, 0x69636f6e5f655f6269676772696e2e676966, 15, 17, 1, 1);
INSERT INTO `ts_smilies` VALUES (2, 0x3a2d44, 0x56657279204861707079, 0x69636f6e5f655f6269676772696e2e676966, 15, 17, 2, 1);
INSERT INTO `ts_smilies` VALUES (3, 0x3a6772696e3a, 0x56657279204861707079, 0x69636f6e5f655f6269676772696e2e676966, 15, 17, 3, 1);
INSERT INTO `ts_smilies` VALUES (4, 0x3a29, 0x536d696c65, 0x69636f6e5f655f736d696c652e676966, 15, 17, 4, 1);
INSERT INTO `ts_smilies` VALUES (5, 0x3a2d29, 0x536d696c65, 0x69636f6e5f655f736d696c652e676966, 15, 17, 5, 1);
INSERT INTO `ts_smilies` VALUES (6, 0x3a736d696c653a, 0x536d696c65, 0x69636f6e5f655f736d696c652e676966, 15, 17, 6, 1);
INSERT INTO `ts_smilies` VALUES (7, 0x3b29, 0x57696e6b, 0x69636f6e5f655f77696e6b2e676966, 15, 17, 7, 1);
INSERT INTO `ts_smilies` VALUES (8, 0x3b2d29, 0x57696e6b, 0x69636f6e5f655f77696e6b2e676966, 15, 17, 8, 1);
INSERT INTO `ts_smilies` VALUES (9, 0x3a77696e6b3a, 0x57696e6b, 0x69636f6e5f655f77696e6b2e676966, 15, 17, 9, 1);
INSERT INTO `ts_smilies` VALUES (10, 0x3a28, 0x536164, 0x69636f6e5f655f7361642e676966, 15, 17, 10, 1);
INSERT INTO `ts_smilies` VALUES (11, 0x3a2d28, 0x536164, 0x69636f6e5f655f7361642e676966, 15, 17, 11, 1);
INSERT INTO `ts_smilies` VALUES (12, 0x3a7361643a, 0x536164, 0x69636f6e5f655f7361642e676966, 15, 17, 12, 1);
INSERT INTO `ts_smilies` VALUES (13, 0x3a6f, 0x537572707269736564, 0x69636f6e5f655f7375727072697365642e676966, 15, 17, 13, 1);
INSERT INTO `ts_smilies` VALUES (14, 0x3a2d6f, 0x537572707269736564, 0x69636f6e5f655f7375727072697365642e676966, 15, 17, 14, 1);
INSERT INTO `ts_smilies` VALUES (15, 0x3a65656b3a, 0x537572707269736564, 0x69636f6e5f655f7375727072697365642e676966, 15, 17, 15, 1);
INSERT INTO `ts_smilies` VALUES (16, 0x3a73686f636b3a, 0x53686f636b6564, 0x69636f6e5f65656b2e676966, 15, 17, 16, 1);
INSERT INTO `ts_smilies` VALUES (17, 0x3a3f, 0x436f6e6675736564, 0x69636f6e5f655f636f6e66757365642e676966, 15, 17, 17, 1);
INSERT INTO `ts_smilies` VALUES (18, 0x3a2d3f, 0x436f6e6675736564, 0x69636f6e5f655f636f6e66757365642e676966, 15, 17, 18, 1);
INSERT INTO `ts_smilies` VALUES (19, 0x3a3f3f3f3a, 0x436f6e6675736564, 0x69636f6e5f655f636f6e66757365642e676966, 15, 17, 19, 1);
INSERT INTO `ts_smilies` VALUES (20, 0x382d29, 0x436f6f6c, 0x69636f6e5f636f6f6c2e676966, 15, 17, 20, 1);
INSERT INTO `ts_smilies` VALUES (21, 0x3a636f6f6c3a, 0x436f6f6c, 0x69636f6e5f636f6f6c2e676966, 15, 17, 21, 1);
INSERT INTO `ts_smilies` VALUES (22, 0x3a6c6f6c3a, 0x4c61756768696e67, 0x69636f6e5f6c6f6c2e676966, 15, 17, 22, 1);
INSERT INTO `ts_smilies` VALUES (23, 0x3a78, 0x4d6164, 0x69636f6e5f6d61642e676966, 15, 17, 23, 1);
INSERT INTO `ts_smilies` VALUES (24, 0x3a2d78, 0x4d6164, 0x69636f6e5f6d61642e676966, 15, 17, 24, 1);
INSERT INTO `ts_smilies` VALUES (25, 0x3a6d61643a, 0x4d6164, 0x69636f6e5f6d61642e676966, 15, 17, 25, 1);
INSERT INTO `ts_smilies` VALUES (26, 0x3a50, 0x52617a7a, 0x69636f6e5f72617a7a2e676966, 15, 17, 26, 1);
INSERT INTO `ts_smilies` VALUES (27, 0x3a2d50, 0x52617a7a, 0x69636f6e5f72617a7a2e676966, 15, 17, 27, 1);
INSERT INTO `ts_smilies` VALUES (28, 0x3a72617a7a3a, 0x52617a7a, 0x69636f6e5f72617a7a2e676966, 15, 17, 28, 1);
INSERT INTO `ts_smilies` VALUES (29, 0x3a6f6f70733a, 0x456d626172726173736564, 0x69636f6e5f726564666163652e676966, 15, 17, 29, 1);
INSERT INTO `ts_smilies` VALUES (30, 0x3a6372793a, 0x437279696e67206f72205665727920536164, 0x69636f6e5f6372792e676966, 15, 17, 30, 1);
INSERT INTO `ts_smilies` VALUES (31, 0x3a6576696c3a, 0x4576696c206f722056657279204d6164, 0x69636f6e5f6576696c2e676966, 15, 17, 31, 1);
INSERT INTO `ts_smilies` VALUES (32, 0x3a747769737465643a, 0x54776973746564204576696c, 0x69636f6e5f747769737465642e676966, 15, 17, 32, 1);
INSERT INTO `ts_smilies` VALUES (33, 0x3a726f6c6c3a, 0x526f6c6c696e672045796573, 0x69636f6e5f726f6c6c657965732e676966, 15, 17, 33, 1);
INSERT INTO `ts_smilies` VALUES (34, 0x3a213a, 0x4578636c616d6174696f6e, 0x69636f6e5f6578636c61696d2e676966, 15, 17, 34, 1);
INSERT INTO `ts_smilies` VALUES (35, 0x3a3f3a, 0x5175657374696f6e, 0x69636f6e5f7175657374696f6e2e676966, 15, 17, 35, 1);
INSERT INTO `ts_smilies` VALUES (36, 0x3a696465613a, 0x49646561, 0x69636f6e5f696465612e676966, 15, 17, 36, 1);
INSERT INTO `ts_smilies` VALUES (37, 0x3a6172726f773a, 0x4172726f77, 0x69636f6e5f6172726f772e676966, 15, 17, 37, 1);
INSERT INTO `ts_smilies` VALUES (38, 0x3a7c, 0x4e65757472616c, 0x69636f6e5f6e65757472616c2e676966, 15, 17, 38, 1);
INSERT INTO `ts_smilies` VALUES (39, 0x3a2d7c, 0x4e65757472616c, 0x69636f6e5f6e65757472616c2e676966, 15, 17, 39, 1);
INSERT INTO `ts_smilies` VALUES (40, 0x3a6d72677265656e3a, 0x4d722e20477265656e, 0x69636f6e5f6d72677265656e2e676966, 15, 17, 40, 1);
INSERT INTO `ts_smilies` VALUES (41, 0x3a6765656b3a, 0x4765656b, 0x69636f6e5f655f6765656b2e676966, 17, 17, 41, 1);
INSERT INTO `ts_smilies` VALUES (42, 0x3a756765656b3a, 0x55626572204765656b, 0x69636f6e5f655f756765656b2e676966, 17, 18, 42, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_styles`
-- 

CREATE TABLE `ts_styles` (
  `style_id` mediumint(8) unsigned NOT NULL auto_increment,
  `style_name` varchar(255) collate utf8_bin NOT NULL default '',
  `style_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `style_active` tinyint(1) unsigned NOT NULL default '1',
  `template_id` mediumint(8) unsigned NOT NULL default '0',
  `theme_id` mediumint(8) unsigned NOT NULL default '0',
  `imageset_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`style_id`),
  UNIQUE KEY `style_name` (`style_name`),
  KEY `template_id` (`template_id`),
  KEY `theme_id` (`theme_id`),
  KEY `imageset_id` (`imageset_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_styles`
-- 

INSERT INTO `ts_styles` VALUES (1, 0x70726f73696c766572, 0x26636f70793b2070687042422047726f7570, 1, 1, 1, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_styles_imageset`
-- 

CREATE TABLE `ts_styles_imageset` (
  `imageset_id` mediumint(8) unsigned NOT NULL auto_increment,
  `imageset_name` varchar(255) collate utf8_bin NOT NULL default '',
  `imageset_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `imageset_path` varchar(100) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`imageset_id`),
  UNIQUE KEY `imgset_nm` (`imageset_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_styles_imageset`
-- 

INSERT INTO `ts_styles_imageset` VALUES (1, 0x70726f73696c766572, 0x26636f70793b2070687042422047726f7570, 0x70726f73696c766572);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_styles_imageset_data`
-- 

CREATE TABLE `ts_styles_imageset_data` (
  `image_id` mediumint(8) unsigned NOT NULL auto_increment,
  `image_name` varchar(200) collate utf8_bin NOT NULL default '',
  `image_filename` varchar(200) collate utf8_bin NOT NULL default '',
  `image_lang` varchar(30) collate utf8_bin NOT NULL default '',
  `image_height` smallint(4) unsigned NOT NULL default '0',
  `image_width` smallint(4) unsigned NOT NULL default '0',
  `imageset_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`image_id`),
  KEY `i_d` (`imageset_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=79 ;

-- 
-- Dumping data for table `ts_styles_imageset_data`
-- 

INSERT INTO `ts_styles_imageset_data` VALUES (1, 0x736974655f6c6f676f, 0x736974655f6c6f676f2e676966, '', 52, 139, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (2, 0x666f72756d5f6c696e6b, 0x666f72756d5f6c696e6b2e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (3, 0x666f72756d5f72656164, 0x666f72756d5f726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (4, 0x666f72756d5f726561645f6c6f636b6564, 0x666f72756d5f726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (5, 0x666f72756d5f726561645f737562666f72756d, 0x666f72756d5f726561645f737562666f72756d2e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (6, 0x666f72756d5f756e72656164, 0x666f72756d5f756e726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (7, 0x666f72756d5f756e726561645f6c6f636b6564, 0x666f72756d5f756e726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (8, 0x666f72756d5f756e726561645f737562666f72756d, 0x666f72756d5f756e726561645f737562666f72756d2e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (9, 0x746f7069635f6d6f766564, 0x746f7069635f6d6f7665642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (10, 0x746f7069635f72656164, 0x746f7069635f726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (11, 0x746f7069635f726561645f6d696e65, 0x746f7069635f726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (12, 0x746f7069635f726561645f686f74, 0x746f7069635f726561645f686f742e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (13, 0x746f7069635f726561645f686f745f6d696e65, 0x746f7069635f726561645f686f745f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (14, 0x746f7069635f726561645f6c6f636b6564, 0x746f7069635f726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (15, 0x746f7069635f726561645f6c6f636b65645f6d696e65, 0x746f7069635f726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (16, 0x746f7069635f756e72656164, 0x746f7069635f756e726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (17, 0x746f7069635f756e726561645f6d696e65, 0x746f7069635f756e726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (18, 0x746f7069635f756e726561645f686f74, 0x746f7069635f756e726561645f686f742e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (19, 0x746f7069635f756e726561645f686f745f6d696e65, 0x746f7069635f756e726561645f686f745f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (20, 0x746f7069635f756e726561645f6c6f636b6564, 0x746f7069635f756e726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (21, 0x746f7069635f756e726561645f6c6f636b65645f6d696e65, 0x746f7069635f756e726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (22, 0x737469636b795f72656164, 0x737469636b795f726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (23, 0x737469636b795f726561645f6d696e65, 0x737469636b795f726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (24, 0x737469636b795f726561645f6c6f636b6564, 0x737469636b795f726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (25, 0x737469636b795f726561645f6c6f636b65645f6d696e65, 0x737469636b795f726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (26, 0x737469636b795f756e72656164, 0x737469636b795f756e726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (27, 0x737469636b795f756e726561645f6d696e65, 0x737469636b795f756e726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (28, 0x737469636b795f756e726561645f6c6f636b6564, 0x737469636b795f756e726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (29, 0x737469636b795f756e726561645f6c6f636b65645f6d696e65, 0x737469636b795f756e726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (30, 0x616e6e6f756e63655f72656164, 0x616e6e6f756e63655f726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (31, 0x616e6e6f756e63655f726561645f6d696e65, 0x616e6e6f756e63655f726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (32, 0x616e6e6f756e63655f726561645f6c6f636b6564, 0x616e6e6f756e63655f726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (33, 0x616e6e6f756e63655f726561645f6c6f636b65645f6d696e65, 0x616e6e6f756e63655f726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (34, 0x616e6e6f756e63655f756e72656164, 0x616e6e6f756e63655f756e726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (35, 0x616e6e6f756e63655f756e726561645f6d696e65, 0x616e6e6f756e63655f756e726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (36, 0x616e6e6f756e63655f756e726561645f6c6f636b6564, 0x616e6e6f756e63655f756e726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (37, 0x616e6e6f756e63655f756e726561645f6c6f636b65645f6d696e65, 0x616e6e6f756e63655f756e726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (38, 0x676c6f62616c5f72656164, 0x616e6e6f756e63655f726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (39, 0x676c6f62616c5f726561645f6d696e65, 0x616e6e6f756e63655f726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (40, 0x676c6f62616c5f726561645f6c6f636b6564, 0x616e6e6f756e63655f726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (41, 0x676c6f62616c5f726561645f6c6f636b65645f6d696e65, 0x616e6e6f756e63655f726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (42, 0x676c6f62616c5f756e72656164, 0x616e6e6f756e63655f756e726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (43, 0x676c6f62616c5f756e726561645f6d696e65, 0x616e6e6f756e63655f756e726561645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (44, 0x676c6f62616c5f756e726561645f6c6f636b6564, 0x616e6e6f756e63655f756e726561645f6c6f636b65642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (45, 0x676c6f62616c5f756e726561645f6c6f636b65645f6d696e65, 0x616e6e6f756e63655f756e726561645f6c6f636b65645f6d696e652e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (46, 0x706d5f72656164, 0x746f7069635f726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (47, 0x706d5f756e72656164, 0x746f7069635f756e726561642e676966, '', 27, 27, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (48, 0x69636f6e5f6261636b5f746f70, 0x69636f6e5f6261636b5f746f702e676966, '', 11, 11, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (49, 0x69636f6e5f636f6e746163745f61696d, 0x69636f6e5f636f6e746163745f61696d2e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (50, 0x69636f6e5f636f6e746163745f656d61696c, 0x69636f6e5f636f6e746163745f656d61696c2e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (51, 0x69636f6e5f636f6e746163745f696371, 0x69636f6e5f636f6e746163745f6963712e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (52, 0x69636f6e5f636f6e746163745f6a6162626572, 0x69636f6e5f636f6e746163745f6a61626265722e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (53, 0x69636f6e5f636f6e746163745f6d736e6d, 0x69636f6e5f636f6e746163745f6d736e6d2e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (54, 0x69636f6e5f636f6e746163745f777777, 0x69636f6e5f636f6e746163745f7777772e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (55, 0x69636f6e5f636f6e746163745f7961686f6f, 0x69636f6e5f636f6e746163745f7961686f6f2e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (56, 0x69636f6e5f706f73745f64656c657465, 0x69636f6e5f706f73745f64656c6574652e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (57, 0x69636f6e5f706f73745f696e666f, 0x69636f6e5f706f73745f696e666f2e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (58, 0x69636f6e5f706f73745f7265706f7274, 0x69636f6e5f706f73745f7265706f72742e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (59, 0x69636f6e5f706f73745f746172676574, 0x69636f6e5f706f73745f7461726765742e676966, '', 9, 11, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (60, 0x69636f6e5f706f73745f7461726765745f756e72656164, 0x69636f6e5f706f73745f7461726765745f756e726561642e676966, '', 9, 11, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (61, 0x69636f6e5f746f7069635f617474616368, 0x69636f6e5f746f7069635f6174746163682e676966, '', 10, 7, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (62, 0x69636f6e5f746f7069635f6c6174657374, 0x69636f6e5f746f7069635f6c61746573742e676966, '', 9, 11, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (63, 0x69636f6e5f746f7069635f6e6577657374, 0x69636f6e5f746f7069635f6e65776573742e676966, '', 9, 11, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (64, 0x69636f6e5f746f7069635f7265706f72746564, 0x69636f6e5f746f7069635f7265706f727465642e676966, '', 14, 16, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (65, 0x69636f6e5f746f7069635f756e617070726f766564, 0x69636f6e5f746f7069635f756e617070726f7665642e676966, '', 14, 16, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (66, 0x69636f6e5f757365725f7761726e, 0x69636f6e5f757365725f7761726e2e676966, '', 20, 20, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (67, 0x737562666f72756d5f72656164, 0x737562666f72756d5f726561642e676966, '', 9, 11, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (68, 0x737562666f72756d5f756e72656164, 0x737562666f72756d5f756e726561642e676966, '', 9, 11, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (69, 0x69636f6e5f636f6e746163745f706d, 0x69636f6e5f636f6e746163745f706d2e676966, 0x656e, 20, 28, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (70, 0x69636f6e5f706f73745f65646974, 0x69636f6e5f706f73745f656469742e676966, 0x656e, 20, 42, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (71, 0x69636f6e5f706f73745f71756f7465, 0x69636f6e5f706f73745f71756f74652e676966, 0x656e, 20, 54, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (72, 0x69636f6e5f757365725f6f6e6c696e65, 0x69636f6e5f757365725f6f6e6c696e652e676966, 0x656e, 58, 58, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (73, 0x627574746f6e5f706d5f666f7277617264, 0x627574746f6e5f706d5f666f72776172642e676966, 0x656e, 25, 96, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (74, 0x627574746f6e5f706d5f6e6577, 0x627574746f6e5f706d5f6e65772e676966, 0x656e, 25, 84, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (75, 0x627574746f6e5f706d5f7265706c79, 0x627574746f6e5f706d5f7265706c792e676966, 0x656e, 25, 96, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (76, 0x627574746f6e5f746f7069635f6c6f636b6564, 0x627574746f6e5f746f7069635f6c6f636b65642e676966, 0x656e, 25, 88, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (77, 0x627574746f6e5f746f7069635f6e6577, 0x627574746f6e5f746f7069635f6e65772e676966, 0x656e, 25, 96, 1);
INSERT INTO `ts_styles_imageset_data` VALUES (78, 0x627574746f6e5f746f7069635f7265706c79, 0x627574746f6e5f746f7069635f7265706c792e676966, 0x656e, 25, 96, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_styles_template`
-- 

CREATE TABLE `ts_styles_template` (
  `template_id` mediumint(8) unsigned NOT NULL auto_increment,
  `template_name` varchar(255) collate utf8_bin NOT NULL default '',
  `template_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `template_path` varchar(100) collate utf8_bin NOT NULL default '',
  `bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default 'kNg=',
  `template_storedb` tinyint(1) unsigned NOT NULL default '0',
  `template_inherits_id` int(4) unsigned NOT NULL default '0',
  `template_inherit_path` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`template_id`),
  UNIQUE KEY `tmplte_nm` (`template_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_styles_template`
-- 

INSERT INTO `ts_styles_template` VALUES (1, 0x70726f73696c766572, 0x26636f70793b2070687042422047726f7570, 0x70726f73696c766572, 0x6c4e673d, 0, 0, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_styles_template_data`
-- 

CREATE TABLE `ts_styles_template_data` (
  `template_id` mediumint(8) unsigned NOT NULL default '0',
  `template_filename` varchar(100) collate utf8_bin NOT NULL default '',
  `template_included` text collate utf8_bin NOT NULL,
  `template_mtime` int(11) unsigned NOT NULL default '0',
  `template_data` mediumtext collate utf8_bin NOT NULL,
  KEY `tid` (`template_id`),
  KEY `tfn` (`template_filename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_styles_template_data`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_styles_theme`
-- 

CREATE TABLE `ts_styles_theme` (
  `theme_id` mediumint(8) unsigned NOT NULL auto_increment,
  `theme_name` varchar(255) collate utf8_bin NOT NULL default '',
  `theme_copyright` varchar(255) collate utf8_bin NOT NULL default '',
  `theme_path` varchar(100) collate utf8_bin NOT NULL default '',
  `theme_storedb` tinyint(1) unsigned NOT NULL default '0',
  `theme_mtime` int(11) unsigned NOT NULL default '0',
  `theme_data` mediumtext collate utf8_bin NOT NULL,
  PRIMARY KEY  (`theme_id`),
  UNIQUE KEY `theme_name` (`theme_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_styles_theme`
-- 

INSERT INTO `ts_styles_theme` VALUES (1, 0x70726f73696c766572, 0x26636f70793b2070687042422047726f7570, 0x70726f73696c766572, 1, 1235834469, 0x2f2a2020706870424220332e30205374796c652053686565740a202020202d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a095374796c65206e616d653a090970726f53696c7665720a094261736564206f6e207374796c653a0970726f53696c766572202874686973206973207468652064656661756c742070687042422033207374796c65290a094f726967696e616c20617574686f723a09737562426c7565202820687474703a2f2f7777772e737562426c75652e636f6d2f20290a094d6f6469666965642062793a09090a090a09436f7079726967687420323030362070687042422047726f7570202820687474703a2f2f7777772e70687062622e636f6d2f20290a202020202d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a2a2f0a0a2f2a2047656e6572616c2070726f53696c766572204d61726b7570205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2a207b0a092f2a2052657365742062726f77736572732064656661756c74206d617267696e2c2070616464696e6720616e6420666f6e742073697a6573202a2f0a096d617267696e3a20303b0a0970616464696e673a20303b0a7d0a0a68746d6c207b0a09666f6e742d73697a653a20313030253b0a092f2a20416c776179732073686f772061207363726f6c6c62617220666f722073686f7274207061676573202d2073746f707320746865206a756d70207768656e20746865207363726f6c6c62617220617070656172732e206e6f6e2d49452062726f7773657273202a2f0a096865696768743a20313030253b0a096d617267696e2d626f74746f6d3a203170783b0a7d0a0a626f6479207b0a092f2a20546578742d53697a696e67207769746820656d733a20687474703a2f2f7777772e636c61676e75742e636f6d2f626c6f672f3334382f202a2f0a09666f6e742d66616d696c793a2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09636f6c6f723a20233832383238323b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a092f2a666f6e742d73697a653a2036322e35253b09090920546869732073657473207468652064656661756c7420666f6e742073697a6520746f206265206571756976616c656e7420746f2031307078202a2f0a09666f6e742d73697a653a20313070783b0a096d617267696e3a20303b0a0970616464696e673a203132707820303b0a7d0a0a6831207b0a092f2a20466f72756d206e616d65202a2f0a09666f6e742d66616d696c793a2022547265627563686574204d53222c20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a096d617267696e2d72696768743a2032303070783b0a09636f6c6f723a20234646464646463b0a096d617267696e2d746f703a20313570783b0a09666f6e742d7765696768743a20626f6c643b0a09666f6e742d73697a653a2032656d3b0a7d0a0a6832207b0a092f2a20466f72756d20686561646572207469746c6573202a2f0a09666f6e742d66616d696c793a2022547265627563686574204d53222c20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636f6c6f723a20233366336633663b0a09666f6e742d73697a653a2032656d3b0a096d617267696e3a20302e38656d203020302e32656d20303b0a7d0a0a68322e736f6c6f207b0a096d617267696e2d626f74746f6d3a2031656d3b0a7d0a0a6833207b0a092f2a205375622d686561646572732028616c736f207573656420617320706f737420686561646572732c2062757420646566696e6564206c6174657229202a2f0a09666f6e742d66616d696c793a20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a09666f6e742d7765696768743a20626f6c643b0a09746578742d7472616e73666f726d3a207570706572636173653b0a09626f726465722d626f74746f6d3a2031707820736f6c696420234343434343433b0a096d617267696e2d626f74746f6d3a203370783b0a0970616464696e672d626f74746f6d3a203270783b0a09666f6e742d73697a653a20312e3035656d3b0a09636f6c6f723a20233938393839383b0a096d617267696e2d746f703a20323070783b0a7d0a0a6834207b0a092f2a20466f72756d20616e6420746f706963206c697374207469746c6573202a2f0a09666f6e742d66616d696c793a2022547265627563686574204d53222c2056657264616e612c2048656c7665746963612c20417269616c2c2053616e732d73657269663b0a09666f6e742d73697a653a20312e33656d3b0a7d0a0a70207b0a096c696e652d6865696768743a20312e33656d3b0a09666f6e742d73697a653a20312e31656d3b0a096d617267696e2d626f74746f6d3a20312e35656d3b0a7d0a0a696d67207b0a09626f726465722d77696474683a20303b0a7d0a0a6872207b0a092f2a20416c736f2073656520747765616b732e637373202a2f0a09626f726465723a2030206e6f6e6520234646464646463b0a09626f726465722d746f703a2031707820736f6c696420234343434343433b0a096865696768743a203170783b0a096d617267696e3a2035707820303b0a09646973706c61793a20626c6f636b3b0a09636c6561723a20626f74683b0a7d0a0a68722e646173686564207b0a09626f726465722d746f703a203170782064617368656420234343434343433b0a096d617267696e3a203130707820303b0a7d0a0a68722e64697669646572207b0a09646973706c61793a206e6f6e653b0a7d0a0a702e7269676874207b0a09746578742d616c69676e3a2072696768743b0a7d0a0a2f2a204d61696e20626c6f636b730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2377726170207b0a0970616464696e673a203020323070783b0a096d696e2d77696474683a2036353070783b0a7d0a0a2373696d706c652d77726170207b0a0970616464696e673a2036707820313070783b0a7d0a0a23706167652d626f6479207b0a096d617267696e3a2034707820303b0a09636c6561723a20626f74683b0a7d0a0a23706167652d666f6f746572207b0a09636c6561723a20626f74683b0a7d0a0a23706167652d666f6f746572206833207b0a096d617267696e2d746f703a20323070783b0a7d0a0a236c6f676f207b0a09666c6f61743a206c6566743b0a0977696474683a206175746f3b0a0970616464696e673a20313070782031337078203020313070783b0a7d0a0a61236c6f676f3a686f766572207b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a2f2a2053656172636820626f780a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a237365617263682d626f78207b0a09636f6c6f723a20234646464646463b0a09706f736974696f6e3a2072656c61746976653b0a096d617267696e2d746f703a20333070783b0a096d617267696e2d72696768743a203570783b0a09646973706c61793a20626c6f636b3b0a09666c6f61743a2072696768743b0a09746578742d616c69676e3a2072696768743b0a0977686974652d73706163653a206e6f777261703b202f2a20466f72204f70657261202a2f0a7d0a0a237365617263682d626f7820236b6579776f726473207b0a0977696474683a20393570783b0a096261636b67726f756e642d636f6c6f723a20234646463b0a7d0a0a237365617263682d626f7820696e707574207b0a09626f726465723a2031707820736f6c696420236230623062303b0a7d0a0a2f2a202e627574746f6e31207374796c6520646566696e6564206c617465722c206a75737420612066657720747765616b7320666f72207468652073656172636820627574746f6e2076657273696f6e202a2f0a237365617263682d626f7820696e7075742e627574746f6e31207b0a0970616464696e673a20317078203570783b0a7d0a0a237365617263682d626f78206c69207b0a09746578742d616c69676e3a2072696768743b0a096d617267696e2d746f703a203470783b0a7d0a0a237365617263682d626f7820696d67207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a096d617267696e2d72696768743a203370783b0a7d0a0a2f2a2053697465206465736372697074696f6e20616e64206c6f676f202a2f0a23736974652d6465736372697074696f6e207b0a09666c6f61743a206c6566743b0a0977696474683a203730253b0a7d0a0a23736974652d6465736372697074696f6e206831207b0a096d617267696e2d72696768743a20303b0a7d0a0a2f2a20526f756e6420636f726e6572656420626f78657320616e64206261636b67726f756e64730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2e686561646572626172207b0a096261636b67726f756e643a2023656265626562206e6f6e65207265706561742d78203020303b0a09636f6c6f723a20234646464646463b0a096d617267696e2d626f74746f6d3a203470783b0a0970616464696e673a2030203570783b0a7d0a0a2e6e6176626172207b0a096261636b67726f756e642d636f6c6f723a20236562656265623b0a0970616464696e673a203020313070783b0a7d0a0a2e666f72616267207b0a096261636b67726f756e643a2023623162316231206e6f6e65207265706561742d78203020303b0a096d617267696e2d626f74746f6d3a203470783b0a0970616464696e673a2030203570783b0a09636c6561723a20626f74683b0a7d0a0a2e666f72756d6267207b0a096261636b67726f756e643a2023656265626562206e6f6e65207265706561742d78203020303b0a096d617267696e2d626f74746f6d3a203470783b0a0970616464696e673a2030203570783b0a09636c6561723a20626f74683b0a7d0a0a2e70616e656c207b0a096d617267696e2d626f74746f6d3a203470783b0a0970616464696e673a203020313070783b0a096261636b67726f756e642d636f6c6f723a20236633663366333b0a09636f6c6f723a20233366336633663b0a7d0a0a2e706f7374207b0a0970616464696e673a203020313070783b0a096d617267696e2d626f74746f6d3a203470783b0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a096261636b67726f756e642d706f736974696f6e3a203130302520303b0a7d0a0a2e706f73743a746172676574202e636f6e74656e74207b0a09636f6c6f723a20233030303030303b0a7d0a0a2e706f73743a7461726765742068332061207b0a09636f6c6f723a20233030303030303b0a7d0a0a2e626731097b206261636b67726f756e642d636f6c6f723a20236637663766373b7d0a2e626732097b206261636b67726f756e642d636f6c6f723a20236632663266323b207d0a2e626733097b206261636b67726f756e642d636f6c6f723a20236562656265623b207d0a0a2e726f776267207b0a096d617267696e3a203570782035707820327078203570783b0a7d0a0a2e756370726f776267207b0a096261636b67726f756e642d636f6c6f723a20236532653265323b0a7d0a0a2e6669656c64736267207b0a092f2a626f726465723a20317078202344424445453220736f6c69643b2a2f0a096261636b67726f756e642d636f6c6f723a20236561656165613b0a7d0a0a7370616e2e636f726e6572732d746f702c207370616e2e636f726e6572732d626f74746f6d2c207370616e2e636f726e6572732d746f70207370616e2c207370616e2e636f726e6572732d626f74746f6d207370616e207b0a09666f6e742d73697a653a203170783b0a096c696e652d6865696768743a203170783b0a09646973706c61793a20626c6f636b3b0a096865696768743a203570783b0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a7d0a0a7370616e2e636f726e6572732d746f70207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a203020303b0a096d617267696e3a2030202d3570783b0a7d0a0a7370616e2e636f726e6572732d746f70207370616e207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a203130302520303b0a7d0a0a7370616e2e636f726e6572732d626f74746f6d207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a203020313030253b0a096d617267696e3a2030202d3570783b0a09636c6561723a20626f74683b0a7d0a0a7370616e2e636f726e6572732d626f74746f6d207370616e207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a203130302520313030253b0a7d0a0a2e686561646267207370616e2e636f726e6572732d626f74746f6d207b0a096d617267696e2d626f74746f6d3a202d3170783b0a7d0a0a2e706f7374207370616e2e636f726e6572732d746f702c202e706f7374207370616e2e636f726e6572732d626f74746f6d2c202e70616e656c207370616e2e636f726e6572732d746f702c202e70616e656c207370616e2e636f726e6572732d626f74746f6d2c202e6e6176626172207370616e2e636f726e6572732d746f702c202e6e6176626172207370616e2e636f726e6572732d626f74746f6d207b0a096d617267696e3a2030202d313070783b0a7d0a0a2e72756c6573207370616e2e636f726e6572732d746f70207b0a096d617267696e3a2030202d3130707820357078202d313070783b0a7d0a0a2e72756c6573207370616e2e636f726e6572732d626f74746f6d207b0a096d617267696e3a20357078202d313070782030202d313070783b0a7d0a0a2f2a20486f72697a6f6e74616c206c697374730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a756c2e6c696e6b6c697374207b0a09646973706c61793a20626c6f636b3b0a096d617267696e3a20303b0a7d0a0a756c2e6c696e6b6c697374206c69207b0a09646973706c61793a20626c6f636b3b0a096c6973742d7374796c652d747970653a206e6f6e653b0a09666c6f61743a206c6566743b0a0977696474683a206175746f3b0a096d617267696e2d72696768743a203570783b0a09666f6e742d73697a653a20312e31656d3b0a096c696e652d6865696768743a20322e32656d3b0a7d0a0a756c2e6c696e6b6c697374206c692e7269676874736964652c20702e726967687473696465207b0a09666c6f61743a2072696768743b0a096d617267696e2d72696768743a20303b0a096d617267696e2d6c6566743a203570783b0a09746578742d616c69676e3a2072696768743b0a7d0a0a756c2e6e61766c696e6b73207b0a0970616464696e672d626f74746f6d3a203170783b0a096d617267696e2d626f74746f6d3a203170783b0a09626f726465722d626f74746f6d3a2031707820736f6c696420234646464646463b0a09666f6e742d7765696768743a20626f6c643b0a7d0a0a756c2e6c65667473696465207b0a09666c6f61743a206c6566743b0a096d617267696e2d6c6566743a20303b0a096d617267696e2d72696768743a203570783b0a09746578742d616c69676e3a206c6566743b0a7d0a0a756c2e726967687473696465207b0a09666c6f61743a2072696768743b0a096d617267696e2d6c6566743a203570783b0a096d617267696e2d72696768743a202d3570783b0a09746578742d616c69676e3a2072696768743b0a7d0a0a2f2a205461626c65207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a7461626c652e7461626c6531207b0a092f2a2053656520747765616b732e637373202a2f0a7d0a0a237563702d6d61696e207461626c652e7461626c6531207b0a0970616464696e673a203270783b0a7d0a0a7461626c652e7461626c6531207468656164207468207b0a09666f6e742d7765696768743a206e6f726d616c3b0a09746578742d7472616e73666f726d3a207570706572636173653b0a09636f6c6f723a20234646464646463b0a096c696e652d6865696768743a20312e33656d3b0a09666f6e742d73697a653a2031656d3b0a0970616464696e673a2030203020347078203370783b0a7d0a0a7461626c652e7461626c6531207468656164207468207370616e207b0a0970616464696e672d6c6566743a203770783b0a7d0a0a7461626c652e7461626c65312074626f6479207472207b0a09626f726465723a2031707820736f6c696420236366636663663b0a7d0a0a7461626c652e7461626c65312074626f64792074723a686f7665722c207461626c652e7461626c65312074626f64792074722e686f766572207b0a096261636b67726f756e642d636f6c6f723a20236636663666363b0a09636f6c6f723a20233030303b0a7d0a0a7461626c652e7461626c6531207464207b0a09636f6c6f723a20233661366136613b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a7461626c652e7461626c65312074626f6479207464207b0a0970616464696e673a203570783b0a09626f726465722d746f703a2031707820736f6c696420234641464146413b0a7d0a0a7461626c652e7461626c65312074626f6479207468207b0a0970616464696e673a203570783b0a09626f726465722d626f74746f6d3a2031707820736f6c696420233030303030303b0a09746578742d616c69676e3a206c6566743b0a09636f6c6f723a20233333333333333b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a2f2a20537065636966696320636f6c756d6e207374796c6573202a2f0a7461626c652e7461626c6531202e6e616d6509097b20746578742d616c69676e3a206c6566743b207d0a7461626c652e7461626c6531202e706f73747309097b20746578742d616c69676e3a2063656e7465722021696d706f7274616e743b2077696474683a2037253b207d0a7461626c652e7461626c6531202e6a6f696e6564097b20746578742d616c69676e3a206c6566743b2077696474683a203135253b207d0a7461626c652e7461626c6531202e616374697665097b20746578742d616c69676e3a206c6566743b2077696474683a203135253b207d0a7461626c652e7461626c6531202e6d61726b09097b20746578742d616c69676e3a2063656e7465723b2077696474683a2037253b207d0a7461626c652e7461626c6531202e696e666f09097b20746578742d616c69676e3a206c6566743b2077696474683a203330253b207d0a7461626c652e7461626c6531202e696e666f20646976097b2077696474683a20313030253b2077686974652d73706163653a206e6f777261703b206f766572666c6f773a2068696464656e3b207d0a7461626c652e7461626c6531202e6175746f636f6c097b206c696e652d6865696768743a2032656d3b2077686974652d73706163653a206e6f777261703b207d0a7461626c652e7461626c6531207468656164202e6175746f636f6c207b2070616464696e672d6c6566743a2031656d3b207d0a0a7461626c652e7461626c6531207370616e2e72616e6b2d696d67207b0a09666c6f61743a2072696768743b0a0977696474683a206175746f3b0a7d0a0a7461626c652e696e666f207464207b0a0970616464696e673a203370783b0a7d0a0a7461626c652e696e666f2074626f6479207468207b0a0970616464696e673a203370783b0a09746578742d616c69676e3a2072696768743b0a09766572746963616c2d616c69676e3a20746f703b0a09636f6c6f723a20233030303030303b0a09666f6e742d7765696768743a206e6f726d616c3b0a7d0a0a2e666f72756d6267207461626c652e7461626c6531207b0a096d617267696e3a2030202d327078202d317078202d3170783b0a7d0a0a2f2a204d697363206c61796f7574207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2f2a20636f6c756d6e5b312d325d207374796c65732061726520636f6e7461696e65727320666f722074776f20636f6c756d6e206c61796f757473200a202020416c736f2073656520747765616b732e637373202a2f0a2e636f6c756d6e31207b0a09666c6f61743a206c6566743b0a09636c6561723a206c6566743b0a0977696474683a203439253b0a7d0a0a2e636f6c756d6e32207b0a09666c6f61743a2072696768743b0a09636c6561723a2072696768743b0a0977696474683a203439253b0a7d0a0a2f2a2047656e6572616c20636c617373657320666f7220706c6163696e6720666c6f6174696e6720626c6f636b73202a2f0a2e6c6566742d626f78207b0a09666c6f61743a206c6566743b0a0977696474683a206175746f3b0a09746578742d616c69676e3a206c6566743b0a7d0a0a2e72696768742d626f78207b0a09666c6f61743a2072696768743b0a0977696474683a206175746f3b0a09746578742d616c69676e3a2072696768743b0a7d0a0a646c2e64657461696c73207b0a092f2a666f6e742d66616d696c793a20224c7563696461204772616e6465222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b2a2f0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a646c2e64657461696c73206474207b0a09666c6f61743a206c6566743b0a09636c6561723a206c6566743b0a0977696474683a203330253b0a09746578742d616c69676e3a2072696768743b0a09636f6c6f723a20233030303030303b0a09646973706c61793a20626c6f636b3b0a7d0a0a646c2e64657461696c73206464207b0a096d617267696e2d6c6566743a20303b0a0970616464696e672d6c6566743a203570783b0a096d617267696e2d626f74746f6d3a203570783b0a09636f6c6f723a20233832383238323b0a09666c6f61743a206c6566743b0a0977696474683a203635253b0a7d0a0a2f2a20506167696e6174696f6e0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2e706167696e6174696f6e207b0a096865696768743a2031253b202f2a20494520747765616b2028686f6c6c79206861636b29202a2f0a0977696474683a206175746f3b0a09746578742d616c69676e3a2072696768743b0a096d617267696e2d746f703a203570783b0a09666c6f61743a2072696768743b0a7d0a0a2e706167696e6174696f6e207370616e2e706167652d736570207b0a09646973706c61793a206e6f6e653b0a7d0a0a6c692e706167696e6174696f6e207b0a096d617267696e2d746f703a20303b0a7d0a0a2e706167696e6174696f6e207374726f6e672c202e706167696e6174696f6e2062207b0a09666f6e742d7765696768743a206e6f726d616c3b0a7d0a0a2e706167696e6174696f6e207370616e207374726f6e67207b0a0970616464696e673a2030203270783b0a096d617267696e3a2030203270783b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636f6c6f723a20234646464646463b0a096261636b67726f756e642d636f6c6f723a20236266626662663b0a09626f726465723a2031707820736f6c696420236266626662663b0a09666f6e742d73697a653a20302e39656d3b0a7d0a0a2e706167696e6174696f6e207370616e20612c202e706167696e6174696f6e207370616e20613a6c696e6b2c202e706167696e6174696f6e207370616e20613a766973697465642c202e706167696e6174696f6e207370616e20613a616374697665207b0a09666f6e742d7765696768743a206e6f726d616c3b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a09636f6c6f723a20233734373437343b0a096d617267696e3a2030203270783b0a0970616464696e673a2030203270783b0a096261636b67726f756e642d636f6c6f723a20236565656565653b0a09626f726465723a2031707820736f6c696420236261626162613b0a09666f6e742d73697a653a20302e39656d3b0a096c696e652d6865696768743a20312e35656d3b0a7d0a0a2e706167696e6174696f6e207370616e20613a686f766572207b0a09626f726465722d636f6c6f723a20236432643264323b0a096261636b67726f756e642d636f6c6f723a20236432643264323b0a09636f6c6f723a20234646463b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a2e706167696e6174696f6e20696d67207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a7d0a0a2f2a20506167696e6174696f6e20696e2076696577666f72756d20666f72206d756c74697061676520746f70696373202a2f0a2e726f77202e706167696e6174696f6e207b0a09646973706c61793a20626c6f636b3b0a09666c6f61743a2072696768743b0a0977696474683a206175746f3b0a096d617267696e2d746f703a20303b0a0970616464696e673a2031707820302031707820313570783b0a09666f6e742d73697a653a20302e39656d3b0a096261636b67726f756e643a206e6f6e65203020353025206e6f2d7265706561743b0a7d0a0a2e726f77202e706167696e6174696f6e207370616e20612c206c692e706167696e6174696f6e207370616e2061207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a2e726f77202e706167696e6174696f6e207370616e20613a686f7665722c206c692e706167696e6174696f6e207370616e20613a686f766572207b0a096261636b67726f756e642d636f6c6f723a20236432643264323b0a7d0a0a2f2a204d697363656c6c616e656f7573207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a23666f72756d2d7065726d697373696f6e73207b0a09666c6f61743a2072696768743b0a0977696474683a206175746f3b0a0970616464696e672d6c6566743a203570783b0a096d617267696e2d6c6566743a203570783b0a096d617267696e2d746f703a20313070783b0a09746578742d616c69676e3a2072696768743b0a7d0a0a2e636f70797269676874207b0a0970616464696e673a203570783b0a09746578742d616c69676e3a2063656e7465723b0a09636f6c6f723a20233535353535353b0a7d0a0a2e736d616c6c207b0a09666f6e742d73697a653a20302e39656d2021696d706f7274616e743b0a7d0a0a2e7469746c657370616365207b0a096d617267696e2d626f74746f6d3a20313570783b0a7d0a0a2e6865616465727370616365207b0a096d617267696e2d746f703a20323070783b0a7d0a0a2e6572726f72207b0a09636f6c6f723a20236263626362633b0a09666f6e742d7765696768743a20626f6c643b0a09666f6e742d73697a653a2031656d3b0a7d0a0a2e7265706f72746564207b0a096261636b67726f756e642d636f6c6f723a20236637663766373b0a7d0a0a6c692e7265706f727465643a686f766572207b0a096261636b67726f756e642d636f6c6f723a20236563656365633b0a7d0a0a6469762e72756c6573207b0a096261636b67726f756e642d636f6c6f723a20236563656365633b0a09636f6c6f723a20236263626362633b0a0970616464696e673a203020313070783b0a096d617267696e3a203130707820303b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a6469762e72756c657320756c207b0a096d617267696e2d6c6566743a20323070783b0a7d0a0a702e72756c6573207b0a096261636b67726f756e642d636f6c6f723a20236563656365633b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a0970616464696e673a203570783b0a7d0a0a702e72756c657320696d67207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a7d0a0a702e72756c65732061207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a09636c6561723a20626f74683b0a7d0a0a23746f70207b0a09706f736974696f6e3a206162736f6c7574653b0a09746f703a202d323070783b0a7d0a0a2e636c656172207b0a09646973706c61793a20626c6f636b3b0a09636c6561723a20626f74683b0a09666f6e742d73697a653a203170783b0a096c696e652d6865696768743a203170783b0a096261636b67726f756e643a207472616e73706172656e743b0a7d0a2f2a2070726f53696c766572204c696e6b205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a613a6c696e6b097b20636f6c6f723a20233839383938393b20746578742d6465636f726174696f6e3a206e6f6e653b207d0a613a76697369746564097b20636f6c6f723a20233839383938393b20746578742d6465636f726174696f6e3a206e6f6e653b207d0a613a686f766572097b20636f6c6f723a20236433643364333b20746578742d6465636f726174696f6e3a20756e6465726c696e653b207d0a613a616374697665097b20636f6c6f723a20236432643264323b20746578742d6465636f726174696f6e3a206e6f6e653b207d0a0a2f2a20436f6c6f7572656420757365726e616d6573202a2f0a2e757365726e616d652d636f6c6f75726564207b0a09666f6e742d7765696768743a20626f6c643b0a09646973706c61793a20696e6c696e652021696d706f7274616e743b0a0970616464696e673a20302021696d706f7274616e743b0a7d0a0a2f2a204c696e6b73206f6e206772616469656e74206261636b67726f756e6473202a2f0a237365617263682d626f7820613a6c696e6b2c202e6e6176626720613a6c696e6b2c202e666f72756d6267202e68656164657220613a6c696e6b2c202e666f72616267202e68656164657220613a6c696e6b2c20746820613a6c696e6b207b0a09636f6c6f723a20234646464646463b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a237365617263682d626f7820613a766973697465642c202e6e6176626720613a766973697465642c202e666f72756d6267202e68656164657220613a766973697465642c202e666f72616267202e68656164657220613a766973697465642c20746820613a76697369746564207b0a09636f6c6f723a20234646464646463b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a237365617263682d626f7820613a686f7665722c202e6e6176626720613a686f7665722c202e666f72756d6267202e68656164657220613a686f7665722c202e666f72616267202e68656164657220613a686f7665722c20746820613a686f766572207b0a09636f6c6f723a20236666666666663b0a09746578742d6465636f726174696f6e3a20756e6465726c696e653b0a7d0a0a237365617263682d626f7820613a6163746976652c202e6e6176626720613a6163746976652c202e666f72756d6267202e68656164657220613a6163746976652c202e666f72616267202e68656164657220613a6163746976652c20746820613a616374697665207b0a09636f6c6f723a20236666666666663b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a2f2a204c696e6b7320666f7220666f72756d2f746f706963206c69737473202a2f0a612e666f72756d7469746c65207b0a09666f6e742d66616d696c793a2022547265627563686574204d53222c2048656c7665746963612c20417269616c2c2053616e732d73657269663b0a09666f6e742d73697a653a20312e32656d3b0a09666f6e742d7765696768743a20626f6c643b0a09636f6c6f723a20233839383938393b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a2f2a20612e666f72756d7469746c653a76697369746564207b20636f6c6f723a20233839383938393b207d202a2f0a0a612e666f72756d7469746c653a686f766572207b0a09636f6c6f723a20236263626362633b0a09746578742d6465636f726174696f6e3a20756e6465726c696e653b0a7d0a0a612e666f72756d7469746c653a616374697665207b0a09636f6c6f723a20233839383938393b0a7d0a0a612e746f7069637469746c65207b0a09666f6e742d66616d696c793a2022547265627563686574204d53222c2048656c7665746963612c20417269616c2c2053616e732d73657269663b0a09666f6e742d73697a653a20312e32656d3b0a09666f6e742d7765696768743a20626f6c643b0a09636f6c6f723a20233839383938393b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a2f2a20612e746f7069637469746c653a76697369746564207b20636f6c6f723a20236432643264323b207d202a2f0a0a612e746f7069637469746c653a686f766572207b0a09636f6c6f723a20236263626362633b0a09746578742d6465636f726174696f6e3a20756e6465726c696e653b0a7d0a0a612e746f7069637469746c653a616374697665207b0a09636f6c6f723a20233839383938393b0a7d0a0a2f2a20506f737420626f6479206c696e6b73202a2f0a2e706f73746c696e6b207b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a09636f6c6f723a20236432643264323b0a09626f726465722d626f74746f6d3a2031707820736f6c696420236432643264323b0a0970616464696e672d626f74746f6d3a20303b0a7d0a0a2e706f73746c696e6b3a76697369746564207b0a09636f6c6f723a20236264626462643b0a09626f726465722d626f74746f6d2d7374796c653a20646f747465643b0a09626f726465722d626f74746f6d2d636f6c6f723a20233636363636363b0a7d0a0a2e706f73746c696e6b3a616374697665207b0a09636f6c6f723a20236432643264323b0a7d0a0a2e706f73746c696e6b3a686f766572207b0a096261636b67726f756e642d636f6c6f723a20236636663666363b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a09636f6c6f723a20233430343034303b0a7d0a0a2e7369676e617475726520612c202e7369676e617475726520613a766973697465642c202e7369676e617475726520613a6163746976652c202e7369676e617475726520613a686f766572207b0a09626f726465723a206e6f6e653b0a09746578742d6465636f726174696f6e3a20756e6465726c696e653b0a096261636b67726f756e642d636f6c6f723a207472616e73706172656e743b0a7d0a0a2f2a2050726f66696c65206c696e6b73202a2f0a2e706f737470726f66696c6520613a6c696e6b2c202e706f737470726f66696c6520613a6163746976652c202e706f737470726f66696c6520613a766973697465642c202e706f737470726f66696c652064742e617574686f722061207b0a09666f6e742d7765696768743a20626f6c643b0a09636f6c6f723a20233839383938393b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a2e706f737470726f66696c6520613a686f7665722c202e706f737470726f66696c652064742e617574686f7220613a686f766572207b0a09746578742d6465636f726174696f6e3a20756e6465726c696e653b0a09636f6c6f723a20236433643364333b0a7d0a0a0a2f2a2050726f66696c6520736561726368726573756c7473202a2f090a2e736561726368202e706f737470726f66696c652061207b0a09636f6c6f723a20233839383938393b0a09746578742d6465636f726174696f6e3a206e6f6e653b200a09666f6e742d7765696768743a206e6f726d616c3b0a7d0a0a2e736561726368202e706f737470726f66696c6520613a686f766572207b0a09636f6c6f723a20236433643364333b0a09746578742d6465636f726174696f6e3a20756e6465726c696e653b200a7d0a0a2f2a204261636b20746f20746f70206f662070616765202a2f0a2e6261636b32746f70207b0a09636c6561723a20626f74683b0a096865696768743a20313170783b0a09746578742d616c69676e3a2072696768743b0a7d0a0a612e746f70207b0a096261636b67726f756e643a206e6f6e65206e6f2d72657065617420746f70206c6566743b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a0977696474683a207b494d475f49434f4e5f4241434b5f544f505f57494454487d70783b0a096865696768743a207b494d475f49434f4e5f4241434b5f544f505f4845494748547d70783b0a09646973706c61793a20626c6f636b3b0a09666c6f61743a2072696768743b0a096f766572666c6f773a2068696464656e3b0a096c65747465722d73706163696e673a203130303070783b0a09746578742d696e64656e743a20313170783b0a7d0a0a612e746f7032207b0a096261636b67726f756e643a206e6f6e65206e6f2d7265706561742030203530253b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a0970616464696e672d6c6566743a20313570783b0a7d0a0a2f2a204172726f77206c696e6b7320202a2f0a612e757009097b206261636b67726f756e643a206e6f6e65206e6f2d726570656174206c6566742063656e7465723b207d0a612e646f776e09097b206261636b67726f756e643a206e6f6e65206e6f2d7265706561742072696768742063656e7465723b207d0a612e6c65667409097b206261636b67726f756e643a206e6f6e65206e6f2d72657065617420337078203630253b207d0a612e726967687409097b206261636b67726f756e643a206e6f6e65206e6f2d72657065617420393525203630253b207d0a0a612e75702c20612e75703a6c696e6b2c20612e75703a6163746976652c20612e75703a76697369746564207b0a0970616464696e672d6c6566743a20313070783b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a09626f726465722d626f74746f6d2d77696474683a20303b0a7d0a0a612e75703a686f766572207b0a096261636b67726f756e642d706f736974696f6e3a206c65667420746f703b0a096261636b67726f756e642d636f6c6f723a207472616e73706172656e743b0a7d0a0a612e646f776e2c20612e646f776e3a6c696e6b2c20612e646f776e3a6163746976652c20612e646f776e3a76697369746564207b0a0970616464696e672d72696768743a20313070783b0a7d0a0a612e646f776e3a686f766572207b0a096261636b67726f756e642d706f736974696f6e3a20726967687420626f74746f6d3b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a612e6c6566742c20612e6c6566743a6163746976652c20612e6c6566743a76697369746564207b0a0970616464696e672d6c6566743a20313270783b0a7d0a0a612e6c6566743a686f766572207b0a09636f6c6f723a20236432643264323b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a2030203630253b0a7d0a0a612e72696768742c20612e72696768743a6163746976652c20612e72696768743a76697369746564207b0a0970616464696e672d72696768743a20313270783b0a7d0a0a612e72696768743a686f766572207b0a09636f6c6f723a20236432643264323b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a2031303025203630253b0a7d0a2f2a2070726f53696c76657220436f6e74656e74205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a756c2e746f7069636c697374207b0a09646973706c61793a20626c6f636b3b0a096c6973742d7374796c652d747970653a206e6f6e653b0a096d617267696e3a20303b0a7d0a0a756c2e666f72756d73207b0a096261636b67726f756e643a2023663966396639206e6f6e65207265706561742d78203020303b0a7d0a0a756c2e746f7069636c697374206c69207b0a09646973706c61793a20626c6f636b3b0a096c6973742d7374796c652d747970653a206e6f6e653b0a09636f6c6f723a20233737373737373b0a096d617267696e3a20303b0a7d0a0a756c2e746f7069636c69737420646c207b0a09706f736974696f6e3a2072656c61746976653b0a7d0a0a756c2e746f7069636c697374206c692e726f7720646c207b0a0970616464696e673a2032707820303b0a7d0a0a756c2e746f7069636c697374206474207b0a09646973706c61793a20626c6f636b3b0a09666c6f61743a206c6566743b0a0977696474683a203530253b0a09666f6e742d73697a653a20312e31656d3b0a0970616464696e672d6c6566743a203570783b0a0970616464696e672d72696768743a203570783b0a7d0a0a756c2e746f7069636c697374206464207b0a09646973706c61793a20626c6f636b3b0a09666c6f61743a206c6566743b0a09626f726465722d6c6566743a2031707820736f6c696420234646464646463b0a0970616464696e673a2034707820303b0a7d0a0a756c2e746f7069636c6973742064666e207b0a092f2a204c6162656c7320666f7220706f73742f7669657720636f756e7473202a2f0a09646973706c61793a206e6f6e653b0a7d0a0a756c2e746f7069636c697374206c692e726f7720647420612e737562666f72756d207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a2030203530253b0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a09706f736974696f6e3a2072656c61746976653b0a0977686974652d73706163653a206e6f777261703b0a0970616464696e673a20302030203020313270783b0a7d0a0a2e666f72756d2d696d616765207b0a09666c6f61743a206c6566743b0a0970616464696e672d746f703a203570783b0a096d617267696e2d72696768743a203570783b0a7d0a0a6c692e726f77207b0a09626f726465722d746f703a2031707820736f6c696420234646464646463b0a09626f726465722d626f74746f6d3a2031707820736f6c696420233866386638663b0a7d0a0a6c692e726f77207374726f6e67207b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636f6c6f723a20233030303030303b0a7d0a0a6c692e726f773a686f766572207b0a096261636b67726f756e642d636f6c6f723a20236636663666363b0a7d0a0a6c692e726f773a686f766572206464207b0a09626f726465722d6c6566742d636f6c6f723a20234343434343433b0a7d0a0a6c692e6865616465722064742c206c692e686561646572206464207b0a096c696e652d6865696768743a2031656d3b0a09626f726465722d6c6566742d77696474683a20303b0a096d617267696e3a2032707820302034707820303b0a09636f6c6f723a20234646464646463b0a0970616464696e672d746f703a203270783b0a0970616464696e672d626f74746f6d3a203270783b0a09666f6e742d73697a653a2031656d3b0a09666f6e742d66616d696c793a20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a09746578742d7472616e73666f726d3a207570706572636173653b0a7d0a0a6c692e686561646572206474207b0a09666f6e742d7765696768743a20626f6c643b0a7d0a0a6c692e686561646572206464207b0a096d617267696e2d6c6566743a203170783b0a7d0a0a6c692e68656164657220646c2e69636f6e207b0a096d696e2d6865696768743a20303b0a7d0a0a6c692e68656164657220646c2e69636f6e206474207b0a092f2a20547765616b20666f72206865616465727320616c69676e6d656e74207768656e20666f6c6465722069636f6e2075736564202a2f0a0970616464696e672d6c6566743a20303b0a0970616464696e672d72696768743a20353070783b0a7d0a0a2f2a20466f72756d206c69737420636f6c756d6e207374796c6573202a2f0a646c2e69636f6e207b0a096d696e2d6865696768743a20333570783b0a096261636b67726f756e642d706f736974696f6e3a2031307078203530253b09092f2a20506f736974696f6e206f6620666f6c6465722069636f6e202a2f0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a7d0a0a646c2e69636f6e206474207b0a0970616464696e672d6c6566743a20343570783b09090909092f2a20537061636520666f7220666f6c6465722069636f6e202a2f0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a096261636b67726f756e642d706f736974696f6e3a20357078203935253b09092f2a20506f736974696f6e206f6620746f7069632069636f6e202a2f0a7d0a0a64642e706f7374732c2064642e746f706963732c2064642e7669657773207b0a0977696474683a2038253b0a09746578742d616c69676e3a2063656e7465723b0a096c696e652d6865696768743a20322e32656d3b0a09666f6e742d73697a653a20312e32656d3b0a7d0a0a64642e6c617374706f7374207b0a0977696474683a203235253b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a64642e7265646972656374207b0a09666f6e742d73697a653a20312e31656d3b0a096c696e652d6865696768743a20322e35656d3b0a7d0a0a64642e6d6f6465726174696f6e207b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a64642e6c617374706f7374207370616e2c20756c2e746f7069636c6973742064642e7365617263686279207370616e2c20756c2e746f7069636c6973742064642e696e666f207370616e2c20756c2e746f7069636c6973742064642e74696d65207370616e2c2064642e7265646972656374207370616e2c2064642e6d6f6465726174696f6e207370616e207b0a09646973706c61793a20626c6f636b3b0a0970616464696e672d6c6566743a203570783b0a7d0a0a64642e74696d65207b0a0977696474683a206175746f3b0a096c696e652d6865696768743a20323030253b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a64642e6578747261207b0a0977696474683a203132253b0a096c696e652d6865696768743a20323030253b0a09746578742d616c69676e3a2063656e7465723b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a64642e6d61726b207b0a09666c6f61743a2072696768742021696d706f7274616e743b0a0977696474683a2039253b0a09746578742d616c69676e3a2063656e7465723b0a096c696e652d6865696768743a20323030253b0a09666f6e742d73697a653a20312e32656d3b0a7d0a0a64642e696e666f207b0a0977696474683a203330253b0a7d0a0a64642e6f7074696f6e207b0a0977696474683a203135253b0a096c696e652d6865696768743a20323030253b0a09746578742d616c69676e3a2063656e7465723b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a64642e7365617263686279207b0a0977696474683a203437253b0a09666f6e742d73697a653a20312e31656d3b0a096c696e652d6865696768743a2031656d3b0a7d0a0a756c2e746f7069636c6973742064642e7365617263686578747261207b0a096d617267696e2d6c6566743a203570783b0a0970616464696e673a20302e32656d20303b0a09666f6e742d73697a653a20312e31656d3b0a09636f6c6f723a20233333333333333b0a09626f726465722d6c6566743a206e6f6e653b0a09636c6561723a20626f74683b0a0977696474683a203938253b0a096f766572666c6f773a2068696464656e3b0a7d0a0a2f2a20436f6e7461696e657220666f7220706f73742f7265706c7920627574746f6e7320616e6420706167696e6174696f6e202a2f0a2e746f7069632d616374696f6e73207b0a096d617267696e2d626f74746f6d3a203370783b0a09666f6e742d73697a653a20312e31656d3b0a096865696768743a20323870783b0a096d696e2d6865696768743a20323870783b0a7d0a6469765b636c6173735d2e746f7069632d616374696f6e73207b0a096865696768743a206175746f3b0a7d0a0a2f2a20506f737420626f6479207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e706f7374626f6479207b0a0970616464696e673a20303b0a096c696e652d6865696768743a20312e3438656d3b0a09636f6c6f723a20233333333333333b0a0977696474683a203736253b0a09666c6f61743a206c6566743b0a09636c6561723a20626f74683b0a7d0a0a2e706f7374626f6479202e69676e6f7265207b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a2e706f7374626f64792068332e6669727374207b0a092f2a2054686520666972737420706f7374206f6e20746865207061676520757365732074686973202a2f0a09666f6e742d73697a653a20312e37656d3b0a7d0a0a2e706f7374626f6479206833207b0a092f2a20506f7374626f6479207265717569726573206120646966666572656e7420683320666f726d6174202d20736f206368616e67652069742068657265202a2f0a09666f6e742d73697a653a20312e35656d3b0a0970616464696e673a203270782030203020303b0a096d617267696e3a2030203020302e33656d20302021696d706f7274616e743b0a09746578742d7472616e73666f726d3a206e6f6e653b0a09626f726465723a206e6f6e653b0a09666f6e742d66616d696c793a2022547265627563686574204d53222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a096c696e652d6865696768743a20313235253b0a7d0a0a2e706f7374626f647920683320696d67207b0a092f2a20416c736f2073656520747765616b732e637373202a2f0a09766572746963616c2d616c69676e3a20626f74746f6d3b0a7d0a0a2e706f7374626f6479202e636f6e74656e74207b0a09666f6e742d73697a653a20312e33656d3b0a7d0a0a2e736561726368202e706f7374626f6479207b0a0977696474683a203638250a7d0a0a2f2a20546f706963207265766965772070616e656c0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a23726576696577207b0a096d617267696e2d746f703a2032656d3b0a7d0a0a23746f706963726576696577207b0a0970616464696e672d72696768743a203570783b0a096f766572666c6f773a206175746f3b0a096865696768743a2033303070783b0a7d0a0a23746f706963726576696577202e706f7374626f6479207b0a0977696474683a206175746f3b0a09666c6f61743a206e6f6e653b0a096d617267696e3a20303b0a096865696768743a206175746f3b0a7d0a0a23746f706963726576696577202e706f7374207b0a096865696768743a206175746f3b0a7d0a0a23746f706963726576696577206832207b0a09626f726465722d626f74746f6d2d77696474683a20303b0a7d0a0a2f2a20436f6e74656e7420636f6e7461696e6572207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e636f6e74656e74207b0a096d696e2d6865696768743a2033656d3b0a096f766572666c6f773a2068696464656e3b0a096c696e652d6865696768743a20312e34656d3b0a09666f6e742d66616d696c793a20224c7563696461204772616e6465222c2022547265627563686574204d53222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09666f6e742d73697a653a2031656d3b0a09636f6c6f723a20233333333333333b0a7d0a0a2e636f6e74656e742068322c202e70616e656c206832207b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636f6c6f723a20233938393839383b0a09626f726465722d626f74746f6d3a2031707820736f6c696420234343434343433b0a09666f6e742d73697a653a20312e36656d3b0a096d617267696e2d746f703a20302e35656d3b0a096d617267696e2d626f74746f6d3a20302e35656d3b0a0970616464696e672d626f74746f6d3a20302e35656d3b0a7d0a0a2e70616e656c206833207b0a096d617267696e3a20302e35656d20303b0a7d0a0a2e70616e656c2070207b0a09666f6e742d73697a653a20312e32656d3b0a096d617267696e2d626f74746f6d3a2031656d3b0a096c696e652d6865696768743a20312e34656d3b0a7d0a0a2e636f6e74656e742070207b0a09666f6e742d66616d696c793a20224c7563696461204772616e6465222c2022547265627563686574204d53222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09666f6e742d73697a653a20312e32656d3b0a096d617267696e2d626f74746f6d3a2031656d3b0a096c696e652d6865696768743a20312e34656d3b0a7d0a0a646c2e666171207b0a09666f6e742d66616d696c793a20224c7563696461204772616e6465222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09666f6e742d73697a653a20312e31656d3b0a096d617267696e2d746f703a2031656d3b0a096d617267696e2d626f74746f6d3a2032656d3b0a096c696e652d6865696768743a20312e34656d3b0a7d0a0a646c2e666171206474207b0a09666f6e742d7765696768743a20626f6c643b0a09636f6c6f723a20233333333333333b0a7d0a0a2e636f6e74656e7420646c2e666171207b0a09666f6e742d73697a653a20312e32656d3b0a096d617267696e2d626f74746f6d3a20302e35656d3b0a7d0a0a2e636f6e74656e74206c69207b0a096c6973742d7374796c652d747970653a20696e68657269743b0a7d0a0a2e636f6e74656e7420756c2c202e636f6e74656e74206f6c207b0a096d617267696e2d626f74746f6d3a2031656d3b0a096d617267696e2d6c6566743a2033656d3b0a7d0a0a2e706f737468696c6974207b0a096261636b67726f756e642d636f6c6f723a20236633663366333b0a09636f6c6f723a20234243424342433b0a0970616464696e673a20302032707820317078203270783b0a7d0a0a2e616e6e6f756e63652c202e756e72656164706f7374207b0a092f2a20486967686c696768742074686520616e6e6f756e63656d656e7473202620756e7265616420706f73747320626f78202a2f0a09626f726465722d6c6566742d636f6c6f723a20234243424342433b0a09626f726465722d72696768742d636f6c6f723a20234243424342433b0a7d0a0a2f2a20506f737420617574686f72202a2f0a702e617574686f72207b0a096d617267696e3a2030203135656d20302e36656d20303b0a0970616464696e673a203020302035707820303b0a09666f6e742d66616d696c793a2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09666f6e742d73697a653a2031656d3b0a096c696e652d6865696768743a20312e32656d3b0a7d0a0a2f2a20506f7374207369676e6174757265202a2f0a2e7369676e6174757265207b0a096d617267696e2d746f703a20312e35656d3b0a0970616464696e672d746f703a20302e32656d3b0a09666f6e742d73697a653a20312e31656d3b0a09626f726465722d746f703a2031707820736f6c696420234343434343433b0a09636c6561723a206c6566743b0a096c696e652d6865696768743a20313430253b0a096f766572666c6f773a2068696464656e3b0a0977696474683a20313030253b0a7d0a0a6464202e7369676e6174757265207b0a096d617267696e3a20303b0a0970616464696e673a20303b0a09636c6561723a206e6f6e653b0a09626f726465723a206e6f6e653b0a7d0a0a2e7369676e6174757265206c69207b0a096c6973742d7374796c652d747970653a20696e68657269743b0a7d0a0a2e7369676e617475726520756c2c202e7369676e6174757265206f6c207b0a096d617267696e2d626f74746f6d3a2031656d3b0a096d617267696e2d6c6566743a2033656d3b0a7d0a0a2f2a20506f7374206e6f746963696573202a2f0a2e6e6f74696365207b0a09666f6e742d66616d696c793a20224c7563696461204772616e6465222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a0977696474683a206175746f3b0a096d617267696e2d746f703a20312e35656d3b0a0970616464696e672d746f703a20302e32656d3b0a09666f6e742d73697a653a2031656d3b0a09626f726465722d746f703a203170782064617368656420234343434343433b0a09636c6561723a206c6566743b0a096c696e652d6865696768743a20313330253b0a7d0a0a2f2a204a756d7020746f20706f7374206c696e6b20666f72206e6f77202a2f0a756c2e736561726368726573756c7473207b0a096c6973742d7374796c653a206e6f6e653b0a09746578742d616c69676e3a2072696768743b0a09636c6561723a20626f74683b0a7d0a0a2f2a20424220436f6465207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2f2a2051756f746520626c6f636b202a2f0a626c6f636b71756f7465207b0a096261636b67726f756e643a2023656265626562206e6f6e652036707820387078206e6f2d7265706561743b0a09626f726465723a2031707820736f6c696420236462646264623b0a09666f6e742d73697a653a20302e3935656d3b0a096d617267696e3a20302e35656d20317078203020323570783b0a096f766572666c6f773a2068696464656e3b0a0970616464696e673a203570783b0a7d0a0a626c6f636b71756f746520626c6f636b71756f7465207b0a092f2a204e65737465642071756f746573202a2f0a096261636b67726f756e642d636f6c6f723a20236261626162613b0a09666f6e742d73697a653a2031656d3b0a096d617267696e3a20302e35656d20317078203020313570783b090a7d0a0a626c6f636b71756f746520626c6f636b71756f746520626c6f636b71756f7465207b0a092f2a204e65737465642071756f746573202a2f0a096261636b67726f756e642d636f6c6f723a20236534653465343b0a7d0a0a626c6f636b71756f74652063697465207b0a092f2a20557365726e616d652f736f75726365206f662071756f746572202a2f0a09666f6e742d7374796c653a206e6f726d616c3b0a09666f6e742d7765696768743a20626f6c643b0a096d617267696e2d6c6566743a20323070783b0a09646973706c61793a20626c6f636b3b0a09666f6e742d73697a653a20302e39656d3b0a7d0a0a626c6f636b71756f746520636974652063697465207b0a09666f6e742d73697a653a2031656d3b0a7d0a0a626c6f636b71756f74652e756e6369746564207b0a0970616464696e672d746f703a20323570783b0a7d0a0a2f2a20436f646520626c6f636b202a2f0a646c2e636f6465626f78207b0a0970616464696e673a203370783b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a09626f726465723a2031707820736f6c696420236438643864383b0a09666f6e742d73697a653a2031656d3b0a7d0a0a646c2e636f6465626f78206474207b0a09746578742d7472616e73666f726d3a207570706572636173653b0a09626f726465722d626f74746f6d3a2031707820736f6c696420234343434343433b0a096d617267696e2d626f74746f6d3a203370783b0a09666f6e742d73697a653a20302e38656d3b0a09666f6e742d7765696768743a20626f6c643b0a09646973706c61793a20626c6f636b3b0a7d0a0a626c6f636b71756f746520646c2e636f6465626f78207b0a096d617267696e2d6c6566743a20303b0a7d0a0a646c2e636f6465626f7820636f6465207b0a092f2a20416c736f2073656520747765616b732e637373202a2f0a096f766572666c6f773a206175746f3b0a09646973706c61793a20626c6f636b3b0a096865696768743a206175746f3b0a096d61782d6865696768743a2032303070783b0a0977686974652d73706163653a206e6f726d616c3b0a0970616464696e672d746f703a203570783b0a09666f6e743a20302e39656d204d6f6e61636f2c2022416e64616c65204d6f6e6f222c22436f7572696572204e6577222c20436f75726965722c206d6f6e6f3b0a096c696e652d6865696768743a20312e33656d3b0a09636f6c6f723a20233862386238623b0a096d617267696e3a2032707820303b0a7d0a0a2e73796e746178626709097b20636f6c6f723a20234646464646463b207d0a2e73796e746178636f6d6d656e74097b20636f6c6f723a20233030303030303b207d0a2e73796e74617864656661756c74097b20636f6c6f723a20236263626362633b207d0a2e73796e74617868746d6c09097b20636f6c6f723a20233030303030303b207d0a2e73796e7461786b6579776f7264097b20636f6c6f723a20233538353835383b207d0a2e73796e746178737472696e67097b20636f6c6f723a20236137613761373b207d0a0a2f2a204174746163686d656e74730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e617474616368626f78207b0a09666c6f61743a206c6566743b0a0977696474683a206175746f3b200a096d617267696e3a20357078203570782035707820303b0a0970616464696e673a203670783b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a09626f726465723a203170782064617368656420236438643864383b0a09636c6561723a206c6566743b0a7d0a0a2e706d2d6d657373616765202e617474616368626f78207b0a096261636b67726f756e642d636f6c6f723a20236633663366333b0a7d0a0a2e617474616368626f78206474207b0a09666f6e742d66616d696c793a20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a09746578742d7472616e73666f726d3a207570706572636173653b0a7d0a0a2e617474616368626f78206464207b0a096d617267696e2d746f703a203470783b0a0970616464696e672d746f703a203470783b0a09636c6561723a206c6566743b0a09626f726465722d746f703a2031707820736f6c696420236438643864383b0a7d0a0a2e617474616368626f78206464206464207b0a09626f726465723a206e6f6e653b0a7d0a0a2e617474616368626f782070207b0a096c696e652d6865696768743a20313130253b0a09636f6c6f723a20233636363636363b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636c6561723a206c6566743b0a7d0a0a2e617474616368626f7820702e73746174730a7b0a096c696e652d6865696768743a20313130253b0a09636f6c6f723a20233636363636363b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636c6561723a206c6566743b0a7d0a0a2e6174746163682d696d616765207b0a096d617267696e3a2033707820303b0a0977696474683a20313030253b0a096d61782d6865696768743a2033353070783b0a096f766572666c6f773a206175746f3b0a7d0a0a2e6174746163682d696d61676520696d67207b0a09626f726465723a2031707820736f6c696420233939393939393b0a2f2a09637572736f723a206d6f76653b202a2f0a09637572736f723a2064656661756c743b0a7d0a0a2f2a20496e6c696e6520696d616765207468756d626e61696c73202a2f0a6469762e696e6c696e652d6174746163686d656e7420646c2e7468756d626e61696c2c206469762e696e6c696e652d6174746163686d656e7420646c2e66696c65207b0a09646973706c61793a20626c6f636b3b0a096d617267696e2d626f74746f6d3a203470783b0a7d0a0a6469762e696e6c696e652d6174746163686d656e742070207b0a09666f6e742d73697a653a20313030253b0a7d0a0a646c2e66696c65207b0a09666f6e742d66616d696c793a2056657264616e612c20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a09646973706c61793a20626c6f636b3b0a7d0a0a646c2e66696c65206474207b0a09746578742d7472616e73666f726d3a206e6f6e653b0a096d617267696e3a20303b0a0970616464696e673a20303b0a09666f6e742d7765696768743a20626f6c643b0a09666f6e742d66616d696c793a2056657264616e612c20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a7d0a0a646c2e66696c65206464207b0a09636f6c6f723a20233636363636363b0a096d617267696e3a20303b0a0970616464696e673a20303b090a7d0a0a646c2e7468756d626e61696c20696d67207b0a0970616464696e673a203370783b0a09626f726465723a2031707820736f6c696420233636363636363b0a096261636b67726f756e642d636f6c6f723a20234646463b0a7d0a0a646c2e7468756d626e61696c206464207b0a09636f6c6f723a20233636363636363b0a09666f6e742d7374796c653a206974616c69633b0a09666f6e742d66616d696c793a2056657264616e612c20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a7d0a0a2e617474616368626f7820646c2e7468756d626e61696c206464207b0a09666f6e742d73697a653a20313030253b0a7d0a0a646c2e7468756d626e61696c20647420613a686f766572207b0a096261636b67726f756e642d636f6c6f723a20234545454545453b0a7d0a0a646c2e7468756d626e61696c20647420613a686f76657220696d67207b0a09626f726465723a2031707820736f6c696420236432643264323b0a7d0a0a2f2a20506f737420706f6c6c207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a6669656c647365742e706f6c6c73207b0a09666f6e742d66616d696c793a2022547265627563686574204d53222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a7d0a0a6669656c647365742e706f6c6c7320646c207b0a096d617267696e2d746f703a203570783b0a09626f726465722d746f703a2031707820736f6c696420236532653265323b0a0970616464696e673a203570782030203020303b0a096c696e652d6865696768743a20313230253b0a09636f6c6f723a20233636363636363b0a7d0a0a6669656c647365742e706f6c6c7320646c2e766f746564207b0a09666f6e742d7765696768743a20626f6c643b0a09636f6c6f723a20233030303030303b0a7d0a0a6669656c647365742e706f6c6c73206474207b0a09746578742d616c69676e3a206c6566743b0a09666c6f61743a206c6566743b0a09646973706c61793a20626c6f636b3b0a0977696474683a203330253b0a09626f726465722d72696768743a206e6f6e653b0a0970616464696e673a20303b0a096d617267696e3a20303b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a6669656c647365742e706f6c6c73206464207b0a09666c6f61743a206c6566743b0a0977696474683a203130253b0a09626f726465722d6c6566743a206e6f6e653b0a0970616464696e673a2030203570783b0a096d617267696e2d6c6566743a20303b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a6669656c647365742e706f6c6c732064642e726573756c74626172207b0a0977696474683a203530253b0a7d0a0a6669656c647365742e706f6c6c7320646420696e707574207b0a096d617267696e3a2032707820303b0a7d0a0a6669656c647365742e706f6c6c7320646420646976207b0a09746578742d616c69676e3a2072696768743b0a09666f6e742d66616d696c793a20417269616c2c2048656c7665746963612c2073616e732d73657269663b0a09636f6c6f723a20234646464646463b0a09666f6e742d7765696768743a20626f6c643b0a0970616464696e673a2030203270783b0a096f766572666c6f773a2076697369626c653b0a096d696e2d77696474683a2032253b0a7d0a0a2e706f6c6c62617231207b0a096261636b67726f756e642d636f6c6f723a20236161616161613b0a09626f726465722d626f74746f6d3a2031707820736f6c696420233734373437343b0a09626f726465722d72696768743a2031707820736f6c696420233734373437343b0a7d0a0a2e706f6c6c62617232207b0a096261636b67726f756e642d636f6c6f723a20236265626562653b0a09626f726465722d626f74746f6d3a2031707820736f6c696420233863386338633b0a09626f726465722d72696768743a2031707820736f6c696420233863386338633b0a7d0a0a2e706f6c6c62617233207b0a096261636b67726f756e642d636f6c6f723a20234431443144313b0a09626f726465722d626f74746f6d3a2031707820736f6c696420236161616161613b0a09626f726465722d72696768743a2031707820736f6c696420236161616161613b0a7d0a0a2e706f6c6c62617234207b0a096261636b67726f756e642d636f6c6f723a20236534653465343b0a09626f726465722d626f74746f6d3a2031707820736f6c696420236265626562653b0a09626f726465722d72696768743a2031707820736f6c696420236265626562653b0a7d0a0a2e706f6c6c62617235207b0a096261636b67726f756e642d636f6c6f723a20236638663866383b0a09626f726465722d626f74746f6d3a2031707820736f6c696420234431443144313b0a09626f726465722d72696768743a2031707820736f6c696420234431443144313b0a7d0a0a2f2a20506f737465722070726f66696c6520626c6f636b0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e706f737470726f66696c65207b0a092f2a20416c736f2073656520747765616b732e637373202a2f0a096d617267696e3a203570782030203130707820303b0a096d696e2d6865696768743a20383070783b0a09636f6c6f723a20233636363636363b0a09626f726465722d6c6566743a2031707820736f6c696420234646464646463b0a0977696474683a203232253b0a09666c6f61743a2072696768743b0a09646973706c61793a20696e6c696e653b0a7d0a2e706d202e706f737470726f66696c65207b0a09626f726465722d6c6566743a2031707820736f6c696420234444444444443b0a7d0a0a2e706f737470726f66696c652064642c202e706f737470726f66696c65206474207b0a096c696e652d6865696768743a20312e32656d3b0a096d617267696e2d6c6566743a203870783b0a7d0a0a2e706f737470726f66696c65207374726f6e67207b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636f6c6f723a20233030303030303b0a7d0a0a2e617661746172207b0a09626f726465723a206e6f6e653b0a096d617267696e2d626f74746f6d3a203370783b0a7d0a0a2e6f6e6c696e65207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a203130302520303b0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a7d0a0a2f2a20506f737465722070726f66696c652075736564206279207365617263682a2f0a2e736561726368202e706f737470726f66696c65207b0a0977696474683a203330253b0a7d0a0a2f2a20706d206c69737420696e20636f6d706f7365206d657373616765206966206d61737320706d20697320656e61626c6564202a2f0a646c2e706d6c697374206474207b0a0977696474683a203630252021696d706f7274616e743b0a7d0a0a646c2e706d6c697374206474207465787461726561207b0a0977696474683a203935253b0a7d0a0a646c2e706d6c697374206464207b0a096d617267696e2d6c6566743a203631252021696d706f7274616e743b0a096d617267696e2d626f74746f6d3a203270783b0a7d0a2f2a2070726f53696c76657220427574746f6e205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2f2a20526f6c6c6f76657220627574746f6e730a2020204261736564206f6e3a20687474703a2f2f77656c6c7374796c65642e636f6d2f6373732d6e6f7072656c6f61642d726f6c6c6f766572732e68746d6c0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e627574746f6e73207b0a09666c6f61743a206c6566743b0a0977696474683a206175746f3b0a096865696768743a206175746f3b0a7d0a0a2f2a20526f6c6c6f766572207374617465202a2f0a2e627574746f6e7320646976207b0a09666c6f61743a206c6566743b0a096d617267696e3a203020357078203020303b0a096261636b67726f756e642d706f736974696f6e3a203020313030253b0a7d0a0a2f2a20526f6c6c6f6666207374617465202a2f0a2e627574746f6e73206469762061207b0a09646973706c61793a20626c6f636b3b0a0977696474683a20313030253b0a096865696768743a20313030253b0a096261636b67726f756e642d706f736974696f6e3a203020303b0a09706f736974696f6e3a2072656c61746976653b0a096f766572666c6f773a2068696464656e3b0a7d0a0a2f2a2048696465203c613e207465787420616e642068696465206f66662d737461746520696d616765207768656e20726f6c6c696e67206f766572202870726576656e747320666c69636b657220696e20494529202a2f0a2f2a2e627574746f6e7320646976207370616e09097b20646973706c61793a206e6f6e653b207d2a2f0a2f2a2e627574746f6e732064697620613a686f766572097b206261636b67726f756e642d696d6167653a206e6f6e653b207d2a2f0a2e627574746f6e7320646976207370616e0909097b20706f736974696f6e3a206162736f6c7574653b2077696474683a20313030253b206865696768743a20313030253b20637572736f723a20706f696e7465723b7d0a2e627574746f6e732064697620613a686f766572207370616e097b206261636b67726f756e642d706f736974696f6e3a203020313030253b207d0a0a2f2a2042696720627574746f6e20696d61676573202a2f0a2e7265706c792d69636f6e207370616e097b206261636b67726f756e643a207472616e73706172656e74206e6f6e6520302030206e6f2d7265706561743b207d0a2e706f73742d69636f6e207370616e09097b206261636b67726f756e643a207472616e73706172656e74206e6f6e6520302030206e6f2d7265706561743b207d0a2e6c6f636b65642d69636f6e207370616e097b206261636b67726f756e643a207472616e73706172656e74206e6f6e6520302030206e6f2d7265706561743b207d0a2e706d7265706c792d69636f6e207370616e097b206261636b67726f756e643a206e6f6e6520302030206e6f2d7265706561743b207d0a2e6e6577706d2d69636f6e207370616e20097b206261636b67726f756e643a206e6f6e6520302030206e6f2d7265706561743b207d0a2e666f7277617264706d2d69636f6e207370616e20097b206261636b67726f756e643a206e6f6e6520302030206e6f2d7265706561743b207d0a0a2f2a205365742062696720627574746f6e2064696d656e73696f6e73202a2f0a2e627574746f6e73206469762e7265706c792d69636f6e09097b2077696474683a207b494d475f425554544f4e5f544f5049435f5245504c595f57494454487d70783b206865696768743a207b494d475f425554544f4e5f544f5049435f5245504c595f4845494748547d70783b207d0a2e627574746f6e73206469762e706f73742d69636f6e09097b2077696474683a207b494d475f425554544f4e5f544f5049435f4e45575f57494454487d70783b206865696768743a207b494d475f425554544f4e5f544f5049435f4e45575f4845494748547d70783b207d0a2e627574746f6e73206469762e6c6f636b65642d69636f6e097b2077696474683a207b494d475f425554544f4e5f544f5049435f4c4f434b45445f57494454487d70783b206865696768743a207b494d475f425554544f4e5f544f5049435f4c4f434b45445f4845494748547d70783b207d0a2e627574746f6e73206469762e706d7265706c792d69636f6e097b2077696474683a207b494d475f425554544f4e5f504d5f5245504c595f57494454487d70783b206865696768743a207b494d475f425554544f4e5f504d5f5245504c595f4845494748547d70783b207d0a2e627574746f6e73206469762e6e6577706d2d69636f6e09097b2077696474683a207b494d475f425554544f4e5f504d5f4e45575f57494454487d70783b206865696768743a207b494d475f425554544f4e5f504d5f4e45575f4845494748547d70783b207d0a2e627574746f6e73206469762e666f7277617264706d2d69636f6e097b2077696474683a207b494d475f425554544f4e5f504d5f464f52574152445f57494454487d70783b206865696768743a207b494d475f425554544f4e5f504d5f464f52574152445f4845494748547d70783b207d0a0a2f2a205375622d68656164657220286e617669676174696f6e20626172290a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a612e7072696e742c20612e73656e64656d61696c2c20612e666f6e7473697a65207b0a09646973706c61793a20626c6f636b3b0a096f766572666c6f773a2068696464656e3b0a096865696768743a20313870783b0a09746578742d696e64656e743a202d3530303070783b0a09746578742d616c69676e3a206c6566743b0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a7d0a0a612e7072696e74207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a0977696474683a20323270783b0a7d0a0a612e73656e64656d61696c207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a0977696474683a20323270783b0a7d0a0a612e666f6e7473697a65207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d706f736974696f6e3a2030202d3170783b0a0977696474683a20323970783b0a7d0a0a612e666f6e7473697a653a686f766572207b0a096261636b67726f756e642d706f736974696f6e3a2030202d323070783b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a2f2a2049636f6e20696d616765730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2e73697465686f6d652c202e69636f6e2d6661712c202e69636f6e2d6d656d626572732c202e69636f6e2d686f6d652c202e69636f6e2d7563702c202e69636f6e2d72656769737465722c202e69636f6e2d6c6f676f75742c0a2e69636f6e2d626f6f6b6d61726b2c202e69636f6e2d62756d702c202e69636f6e2d7375627363726962652c202e69636f6e2d756e7375627363726962652c202e69636f6e2d70616765732c202e69636f6e2d736561726368207b0a096261636b67726f756e642d706f736974696f6e3a2030203530253b0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a0970616464696e673a203170782030203020313770783b0a7d0a0a2f2a20506f737465722070726f66696c652069636f6e730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a756c2e70726f66696c652d69636f6e73207b0a0970616464696e672d746f703a20313070783b0a096c6973742d7374796c653a206e6f6e653b0a7d0a0a2f2a20526f6c6c6f766572207374617465202a2f0a756c2e70726f66696c652d69636f6e73206c69207b0a09666c6f61743a206c6566743b0a096d617267696e3a2030203670782033707820303b0a096261636b67726f756e642d706f736974696f6e3a203020313030253b0a7d0a0a2f2a20526f6c6c6f6666207374617465202a2f0a756c2e70726f66696c652d69636f6e73206c692061207b0a09646973706c61793a20626c6f636b3b0a0977696474683a20313030253b0a096865696768743a20313030253b0a096261636b67726f756e642d706f736974696f6e3a203020303b0a7d0a0a2f2a2048696465203c613e207465787420616e642068696465206f66662d737461746520696d616765207768656e20726f6c6c696e67206f766572202870726576656e747320666c69636b657220696e20494529202a2f0a756c2e70726f66696c652d69636f6e73206c69207370616e207b20646973706c61793a6e6f6e653b207d0a756c2e70726f66696c652d69636f6e73206c6920613a686f766572207b206261636b67726f756e643a206e6f6e653b207d0a0a2f2a20506f736974696f6e696e67206f66206d6f64657261746f722069636f6e73202a2f0a2e706f7374626f647920756c2e70726f66696c652d69636f6e73207b0a09666c6f61743a2072696768743b0a0977696474683a206175746f3b0a0970616464696e673a20303b0a7d0a0a2e706f7374626f647920756c2e70726f66696c652d69636f6e73206c69207b0a096d617267696e3a2030203370783b0a7d0a0a2f2a2050726f66696c652026206e617669676174696f6e2069636f6e73202a2f0a2e656d61696c2d69636f6e2c202e656d61696c2d69636f6e206109097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e61696d2d69636f6e2c202e61696d2d69636f6e20610909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e7961686f6f2d69636f6e2c202e7961686f6f2d69636f6e206109097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e7765622d69636f6e2c202e7765622d69636f6e20610909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e6d736e6d2d69636f6e2c202e6d736e6d2d69636f6e20610909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e6963712d69636f6e2c202e6963712d69636f6e20610909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e6a61626265722d69636f6e2c202e6a61626265722d69636f6e206109097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e706d2d69636f6e2c202e706d2d69636f6e2061090909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e71756f74652d69636f6e2c202e71756f74652d69636f6e206109097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a0a2f2a204d6f64657261746f722069636f6e73202a2f0a2e7265706f72742d69636f6e2c202e7265706f72742d69636f6e206109097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e7761726e2d69636f6e2c202e7761726e2d69636f6e20610909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e656469742d69636f6e2c202e656469742d69636f6e20610909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e64656c6574652d69636f6e2c202e64656c6574652d69636f6e206109097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a2e696e666f2d69636f6e2c202e696e666f2d69636f6e20610909097b206261636b67726f756e643a206e6f6e6520746f70206c656674206e6f2d7265706561743b207d0a0a2f2a205365742070726f66696c652069636f6e2064696d656e73696f6e73202a2f0a756c2e70726f66696c652d69636f6e73206c692e656d61696c2d69636f6e09097b2077696474683a207b494d475f49434f4e5f434f4e544143545f454d41494c5f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f454d41494c5f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e61696d2d69636f6e097b2077696474683a207b494d475f49434f4e5f434f4e544143545f41494d5f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f41494d5f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e7961686f6f2d69636f6e097b2077696474683a207b494d475f49434f4e5f434f4e544143545f5941484f4f5f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f5941484f4f5f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e7765622d69636f6e097b2077696474683a207b494d475f49434f4e5f434f4e544143545f5757575f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f5757575f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e6d736e6d2d69636f6e097b2077696474683a207b494d475f49434f4e5f434f4e544143545f4d534e4d5f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f4d534e4d5f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e6963712d69636f6e097b2077696474683a207b494d475f49434f4e5f434f4e544143545f4943515f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f4943515f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e6a61626265722d69636f6e097b2077696474683a207b494d475f49434f4e5f434f4e544143545f4a41424245525f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f4a41424245525f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e706d2d69636f6e09097b2077696474683a207b494d475f49434f4e5f434f4e544143545f504d5f57494454487d70783b206865696768743a207b494d475f49434f4e5f434f4e544143545f504d5f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e71756f74652d69636f6e097b2077696474683a207b494d475f49434f4e5f504f53545f51554f54455f57494454487d70783b206865696768743a207b494d475f49434f4e5f504f53545f51554f54455f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e7265706f72742d69636f6e097b2077696474683a207b494d475f49434f4e5f504f53545f5245504f52545f57494454487d70783b206865696768743a207b494d475f49434f4e5f504f53545f5245504f52545f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e656469742d69636f6e097b2077696474683a207b494d475f49434f4e5f504f53545f454449545f57494454487d70783b206865696768743a207b494d475f49434f4e5f504f53545f454449545f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e64656c6574652d69636f6e097b2077696474683a207b494d475f49434f4e5f504f53545f44454c4554455f57494454487d70783b206865696768743a207b494d475f49434f4e5f504f53545f44454c4554455f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e696e666f2d69636f6e097b2077696474683a207b494d475f49434f4e5f504f53545f494e464f5f57494454487d70783b206865696768743a207b494d475f49434f4e5f504f53545f494e464f5f4845494748547d70783b207d0a756c2e70726f66696c652d69636f6e73206c692e7761726e2d69636f6e097b2077696474683a207b494d475f49434f4e5f555345525f5741524e5f57494454487d70783b206865696768743a207b494d475f49434f4e5f555345525f5741524e5f4845494748547d70783b207d0a0a2f2a204669782070726f66696c652069636f6e2064656661756c74206d617267696e73202a2f0a756c2e70726f66696c652d69636f6e73206c692e656469742d69636f6e097b206d617267696e3a203020302030203370783b207d0a756c2e70726f66696c652d69636f6e73206c692e71756f74652d69636f6e097b206d617267696e3a20302030203020313070783b207d0a756c2e70726f66696c652d69636f6e73206c692e696e666f2d69636f6e2c20756c2e70726f66696c652d69636f6e73206c692e7265706f72742d69636f6e097b206d617267696e3a203020337078203020303b207d0a2f2a2070726f53696c76657220436f6e74726f6c2050616e656c205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a0a2f2a204d61696e20435020626f780a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2363702d6d656e75207b0a09666c6f61743a6c6566743b0a0977696474683a203139253b0a096d617267696e2d746f703a2031656d3b0a096d617267696e2d626f74746f6d3a203570783b0a7d0a0a2363702d6d61696e207b0a09666c6f61743a206c6566743b0a0977696474683a203831253b0a7d0a0a2363702d6d61696e202e636f6e74656e74207b0a0970616464696e673a20303b0a7d0a0a2363702d6d61696e2068332c202363702d6d61696e2068722c202363702d6d656e75206872207b0a09626f726465722d636f6c6f723a20236266626662663b0a7d0a0a2363702d6d61696e202e70616e656c2070207b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a2363702d6d61696e202e70616e656c206f6c207b0a096d617267696e2d6c6566743a2032656d3b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a2363702d6d61696e202e70616e656c206c692e726f77207b0a09626f726465722d626f74746f6d3a2031707820736f6c696420236362636263623b0a09626f726465722d746f703a2031707820736f6c696420234639463946393b0a7d0a0a756c2e63706c697374207b0a096d617267696e2d626f74746f6d3a203570783b0a09626f726465722d746f703a2031707820736f6c696420236362636263623b0a7d0a0a2363702d6d61696e202e70616e656c206c692e6865616465722064642c202363702d6d61696e202e70616e656c206c692e686561646572206474207b0a09636f6c6f723a20233030303030303b0a096d617267696e2d626f74746f6d3a203270783b0a7d0a0a2363702d6d61696e207461626c652e7461626c6531207b0a096d617267696e2d626f74746f6d3a2031656d3b0a7d0a0a2363702d6d61696e207461626c652e7461626c6531207468656164207468207b0a09636f6c6f723a20233333333333333b0a09666f6e742d7765696768743a20626f6c643b0a09626f726465722d626f74746f6d3a2031707820736f6c696420233333333333333b0a0970616464696e673a203570783b0a7d0a0a2363702d6d61696e207461626c652e7461626c65312074626f6479207468207b0a09666f6e742d7374796c653a206974616c69633b0a096261636b67726f756e642d636f6c6f723a207472616e73706172656e742021696d706f7274616e743b0a09626f726465722d626f74746f6d3a206e6f6e653b0a7d0a0a2363702d6d61696e202e706167696e6174696f6e207b0a09666c6f61743a2072696768743b0a0977696474683a206175746f3b0a0970616464696e672d746f703a203170783b0a7d0a0a2363702d6d61696e202e706f7374626f64792070207b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a2363702d6d61696e202e706d2d6d657373616765207b0a09626f726465723a2031707820736f6c696420236532653265323b0a096d617267696e3a203130707820303b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a0977696474683a206175746f3b0a09666c6f61743a206e6f6e653b0a7d0a0a2e706d2d6d657373616765206832207b0a0970616464696e672d626f74746f6d3a203570783b0a7d0a0a2363702d6d61696e202e706f7374626f64792068332c202363702d6d61696e202e626f7832206833207b0a096d617267696e2d746f703a20303b0a7d0a0a2363702d6d61696e202e627574746f6e73207b0a096d617267696e2d6c6566743a20303b0a7d0a0a2363702d6d61696e20756c2e6c696e6b6c697374207b0a096d617267696e3a20303b0a7d0a0a2f2a204d435020537065636966696320747765616b73202a2f0a2e6d63702d6d61696e202e706f7374626f6479207b0a0977696474683a20313030253b0a7d0a0a2f2a20435020746162626564206d656e750a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2374616273207b0a096c696e652d6865696768743a206e6f726d616c3b0a096d617267696e3a20323070782030202d317078203770783b0a096d696e2d77696474683a2035373070783b0a7d0a0a237461627320756c207b0a096d617267696e3a303b0a0970616464696e673a20303b0a096c6973742d7374796c653a206e6f6e653b0a7d0a0a2374616273206c69207b0a09646973706c61793a20696e6c696e653b0a096d617267696e3a20303b0a0970616464696e673a20303b0a09666f6e742d73697a653a2031656d3b0a09666f6e742d7765696768743a20626f6c643b0a7d0a0a23746162732061207b0a09666c6f61743a206c6566743b0a096261636b67726f756e643a206e6f6e65206e6f2d726570656174203025202d333570783b0a096d617267696e3a203020317078203020303b0a0970616464696e673a203020302030203570783b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a09706f736974696f6e3a2072656c61746976653b0a09637572736f723a20706f696e7465723b0a7d0a0a23746162732061207370616e207b0a09666c6f61743a206c6566743b0a09646973706c61793a20626c6f636b3b0a096261636b67726f756e643a206e6f6e65206e6f2d7265706561742031303025202d333570783b0a0970616464696e673a20367078203130707820367078203570783b0a09636f6c6f723a20233832383238323b0a0977686974652d73706163653a206e6f777261703b0a7d0a0a237461627320613a686f766572207370616e207b0a09636f6c6f723a20236263626362633b0a7d0a0a2374616273202e6163746976657461622061207b0a096261636b67726f756e642d706f736974696f6e3a203020303b0a09626f726465722d626f74746f6d3a2031707820736f6c696420236562656265623b0a7d0a0a2374616273202e6163746976657461622061207370616e207b0a096261636b67726f756e642d706f736974696f6e3a203130302520303b0a0970616464696e672d626f74746f6d3a203770783b0a09636f6c6f723a20233333333333333b0a7d0a0a237461627320613a686f766572207b0a096261636b67726f756e642d706f736974696f6e3a2030202d373070783b0a7d0a0a237461627320613a686f766572207370616e207b0a096261636b67726f756e642d706f736974696f6e3a31303025202d373070783b0a7d0a0a2374616273202e61637469766574616220613a686f766572207b0a096261636b67726f756e642d706f736974696f6e3a203020303b0a7d0a0a2374616273202e61637469766574616220613a686f766572207370616e207b0a09636f6c6f723a20233030303030303b0a096261636b67726f756e642d706f736974696f6e3a203130302520303b0a7d0a0a2f2a204d696e6920746162626564206d656e75207573656420696e204d43500a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a236d696e6974616273207b0a096c696e652d6865696768743a206e6f726d616c3b0a096d617267696e3a202d3230707820377078203020303b0a7d0a0a236d696e697461627320756c207b0a096d617267696e3a303b0a0970616464696e673a20303b0a096c6973742d7374796c653a206e6f6e653b0a7d0a0a236d696e6974616273206c69207b0a09646973706c61793a20626c6f636b3b0a09666c6f61743a2072696768743b0a0970616464696e673a203020313070782034707820313070783b0a09666f6e742d73697a653a2031656d3b0a09666f6e742d7765696768743a20626f6c643b0a096261636b67726f756e642d636f6c6f723a20236632663266323b0a096d617267696e2d6c6566743a203270783b0a7d0a0a236d696e69746162732061207b0a7d0a0a236d696e697461627320613a686f766572207b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a7d0a0a236d696e6974616273206c692e616374697665746162207b0a096261636b67726f756e642d636f6c6f723a20234639463946393b0a7d0a0a236d696e6974616273206c692e61637469766574616220612c20236d696e6974616273206c692e61637469766574616220613a686f766572207b0a09636f6c6f723a20233333333333333b0a7d0a0a2f2a20554350206e617669676174696f6e206d656e750a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2f2a20436f6e7461696e657220666f72207375622d6e617669676174696f6e206c697374202a2f0a236e617669676174696f6e207b0a0977696474683a20313030253b0a0970616464696e672d746f703a20333670783b0a7d0a0a236e617669676174696f6e20756c207b0a096c6973742d7374796c653a6e6f6e653b0a7d0a0a2f2a2044656661756c74206c697374207374617465202a2f0a236e617669676174696f6e206c69207b0a096d617267696e3a2031707820303b0a0970616464696e673a20303b0a09666f6e742d7765696768743a20626f6c643b0a09646973706c61793a20696e6c696e653b0a7d0a0a2f2a204c696e6b207374796c657320666f7220746865207375622d73656374696f6e206c696e6b73202a2f0a236e617669676174696f6e2061207b0a09646973706c61793a20626c6f636b3b0a0970616464696e673a203570783b0a096d617267696e3a2031707820303b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a09666f6e742d7765696768743a20626f6c643b0a09636f6c6f723a20233333333b0a096261636b67726f756e643a2023636663666366206e6f6e65207265706561742d79203130302520303b0a7d0a0a236e617669676174696f6e20613a686f766572207b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a096261636b67726f756e642d636f6c6f723a20236336633663363b0a09636f6c6f723a20236263626362633b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a236e617669676174696f6e20236163746976652d73756273656374696f6e2061207b0a09646973706c61793a20626c6f636b3b0a09636f6c6f723a20236433643364333b0a096261636b67726f756e642d636f6c6f723a20234639463946393b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a236e617669676174696f6e20236163746976652d73756273656374696f6e20613a686f766572207b0a09636f6c6f723a20236433643364333b0a7d0a0a2f2a20507265666572656e6365732070616e65206c61796f75740a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2363702d6d61696e206832207b0a09626f726465722d626f74746f6d3a206e6f6e653b0a0970616464696e673a20303b0a096d617267696e2d6c6566743a20313070783b0a09636f6c6f723a20233333333333333b0a7d0a0a2363702d6d61696e202e70616e656c207b0a096261636b67726f756e642d636f6c6f723a20234639463946393b0a7d0a0a2363702d6d61696e202e706d207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d746f702c202363702d6d656e75207370616e2e636f726e6572732d746f70207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d746f70207370616e2c202363702d6d656e75207370616e2e636f726e6572732d746f70207370616e207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d626f74746f6d2c202363702d6d656e75207370616e2e636f726e6572732d626f74746f6d207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d626f74746f6d207370616e2c202363702d6d656e75207370616e2e636f726e6572732d626f74746f6d207370616e207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2f2a20546f706963726576696577202a2f0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f702c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f70207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f70207370616e2c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f70207370616e207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d2c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d207370616e2c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d207370616e207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2f2a20467269656e6473206c697374202a2f0a2e63702d6d696e69207b0a096261636b67726f756e642d636f6c6f723a20236639663966393b0a0970616464696e673a2030203570783b0a096d617267696e3a203130707820313570782031307078203570783b0a7d0a0a2e63702d6d696e69207370616e2e636f726e6572732d746f702c202e63702d6d696e69207370616e2e636f726e6572732d626f74746f6d207b0a096d617267696e3a2030202d3570783b0a7d0a0a646c2e6d696e69206474207b0a09666f6e742d7765696768743a20626f6c643b0a09636f6c6f723a20233637363736373b0a7d0a0a646c2e6d696e69206464207b0a0970616464696e672d746f703a203470783b0a7d0a0a2e667269656e642d6f6e6c696e65207b0a09666f6e742d7765696768743a20626f6c643b0a7d0a0a2e667269656e642d6f66666c696e65207b0a09666f6e742d7374796c653a206974616c69633b0a7d0a0a2f2a20504d205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a23706d2d6d656e75207b0a096c696e652d6865696768743a20322e35656d3b0a7d0a0a2f2a20504d204d65737361676520686973746f7279202a2f0a2e63757272656e74207b0a09636f6c6f723a20233939393939393b0a7d0a0a2f2a20446566696e65642072756c6573206c69737420666f7220504d206f7074696f6e73202a2f0a6f6c2e6465662d72756c6573207b0a0970616464696e672d6c6566743a20303b0a7d0a0a6f6c2e6465662d72756c6573206c69207b0a096c696e652d6865696768743a20313830253b0a0970616464696e673a203170783b0a7d0a0a2f2a20504d206d61726b696e6720636f6c6f757273202a2f0a2e706d6c697374206c692e626731207b0a09626f726465723a20736f6c696420337078207472616e73706172656e743b0a09626f726465722d77696474683a2030203370783b0a7d0a0a2e706d6c697374206c692e626732207b0a09626f726465723a20736f6c696420337078207472616e73706172656e743b0a09626f726465722d77696474683a2030203370783b0a7d0a0a2e706d6c697374206c692e706d5f6d6573736167655f7265706f727465645f636f6c6f75722c202e706d5f6d6573736167655f7265706f727465645f636f6c6f7572207b0a09626f726465722d6c6566742d636f6c6f723a20236263626362633b0a09626f726465722d72696768742d636f6c6f723a20236263626362633b0a7d0a0a2e706d6c697374206c692e706d5f6d61726b65645f636f6c6f75722c202e706d5f6d61726b65645f636f6c6f7572207b0a09626f726465723a20736f6c69642033707820236666666666663b0a09626f726465722d77696474683a2030203370783b0a7d0a0a2e706d6c697374206c692e706d5f7265706c6965645f636f6c6f75722c202e706d5f7265706c6965645f636f6c6f7572207b0a09626f726465723a20736f6c69642033707820236332633263323b0a09626f726465722d77696474683a2030203370783b090a7d0a0a2e706d6c697374206c692e706d5f667269656e645f636f6c6f75722c202e706d5f667269656e645f636f6c6f7572207b0a09626f726465723a20736f6c69642033707820236264626462643b0a09626f726465722d77696474683a2030203370783b0a7d0a0a2e706d6c697374206c692e706d5f666f655f636f6c6f75722c202e706d5f666f655f636f6c6f7572207b0a09626f726465723a20736f6c69642033707820233030303030303b0a09626f726465722d77696474683a2030203370783b0a7d0a0a2e706d2d6c6567656e64207b0a09626f726465722d6c6566742d77696474683a20313070783b0a09626f726465722d6c6566742d7374796c653a20736f6c69643b0a09626f726465722d72696768742d77696474683a20303b0a096d617267696e2d626f74746f6d3a203370783b0a0970616464696e672d6c6566743a203370783b0a7d0a0a2f2a204176617461722067616c6c657279202a2f0a2367616c6c657279206c6162656c207b0a09706f736974696f6e3a2072656c61746976653b0a09666c6f61743a206c6566743b0a096d617267696e3a20313070783b0a0970616464696e673a203570783b0a0977696474683a206175746f3b0a096261636b67726f756e643a20234646464646463b0a09626f726465723a2031707820736f6c696420234343433b0a09746578742d616c69676e3a2063656e7465723b0a7d0a0a2367616c6c657279206c6162656c3a686f766572207b0a096261636b67726f756e642d636f6c6f723a20234545453b0a7d0a2f2a2070726f53696c76657220466f726d205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2f2a2047656e6572616c20666f726d207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a6669656c64736574207b0a09626f726465722d77696474683a20303b0a09666f6e742d66616d696c793a2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09666f6e742d73697a653a20312e31656d3b0a7d0a0a696e707574207b0a09666f6e742d7765696768743a206e6f726d616c3b0a09637572736f723a20706f696e7465723b0a09766572746963616c2d616c69676e3a206d6964646c653b0a0970616464696e673a2030203370783b0a09666f6e742d73697a653a2031656d3b0a09666f6e742d66616d696c793a2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a7d0a0a73656c656374207b0a09666f6e742d66616d696c793a2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09666f6e742d7765696768743a206e6f726d616c3b0a09637572736f723a20706f696e7465723b0a09766572746963616c2d616c69676e3a206d6964646c653b0a09626f726465723a2031707820736f6c696420233636363636363b0a0970616464696e673a203170783b0a096261636b67726f756e642d636f6c6f723a20234641464146413b0a7d0a0a6f7074696f6e207b0a0970616464696e672d72696768743a2031656d3b0a7d0a0a6f7074696f6e2e64697361626c65642d6f7074696f6e207b0a09636f6c6f723a2067726179746578743b0a7d0a0a7465787461726561207b0a09666f6e742d66616d696c793a20224c7563696461204772616e6465222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a0977696474683a203630253b0a0970616464696e673a203270783b0a09666f6e742d73697a653a2031656d3b0a096c696e652d6865696768743a20312e34656d3b0a7d0a0a6c6162656c207b0a09637572736f723a2064656661756c743b0a0970616464696e672d72696768743a203570783b0a09636f6c6f723a20233637363736373b0a7d0a0a6c6162656c20696e707574207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a7d0a0a6c6162656c20696d67207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a7d0a0a2f2a20446566696e6974696f6e206c697374206c61796f757420666f7220666f726d730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a6669656c6473657420646c207b0a0970616464696e673a2034707820303b0a7d0a0a6669656c64736574206474207b0a09666c6f61743a206c6566743b090a0977696474683a203430253b0a09746578742d616c69676e3a206c6566743b0a09646973706c61793a20626c6f636b3b0a7d0a0a6669656c64736574206464207b0a096d617267696e2d6c6566743a203431253b0a09766572746963616c2d616c69676e3a20746f703b0a096d617267696e2d626f74746f6d3a203370783b0a7d0a0a2f2a205370656369666963206c61796f75742031202a2f0a6669656c647365742e6669656c647331206474207b0a0977696474683a203135656d3b0a09626f726465722d72696768742d77696474683a20303b0a7d0a0a6669656c647365742e6669656c647331206464207b0a096d617267696e2d6c6566743a203135656d3b0a09626f726465722d6c6566742d77696474683a20303b0a7d0a0a6669656c647365742e6669656c647331207b0a096261636b67726f756e642d636f6c6f723a207472616e73706172656e743b0a7d0a0a6669656c647365742e6669656c64733120646976207b0a096d617267696e2d626f74746f6d3a203370783b0a7d0a0a2f2a205370656369666963206c61796f75742032202a2f0a6669656c647365742e6669656c647332206474207b0a0977696474683a203135656d3b0a09626f726465722d72696768742d77696474683a20303b0a7d0a0a6669656c647365742e6669656c647332206464207b0a096d617267696e2d6c6566743a203136656d3b0a09626f726465722d6c6566742d77696474683a20303b0a7d0a0a2f2a20466f726d20656c656d656e7473202a2f0a6474206c6162656c207b0a09666f6e742d7765696768743a20626f6c643b0a09746578742d616c69676e3a206c6566743b0a7d0a0a6464206c6162656c207b0a0977686974652d73706163653a206e6f777261703b0a09636f6c6f723a20233333333b0a7d0a0a646420696e7075742c206464207465787461726561207b0a096d617267696e2d72696768743a203370783b0a7d0a0a64642073656c656374207b0a0977696474683a206175746f3b0a7d0a0a6464207465787461726561207b0a0977696474683a203835253b0a7d0a0a2f2a20486f7665722065666665637473202a2f0a6669656c6473657420646c3a686f766572206474206c6162656c207b0a09636f6c6f723a20233030303030303b0a7d0a0a6669656c647365742e6669656c64733220646c3a686f766572206474206c6162656c207b0a09636f6c6f723a20696e68657269743b0a7d0a0a2374696d657a6f6e65207b0a0977696474683a203935253b0a7d0a0a2a2068746d6c202374696d657a6f6e65207b0a0977696474683a203530253b0a7d0a0a2f2a20517569636b2d6c6f67696e206f6e20696e6465782070616765202a2f0a6669656c647365742e717569636b2d6c6f67696e207b0a096d617267696e2d746f703a203570783b0a7d0a0a6669656c647365742e717569636b2d6c6f67696e20696e707574207b0a0977696474683a206175746f3b0a7d0a0a6669656c647365742e717569636b2d6c6f67696e20696e7075742e696e707574626f78207b0a0977696474683a203135253b0a09766572746963616c2d616c69676e3a206d6964646c653b0a096d617267696e2d72696768743a203570783b0a096261636b67726f756e642d636f6c6f723a20236633663366333b0a7d0a0a6669656c647365742e717569636b2d6c6f67696e206c6162656c207b0a0977686974652d73706163653a206e6f777261703b0a0970616464696e672d72696768743a203270783b0a7d0a0a2f2a20446973706c6179206f7074696f6e73206f6e2076696577746f7069632f76696577666f72756d20706167657320202a2f0a6669656c647365742e646973706c61792d6f7074696f6e73207b0a09746578742d616c69676e3a2063656e7465723b0a096d617267696e3a2033707820302035707820303b0a7d0a0a6669656c647365742e646973706c61792d6f7074696f6e73206c6162656c207b0a0977686974652d73706163653a206e6f777261703b0a0970616464696e672d72696768743a203270783b0a7d0a0a6669656c647365742e646973706c61792d6f7074696f6e732061207b0a096d617267696e2d746f703a203370783b0a7d0a0a2f2a20446973706c617920616374696f6e7320666f722075637020616e64206d6370207061676573202a2f0a6669656c647365742e646973706c61792d616374696f6e73207b0a09746578742d616c69676e3a2072696768743b0a096c696e652d6865696768743a2032656d3b0a0977686974652d73706163653a206e6f777261703b0a0970616464696e672d72696768743a2031656d3b0a7d0a0a6669656c647365742e646973706c61792d616374696f6e73206c6162656c207b0a0977686974652d73706163653a206e6f777261703b0a0970616464696e672d72696768743a203270783b0a7d0a0a6669656c647365742e736f72742d6f7074696f6e73207b0a096c696e652d6865696768743a2032656d3b0a7d0a0a2f2a204d435020666f72756d2073656c656374696f6e2a2f0a6669656c647365742e666f72756d2d73656c656374696f6e207b0a096d617267696e3a2035707820302033707820303b0a09666c6f61743a2072696768743b0a7d0a0a6669656c647365742e666f72756d2d73656c656374696f6e32207b0a096d617267696e3a203133707820302033707820303b0a09666c6f61743a2072696768743b0a7d0a0a2f2a204a756d70626f78202a2f0a6669656c647365742e6a756d70626f78207b0a09746578742d616c69676e3a2072696768743b0a096d617267696e2d746f703a20313570783b0a096865696768743a20322e35656d3b0a7d0a0a6669656c647365742e717569636b6d6f64207b0a0977696474683a203530253b0a09666c6f61743a2072696768743b0a09746578742d616c69676e3a2072696768743b0a096865696768743a20322e35656d3b0a7d0a0a2f2a205375626d697420627574746f6e206669656c64736574202a2f0a6669656c647365742e7375626d69742d627574746f6e73207b0a09746578742d616c69676e3a2063656e7465723b0a09766572746963616c2d616c69676e3a206d6964646c653b0a096d617267696e3a2035707820303b0a7d0a0a6669656c647365742e7375626d69742d627574746f6e7320696e707574207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a0970616464696e672d746f703a203370783b0a0970616464696e672d626f74746f6d3a203370783b0a7d0a0a2f2a20506f7374696e672070616765207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a0a2f2a20427574746f6e73207573656420696e2074686520656469746f72202a2f0a23666f726d61742d627574746f6e73207b0a096d617267696e3a203135707820302032707820303b0a7d0a0a23666f726d61742d627574746f6e7320696e7075742c2023666f726d61742d627574746f6e732073656c656374207b0a09766572746963616c2d616c69676e3a206d6964646c653b0a7d0a0a2f2a204d61696e206d65737361676520626f78202a2f0a236d6573736167652d626f78207b0a0977696474683a203830253b0a7d0a0a236d6573736167652d626f78207465787461726561207b0a09666f6e742d66616d696c793a2022547265627563686574204d53222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a0977696474683a20313030253b0a09666f6e742d73697a653a20312e32656d3b0a09636f6c6f723a20233333333333333b0a7d0a0a2f2a20456d6f7469636f6e732070616e656c202a2f0a23736d696c65792d626f78207b0a0977696474683a203138253b0a09666c6f61743a2072696768743b0a7d0a0a23736d696c65792d626f7820696d67207b0a096d617267696e3a203370783b0a7d0a0a2f2a20496e707574206669656c64207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2e696e707574626f78207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a09626f726465723a2031707820736f6c696420236330633063303b0a09636f6c6f723a20233333333333333b0a0970616464696e673a203270783b0a09637572736f723a20746578743b0a7d0a0a2e696e707574626f783a686f766572207b0a09626f726465723a2031707820736f6c696420236561656165613b0a7d0a0a2e696e707574626f783a666f637573207b0a09626f726465723a2031707820736f6c696420236561656165613b0a09636f6c6f723a20233462346234623b0a7d0a0a696e7075742e696e707574626f78097b2077696474683a203835253b207d0a696e7075742e6d656469756d097b2077696474683a203530253b207d0a696e7075742e6e6172726f77097b2077696474683a203235253b207d0a696e7075742e74696e7909097b2077696474683a2031323570783b207d0a0a74657874617265612e696e707574626f78207b0a0977696474683a203835253b0a7d0a0a2e6175746f7769647468207b0a0977696474683a206175746f2021696d706f7274616e743b0a7d0a0a2f2a20466f726d20627574746f6e207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a696e7075742e627574746f6e312c20696e7075742e627574746f6e32207b0a09666f6e742d73697a653a2031656d3b0a7d0a0a612e627574746f6e312c20696e7075742e627574746f6e312c20696e7075742e627574746f6e332c20612e627574746f6e322c20696e7075742e627574746f6e32207b0a0977696474683a206175746f2021696d706f7274616e743b0a0970616464696e672d746f703a203170783b0a0970616464696e672d626f74746f6d3a203170783b0a09666f6e742d66616d696c793a20224c7563696461204772616e6465222c2056657264616e612c2048656c7665746963612c20417269616c2c2073616e732d73657269663b0a09636f6c6f723a20233030303b0a096261636b67726f756e643a2023464146414641206e6f6e65207265706561742d7820746f703b0a7d0a0a612e627574746f6e312c20696e7075742e627574746f6e31207b0a09666f6e742d7765696768743a20626f6c643b0a09626f726465723a2031707820736f6c696420233636363636363b0a7d0a0a696e7075742e627574746f6e33207b0a0970616464696e673a20303b0a096d617267696e3a20303b0a096c696e652d6865696768743a203570783b0a096865696768743a20313270783b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a09666f6e742d76617269616e743a20736d616c6c2d636170733b0a7d0a0a2f2a20416c7465726e617469766520627574746f6e202a2f0a612e627574746f6e322c20696e7075742e627574746f6e322c20696e7075742e627574746f6e33207b0a09626f726465723a2031707820736f6c696420233636363636363b0a7d0a0a2f2a203c613e20627574746f6e20696e20746865207374796c65206f662074686520666f726d20627574746f6e73202a2f0a612e627574746f6e312c20612e627574746f6e313a6c696e6b2c20612e627574746f6e313a766973697465642c20612e627574746f6e313a6163746976652c20612e627574746f6e322c20612e627574746f6e323a6c696e6b2c20612e627574746f6e323a766973697465642c20612e627574746f6e323a616374697665207b0a09746578742d6465636f726174696f6e3a206e6f6e653b0a09636f6c6f723a20233030303030303b0a0970616464696e673a20327078203870783b0a096c696e652d6865696768743a20323530253b0a09766572746963616c2d616c69676e3a20746578742d626f74746f6d3b0a096261636b67726f756e642d706f736974696f6e3a2030203170783b0a7d0a0a2f2a20486f76657220737461746573202a2f0a612e627574746f6e313a686f7665722c20696e7075742e627574746f6e313a686f7665722c20612e627574746f6e323a686f7665722c20696e7075742e627574746f6e323a686f7665722c20696e7075742e627574746f6e333a686f766572207b0a09626f726465723a2031707820736f6c696420234243424342433b0a096261636b67726f756e642d706f736974696f6e3a203020313030253b0a09636f6c6f723a20234243424342433b0a7d0a0a696e7075742e64697361626c6564207b0a09666f6e742d7765696768743a206e6f726d616c3b0a09636f6c6f723a20233636363636363b0a7d0a0a2f2a20546f70696320616e6420666f72756d20536561726368202a2f0a2e7365617263682d626f78207b0a096d617267696e2d746f703a203370783b0a096d617267696e2d6c6566743a203570783b0a09666c6f61743a206c6566743b0a7d0a0a2e7365617263682d626f7820696e707574207b0a7d0a0a696e7075742e736561726368207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a096261636b67726f756e642d7265706561743a206e6f2d7265706561743b0a096261636b67726f756e642d706f736974696f6e3a206c656674203170783b0a0970616464696e672d6c6566743a20313770783b0a7d0a0a2e66756c6c207b2077696474683a203935253b207d0a2e6d656469756d207b2077696474683a203530253b7d0a2e6e6172726f77207b2077696474683a203235253b7d0a2e74696e79207b2077696474683a203130253b7d0a2f2a2070726f53696c766572205374796c6520536865657420547765616b730a0a5468657365207374796c6520646566696e6974696f6e7320617265206d61696e6c79204945207370656369666963200a747765616b732072657175697265642064756520746f2069747320706f6f722043535320737570706f72742e0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a0a2a2068746d6c207461626c652c202a2068746d6c2073656c6563742c202a2068746d6c20696e707574207b20666f6e742d73697a653a20313030253b207d0a2a2068746d6c206872207b206d617267696e3a20303b207d0a2a2068746d6c207370616e2e636f726e6572732d746f702c202a2068746d6c207370616e2e636f726e6572732d626f74746f6d207b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f6c6566742e67696622293b207d0a2a2068746d6c207370616e2e636f726e6572732d746f70207370616e2c202a2068746d6c207370616e2e636f726e6572732d626f74746f6d207370616e207b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f72696768742e67696622293b207d0a0a7461626c652e7461626c6531207b0a0977696474683a203939253b09092f2a204945203c20362062726f7773657273202a2f0a092f2a2054616e74656b206861636b202a2f0a09766f6963652d66616d696c793a20225c227d5c22223b0a09766f6963652d66616d696c793a20696e68657269743b0a0977696474683a20313030253b0a7d0a68746d6c3e626f6479207461626c652e7461626c6531207b2077696474683a20313030253b207d092f2a205265736574203130302520666f72206f70657261202a2f0a0a2a2068746d6c20756c2e746f7069636c697374206c69207b20706f736974696f6e3a2072656c61746976653b207d0a2a2068746d6c202e706f7374626f647920683320696d67207b20766572746963616c2d616c69676e3a206d6964646c653b207d0a0a2f2a20466f726d207374796c6573202a2f0a68746d6c3e626f6479206464206c6162656c20696e707574207b20766572746963616c2d616c69676e3a20746578742d626f74746f6d3b207d092f2a20416c69676e20636865636b626f7865732f726164696f20627574746f6e73206e6963656c79202a2f0a0a2a2068746d6c20696e7075742e627574746f6e312c202a2068746d6c20696e7075742e627574746f6e32207b0a0970616464696e672d626f74746f6d3a20303b0a096d617267696e2d626f74746f6d3a203170783b0a7d0a0a2f2a204d697363206c61796f7574207374796c6573202a2f0a2a2068746d6c202e636f6c756d6e312c202a2068746d6c202e636f6c756d6e32207b2077696474683a203435253b207d0a0a2f2a204e696365206d6574686f6420666f7220636c656172696e6720666c6f6174656420626c6f636b7320776974686f757420686176696e6720746f20696e7365727420616e79206578747261206d61726b757020286c696b65207370616365722061626f7665290a20202046726f6d20687474703a2f2f7777772e706f736974696f6e697365766572797468696e672e6e65742f65617379636c656172696e672e68746d6c200a23746162733a61667465722c20236d696e69746162733a61667465722c202e706f73743a61667465722c202e6e61766261723a61667465722c206669656c6473657420646c3a61667465722c20756c2e746f7069636c69737420646c3a61667465722c20756c2e6c696e6b6c6973743a61667465722c20646c2e706f6c6c733a6166746572207b0a09636f6e74656e743a20222e223b200a09646973706c61793a20626c6f636b3b200a096865696768743a20303b200a09636c6561723a20626f74683b200a097669736962696c6974793a2068696464656e3b0a7d2a2f0a0a2e636c6561726669782c2023746162732c20236d696e69746162732c206669656c6473657420646c2c20756c2e746f7069636c69737420646c2c20646c2e706f6c6c73207b0a096865696768743a2031253b0a096f766572666c6f773a2068696464656e3b0a7d0a0a2f2a2076696577746f70696320666978202a2f0a2a2068746d6c202e706f7374207b0a096865696768743a203235253b0a096f766572666c6f773a2068696464656e3b0a7d0a0a2f2a206e617662617220666978202a2f0a2a2068746d6c202e636c6561726669782c202a2068746d6c202e6e61766261722c20756c2e6c696e6b6c697374207b0a096865696768743a2034253b0a096f766572666c6f773a2068696464656e3b0a7d0a0a2f2a2053696d706c652066697820736f20666f72756d20616e6420746f706963206c6973747320616c7761797320686176652061206d696e2d686569676874207365742c206576656e20696e204945360a0946726f6d20687474703a2f2f7777772e64757374696e6469617a2e636f6d2f6d696e2d6865696768742d666173742d6861636b202a2f0a646c2e69636f6e207b0a096d696e2d6865696768743a20333570783b0a096865696768743a206175746f2021696d706f7274616e743b0a096865696768743a20333570783b0a7d0a0a2a2068746d6c20237365617263682d626f78207b0a0977696474683a203235253b0a7d0a0a2f2a20436f72726563746c7920636c65617220666c6f6174696e6720666f722064657461696c73206f6e2070726f66696c652076696577202a2f0a2a3a66697273742d6368696c642b68746d6c20646c2e64657461696c73206464207b0a096d617267696e2d6c6566743a203330253b0a09666c6f61743a206e6f6e653b0a7d0a0a2a2068746d6c20646c2e64657461696c73206464207b0a096d617267696e2d6c6566743a203330253b0a09666c6f61743a206e6f6e653b0a7d0a2f2a2020090a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a436f6c6f75727320616e64206261636b67726f756e647320666f7220636f6d6d6f6e2e6373730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a68746d6c2c20626f6479207b0a09636f6c6f723a20233533363438323b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a6831207b0a09636f6c6f723a20234646464646463b0a7d0a0a6832207b0a09636f6c6f723a20233238333133463b0a7d0a0a6833207b0a09626f726465722d626f74746f6d2d636f6c6f723a20234343434343433b0a09636f6c6f723a20233131353039383b0a7d0a0a6872207b0a09626f726465722d636f6c6f723a20234646464646463b0a09626f726465722d746f702d636f6c6f723a20234343434343433b0a7d0a0a68722e646173686564207b0a09626f726465722d746f702d636f6c6f723a20234343434343433b0a7d0a0a2f2a2053656172636820626f780a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a237365617263682d626f78207b0a09636f6c6f723a20234646464646463b0a7d0a0a237365617263682d626f7820236b6579776f726473207b0a096261636b67726f756e642d636f6c6f723a20234646463b0a7d0a0a237365617263682d626f7820696e707574207b0a09626f726465722d636f6c6f723a20233030373542303b0a7d0a0a2f2a20526f756e6420636f726e6572656420626f78657320616e64206261636b67726f756e64730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2e686561646572626172207b0a096261636b67726f756e642d636f6c6f723a20233132413345423b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f62675f6865616465722e67696622293b0a09636f6c6f723a20234646464646463b0a7d0a0a2e6e6176626172207b0a096261636b67726f756e642d636f6c6f723a20236361646365623b0a7d0a0a2e666f72616267207b0a096261636b67726f756e642d636f6c6f723a20233030373662313b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f62675f6c6973742e67696622293b0a7d0a0a2e666f72756d6267207b0a096261636b67726f756e642d636f6c6f723a20233132413345423b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f62675f6865616465722e67696622293b0a7d0a0a2e70616e656c207b0a096261636b67726f756e642d636f6c6f723a20234543463146333b0a09636f6c6f723a20233238333133463b0a7d0a0a2e706f73743a746172676574202e636f6e74656e74207b0a09636f6c6f723a20233030303030303b0a7d0a0a2e706f73743a7461726765742068332061207b0a09636f6c6f723a20233030303030303b0a7d0a0a2e626731097b206261636b67726f756e642d636f6c6f723a20234543463346373b207d0a2e626732097b206261636b67726f756e642d636f6c6f723a20236531656266323b20207d0a2e626733097b206261636b67726f756e642d636f6c6f723a20236361646365623b207d0a0a2e756370726f776267207b0a096261636b67726f756e642d636f6c6f723a20234443444545323b0a7d0a0a2e6669656c64736267207b0a096261636b67726f756e642d636f6c6f723a20234537453845413b0a7d0a0a7370616e2e636f726e6572732d746f70207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f6c6566742e706e6722293b0a7d0a0a7370616e2e636f726e6572732d746f70207370616e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f72696768742e706e6722293b0a7d0a0a7370616e2e636f726e6572732d626f74746f6d207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f6c6566742e706e6722293b0a7d0a0a7370616e2e636f726e6572732d626f74746f6d207370616e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f72696768742e706e6722293b0a7d0a0a2f2a20486f72697a6f6e74616c206c697374730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a0a756c2e6e61766c696e6b73207b0a09626f726465722d626f74746f6d2d636f6c6f723a20234646464646463b0a7d0a0a2f2a205461626c65207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a7461626c652e7461626c6531207468656164207468207b0a09636f6c6f723a20234646464646463b0a7d0a0a7461626c652e7461626c65312074626f6479207472207b0a09626f726465722d636f6c6f723a20234246433143463b0a7d0a0a7461626c652e7461626c65312074626f64792074723a686f7665722c207461626c652e7461626c65312074626f64792074722e686f766572207b0a096261636b67726f756e642d636f6c6f723a20234346453146363b0a09636f6c6f723a20233030303b0a7d0a0a7461626c652e7461626c6531207464207b0a09636f6c6f723a20233533363438323b0a7d0a0a7461626c652e7461626c65312074626f6479207464207b0a09626f726465722d746f702d636f6c6f723a20234641464146413b0a7d0a0a7461626c652e7461626c65312074626f6479207468207b0a09626f726465722d626f74746f6d2d636f6c6f723a20233030303030303b0a09636f6c6f723a20233333333333333b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a7461626c652e696e666f2074626f6479207468207b0a09636f6c6f723a20233030303030303b0a7d0a0a2f2a204d697363206c61796f7574207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a646c2e64657461696c73206474207b0a09636f6c6f723a20233030303030303b0a7d0a0a646c2e64657461696c73206464207b0a09636f6c6f723a20233533363438323b0a7d0a0a2e736570207b0a09636f6c6f723a20233131393844393b0a7d0a0a2f2a20506167696e6174696f6e0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2e706167696e6174696f6e207370616e207374726f6e67207b0a09636f6c6f723a20234646464646463b0a096261636b67726f756e642d636f6c6f723a20233436393242463b0a09626f726465722d636f6c6f723a20233436393242463b0a7d0a0a2e706167696e6174696f6e207370616e20612c202e706167696e6174696f6e207370616e20613a6c696e6b2c202e706167696e6174696f6e207370616e20613a766973697465642c202e706167696e6174696f6e207370616e20613a616374697665207b0a09636f6c6f723a20233543373538433b0a096261636b67726f756e642d636f6c6f723a20234543454445453b0a09626f726465722d636f6c6f723a20234234424143303b0a7d0a0a2e706167696e6174696f6e207370616e20613a686f766572207b0a09626f726465722d636f6c6f723a20233336384144323b0a096261636b67726f756e642d636f6c6f723a20233336384144323b0a09636f6c6f723a20234646463b0a7d0a0a2f2a20506167696e6174696f6e20696e2076696577666f72756d20666f72206d756c74697061676520746f70696373202a2f0a2e726f77202e706167696e6174696f6e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f70616765732e67696622293b0a7d0a0a2e726f77202e706167696e6174696f6e207370616e20612c206c692e706167696e6174696f6e207370616e2061207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a2e726f77202e706167696e6174696f6e207370616e20613a686f7665722c206c692e706167696e6174696f6e207370616e20613a686f766572207b0a096261636b67726f756e642d636f6c6f723a20233336384144323b0a7d0a0a2f2a204d697363656c6c616e656f7573207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2e636f70797269676874207b0a09636f6c6f723a20233535353535353b0a7d0a0a2e6572726f72207b0a09636f6c6f723a20234243324134443b0a7d0a0a2e7265706f72746564207b0a096261636b67726f756e642d636f6c6f723a20234637454345463b0a7d0a0a6c692e7265706f727465643a686f766572207b0a096261636b67726f756e642d636f6c6f723a20234543443544382021696d706f7274616e743b0a7d0a2e737469636b792c202e616e6e6f756e6365207b0a092f2a20796f752063616e206164642061206261636b67726f756e6420666f7220737469636b69657320616e6420616e6e6f756e63656d656e74732a2f0a7d0a0a6469762e72756c6573207b0a096261636b67726f756e642d636f6c6f723a20234543443544383b0a09636f6c6f723a20234243324134443b0a7d0a0a702e72756c6573207b0a096261636b67726f756e642d636f6c6f723a20234543443544383b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2f2a2020090a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a436f6c6f75727320616e64206261636b67726f756e647320666f72206c696e6b732e6373730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a613a6c696e6b097b20636f6c6f723a20233130353238393b207d0a613a76697369746564097b20636f6c6f723a20233130353238393b207d0a613a686f766572097b20636f6c6f723a20234433313134313b207d0a613a616374697665097b20636f6c6f723a20233336384144323b207d0a0a2f2a204c696e6b73206f6e206772616469656e74206261636b67726f756e6473202a2f0a237365617263682d626f7820613a6c696e6b2c202e6e6176626720613a6c696e6b2c202e666f72756d6267202e68656164657220613a6c696e6b2c202e666f72616267202e68656164657220613a6c696e6b2c20746820613a6c696e6b207b0a09636f6c6f723a20234646464646463b0a7d0a0a237365617263682d626f7820613a766973697465642c202e6e6176626720613a766973697465642c202e666f72756d6267202e68656164657220613a766973697465642c202e666f72616267202e68656164657220613a766973697465642c20746820613a76697369746564207b0a09636f6c6f723a20234646464646463b0a7d0a0a237365617263682d626f7820613a686f7665722c202e6e6176626720613a686f7665722c202e666f72756d6267202e68656164657220613a686f7665722c202e666f72616267202e68656164657220613a686f7665722c20746820613a686f766572207b0a09636f6c6f723a20234138443846463b0a7d0a0a237365617263682d626f7820613a6163746976652c202e6e6176626720613a6163746976652c202e666f72756d6267202e68656164657220613a6163746976652c202e666f72616267202e68656164657220613a6163746976652c20746820613a616374697665207b0a09636f6c6f723a20234338453646463b0a7d0a0a2f2a204c696e6b7320666f7220666f72756d2f746f706963206c69737473202a2f0a612e666f72756d7469746c65207b0a09636f6c6f723a20233130353238393b0a7d0a0a2f2a20612e666f72756d7469746c653a76697369746564207b20636f6c6f723a20233130353238393b207d202a2f0a0a612e666f72756d7469746c653a686f766572207b0a09636f6c6f723a20234243324134443b0a7d0a0a612e666f72756d7469746c653a616374697665207b0a09636f6c6f723a20233130353238393b0a7d0a0a612e746f7069637469746c65207b0a09636f6c6f723a20233130353238393b0a7d0a0a2f2a20612e746f7069637469746c653a76697369746564207b20636f6c6f723a20233336384144323b207d202a2f0a0a612e746f7069637469746c653a686f766572207b0a09636f6c6f723a20234243324134443b0a7d0a0a612e746f7069637469746c653a616374697665207b0a09636f6c6f723a20233130353238393b0a7d0a0a2f2a20506f737420626f6479206c696e6b73202a2f0a2e706f73746c696e6b207b0a09636f6c6f723a20233336384144323b0a09626f726465722d626f74746f6d2d636f6c6f723a20233336384144323b0a7d0a0a2e706f73746c696e6b3a76697369746564207b0a09636f6c6f723a20233544384642443b0a09626f726465722d626f74746f6d2d636f6c6f723a20233636363636363b0a7d0a0a2e706f73746c696e6b3a616374697665207b0a09636f6c6f723a20233336384144323b0a7d0a0a2e706f73746c696e6b3a686f766572207b0a096261636b67726f756e642d636f6c6f723a20234430453446363b0a09636f6c6f723a20233044343437333b0a7d0a0a2e7369676e617475726520612c202e7369676e617475726520613a766973697465642c202e7369676e617475726520613a6163746976652c202e7369676e617475726520613a686f766572207b0a096261636b67726f756e642d636f6c6f723a207472616e73706172656e743b0a7d0a0a2f2a2050726f66696c65206c696e6b73202a2f0a2e706f737470726f66696c6520613a6c696e6b2c202e706f737470726f66696c6520613a6163746976652c202e706f737470726f66696c6520613a766973697465642c202e706f737470726f66696c652064742e617574686f722061207b0a09636f6c6f723a20233130353238393b0a7d0a0a2e706f737470726f66696c6520613a686f7665722c202e706f737470726f66696c652064742e617574686f7220613a686f766572207b0a09636f6c6f723a20234433313134313b0a7d0a0a2f2a2050726f66696c6520736561726368726573756c7473202a2f090a2e736561726368202e706f737470726f66696c652061207b0a09636f6c6f723a20233130353238393b0a7d0a0a2e736561726368202e706f737470726f66696c6520613a686f766572207b0a09636f6c6f723a20234433313134313b0a7d0a0a2f2a204261636b20746f20746f70206f662070616765202a2f0a612e746f70207b0a096261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f4241434b5f544f505f5352437d22293b0a7d0a0a612e746f7032207b0a096261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f4241434b5f544f505f5352437d22293b0a7d0a0a2f2a204172726f77206c696e6b7320202a2f0a612e757009097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f6172726f775f75702e6769662229207d0a612e646f776e09097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f6172726f775f646f776e2e6769662229207d0a612e6c65667409097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f6172726f775f6c6566742e6769662229207d0a612e726967687409097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f6172726f775f72696768742e6769662229207d0a0a612e75703a686f766572207b0a096261636b67726f756e642d636f6c6f723a207472616e73706172656e743b0a7d0a0a612e6c6566743a686f766572207b0a09636f6c6f723a20233336384144323b0a7d0a0a612e72696768743a686f766572207b0a09636f6c6f723a20233336384144323b0a7d0a0a0a2f2a2020090a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a436f6c6f75727320616e64206261636b67726f756e647320666f7220636f6e74656e742e6373730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a756c2e666f72756d73207b0a096261636b67726f756e642d636f6c6f723a20236565663566393b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f6772616469656e742e67696622293b0a7d0a0a756c2e746f7069636c697374206c69207b0a09636f6c6f723a20233443354437373b0a7d0a0a756c2e746f7069636c697374206464207b0a09626f726465722d6c6566742d636f6c6f723a20234646464646463b0a7d0a0a2e72746c20756c2e746f7069636c697374206464207b0a09626f726465722d72696768742d636f6c6f723a20236666663b0a09626f726465722d6c6566742d636f6c6f723a207472616e73706172656e743b0a7d0a0a756c2e746f7069636c697374206c692e726f7720647420612e737562666f72756d2e72656164207b0a096261636b67726f756e642d696d6167653a2075726c28227b494d475f535542464f52554d5f524541445f5352437d22293b0a7d0a0a756c2e746f7069636c697374206c692e726f7720647420612e737562666f72756d2e756e72656164207b0a096261636b67726f756e642d696d6167653a2075726c28227b494d475f535542464f52554d5f554e524541445f5352437d22293b0a7d0a0a6c692e726f77207b0a09626f726465722d746f702d636f6c6f723a2020234646464646463b0a09626f726465722d626f74746f6d2d636f6c6f723a20233030363038463b0a7d0a0a6c692e726f77207374726f6e67207b0a09636f6c6f723a20233030303030303b0a7d0a0a6c692e726f773a686f766572207b0a096261636b67726f756e642d636f6c6f723a20234636463444303b0a7d0a0a6c692e726f773a686f766572206464207b0a09626f726465722d6c6566742d636f6c6f723a20234343434343433b0a7d0a0a2e72746c206c692e726f773a686f766572206464207b0a09626f726465722d72696768742d636f6c6f723a20234343434343433b0a09626f726465722d6c6566742d636f6c6f723a207472616e73706172656e743b0a7d0a0a6c692e6865616465722064742c206c692e686561646572206464207b0a09636f6c6f723a20234646464646463b0a7d0a0a2f2a20466f72756d206c69737420636f6c756d6e207374796c6573202a2f0a756c2e746f7069636c6973742064642e7365617263686578747261207b0a09636f6c6f723a20233333333333333b0a7d0a0a2f2a20506f737420626f6479207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e706f7374626f6479207b0a09636f6c6f723a20233333333333333b0a7d0a0a2f2a20436f6e74656e7420636f6e7461696e6572207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e636f6e74656e74207b0a09636f6c6f723a20233333333333333b0a7d0a0a2e636f6e74656e742068322c202e70616e656c206832207b0a09636f6c6f723a20233131353039383b0a09626f726465722d626f74746f6d2d636f6c6f723a2020234343434343433b0a7d0a0a646c2e666171206474207b0a09636f6c6f723a20233333333333333b0a7d0a0a2e706f737468696c6974207b0a096261636b67726f756e642d636f6c6f723a20234633424643433b0a09636f6c6f723a20234243324134443b0a7d0a0a2f2a20506f7374207369676e6174757265202a2f0a2e7369676e6174757265207b0a09626f726465722d746f702d636f6c6f723a20234343434343433b0a7d0a0a2f2a20506f7374206e6f746963696573202a2f0a2e6e6f74696365207b0a09626f726465722d746f702d636f6c6f723a2020234343434343433b0a7d0a0a2f2a20424220436f6465207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2f2a2051756f746520626c6f636b202a2f0a626c6f636b71756f7465207b0a096261636b67726f756e642d636f6c6f723a20234542454144443b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f71756f74652e67696622293b0a09626f726465722d636f6c6f723a234442444243453b0a7d0a0a626c6f636b71756f746520626c6f636b71756f7465207b0a092f2a204e65737465642071756f746573202a2f0a096261636b67726f756e642d636f6c6f723a234546454544393b0a7d0a0a626c6f636b71756f746520626c6f636b71756f746520626c6f636b71756f7465207b0a092f2a204e65737465642071756f746573202a2f0a096261636b67726f756e642d636f6c6f723a20234542454144443b0a7d0a0a2f2a20436f646520626c6f636b202a2f0a646c2e636f6465626f78207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a09626f726465722d636f6c6f723a20234339443244383b0a7d0a0a646c2e636f6465626f78206474207b0a09626f726465722d626f74746f6d2d636f6c6f723a2020234343434343433b0a7d0a0a646c2e636f6465626f7820636f6465207b0a09636f6c6f723a20233245384235373b0a7d0a0a2e73796e746178626709097b20636f6c6f723a20234646464646463b207d0a2e73796e746178636f6d6d656e74097b20636f6c6f723a20234646383030303b207d0a2e73796e74617864656661756c74097b20636f6c6f723a20233030303042423b207d0a2e73796e74617868746d6c09097b20636f6c6f723a20233030303030303b207d0a2e73796e7461786b6579776f7264097b20636f6c6f723a20233030373730303b207d0a2e73796e746178737472696e67097b20636f6c6f723a20234444303030303b207d0a0a2f2a204174746163686d656e74730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e617474616368626f78207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a09626f726465722d636f6c6f723a2020234339443244383b0a7d0a0a2e706d2d6d657373616765202e617474616368626f78207b0a096261636b67726f756e642d636f6c6f723a20234632463346333b0a7d0a0a2e617474616368626f78206464207b0a09626f726465722d746f702d636f6c6f723a20234339443244383b0a7d0a0a2e617474616368626f782070207b0a09636f6c6f723a20233636363636363b0a7d0a0a2e617474616368626f7820702e7374617473207b0a09636f6c6f723a20233636363636363b0a7d0a0a2e6174746163682d696d61676520696d67207b0a09626f726465722d636f6c6f723a20233939393939393b0a7d0a0a2f2a20496e6c696e6520696d616765207468756d626e61696c73202a2f0a0a646c2e66696c65206464207b0a09636f6c6f723a20233636363636363b0a7d0a0a646c2e7468756d626e61696c20696d67207b0a09626f726465722d636f6c6f723a20233636363636363b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a646c2e7468756d626e61696c206464207b0a09636f6c6f723a20233636363636363b0a7d0a0a646c2e7468756d626e61696c20647420613a686f766572207b0a096261636b67726f756e642d636f6c6f723a20234545454545453b0a7d0a0a646c2e7468756d626e61696c20647420613a686f76657220696d67207b0a09626f726465722d636f6c6f723a20233336384144323b0a7d0a0a2f2a20506f737420706f6c6c207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a0a6669656c647365742e706f6c6c7320646c207b0a09626f726465722d746f702d636f6c6f723a20234443444545323b0a09636f6c6f723a20233636363636363b0a7d0a0a6669656c647365742e706f6c6c7320646c2e766f746564207b0a09636f6c6f723a20233030303030303b0a7d0a0a6669656c647365742e706f6c6c7320646420646976207b0a09636f6c6f723a20234646464646463b0a7d0a0a2e72746c202e706f6c6c626172312c202e72746c202e706f6c6c626172322c202e72746c202e706f6c6c626172332c202e72746c202e706f6c6c626172342c202e72746c202e706f6c6c62617235207b0a09626f726465722d72696768742d636f6c6f723a207472616e73706172656e743b0a7d0a0a2e706f6c6c62617231207b0a096261636b67726f756e642d636f6c6f723a20234141323334363b0a09626f726465722d626f74746f6d2d636f6c6f723a20233734313632433b0a09626f726465722d72696768742d636f6c6f723a20233734313632433b0a7d0a0a2e72746c202e706f6c6c62617231207b0a09626f726465722d6c6566742d636f6c6f723a20233734313632433b0a7d0a0a2e706f6c6c62617232207b0a096261636b67726f756e642d636f6c6f723a20234245314534413b0a09626f726465722d626f74746f6d2d636f6c6f723a20233843314333383b0a09626f726465722d72696768742d636f6c6f723a20233843314333383b0a7d0a0a2e72746c202e706f6c6c62617232207b0a09626f726465722d6c6566742d636f6c6f723a20233843314333383b0a7d0a0a2e706f6c6c62617233207b0a096261636b67726f756e642d636f6c6f723a20234431314134453b0a09626f726465722d626f74746f6d2d636f6c6f723a20234141323334363b0a09626f726465722d72696768742d636f6c6f723a20234141323334363b0a7d0a0a2e72746c202e706f6c6c62617233207b0a09626f726465722d6c6566742d636f6c6f723a20234141323334363b0a7d0a0a2e706f6c6c62617234207b0a096261636b67726f756e642d636f6c6f723a20234534313635333b0a09626f726465722d626f74746f6d2d636f6c6f723a20234245314534413b0a09626f726465722d72696768742d636f6c6f723a20234245314534413b0a7d0a0a2e72746c202e706f6c6c62617234207b0a09626f726465722d6c6566742d636f6c6f723a20234245314534413b0a7d0a0a2e706f6c6c62617235207b0a096261636b67726f756e642d636f6c6f723a20234638313135373b0a09626f726465722d626f74746f6d2d636f6c6f723a20234431314134453b0a09626f726465722d72696768742d636f6c6f723a20234431314134453b0a7d0a0a2e72746c202e706f6c6c62617235207b0a09626f726465722d6c6566742d636f6c6f723a20234431314134453b0a7d0a0a2f2a20506f737465722070726f66696c6520626c6f636b0a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2e706f737470726f66696c65207b0a09636f6c6f723a20233636363636363b0a09626f726465722d6c6566742d636f6c6f723a20234646464646463b0a7d0a0a2e72746c202e706f737470726f66696c65207b0a09626f726465722d72696768742d636f6c6f723a20234646464646463b0a09626f726465722d6c6566742d636f6c6f723a207472616e73706172656e743b0a7d0a0a2e706d202e706f737470726f66696c65207b0a09626f726465722d6c6566742d636f6c6f723a20234444444444443b0a7d0a0a2e72746c202e706d202e706f737470726f66696c65207b0a09626f726465722d72696768742d636f6c6f723a20234444444444443b0a09626f726465722d6c6566742d636f6c6f723a207472616e73706172656e743b0a7d0a0a2e706f737470726f66696c65207374726f6e67207b0a09636f6c6f723a20233030303030303b0a7d0a0a2e6f6e6c696e65207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f494d4147455345545f4c414e475f504154487d2f69636f6e5f757365725f6f6e6c696e652e67696622293b0a7d0a0a2f2a2020090a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a436f6c6f75727320616e64206261636b67726f756e647320666f7220627574746f6e732e6373730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2f2a2042696720627574746f6e20696d61676573202a2f0a2e7265706c792d69636f6e207370616e097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f425554544f4e5f544f5049435f5245504c595f5352437d22293b207d0a2e706f73742d69636f6e207370616e09097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f425554544f4e5f544f5049435f4e45575f5352437d22293b207d0a2e6c6f636b65642d69636f6e207370616e097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f425554544f4e5f544f5049435f4c4f434b45445f5352437d22293b207d0a2e706d7265706c792d69636f6e207370616e097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f425554544f4e5f504d5f5245504c595f5352437d2229203b7d0a2e6e6577706d2d69636f6e207370616e20097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f425554544f4e5f504d5f4e45575f5352437d2229203b7d0a2e666f7277617264706d2d69636f6e207370616e097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f425554544f4e5f504d5f464f52574152445f5352437d2229203b7d0a0a612e7072696e74207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f7072696e742e67696622293b0a7d0a0a612e73656e64656d61696c207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f73656e64656d61696c2e67696622293b0a7d0a0a612e666f6e7473697a65207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f666f6e7473697a652e67696622293b0a7d0a0a2f2a2049636f6e20696d616765730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2e73697465686f6d650909090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f686f6d652e67696622293b207d0a2e69636f6e2d6661710909090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f6661712e67696622293b207d0a2e69636f6e2d6d656d6265727309090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f6d656d626572732e67696622293b207d0a2e69636f6e2d686f6d650909090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f686f6d652e67696622293b207d0a2e69636f6e2d7563700909090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f7563702e67696622293b207d0a2e69636f6e2d726567697374657209090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f72656769737465722e67696622293b207d0a2e69636f6e2d6c6f676f757409090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f6c6f676f75742e67696622293b207d0a2e69636f6e2d626f6f6b6d61726b09090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f626f6f6b6d61726b2e67696622293b207d0a2e69636f6e2d62756d700909090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f62756d702e67696622293b207d0a2e69636f6e2d73756273637269626509090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f7375627363726962652e67696622293b207d0a2e69636f6e2d756e737562736372696265090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f756e7375627363726962652e67696622293b207d0a2e69636f6e2d70616765730909090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f70616765732e67696622293b207d0a2e69636f6e2d73656172636809090909097b206261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f7365617263682e67696622293b207d0a0a2f2a2050726f66696c652026206e617669676174696f6e2069636f6e73202a2f0a2e656d61696c2d69636f6e2c202e656d61696c2d69636f6e206109097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f454d41494c5f5352437d22293b207d0a2e61696d2d69636f6e2c202e61696d2d69636f6e20610909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f41494d5f5352437d22293b207d0a2e7961686f6f2d69636f6e2c202e7961686f6f2d69636f6e206109097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f5941484f4f5f5352437d22293b207d0a2e7765622d69636f6e2c202e7765622d69636f6e20610909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f5757575f5352437d22293b207d0a2e6d736e6d2d69636f6e2c202e6d736e6d2d69636f6e20610909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f4d534e4d5f5352437d22293b207d0a2e6963712d69636f6e2c202e6963712d69636f6e20610909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f4943515f5352437d22293b207d0a2e6a61626265722d69636f6e2c202e6a61626265722d69636f6e206109097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f4a41424245525f5352437d22293b207d0a2e706d2d69636f6e2c202e706d2d69636f6e2061090909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f434f4e544143545f504d5f5352437d22293b207d0a2e71756f74652d69636f6e2c202e71756f74652d69636f6e206109097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f504f53545f51554f54455f5352437d22293b207d0a0a2f2a204d6f64657261746f722069636f6e73202a2f0a2e7265706f72742d69636f6e2c202e7265706f72742d69636f6e206109097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f504f53545f5245504f52545f5352437d22293b207d0a2e656469742d69636f6e2c202e656469742d69636f6e20610909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f504f53545f454449545f5352437d22293b207d0a2e64656c6574652d69636f6e2c202e64656c6574652d69636f6e206109097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f504f53545f44454c4554455f5352437d22293b207d0a2e696e666f2d69636f6e2c202e696e666f2d69636f6e20610909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f504f53545f494e464f5f5352437d22293b207d0a2e7761726e2d69636f6e2c202e7761726e2d69636f6e20610909097b206261636b67726f756e642d696d6167653a2075726c28227b494d475f49434f4e5f555345525f5741524e5f5352437d22293b207d202f2a204e6565642075706461746564207761726e2069636f6e202a2f0a0a2f2a2020090a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a436f6c6f75727320616e64206261636b67726f756e647320666f722063702e6373730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2f2a204d61696e20435020626f780a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a0a2363702d6d61696e2068332c202363702d6d61696e2068722c202363702d6d656e75206872207b0a09626f726465722d636f6c6f723a20234134423342463b0a7d0a0a2363702d6d61696e202e70616e656c206c692e726f77207b0a09626f726465722d626f74746f6d2d636f6c6f723a20234235433143423b0a09626f726465722d746f702d636f6c6f723a20234639463946393b0a7d0a0a756c2e63706c697374207b0a09626f726465722d746f702d636f6c6f723a20234235433143423b0a7d0a0a2363702d6d61696e202e70616e656c206c692e6865616465722064642c202363702d6d61696e202e70616e656c206c692e686561646572206474207b0a09636f6c6f723a20233030303030303b0a7d0a0a2363702d6d61696e207461626c652e7461626c6531207468656164207468207b0a09636f6c6f723a20233333333333333b0a09626f726465722d626f74746f6d2d636f6c6f723a20233333333333333b0a7d0a0a2363702d6d61696e202e706d2d6d657373616765207b0a09626f726465722d636f6c6f723a20234442444545323b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a2f2a20435020746162626564206d656e750a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a23746162732061207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f62675f74616273312e67696622293b0a7d0a0a23746162732061207370616e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f62675f74616273322e67696622293b0a09636f6c6f723a20233533363438323b0a7d0a0a237461627320613a686f766572207370616e207b0a09636f6c6f723a20234243324134443b0a7d0a0a2374616273202e6163746976657461622061207b0a09626f726465722d626f74746f6d2d636f6c6f723a20234341444345423b0a7d0a0a2374616273202e6163746976657461622061207370616e207b0a09636f6c6f723a20233333333333333b0a7d0a0a2374616273202e61637469766574616220613a686f766572207370616e207b0a09636f6c6f723a20233030303030303b0a7d0a0a2f2a204d696e6920746162626564206d656e75207573656420696e204d43500a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a236d696e6974616273206c69207b0a096261636b67726f756e642d636f6c6f723a20234531454246323b0a7d0a0a236d696e6974616273206c692e616374697665746162207b0a096261636b67726f756e642d636f6c6f723a20234639463946393b0a7d0a0a236d696e6974616273206c692e61637469766574616220612c20236d696e6974616273206c692e61637469766574616220613a686f766572207b0a09636f6c6f723a20233333333333333b0a7d0a0a2f2a20554350206e617669676174696f6e206d656e750a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a0a2f2a204c696e6b207374796c657320666f7220746865207375622d73656374696f6e206c696e6b73202a2f0a236e617669676174696f6e2061207b0a09636f6c6f723a20233333333b0a096261636b67726f756e642d636f6c6f723a20234232433243463b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f62675f6d656e752e67696622293b0a7d0a0a236e617669676174696f6e20613a686f766572207b0a096261636b67726f756e642d636f6c6f723a20236161626163363b0a09636f6c6f723a20234243324134443b0a7d0a0a236e617669676174696f6e20236163746976652d73756273656374696f6e2061207b0a09636f6c6f723a20234433313134313b0a096261636b67726f756e642d636f6c6f723a20234639463946393b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a236e617669676174696f6e20236163746976652d73756273656374696f6e20613a686f766572207b0a09636f6c6f723a20234433313134313b0a7d0a0a2f2a20507265666572656e6365732070616e65206c61796f75740a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2363702d6d61696e206832207b0a09636f6c6f723a20233333333333333b0a7d0a0a2363702d6d61696e202e70616e656c207b0a096261636b67726f756e642d636f6c6f723a20234639463946393b0a7d0a0a2363702d6d61696e202e706d207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d746f702c202363702d6d656e75207370616e2e636f726e6572732d746f70207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f6c656674322e67696622293b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d746f70207370616e2c202363702d6d656e75207370616e2e636f726e6572732d746f70207370616e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f7269676874322e67696622293b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d626f74746f6d2c202363702d6d656e75207370616e2e636f726e6572732d626f74746f6d207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f6c656674322e67696622293b0a7d0a0a2363702d6d61696e207370616e2e636f726e6572732d626f74746f6d207370616e2c202363702d6d656e75207370616e2e636f726e6572732d626f74746f6d207370616e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f7269676874322e67696622293b0a7d0a0a2f2a20546f706963726576696577202a2f0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f702c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f70207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f6c6566742e67696622293b0a7d0a0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f70207370616e2c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d746f70207370616e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f72696768742e67696622293b0a7d0a0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d2c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f6c6566742e67696622293b0a7d0a0a2363702d6d61696e202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d207370616e2c202363702d6d656e75202e70616e656c2023746f706963726576696577207370616e2e636f726e6572732d626f74746f6d207370616e207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f636f726e6572735f72696768742e67696622293b0a7d0a0a2f2a20467269656e6473206c697374202a2f0a2e63702d6d696e69207b0a096261636b67726f756e642d636f6c6f723a20236565663566393b0a7d0a0a646c2e6d696e69206474207b0a09636f6c6f723a20233432353036373b0a7d0a0a2f2a20504d205374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a2f2a20504d204d65737361676520686973746f7279202a2f0a2e63757272656e74207b0a09636f6c6f723a20233939393939392021696d706f7274616e743b0a7d0a0a2f2a20504d206d61726b696e6720636f6c6f757273202a2f0a2e706d6c697374206c692e706d5f6d6573736167655f7265706f727465645f636f6c6f75722c202e706d5f6d6573736167655f7265706f727465645f636f6c6f7572207b0a09626f726465722d6c6566742d636f6c6f723a20234243324134443b0a09626f726465722d72696768742d636f6c6f723a20234243324134443b0a7d0a0a2e706d6c697374206c692e706d5f6d61726b65645f636f6c6f75722c202e706d5f6d61726b65645f636f6c6f7572207b0a09626f726465722d636f6c6f723a20234646363630303b0a7d0a0a2e706d6c697374206c692e706d5f7265706c6965645f636f6c6f75722c202e706d5f7265706c6965645f636f6c6f7572207b0a09626f726465722d636f6c6f723a20234139423843323b0a7d0a0a2e706d6c697374206c692e706d5f667269656e645f636f6c6f75722c202e706d5f667269656e645f636f6c6f7572207b0a09626f726465722d636f6c6f723a20233544384642443b0a7d0a0a706d6c697374206c692e706d5f666f655f636f6c6f75722c202e706d5f666f655f636f6c6f7572207b0a09626f726465722d636f6c6f723a20233030303030303b0a7d0a0a2f2a204176617461722067616c6c657279202a2f0a2367616c6c657279206c6162656c207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b0a09626f726465722d636f6c6f723a20234343433b0a7d0a0a2367616c6c657279206c6162656c3a686f766572207b0a096261636b67726f756e642d636f6c6f723a20234545453b0a7d0a0a2f2a2020090a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a436f6c6f75727320616e64206261636b67726f756e647320666f7220666f726d732e6373730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a2f2a2047656e6572616c20666f726d207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a73656c656374207b0a09626f726465722d636f6c6f723a20233636363636363b0a096261636b67726f756e642d636f6c6f723a20234641464146413b0a7d0a0a6c6162656c207b0a09636f6c6f723a20233432353036373b0a7d0a0a6f7074696f6e2e64697361626c65642d6f7074696f6e207b0a09636f6c6f723a2067726179746578743b0a7d0a0a2f2a20446566696e6974696f6e206c697374206c61796f757420666f7220666f726d730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a6464206c6162656c207b0a09636f6c6f723a20233333333b0a7d0a0a2f2a20486f7665722065666665637473202a2f0a6669656c6473657420646c3a686f766572206474206c6162656c207b0a09636f6c6f723a20233030303030303b0a7d0a0a6669656c647365742e6669656c64733220646c3a686f766572206474206c6162656c207b0a09636f6c6f723a20696e68657269743b0a7d0a0a2f2a20517569636b2d6c6f67696e206f6e20696e6465782070616765202a2f0a6669656c647365742e717569636b2d6c6f67696e20696e7075742e696e707574626f78207b0a096261636b67726f756e642d636f6c6f723a20234632463346333b0a7d0a0a2f2a20506f7374696e672070616765207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2a2f0a0a236d6573736167652d626f78207465787461726561207b0a09636f6c6f723a20233333333333333b0a7d0a0a2f2a20496e707574206669656c64207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2e696e707574626f78207b0a096261636b67726f756e642d636f6c6f723a20234646464646463b200a09626f726465722d636f6c6f723a20234234424143303b0a09636f6c6f723a20233333333333333b0a7d0a0a2e696e707574626f783a686f766572207b0a09626f726465722d636f6c6f723a20233131413345413b0a7d0a0a2e696e707574626f783a666f637573207b0a09626f726465722d636f6c6f723a20233131413345413b0a09636f6c6f723a20233046343938373b0a7d0a0a2f2a20466f726d20627574746f6e207374796c65730a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a612e627574746f6e312c20696e7075742e627574746f6e312c20696e7075742e627574746f6e332c20612e627574746f6e322c20696e7075742e627574746f6e32207b0a09636f6c6f723a20233030303b0a096261636b67726f756e642d636f6c6f723a20234641464146413b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f62675f627574746f6e2e67696622293b0a7d0a0a612e627574746f6e312c20696e7075742e627574746f6e31207b0a09626f726465722d636f6c6f723a20233636363636363b0a7d0a0a696e7075742e627574746f6e33207b0a096261636b67726f756e642d696d6167653a206e6f6e653b0a7d0a0a2f2a20416c7465726e617469766520627574746f6e202a2f0a612e627574746f6e322c20696e7075742e627574746f6e322c20696e7075742e627574746f6e33207b0a09626f726465722d636f6c6f723a20233636363636363b0a7d0a0a2f2a203c613e20627574746f6e20696e20746865207374796c65206f662074686520666f726d20627574746f6e73202a2f0a612e627574746f6e312c20612e627574746f6e313a6c696e6b2c20612e627574746f6e313a766973697465642c20612e627574746f6e313a6163746976652c20612e627574746f6e322c20612e627574746f6e323a6c696e6b2c20612e627574746f6e323a766973697465642c20612e627574746f6e323a616374697665207b0a09636f6c6f723a20233030303030303b0a7d0a0a2f2a20486f76657220737461746573202a2f0a612e627574746f6e313a686f7665722c20696e7075742e627574746f6e313a686f7665722c20612e627574746f6e323a686f7665722c20696e7075742e627574746f6e323a686f7665722c20696e7075742e627574746f6e333a686f766572207b0a09626f726465722d636f6c6f723a20234243324134443b0a09636f6c6f723a20234243324134443b0a7d0a0a696e7075742e736561726368207b0a096261636b67726f756e642d696d6167653a2075726c28227b545f5448454d455f504154487d2f696d616765732f69636f6e5f74657874626f785f7365617263682e67696622293b0a7d0a0a696e7075742e64697361626c6564207b0a09636f6c6f723a20233636363636363b0a7d0a);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_topics`
-- 

CREATE TABLE `ts_topics` (
  `topic_id` mediumint(8) unsigned NOT NULL auto_increment,
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `icon_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_attachment` tinyint(1) unsigned NOT NULL default '0',
  `topic_approved` tinyint(1) unsigned NOT NULL default '1',
  `topic_reported` tinyint(1) unsigned NOT NULL default '0',
  `topic_title` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL default '',
  `topic_poster` mediumint(8) unsigned NOT NULL default '0',
  `topic_time` int(11) unsigned NOT NULL default '0',
  `topic_time_limit` int(11) unsigned NOT NULL default '0',
  `topic_views` mediumint(8) unsigned NOT NULL default '0',
  `topic_replies` mediumint(8) unsigned NOT NULL default '0',
  `topic_replies_real` mediumint(8) unsigned NOT NULL default '0',
  `topic_status` tinyint(3) NOT NULL default '0',
  `topic_type` tinyint(3) NOT NULL default '0',
  `topic_first_post_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_first_poster_name` varchar(255) collate utf8_bin NOT NULL default '',
  `topic_first_poster_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `topic_last_post_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_last_poster_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_last_poster_name` varchar(255) collate utf8_bin NOT NULL default '',
  `topic_last_poster_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `topic_last_post_subject` varchar(255) collate utf8_bin NOT NULL default '',
  `topic_last_post_time` int(11) unsigned NOT NULL default '0',
  `topic_last_view_time` int(11) unsigned NOT NULL default '0',
  `topic_moved_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_bumped` tinyint(1) unsigned NOT NULL default '0',
  `topic_bumper` mediumint(8) unsigned NOT NULL default '0',
  `poll_title` varchar(255) collate utf8_bin NOT NULL default '',
  `poll_start` int(11) unsigned NOT NULL default '0',
  `poll_length` int(11) unsigned NOT NULL default '0',
  `poll_max_options` tinyint(4) NOT NULL default '1',
  `poll_last_vote` int(11) unsigned NOT NULL default '0',
  `poll_vote_change` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`topic_id`),
  KEY `forum_id` (`forum_id`),
  KEY `forum_id_type` (`forum_id`,`topic_type`),
  KEY `last_post_time` (`topic_last_post_time`),
  KEY `topic_approved` (`topic_approved`),
  KEY `forum_appr_last` (`forum_id`,`topic_approved`,`topic_last_post_id`),
  KEY `fid_time_moved` (`forum_id`,`topic_last_post_time`,`topic_moved_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `ts_topics`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_topics_posted`
-- 

CREATE TABLE `ts_topics_posted` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_posted` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_topics_posted`
-- 

INSERT INTO `ts_topics_posted` VALUES (2, 1, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_topics_track`
-- 

CREATE TABLE `ts_topics_track` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `forum_id` mediumint(8) unsigned NOT NULL default '0',
  `mark_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`topic_id`),
  KEY `forum_id` (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_topics_track`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_topics_watch`
-- 

CREATE TABLE `ts_topics_watch` (
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `notify_status` tinyint(1) unsigned NOT NULL default '0',
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`),
  KEY `notify_stat` (`notify_status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_topics_watch`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_user_group`
-- 

CREATE TABLE `ts_user_group` (
  `group_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `group_leader` tinyint(1) unsigned NOT NULL default '0',
  `user_pending` tinyint(1) unsigned NOT NULL default '1',
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  KEY `group_leader` (`group_leader`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_user_group`
-- 

INSERT INTO `ts_user_group` VALUES (1, 1, 0, 0);
INSERT INTO `ts_user_group` VALUES (2, 2, 0, 0);
INSERT INTO `ts_user_group` VALUES (4, 2, 0, 0);
INSERT INTO `ts_user_group` VALUES (5, 2, 1, 0);
INSERT INTO `ts_user_group` VALUES (6, 3, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 4, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 5, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 6, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 7, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 8, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 9, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 10, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 11, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 12, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 13, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 14, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 15, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 16, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 17, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 18, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 19, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 20, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 21, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 22, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 23, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 24, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 25, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 26, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 27, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 28, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 29, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 30, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 31, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 32, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 33, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 34, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 35, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 36, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 37, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 38, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 39, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 40, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 41, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 42, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 43, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 44, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 45, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 46, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 47, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 48, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 49, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 50, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 51, 0, 0);
INSERT INTO `ts_user_group` VALUES (6, 52, 0, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_users`
-- 

CREATE TABLE `ts_users` (
  `user_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_type` tinyint(2) NOT NULL default '0',
  `group_id` mediumint(8) unsigned NOT NULL default '3',
  `user_permissions` mediumtext collate utf8_bin NOT NULL,
  `user_perm_from` mediumint(8) unsigned NOT NULL default '0',
  `user_ip` varchar(40) collate utf8_bin NOT NULL default '',
  `user_regdate` int(11) unsigned NOT NULL default '0',
  `username` varchar(255) collate utf8_bin NOT NULL default '',
  `username_clean` varchar(255) collate utf8_bin NOT NULL default '',
  `user_password` varchar(40) collate utf8_bin NOT NULL default '',
  `user_passchg` int(11) unsigned NOT NULL default '0',
  `user_pass_convert` tinyint(1) unsigned NOT NULL default '0',
  `user_email` varchar(100) collate utf8_bin NOT NULL default '',
  `user_email_hash` bigint(20) NOT NULL default '0',
  `user_birthday` varchar(10) collate utf8_bin NOT NULL default '',
  `user_lastvisit` int(11) unsigned NOT NULL default '0',
  `user_lastmark` int(11) unsigned NOT NULL default '0',
  `user_lastpost_time` int(11) unsigned NOT NULL default '0',
  `user_lastpage` varchar(200) collate utf8_bin NOT NULL default '',
  `user_last_confirm_key` varchar(10) collate utf8_bin NOT NULL default '',
  `user_last_search` int(11) unsigned NOT NULL default '0',
  `user_warnings` tinyint(4) NOT NULL default '0',
  `user_last_warning` int(11) unsigned NOT NULL default '0',
  `user_login_attempts` tinyint(4) NOT NULL default '0',
  `user_inactive_reason` tinyint(2) NOT NULL default '0',
  `user_inactive_time` int(11) unsigned NOT NULL default '0',
  `user_posts` mediumint(8) unsigned NOT NULL default '0',
  `user_lang` varchar(30) collate utf8_bin NOT NULL default '',
  `user_timezone` decimal(5,2) NOT NULL default '0.00',
  `user_dst` tinyint(1) unsigned NOT NULL default '0',
  `user_dateformat` varchar(30) collate utf8_bin NOT NULL default 'd M Y H:i',
  `user_style` mediumint(8) unsigned NOT NULL default '0',
  `user_rank` mediumint(8) unsigned NOT NULL default '0',
  `user_colour` varchar(6) collate utf8_bin NOT NULL default '',
  `user_new_privmsg` int(4) NOT NULL default '0',
  `user_unread_privmsg` int(4) NOT NULL default '0',
  `user_last_privmsg` int(11) unsigned NOT NULL default '0',
  `user_message_rules` tinyint(1) unsigned NOT NULL default '0',
  `user_full_folder` int(11) NOT NULL default '-3',
  `user_emailtime` int(11) unsigned NOT NULL default '0',
  `user_topic_show_days` smallint(4) unsigned NOT NULL default '0',
  `user_topic_sortby_type` varchar(1) collate utf8_bin NOT NULL default 't',
  `user_topic_sortby_dir` varchar(1) collate utf8_bin NOT NULL default 'd',
  `user_post_show_days` smallint(4) unsigned NOT NULL default '0',
  `user_post_sortby_type` varchar(1) collate utf8_bin NOT NULL default 't',
  `user_post_sortby_dir` varchar(1) collate utf8_bin NOT NULL default 'a',
  `user_notify` tinyint(1) unsigned NOT NULL default '0',
  `user_notify_pm` tinyint(1) unsigned NOT NULL default '1',
  `user_notify_type` tinyint(4) NOT NULL default '0',
  `user_allow_pm` tinyint(1) unsigned NOT NULL default '1',
  `user_allow_viewonline` tinyint(1) unsigned NOT NULL default '1',
  `user_allow_viewemail` tinyint(1) unsigned NOT NULL default '1',
  `user_allow_massemail` tinyint(1) unsigned NOT NULL default '1',
  `user_options` int(11) unsigned NOT NULL default '895',
  `user_avatar` varchar(255) collate utf8_bin NOT NULL default '',
  `user_avatar_type` tinyint(2) NOT NULL default '0',
  `user_avatar_width` smallint(4) unsigned NOT NULL default '0',
  `user_avatar_height` smallint(4) unsigned NOT NULL default '0',
  `user_sig` mediumtext collate utf8_bin NOT NULL,
  `user_sig_bbcode_uid` varchar(8) collate utf8_bin NOT NULL default '',
  `user_sig_bbcode_bitfield` varchar(255) collate utf8_bin NOT NULL default '',
  `user_from` varchar(100) collate utf8_bin NOT NULL default '',
  `user_icq` varchar(15) collate utf8_bin NOT NULL default '',
  `user_aim` varchar(255) collate utf8_bin NOT NULL default '',
  `user_yim` varchar(255) collate utf8_bin NOT NULL default '',
  `user_msnm` varchar(255) collate utf8_bin NOT NULL default '',
  `user_jabber` varchar(255) collate utf8_bin NOT NULL default '',
  `user_website` varchar(200) collate utf8_bin NOT NULL default '',
  `user_occ` text collate utf8_bin NOT NULL,
  `user_interests` text collate utf8_bin NOT NULL,
  `user_actkey` varchar(32) collate utf8_bin NOT NULL default '',
  `user_newpasswd` varchar(40) collate utf8_bin NOT NULL default '',
  `user_form_salt` varchar(32) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `username_clean` (`username_clean`),
  KEY `user_birthday` (`user_birthday`),
  KEY `user_email_hash` (`user_email_hash`),
  KEY `user_type` (`user_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=53 ;

-- 
-- Dumping data for table `ts_users`
-- 

INSERT INTO `ts_users` VALUES (1, 2, 1, 0x30303030303030303030336b687261336e6b0a0a0a0a0a0a0a0a0a0a0a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f3030303030300a6931636a796f303030303030, 0, '', 1235828441, 0x416e6f6e796d6f7573, 0x616e6f6e796d6f7573, '', 0, 0, '', 0, '', 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x64204d205920483a69, 1, 0, '', 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x39393531623035303233383437666134);
INSERT INTO `ts_users` VALUES (2, 3, 5, 0x7a696b307a6a7a696b307a6a7a696b3078730a0a0a0a0a0a0a0a0a0a0a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d66323030303030300a7a69696d6632303030303030, 0, 0x3132312e3234362e3233342e323033, 1235828441, 0x6465616e, 0x6465616e, 0x24482439447a7a652f576e47712e727a38723632624f657865476652323772463830, 0, 0, 0x6465616e407465636873746174696f6e2e696e, 158884011819, '', 1235828477, 0, 0, 0x61646d2f696e6465782e706870, '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 1, 0x414130303030, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 1, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x36323939343333383066313363626535);
INSERT INTO `ts_users` VALUES (3, 2, 6, '', 0, '', 1235828447, 0x416473426f74205b476f6f676c655d, 0x616473626f74205b676f6f676c655d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x63366432656666316137306261323837);
INSERT INTO `ts_users` VALUES (4, 2, 6, '', 0, '', 1235828447, 0x416c657861205b426f745d, 0x616c657861205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x37356630386133303839396666396630);
INSERT INTO `ts_users` VALUES (5, 2, 6, '', 0, '', 1235828447, 0x416c7461205669737461205b426f745d, 0x616c7461207669737461205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x61356661656631373733666562333237);
INSERT INTO `ts_users` VALUES (6, 2, 6, '', 0, '', 1235828447, 0x41736b204a6565766573205b426f745d, 0x61736b206a6565766573205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x66343531626231356136366630333037);
INSERT INTO `ts_users` VALUES (7, 2, 6, '', 0, '', 1235828447, 0x4261696475205b5370696465725d, 0x6261696475205b7370696465725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x35626563396238613031366531396466);
INSERT INTO `ts_users` VALUES (8, 2, 6, '', 0, '', 1235828447, 0x457861626f74205b426f745d, 0x657861626f74205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x65643134366264386335396232633439);
INSERT INTO `ts_users` VALUES (9, 2, 6, '', 0, '', 1235828447, 0x4641535420456e7465727072697365205b437261776c65725d, 0x6661737420656e7465727072697365205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x38613362323539363433383234373135);
INSERT INTO `ts_users` VALUES (10, 2, 6, '', 0, '', 1235828447, 0x4641535420576562437261776c6572205b437261776c65725d, 0x6661737420776562637261776c6572205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x63633465313062313361643831373561);
INSERT INTO `ts_users` VALUES (11, 2, 6, '', 0, '', 1235828447, 0x4672616e636973205b426f745d, 0x6672616e636973205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x64333861663039343866666464613763);
INSERT INTO `ts_users` VALUES (12, 2, 6, '', 0, '', 1235828447, 0x47696761626f74205b426f745d, 0x67696761626f74205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x32653663383033666531343738306161);
INSERT INTO `ts_users` VALUES (13, 2, 6, '', 0, '', 1235828447, 0x476f6f676c6520416473656e7365205b426f745d, 0x676f6f676c6520616473656e7365205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x32633034636132653838383739396530);
INSERT INTO `ts_users` VALUES (14, 2, 6, '', 0, '', 1235828447, 0x476f6f676c65204465736b746f70, 0x676f6f676c65206465736b746f70, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x38363530626630386431623430643035);
INSERT INTO `ts_users` VALUES (15, 2, 6, '', 0, '', 1235828447, 0x476f6f676c65204665656466657463686572, 0x676f6f676c65206665656466657463686572, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x39333461323232636231616265613561);
INSERT INTO `ts_users` VALUES (16, 2, 6, '', 0, '', 1235828447, 0x476f6f676c65205b426f745d, 0x676f6f676c65205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x65393732333863633439333265646565);
INSERT INTO `ts_users` VALUES (17, 2, 6, '', 0, '', 1235828447, 0x48656973652049542d4d61726b74205b437261776c65725d, 0x68656973652069742d6d61726b74205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x61633337633162323564373038663838);
INSERT INTO `ts_users` VALUES (18, 2, 6, '', 0, '', 1235828447, 0x4865726974726978205b437261776c65725d, 0x6865726974726978205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x66356331353539303164643337393835);
INSERT INTO `ts_users` VALUES (19, 2, 6, '', 0, '', 1235828447, 0x49424d205265736561726368205b426f745d, 0x69626d207265736561726368205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x62333536306261383962646138383765);
INSERT INTO `ts_users` VALUES (20, 2, 6, '', 0, '', 1235828447, 0x4943437261776c6572202d2049436a6f6273, 0x6963637261776c6572202d2069636a6f6273, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x64633838366639383336376561323936);
INSERT INTO `ts_users` VALUES (21, 2, 6, '', 0, '', 1235828447, 0x69636869726f205b437261776c65725d, 0x69636869726f205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x65623836646462383231336463663866);
INSERT INTO `ts_users` VALUES (22, 2, 6, '', 0, '', 1235828447, 0x4d616a65737469632d3132205b426f745d, 0x6d616a65737469632d3132205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x39623866663731616562613031303939);
INSERT INTO `ts_users` VALUES (23, 2, 6, '', 0, '', 1235828447, 0x4d657461676572205b426f745d, 0x6d657461676572205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x65646237666538383830346532373031);
INSERT INTO `ts_users` VALUES (24, 2, 6, '', 0, '', 1235828447, 0x4d534e204e657773426c6f6773, 0x6d736e206e657773626c6f6773, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x66366131613932386563653465383637);
INSERT INTO `ts_users` VALUES (25, 2, 6, '', 0, '', 1235828447, 0x4d534e205b426f745d, 0x6d736e205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x32376635383338326362613038336265);
INSERT INTO `ts_users` VALUES (26, 2, 6, '', 0, '', 1235828447, 0x4d534e626f74204d65646961, 0x6d736e626f74206d65646961, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x61653635376564363063316462323834);
INSERT INTO `ts_users` VALUES (27, 2, 6, '', 0, '', 1235828447, 0x4e472d536561726368205b426f745d, 0x6e672d736561726368205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x34306566393831373334306564656332);
INSERT INTO `ts_users` VALUES (28, 2, 6, '', 0, '', 1235828447, 0x4e75746368205b426f745d, 0x6e75746368205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x32363931626362393661353436623238);
INSERT INTO `ts_users` VALUES (29, 2, 6, '', 0, '', 1235828447, 0x4e757463682f435653205b426f745d, 0x6e757463682f637673205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x36353361373837306361383736623134);
INSERT INTO `ts_users` VALUES (30, 2, 6, '', 0, '', 1235828447, 0x4f6d6e694578706c6f726572205b426f745d, 0x6f6d6e696578706c6f726572205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x36383939643431633030643036626538);
INSERT INTO `ts_users` VALUES (31, 2, 6, '', 0, '', 1235828447, 0x4f6e6c696e65206c696e6b205b56616c696461746f725d, 0x6f6e6c696e65206c696e6b205b76616c696461746f725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x63393333623266643666316534633338);
INSERT INTO `ts_users` VALUES (32, 2, 6, '', 0, '', 1235828447, 0x7073626f74205b5069637365617263685d, 0x7073626f74205b7069637365617263685d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x30623861613536643233323861356134);
INSERT INTO `ts_users` VALUES (33, 2, 6, '', 0, '', 1235828447, 0x5365656b706f7274205b426f745d, 0x7365656b706f7274205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x64313639396162616138303832366437);
INSERT INTO `ts_users` VALUES (34, 2, 6, '', 0, '', 1235828447, 0x53656e736973205b437261776c65725d, 0x73656e736973205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x34653930643634653430346639636233);
INSERT INTO `ts_users` VALUES (35, 2, 6, '', 0, '', 1235828447, 0x53454f20437261776c6572, 0x73656f20637261776c6572, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x31353937656463643938366263333630);
INSERT INTO `ts_users` VALUES (36, 2, 6, '', 0, '', 1235828447, 0x53656f6d61205b437261776c65725d, 0x73656f6d61205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x32393362643837613666346163613037);
INSERT INTO `ts_users` VALUES (37, 2, 6, '', 0, '', 1235828447, 0x53454f536561726368205b437261776c65725d, 0x73656f736561726368205b637261776c65725d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x32323063396630653237363030343362);
INSERT INTO `ts_users` VALUES (38, 2, 6, '', 0, '', 1235828447, 0x536e61707079205b426f745d, 0x736e61707079205b626f745d, '', 1235828447, 0, '', 0, '', 0, 1235828447, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x64393464333933633835363562376362);
INSERT INTO `ts_users` VALUES (39, 2, 6, '', 0, '', 1235828448, 0x537465656c6572205b437261776c65725d, 0x737465656c6572205b637261776c65725d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x33356134623335656465313132356533);
INSERT INTO `ts_users` VALUES (40, 2, 6, '', 0, '', 1235828448, 0x53796e6f6f205b426f745d, 0x73796e6f6f205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x64323837356239323362613436616432);
INSERT INTO `ts_users` VALUES (41, 2, 6, '', 0, '', 1235828448, 0x54656c656b6f6d205b426f745d, 0x74656c656b6f6d205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x64303732313636646263363139326539);
INSERT INTO `ts_users` VALUES (42, 2, 6, '', 0, '', 1235828448, 0x5475726e6974696e426f74205b426f745d, 0x7475726e6974696e626f74205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x31393664663163396439646364636637);
INSERT INTO `ts_users` VALUES (43, 2, 6, '', 0, '', 1235828448, 0x566f7961676572205b426f745d, 0x766f7961676572205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x31633932653762353731373837353865);
INSERT INTO `ts_users` VALUES (44, 2, 6, '', 0, '', 1235828448, 0x5733205b536974657365617263685d, 0x7733205b736974657365617263685d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x30653431373132623063323238393632);
INSERT INTO `ts_users` VALUES (45, 2, 6, '', 0, '', 1235828448, 0x573343205b4c696e6b636865636b5d, 0x773363205b6c696e6b636865636b5d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x36356534303861386463633565306534);
INSERT INTO `ts_users` VALUES (46, 2, 6, '', 0, '', 1235828448, 0x573343205b56616c696461746f725d, 0x773363205b76616c696461746f725d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x35336539303932323866316433663234);
INSERT INTO `ts_users` VALUES (47, 2, 6, '', 0, '', 1235828448, 0x576973654e7574205b426f745d, 0x776973656e7574205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x62653266623962653561623131336662);
INSERT INTO `ts_users` VALUES (48, 2, 6, '', 0, '', 1235828448, 0x59614379205b426f745d, 0x79616379205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x33373138626133343066663531666531);
INSERT INTO `ts_users` VALUES (49, 2, 6, '', 0, '', 1235828448, 0x5961686f6f204d4d437261776c6572205b426f745d, 0x7961686f6f206d6d637261776c6572205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x35346533623765343964313733643263);
INSERT INTO `ts_users` VALUES (50, 2, 6, '', 0, '', 1235828448, 0x5961686f6f20536c757270205b426f745d, 0x7961686f6f20736c757270205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x31303138303134303336386134613132);
INSERT INTO `ts_users` VALUES (51, 2, 6, '', 0, '', 1235828448, 0x5961686f6f205b426f745d, 0x7961686f6f205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x62313562353532643665643466353835);
INSERT INTO `ts_users` VALUES (52, 2, 6, '', 0, '', 1235828448, 0x5961686f6f5365656b6572205b426f745d, 0x7961686f6f7365656b6572205b626f745d, '', 1235828448, 0, '', 0, '', 0, 1235828448, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0x656e, '0.00', 0, 0x44204d20642c205920673a692061, 1, 0, 0x394538444137, 0, 0, 0, 0, -3, 0, 0, 0x74, 0x64, 0, 0x74, 0x61, 0, 1, 0, 1, 1, 1, 0, 895, '', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0x34623033633039373232306636343839);

-- --------------------------------------------------------

-- 
-- Table structure for table `ts_warnings`
-- 

CREATE TABLE `ts_warnings` (
  `warning_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `post_id` mediumint(8) unsigned NOT NULL default '0',
  `log_id` mediumint(8) unsigned NOT NULL default '0',
  `warning_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`warning_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_warnings`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_words`
-- 

CREATE TABLE `ts_words` (
  `word_id` mediumint(8) unsigned NOT NULL auto_increment,
  `word` varchar(255) collate utf8_bin NOT NULL default '',
  `replacement` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`word_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `ts_words`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `ts_zebra`
-- 

CREATE TABLE `ts_zebra` (
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `zebra_id` mediumint(8) unsigned NOT NULL default '0',
  `friend` tinyint(1) unsigned NOT NULL default '0',
  `foe` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`zebra_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 
-- Dumping data for table `ts_zebra`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_bandwidth`
-- 

CREATE TABLE `x7chat2_bandwidth` (
  `id` int(11) NOT NULL auto_increment,
  `user` varchar(255) NOT NULL default '',
  `used` bigint(20) NOT NULL default '0',
  `max` bigint(20) NOT NULL default '0',
  `current` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `x7chat2_bandwidth`
-- 

INSERT INTO `x7chat2_bandwidth` VALUES (1, 'Volcano', 0, -1, 1248991200);
INSERT INTO `x7chat2_bandwidth` VALUES (2, 'Po11ix', 0, -1, 1248991200);
INSERT INTO `x7chat2_bandwidth` VALUES (3, 'Cast0r', 0, -1, 1248991200);
INSERT INTO `x7chat2_bandwidth` VALUES (4, 'BasisB', 0, -1, 1248991200);
INSERT INTO `x7chat2_bandwidth` VALUES (5, 'Edimonster', 0, -1, 1248991200);

-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_banned`
-- 

CREATE TABLE `x7chat2_banned` (
  `id` int(11) NOT NULL auto_increment,
  `room` varchar(255) NOT NULL default '',
  `user_ip_email` varchar(255) NOT NULL default '',
  `starttime` int(11) NOT NULL default '0',
  `endtime` int(11) NOT NULL default '0',
  `reason` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `x7chat2_banned`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_events`
-- 

CREATE TABLE `x7chat2_events` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` int(11) NOT NULL default '0',
  `event` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `x7chat2_events`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_filter`
-- 

CREATE TABLE `x7chat2_filter` (
  `id` int(11) NOT NULL auto_increment,
  `room` varchar(255) NOT NULL default '',
  `type` int(11) NOT NULL default '0',
  `text` varchar(255) NOT NULL default '',
  `replacement` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

-- 
-- Dumping data for table `x7chat2_filter`
-- 

INSERT INTO `x7chat2_filter` VALUES (1, '', 2, '8|', '<img src="./smilies/big_eyes.gif">');
INSERT INTO `x7chat2_filter` VALUES (2, '', 2, ';)', '<img src="./smilies/wink.gif">');
INSERT INTO `x7chat2_filter` VALUES (3, '', 2, '=|', '<img src="./smilies/not_impressed.gif">');
INSERT INTO `x7chat2_filter` VALUES (4, '', 2, ':D', '<img src="./smilies/grin.gif">');
INSERT INTO `x7chat2_filter` VALUES (5, '', 2, ':(', '<img src="./smilies/unhappy.gif">');
INSERT INTO `x7chat2_filter` VALUES (6, '', 2, ':o', '<img src="./smilies/surprised.gif">');
INSERT INTO `x7chat2_filter` VALUES (7, '', 2, ':|', '<img src="./smilies/straight.gif">');
INSERT INTO `x7chat2_filter` VALUES (8, '', 2, ':)', '<img src="./smilies/happy.gif">');
INSERT INTO `x7chat2_filter` VALUES (9, '', 2, ':,(', '<img src="./smilies/cry.gif">');
INSERT INTO `x7chat2_filter` VALUES (10, '', 2, '8)', '<img src="./smilies/cool.gif">');
INSERT INTO `x7chat2_filter` VALUES (11, '', 2, ':roll:', '<img src="./smilies/eye_roll.gif">');
INSERT INTO `x7chat2_filter` VALUES (12, '', 2, ':wink:', '<img src="./smilies/ani_wink.gif">');
INSERT INTO `x7chat2_filter` VALUES (13, '', 2, ':p', '<img src="./smilies/stickout.gif">');

-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_messages`
-- 

CREATE TABLE `x7chat2_messages` (
  `id` int(11) NOT NULL auto_increment,
  `user` varchar(255) NOT NULL default '0',
  `type` int(11) NOT NULL default '0',
  `body` text NOT NULL,
  `body_parsed` text NOT NULL,
  `room` varchar(255) NOT NULL default '',
  `time` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=355 ;

-- 
-- Dumping data for table `x7chat2_messages`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_muted`
-- 

CREATE TABLE `x7chat2_muted` (
  `id` int(11) NOT NULL auto_increment,
  `user` varchar(255) NOT NULL default '',
  `ignored_user` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `x7chat2_muted`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_online`
-- 

CREATE TABLE `x7chat2_online` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `ip` varchar(255) NOT NULL default '',
  `room` varchar(255) NOT NULL default '',
  `usersonline` tinytext NOT NULL,
  `time` int(11) NOT NULL default '0',
  `invisible` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9471 ;

-- 
-- Dumping data for table `x7chat2_online`
-- 

INSERT INTO `x7chat2_online` VALUES (9468, 'basisb', '196.13.229.9', 'Travian', '', 1250439773, 0);
INSERT INTO `x7chat2_online` VALUES (9464, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7036, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9463, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7035, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9462, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7034, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9461, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7033, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9460, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7032, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9459, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7031, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9458, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9457, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9456, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9455, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9454, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9453, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9452, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9451, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9450, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9449, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9448, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9447, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9446, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9445, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9444, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9443, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9442, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9441, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9440, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9439, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9438, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9437, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9436, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9435, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9434, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9433, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9432, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9431, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9430, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9429, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9428, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9427, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9426, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9425, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9424, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9423, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9422, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9421, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9420, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9419, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9418, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9417, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9416, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9415, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9414, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9413, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9412, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9411, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9410, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9409, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9408, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9407, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9406, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9405, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9404, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9403, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9402, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9401, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9400, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9399, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9398, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9397, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9396, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9395, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9394, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9393, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9392, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9391, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9390, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9389, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9388, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9387, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9386, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9385, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9384, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9383, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9382, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9381, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9380, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9379, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9378, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9377, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9376, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9375, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9374, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9373, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9372, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9371, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9370, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9369, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9368, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9367, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9366, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9365, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9364, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9363, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9362, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9361, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9360, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9359, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9358, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9357, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9356, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9355, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9354, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9353, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9352, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9351, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9350, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9349, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9348, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9347, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9346, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9345, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9344, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9343, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9342, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9341, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9340, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9339, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9338, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9337, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9336, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9335, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9334, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9333, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9332, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9331, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9330, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9329, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9328, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9327, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9326, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9325, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9324, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9323, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9322, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9321, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9320, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9319, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9318, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9317, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9316, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9315, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9314, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9313, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9312, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9311, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9310, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9309, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9308, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9307, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9306, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9305, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9304, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9303, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9302, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9301, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9300, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9299, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9298, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9297, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9296, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9295, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9294, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9293, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9292, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9291, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9290, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9289, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9288, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9287, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9286, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9285, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9284, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9283, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9282, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9281, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9280, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9279, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9278, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9277, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9276, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9275, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9274, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9273, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9272, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9271, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9270, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9269, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9268, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9267, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9266, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9265, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9264, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9263, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9262, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9261, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9260, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9259, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9258, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9257, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9256, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9255, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9254, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9253, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9252, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9251, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9250, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9249, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9248, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9247, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9246, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9245, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9244, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9243, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9242, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9241, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9240, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9239, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9238, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9237, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9236, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9235, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9234, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9233, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9232, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9231, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9230, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9229, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9228, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9227, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9226, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9225, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9224, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9223, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9222, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9221, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9220, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9219, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9218, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9217, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9216, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9215, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9214, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9213, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9212, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9211, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9210, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9209, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9208, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9207, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9206, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9205, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9204, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9203, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9202, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9201, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9200, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9199, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9198, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9197, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9196, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9195, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9194, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9193, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9192, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9191, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9190, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9189, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9188, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9187, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9186, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9185, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9184, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9183, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9182, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9181, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9180, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9179, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9178, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9177, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9176, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9175, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9174, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9173, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9172, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9171, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9170, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9169, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9168, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9167, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9166, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9165, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9164, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9163, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9162, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9161, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9160, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9159, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9158, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9157, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9156, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9155, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9154, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9153, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9152, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9151, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9150, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9149, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9148, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9147, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9146, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9145, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9144, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9143, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9142, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9141, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9140, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9139, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9138, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9137, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9136, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9135, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9134, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9133, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9132, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9131, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9130, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9129, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9128, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9127, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9126, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9125, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9124, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9123, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9122, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9121, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9120, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9119, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9118, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9117, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9116, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9115, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9114, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9113, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9112, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9111, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9110, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9109, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9108, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9107, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9106, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9105, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9104, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9103, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9102, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9101, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9100, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9099, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9098, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9097, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9096, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9095, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9094, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9093, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9092, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9091, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9090, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9089, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9088, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9087, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9086, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9085, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9084, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9083, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9082, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9081, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9080, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9079, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9078, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9077, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9076, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9075, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9074, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9073, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9072, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9071, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9070, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9069, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9068, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9067, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9066, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9065, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9064, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9063, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9062, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9061, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9060, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9059, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9058, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9057, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9056, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9055, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9054, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9053, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9052, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9051, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9050, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9049, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9048, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9047, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9046, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9045, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9044, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9043, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9042, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9041, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9040, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9039, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9038, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9037, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9036, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9035, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9034, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9033, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9032, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9031, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9030, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9029, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9028, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9027, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9026, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9025, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9024, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9023, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9022, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9021, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9020, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9019, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9018, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9017, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9016, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9015, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9014, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9013, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9012, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9011, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9010, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9009, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9008, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9007, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9006, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9005, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9004, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9003, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9002, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9001, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9000, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8999, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8998, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8997, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8996, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8995, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8994, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8993, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8992, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8991, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8990, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8989, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8988, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8987, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8986, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8985, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8984, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8983, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8982, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8981, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8980, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8979, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8978, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8977, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8976, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8975, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8974, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8973, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8972, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8971, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8970, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8969, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8968, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8967, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8966, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8965, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8964, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8963, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8962, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8961, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8960, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8959, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8958, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8957, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8956, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8955, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8954, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8953, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8952, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8951, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8950, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8949, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8948, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8947, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8946, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8945, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8944, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8943, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8942, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8941, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8940, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8939, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8938, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8937, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8936, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8935, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8934, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8933, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8932, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8931, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8930, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8929, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8928, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8927, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8926, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8925, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8924, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8923, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8922, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8921, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8920, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8919, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8918, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8917, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8916, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8915, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8914, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8913, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8912, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8911, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8910, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8909, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8908, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8907, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8906, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8905, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8904, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8903, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8902, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8901, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8900, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8899, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8898, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8897, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8896, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8895, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8894, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8893, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8892, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8891, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8890, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8889, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8888, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8887, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8886, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8885, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8884, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8883, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8882, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8881, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8880, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8879, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8878, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8877, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8876, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8875, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8874, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8873, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8872, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8871, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8870, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8869, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8868, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8867, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8866, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8865, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8864, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8863, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8862, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8861, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8860, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8859, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8858, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8857, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8856, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8855, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8854, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8853, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8852, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8851, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8850, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8849, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8848, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8847, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8846, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8845, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8844, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8843, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8842, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8841, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8840, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8839, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8838, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8837, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8836, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8835, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8834, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8833, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8832, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8831, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8830, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8829, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8828, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8827, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8826, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8825, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8824, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8823, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8822, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8821, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8820, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8819, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8818, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8817, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8816, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8815, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8814, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8813, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8812, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8811, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8810, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8809, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8808, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8807, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8806, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8805, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8804, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8803, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8802, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8801, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8800, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8799, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8798, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8797, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8796, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8795, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8794, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8793, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8792, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8791, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8790, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8789, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8788, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8787, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8786, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8785, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8784, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8783, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8782, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8781, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8780, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8779, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8778, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8777, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8776, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8775, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8774, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8773, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8772, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8771, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8770, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8769, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8768, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8767, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8766, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8765, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8764, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8763, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8762, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8761, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8760, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8759, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8758, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8757, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8756, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8755, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8754, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8753, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8752, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8751, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8750, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8749, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8748, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8747, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8746, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8745, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8744, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8743, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8742, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8741, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8740, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8739, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8738, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8737, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8736, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8735, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8734, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8733, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8732, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8731, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8730, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8729, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8728, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8727, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8726, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8725, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8724, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8723, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8722, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8721, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8720, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8719, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8718, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8717, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8716, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8715, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8714, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8713, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8712, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8711, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8710, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8709, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8708, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8707, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8706, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8705, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8704, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8703, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8702, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8701, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8700, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8699, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8698, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8697, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8696, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8695, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8694, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8693, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8692, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8691, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8690, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8689, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8688, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8687, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8686, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8685, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8684, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8683, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8682, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8681, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8680, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8679, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8678, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8677, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8676, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8675, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8674, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8673, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8672, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8671, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8670, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8669, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8668, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8667, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8666, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8665, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8664, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8663, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8662, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8661, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8660, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8659, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8658, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8657, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8656, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8655, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8654, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8653, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8652, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8651, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8650, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8649, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8648, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8647, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8646, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8645, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8644, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8643, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8642, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8641, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8640, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8639, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8638, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8637, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8636, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8635, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8634, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8633, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8632, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8631, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8630, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8629, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8628, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8627, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8626, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8625, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8624, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8623, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8622, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8621, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8620, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8619, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8618, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8617, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8616, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8615, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8614, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8613, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8612, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8611, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8610, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8609, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8608, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8607, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8606, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8605, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8604, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8603, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8602, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8601, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8600, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8599, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8598, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8597, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8596, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8595, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8594, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8593, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8592, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8591, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8590, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8589, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8588, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8587, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8586, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8585, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8584, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8583, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8582, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8581, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8580, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8579, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8578, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8577, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8576, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8575, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8574, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8573, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8572, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8571, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8570, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8569, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8568, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8567, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8566, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8565, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8564, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8563, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8562, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8561, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8560, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8559, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8558, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8557, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8556, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8555, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8554, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8553, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8552, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8551, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8550, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8549, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8548, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8547, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8546, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8545, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8544, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8543, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8542, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8541, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8540, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8539, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8538, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8537, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8536, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8535, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8534, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8533, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8532, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8531, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8530, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8529, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8528, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8527, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8526, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8525, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8524, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8523, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8522, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8521, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8520, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8519, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8518, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8517, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8516, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8515, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8514, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8513, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8512, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8511, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8510, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8509, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8508, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8507, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8506, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8505, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8504, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8503, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8502, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8501, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8500, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8499, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8498, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8497, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8496, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8495, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8494, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8493, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8492, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8491, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8490, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8489, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8488, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8487, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8486, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8485, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8484, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8483, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8482, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8481, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8480, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8479, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8478, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8477, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8476, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8475, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8474, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8473, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8472, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8471, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8470, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8469, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8468, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8467, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8466, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8465, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8464, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8463, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8462, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8461, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8460, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8459, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8458, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8457, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8456, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8455, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8454, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8453, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8452, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8451, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8450, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8449, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8448, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8447, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8446, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8445, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8444, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8443, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8442, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8441, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8440, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8439, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8438, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8437, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8436, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8435, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8434, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8433, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8432, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8431, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8430, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8429, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8428, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8427, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8426, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8425, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8424, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8423, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8422, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8421, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8420, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8419, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8418, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8417, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8416, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8415, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8414, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8413, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8412, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8411, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8410, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8409, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8408, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8407, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8406, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8405, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8404, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8403, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8402, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8401, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8400, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8399, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8398, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8397, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8396, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8395, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8394, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8393, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8392, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8391, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8390, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8389, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8388, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8387, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8386, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8385, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8384, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8383, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8382, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8381, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8380, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8379, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8378, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8377, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8376, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8375, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8374, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8373, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8372, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8371, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8370, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8369, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8368, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8367, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8366, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8365, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8364, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8363, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8362, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8361, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8360, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8359, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8358, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8357, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8356, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8355, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8354, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8353, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8352, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8351, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8350, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8349, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8348, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8347, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8346, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8345, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8344, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8343, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8342, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8341, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8340, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8339, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8338, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8337, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8336, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8335, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8334, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8333, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8332, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8331, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8330, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8329, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8328, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8327, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8326, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8325, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8324, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8323, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8322, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8321, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8320, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8319, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8318, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8317, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8316, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8315, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8314, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8313, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8312, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8311, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8310, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8309, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8308, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8307, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8306, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8305, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8304, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8303, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8302, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8301, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8300, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8299, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8298, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8297, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8296, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8295, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8294, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8293, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8292, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8291, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8290, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8289, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8288, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8287, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8286, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8285, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8284, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8283, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8282, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8281, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8280, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8279, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8278, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8277, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8276, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8275, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8274, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8273, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8272, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8271, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8270, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8269, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8268, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8267, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8266, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8265, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8264, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8263, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8262, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8261, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8260, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8259, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8258, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8257, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8256, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8255, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8254, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8253, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8252, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8251, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8250, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8249, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8248, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8247, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8246, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8245, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8244, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8243, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8242, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8241, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8240, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8239, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8238, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8237, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8236, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8235, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8234, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8233, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8232, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8231, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8230, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8229, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8228, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8227, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8226, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8225, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8224, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8223, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8222, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8221, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8220, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8219, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8218, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8217, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8216, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8215, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8214, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8213, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8212, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8211, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8210, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8209, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8208, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8207, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8206, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8205, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8204, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8203, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8202, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8201, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8200, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8199, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8198, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8197, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8196, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8195, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8194, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8193, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8192, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8191, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8190, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8189, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8188, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8187, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8186, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8185, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8184, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8183, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8182, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8181, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8180, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8179, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8178, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8177, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8176, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8175, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8174, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8173, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8172, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8171, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8170, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8169, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8168, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8167, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8166, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8165, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8164, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8163, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8162, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8161, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8160, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8159, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8158, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8157, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8156, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8155, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8154, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8153, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8152, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8151, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8150, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8149, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8148, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8147, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8146, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8145, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8144, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8143, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8142, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8141, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8140, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8139, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8138, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8137, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8136, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8135, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8134, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8133, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8132, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8131, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8130, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8129, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8128, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8127, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8126, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8125, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8124, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8123, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8122, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8121, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8120, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8119, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8118, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8117, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8116, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8115, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8114, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8113, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8112, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8111, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8110, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8109, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8108, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8107, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8106, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8105, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8104, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8103, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8102, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8101, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8100, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8099, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8098, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8097, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8096, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (9470, 'Edimonster', '90.220.51.14', 'Travian', '', 1250513252, 0);
INSERT INTO `x7chat2_online` VALUES (7040, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7041, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7042, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7043, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7044, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7045, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7046, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7047, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7048, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8095, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8094, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8093, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8092, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8091, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8090, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8089, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8088, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8087, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8086, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8085, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8084, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8083, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8082, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8081, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8080, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8079, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8078, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8077, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8076, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8075, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8074, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8073, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8072, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8071, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8070, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8069, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8068, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8067, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8066, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8065, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8064, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8063, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8062, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8061, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8060, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8059, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8058, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8057, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8056, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8055, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8054, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8053, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8052, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8051, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8050, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8049, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8048, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8047, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8046, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8045, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8044, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8043, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8042, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8041, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8040, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8039, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8038, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8037, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8036, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8035, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8034, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8033, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8032, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8031, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8030, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8029, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8028, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8027, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8026, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8025, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8024, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8023, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8022, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8021, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8020, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8019, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8018, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8017, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8016, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8015, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8014, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8013, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8012, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8011, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8010, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8009, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8008, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8007, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8006, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8005, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8004, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8003, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8002, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8001, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (8000, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7999, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7998, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7997, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7996, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7995, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7994, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7993, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7992, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7991, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7990, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7989, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7988, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7987, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7986, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7985, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7984, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7983, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7982, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7981, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7980, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7979, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7978, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7977, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7976, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7975, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7974, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7973, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7972, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7971, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7970, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7969, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7968, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7967, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7966, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7965, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7964, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7963, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7962, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7961, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7960, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7959, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7958, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7957, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7956, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7955, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7954, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7953, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7952, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7951, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7950, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7949, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7948, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7947, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7946, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7945, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7944, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7943, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7942, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7941, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7940, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7939, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7938, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7937, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7936, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7935, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7934, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7933, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7932, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7931, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7930, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7929, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7928, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7927, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7926, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7925, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7924, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7923, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7922, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7921, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7920, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7919, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7918, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7917, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7916, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7915, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7914, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7913, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7912, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7911, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7910, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7909, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7908, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7907, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7906, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7905, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7904, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7903, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7902, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7901, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7900, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7899, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7898, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7897, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7896, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7895, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7894, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7893, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7892, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7891, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7890, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7889, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7888, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7887, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7886, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7885, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7884, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7883, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7882, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7881, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7880, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7879, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7878, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7877, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7876, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7875, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7874, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7873, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7872, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7871, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7870, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7869, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7868, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7867, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7866, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7865, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7864, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7863, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7862, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7861, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7860, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7859, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7858, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7857, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7856, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7855, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7854, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7853, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7852, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7851, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7850, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7849, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7848, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7847, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7846, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7845, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7844, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7843, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7842, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7841, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7840, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7839, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7838, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7837, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7836, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7835, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7834, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7833, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7832, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7831, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7830, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7829, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7828, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7827, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7826, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7825, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7824, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7823, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7822, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7821, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7820, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7819, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7818, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7817, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7816, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7815, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7814, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7813, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7812, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7811, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7810, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7809, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7808, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7807, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7806, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7805, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7804, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7803, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7802, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7801, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7800, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7799, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7798, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7797, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7796, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7795, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7794, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7793, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7792, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7791, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7790, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7789, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7788, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7787, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7786, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7785, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7784, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7783, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7782, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7781, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7780, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7779, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7778, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7777, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7776, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7775, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7774, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7773, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7772, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7771, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7770, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7769, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7768, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7767, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7766, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7765, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7764, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7763, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7762, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7761, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7760, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7759, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7758, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7757, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7756, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7755, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7754, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7753, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7752, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7751, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7750, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7749, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7748, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7747, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7746, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7745, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7744, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7743, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7742, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7741, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7740, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7739, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7738, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7737, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7736, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7735, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7734, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7733, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7732, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7731, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7730, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7729, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7728, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7727, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7726, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7725, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7724, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7723, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7722, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7721, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7720, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7719, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7718, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7717, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7716, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7715, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7714, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7713, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7712, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7711, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7710, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7709, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7708, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7707, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7706, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7705, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7704, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7703, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7702, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7701, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7700, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7699, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7698, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7697, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7696, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7695, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7694, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7693, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7692, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7691, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7690, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7689, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7688, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7687, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7686, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7685, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7684, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7683, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7682, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7681, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7680, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7679, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7678, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7677, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7676, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7675, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7674, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7673, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7672, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7671, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7670, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7669, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7668, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7667, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7666, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7665, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7664, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7663, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7662, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7661, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7660, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7659, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7658, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7657, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7656, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7655, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7654, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7653, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7652, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7651, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7650, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7649, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7648, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7647, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7646, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7645, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7644, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7643, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7642, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7641, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7640, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7639, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7638, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7637, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7636, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7635, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7634, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7633, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7632, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7631, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7630, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7629, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7628, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7627, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7626, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7625, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7624, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7623, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7622, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7621, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7620, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7619, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7618, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7617, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7616, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7615, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7614, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7613, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7612, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7611, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7610, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7609, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7608, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7607, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7606, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7605, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7604, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7603, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7602, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7601, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7600, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7599, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7598, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7597, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7596, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7595, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7594, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7593, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7592, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7591, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7590, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7589, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7588, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7587, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7586, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7585, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7584, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7583, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7582, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7581, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7580, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7579, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7578, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7577, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7576, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7575, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7574, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7573, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7572, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7571, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7570, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7569, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7568, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7567, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7566, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7565, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7564, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7563, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7562, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7561, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7560, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7559, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7558, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7557, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7556, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7555, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7554, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7553, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7552, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7551, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7550, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7549, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7548, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7547, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7546, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7545, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7544, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7543, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7542, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7541, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7540, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7539, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7538, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7537, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7536, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7535, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7534, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7533, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7532, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7531, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7530, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7529, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7528, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7527, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7526, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7525, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7524, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7523, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7522, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7521, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7520, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7519, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7518, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7517, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7516, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7515, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7514, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7513, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7512, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7511, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7510, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7509, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7508, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7507, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7506, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7505, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7504, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7503, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7502, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7501, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7500, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7499, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7498, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7497, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7496, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7495, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7494, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7493, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7492, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7491, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7490, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7489, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7488, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7487, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7486, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7485, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7484, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7483, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7482, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7481, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7480, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7479, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7478, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7477, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7476, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7475, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7474, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7473, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7472, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7471, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7470, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7469, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7468, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7467, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7466, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7465, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7464, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7463, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7462, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7461, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7460, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7459, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7458, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7457, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7456, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7455, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7454, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7453, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7452, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7451, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7450, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7449, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7448, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7447, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7446, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7445, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7444, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7443, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7442, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7441, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7440, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7439, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7438, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7437, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7436, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7435, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7434, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7433, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7432, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7431, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7430, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7429, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7428, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7427, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7426, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7425, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7424, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7423, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7422, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7421, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7420, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7419, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7418, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7417, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7416, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7415, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7414, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7413, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7412, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7411, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7410, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7409, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7408, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7407, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7406, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7405, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7404, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7403, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7402, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7401, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7400, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7399, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7398, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7397, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7396, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7395, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7394, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7393, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7392, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7391, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7390, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7389, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7388, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7387, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7386, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7385, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7384, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7383, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7382, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7381, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7380, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7379, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7378, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7377, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7376, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7375, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7374, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7373, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7372, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7371, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7370, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7369, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7368, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7367, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7366, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7365, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7364, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7363, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7362, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7361, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7360, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7359, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7358, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7357, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7356, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7355, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7354, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7353, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7352, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7351, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7350, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7349, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7348, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7347, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7346, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7345, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7344, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7343, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7342, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7341, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7340, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7339, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7338, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7337, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7336, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7335, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7334, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7333, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7332, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7331, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7330, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7329, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7328, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7327, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7326, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7325, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7324, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7323, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7322, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7321, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7320, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7319, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7318, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7317, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7316, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7315, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7314, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7313, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7312, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7311, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7310, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7309, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7308, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7307, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7306, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7305, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7304, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7303, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7302, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7301, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7300, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7299, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7298, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7297, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7296, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7295, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7294, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7293, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7292, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7291, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7290, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7289, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7288, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7287, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7286, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7285, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7284, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7283, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7282, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7281, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7280, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7279, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7278, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7277, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7276, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7275, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7274, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7273, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7272, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7271, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7270, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7269, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7268, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7267, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7266, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7265, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7264, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7263, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7262, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7261, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7260, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7259, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7258, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7257, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7256, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7255, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7254, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7253, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7252, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7251, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7250, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7249, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7248, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7247, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7246, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7245, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7244, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7243, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7242, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7241, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7240, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7239, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7238, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7237, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7236, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7235, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7234, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7233, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7232, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7231, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7230, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7229, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7228, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7227, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7226, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7225, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7224, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7223, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7222, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7221, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7220, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7219, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7218, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7217, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7216, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7215, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7214, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7213, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7212, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7211, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7210, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7209, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7208, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7207, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7206, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7205, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7204, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7203, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7202, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7201, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7200, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7199, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7198, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7197, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7196, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7195, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7194, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7193, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7192, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7191, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7190, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7189, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7188, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7187, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7186, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7185, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7184, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7183, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7182, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7181, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7180, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7179, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7178, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7177, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7176, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7175, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7174, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7173, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7172, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7171, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7170, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7169, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7168, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7167, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7166, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7165, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7164, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7163, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7162, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7161, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7160, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7159, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7158, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7157, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7156, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7155, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7154, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7153, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7152, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7151, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7150, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7149, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7148, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7147, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7146, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7145, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7144, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7143, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7142, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7141, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7140, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7139, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7138, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7137, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7136, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7135, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7134, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7133, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7132, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7131, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7130, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7129, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7128, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7127, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7126, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7125, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7124, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7123, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7122, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7121, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7120, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7119, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7118, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7117, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7116, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7115, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7114, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7113, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7112, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7111, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7110, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7109, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7108, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7107, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7106, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7105, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7104, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7103, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7102, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7101, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7100, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7099, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7098, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7097, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7096, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7095, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7094, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7093, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7092, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7091, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7090, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7089, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7088, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7087, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7086, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7085, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7084, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7083, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7082, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7081, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7080, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7079, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7078, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7077, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7076, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7075, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7074, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7073, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7072, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7071, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7070, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7069, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7068, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7067, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7066, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7065, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7064, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7063, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7062, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7061, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7060, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7059, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7058, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7057, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7056, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7055, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7054, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7053, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7052, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7051, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7050, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);
INSERT INTO `x7chat2_online` VALUES (7049, 'Po11ix', '173.77.229.226', 'Travian', '', 1250466550, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_permissions`
-- 

CREATE TABLE `x7chat2_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `usergroup` varchar(255) NOT NULL default '',
  `make_rooms` int(11) NOT NULL default '0',
  `make_proom` int(11) NOT NULL default '0',
  `make_nexp` int(11) NOT NULL default '0',
  `make_mod` int(11) NOT NULL default '0',
  `viewip` int(11) NOT NULL default '0',
  `kick` int(11) NOT NULL default '0',
  `ban_kick_imm` int(11) NOT NULL default '0',
  `AOP_all` int(11) NOT NULL default '0',
  `AV_all` int(11) NOT NULL default '0',
  `view_hidden_emails` int(11) NOT NULL default '0',
  `use_keywords` int(11) NOT NULL default '0',
  `access_room_logs` int(11) NOT NULL default '0',
  `log_pms` int(11) NOT NULL default '0',
  `set_background` int(11) NOT NULL default '0',
  `set_logo` int(11) NOT NULL default '0',
  `make_admins` int(11) NOT NULL default '0',
  `server_msg` int(11) NOT NULL default '0',
  `can_mdeop` int(11) NOT NULL default '0',
  `can_mkick` int(11) NOT NULL default '0',
  `admin_settings` int(11) NOT NULL default '0',
  `admin_themes` int(11) NOT NULL default '0',
  `admin_filter` int(11) NOT NULL default '0',
  `admin_groups` int(11) NOT NULL default '0',
  `admin_users` int(11) NOT NULL default '0',
  `admin_ban` int(11) NOT NULL default '0',
  `admin_bandwidth` int(11) NOT NULL default '0',
  `admin_logs` int(11) NOT NULL default '0',
  `admin_events` int(11) NOT NULL default '0',
  `admin_mail` int(11) NOT NULL default '0',
  `admin_mods` int(11) NOT NULL default '0',
  `admin_smilies` int(11) NOT NULL default '0',
  `admin_rooms` int(11) NOT NULL default '0',
  `access_disabled` int(11) NOT NULL default '0',
  `b_invisible` int(11) NOT NULL default '0',
  `c_invisible` int(11) NOT NULL default '0',
  `admin_keywords` int(11) NOT NULL default '0',
  `access_pw_rooms` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- 
-- Dumping data for table `x7chat2_permissions`
-- 

INSERT INTO `x7chat2_permissions` VALUES (2, 'Administrator', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0);
INSERT INTO `x7chat2_permissions` VALUES (3, 'Registered User', 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `x7chat2_permissions` VALUES (6, 'Guest', 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_rooms`
-- 

CREATE TABLE `x7chat2_rooms` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `type` int(11) NOT NULL default '0',
  `moderated` int(11) NOT NULL default '0',
  `topic` varchar(255) NOT NULL default '',
  `greeting` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  `maxusers` int(11) NOT NULL default '0',
  `time` int(11) NOT NULL default '0',
  `ops` text NOT NULL,
  `voiced` text NOT NULL,
  `logged` int(11) NOT NULL default '0',
  `background` varchar(255) NOT NULL default '',
  `logo` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `x7chat2_rooms`
-- 

INSERT INTO `x7chat2_rooms` VALUES (1, 'General Chat', 2, 0, 'Alliance discussions', 'Welcome Leaders!', '', 50, 0, '', '', 0, '', '');
INSERT INTO `x7chat2_rooms` VALUES (2, 'Travian', 2, 0, 'To discuss grand alliance', 'Welcome Leaders', '', 3, 0, '1', '1', 0, '', '');

-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_settings`
-- 

CREATE TABLE `x7chat2_settings` (
  `id` int(11) NOT NULL auto_increment,
  `variable` varchar(255) NOT NULL default '',
  `setting` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=76 ;

-- 
-- Dumping data for table `x7chat2_settings`
-- 

INSERT INTO `x7chat2_settings` VALUES (1, 'default_lang', 'english');
INSERT INTO `x7chat2_settings` VALUES (2, 'disable_chat', '0');
INSERT INTO `x7chat2_settings` VALUES (3, 'site_name', '~Spirit');
INSERT INTO `x7chat2_settings` VALUES (4, 'default_skin', 'Castle');
INSERT INTO `x7chat2_settings` VALUES (5, 'cookie_time', '630000000');
INSERT INTO `x7chat2_settings` VALUES (6, 'logout_page', '');
INSERT INTO `x7chat2_settings` VALUES (7, 'allow_reg', '1');
INSERT INTO `x7chat2_settings` VALUES (8, 'style_max_size', '25');
INSERT INTO `x7chat2_settings` VALUES (9, 'banner_url', './themes/x7chat2/defthcon.gif');
INSERT INTO `x7chat2_settings` VALUES (10, 'background_image', '');
INSERT INTO `x7chat2_settings` VALUES (11, 'default_font', 'Arial');
INSERT INTO `x7chat2_settings` VALUES (12, 'default_color', 'black');
INSERT INTO `x7chat2_settings` VALUES (13, 'default_size', '10 Pt');
INSERT INTO `x7chat2_settings` VALUES (14, 'style_min_size', '8');
INSERT INTO `x7chat2_settings` VALUES (15, 'style_allowed_fonts', 'arial,courier,verdana,helvetica');
INSERT INTO `x7chat2_settings` VALUES (16, 'system_message_color', '#ff0000');
INSERT INTO `x7chat2_settings` VALUES (17, 'allow_guests', '1');
INSERT INTO `x7chat2_settings` VALUES (18, 'online_time', '30');
INSERT INTO `x7chat2_settings` VALUES (19, 'disable_smiles', '0');
INSERT INTO `x7chat2_settings` VALUES (20, 'tweak_window_large_height', '450');
INSERT INTO `x7chat2_settings` VALUES (21, 'disable_gd', '0');
INSERT INTO `x7chat2_settings` VALUES (22, 'disable_styles', '0');
INSERT INTO `x7chat2_settings` VALUES (23, 'expire_messages', '300');
INSERT INTO `x7chat2_settings` VALUES (24, 'maxchars_status', '19');
INSERT INTO `x7chat2_settings` VALUES (25, 'date_format', 'g:i:s A');
INSERT INTO `x7chat2_settings` VALUES (26, 'max_offline_msgs', '50');
INSERT INTO `x7chat2_settings` VALUES (27, 'uploads_path', '/customers/techstation.in/techstation.in/httpd.www/ichat/uploads');
INSERT INTO `x7chat2_settings` VALUES (28, 'enable_avatar_uploads', '1');
INSERT INTO `x7chat2_settings` VALUES (29, 'avatar_max_size', '5242880');
INSERT INTO `x7chat2_settings` VALUES (30, 'uploads_url', 'http://techstation.in/ichat/uploads');
INSERT INTO `x7chat2_settings` VALUES (31, 'avatar_size_px', '90x90');
INSERT INTO `x7chat2_settings` VALUES (32, 'resize_smaller_avatars', '0');
INSERT INTO `x7chat2_settings` VALUES (33, 'disable_sounds', '0');
INSERT INTO `x7chat2_settings` VALUES (34, 'min_refresh', '1000');
INSERT INTO `x7chat2_settings` VALUES (35, 'max_refresh', '30000');
INSERT INTO `x7chat2_settings` VALUES (36, 'time_offset_hours', '0');
INSERT INTO `x7chat2_settings` VALUES (37, 'time_offset_mins', '0');
INSERT INTO `x7chat2_settings` VALUES (38, 'tweak_window_large_width', '550');
INSERT INTO `x7chat2_settings` VALUES (39, 'tweak_window_small_width', '300');
INSERT INTO `x7chat2_settings` VALUES (40, 'tweak_window_small_height', '300');
INSERT INTO `x7chat2_settings` VALUES (41, 'maxchars_msg', '0');
INSERT INTO `x7chat2_settings` VALUES (42, 'date_format_full', 'm/d/y g:i A ');
INSERT INTO `x7chat2_settings` VALUES (43, 'disable_autolinking', '0');
INSERT INTO `x7chat2_settings` VALUES (44, 'logs_path', './logs');
INSERT INTO `x7chat2_settings` VALUES (45, 'max_log_room', '5242880');
INSERT INTO `x7chat2_settings` VALUES (46, 'max_log_user', '5242880');
INSERT INTO `x7chat2_settings` VALUES (47, 'enable_logging', '1');
INSERT INTO `x7chat2_settings` VALUES (48, 'admin_email', 'razikh@gmail.com');
INSERT INTO `x7chat2_settings` VALUES (49, 'enable_roombgs', '1');
INSERT INTO `x7chat2_settings` VALUES (50, 'enable_roomlogo', '1');
INSERT INTO `x7chat2_settings` VALUES (51, 'enable_passreminder', '1');
INSERT INTO `x7chat2_settings` VALUES (52, 'show_events', '0');
INSERT INTO `x7chat2_settings` VALUES (53, 'events_showmonth', '1');
INSERT INTO `x7chat2_settings` VALUES (54, 'events_show3day', '0');
INSERT INTO `x7chat2_settings` VALUES (55, 'show_stats', '1');
INSERT INTO `x7chat2_settings` VALUES (56, 'events_3day_number', '0');
INSERT INTO `x7chat2_settings` VALUES (57, 'news', '');
INSERT INTO `x7chat2_settings` VALUES (58, 'expire_rooms', '1800');
INSERT INTO `x7chat2_settings` VALUES (59, 'usergroup_guest', 'Guest');
INSERT INTO `x7chat2_settings` VALUES (60, 'log_bandwidth', '0');
INSERT INTO `x7chat2_settings` VALUES (61, 'usergroup_default', 'Registered User');
INSERT INTO `x7chat2_settings` VALUES (62, 'expire_guests', '600');
INSERT INTO `x7chat2_settings` VALUES (63, 'date_format_date', 'm/d/y');
INSERT INTO `x7chat2_settings` VALUES (64, 'usergroup_admin', 'Administrator');
INSERT INTO `x7chat2_settings` VALUES (65, 'max_default_bandwidth', '524288000');
INSERT INTO `x7chat2_settings` VALUES (66, 'default_bandwidth_type', '2');
INSERT INTO `x7chat2_settings` VALUES (67, 'maxchars_username', '18');
INSERT INTO `x7chat2_settings` VALUES (68, 'user_agreement', '');
INSERT INTO `x7chat2_settings` VALUES (69, 'banner_link', 'http://www.techstation.in');
INSERT INTO `x7chat2_settings` VALUES (70, 'single_room_mode', '');
INSERT INTO `x7chat2_settings` VALUES (71, 'support_personel', '');
INSERT INTO `x7chat2_settings` VALUES (72, 'support_image_online', './themes/supportimages/support_s1_1_online.gif');
INSERT INTO `x7chat2_settings` VALUES (73, 'support_image_offline', './themes/supportimages/support_s1_1_offline.gif');
INSERT INTO `x7chat2_settings` VALUES (74, 'support_message', '');
INSERT INTO `x7chat2_settings` VALUES (75, 'req_activation', '0');

-- --------------------------------------------------------

-- 
-- Table structure for table `x7chat2_users`
-- 

CREATE TABLE `x7chat2_users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `avatar` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `location` varchar(255) NOT NULL default '',
  `hobbies` varchar(255) NOT NULL default '',
  `bio` text NOT NULL,
  `status` varchar(255) NOT NULL default '',
  `user_group` text NOT NULL,
  `time` int(11) NOT NULL default '0',
  `settings` varchar(255) NOT NULL default '',
  `hideemail` int(11) NOT NULL default '0',
  `gender` int(11) NOT NULL default '0',
  `ip` varchar(255) NOT NULL default '',
  `activated` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- 
-- Dumping data for table `x7chat2_users`
-- 

INSERT INTO `x7chat2_users` VALUES (1, 'razikh', '4c609ad543a421ca389180e3e4f7c867', 'razikh@gmail.com', '', '', '', '', '', 'Available', 'Administrator', 1250022500, 'default;default;630000000;Arial;10 Pt;black;0;0;0;0;5000;default;default;0;0', 0, 0, '115.240.122.147', '1');
INSERT INTO `x7chat2_users` VALUES (2, 'Volcano', '4c609ad543a421ca389180e3e4f7c867', 'razikh@gmail.com', '', '', '', '', '', 'Available', 'Registered User', 1250149695, 'default;Castle;630000000;Arial;10 Pt;black;0;0;0;0;5000;default;default;0;0', 0, 0, '115.240.122.147', '1');
INSERT INTO `x7chat2_users` VALUES (3, 'Po11ix', '9a373e66773d2e335e8f611a39378148', 'ryanqmorris@gmail.com', '', '', '', '', '', 'Available', 'Registered User', 1250466550, 'default;default;630000000;courier;10 Pt;black;0;0;0;0;5000;default;default;0;0', 0, 0, '173.77.229.226', '1');
INSERT INTO `x7chat2_users` VALUES (4, 'Cast0r', 'ba15f62674cc3b05cb09384f8df80255', 'dtm1182@hotmail.com', '', '', '', '', '', 'Available', 'Registered User', 1250152363, 'default;default;630000000;Arial;10 Pt;#721d07;0;0;0;0;5000;default;default;0;0', 0, 0, '24.191.244.72', '1');
INSERT INTO `x7chat2_users` VALUES (5, 'BasisB', '9b306ab04ef5e25f9fb89c998a6aedab', 'jeanigrsa@gmail.com', '', '', '', '', '', 'Available', 'Registered User', 1250439773, 'default;default;630000000;Arial;10 Pt;black;0;0;0;0;5000;default;default;0;0', 0, 0, '196.35.158.179', '1');
INSERT INTO `x7chat2_users` VALUES (6, 'Edimonster', '2469c12ad712ef35e0792dd239e318f4', 'Edimonster@volvo.no-ip.com', '', '', '', '', '', 'Available', 'Registered User', 1250513252, 'default;default;630000000;Arial;10 Pt;black;0;0;0;0;5000;default;default;0;0', 0, 0, '90.220.51.14', '1');
