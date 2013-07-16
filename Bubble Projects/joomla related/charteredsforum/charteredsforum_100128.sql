-- phpMyAdmin SQL Dump
-- version 2.9.2-Debian-1.one.com1
-- http://www.phpmyadmin.net
-- 
-- Host: MySQL Server
-- Generation Time: Jan 28, 2010 at 01:13 AM
-- Server version: 5.0.32
-- PHP Version: 5.2.0-8+etch16

SET AUTOCOMMIT=0;
START TRANSACTION;

-- 
-- Database: `charteredsforum`
-- 
CREATE DATABASE `charteredsforum` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `charteredsforum`;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- 
-- Dumping data for table `jos_categories`
-- 

INSERT INTO `jos_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `params`) VALUES (1, 0, 'Direct Tax', '', 'direct-tax', 'key.jpg', '1', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 1, 0, 0, '');
INSERT INTO `jos_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `params`) VALUES (2, 0, 'Accounts', '', 'accounts', '', 'com_weblinks', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 1, 0, 0, '');
INSERT INTO `jos_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `params`) VALUES (3, 0, 'Audit', '', 'audit', '', 'com_weblinks', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 2, 0, 0, '');
INSERT INTO `jos_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `params`) VALUES (4, 0, 'Direct Tax', '', 'directtax', '', 'com_weblinks', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 3, 0, 0, '');
INSERT INTO `jos_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `params`) VALUES (5, 0, 'Indirect Tax', '', 'indirecttax', '', 'com_weblinks', 'left', '', 1, 62, '2009-07-11 10:50:09', NULL, 4, 0, 0, '');
INSERT INTO `jos_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `params`) VALUES (7, 0, 'Corporate Laws', '', 'corporate-laws', '', 'com_weblinks', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 5, 0, 0, '');
INSERT INTO `jos_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `params`) VALUES (8, 0, 'Costing & Financial Management', '', 'cofm', '', 'com_weblinks', 'left', '', 1, 0, '0000-00-00 00:00:00', NULL, 6, 0, 0, '');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

-- 
-- Dumping data for table `jos_components`
-- 

INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (1, 'Banners', '', 0, 0, '', 'Banner Management', 'com_banners', 0, 'js/ThemeOffice/component.png', 0, 'track_impressions=0\ntrack_clicks=0\ntag_prefix=\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (2, 'Banners', '', 0, 1, 'option=com_banners', 'Active Banners', 'com_banners', 1, 'js/ThemeOffice/edit.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (3, 'Clients', '', 0, 1, 'option=com_banners&c=client', 'Manage Clients', 'com_banners', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (4, 'Web Links', 'option=com_weblinks', 0, 0, '', 'Manage Weblinks', 'com_weblinks', 0, 'js/ThemeOffice/component.png', 0, 'show_comp_description=1\ncomp_description=\nshow_link_hits=1\nshow_link_description=1\nshow_other_cats=1\nshow_headings=1\nshow_page_title=1\nlink_target=0\nlink_icons=\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (5, 'Links', '', 0, 4, 'option=com_weblinks', 'View existing weblinks', 'com_weblinks', 1, 'js/ThemeOffice/edit.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (6, 'Categories', '', 0, 4, 'option=com_categories&section=com_weblinks', 'Manage weblink categories', '', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (7, 'Contacts', 'option=com_contact', 0, 0, '', 'Edit contact details', 'com_contact', 0, 'js/ThemeOffice/component.png', 1, 'contact_icons=0\nicon_address=\nicon_email=\nicon_telephone=\nicon_fax=\nicon_misc=\nshow_headings=1\nshow_position=1\nshow_email=0\nshow_telephone=1\nshow_mobile=1\nshow_fax=1\nbannedEmail=\nbannedSubject=\nbannedText=\nsession=1\ncustomReply=0\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (8, 'Contacts', '', 0, 7, 'option=com_contact', 'Edit contact details', 'com_contact', 0, 'js/ThemeOffice/edit.png', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (9, 'Categories', '', 0, 7, 'option=com_categories&section=com_contact_details', 'Manage contact categories', '', 2, 'js/ThemeOffice/categories.png', 1, 'contact_icons=0\nicon_address=\nicon_email=\nicon_telephone=\nicon_fax=\nicon_misc=\nshow_headings=1\nshow_position=1\nshow_email=0\nshow_telephone=1\nshow_mobile=1\nshow_fax=1\nbannedEmail=\nbannedSubject=\nbannedText=\nsession=1\ncustomReply=0\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (10, 'Polls', 'option=com_poll', 0, 0, 'option=com_poll', 'Manage Polls', 'com_poll', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (11, 'News Feeds', 'option=com_newsfeeds', 0, 0, '', 'News Feeds Management', 'com_newsfeeds', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (12, 'Feeds', '', 0, 11, 'option=com_newsfeeds', 'Manage News Feeds', 'com_newsfeeds', 1, 'js/ThemeOffice/edit.png', 0, 'show_headings=1\nshow_name=1\nshow_articles=1\nshow_link=1\nshow_cat_description=1\nshow_cat_items=1\nshow_feed_image=1\nshow_feed_description=1\nshow_item_description=1\nfeed_word_count=0\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (13, 'Categories', '', 0, 11, 'option=com_categories&section=com_newsfeeds', 'Manage Categories', '', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (14, 'User', 'option=com_user', 0, 0, '', '', 'com_user', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (15, 'Search', 'option=com_search', 0, 0, 'option=com_search', 'Search Statistics', 'com_search', 0, 'js/ThemeOffice/component.png', 1, 'enabled=0\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (16, 'Categories', '', 0, 1, 'option=com_categories&section=com_banner', 'Categories', '', 3, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (17, 'Wrapper', 'option=com_wrapper', 0, 0, '', 'Wrapper', 'com_wrapper', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (18, 'Mail To', '', 0, 0, '', '', 'com_mailto', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (19, 'Media Manager', '', 0, 0, 'option=com_media', 'Media Manager', 'com_media', 0, '', 1, 'upload_extensions=bmp,csv,doc,epg,gif,ico,jpg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,EPG,GIF,ICO,JPG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\nupload_maxsize=10000000\nfile_path=images\nimage_path=images/stories\nrestrict_uploads=1\nallowed_media_usergroup=3\ncheck_mime=1\nimage_extensions=bmp,gif,jpg,png\nignore_extensions=\nupload_mime=image/jpeg,image/gif,image/png,image/bmp,application/x-shockwave-flash,application/msword,application/excel,application/pdf,application/powerpoint,text/plain,application/x-zip\nupload_mime_illegal=text/html\nenable_flash=0\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (20, 'Articles', 'option=com_content', 0, 0, '', '', 'com_content', 0, '', 1, 'show_noauth=0\nshow_title=1\nlink_titles=0\nshow_intro=1\nshow_section=0\nlink_section=0\nshow_category=0\nlink_category=0\nshow_author=0\nshow_create_date=0\nshow_modify_date=0\nshow_item_navigation=0\nshow_readmore=1\nshow_vote=1\nshow_icons=1\nshow_pdf_icon=0\nshow_print_icon=1\nshow_email_icon=1\nshow_hits=0\nfeed_summary=0\nfilter_tags=\nfilter_attritbutes=\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (21, 'Configuration Manager', '', 0, 0, '', 'Configuration', 'com_config', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (22, 'Installation Manager', '', 0, 0, '', 'Installer', 'com_installer', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (23, 'Language Manager', '', 0, 0, '', 'Languages', 'com_languages', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (24, 'Mass mail', '', 0, 0, '', 'Mass Mail', 'com_massmail', 0, '', 1, 'mailSubjectPrefix=\nmailBodySuffix=\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (25, 'Menu Editor', '', 0, 0, '', 'Menu Editor', 'com_menus', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (27, 'Messaging', '', 0, 0, '', 'Messages', 'com_messages', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (28, 'Modules Manager', '', 0, 0, '', 'Modules', 'com_modules', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (29, 'Plugin Manager', '', 0, 0, '', 'Plugins', 'com_plugins', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (30, 'Template Manager', '', 0, 0, '', 'Templates', 'com_templates', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (31, 'User Manager', '', 0, 0, '', 'Users', 'com_users', 0, '', 1, 'allowUserRegistration=1\nnew_usertype=Registered\nuseractivation=1\nfrontend_userparams=1\n\n', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (32, 'Cache Manager', '', 0, 0, '', 'Cache', 'com_cache', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (33, 'Control Panel', '', 0, 0, '', 'Control Panel', 'com_cpanel', 0, '', 1, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (34, 'Phoca Gallery', 'option=com_phocagallery', 0, 0, 'option=com_phocagallery', 'Phoca Gallery', 'com_phocagallery', 0, 'components/com_phocagallery/assets/images/icon-16-pg-menu.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (35, 'Control Panel', '', 0, 34, 'option=com_phocagallery', 'Control Panel', 'com_phocagallery', 0, 'components/com_phocagallery/assets/images/icon-16-pg-control-panel.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (36, 'Images', '', 0, 34, 'option=com_phocagallery&view=phocagallerys', 'Images', 'com_phocagallery', 1, 'components/com_phocagallery/assets/images/icon-16-pg-menu-gal.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (37, 'Categories', '', 0, 34, 'option=com_phocagallery&view=phocagallerycs', 'Categories', 'com_phocagallery', 2, 'components/com_phocagallery/assets/images/icon-16-pg-menu-cat.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (38, 'Themes', '', 0, 34, 'option=com_phocagallery&view=phocagalleryt', 'Themes', 'com_phocagallery', 3, 'components/com_phocagallery/assets/images/icon-16-pg-menu-theme.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (39, 'Category Rating', '', 0, 34, 'option=com_phocagallery&view=phocagalleryra', 'Category Rating', 'com_phocagallery', 4, 'components/com_phocagallery/assets/images/icon-16-pg-menu-vote.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (40, 'Image Rating', '', 0, 34, 'option=com_phocagallery&view=phocagalleryraimg', 'Image Rating', 'com_phocagallery', 5, 'components/com_phocagallery/assets/images/icon-16-pg-menu-vote-img.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (41, 'Comments', '', 0, 34, 'option=com_phocagallery&view=phocagallerycos', 'Comments', 'com_phocagallery', 6, 'components/com_phocagallery/assets/images/icon-16-pg-menu-comment.png', 0, '', 1);
INSERT INTO `jos_components` (`id`, `name`, `link`, `menuid`, `parent`, `admin_menu_link`, `admin_menu_alt`, `option`, `ordering`, `admin_menu_img`, `iscore`, `params`, `enabled`) VALUES (42, 'Info', '', 0, 34, 'option=com_phocagallery&view=phocagalleryin', 'Info', 'com_phocagallery', 7, 'components/com_phocagallery/assets/images/icon-16-pg-menu-info.png', 0, '', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

-- 
-- Dumping data for table `jos_content`
-- 

INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (1, 'About Chartered''s Forum', 'about-chartereds-forum', '', '<p>Here comes the info about chartered''s forum</p>', '', 1, 0, 0, 0, '2009-07-11 11:30:40', 62, '', '2009-07-11 12:07:45', 62, 0, '0000-00-00 00:00:00', '2009-07-11 11:30:40', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 3, '', '', 0, 47, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (2, 'Contact Us', 'contact-us', '', '<p>To Contact Us send an email to sundeep.753@gmail.com</p>', '', 1, 0, 0, 0, '2009-07-11 12:03:56', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-07-11 12:03:56', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 5, '', '', 0, 36, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (3, 'Welcome', 'welcome', '', '<p>Welcome to chartered''s forum</p>', '', 1, 0, 0, 0, '2009-07-11 12:05:40', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-07-11 12:05:40', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 4, '', '', 0, 725, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (4, 'Goals', 'goals', '', '<p>Our goals</p>', '', 1, 0, 0, 0, '2009-07-11 12:11:56', 62, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2009-07-11 12:11:56', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 1, 0, 2, '', '', 0, 38, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (5, 'Bhoomika Chawla Pics', 'bhoomika-chawla-pics', '', '<p>{googleAds}\r\n<script type="text/javascript">// <![CDATA[\r\ngoogle_ad_client = "pub-7647201708831718";\r\n/* pub_ads_generic_160_600 */\r\ngoogle_ad_slot = "8715666204";\r\ngoogle_ad_width = 160;\r\ngoogle_ad_height = 600;\r\n// ]]></script>\r\n<script src="http://pagead2.googlesyndication.com/pagead/show_ads.js" type="text/javascript">\r\n</script>\r\n{/googleAds}</p>\r\n<p> </p>', '', 0, 1, 0, 1, '2009-09-19 08:07:08', 62, '', '2009-09-19 11:36:24', 62, 0, '0000-00-00 00:00:00', '2009-09-19 08:07:08', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 12, 0, 8, '', '', 0, 61, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (6, 'Chapter 1 : Basics', 'chapter-1-basics', '', '<h3 style="margin: 24pt 0pt 0pt;"><strong><span class="bannerheader">Section 2(1A) Agricultural income U/s 2 ( 1A )<br /></span></strong></h3>\r\n<p style="margin: 24pt 0pt 0pt;">(a) Income from land   which is situated in India and is used for agricultural purposes.<br />Income from farm Building is considered as agriculture Income</p>\r\n<ol>\r\n<li>It should be occupied by the cultivator or receiver of rent or revenue</li>\r\n<li>The building is on or in the immediate vicinity of the land</li>\r\n<li>Building can be used as dwelling house or store house or out-house</li>\r\n<li>The land is assessed to land revenue if not land shall not be situated<ol>\r\n<li>Within municipality with not less than 10,000 population as per last census on the 1<sup>st</sup> day of pervious year</li>\r\n<li>Within 8 Kilometers from the notified local limits</li>\r\n</ol></li>\r\n<li>Income derived from letting  out the land or building for the residential purpose or for business or profession is not an agriculture Income.</li>\r\n</ol>\r\n<p style="margin: 24pt 0pt 0pt;"><strong>Note</strong>: Any income derived from saplings or seedlings grown in a nursery shall be deemed to be agricultural income.</p>\r\n<h3 style="margin: 24pt 0pt 0pt;">Assessee U/s 2 (7)<br /><br /></h3>\r\n<p>Assessee means a person liable to pay any Tax or any other sum of money under the Income tax act.</p>\r\n<h3>Assessment Year U/s 2 ( 9 )</h3>\r\n<p>The period of 12 months commencing on the first day of April of every year</p>\r\n<h3><br />Books or Books of account U/s 2(12A)</h3>\r\n<p>Ledgers, day-books, cash books, account-books and other books, whether kept in the written form or as print-outs of data stored in a floppy, disc, tape or any other form of electro-magnetic data storage device</p>\r\n<h3>Person U/s 2 ( 31)</h3>\r\n<p>It Includes</p>\r\n<ul>\r\n<li>An individual</li>\r\n<li>Hindu undivided family</li>\r\n<li>Company</li>\r\n<li>Firm</li>\r\n<li>Association of persons</li>\r\n<li>A body of individuals</li>\r\n<li>Local authority </li>\r\n<li>Every artificial juridical person</li>\r\n</ul>\r\n<p style="margin: 0pt;"><strong>Note</strong>: Association of persons or a body of individuals or a local authority or an artificial juridical person shall be deemed to be a person, whether or not such person or body or authority or juridical person was formed or established or incorporated with the object of deriving income, profits or gains.</p>\r\n<p style="margin: 0pt;"> </p>\r\n<h3 style="margin: 0pt;">Income U/s 2 ( 24)</h3>\r\n<p>Includes</p>\r\n<ul>\r\n<li>Profit and gains of business or profession.</li>\r\n<li>Dividends</li>\r\n<li>Voluntary contributions received by a charitable or religious purposes or by an institution established hospital or other institution</li>\r\n<li>The value of any perquisite or profit in lieu of salary taxable</li>\r\n<li>Interest, salary, bonus, commission or remuneration earned by a partner of a firm</li>\r\n<li>Capital gains chargeable U/s 45</li>\r\n<li>The profits and gains of any business of insurance carried on by a mutual insurance company or by a co-operative society</li>\r\n<li>Any winnings from lotteries, crossword puzzles, races including horse races, card games and other games of any sort or from gambling or betting of any form or nature whatsoever</li>\r\n<li>Any sum received by the assessee from his employees as contributions to any provident fund or superannuation fund</li>\r\n<li>Any sum received under a Keyman insurance policy including the sum allocated by way of bonus on such policy.</li>\r\n<li>Benefit or perquisite received from a company, by a director or a person holding substantial interest or a relative of the director or such person.</li>\r\n<li>Gifts U/s 56(2)(Vi)</li>\r\n</ul>\r\n<h3 style="margin: 0pt;"><br />Pervious Year U/s 3</h3>\r\n<p>Financial year immediately preceding the assessment Year.</p>\r\n<p><strong>Exception in the following cases:</strong></p>\r\n<ul>\r\n<li>Shipping business of non- resident (section 172)</li>\r\n<li>Person Leaving India (section 174)</li>\r\n<li>AOP or BOI or Artificial Juridical person formed for a particular event or purpose (Section 174A)</li>\r\n<li>Person likely to transfer property to avoid Tax (Section 175)</li>\r\n<li>Discontinued Business ( Section 174)</li>\r\n</ul>\r\n<h3 style="margin: 0pt;"><br />Substantial Interest U/s 2(32)</h3>\r\n<p>Person who has a substantial interest in the company, in relation to a company, means a person who is the beneficial owner of shares, not being shares entitled to a fixed rate of dividend whether with or without a right to participate in profits, carrying not less than twenty per cent of the voting power</p>\r\n<h3 style="margin: 0pt;"><br />9.Section 4 charge of Income Tax:</h3>\r\n<p>Income tax will be charged for any Assessment year at the rates specified in the Finance act for that year in respect of the total income of previous year of every person.</p>\r\n<h3 style="margin: 0pt;"><br />10.Section 2(45) Total Income:</h3>\r\n<p>Computed as per the provisions of the Income Tax act.</p>', '', 1, 1, 0, 1, '2009-12-31 17:19:32', 62, '', '2010-01-05 17:19:33', 62, 0, '0000-00-00 00:00:00', '2009-12-31 17:19:32', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 4, 0, 4, '', '', 0, 42, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (7, 'Residential Status', 'residential-status', '', '<h3 style="margin: 0pt;">Residential Status of Individual U/s 6(1)</h3>\r\n<p style="margin: 0pt;"><br />a) In the Individual stayed in India for a period of 182 days or more during the relevant previous year or</p>\r\n<p style="margin: 0pt;">b) If Stayed in India for a period of 60 days or more during the relevant previous year and 365 days or more during the four preceding previous year</p>\r\n<p style="margin: 0pt;"> </p>\r\n<p style="margin: 0pt;">If the above two conditiond are statified then Individual is a resident inIndia and if not non-resident</p>\r\n<p style="margin: 0pt;"> </p>\r\n<h3 style="margin: 0pt;">Resident ordinarily resident or not ordinarily resident U/s 6(6):</h3>\r\n<ol>\r\n<li>This provision is applicable to the individuals who are resident U/s 6(1)</li>\r\n<li>If the Assessees  fulfills any one of the following condition, then assessees is Resident not ordinarily resident.If both conditions are not fulfilled, then resident ordinarily resident<br />a. Should be a Non -resident in India u/s 6(2) for at least 9 out of 10 preceding previous years or<br />b.Should be in India for a period of 729 days or less in the 7 preceding previous years.</li>\r\n</ol>\r\n<p style="margin: 0pt;"> </p>\r\n<h3 style="margin: 0pt;">Residential status of HUF, Firm, AOP, Other Person U/s 6(2)</h3>\r\n<p style="margin: 0pt;"><br />Residential status of the above depends upon the control and management of its affairs</p>\r\n<ol>\r\n<li>If control and  management of its affairs is wholly or partly inside India, then status is resident.</li>\r\n<li>If control and  management of its affairs is wholly outside India ,then status is Non -resident.</li>\r\n</ol>\r\n<p style="margin: 0pt;"> </p>\r\n<p style="margin: 0pt;">In case of HUF to determine ordinarily resident or not ordinarily resident  following conditions should be fulfilled</p>\r\n<ol>\r\n<li>This provision is applicable to HUF resident U/s 6(2)</li>\r\n<li>If the karta or the manager fulfills any one of the following condition, then HUF is Resident not ordinarily resident.If both conditions are not fulfilled, then resident ordinarily resident.<br />a. Should be a Non -resident in India u/s 6(2) for at least 9 out of 10 preceding previous years or<br />b.Should be in India for a period of 729 days or less in the 7 preceding previous years.</li>\r\n</ol>\r\n<h3 style="margin: 0pt;"></h3>\r\n<h3 style="margin: 0pt;">Residential status of Company U/s 6(3)</h3>\r\n<p style="margin: 0pt;"><br />1.In case of Indian company status of Company is Resident</p>\r\n<p style="margin: 0pt;">2.In case of other companies if control and management is wholly in India, then the status is Resident and if wholly or partly outside India, then the status of the company is non- resident</p>\r\n<p style="margin: 0pt;"> </p>\r\n<p style="margin: 0pt;">Income deemed to be received U/s 7</p>\r\n<p style="margin: 0pt;">i) The annual accretion in the previous year to the balance          at the credit of an employee participating in a recognised provident fund,          to the extent provided in rule 6 of Part A of the Fourth Schedule</p>\r\n<p>(ii)          The transferred balance in a recognised provident fund, to the extent          provided in sub-rule (4) of rule 11 of Part A of the Fourth Schedule.</p>\r\n<p> </p>\r\n<h3>Dividend Income U/s 8:</h3>\r\n<p>(a) Any dividend declared by a company or distributed or paid by it within          the meaning of sub-clause (a) to  (e) of section 2(22) shall be deemed to be          the income of the previous year in which it is so declared, distributed          or paid, as the case may be<br />(b)          Any interim dividend shall be deemed to be the income of the previous          year in which the amount of such dividend is unconditionally made available          by the company to the member who is entitled to it.</p>\r\n<p> </p>\r\n<h3 style="margin: 0pt;">Income deemed to accrue or arise in India U/s 9:</h3>\r\n<p style="margin: 0pt;"> </p>\r\n<ol>\r\n<li>All income accruing or arising, whether directly or indirectly, through          or from any business connection in India, or through or from any property          in India, or through or from any asset or source of income in India, or          through the transfer of a capital asset situated in India</li>\r\n<li>Income which falls under the head "Salaries", if it is earned          in India</li>\r\n<li>Income chargeable under the head "Salaries" payable by the Government          to a citizen of India for service outside India</li>\r\n<li>A dividend paid by an Indian company outside India</li>\r\n</ol>\r\n<p style="margin: 0pt;"><strong> For Interest</strong></p>\r\n<p style="margin: 0pt;">(a) The Government or</p>\r\n<p style="margin: 0pt;">(b)          A person who is a resident, except where the interest is payable in respect          of any debt incurred or moneys borrowed and used, for the purposes of          a business or profession carried on by such person outside India or for          the purposes of making or earning any income from any source outside India          or <br />(c)          A person who is a non-resident, where the interest is payable in respect          of any debt incurred, or moneys borrowed and used, for the purposes of          a business or profession carried on by such person in India<br /><br /><strong>For Royalty/Fees for technical Services</strong><br />(a) The Government or  <br />(b)          A person who is a resident, except where the royalty is payable in respect          of any right, property or information used or services utilised for the          purposes of a business or profession carried on by such person outside          India or for the purposes of making or earning any income from any source          outside India or <br />(c)          A person who is a non-resident, where the royalty is payable in respect          of any right, property or information used or services utilised for the          purposes of a business or profession carried on by such person in India,          or for the purposes of making or earning any income from any source in          India :<br /><br /><strong>Royalty U/s 9:</strong></p>\r\n<p style="margin: 0pt;"> </p>\r\n<p style="margin: 0pt;">(i) The transfer of all or any rights in respect of a patent, invention, model, design,          secret formula or process or trade mark or similar property</p>\r\n<p> </p>\r\n<p>(ii)          The imparting of any information concerning the working of or the use          of, a patent, invention, model, design, secret formula or process or trade          mark or similar property<br />(iii)          The use of any patent, invention, model, design, secret formula or process          or trade mark or similar property<br />(iv)          The imparting of any information concerning technical, industrial, commercial          or scientific knowledge, experience or skill<br />(v)          The transfer of all or any rights           in respect of any copyright, literary, artistic or scientific work including          films or video tapes for use in connection with television or tapes for          use in connection with radio broadcasting, but not including consideration          for the sale, distribution or exhibition of cinematographic films or<br />(vi)          The rendering of any services in connection with the activities referred          to in sub-clauses (i) to (v);</p>\r\n<p><strong><br />Fees for Technical Services U/s 9</strong>:<br />Fees for technical services          means any consideration (including any lump sum consideration) for the          rendering of any managerial, technical or consultancy services (including          the provision of services of technical or other personnel) but does not          include consideration for any construction, assembly, mining or like project          undertaken by the recipient or consideration which would be income of          the recipient chargeable under the head "Salaries".</p>\r\n<p> </p>', '', 1, 1, 0, 1, '2010-01-05 16:30:03', 62, '', '2010-01-05 18:36:34', 62, 0, '0000-00-00 00:00:00', '2010-01-05 16:30:03', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 3, 0, 7, '', '', 0, 16, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (12, 'Income from Salary', 'income-from-salary', '', '<h3><span style="font-size: medium;"><span style="font-family: book antiqua,palatino;"><span style="text-decoration: underline;"><strong>Head of Income---- Income from Salary</strong></span></span></span></h3>\r\n<p><span style="text-decoration: underline;"><strong>Section 15:</strong></span> Salary</p>\r\n<ul>\r\n<li>Salary is taxable on due or receipt basis whichever is earlier</li>\r\n<li>Salary due from the Employer or the former Employer is Taxable</li>\r\n<li>Arrears of salary paid or allowed by the employer or the former employer during the previous year is Taxable</li>\r\n<li>Advance Salary is Taxable(Advance Aganist salary is not charged to Tax)</li>\r\n<li> salary, bonus, commission or remuneration,due to, or received by, a partner of a firm from the firm shall not be regarded as salary .</li>\r\n</ul>\r\n<p><span style="text-decoration: underline;"><strong>Section 16</strong></span>: Deduction from Salary</p>\r\n<ul>\r\n<li>16(ii) Entertainment allowance-Only for Government Employees</li>\r\n</ul>\r\n<p>Least fo the following</p>\r\n<ol>\r\n<li>Actual Amount Received</li>\r\n<li>20% of basic salary</li>\r\n<li>Rs.5,000</li>\r\n</ol> \r\n<ul>\r\n<li>16(iii) Professional Tax</li>\r\n</ul>\r\n<ol>\r\n<li> Professional Tax paid by employee shall be allowed as deduction under the state Act levied.</li>\r\n<li>Deduction is avaliable on Actual Payment</li>\r\n<li>Employer pays Professional Tax on behalf of the Employee,then first included in salary as perquisite and then allowed as deduction.</li>\r\n</ol>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>', '', 1, 1, 0, 1, '2010-01-12 13:05:44', 62, '', '2010-01-12 13:36:35', 62, 62, '2010-01-12 13:36:36', '2010-01-12 13:05:44', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 1, '', '', 0, 6, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (8, 'Agriculture Income', 'agriculture-income', '', '<h3>Agricultural income U/s 2(1A)</h3>\r\n<p>(a) Income from land   which is situated in India and is used for agricultural purposes.</p>\r\n<p>Income from farm Building is considered as agriculture Income:</p>\r\n<ol>\r\n<li>It should be occupied by the cultivator or receiver of rent or revenue</li>\r\n<li>The building is on or in the immediate vicinity of the land</li>\r\n<li>Building can be used as dwelling house or store house or out-house</li>\r\n<li>The land is assessed to land revenue if not land shall not be situated<br />a. Within municipality with not less than 10,000 population as per last census on the 1<sup>st</sup> day of pervious year<br />b. Within 8 Kilometers from the notified local limits</li>\r\n<li>Income derived from letting  out the land or building for the residential purpose or for business or profession is not an agriculture Income.</li>\r\n</ol>\r\n<p><strong>Note: </strong></p>\r\n<ul>\r\n<li>Any income derived from saplings or seedlings grown in a nursery shall be deemed to be agricultural income.</li>\r\n<li>Exemption of agriculture Income derived in India U/s 10(1)</li>\r\n<li>Computation of agriculture and non-agriculture income is done on the percentages basis of profit of business-<br /><br />Rule 7A sale of centrifuged latex and cenex manufactured from rubber </li>\r\n</ul>\r\n<ul style="padding-left: 60px;">\r\n<li> 65% Agriculture Income</li>\r\n<li> 35% Non-Agriculture Income</li>\r\n</ul>\r\n<p style="padding-left: 30px;">Rule7B -<br />a. sale of grown and cured coffee by seller in India</p>\r\n<ul style="padding-left: 60px;">\r\n<li> 75% Agriculture Income</li>\r\n<li> 25% Non-Agriculture Income</li>\r\n</ul>\r\n<p style="padding-left: 30px;">b. Sale of grown, cured, roasted and grounded coffee by the seller in India</p>\r\n<blockquote>\r\n<ul>\r\n<li>60% Agricultural Income</li>\r\n<li>40% Non-Agriculture Income</li>\r\n</ul>\r\nRule 8 Growing and Manufacturing Tea<br /></blockquote>\r\n<blockquote>\r\n<ul>\r\n<li>60% Agricultural Income</li>\r\n<li> 40% Non-Agriculture Income</li>\r\n</ul>\r\n</blockquote>\r\n<p style="padding-left: 60px;"> </p>', '', 1, 1, 0, 1, '2010-01-05 16:31:16', 62, '', '2010-01-05 18:14:46', 62, 0, '0000-00-00 00:00:00', '2010-01-05 16:31:16', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 2, 0, 6, '', '', 0, 18, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (11, 'Interest/Advance Tax', 'interestadvance-tax', '', '<h3><span style="text-decoration: underline;"><span style="font-size: medium;"><span style="font-family: book antiqua,palatino;">Interest</span></span></span>:</h3>\r\n<p><span style="text-decoration: underline;"><span style="font-size: medium;"><span style="font-family: book antiqua,palatino;">Section 234A: </span></span></span><span style="font-family: arial,helvetica,sans-serif;"><span style="font-size: medium;"><span style="color: #000000;"><br /></span></span></span></p>\r\n<p><span style="font-family: arial,helvetica,sans-serif;"><span style="font-size: medium;"><span style="color: #000000;">Interest under this section charges for-</span></span></span></p>\r\n<ul>\r\n<li>\r\n<p>The return of Income is not filed within the due date u/s139(1) or within the time allowed by the notice U/s 142(1) or</p>\r\n</li>\r\n<li>\r\n<p>The return of Income is not Furnished</p>\r\n</li>\r\n</ul>\r\n<p>1. Interest rate is 1% for every Month or part of the month</p>\r\n<p>2. The period of charging the interest in case of return is filed- is from the due date of filing the return till the date of furnishing the return of Income and if return of income is not filed then from the due date of filing the return upto date of completion of assessment</p>\r\n<p>3 .The amount on which the interest is payable ia as below:</p>\r\n<p>Tax payable less TDS.TCS, advance tax paid -balance is the amount on which Interest u/s 234A is Payable</p>\r\n<p>4. Calculation of Interest is on the amount on which interest is payable *1% per month*no. of months.</p>\r\n<p>5. Interest payanle U/s 234A is to be reduced by interest paid U/s 140A Self -Assessment.</p>\r\n<p>Refund is granted to the assess</p>\r\n<p> </p>\r\n<p><span style="font-size: medium;"><span style="font-family: book antiqua,palatino;"><span style="text-decoration: underline;"><strong>Section 234B</strong></span>:</span></span></p>\r\n<p>I<span style="font-size: medium;"><span style="font-family: arial,helvetica,sans-serif;">nterest under this section is charged for-</span></span></p>\r\n<ul>\r\n<li>Assessee fails to pay advance Tax</li>\r\n<li>The advance Tax paid by the assessee iss less than 90% of the assessed Tax.</li>\r\n</ul>\r\n<p>1. Interest rate is 1% for every Month or part of the month</p>\r\n<p>2.The amount on which the interest is payable ia as below:</p>\r\n<p>Tax payable less TDS.TCS, advance tax paid -balance is the amount on which Interest u/s 234A is Payable</p>\r\n<p>4. Calculation of Interest is on the amount on which interest is payable *1% per month*no. of months.</p>\r\n<p>5.a) The period of charging of interest in case if return of income if not filed then interest is as below</p>\r\n<p>Amount as per point 2.*no. of months from 1st April of assessment year to the month of completion of assessment *1%p.m</p>\r\n<p>b) when of Income as per assessment and the return filed are same and 140A self assessment Tax is paid then interest is</p>\r\n<p>amount as per point 2.*no. of months from 1st April of assessment year to the month of payment of tax U/s 140A *1%p.m</p>\r\n<p> </p>\r\n<p><span style="text-decoration: underline;"><strong><span style="font-size: medium;"><span style="font-family: book antiqua,palatino;">Section 234C</span></span></strong></span>:</p>\r\n<p>I<span style="font-size: medium;"><span style="font-family: arial,helvetica,sans-serif;">nterest under this section is charged for-</span></span></p>\r\n<p>For the failure to pay any installment of advance atx by the assessee or pay less than the prescribed amount.</p>\r\n<p>1.Interest rate is 1% per month</p>\r\n<p>2.for Ist installment -3months*1%(12% of advance Tax payable)</p>\r\n<p>for IInd installment -3months *1%(36% of advance Tax Payable)</p>\r\n<p>for IIIrd installment -3 months*1%</p>\r\n<p>for IV th installment - 1Month *1%</p>\r\n<p>3.Advance Tax-Due date and % of amount payable</p>\r\n<p> </p>\r\n<table style="width: 507px; height: 190px;" border="0">\r\n<tbody>\r\n<tr>\r\n<td><span style="font-size: small;"><strong>Due Date</strong></span></td>\r\n<td><span style="font-size: small;"><strong>Corporate Assessee</strong></span></td>\r\n<td><span style="font-size: small;"><strong>Non-corporate Assessee</strong></span></td>\r\n</tr>\r\n<tr>\r\n<td>On or before 15th June</td>\r\n<td>15% of Advance Tax payable</td>\r\n<td>Not Applicable</td>\r\n</tr>\r\n<tr>\r\n<td>On or before 15th Sep</td>\r\n<td>45% of Advance Tax payable</td>\r\n<td>30% of Advance Tax payable</td>\r\n</tr>\r\n<tr>\r\n<td>On or before 15th Dec</td>\r\n<td>75% of Advance Tax payable</td>\r\n<td>60% of Advance Tax payable</td>\r\n</tr>\r\n<tr>\r\n<td>On or before 15th march</td>\r\n<td>100% of Advance Tax payable</td>\r\n<td>100% of Advance Tax payable</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<p>4.Advance Tax should be paid by any person fopr the assessment year immediately following the financial year is Ra.5,000/- or more (AY 2009-10) as per Finance Bill 2009 ,advance Tax for the financial year would be payable only if the advance Tax liability is Rs.10,000/- or more.</p>\r\n<p> </p>\r\n<p><span style="text-decoration: underline;"><strong><span style="font-size: medium;"><span style="font-family: book antiqua,palatino;">Section 234D</span></span></strong></span>:</p>\r\n<p>I<span style="font-size: medium;"><span style="font-family: arial,helvetica,sans-serif;">nterest under this section is charged on Excess Refund<br /></span></span></p>\r\n<p>1.Refund is granted to the assessee u/s 143(1)</p>\r\n<p>2.No refund is due or it is reduced on regular Assessment u/s143(3)</p>\r\n<p>3.Amounof Interest is excess refund made u/s 143(1)*0.5%*no. of months or part thereof</p>\r\n<p>4.the interest achrged under this section may be reduced by order received u/s154,155,250,25,260,262,263,264 or an order os an settlement commission</p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n<ul>\r\n</ul>', '', 1, 1, 0, 1, '2010-01-11 05:28:04', 62, '', '2010-01-11 08:47:33', 62, 62, '2010-01-11 08:47:34', '2010-01-11 05:28:04', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 18, 0, 2, '', '', 0, 15, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (9, 'Exempted Income', 'exempted-income', '', '<p style="text-align: left;"><span style="font-size: small;"><strong>Under Section 10 Following are the Income Exempt from Total Income</strong></span></p>\r\n<h3 style="text-align: left;"><strong>Section 10(1)</strong></h3>\r\n<p style="text-align: left;">Agricultural income</p>\r\n<h3 style="text-align: left;"><strong>Section 10(2)</strong></h3>\r\n<p style="text-&lt;mce:script type=">Any sum received by an individual as a member of a Hindu undivided family, where such sum has been paid out of the income of the family, or, in the case of any impartible estate, where such sum has been paid out of the income of the estate belonging to the family</p>\r\n<p style="text-&lt;mce:script type="> </p>\r\n<h3 style="text-align: left;"><strong><strong>Section 10(2A)</strong></strong></h3>\r\n<p>partner of a firm which is separately assessed as such, his share in the total income of the firm.<br /><br /></p>\r\n<h3 style="text-align: left;"><strong>section 10(4)</strong></h3>\r\n<p style="text-align: left;">A non-resident, any income by way of interest on such securities or bonds as the Central Government may, by notification in the Official Gazette, specify in this behalf, including income by way of premium on the redemption of such bonds (Central Government shall not specify, for the purposes of this sub-clause, such securities or bonds on or after the 1st day of June, 2002)</p>\r\n<p style="text-align: left;">In the case of an individual, any income by way of interest on moneys standing to his credit in a Non-Resident (External) Account in any bank in India in accordance with the Foreign Exchange Regulation Act, 1973 (46 of 1973), and the rules made thereunder</p>\r\n<p style="text-align: left;"> </p>\r\n<h3 style="text-align: left;"><strong><strong>section 10(4B)</strong></strong></h3>\r\n<p>An individual, being a citizen of India or a person of Indian origin, who is a non-resident, any income from interest on such savings certificates issued [before the 1st day of June, 2002] by the Central Government as that Government may, by notification in the Official Gazette.</p>\r\n<p> </p>\r\n<h3 style="text-align: left;">Section 10(5)</h3>\r\n<p>In the case of an individual, the value of any travel concession or assistance received by, or due to, him,</p>\r\n<p style="padding-left: 30px;">(<em>a</em>) from his employer for himself and his family, in connection with his proceeding on leave to any place in India ;</p>\r\n<p style="padding-left: 30px;">(<em>b</em>) from his employer or former employer for himself and his family, in connection with his proceeding to any place in India after retirement from service or after the termination of his service, subject to such conditions as may be prescribed (including conditions as to number of journeys and the amount which shall be exempt per head) having regard to the travel concession or assistance granted to the employees of the Central Government</p>\r\n<p><strong>Note:</strong> The amount of exemption shall in no case exceed the amount of expenses actually incurred for the purpose of such travel.</p>\r\n<h3 style="text-align: left;"><br />Section 10(6A)</h3>\r\n<p>In the case of a foreign company deriving income by way of royalty or fees for technical services received from Government or an Indian concern in pursuance of an agreement made by the foreign company with Government or the Indian concern after the 31st day of March, 1976 but before the 1st day of June, 2002 and,</p>\r\n<p style="padding-left: 30px;"><br />(<em>a</em>) where the agreement relates to a matter included in the industrial policy, for the time being in force, of the Government of India, such agreement is in accordance with that policy ; and</p>\r\n<p style="padding-left: 30px;">(<em>b</em>) in any other case, the agreement is approved by the Central Government.</p>\r\n<h3 style="text-align: left;">Section 10(6B)</h3>\r\n<p>Where in the case of a non-resident or of a foreign company deriving income (not being salary, royalty or fees for technical services) from Government or an Indian concern in pur-suance of an agreement entered into before the 1st day of June, 2002 by the Central Government with the Government of a foreign State or an international organisation, the tax on such income is payable by Government or the Indian concern to the Central Government under the terms of that agreement or any other related agreement approved .</p>\r\n<h3 style="text-align: left;">Section 10(6BB)</h3>\r\n<p>where in the case of the Government of a foreign State or a foreign enterprise deriving income from an Indian company engaged in the business of operation of aircraft, on lease  (agreement entered into after the 31st day of March,[2007) and approved by the Central Government in this behalf and the tax on such income is payable by such Indian company under the terms of that agreement to the Central Government, the tax so paid.</p>\r\n<h3 style="text-align: left;">Section 10(6C)</h3>\r\n<p>Any income arising to such foreign company, by way of  royalty or  fees for technical services received in pursuance of an agreement entered into with that Government for providing services in or outside India in projects connected with security of India</p>\r\n<h3 style="text-align: left;">Section 10(7)</h3>\r\n<p>Any allowances or perquisites paid or allowed as such outside India by the Government to a citizen of India for rendering service outside India</p>\r\n<h3 style="text-align: left;">Section 10(8)</h3>\r\n<p>An individual who is assigned to duties in India in connection with any co-operative technical assistance programmes</p>\r\n<p style="text-align: left; padding-left: 30px;"><strong>Section 10(8A)</strong></p>\r\n<p style="padding-left: 30px;">In the case of a consultant</p>\r\n<p style="padding-left: 60px;">(<em>a</em>) any remuneration or fee received by him or it, directly or indirectly, out of the funds made available to an international organisation  under a technical assistance grant agreement between the agency and the Government of a foreign State ; and</p>\r\n<p style="padding-left: 60px;">(<em>b</em>) any other income which accrues or arises to him or it outside India, and is not deemed to accrue or arise in India, in respect of which such consultant is required to pay any income or social security tax to the Government of the country of his or its origin.</p>\r\n<p style="text-align: left; padding-left: 30px;"><strong>Section 10(8B)</strong></p>\r\n<p style="padding-left: 30px;">In the case of an individual who is assigned to duties in India in connection with any technical assistance programme the remuneration received by him, directly or indirectly, for such duties from any consultant referred to (<em>8A</em>)</p>\r\n<h3 style="text-align: left;">Section 10(9)</h3>\r\n<p>The income of any member of the family of any such individual  which accrues or arises outside India, and is not deemed to accrue or arise in India, in respect of which such member is required to pay any income or social security tax to the Government of that foreign State</p>\r\n<h3 style="text-align: left;">Section 10(10BC)</h3>\r\n<p>Any amount received or receivable from the Central Government or a State Government or a local authority by an individual or his legal heir by way of compensation on account of any disaster, except the amount received or receivable to the extent such individual or his legal heir has been allowed a deduction under this Act on account of any loss or damage caused by such disaster.</p>\r\n<h3 style="text-align: left;">Section 10(15)</h3>\r\n<p>This Section os applicable to the all assessees ,Income from notified bonds,deposits and securities-Fully exempt.</p>\r\n<h3 style="text-align: left;">Section 10(15A)</h3>\r\n<p>Applicable to Foreign enterprise/Government-Nature of Income is Tax paid by an Indian Company in respect of lease payment made by it to acquire an aircraft from a foreign Government /Foreign enterprise by the way of agreement entered up to 31-03-2007 which is fully Exempt.</p>\r\n<h3 style="text-align: left;">Section 10(16)</h3>\r\n<p>Scholarships granted to meet the cost of education</p>\r\n<h3 style="text-align: left;">Section 10(17)</h3>\r\n<p>Any income by way of</p>\r\n<p style="padding-left: 30px;">(<em>i</em>) daily allowance received by any person by reason of his membership of Parliament or of any State Legislature or of any Committee</p>\r\n<p style="padding-left: 30px;"><em>ii</em>) any allowance received by any person by reason of his membership of Parliament under the Members of Parliament (Constituency Allowance) Rules, 1986;</p>\r\n<p style="padding-left: 30px;">(<em>iii</em>) any constituency allowance received by any person by reason of his membership of any State Legislature under any Act or rules made by that State Legislature</p>\r\n<h3 style="text-align: left;">Section 10(17A)</h3>\r\n<p>Any payment made, whether in cash or in kind,</p>\r\n<p style="padding-left: 30px;">(<em>i</em>) in pursuance of any award instituted in the public interest by the Central Government or any State Government or instituted by any other body and approved by the Central Government  or</p>\r\n<p style="padding-left: 30px;">(<em>ii</em>) as a reward by the Central Government or any State Government for such purposes as may be approved by the Central Government in this behalf in the public interest</p>\r\n<h3 style="text-align: left;">Section 10(18)</h3>\r\n<p>Any income by way of</p>\r\n<p style="padding-left: 30px;">(<em>i</em>) pension received by an individual who has been in the service of the Central Government or State Government and has been awarded Param Vir Chakra or Maha Vir Chakra or Vir Chakra or such other gallantry award as the Central Government may, notify in Official Gazette</p>\r\n<p style="padding-left: 30px;">(<em>ii</em>) family pension received by any member of the family of an individual referred to in sub-clause (<em>i</em>).</p>\r\n<h3 style="text-align: left;">Section 10(19)</h3>\r\n<p>Family pension received by the widow or children or nominated heirs, as the case may be, of a member of the armed forces (including para-military forces) of the Union, where the death of such member has occurred in the course of operational duties, in such circumstances and subject to such conditions, as may be prescribed .</p>\r\n<h3 style="text-align: left;">Section 10(19A)</h3>\r\n<p>Income from any House Property which is applicable for the Ex-ruler is fully Exempt.</p>\r\n<h3 style="text-align: left;">Section 10(20)</h3>\r\n<p>Nature of Income House property, Capital Gain, or other sources and other Income is Fully Exempt applicable to the Local authority</p>\r\n<h3 style="text-align: left;">Section 10(21)</h3>\r\n<p>Any income of a scientific research association approved for the purpose of U/s 35</p>\r\n<h3 style="text-align: left;">Section 10(22B)</h3>\r\n<p>Any income of such news agency set up in India solely for collection and distribution of news as the Central Government may, by notification in the Official Gazette specify in this behalf: is fully Exempt.</p>\r\n<h3 style="text-align: left;">Section 10(23A)</h3>\r\n<p>Any income other than income chargeable under the head  Income from house property or  any specific services or income by way of interest or dividends  of an association or institution established in India having as its object the control, supervision, regulation or encouragement of the profession of law, medicine, accountancy, engineering or architecture or such other profession as the Central Government may specify in this behalf, from time to time, by notification in the Official Gazette</p>\r\n<p> </p>\r\n<h3 style="text-align: left;">Section 10(23AA)</h3>\r\n<p style="text-align: left;"><span style="font-family: book antiqua,palatino;"><span style="color: #000000;"><span style="font-size: small;">Any income received by any person on behalf of any Regimental Fund or Non-Public Fund established by the armed forces .</span></span></span></p>\r\n<p style="text-align: left;"> </p>\r\n<h3 style="text-align: left;">Section 10(23AAA)</h3>\r\n<p style="text-align: left;">Any income received by any person on behalf of a fund established, for such purposes as may be notified by the Board in the Official Gazette, for the welfare of employees or their dependants and such employees are members if such fund fulfils the following conditions, namely :</p>\r\n<p style="text-align: left;">(<em>a</em>) the fund</p>\r\n<p style="text-align: left;">(<em>i</em>) applies its income or accumulates it for application, wholly and exclusively to the objects for which it is established; and</p>\r\n<p style="text-align: left;">(<em>ii</em>) invests its funds and contributions and other sums received by it in the forms or modes specified in u/s 11(5)</p>\r\n<p>(<em>b</em>) the fund is approved by the Commissioner</p>\r\n<p style="text-align: left;"> </p>\r\n<p style="padding-left: 60px;"> </p>\r\n<h3>Section 10(23AAB)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Ant Income of approved pension fund of LIC or Other insurer is fully Exempt.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23B)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of an institution constituted as a public charitable trust or registered under the Societies Registration Act, 1860 (21 of 1860), or under any law  existing solely for the development of khadi or village industries or both, and not for purposes of profit, to the extent such income is attributable to the business of production, sale, or marketing, of khadi or products of village industries</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23BB)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of an authority  established in a State by or under a State or Provincial Act for the development of khadi or village industries in the State.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23BBA)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of any body or authority  constituted  under any Central, State or Provincial Act which provides for the administration of any one or more of the following, that is to say, public religious or charitable trusts or endowments  or societies for religious or charitable purposes registered as such under the Societies Registration Act, 1860 (21 of 1860), or any other law for the time being in force</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23BBB)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of the European Economic Community derived in India by way of interest, dividends or capital gains from investments made out of its funds under notified scheme<sup>.</sup></p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23BBC)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of the SAARC Fund for Regional Projects .</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23BBD)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of the Secretariat of the Asian Organisation of the Supreme Audit Institutions registered as ASOSAI-SECRETARIAT under the Societies Registration Act, 1860 .</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23BBE)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">any income of the Insurance Regulatory and Development Authority established under  Insurance Regulatory and Development Authority act,1999</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23BBG)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of the Central Electricity Regulatory Commission constituted under sub-section (1) of section 76 of the Electricity Act, 2003.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section10(23C)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income received by any person on behalf of</p>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">The Prime Ministers National Relief Fund</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">The Prime Ministers Fund </li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">The Prime Ministers Aid to Students Fund; </li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; "> The National Foundation for Communal Harmony</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; "> Any university or other educational institution existing  solely for educational purposes and not for purposes of profit, and which is wholly or substantially financed by the Government</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">Any hospital or other institution for the reception and treatment of persons suffering from illness or mental defectiveness or for the reception and treatment of persons during convalescence or of persons requiring medical attention or rehabilitation, existing solely for philanthropic purposes and not for purposes of profit, and which is wholly or substantially financed by the Government</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">Any university or other educational institution existing solely  for educational purposes and not for purposes of profit if the aggregate annual receipts of such university or educational institution do not exceed the amount of annual receipts as may be prescribed</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">Any hospital or other institution for the reception and treatment of persons suffering from illness or mental defectiveness or for the reception and treatment of persons during convalescence or of persons requiring medical attention or rehabilitation, existing solely for philanthropic purposes and not for purposes of profit, if the aggregate annual receipts of such hospital or institution do not exceed the amount of annual receipts as may be prescribed </li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">Any other fund or institution established for charitable purposes</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">Any trust or institution wholly for public religious purposes or wholly for public religious and charitable purposes,  having regard to the manner in which the affairs of the trust or institution are administered and supervised for ensuring that the income accruing thereto is properly applied for the objects .</li>\r\n</ul>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "><strong>Note (<span style="color: #ff0000;">Latest amendment</span>) </strong>:Income of Institutions specified under its various Sub-clauses shall be exempt from Income Tax. In certain cases, approvals are required to be taken from prescribed authorities, in the prescribed manner to become eligible for claiming exemption.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Under existing provisions, any institution having receipt of more than rupees one crore has to make an application for seeking exemption at any during the financial year for which the exemption is sought</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">In Practice, an eligible institution has to anticipate its annual receipts to decide whether the application for exemption  is required to be filed or not.This has often led to avoidable hardships.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">In order to mitigate this hardships it is proposed to extend the time limit for filling such application to the 30th day of September in the succeeding financial year. It is proposed to provide this relaxation for the financial year 2008-09 and subsequent years.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">In other words, where the gross receipt of a trust or institution exceeds rupees one crore in the financial year 2009-09,it can file application for exemption until 30th September 2009.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23D)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any Income from the approved mutual funds is totally Exempt.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23EA)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of  Investor Protection Fund set up by recognised stock exchanges in India, either jointly or separately, as the Central Government may by notification in the Official Gazette.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(23EB)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income of the Credit Guarantee Fund Trust for Small</p>\r\n<p> </p>\r\n<h3>section 10(23EC)</h3>\r\n<p>Any income, by way of contributions received from commodity exchanges and the members thereof, of such Investor Protection Fund set up by commodity exchanges in India, either jointly or separately, as the Central Government may, by notification in the Official Gazette<br /><br /><br /></p>\r\n<h3>Section10(30)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">In the case of an assessee who carries on the business of growing and manufacturing tea in India, the amount of any subsidy received from or through the Tea Board under any such scheme for replantation or replacement of tea bushes</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(31)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Growing and Manufacturing of rubber, Coffee, or cardamom or other notified commodities,the amount any subsidy received from the relevant board.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(32)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Applicable to the Individual ,where Income of minor child clubbed U/s 64(1) the amount of exemption is Ra.1500 p.a per child (No restriction on no. of children)</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section10(33)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Applicable for the all assessees for the Income from unit of unit scheme,1964</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section10(34)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income by way of dividends referred to in Section 115O( refer to this given link http://law.incometaxindia.gov.in/TaxmannDit/DispCitation/ShowCit.aspx?fn=http://law.incometaxindia.gov.in/DitTaxmann/IncomeTaxActs/2009ITAct/section10.htm)</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(35)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income by way of units of Mutual funds is fully Exempt.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<h3>Section 10(36)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income arising from the transfer of a long-term capital asset, being an eligible equity share in a company purchased on or after the 1st day of March, 2003 and before the 1st day of March, 2004 and held for a period of twelve months or more.</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Note: eligible equity share means,</p>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; "> Any equity share in a company being a constituent of BSE-500 Index of the Stock Exchange, Mumbai as on the 1st day of March, 2003 and the transactions of purchase and sale of such equity share are entered into on a recognised stock exchange in India.</li>\r\n</ul>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; "> </p>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">Any equity share in a company allotted through a public issue on or after the 1st day of March, 2003 and listed in a recognised stock exchange in India before the 1st day of March, 2004 and the transaction of sale of such share is entered into on a recognised stock exchange in India.</li>\r\n</ul>\r\n<p> </p>\r\n<h3>Section 10(37)</h3>\r\n<p>An individual or a Hindu undivided family, any income chargeable under the head Capital gains arising from the transfer of agricultural land,</p>\r\n<p> </p>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">such land, during the period of two years immediately preceding the date of transfer, was being used for agricultural purposes by such Hindu undivided family or individual or a parent of his;</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">such transfer is by way of compulsory acquisition under any law, or a transfer the consideration for which is determined or approved by the Central Government or the Reserve Bank of India;</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; "> such income has arisen from the compensation or consideration for such transfer received by such assessee on or after the 1st day of April, 2004.</li>\r\n</ul>\r\n<p> </p>\r\n<h3>Section10(38)</h3>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any income arising from the transfer of a long-term capital asset, being an equity share in a company or a unit of an equity oriented fund .</p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">equity oriented fund means a fund</p>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; "> where the investible funds are invested by way of equity shares in domestic companies to the extent of more than <a href="http://law.incometaxindia.gov.in/DitTaxmann/IncomeTaxActs/2009ITAct/ftn71section7.htm"></a>sixty-five per cent of the total proceeds of such fund; and</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">which has been set up under a scheme of a Mutual Fund specified under clause (23D) </li>\r\n</ul>\r\n<p> </p>\r\n<h3>Section 10(39)</h3>\r\n<p>Any specified income, arising from any international sporting event held in India to the notified assessees.</p>\r\n<p> </p>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; "> is approved by the international body regulating the international sport relating to such event;</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">has participation by more than two countries;</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">is notified by the Central Government in the Official Gazette for the purposes of this clause.</li>\r\n</ul>\r\n<p> </p>\r\n<h3>Section 10(40)</h3>\r\n<p>Any income received by a  subsidiary company by way of grant or otherwise received from an Indian company, being its holding company engaged in the business of generation or transmission or distribution of power if receipt of such income is for settlement of dues in connection with reconstruction or revival of an existing business of power generation.<br /><br /></p>\r\n<h3>Section 10(42)</h3>\r\n<p> </p>\r\n<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; text-align: left; ">Any specified income arising to a body or authority which</p>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">into by the Central Government with two or more countries or a convention signed by the Central Government;</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">is established or constituted or appointed not for the purposes of profit;</li>\r\n</ul>\r\n<ul style="margin-top: 0px; margin-bottom: 0px; ">\r\n<li style="margin-top: 0px; margin-bottom: 0px; ">is notified by the Central Government in the Official Gazette for the purposes of this clause.</li>\r\n</ul>\r\n<p> </p>\r\n<h3>Section 10(43)</h3>\r\n<p>Any amount received by an individual as a loan, either in lump sum or in instalment, in a transaction of reverse mortgage referred to in Section 47(xvi)</p>\r\n<p> </p>\r\n<p><span style="font-size: medium;"><strong><br />Following are the particulars of section 10A,10AA,10B,10BA</strong></span></p>\r\n<!-- 		@page { margin: 0.79in } 		P { margin-bottom: 0.08in } --> \r\n<table style="width: 732px;" border="1" cellspacing="0" cellpadding="7" bordercolor="#000001">\r\n<col width="119"></col> <col width="133"></col> <col width="137"></col> <col width="133"></col> <col width="138"></col> \r\n<tbody>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p align="CENTER">Particulars</p>\r\n</td>\r\n<td width="133">\r\n<p align="CENTER">Section 10A</p>\r\n</td>\r\n<td width="137">\r\n<p align="CENTER">Section 10AA</p>\r\n</td>\r\n<td width="133">\r\n<p align="CENTER">Section 10B</p>\r\n</td>\r\n<td width="138">\r\n<p align="CENTER">Section 10BA</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p align="CENTER"><strong>Eligible Assessee</strong></p>\r\n</td>\r\n<td width="133">\r\n<p><strong>Special provision in respect of newly established 			undertakings in free trade zone, etc.</strong></p>\r\n</td>\r\n<td width="137">\r\n<p><strong>Special provisions in respect of newly established Units in 			Special Economic Zones</strong></p>\r\n</td>\r\n<td width="133">\r\n<p><strong>Special provisions in respect of newly established hundred 			per cent export-oriented undertakings</strong></p>\r\n</td>\r\n<td width="138">\r\n<p><strong>Units Exporting article or things</strong></p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p align="CENTER">Nature of Business</p>\r\n</td>\r\n<td width="133">\r\n<p>Manufacture/produce article or things or computer software</p>\r\n</td>\r\n<td width="137">\r\n<p>Manufacture/produce article or things or computer software or 			provide services</p>\r\n</td>\r\n<td width="133">\r\n<p>Manufacture/produce article or things or computer software</p>\r\n</td>\r\n<td width="138">\r\n<p>Manufacture/producer of Eligible article or things(Min. export 			is 90% to total Turnover)</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p>Special Reserve account and conditions relating for additional 			reserve</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Applicable</p>\r\n</td>\r\n<td width="137">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Applicable</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Not Applicable</p>\r\n</td>\r\n<td width="138">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Not Applicable</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p>Audit report</p>\r\n</td>\r\n<td width="133">\r\n<p align="CENTER">FORM 56F</p>\r\n</td>\r\n<td width="137">\r\n<p align="CENTER">FORM 56F</p>\r\n</td>\r\n<td width="133">\r\n<p align="CENTER">FORM 56G</p>\r\n</td>\r\n<td width="138">\r\n<p align="CENTER">FORM 56H</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p>Form for return for particulars of New machinery</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Form 56FF</p>\r\n</td>\r\n<td width="137">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Form 56FF</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">-</p>\r\n</td>\r\n<td width="138">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p>Proceeds of sale to be received with 6 months in convertible 			foreign exchange</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Within 6 Months</p>\r\n</td>\r\n<td width="137">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Within 6 Months</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">-</p>\r\n</td>\r\n<td width="138">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Within 6 Months</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119" height="5">\r\n<p>Deduction</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;">Year 1-5 100% Export profit</p>\r\n<p style="margin-bottom: 0in;">Year 6-7 50% export profit</p>\r\n<p>Year 8-10 50% export profit or credit to special reserve</p>\r\n</td>\r\n<td width="137">\r\n<p style="margin-bottom: 0in;">Year 1-5 100% Export profit</p>\r\n<p style="margin-bottom: 0in;">Year 6-7 50% export profit</p>\r\n<p style="margin-bottom: 0in;">Year 8-10 50% export profit</p>\r\n<p style="margin-bottom: 0in;">Year 11-15 50% export profit</p>\r\n<p>or credit to special reserve</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p>100% of Export profit</p>\r\n</td>\r\n<td width="138">\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p>100% of Export Profit</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="119">\r\n<p>Deduction applicable till assessment</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">2011-12</p>\r\n</td>\r\n<td width="137">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">Not specified</p>\r\n</td>\r\n<td width="133">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">2011-12</p>\r\n</td>\r\n<td width="138">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">2009-10</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<p style="padding-left: 90px;"> </p>', '', 1, 1, 0, 1, '2010-01-05 16:32:21', 62, '', '2010-01-11 16:37:42', 62, 62, '2010-01-11 16:37:43', '2010-01-05 16:32:21', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 12, 0, 5, '', '', 0, 15, 'robots=\nauthor=');
INSERT INTO `jos_content` (`id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`) VALUES (10, 'Tax Deduction/Collection at Source', 'tax-deductioncollection-at-source', '', '<!-- 		@page { margin: 0.79in } 		P { margin-bottom: 0.08in } --> <!-- 		@page { margin: 0.79in } 		P { margin-bottom: 0.08in } -->\r\n<p> </p>\r\n<h3>Individual / HUF</h3>\r\n<dl><dl><dd> \r\n<table style="width: 632px; height: 1095px;" border="1" cellspacing="0" cellpadding="7" bordercolor="#000001">\r\n<col width="151"></col> <col width="237"></col> <col width="250"></col> <col width="153"></col> \r\n<tbody>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p><strong>Section/Nature</strong></p>\r\n</td>\r\n<td width="237">\r\n<p style="margin-bottom: 0in;" align="CENTER"><span style="text-decoration: underline;"><strong>Assessment year 					2009-10</strong></span></p>\r\n<p style="margin-bottom: 0in;">Less than          Greater than</p>\r\n<p>10 Lakhs                                           10 Lakhs</p>\r\n</td>\r\n<td width="250">\r\n<p style="margin-bottom: 0in;" align="CENTER"><strong>Assessment year 					2010-2011(W.e.f 1-10-2009)</strong></p>\r\n<p> </p>\r\n</td>\r\n<td width="153">\r\n<p><strong>Exemption Limit</strong></p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>192-Salary</p>\r\n</td>\r\n<td width="237">\r\n<p style="margin-bottom: 0in;">As applicable to  Individual</p>\r\n<p> </p>\r\n</td>\r\n<td width="250">\r\n<p style="margin-bottom: 0in;" align="CENTER">As  applicable to     					                            Individual</p>\r\n<p align="CENTER"> </p>\r\n</td>\r\n<td width="153">\r\n<p>Basic Exemption</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>193-Interest on Securities</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                     11.3%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Exempted for certain listed securities  u/s 193.Listed 					Debentures Rs.2,500/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194A- Interest  other than interest on Securities</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                     11.3%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.10,000/- if payment made by Banking co., co-operative 					society, post office .Rs.5,000/- made by any other person</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151" height="33">\r\n<p>194B-Winning from lottery/cross word puzzle</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">30.9%                                             33.99%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">30%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.5,000/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194BB-Winning from Horse  race</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">30.9%                                             33.99%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">30%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.2,500/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194C-Contractor</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">2.06%                                             2.266%%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">1%</p>\r\n</td>\r\n<td width="153">\r\n<p>Payment in excess of Rs. 20,000/- per contract or Rs. 					50,000/- per annum.</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194C-Sub contractor/Advertising contract</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">1.03%                                                   1.133%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">1%</p>\r\n</td>\r\n<td width="153">\r\n<p>------do-------</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p style="margin-bottom: 0in;">194D-Insurance</p>\r\n<p>Commission</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                                 11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.5,000/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194EE-National Savings Scheme</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">20.6%                                              22.66%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">20%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.2,500/-or payment is made to heirs of the deceased 					assessee</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194F-Equity linked savings scheme</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">20.6%                                            22.66%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">20%</p>\r\n</td>\r\n<td width="153">\r\n<p>-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194G-Commission on sale of Lottery tickets</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                           11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.1,000/- p.a</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194H-Commisssion or Brokerage</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                           11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.2,500/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151" height="95">\r\n<p style="margin-bottom: 0in;">194I-Rent</p>\r\n<p style="margin-bottom: 0in;">a. Land, building &amp; Furniture</p>\r\n<p style="margin-bottom: 0in;">b. Plant &amp; machinery</p>\r\n<p> </p>\r\n</td>\r\n<td width="237">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER">15.45%                             					       16.995%</p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">10.3%                                         11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER">10%</p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">2%</p>\r\n</td>\r\n<td width="153">\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p>Rs.1,20,000 in a financial year</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194J-Professional or technical; fees</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                    11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.20,000/- in financial year</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194LA-Compensation /Enhances compensation on compulsory 					acquisition</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                     11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.1,00,000/- in the financial yea</p>\r\n<p> </p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</dd></dl></dl>\r\n<h3>Company / Firms</h3>\r\n<!-- 		@page { margin: 0.79in } 		P { margin-bottom: 0.08in } --> <dl><dl><dd> \r\n<table style="width: 637px; height: 1036px;" border="1" cellspacing="0" cellpadding="7" bordercolor="#000001">\r\n<col width="151"></col> <col width="237"></col> <col width="250"></col> <col width="153"></col> \r\n<tbody>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p><strong>Section/Nature</strong></p>\r\n</td>\r\n<td width="237">\r\n<p style="margin-bottom: 0in;" align="CENTER"><span style="text-decoration: underline;"><strong>Assessment year 					2009-10</strong></span></p>\r\n<p style="margin-bottom: 0in;">Less than                               					Greater than</p>\r\n<p>1 crore                                            1 crore</p>\r\n</td>\r\n<td width="250">\r\n<p style="margin-bottom: 0in;" align="CENTER"><strong>Assessment year 					2010-2011(W.e.f 1-10-2009)</strong></p>\r\n<p><strong><br /></strong></p>\r\n</td>\r\n<td width="153">\r\n<p><strong>Exemption Limit</strong></p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>192-Salary</p>\r\n</td>\r\n<td width="237">\r\n<p style="margin-bottom: 0in;">As applicable to Individual</p>\r\n<p> </p>\r\n</td>\r\n<td width="250">\r\n<p style="margin-bottom: 0in;" align="CENTER">As  applicable to     					                            Individual</p>\r\n<p align="CENTER"> </p>\r\n</td>\r\n<td width="153">\r\n<p>Basic Exemption</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>193-Interest on Securities</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">20.6%                                       22.66%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">20%</p>\r\n</td>\r\n<td width="153">\r\n<p>Exempted for certain listed securities  u/s 193.Listed 					Debentures Rs.2,500/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194A- Interest  other than interest on Securities</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">20.6%                                         22.66%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">20%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.10,000/- if payment made by Banking co., co-operative 					society, post office .Rs.5,000/- made by any other person</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151" height="33">\r\n<p>194B-Winning from lottery/cross word puzzle</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">30.9%                                             33.99%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">30%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.5,000/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194BB-Winning from Horse  race</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">30.9%                                              33.99%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">30%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.2,500/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194C-Contractor/Cub contractor/Advertising contract</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">2.06%                                             2.266%%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">2%</p>\r\n</td>\r\n<td width="153">\r\n<p>Payment in excess of Rs. 20,000/- per contract or Rs. 					50,000/- per annum.</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p style="margin-bottom: 0in;">194D-Insurance</p>\r\n<p>Commission</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">20.6%                                   22.66%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">20%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.5,000/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194EE-National Savings Scheme</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">20.6%                                              22.66%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">20%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.2,500/-or payment is made to heirs of the deceased 					assessee</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194F-Equity linked savings scheme</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">20.6%                                            22.66%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">20%</p>\r\n</td>\r\n<td width="153">\r\n<p>-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194G-Commission on sale of Lottery tickets</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                           11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.1,000/- p.a</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194H-Commisssion or Brokerage</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                              11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.2,500/-</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151" height="95">\r\n<p style="margin-bottom: 0in;">194I-Rent</p>\r\n<p style="margin-bottom: 0in;">a. Land, building &amp; Furniture</p>\r\n<p style="margin-bottom: 0in;">b. Plant &amp; machinery</p>\r\n<p> </p>\r\n</td>\r\n<td width="237">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER">20.6%                                   					      22.66%</p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">10.3%                                     11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p style="margin-bottom: 0in;" align="CENTER">10%</p>\r\n<p style="margin-bottom: 0in;" align="CENTER"> </p>\r\n<p align="CENTER">2%</p>\r\n</td>\r\n<td width="153">\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p style="margin-bottom: 0in;"> </p>\r\n<p>Rs.1,20,000 in a financial year</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194J-Professional or technical; fees</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                      11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.20,000/- in financial year</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="151">\r\n<p>194LA-Compensation /Enhances compensation on compulsory 					acquisition</p>\r\n</td>\r\n<td width="237">\r\n<p align="CENTER">10.3%                                         11.33%</p>\r\n</td>\r\n<td width="250">\r\n<p align="CENTER">10%</p>\r\n</td>\r\n<td width="153">\r\n<p>Rs.1,00,000/- in the financial year</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</dd></dl></dl>\r\n<h3>Note</h3>\r\n<ol>\r\n<li> .<span style="font-size: small;">For the assessment year 2010-11 the rate of TDS will be 20% in all cases if PAN no. is not quoted by the deductee  w.e.f  01-04-2010</span></li>\r\n<li><span style="font-size: small;"> The nil rate will be applicable if the transporter quotes his PAN .If PAN is not quoted the rate will be 1% for an individual, HUF transporter and 2% for other transporters up to 31-03-2010</span></li>\r\n<li><span style="font-size: small;"> AY 2009-10-In case of Individual, HUF if the payment exceeds 10 lakhs –surcharge @10%+EC@2%+SHEC @1% is applicable (if not exceeds EC and SHEC is applicable)</span></li>\r\n<li><span style="font-size: small;">In case of company, firms if the payment exceeds 1 crore–surcharge @10%+EC@2%+SHEC @1% is applicable (if not exceeds EC and SHEC is applicable</span></li>\r\n<li><span style="font-size: small;">AY 2010-2011-Surcharge and education cess on tax Deducted on Non-salary payments made to resident taxpayers is proposed to be removed</span></li>\r\n</ol>\r\n<p>* EC-Education Cess    SHEC –Secondary higher education cess</p>\r\n<h3>Other Points</h3>\r\n<!-- 		@page { margin: 0.79in } 		P { margin-bottom: 0.08in } --> <ol>\r\n<li>\r\n<p style="margin-bottom: 0in;">TDS shall be deducted at the time 	of payment or at the time of credit whichever falls earlier</p>\r\n</li>\r\n<li>\r\n<p style="margin-bottom: 0in;"><span style="text-decoration: underline;"><strong>Time of remittance to the 	Government</strong></span>:</p>\r\n<ul>\r\n<li>In case of deduction by or on 	behalf of the Government ,TDS shall be remitted on the same day</li>\r\n<li>TDS made every month shall be 	deposited within one week from the last of the month in which 	deduction is made</li>\r\n</ul>\r\n<ul>\r\n<li>TDS made on the last day of the accounting year ,shall be deposited within 2 months from the end of the relevant accounting year</li>\r\n</ul>\r\n</li>\r\n<li>TDS Certificates Forms     \r\n<ul>\r\n<li>Salary-FORM 16</li>\r\n<li>Employees gross salary less than 1,50,000 and do not any income under the head profit and gains of business or profession or capital gains-FORM 16AA</li>\r\n<li>For Non-salary-FORM 16A</li>\r\n</ul>\r\n</li>\r\n<li>Issue of TDS Certificate     \r\n<ul>\r\n<li>Section 192-With one month from 	end of relevant financial year</li>\r\n<li>\r\n<p style="margin-bottom: 0in;">For non-salary</p>\r\n<ul>\r\n<li>\r\n<p style="margin-bottom: 0in;">If TDS is deducted 	Every month then within 1 month for the end of the month in which 	tax was deducted</p>\r\n</li>\r\n<li>If TDS deducted on the last day of the accounting year then within one week from the end of the two months (before 7<sup>th</sup> June of relevant assessment year)</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n</li>\r\n<li>Quarterly return and Due Date</li>\r\n</ol><dl><dl><dd> \r\n<table style="width: 408px;" border="1" cellspacing="0" cellpadding="7" bordercolor="#000001">\r\n<col width="87"></col> <col width="58"></col> <col width="219"></col> \r\n<tbody>\r\n<tr valign="TOP">\r\n<td width="87">\r\n<p align="CENTER">Section</p>\r\n</td>\r\n<td width="58">\r\n<p align="CENTER">From no.</p>\r\n</td>\r\n<td width="219">\r\n<p align="CENTER">Due date</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="87">\r\n<p>194</p>\r\n</td>\r\n<td width="58">\r\n<p>24Q</p>\r\n</td>\r\n<td width="219">\r\n<p style="margin-bottom: 0in;">I quarter -15<sup>th</sup> July</p>\r\n<p style="margin-bottom: 0in;">II quarter – 15<sup>th</sup> October</p>\r\n<p style="margin-bottom: 0in;">III  quarter  - 15<sup>th</sup> January</p>\r\n<p>IV quarter – on or before 15<sup>th</sup> June of the 					financial year</p>\r\n</td>\r\n</tr>\r\n<tr valign="TOP">\r\n<td width="87">\r\n<p>193 to 194J</p>\r\n</td>\r\n<td width="58">\r\n<p>26Q</p>\r\n</td>\r\n<td width="219">\r\n<p>------do-------</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</dd></dl></dl>\r\n<p style="margin-bottom: 0in;">Section 194E, 195,196B to 196D-From no.27Q and due date is 14 days from the end of the quarter <span style="text-decoration: underline;"><strong><br /></strong></span></p>\r\n<p style="margin-bottom: 0in;"><span style="text-decoration: underline;"><strong><br /></strong></span></p>\r\n<h3 style="margin-bottom: 0in;">Section 206C Tax Collection 	at source.</h3>\r\n<ol> </ol>\r\n<p style="margin-bottom: 0in;">Seller of a particular commodity shall collect tax from the buyer   for the following nature of goods.</p>\r\n<p style="margin-left: 0.67in; text-indent: -0.67in; margin-bottom: 0.04in;" align="JUSTIFY">Buyer means a person who obtains in any sale, by way of auction, tender or any other mode, goods of the nature specified</p>\r\n<p style="margin-left: 0.67in; text-indent: -0.67in; margin-bottom: 0.04in;" align="JUSTIFY">or the right to receive any such goods but does not include</p>\r\n<p style="margin-left: 0.92in; text-indent: -0.5in; margin-bottom: 0.04in;" align="JUSTIFY">(<em>i</em>) a public sector company, the Central Government, a State Government, and an embassy, a high commission, legation, commission, consulate and the trade representation, of a foreign State and a club</p>\r\n<p style="margin-left: 0.92in; text-indent: -0.5in; margin-bottom: 0.06in;" align="JUSTIFY">(<em>ii</em>) a buyer in the retail sale of such goods purchased by him for personal consumption</p>\r\n<p style="margin-left: 0.67in; text-indent: -0.67in; margin-bottom: 0.06in;" align="JUSTIFY">(<em>b</em>) scrap means waste and scrap from the manufacture or mechanical working of materials which is definitely not usable as such because of breakage, cutting up, wear and other reasons;</p>\r\n<p style="margin-left: 0.67in; text-indent: -0.67in; margin-bottom: 0.06in;" align="JUSTIFY">(<em>c</em>) seller means the Central Government, a State Government or any local authority or corporation or authority established by or under a Central, State or Provincial Act, or any company or firm or co-operative society and also includes an individual or a Hindu undivided family whose total sales, gross receipts or turnover from the business or profession carried on by him exceed the monetary limits specified under  section 44AB During the financial year immediately preceding the financial year in which the goods of the nature specified</p>', '', 1, 1, 0, 1, '2010-01-10 17:12:48', 62, '', '2010-01-11 14:09:56', 62, 62, '2010-01-11 14:09:57', '2010-01-10 17:12:48', '0000-00-00 00:00:00', '', '', 'show_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_vote=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nlanguage=\nkeyref=\nreadmore=', 6, 0, 3, '', '', 0, 15, 'robots=\nauthor=');

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

INSERT INTO `jos_content_frontpage` (`content_id`, `ordering`) VALUES (3, 1);

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

INSERT INTO `jos_content_rating` (`content_id`, `rating_sum`, `rating_count`, `lastip`) VALUES (6, 5, 1, '122.172.33.74');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- 
-- Dumping data for table `jos_core_acl_aro`
-- 

INSERT INTO `jos_core_acl_aro` (`id`, `section_value`, `value`, `order_value`, `name`, `hidden`) VALUES (10, 'users', '62', 0, 'Administrator', 0);

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

INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (17, 0, 'ROOT', 1, 22, 'ROOT');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (28, 17, 'USERS', 2, 21, 'USERS');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (29, 28, 'Public Frontend', 3, 12, 'Public Frontend');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (18, 29, 'Registered', 4, 11, 'Registered');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (19, 18, 'Author', 5, 10, 'Author');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (20, 19, 'Editor', 6, 9, 'Editor');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (21, 20, 'Publisher', 7, 8, 'Publisher');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (30, 28, 'Public Backend', 13, 20, 'Public Backend');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (23, 30, 'Manager', 14, 19, 'Manager');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (24, 23, 'Administrator', 15, 18, 'Administrator');
INSERT INTO `jos_core_acl_aro_groups` (`id`, `parent_id`, `name`, `lft`, `rgt`, `value`) VALUES (25, 24, 'Super Administrator', 16, 17, 'Super Administrator');

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

INSERT INTO `jos_core_acl_aro_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES (10, 'users', 1, 'Users', 0);

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

INSERT INTO `jos_core_acl_groups_aro_map` (`group_id`, `section_value`, `aro_id`) VALUES (25, '', 10);

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

INSERT INTO `jos_groups` (`id`, `name`) VALUES (0, 'Public');
INSERT INTO `jos_groups` (`id`, `name`) VALUES (1, 'Registered');
INSERT INTO `jos_groups` (`id`, `name`) VALUES (2, 'Special');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

-- 
-- Dumping data for table `jos_menu`
-- 

INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (1, 'knowledgebase', 'Knowledge Base', 'knowledgebase', 'index.php?option=com_content&view=frontpage', 'component', -2, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 3, 'num_leading_articles=1\nnum_intro_articles=4\nnum_columns=2\nnum_links=4\norderby_pri=\norderby_sec=front\nmulti_column_order=1\nshow_pagination=2\nshow_pagination_results=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (9, 'chartereds', 'Home', 'home', 'index.php?option=com_content&view=article&id=3', 'component', 1, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 1);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (2, 'knowledgebase', 'Accounts', 'accounts', 'index.php?option=com_weblinks&view=category&id=2', 'component', 1, 0, 4, 0, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_feed_link=1\nshow_comp_description=\ncomp_description=\nshow_link_hits=\nshow_link_description=\nshow_other_cats=\nshow_headings=\ntarget=\nlink_icons=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (3, 'knowledgebase', 'Direct Tax', 'direct-tax', 'index.php?option=com_content&view=category&id=1', 'component', 1, 0, 20, 0, 3, 62, '2010-01-05 18:43:41', 0, 0, 0, 0, 'display_num=10\nshow_headings=1\nshow_date=0\ndate_format=\nfilter=0\nfilter_type=title\norderby_sec=order\nshow_pagination=1\nshow_pagination_limit=1\nshow_feed_link=1\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (4, 'knowledgebase', 'Audit', 'audit', 'index.php?option=com_weblinks&view=category&id=3', 'component', 1, 0, 4, 0, 4, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_feed_link=1\nshow_comp_description=\ncomp_description=\nshow_link_hits=\nshow_link_description=\nshow_other_cats=\nshow_headings=\ntarget=\nlink_icons=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (5, 'knowledgebase', 'Corporate Laws', 'corporate-laws', 'index.php?option=com_weblinks&view=category&id=7', 'component', 1, 0, 4, 0, 5, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_feed_link=1\nshow_comp_description=\ncomp_description=\nshow_link_hits=\nshow_link_description=\nshow_other_cats=\nshow_headings=\ntarget=\nlink_icons=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (6, 'knowledgebase', 'Indirect Tax', 'indirect-tax', 'index.php?option=com_weblinks&view=category&id=5', 'component', 1, 0, 4, 0, 6, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_feed_link=1\nshow_comp_description=\ncomp_description=\nshow_link_hits=\nshow_link_description=\nshow_other_cats=\nshow_headings=\ntarget=\nlink_icons=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (8, 'chartereds', 'About Us', 'about-chartereds-forum', 'index.php?option=com_content&view=article&id=1', 'component', 1, 0, 20, 0, 3, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (10, 'chartereds', 'Contact Us', 'contact-us', 'index.php?option=com_content&view=article&id=2', 'component', 1, 0, 20, 0, 4, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (11, 'chartereds', 'Goals', 'goals', 'index.php?option=com_content&view=article&id=4', 'component', 1, 0, 20, 0, 2, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (12, 'knowledgebase', 'Jokes', 'jokes', 'index.php?option=com_content&view=archive', 'component', 0, 2, 20, 1, 1, 62, '2009-09-19 06:19:24', 0, 0, 0, 0, 'orderby=\nshow_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (13, 'funmenu', 'testing relaxation', 'relaxedtest', 'index.php?option=com_content&view=article&id=5', 'component', 1, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (14, 'funmenu', 'Bhoomika Chawla', 'bhoomika-chawla', 'index.php?option=com_phocagallery&view=category&id=1', 'component', 1, 0, 34, 0, 2, 62, '2009-12-28 16:48:43', 0, 0, 0, 0, 'show_pagination_categories=0\nshow_pagination_category=1\nshow_pagination_limit_categories=0\nshow_pagination_limit_category=1\ndisplay_cat_name_title=1\ndisplay_cat_name_breadcrumbs=0\nfont_color=\nbackground_color=\nbackground_color_hover=\nimage_background_color=\nimage_background_shadow=\nborder_color=\nborder_color_hover=\nmargin_box=\npadding_box=\ndisplay_name=\ndisplay_icon_detail=\ndisplay_icon_download=\ndisplay_icon_folder=\nfont_size_name=\nchar_length_name=\ncategory_box_space=\ndisplay_categories_sub=\ndisplay_subcat_page=\ndisplay_category_icon_image=\ncategory_image_ordering=\ndisplay_back_button=\ndisplay_categories_back_button=\ndefault_pagination_category=\npagination_category=\ndisplay_img_desc_box=\nfont_size_img_desc=\nimg_desc_box_height=\nchar_length_img_desc=\ndisplay_categories_cv=\ndisplay_subcat_page_cv=\ndisplay_category_icon_image_cv=\ncategory_image_ordering_cv=\ndisplay_back_button_cv=\ndisplay_categories_back_button_cv=\ncategories_columns_cv=\ndisplay_image_categories_cv=\nimage_categories_size_cv=\ncategories_columns=\ndisplay_image_categories=\nimage_categories_size=\ncategories_image_ordering=\ndisplay_subcategories=\ndisplay_empty_categories=\nhide_categories=\ndisplay_access_category=\ndefault_pagination_categories=\npagination_categories=\ndetail_window=\ndetail_window_background_color=\nmodal_box_overlay_color=\nmodal_box_overlay_opacity=\nmodal_box_border_color=\nmodal_box_border_width=\nsb_slideshow_delay=\nsb_lang=\nhighslide_class=\nhighslide_opacity=\nhighslide_outline_type=\nhighslide_fullimg=\nhighslide_close_button=\nhighslide_slideshow=\njak_slideshow_delay=\njak_orientation=\njak_description=\njak_description_height=\ndisplay_description_detail=\ndisplay_title_description=\nfont_size_desc=\nfont_color_desc=\ndescription_detail_height=\ndescription_lightbox_font_size=\ndescription_lightbox_font_color=\ndescription_lightbox_bg_color=\nslideshow_delay=\nslideshow_pause=\nslideshow_random=\ndetail_buttons=\nphocagallery_width=\nphocagallery_center=\ndisplay_phoca_info=\ncategory_ordering=\nimage_ordering=\nenable_piclens=\nstart_piclens=\npiclens_image=\nswitch_image=\nswitch_width=\nswitch_height=\nenable_overlib=\nol_bg_color=\nol_fg_color=\nol_tf_color=\nol_cf_color=\noverlib_overlay_opacity=\ncreate_watermark=\nwatermark_position_x=\nwatermark_position_y=\ndisplay_icon_vm=\nenable_user_cp=\nmax_create_cat_char=\ndisplay_rating=\ndisplay_rating_img=\ndisplay_comment=\ncomment_width=\nmax_comment_char=\ndisplay_category_statistics=\ndisplay_main_cat_stat=\ndisplay_lastadded_cat_stat=\ncount_lastadded_cat_stat=\ndisplay_mostviewed_cat_stat=\ncount_mostviewed_cat_stat=\ndisplay_camera_info=\nexif_information=\ngoogle_maps_api_key=\ndisplay_categories_geotagging=\ncategories_lng=\ncategories_lat=\ncategories_zoom=\ncategories_map_width=\ncategories_map_height=\ndisplay_icon_geotagging=\ndisplay_category_geotagging=\ncategory_map_width=\ncategory_map_height=\ndisplay_title_upload=\ndisplay_description_upload=\nmax_upload_char=\nupload_maxsize=\ncat_folder_maxsize=\nenable_java=\njava_resize_width=\njava_resize_height=\njava_box_width=\njava_box_height=\npagination_thumbnail_creation=\nclean_thumbnails=\nenable_thumb_creation=\ncrop_thumbnail=\njpeg_quality=\nicon_format=\nlarge_image_width=\nlarge_image_height=\nmedium_image_width=\nmedium_image_height=\nsmall_image_width=\nsmall_image_height=\nfront_modal_box_width=\nfront_modal_box_height=\nadmin_modal_box_width=\nadmin_modal_box_height=\nfolder_permissions=\njfile_thumbs=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);
INSERT INTO `jos_menu` (`id`, `menutype`, `name`, `alias`, `link`, `type`, `published`, `parent`, `componentid`, `sublevel`, `ordering`, `checked_out`, `checked_out_time`, `pollid`, `browserNav`, `access`, `utaccess`, `params`, `lft`, `rgt`, `home`) VALUES (15, 'knowledgebase', 'DIrect Tax Basics', 'direct-tax-basics', 'index.php?option=com_content&view=article&id=6', 'component', 1, 3, 20, 1, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, 'show_noauth=\nshow_title=\nlink_titles=\nshow_intro=\nshow_section=\nlink_section=\nshow_category=\nlink_category=\nshow_author=\nshow_create_date=\nshow_modify_date=\nshow_item_navigation=\nshow_readmore=\nshow_vote=\nshow_icons=\nshow_pdf_icon=\nshow_print_icon=\nshow_email_icon=\nshow_hits=\nfeed_summary=\npage_title=\nshow_page_title=1\npageclass_sfx=\nmenu_image=-1\nsecure=0\n\n', 0, 0, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table `jos_menu_types`
-- 

INSERT INTO `jos_menu_types` (`id`, `menutype`, `title`, `description`) VALUES (1, 'knowledgebase', 'Knowledge Home', 'The main menu for the site');
INSERT INTO `jos_menu_types` (`id`, `menutype`, `title`, `description`) VALUES (4, 'funmenu', 'Relax', 'Browse to relax');
INSERT INTO `jos_menu_types` (`id`, `menutype`, `title`, `description`) VALUES (3, 'chartereds', 'Chartereds Forum', 'About Chartered''s Forum');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

-- 
-- Dumping data for table `jos_modules`
-- 

INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (1, 'Knowledge Base', '', 2, 'left', 62, '2009-09-24 20:22:58', 1, 'mod_mainmenu', 0, 0, 0, 'menutype=knowledgebase\nmenu_style=list\nstartLevel=0\nendLevel=0\nshowAllChildren=0\nwindow_open=\nshow_whitespace=0\ncache=1\ntag_id=\nclass_sfx=\nmoduleclass_sfx=_menu\nmaxdepth=10\nmenu_images=0\nmenu_images_align=0\nmenu_images_link=0\nexpand_menu=0\nactivate_parent=0\nfull_active_id=0\nindent_image=0\nindent_image1=\nindent_image2=\nindent_image3=\nindent_image4=\nindent_image5=\nindent_image6=\nspacer=\nend_spacer=\n\n', 1, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (2, 'Login', '', 1, 'login', 0, '0000-00-00 00:00:00', 1, 'mod_login', 0, 0, 1, '', 1, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (3, 'Popular', '', 3, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_popular', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (4, 'Recent added Articles', '', 4, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_latest', 0, 2, 1, 'ordering=c_dsc\nuser_id=0\ncache=0\n\n', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (5, 'Menu Stats', '', 5, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_stats', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (6, 'Unread Messages', '', 1, 'header', 0, '0000-00-00 00:00:00', 1, 'mod_unread', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (7, 'Online Users', '', 2, 'header', 0, '0000-00-00 00:00:00', 1, 'mod_online', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (8, 'Toolbar', '', 1, 'toolbar', 0, '0000-00-00 00:00:00', 1, 'mod_toolbar', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (9, 'Quick Icons', '', 1, 'icon', 0, '0000-00-00 00:00:00', 1, 'mod_quickicon', 0, 2, 1, '', 1, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (10, 'Logged in Users', '', 2, 'cpanel', 0, '0000-00-00 00:00:00', 1, 'mod_logged', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (11, 'Footer', '', 0, 'footer', 0, '0000-00-00 00:00:00', 1, 'mod_footer', 0, 0, 1, '', 1, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (12, 'Admin Menu', '', 1, 'menu', 0, '0000-00-00 00:00:00', 1, 'mod_menu', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (13, 'Admin SubMenu', '', 1, 'submenu', 0, '0000-00-00 00:00:00', 1, 'mod_submenu', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (14, 'User Status', '', 1, 'status', 0, '0000-00-00 00:00:00', 1, 'mod_status', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (15, 'Title', '', 1, 'title', 0, '0000-00-00 00:00:00', 1, 'mod_title', 0, 2, 1, '', 0, 1, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (16, 'Chartered''s Forum', '', 0, 'user2', 62, '2010-01-12 22:58:28', 1, 'mod_mainmenu', 0, 0, 0, 'menutype=chartereds\nmenu_style=list\nstartLevel=0\nendLevel=0\nshowAllChildren=1\nwindow_open=\nshow_whitespace=0\ncache=1\ntag_id=\nclass_sfx=\nmoduleclass_sfx=_menu\nmaxdepth=10\nmenu_images=0\nmenu_images_align=1\nmenu_images_link=0\nexpand_menu=0\nactivate_parent=0\nfull_active_id=0\nindent_image=0\nindent_image1=\nindent_image2=\nindent_image3=\nindent_image4=\nindent_image5=\nindent_image6=\nspacer=\\|\nend_spacer=\\|\n\n', 0, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (17, 'AdBrite', '', 0, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_adbrite', 0, 0, 0, 'js_adtype=2\nb_sid=\nb_zsid=\nb_title_color=0000FF\nb_text_color=000000\nb_url_color=008000\nb_bg_color=FFFFFF\nb_border_color=FFFFFF\nt_sid=\nt_headline_weight=bold\nt_headline_size=10\nt_headline_face=Arial\nt_headline_decoration=underline\nt_headline_color=0000FF\nt_text_weight=normal\nt_text_size=10\nt_text_face=Arial\nt_text_decoration=none\nt_text_color=000000\njs_adbrite_link=1\njs_adbrite_target=_blank\njs_adbrite_link_css=font-weight:bold;font-family:Arial;font-size:12px;\njs_adbrite_link_text=<a href="http://www.bharatmatrimony.com/register/addmatrimony.php?aff=sundeep.753" target="_blank" border="0"><img src="http://imgs.bharatmatrimony.com/matrimoney/matrimoneybanners/banner72.gif" border=0></a>\njs_attribute=1\nmoduleclass_sfx=\njs_ad_css=text-align:center;\n\n', 0, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (18, 'fun', '', 4, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_mainmenu', 0, 0, 0, 'menutype=chartereds\nmenu_style=list\nstartLevel=0\nendLevel=0\nshowAllChildren=0\nwindow_open=\nshow_whitespace=0\ncache=1\ntag_id=\nclass_sfx=\nmoduleclass_sfx=\nmaxdepth=10\nmenu_images=0\nmenu_images_align=0\nmenu_images_link=0\nexpand_menu=0\nactivate_parent=0\nfull_active_id=0\nindent_image=0\nindent_image1=\nindent_image2=\nindent_image3=\nindent_image4=\nindent_image5=\nindent_image6=\nspacer=\nend_spacer=\n\n', 0, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (19, 'fun_menu', '', 0, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_mainmenu', 0, 0, 1, 'menutype=funmenu', 0, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (23, 'Google Ads (bottom)', '', 0, 'breadcrumb', 0, '0000-00-00 00:00:00', 0, 'mod_adsense_joomlaspan_3_Regular', 0, 0, 0, 'moduleclass_sfx=\njoomlaspan_ad_css=text-align:center;\njoomlaspan_ad_client=7647201708831718\njoomlaspan_ad_channel=\njoomlaspan_ad_type=text\njoomlaspan_ad_uifeatures=6\njoomlaspan_ad_format=728x15_0ads_al\njoomlaspan_color_border=D5D5D5\njoomlaspan_color_bg=FFFFFF\njoomlaspan_color_link=0033FF\njoomlaspan_color_text=333333\njoomlaspan_color_url=008000\njoomlaspan_alternate_ad_url=\njoomlaspan_alternate_color=\n\n', 0, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (20, 'Google Ads', '', 2, 'breadcrumb', 62, '2010-01-05 18:21:55', 1, 'mod_adsense_joomlaspan_3_Regular', 0, 0, 0, 'moduleclass_sfx=\njoomlaspan_ad_css=text-align:center;\njoomlaspan_ad_client=7647201708831718\njoomlaspan_ad_channel=\njoomlaspan_ad_type=text\njoomlaspan_ad_uifeatures=6\njoomlaspan_ad_format=728x15_0ads_al\njoomlaspan_color_border=D5D5D5\njoomlaspan_color_bg=FFFFFF\njoomlaspan_color_link=0033FF\njoomlaspan_color_text=333333\njoomlaspan_color_url=008000\njoomlaspan_alternate_ad_url=\njoomlaspan_alternate_color=\n\n', 0, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (21, 'Sponsored Links', '', 6, 'left', 0, '0000-00-00 00:00:00', 0, 'mod_adsense_joomlaspan_3_ClickSafe', 0, 0, 1, '@spacer=IP Block and other advanced optional features are included in Advanced Parameters below\njoomlaspan_ad_css=text-align:center;\njoomlaspan_ad_type=text_image\njoomlaspan_ad_uifeatures=6\njoomlaspan_ad_format=120x240_as\n@spacer= \njoomlaspan_color_border1=D5D5D5\njoomlaspan_color_bg1=FFFFFF\njoomlaspan_color_link1=0033FF\njoomlaspan_color_text1=333333\njoomlaspan_color_url1=008000\n', 0, 0, '');
INSERT INTO `jos_modules` (`id`, `title`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `published`, `module`, `numnews`, `access`, `showtitle`, `params`, `iscore`, `client_id`, `control`) VALUES (22, 'Chartereds Forum', '', 3, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_adsense_joomlaspan_3_ClickSafe', 0, 0, 0, 'moduleclass_sfx=\njoomlaspan_ad_css=text-align:center;\njoomlaspan_ad_client=7647201708831718\njoomlaspan_ad_channel=\njoomlaspan_ad_type=text_image\njoomlaspan_ad_uifeatures=6\njoomlaspan_ad_format=120x240_as\njoomlaspan_color_border1=D5D5D5\njoomlaspan_color_bg1=FFFFFF\njoomlaspan_color_link1=0033FF\njoomlaspan_color_text1=333333\njoomlaspan_color_url1=008000\njoomlaspan_ip_block1=\njoomlaspan_ip_block2=\njoomlaspan_ip_block3=\njoomlaspan_ip_block4=\njoomlaspan_ip_block5=\nip_block_alt_code=\njoomlaspan_alternate_ad_url=\njoomlaspan_alternate_color=\njoomlaspan_color_border2=\njoomlaspan_color_border3=\njoomlaspan_color_border4=\njoomlaspan_color_bg2=\njoomlaspan_color_bg3=\njoomlaspan_color_bg4=\njoomlaspan_color_link2=\njoomlaspan_color_link3=\njoomlaspan_color_link4=\njoomlaspan_color_text2=\njoomlaspan_color_text3=\njoomlaspan_color_text4=\njoomlaspan_color_url2=\njoomlaspan_color_url3=\njoomlaspan_color_url4=\n\n', 0, 0, '');

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

INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (1, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (16, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (17, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (18, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (19, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (20, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (21, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (22, 0);
INSERT INTO `jos_modules_menu` (`moduleid`, `menuid`) VALUES (23, 0);

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
-- Table structure for table `jos_phocagallery`
-- 

CREATE TABLE `jos_phocagallery` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `sid` int(11) NOT NULL default '0',
  `title` varchar(250) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `filename` varchar(250) NOT NULL default '',
  `description` text,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` int(11) NOT NULL default '0',
  `latitude` varchar(20) NOT NULL default '',
  `longitude` varchar(20) NOT NULL default '',
  `zoom` int(3) NOT NULL default '0',
  `geotitle` varchar(255) NOT NULL default '',
  `videocode` text,
  `vmproductid` int(11) NOT NULL default '0',
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `params` text,
  `extlink1` text,
  `extlink2` text,
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`,`published`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `jos_phocagallery`
-- 

INSERT INTO `jos_phocagallery` (`id`, `catid`, `sid`, `title`, `alias`, `filename`, `description`, `date`, `hits`, `latitude`, `longitude`, `zoom`, `geotitle`, `videocode`, `vmproductid`, `published`, `checked_out`, `checked_out_time`, `ordering`, `params`, `extlink1`, `extlink2`) VALUES (1, 1, 0, 'bhumika_chawla_actress_-_hot_picture_20090903_1141592034400x600', 'bhumikachawlaactress-hotpicture200909031141592034400x600', 'bhumika_chawla_actress_-_hot_picture_20090903_1141592034400x600.jpg', NULL, '2009-09-19 08:53:02', 34, '', '', 0, '', NULL, 0, 1, 0, '0000-00-00 00:00:00', 1, NULL, NULL, NULL);
INSERT INTO `jos_phocagallery` (`id`, `catid`, `sid`, `title`, `alias`, `filename`, `description`, `date`, `hits`, `latitude`, `longitude`, `zoom`, `geotitle`, `videocode`, `vmproductid`, `published`, `checked_out`, `checked_out_time`, `ordering`, `params`, `extlink1`, `extlink2`) VALUES (2, 1, 0, 'bhumika_chawla_actress_-_hot_picture_20090903_1141592034400x600', 'bhumikachawlaactress-hotpicture200909031141592034400x600', 'bhumika_chawla_actress_-_hot_picture_20090903_1141592034400x600.jpg', NULL, '2009-09-19 08:56:09', 30, '', '', 0, '', NULL, 0, 1, 0, '0000-00-00 00:00:00', 2, NULL, NULL, NULL);
INSERT INTO `jos_phocagallery` (`id`, `catid`, `sid`, `title`, `alias`, `filename`, `description`, `date`, `hits`, `latitude`, `longitude`, `zoom`, `geotitle`, `videocode`, `vmproductid`, `published`, `checked_out`, `checked_out_time`, `ordering`, `params`, `extlink1`, `extlink2`) VALUES (3, 1, 0, 'bhumika_chawla_actress_-_hot_picture_20090903_10508745131400x600', 'bhumikachawlaactress-hotpicture2009090310508745131400x600', 'bhumika_chawla_actress_-_hot_picture_20090903_10508745131400x600.jpg', NULL, '2009-09-19 08:56:09', 15, '', '', 0, '', NULL, 0, 1, 0, '0000-00-00 00:00:00', 3, NULL, NULL, NULL);
INSERT INTO `jos_phocagallery` (`id`, `catid`, `sid`, `title`, `alias`, `filename`, `description`, `date`, `hits`, `latitude`, `longitude`, `zoom`, `geotitle`, `videocode`, `vmproductid`, `published`, `checked_out`, `checked_out_time`, `ordering`, `params`, `extlink1`, `extlink2`) VALUES (4, 1, 0, 'bhumika_chawla_actress_-_hot_picture_20090903_10706277011400x600', 'bhumikachawlaactress-hotpicture2009090310706277011400x600', 'bhumika_chawla_actress_-_hot_picture_20090903_10706277011400x600.jpg', NULL, '2009-09-19 08:56:09', 22, '', '', 0, '', NULL, 0, 1, 0, '0000-00-00 00:00:00', 4, NULL, NULL, NULL);
INSERT INTO `jos_phocagallery` (`id`, `catid`, `sid`, `title`, `alias`, `filename`, `description`, `date`, `hits`, `latitude`, `longitude`, `zoom`, `geotitle`, `videocode`, `vmproductid`, `published`, `checked_out`, `checked_out_time`, `ordering`, `params`, `extlink1`, `extlink2`) VALUES (5, 1, 0, 'bhumika_chawla_actress_-_hot_picture_20090903_10773364201400x600', 'bhumikachawlaactress-hotpicture2009090310773364201400x600', 'bhumika_chawla_actress_-_hot_picture_20090903_10773364201400x600.jpg', NULL, '2009-09-19 08:56:09', 25, '', '', 0, '', NULL, 0, 1, 0, '0000-00-00 00:00:00', 5, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_phocagallery_categories`
-- 

CREATE TABLE `jos_phocagallery_categories` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `image` varchar(255) NOT NULL default '',
  `section` varchar(50) NOT NULL default '',
  `image_position` varchar(30) NOT NULL default '',
  `description` text,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `editor` varchar(50) default NULL,
  `ordering` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `count` int(11) NOT NULL default '0',
  `hits` int(11) NOT NULL default '0',
  `accessuserid` text,
  `uploaduserid` text,
  `deleteuserid` text,
  `userfolder` text,
  `latitude` varchar(20) NOT NULL default '',
  `longitude` varchar(20) NOT NULL default '',
  `zoom` int(3) NOT NULL default '0',
  `geotitle` varchar(255) NOT NULL default '',
  `params` text,
  PRIMARY KEY  (`id`),
  KEY `cat_idx` (`section`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `jos_phocagallery_categories`
-- 

INSERT INTO `jos_phocagallery_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `date`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `hits`, `accessuserid`, `uploaduserid`, `deleteuserid`, `userfolder`, `latitude`, `longitude`, `zoom`, `geotitle`, `params`) VALUES (1, 2, 'Bhoomika Chawla', '', 'bhoomikachawla', '', '', 'left', '', '2009-09-19 08:51:12', 1, 0, '0000-00-00 00:00:00', NULL, 1, 0, 0, 64, '0', '-2', '-2', 'bollywood_actress/bhoomika_chawla', '', '', 0, '', NULL);
INSERT INTO `jos_phocagallery_categories` (`id`, `parent_id`, `title`, `name`, `alias`, `image`, `section`, `image_position`, `description`, `date`, `published`, `checked_out`, `checked_out_time`, `editor`, `ordering`, `access`, `count`, `hits`, `accessuserid`, `uploaduserid`, `deleteuserid`, `userfolder`, `latitude`, `longitude`, `zoom`, `geotitle`, `params`) VALUES (2, 0, 'Bollywood Actress', '', 'bollywoodactress', '', '', 'left', '', '2009-09-19 09:26:13', 1, 0, '0000-00-00 00:00:00', NULL, 2, 0, 0, 16, '0', '62', '62', 'bollywood_actress', '', '', 0, '', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `jos_phocagallery_comments`
-- 

CREATE TABLE `jos_phocagallery_comments` (
  `id` int(11) NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `userid` int(11) NOT NULL default '0',
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `title` varchar(255) NOT NULL default '',
  `comment` text,
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `params` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_phocagallery_comments`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_phocagallery_img_votes`
-- 

CREATE TABLE `jos_phocagallery_img_votes` (
  `id` int(11) NOT NULL auto_increment,
  `imgid` int(11) NOT NULL default '0',
  `userid` int(11) NOT NULL default '0',
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `rating` tinyint(1) NOT NULL default '0',
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `params` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_phocagallery_img_votes`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_phocagallery_img_votes_statistics`
-- 

CREATE TABLE `jos_phocagallery_img_votes_statistics` (
  `id` int(11) NOT NULL auto_increment,
  `imgid` int(11) NOT NULL default '0',
  `count` tinyint(11) NOT NULL default '0',
  `average` float(8,6) NOT NULL default '0.000000',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_phocagallery_img_votes_statistics`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_phocagallery_user_category`
-- 

CREATE TABLE `jos_phocagallery_user_category` (
  `id` int(11) NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `userid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_phocagallery_user_category`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_phocagallery_votes`
-- 

CREATE TABLE `jos_phocagallery_votes` (
  `id` int(11) NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `userid` int(11) NOT NULL default '0',
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `rating` tinyint(1) NOT NULL default '0',
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `params` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_phocagallery_votes`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `jos_phocagallery_votes_statistics`
-- 

CREATE TABLE `jos_phocagallery_votes_statistics` (
  `id` int(11) NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `count` tinyint(11) NOT NULL default '0',
  `average` float(8,6) NOT NULL default '0.000000',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `jos_phocagallery_votes_statistics`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

-- 
-- Dumping data for table `jos_plugins`
-- 

INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (1, 'Authentication - Joomla', 'joomla', 'authentication', 0, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (2, 'Authentication - LDAP', 'ldap', 'authentication', 0, 2, 0, 1, 0, 0, '0000-00-00 00:00:00', 'host=\nport=389\nuse_ldapV3=0\nnegotiate_tls=0\nno_referrals=0\nauth_method=bind\nbase_dn=\nsearch_string=\nusers_dn=\nusername=\npassword=\nldap_fullname=fullName\nldap_email=mail\nldap_uid=uid\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (3, 'Authentication - GMail', 'gmail', 'authentication', 0, 4, 0, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (4, 'Authentication - OpenID', 'openid', 'authentication', 0, 3, 0, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (5, 'User - Joomla!', 'joomla', 'user', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', 'autoregister=1\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (6, 'Search - Content', 'content', 'search', 0, 1, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\nsearch_content=1\nsearch_uncategorised=1\nsearch_archived=1\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (7, 'Search - Contacts', 'contacts', 'search', 0, 3, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (8, 'Search - Categories', 'categories', 'search', 0, 4, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (9, 'Search - Sections', 'sections', 'search', 0, 5, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (10, 'Search - Newsfeeds', 'newsfeeds', 'search', 0, 6, 1, 0, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (11, 'Search - Weblinks', 'weblinks', 'search', 0, 2, 1, 1, 0, 0, '0000-00-00 00:00:00', 'search_limit=50\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (12, 'Content - Pagebreak', 'pagebreak', 'content', 0, 10000, 1, 1, 0, 0, '0000-00-00 00:00:00', 'enabled=1\ntitle=1\nmultipage_toc=1\nshowall=1\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (13, 'Content - Rating', 'vote', 'content', 0, 4, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (14, 'Content - Email Cloaking', 'emailcloak', 'content', 0, 5, 1, 0, 0, 0, '0000-00-00 00:00:00', 'mode=1\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (15, 'Content - Code Hightlighter (GeSHi)', 'geshi', 'content', 0, 5, 0, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (16, 'Content - Load Module', 'loadmodule', 'content', 0, 6, 1, 0, 0, 0, '0000-00-00 00:00:00', 'enabled=1\nstyle=0\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (17, 'Content - Page Navigation', 'pagenavigation', 'content', 0, 2, 1, 1, 0, 0, '0000-00-00 00:00:00', 'position=1\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (18, 'Editor - No Editor', 'none', 'editors', 0, 0, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (19, 'Editor - TinyMCE', 'tinymce', 'editors', 0, 0, 1, 1, 0, 0, '0000-00-00 00:00:00', 'mode=extended\nskin=1\ncompressed=0\ncleanup_startup=0\ncleanup_save=2\nentity_encoding=raw\nlang_mode=0\nlang_code=en\ntext_direction=ltr\ncontent_css=1\ncontent_css_custom=\nrelative_urls=1\nnewlines=0\ninvalid_elements=applet\nextended_elements=\ntoolbar=top\ntoolbar_align=left\nhtml_height=550\nhtml_width=750\nelement_path=1\nfonts=1\npaste=1\nsearchreplace=1\ninsertdate=1\nformat_date=%Y-%m-%d\ninserttime=1\nformat_time=%H:%M:%S\ncolors=1\ntable=1\nsmilies=1\nmedia=1\nhr=1\ndirectionality=1\nfullscreen=1\nstyle=1\nlayer=1\nxhtmlxtras=0\nvisualchars=1\nnonbreaking=1\ntemplate=0\ntinybrowser=1\nadvimage=1\nadvlink=1\nautosave=0\ncontextmenu=1\ninlinepopups=1\nsafari=0\ncustom_plugin=\ncustom_button=\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (20, 'Editor - XStandard Lite 2.0', 'xstandard', 'editors', 0, 0, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (21, 'Editor Button - Image', 'image', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (22, 'Editor Button - Pagebreak', 'pagebreak', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (23, 'Editor Button - Readmore', 'readmore', 'editors-xtd', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (24, 'XML-RPC - Joomla', 'joomla', 'xmlrpc', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (25, 'XML-RPC - Blogger API', 'blogger', 'xmlrpc', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', 'catid=1\nsectionid=0\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (27, 'System - SEF', 'sef', 'system', 0, 1, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (28, 'System - Debug', 'debug', 'system', 0, 2, 1, 0, 0, 0, '0000-00-00 00:00:00', 'queries=1\nmemory=1\nlangauge=1\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (29, 'System - Legacy', 'legacy', 'system', 0, 3, 0, 1, 0, 0, '0000-00-00 00:00:00', 'route=0\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (30, 'System - Cache', 'cache', 'system', 0, 4, 0, 1, 0, 0, '0000-00-00 00:00:00', 'browsercache=0\ncachetime=15\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (31, 'System - Log', 'log', 'system', 0, 5, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (32, 'System - Remember Me', 'remember', 'system', 0, 6, 1, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (33, 'System - Backlink', 'backlink', 'system', 0, 7, 0, 1, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (34, 'Content - Core Design Web Gallery plugin', 'cdwebgallery', 'content', 0, 0, 1, 0, 0, 62, '2009-12-28 16:47:22', 'integration=cdwebgallery\ntheme=default\nengine=popup\ndisplay_gal_title=0\ndisplay_alt=1\nthumb_output=JPG\nthumb_height=100\nthumb_width=100\njpg_quality=70\nwatermark=no\nwatermark_image=magnify.png\nwatermark_valign=BOTTOM\nwatermark_halign=RIGHT\n\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (35, 'googleAds', 'googleads', 'content', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', '');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (36, 'Simple Image Gallery Plugin', 'jwsig', 'content', 0, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 'th_width=200\nth_height=200\nth_quality=80\ndisplaynavtip=1\nnavtip=Navigation tip: Hover mouse on top of the right or left side of the image to see the next or previous image respectively.\ndisplaymessage=1\nmessage=You are browsing images from the article:\n');
INSERT INTO `jos_plugins` (`id`, `name`, `element`, `folder`, `access`, `ordering`, `published`, `iscore`, `client_id`, `checked_out`, `checked_out_time`, `params`) VALUES (37, 'Content - Article Table of Contents', 'toc', 'content', 0, 0, 1, 0, 0, 0, '0000-00-00 00:00:00', 'enabled=1\naddNumbering=0\naddToc=1\nindentToc=1\ndisplayToc=table\n\n');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `jos_sections`
-- 

INSERT INTO `jos_sections` (`id`, `title`, `name`, `alias`, `image`, `scope`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `ordering`, `access`, `count`, `params`) VALUES (1, 'Knowledge Base', '', 'knowledge-base', 'articles.jpg', 'content', 'left', '', 1, 0, '0000-00-00 00:00:00', 1, 0, 2, '');
INSERT INTO `jos_sections` (`id`, `title`, `name`, `alias`, `image`, `scope`, `image_position`, `description`, `published`, `checked_out`, `checked_out_time`, `ordering`, `access`, `count`, `params`) VALUES (2, 'News', '', 'news', 'web_links.jpg', 'content', 'left', '', 1, 0, '0000-00-00 00:00:00', 2, 0, 0, '');

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

INSERT INTO `jos_session` (`username`, `time`, `session_id`, `guest`, `userid`, `usertype`, `gid`, `client_id`, `data`) VALUES ('', '1264587615', '49168e0e02aa20984050a23176254e3a', 1, 0, '', 0, 0, '__default|a:7:{s:15:"session.counter";i:3;s:19:"session.timer.start";i:1264587605;s:18:"session.timer.last";i:1264587610;s:17:"session.timer.now";i:1264587615;s:22:"session.client.browser";s:66:"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1) Opera 7.54 [en]";s:8:"registry";O:9:"JRegistry":3:{s:17:"_defaultNameSpace";s:7:"session";s:9:"_registry";a:1:{s:7:"session";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:4:"user";O:5:"JUser":19:{s:2:"id";i:0;s:4:"name";N;s:8:"username";N;s:5:"email";N;s:8:"password";N;s:14:"password_clear";s:0:"";s:8:"usertype";N;s:5:"block";N;s:9:"sendEmail";i:0;s:3:"gid";i:0;s:12:"registerDate";N;s:13:"lastvisitDate";N;s:10:"activation";N;s:6:"params";N;s:3:"aid";i:0;s:5:"guest";i:1;s:7:"_params";O:10:"JParameter":7:{s:4:"_raw";s:0:"";s:4:"_xml";N;s:9:"_elements";a:0:{}s:12:"_elementPath";a:1:{i:0;s:100:"/customers/charteredsforum.com/charteredsforum.com/httpd.www/libraries/joomla/html/parameter/element";}s:17:"_defaultNameSpace";s:8:"_default";s:9:"_registry";a:1:{s:8:"_default";a:1:{s:4:"data";O:8:"stdClass":0:{}}}s:7:"_errors";a:0:{}}s:9:"_errorMsg";N;s:7:"_errors";a:0:{}}}');

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

INSERT INTO `jos_templates_menu` (`template`, `menuid`, `client_id`) VALUES ('siteground-j15-94', 0, 0);
INSERT INTO `jos_templates_menu` (`template`, `menuid`, `client_id`) VALUES ('khepri', 0, 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=63 ;

-- 
-- Dumping data for table `jos_users`
-- 

INSERT INTO `jos_users` (`id`, `name`, `username`, `email`, `password`, `usertype`, `block`, `sendEmail`, `gid`, `registerDate`, `lastvisitDate`, `activation`, `params`) VALUES (62, 'Administrator', 'admin', 'sundeep.techie@gmail.com', 'ae8dc7d42df1a886ca3271f43b99685d:tVmT3sBrfL5SZ8W8tehqFAMa95W9MdJJ', 'Super Administrator', 0, 1, 25, '2009-07-11 11:31:22', '2010-01-12 22:35:50', '', '');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table `jos_weblinks`
-- 

INSERT INTO `jos_weblinks` (`id`, `catid`, `sid`, `title`, `alias`, `url`, `description`, `date`, `hits`, `published`, `checked_out`, `checked_out_time`, `ordering`, `archived`, `approved`, `params`) VALUES (1, 2, 0, 'Accounting Standards', 'accounting-standards', 'http://www.pdicai.org/bareAct.aspx', '', '2009-07-11 10:56:21', 65, 1, 0, '0000-00-00 00:00:00', 1, 0, 1, 'target=1\n\n');
INSERT INTO `jos_weblinks` (`id`, `catid`, `sid`, `title`, `alias`, `url`, `description`, `date`, `hits`, `published`, `checked_out`, `checked_out_time`, `ordering`, `archived`, `approved`, `params`) VALUES (2, 2, 0, 'Accounting Standards Interpretation', 'accounting-standards-interpretation', 'http://www.icai.org/icairoot/resources/asi_index.jsp', '', '2009-07-11 11:00:04', 68, 1, 0, '0000-00-00 00:00:00', 2, 0, 1, 'target=1\n\n');
INSERT INTO `jos_weblinks` (`id`, `catid`, `sid`, `title`, `alias`, `url`, `description`, `date`, `hits`, `published`, `checked_out`, `checked_out_time`, `ordering`, `archived`, `approved`, `params`) VALUES (3, 4, 0, 'Tax Audit form 3CD', 'tax-audit-form-3cd', 'http://incometaxindia.gov.in/forms/3cd.pdf', '', '2009-07-11 11:16:27', 25, 1, 0, '0000-00-00 00:00:00', 1, 0, 1, 'target=2\n\n');

COMMIT;
