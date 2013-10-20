-- phpMyAdmin SQL Dump
-- version 3.4.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 03, 2012 at 04:31 AM
-- Server version: 5.5.20
-- PHP Version: 5.3.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `x2_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `x2_article`
--

CREATE TABLE IF NOT EXISTS `x2_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` varchar(5000) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `modifiedtime` int(10) unsigned NOT NULL,
  `visits` int(10) unsigned NOT NULL,
  `published` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `x2_article`
--

INSERT INTO `x2_article` (`id`, `user_id`, `title`, `text`, `createtime`, `modifiedtime`, `visits`, `published`) VALUES
(1, 1, 'Sundeep', 'This artcle is last updated on 1 Jan 2013', 1340441826, 1343024220, 0, 0),
(8, 1, 'New Article for approval', 'From sundeep, harsha and abeer for testing tags', 1340445444, 1340445444, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `x2_article_approval`
--

CREATE TABLE IF NOT EXISTS `x2_article_approval` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(10) unsigned NOT NULL,
  `submittime` int(10) unsigned NOT NULL,
  `approver_id` int(10) unsigned DEFAULT NULL,
  `approvetime` int(10) unsigned DEFAULT NULL,
  `approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`,`approver_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `x2_article_approval`
--

INSERT INTO `x2_article_approval` (`id`, `article_id`, `submittime`, `approver_id`, `approvetime`, `approved`) VALUES
(1, 8, 1340445444, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `x2_article_comment`
--

CREATE TABLE IF NOT EXISTS `x2_article_comment` (
  `id` int(10) unsigned NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `text` varchar(300) NOT NULL,
  `published` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `x2_article_comment_approval`
--

CREATE TABLE IF NOT EXISTS `x2_article_comment_approval` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` int(10) unsigned NOT NULL,
  `submittime` int(10) unsigned NOT NULL,
  `approver_id` int(10) unsigned NOT NULL,
  `approvetime` int(10) unsigned NOT NULL,
  `approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_id` (`comment_id`,`approver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_article_rating`
--

CREATE TABLE IF NOT EXISTS `x2_article_rating` (
  `id` int(10) unsigned NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `rating` int(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `x2_auth_assignment`
--

CREATE TABLE IF NOT EXISTS `x2_auth_assignment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemname` varchar(64) DEFAULT NULL,
  `userid` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `bizrule` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `restaurant_id` (`itemname`,`userid`,`role_id`),
  KEY `role_id` (`role_id`),
  KEY `user_id` (`userid`),
  KEY `restaurant_id_2` (`itemname`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `x2_auth_assignment`
--

INSERT INTO `x2_auth_assignment` (`id`, `itemname`, `userid`, `role_id`, `bizrule`) VALUES
(1, 'viewRestaurantMenu', 2, 1, ''),
(2, '1', 2, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `x2_auth_item`
--

CREATE TABLE IF NOT EXISTS `x2_auth_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `type` int(2) unsigned NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `bizrule` varchar(300) DEFAULT NULL,
  `data` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `x2_auth_item`
--

INSERT INTO `x2_auth_item` (`id`, `name`, `type`, `description`, `bizrule`, `data`) VALUES
(1, 'viewRestaurantMenu', 1, 'view the restaurant menu', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `x2_auth_item_child`
--

CREATE TABLE IF NOT EXISTS `x2_auth_item_child` (
  `parent` int(10) unsigned NOT NULL,
  `child` int(10) unsigned NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `x2_city`
--

CREATE TABLE IF NOT EXISTS `x2_city` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_city`
--

INSERT INTO `x2_city` (`id`, `name`) VALUES
(1, 'bangalore'),
(0, 'Hyderabad');

-- --------------------------------------------------------

--
-- Table structure for table `x2_coupon`
--

CREATE TABLE IF NOT EXISTS `x2_coupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(300) NOT NULL,
  `start_date` int(12) unsigned NOT NULL,
  `end_date` int(12) unsigned NOT NULL,
  `create_time` int(12) unsigned NOT NULL,
  `modified_time` int(12) unsigned NOT NULL,
  `modified_by` int(10) unsigned NOT NULL,
  `published` tinyint(1) NOT NULL,
  `discount_type` int(10) unsigned NOT NULL,
  `discount_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `published` (`published`,`discount_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_coupon_discount_type`
--

CREATE TABLE IF NOT EXISTS `x2_coupon_discount_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  `description` int(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_coupon_images`
--

CREATE TABLE IF NOT EXISTS `x2_coupon_images` (
  `coupon_id` int(10) unsigned NOT NULL,
  `image_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`coupon_id`,`image_id`),
  UNIQUE KEY `food_item_id` (`coupon_id`),
  KEY `image_id` (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `x2_coupon_redeem`
--

CREATE TABLE IF NOT EXISTS `x2_coupon_redeem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_code_id` int(10) unsigned NOT NULL,
  `redeem_time` int(12) unsigned NOT NULL,
  `redeem_ip` varchar(100) DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_code_id` (`coupon_code_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_coupon_restriction_type`
--

CREATE TABLE IF NOT EXISTS `x2_coupon_restriction_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(30) NOT NULL,
  `description` int(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_coupon_rules`
--

CREATE TABLE IF NOT EXISTS `x2_coupon_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int(10) unsigned NOT NULL,
  `restriction_type` int(10) unsigned NOT NULL,
  `value` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_id` (`coupon_id`,`restriction_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_coupon_track`
--

CREATE TABLE IF NOT EXISTS `x2_coupon_track` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(128) NOT NULL,
  `coupon_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `create_time` int(12) unsigned NOT NULL,
  `email` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_code` (`coupon_code`),
  KEY `coupon_id` (`coupon_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_cusine`
--

CREATE TABLE IF NOT EXISTS `x2_cusine` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_cusine`
--

INSERT INTO `x2_cusine` (`id`, `name`) VALUES
(2, 'Chinese'),
(1, 'South Indian');

-- --------------------------------------------------------

--
-- Table structure for table `x2_entity`
--

CREATE TABLE IF NOT EXISTS `x2_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `x2_entity`
--

INSERT INTO `x2_entity` (`id`, `name`) VALUES
(3, 'food_item'),
(1, 'restaurant'),
(2, 'restaurant_feedback');

-- --------------------------------------------------------

--
-- Table structure for table `x2_entity_attributes`
--

CREATE TABLE IF NOT EXISTS `x2_entity_attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `TYPE` (`type`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_entity_attributes`
--

INSERT INTO `x2_entity_attributes` (`id`, `entity_id`, `name`, `type`) VALUES
(1, 1, 'PARKING', '1'),
(2, 1, 'VEGETARIAN', '1'),
(3, 1, 'DINING', '1'),
(4, 1, 'TAKEAWAY', '1'),
(5, 1, 'DELIVERY', '1'),
(6, 3, 'SPICY', '1'),
(7, 3, 'VEGETARIAN', '3'),
(8, 3, 'PRICE', '1'),
(9, 3, 'SPECIAL', '3'),
(10, 3, 'SERVES', '1'),
(11, 2, 'food_flavor', 'feedback_rating'),
(12, 2, 'food_presentation', 'feedback_rating'),
(13, 2, 'food_valueformoney', 'feedback_rating'),
(14, 2, 'food_choice', 'feedback_rating'),
(15, 2, 'food_freshness', 'feedback_rating'),
(16, 2, 'serve_menu', 'feedback_rating'),
(17, 2, 'serve_timetoserve', 'feedback_rating'),
(18, 2, 'venue_ambience', 'feedback_rating'),
(19, 2, 'venue_cleanliness', 'feedback_rating'),
(20, 2, 'venue_staffpresentation', 'feedback_rating'),
(21, 2, 'wanttoreturn', '3'),
(22, 2, 'willrecommend', '3'),
(23, 2, 'suggestion', '2');

-- --------------------------------------------------------

--
-- Table structure for table `x2_food_item`
--

CREATE TABLE IF NOT EXISTS `x2_food_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` varchar(250) NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NAME` (`name`),
  KEY `CATEGORY_ID` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Contains Food Items list' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `x2_food_item`
--

INSERT INTO `x2_food_item` (`id`, `name`, `description`, `category_id`) VALUES
(1, 'IDLI', 'South Indian Food', 1),
(2, 'Dosa', 'South Indian Food', 1),
(3, 'Paratha', 'North Indian Food', 2),
(4, 'Chole', 'North Indian Food', 2),
(5, 'Dhokla', 'North Indian Food', 2),
(6, 'Pizza', 'Italian Food', 3),
(7, 'Pasta', 'Italian Food', 3),
(8, 'Burger', 'American Food', 4),
(9, 'Sandwitch', 'Healthy Food', 5),
(10, 'Samosa', 'Indian Food', 5);

-- --------------------------------------------------------

--
-- Table structure for table `x2_food_item_category`
--

CREATE TABLE IF NOT EXISTS `x2_food_item_category` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `PARENT_CATEGORY` int(10) unsigned DEFAULT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `PARENT_CATEGORY` (`PARENT_CATEGORY`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `x2_food_item_category`
--

INSERT INTO `x2_food_item_category` (`ID`, `NAME`, `PARENT_CATEGORY`, `DESCRIPTION`) VALUES
(1, 'Indian', NULL, 'All Indian Food dishes are delicious'),
(2, 'South Indian', 1, 'South Indian dishes very yummy!'),
(3, 'North Indian', 1, 'North Indian dishes are too good'),
(4, 'Italian', NULL, 'Pastaz, Pizzas... ummmm'),
(5, 'Diet', NULL, 'Food for your good diet.');

-- --------------------------------------------------------

--
-- Table structure for table `x2_food_item_images`
--

CREATE TABLE IF NOT EXISTS `x2_food_item_images` (
  `food_item_id` int(10) unsigned NOT NULL,
  `image_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`food_item_id`,`image_id`),
  KEY `image_id` (`image_id`),
  KEY `food_item_id` (`food_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_food_item_images`
--

INSERT INTO `x2_food_item_images` (`food_item_id`, `image_id`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `x2_food_item_property_obsolete`
--

CREATE TABLE IF NOT EXISTS `x2_food_item_property_obsolete` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `TYPE` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `TYPE` (`TYPE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `x2_food_item_property_obsolete`
--

INSERT INTO `x2_food_item_property_obsolete` (`ID`, `NAME`, `TYPE`) VALUES
(2, 'SPICY', '1'),
(3, 'VEGETARIAN', '3'),
(4, 'PRICE', '1'),
(5, 'SPECIAL', '3'),
(6, 'SERVES', '1');

-- --------------------------------------------------------

--
-- Table structure for table `x2_image`
--

CREATE TABLE IF NOT EXISTS `x2_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(25) NOT NULL,
  `content` blob NOT NULL,
  `size` varchar(25) NOT NULL,
  `category` varchar(25) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `x2_image`
--

INSERT INTO `x2_image` (`id`, `type`, `content`, `size`, `category`, `name`) VALUES
(1, 'jpg', 0xffd8ffe000104a46494600010100000100010000ffdb00840009060614121115141214141414151517141717171714171417141514151515141417171c261e1719231914151f2f202327292c2c2c151e3135302a35262b2c2901090a0a0e0c0e1a0f0f1a2c241c1c292929292c292c2c292c292c292c29292c2c2c2929292c2c2929292c2c292c29292c2c2c292c292c2c2c292c2c292c292929ffc000110800b7011303012200021101031101ffc4001c0000010501010100000000000000000000020001030406050708ffc40046100002010203040605050f04030100000001020003111221310405064113225161719107324281a12352b1d1f0141516243343535462728292a2c1e11725b2d23563f164ffc400190100030101010000000000000000000000010203000405ffc40032110002020102030409030500000000000000010211031221043151131441f02223325261718191a1b1c1d105153382c2ffda000c03010002110311003f00f2bde0b602554596f79fac24082725ec76c10ea21811c2c2c30597486090d522510a62890e1212ac4a614565121c0926183081807487091ed1b143bcc3d0368ad0af1b14c3215a231628966331031466304b4c62411b148cb412d31ac983888990de3cc6b25c51b1c8818b14d46b25bc5791de2c5351ac97146818a3169804a23c883c35680361c68e233400018c8d9edcfc8c3691b98c89c897efad4f9c7e1f5452a450e844f4a23daec5cdf9651969080f52ec4f693f4c911e6673c1227448ce91d1a2768132d4808f8a0de3831c2a820218b405326a1b3e2b9390f3cfb04563c62e4e9021a106964ec0b975af717cb9771ef84bbbc7ce3f082ceb5c365e855bc7c72eaeeb5b138f3ecb6bfda31dd8bf38fc20b43ae1337429f4904b4e82eeb526c5881db6bfc046fbd83b4fc26b43774cdd0a01a3629d21bad7b48f7092fde74b021cf85b4fae6b41ee79ba1c90634ec0dca9f38f908c9b953f4874ec1af64da907b966e872634eb7de85f9c7ca23b9c7263e536a40ee79bddfd3f939768c44eabee400e4f7efb7d7691b6e7fdbfe9ff335a0774cdee9cd11a74cee6cbd7171ddfe647f7a4fce1e47eb9ad0af85cbee94488c4cbebba89f696fdf90f7939091beec23da53e70da15f0f97dd29031131dd083622c60cc73b15e12340bc1bc285b2c0ad08d595818f8a0a36a2566913182cf00986856c72d14126342259590c9d5a570b69208cce58b2c0782d52451a048a6a24bc2060a986230e8b5b0ec6d55c220258df404e405ce93b1b2ee0aed71d1b8c2b7019585ed6c972d73bf9e738946ab2306562a4684120fc25d5e20ae058557b69cbb6ff004c9cd37ba3a70e678ee96e75470e6d1ce9e1fde641f49937e0e57cc9e8c0b5c93529803c73ca777d152fdd55eaf4f8ab6108402c72bb589bdc765a4bc43b0d2a7b6338164434baa2c416757b29573802d80376e6246ddd33aa3c6e59cb4aae4718f0b54be5528fbded9db3190232f19352e12ae72e9285b5fca1ff00af7fc669f7370d5014fac94cd3c16151c15e9096b838715cdac45c0008395e51df7b9e82b16fc95d6a2917a8d8cbb10b53d62ac16ea3237c85c2d808baadd263478ccce5a6d7d8e52707d4cf155a20db2b39d6e35cb21e1786bc1557535688fe27ff00a4ddf006e6434985518cab950713138705320dc906c715edcae3b265f8cd5536ada556c94c525b8c3722a166c0a99752fcc8ff0030efd430e373cf23c69ad8e67e0b91aed143336d6a664ff0c3adc328331b4d202c2e0e3bdf9dac9a5e4dbb372e37a34ea51a54fa5a6cd498bd462cd845ce12585f4366cb2d7b60db376d1a24530c95d8300c02d31505501462a659482a2d86cc4df326d31d0b3710e5a5495fcbca17e0b9397dd146d7d3e53e3d5f092270a2e77da696995ba4b62e4092b9094b756c546a56a4b428f4989f0d4150a7585ee7aab9534c2733fb3af28fbc765a2b56ad3ab4701e930a0a582c2c6e06136c6b85b2623dad72b423ebe2b569d6b95f2fa72f3b173f04aa0b61abb39be63e5083eebac8df84eb8d0d2395f2aa9cfb6e44b1bb777d1ae7a2c6941c96540541a86a5987cab61b0b92c005230e440ec8779eec08bb460a41d291c06b0ab52eae4a8b95246799c80b5c9b5e632e2389d5a5b8dfcbcfe067e11af95b01c813f294467cc7ae6e3bfe119b85768b58a0ee02a523af61c5355c07bb29d6daaa8a8aaca28d234cadd54a90417c249eb1b67de0cabe913752d2acab418d2ba333127aa02b53cd8dae0758fab992ddf0e975673afea39fb5ec5e9babf1f9f9d8cd370a57cc744c0dae2c69b5cf664f61f1909e1bda87e62af906fef355bbb7053a8fd6a95583bb950951c60a385ad8d70e2438c0cdac08195f48fbc373f40415ace984837666657a585712d201713b9637cb4b676d2037f71cdab4d2fc98ca9b96b8ccd0adef47fec254db361643620db2cecc069fb404f42e08d96aed0efd256365085592fd6575acd719023d55f23db385c63c59b46c5b5d4a14dcb2a843d6bdfaca0919e9ac3b825fd4e6a7a1c775d198cda68e3463617a4035c5bd4b8041edcd81f39ca0669379f1c55af4de9ba5318c58b615c40644e76bf299a023c53f138f2e55924e5543c602318d8a3a2363c6bc6260186856c726098c4c6c5088c7c51402634c2d91557ce3ab489b58423b472c5935e3ac058622d164482482440c916065912470b0043022b28a8f45f42c97da2b0b16ea21b036fce6b7bfdaf3abb56ede9b6eaa18808bb3a330e6e0e055523e68653981719f6e5c9f43097da6af54b7513206df9c19fdbb66af655fc736816c853a047bc907cf08f2f7ce79f3605271949ae85ba5b3749899864d6c239003b469cc7ff643bcb77ab8e8c8eb630f49880c15c8f55830cc666e3b2dd93acf95bc08fea060b1164397aea3fac01efe5234423271768a9e8cd8947c40e2e92a06cce6c3a304e6dfdedfdb8bbf76ba54b79d6a9509b7c8295cb01c59f4952e0e4a545b08bdf3ed9a1e02249ac08f5768aea00b29b064cc816cf31e37bf398be31dd4d5b7b940594b747661a205505989ed0149cbba7456c7760a97113d4e969fe09376ad5ae71ecf7d9b6642ca4f5ce3171903705c9b682c174bceb6c9b8a9a8554a18ed76c554e3d6c0d830c2092068397709d7d93671702df27492c809bdce799ed370493ccb1f7f428818bb800a3dc6df493e52364b2f1326ea3b2f3cfa9506ccf4a9b9f93a61171114d114901493981fb26653817882aef00eb59293b5214ec5910f55f1e44906f62b345c71bc0d2d836861912300fe365a7f4179e77e8af7a745b66036b55529afb43acb6f78b7be4ede993e9e5928a6d6a373bc78468d416c3d035c306a7714cb0b8eb53070f222e083669c21b4d4a5b50a7b7a8a8aee190e26c3619a90c4daa26830b92721ce7a43e76fb647fcccd6f1dcbd2516a77c26ecd45f9a3b2d994f7302548efbcac645f0f12d3d39375f95f503d1d943b6556a44f46d469e152b84a0bd4b2fed0b0b8604838a2f480d8b6dd9e9840e6a164b31b2e1614b16316b95b03e57d44e6fa2052b5eb29398e8c116b1042d5bae7c94dc4ecf157fe53661d8955f9dc61a434b0ecfb0e7d1cb1fd7f60e54a1c63f1a8ffc83ba375222ad2a77e8d4b6336b17726c5af736398b677000116f2d85087a4f734aa5829d703a904100eba768bdc8f1eb6ee00534ee50da58dc866cfbfad20da93e4d89bfa8da6ba72f23398e37396ad57b94fd1ed265da76c56014a145eae69840a983003a00a4653ccfd2b8ff0074ade14ffe027a7f0cd6b6f0da00b005689240eb1c5418dafcc5c65d969e5de957ff00295b5d29ebafa827427b2f3d0adde66df45fa23251888d1ef1acb02635a398d78c2836806485a46c7ed785311824c0261de0c24d8378d0a340207b23530c7a51716cb5d6e3b276686f1d947e64795fe999c27392a88671bf12303574f7d6c9fa01e43ea927e10ecbfab8f21f54caa8920591ec91648d4af13ecdfab8f21253c5b4396cff001992c30d443d944a289a5fc2aa5fa05f3318f1453fd5d3e3f5ccf8115a6d111d6347a87a30dec2b6d0eab4156c8a7a84a93d703337ef9ddd9cb2ed358b1ea9a5430e7a0151c35872397c44c6fa1f17daea0c38af4c657b695179fbe69c3e1dbb69c5eaf434b2be76566d476758fc6426a94a854aa4d7c0d3ed0b90ee257cf21f4caeedd4f7ae9fbcbf542a9b47548f03f45ffb9f7195ea55ea3dbb5187f38938eeac8f893f02b31a9b462b9b6d35c017b596f4c8b69967da61b6c6d52a12d509b961cf42c6c2da1d07c656e04a656b6d20ea769acd60c3204d3b1c8e44dce5e048179d2d8ec59ada8761e4491ff232b35b0d91fac75d00c186f6f9d6efb28fac7c61d31f4fd033f8b40da1f3cb5e5e24ff008bc3d9dac0db3b0cbbcfff004c8dd26c0613d2d6f1b52a342f9b39a8c3b90611fd4cde53cef766f06a3592aaea8c18788cff00b4ed7a43de46aedd505f2a40521d9d5b96feb2d3361a5b0c3d5d3f1dfee77463e8d1f4851ae1c2b0f559430f06008f848da962c40646e0836bd8e77fa7e332fe8eb7e8afb18424e3a16a66fcc6669b0f70b7f0cd3507b3b78629082a5a5f81c735a5d10ee6d9d9369420280cce18a8019ac8fa91ae7de673f88aa7fbb525ff00d358fbc526039765f9fd02fdbddcd7ad4ff79bfe2d385c542dbce83007f27b4039ff00e9161e779d4bfc62e27791dfbaff0073ab8fe4afcdadf40ca2a8bd565b5c05c3e26d98f3bf9c0c7734c0e431dbb94643cec254de5b5e042058b39b004ea0a966fe856339b25a8d2e6f63479fc8afc38e7ef95506f9250d07ff0099ef63cf3b76cccf1df18ad0dbaad33b2d1aa570f5ea038cdd41b1f0bda68b866e77a5626f634e8daddd42c6dcbec279c7a523fee75ff835d7f26b3a294924fcf22b5797fd507fea02fea7b38f006055e3943aec7b39fb784c9c6b43d943a15d26a871bd3d3ee3a3ee024678c295eff72d207f744cbda3111962888e26b071b53fd5d3f9563371b52fd5d3f952649960183b080acd53f18d2fd027f224ce6f7db455a85d542020640003216bd84ac60131e38e31768463451a3ca5212c8e909629ac6a225aa6b04a5b82101969e50c5393224956944b2ea2556a7070cb352948fa38c3d0223da10589f480746bfd141fc78ae1c77a2d95eda3d33afdb59e87b670ee3a952b5336a8e05138ad87087624e449c5d53ae47bb9799fa326fc7c0b06bd271626df34eb6ee9b0e24dfdb452da0a5134950599b1d3c44632e72b1eb1b2b6a06833ccda32572d88c9394aa26b5374b939dbe69cf98b827e982bb86adb22b99cae4dae0836391caff03321bab8a3697714eaf44a591aa2b2a6136522c4e3201cdb4ec3af281b471a6d7d254c028f462a3d34ba303895ca80594e873cfb8e5116351f445ec66df81bedcfc34bb3557a8859cd67666536166386f8483a65cfb60ecf6049d3acff00076faa71b81f7ed5da59c5602f4ce1c2a481728ac4dcb1beb91cb533a556ae10c34cd87f59ca69ec4da9293527b91bd4cc91e03c799fb764837c6f2fb9f67673f9b42ffc5a2dfb6e64ae42dafa01e7dc3c679ffa4bdfc5b0ecea472a952dc8fb0be1637f29ced6b9287dcae38dbb30759cb31626e58924f7937306d118e27a2761abf46fbd8d2dac53f66b8c073b759416523de08fe29eb5d258a30e591f0208fb784f9f68d564656536652181ec20dc1f39ed5b837fa6d1412a2f31665e6ae07594f913e1e33932ad13d5e0ce7cd1f1343bb52d593f78dbc0ab1cbe116fce14fba2aad756c35103a2df35ebd81273bdc0122dd152f590765ec398eab73ecfaa7178c388eb50da425122eca5acc1d87559572c06f7eb2f6f3eebda1ecd1c918c9e4a8f3a3bcbc38e3da1a04199f540cfdf296f0e13ad52aa35e9e1a6b52c311cd9d1d093d5b58023ccfbf814b8cab3d5455b74753161660cadd4a6cce4e26b01746008bf7da55db78c36a5a8eaac8550842703162e69ab5eead6b6271f1b76c578d3699458b272d8daeefe1b5a35fa6c4c5dd55194683a3a6ea309041edccf677cf16f49e7fdcebff06b99fc9acf47e0bdf55abed0cb54838143f5712dfa457f9cda580e73cd3d243df796d06ded28edfcdaf7c78f3a1e11947254ba1991118e20da50bd88c6846464c290ac626018460c6118c6018500cc4d8ad1a35a3c627b0540cbb4e52a465ca4d2321e058593a99021932454ce8889cc0c30c88c16321800b01e4af20798268bd1e9fc797206e95058e40f56fafba6cb7d5047db992a75530824dc8fd64612dd82dc873f0984e096b6db4f206f8c67a7a8dae5351c5a8cb5cb746eeac8a00446750c1eb12790d1873be99762729926ae55f02c2aad3da95698c4a29d618ac49bf46a42df3d733a1394e66db5407a819992d56a95b1c3721dacd9ea6f6cc77c0ddd45b18f93a8aa8958331a6c88d7a0543e642eabed107ae3be16df45fa4aa1a9d460ceeeac10bae02410a871644d8e432cfc6197b45f1d46af7359e8dea62a956ea2f893b462bd053889cf3d74ec96b8ab88a9ecb9bdee5d911429209351b56b586bce73380438ab50b23286642ab51596d6a6ea45883cc5f2be4473bceaf11ec74ead36e956fd1bb32806c31749617f9c05ce446761232abdce3cdb4db473778efce890bb01885f02e762d879f75ce67ca794d5aecec59c92c4dc939927b67a352ddf9e2a8713017e7a93a93cccf3cdb81e95eea14e26ea8d067a0bcd8229365f0bbb202628ad1619d2740f79a0e0ee21fb9ab616bf475080d6f65b40fe4483dde133d3b5c2db22bd53885c05c8789b5fcbe98b28ea54c9657516cf5fdc3bc90ed494c95c643b28b8eb28074f819c2e3438b6f0afd54c362ff349aa9ed9d321a73b4b3c1db94256a6e7ac14954c5c832b061de333e52871a6c8e76c66a6a1ecb80a87a2b6ebabded508ec1cbda39e562905a29338f13d53bf814df67a74768a2b44e24f9562d70c17e41fdb16c19f78d7594779a97ad5af70056a986d962c2292eb638ac31664fb3ae50e8eefa82a062a5569a562097a7d62f48aae5498b0e5da73cb485b56cd503d5b056152abb861568a8b30c387325ac40d45bd6d3b5e4d3677637a1a6f7d8ebfa3c2cb59f1039a52b68a48e8aa1be2c89cd4f3e4661fd208ff0070adde41edf646be5371c13408ad50b60bbf5f08746b04a4d4f32874d3b398b65315e9196db6b1ed453f161fda227e9126fd6b665e211af14aa1d8f01842bc6b42280562b438c66b15a00890389609806312922be28a198a1b1348f48cb94c0942919729349c91a0cb694e4e124149a5a412475441091addd253142574909d254a93a0f29d7119315a2f70ab7e374b4f58eba7aadacd86ff00de5505514a90a7764e90dd31839b2900781fa662f879adb4d23fb63e371da3b669b8a49e954e587a21722c34a8a72e7cd8e5d9e115fb44ebd3487d877954e9543e03885465229a2b0c08cc0dc106f7c36b11a1d23d4daea07a810530a95192c6921b1001420e13958a5ef99b1cf49ceddac59e9a8eb026a0395cdcd0232256e01cf21ae5ad84eceefa349aad5fba708506e97387acc9489b902e7dad7b21493950f3f42ce9f066dc5aa91530624c0b92955b3a936c37208c2a99e119823bce876837e9465ebd419683ae6dee194cb70f305dadc2d8531830b5858d85504e2cb1f2d6685e8d477714b0e75092c54940b604dada9bdac3ea9cf9ed3a8f339e74ddbe8503b03b9cee0002ddfda7eddb38957d1d2335cd67190be40dcdb3624df539fbe7a17dc7dd046cddda4bc20a28e47925e1b1e7dfe9a5319f4d52de09f542ff004e297e96af2f99a794f423b0f744766b7b3cb4e7794376b3eacf393e8ee9fe96af927d526d8f8386cef8d2a331033042e60dbb39cdf36cd7b6405c1072cbb89128fdefaa33254f216045ada0233e5df164eb920ac9296ce44bc3f5b3a62d906b0bf81bf2995e2bde95176daa88c13abd21212912c558a85eb8bfdac06734db0e35aa98c5b3bdec0adac7298be31b9db1ed661852ea2d737aad98519db2b65da2471b936f51d78231d43ec9bdea1ad66605592a9b61a4b8702621d6500ea41d45ac7b72ab577bbe2a96a8500ab529050288070b755ee52e000545b3f573d641bb6e2a2daea30d6387ac2ff2282e003c8dc6bcf297773ed14835735fac3ee8a81322c075cdd72395cf2ef968ab9517c950dd2b3b9c1bb533354c6d8f0755598268c818fa8b622e32cb398ff48c3f194efa60f9bb99a9e14aa2f57316c4a141cc055a42e2c74be3072ed98fe3caf8b685d32a4a32f16327cb25118ef3b3346318e222258ab40111c08e161e1981405e2224a52015ef98c42cb23693b2c85d632252238a31114c4ec0a72d53321a72cd310498b0458a265da6653a692d21923aa24d1ad081ca32e4662d60d4129d5971de51a8630ad93ee87b6d148fedafd3e3363bfb63a951d2a531d215465b028b992b63d63968791d394c352a855830f6483e46f3b7f85f56e4e15cf239b77f96bf0115a77689c936ed1d4d9f74560f48940021b938909b3290e30adbe71cef736e5157dd958d46655c4b53a3b9ba0230d35162af723cf2b0ccc9760dfa6aa3306b155c4eb63616d2d9e6349ca1c715c5faa86e41d5f516b7d026b9362a72e468387765aab5daa544e8f25191422e0be980803f29a65a4f48dcfbd69a53219acd8c9391cee723cf94f1c5e3fda07b14f5beafa8b67af77c4c31e90b68cce0a79d89cdf503c60a95d892c7299ed877f51b6649fe173fda352df9472ccfbd1fea9e323d246d1f329f9bfd7245f499b40f629eb9e6fcbdf1ae44fbb33da7efd51ede7f35fea86bbd28fce1fcadd9e13c487a4caf9fc9a66d8bd6a9a8b77f74913d27d7f983d6c5ebd4d66b974377691ed277b51bdee3f91bfeb1befe51cecc399f55b967d9dd3c60fa4faf9757dac5f947d73fae151f4a3585ee97f588ebb64cd7cfe27cf586e46eeb23d636fdec84aaab5983f219e418b137b73cb598adf1c0db46d550d7a6d48065c3f2841b80ec7d5bf6db9f2999ff0053ab65741912475df537ff00b18ffea7d516b535c893ebbf3bdfe98be95dd0f0c3387b277978036a562ccd45805a81143a5fe52c0e2c591390f2d3391b7a3ada7a472b52805677a8b7605d599f103cb4cb2eed67097d2555cbe4d7227da7e7afd33b5bef897ee7a6a412cccb7452185d4919920e5940e54f9731ab22dad7d8e96ebdc3576424d5742ce58e242a47ab496d60461c93fccf2adf5b61ab5dd8fce20782f547c04ee55e3eda2e30845b023da391f7f70997737373a937f79862b7b6521192dd831131fc631128358404915644b250666143de034782d01982d20a9256320a86322320098a0de34623615332d53329a4b54da2c91a05ba6659569511e4ead2674c49d5e0d48ca62680a00f56576693b2c8cac742d115e2bc90a4629359a8b7bab7f55d9c5414c8f945c06e01cbbafa4a21e10a7104982a3bd8818847c30824238d68898e5622b3041bc4217471f0c16606f1086045866b311da2021e18e566311ce8ef8e20abb48415483d1ae15b0b65296183860a0344718892b2c0221300238584042b4c2818616188c698c3891b08e6a4076984646f2079333489cc7232228a14687725402b4b14de5359629b42d0b065c469611a534693a349b474c196c3422d2b87861a02d61341b428ad00c90d863e086216182c6a22c315a4b82095843405a2b428af30681b4568444444c102f15a10844de60000c7b4463cc111118ac7318198c2b41ca3c79856091070c33066034088c614130894466333433018422b03148dcc36122610a44db04980c6132c8cac624c514123c628c4c884914c5142c9a26469611a28a4ce8893092ac51443a1120308c51452a87530af1e2998e2bc1b478a1311b1820c514c11ef1c3468a60788e62bc514c115a2bc514c6162ec8d14531868af1450818c4c6c514530a0c6c514530a09323631e28446464c8c98f14644d81782d14509360451450133ffd9, '100', 'no category', 'Palki'),
(2, 'jpeg', 0x89504e470d0a1a0a0000000d49484452000000140000001408060000008d891d0d0000001974455874536f6674776172650041646f626520496d616765526561647971c9653c000002374944415478da9c55cb8a1341143db7fa91c4c4cc90680f18c4854a701398e5802bc11712cc1784d9b8f463c4cd202e862c5d48308a821f908d10c82e7ba3631c9051f1917e94a73a9d31e6d193f1d297eaeeaa3a75eeb3446b8d79d93b235e1061c7126c53ab964285236cc190ef038e3dd742f7fea11ecdef9559c0a70591ef3e1a8e427dc345ad6003392abf6309b9940721e0c86d7d25e810b87debe02fc831e05e5e8a3f03ec12a85976018ea9e213980f78568bacf76f7cd45f8f019fe4c92cc0c312c1b67240c6c25a32a54517b4e892c7d7875ac7c61c0568141c34bd2ce0aad89cb51489d2bd4d82360c967a94138f1f756326fd8199756babf12d79d4df5d24d698d1a4a9b5a2939cfa1f6282145aa865043b4a981a79328b74badefca453e783103069a648b59a5dc3d4379ee0f648af9c37513758361956e8c30573ef7e5e6eff1d82be3e2f0bffc726da9860c560d1dc8257e71637dd3bd44bff63928f131585a1af4f36d980bd24d8aa7947628643c370f03bc2555bd223f9a29cbe20ab62860345d4de58af9fccabf4ac8a19f6140bbfcb08f57f4527a7ce2a2d324b4a16fa7e88ae7af04d8f684c274c0273da2ac99099476a2e3bcfa5f77a14d732ebb74db056744a335919b8c00a2bdb687df1d1fea77d3ddb9022337d973dae39ed7d69b24933b712b01f11f6af7c98695f5379be29c253e3064bc09a61ec27b52a496a14d4c46704ea736de72844fbdab2063b2b6f4be29942b715b649a24aa08a935c01d401df7b0c64f7f2c1e215f047800100bd17764b82a883bd0000000049454e44ae426082, '64', '', 'food_item');

-- --------------------------------------------------------

--
-- Table structure for table `x2_locations`
--

CREATE TABLE IF NOT EXISTS `x2_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `city_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CITY_ID` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_locations`
--

INSERT INTO `x2_locations` (`id`, `name`, `zip`, `city_id`) VALUES
(1, 'MURUGESHPALYA', '560071', 1),
(2, 'DOMLUR', '560017', 1),
(3, 'BANNERGATTA', '560028', 1),
(4, 'ELECTRONIC CITY 1', '560028', 1),
(5, 'AUDOGODI', '560029', 1),
(6, 'KAMPEGOWDA', '560001', 1),
(7, 'M. G. ROAD', '560001', 1),
(8, 'ULSOOR', '560002', 1),
(9, 'RICHMOND CIRCLE', '560003', 1),
(10, 'LALBAGH', '560004', 1);

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned DEFAULT NULL,
  `about` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `x2_restaurant`
--

INSERT INTO `x2_restaurant` (`id`, `name`, `group_id`, `createtime`, `about`) VALUES
(1, 'Palki', 1, 123455679, 'Palki Restaurant is one of the oldest places in Town. Located in quiet corner of the Gandhinagar, it caters to most of the tourists round the clock '),
(2, 'Diners Den', 2, NULL, ''),
(3, 'Potato Tub', 2, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_activity`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(10) unsigned NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `starttime` int(10) unsigned NOT NULL,
  `endtime` int(10) unsigned NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_id` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_address`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_address` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(10) unsigned DEFAULT NULL,
  `line1` text NOT NULL,
  `line2` text NOT NULL,
  `landmark` text NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `latitude` text NOT NULL,
  `longitude` text NOT NULL,
  `zipcode` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `LOCATION_ID` (`location_id`),
  KEY `RESTAURANT_ID` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_restaurant_address`
--

INSERT INTO `x2_restaurant_address` (`id`, `restaurant_id`, `line1`, `line2`, `landmark`, `location_id`, `latitude`, `longitude`, `zipcode`) VALUES
(1, 1, '5th Cross', 'Near Kemp Fort', 'Total Mall', 1, '45.64', '443.22', '560071'),
(4, 2, '3rd Main', '3rd Cross', 'Opp SLV temple', 5, '', '', '560029'),
(5, 3, 'Tavarekere main road', '1st Main', 'Behind Oracle', 5, '', '', '560029');

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_contacts`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_contacts` (
  `id` int(10) NOT NULL,
  `restaurant_id` int(10) unsigned NOT NULL,
  `contact_type` int(10) unsigned DEFAULT NULL,
  `contact_details` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `RESTAURANT_ID` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_restaurant_contacts`
--

INSERT INTO `x2_restaurant_contacts` (`id`, `restaurant_id`, `contact_type`, `contact_details`) VALUES
(1, 1, 1, '9916193366'),
(2, 1, 2, 'sundeep.techie@gmail.com'),
(3, 2, 1, '9008174411'),
(4, 3, 1, '9945637156');

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_feedback`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `order_id` varchar(20) NOT NULL,
  `createtime` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_id` (`restaurant_id`,`user_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_feedback_properties`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_feedback_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `feedback_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `value` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `feedback_id` (`feedback_id`,`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_group`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `smart_name` varchar(50) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `smart_name` (`smart_name`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `x2_restaurant_group`
--

INSERT INTO `x2_restaurant_group` (`id`, `name`, `smart_name`, `user_id`) VALUES
(1, 'Palki', 'palki', 1),
(2, 'Potato Tub', 'potatotub', 2);

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_images`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_images` (
  `restaurant_id` int(10) unsigned NOT NULL,
  `image_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`restaurant_id`,`image_id`),
  KEY `restaurant_id` (`restaurant_id`),
  KEY `image_id` (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_restaurant_images`
--

INSERT INTO `x2_restaurant_images` (`restaurant_id`, `image_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_menu`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `RESTAURANT_ID` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `x2_restaurant_menu`
--

INSERT INTO `x2_restaurant_menu` (`id`, `restaurant_id`, `name`, `description`) VALUES
(1, 1, 'Breakfast', 'Breakfast menu');

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_menu_details`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_menu_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned NOT NULL,
  `menu_item_id` int(10) unsigned NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `image` mediumblob,
  PRIMARY KEY (`id`),
  KEY `MENU_ID` (`menu_id`,`menu_item_id`),
  KEY `MENU_ITEM_ID` (`menu_item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `x2_restaurant_menu_details`
--

INSERT INTO `x2_restaurant_menu_details` (`id`, `menu_id`, `menu_item_id`, `description`, `image`) VALUES
(1, 1, 1, 'Item 1 of Menu 1', NULL),
(2, 1, 2, 'Masala Dosa, Rawa Dosa, blah blah', 0x89504e470d0a1a0a0000000d49484452000000aa0000000a0806000000246ac56c0000001974455874536f6674776172650041646f626520496d616765526561647971c9653c0000010c4944415478daec98eb0a83300c85d38bd3f77fdacd4b5d1d296421ad9be2d88f73e090b85541f94893462272d99e63a8d82b3b751f19113aae95bfe35af9df8935fffc0e3a268e25975e2a7ead8d02c64e391a903ac38013fa065a6d0deb9c3d292f91a1bc650fd9bd00d50254430940a123c05af04a600ba08fec7bf618b972f60ceac09006544de802b90fab6de1b2b438c91b0f91119042bf82d7b5e69d20c87506e9d2a472083ad302d47ad485b7fd91b7fe2d4e917f5cc5824e6cff41b4011e831474c14095047f12d402eb16e7dad154a4f6f19407b0d0094013b58fa76675bd6ac8bca89ead1cd5153a5b4593a8a6ad9c24a89f34b77b67a88014da83d582b63603bdcd424f01060006168a138e4273eb0000000049454e44ae426082);

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_menu_item_properties`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_menu_item_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_item_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_property_uniq` (`menu_item_id`,`property_id`),
  KEY `menu_item_id` (`menu_item_id`),
  KEY `property_id` (`property_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `x2_restaurant_menu_item_properties`
--

INSERT INTO `x2_restaurant_menu_item_properties` (`id`, `menu_item_id`, `property_id`, `value`) VALUES
(1, 1, 2, '1'),
(2, 1, 3, '1'),
(3, 2, 5, '1');

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_menu_properties`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_menu_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `MENU_ID` (`menu_id`,`property_id`),
  KEY `PROPERTY_ID` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_restaurant_properties`
--

CREATE TABLE IF NOT EXISTS `x2_restaurant_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `RESTAURANT_ID` (`restaurant_id`,`property_id`),
  KEY `PROPERTY_ID` (`property_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `x2_restaurant_properties`
--

INSERT INTO `x2_restaurant_properties` (`id`, `restaurant_id`, `property_id`, `value`) VALUES
(1, 1, 1, '12'),
(2, 1, 2, '1'),
(3, 1, 3, '1'),
(4, 1, 4, '1'),
(5, 1, 5, '1');

-- --------------------------------------------------------

--
-- Table structure for table `x2_user`
--

CREATE TABLE IF NOT EXISTS `x2_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `firstname` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  `dob` int(10) DEFAULT NULL,
  `activkey` varchar(128) NOT NULL DEFAULT '',
  `createtime` int(10) NOT NULL DEFAULT '0',
  `lastvisit` int(10) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `x2_user`
--

INSERT INTO `x2_user` (`id`, `username`, `password`, `email`, `firstname`, `lastname`, `dob`, `activkey`, `createtime`, `lastvisit`, `status`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'webmaster@example.com', NULL, NULL, NULL, '9a24eff8c15a6a141ece27eb6947da0f', 1261146094, 1332690864, 1),
(2, 'demo', 'fe01ce2a7fbac8fafaed7c982a04e229', 'demo@example.com', NULL, NULL, NULL, '099f825543f7850cc038b90aaff39fac', 1261146096, 1341896302, 1),
(5, 'harsha', '226280c5dd9b1bd4e67c72ff2c94bf1b', 'harshasanghi@gmail.com', 'Harsha', 'Sanghi', NULL, 'harsha', 10000000, 1342117418, 1),
(7, 'sundeep', '60ed5ab0fa153358e7e5643f190391a5', 'sundeep.techie@gmail.com', 'Sundeep', 'Gupta', NULL, '4253c0f178450be7bc03fc0f3af0700a', 1342992915, 1342992915, 0);

-- --------------------------------------------------------

--
-- Table structure for table `x2_user_address`
--

CREATE TABLE IF NOT EXISTS `x2_user_address` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `line1` text NOT NULL,
  `line2` text NOT NULL,
  `landmark` text NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `latitude` text NOT NULL,
  `longitude` text NOT NULL,
  `zipcode` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `LOCATION_ID` (`location_id`),
  KEY `RESTAURANT_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `x2_user_contacts`
--

CREATE TABLE IF NOT EXISTS `x2_user_contacts` (
  `id` int(10) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `contact_type` int(10) unsigned DEFAULT NULL,
  `contact_details` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `RESTAURANT_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `x2_article`
--
ALTER TABLE `x2_article`
  ADD CONSTRAINT `x2_article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `x2_user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_auth_assignment`
--
ALTER TABLE `x2_auth_assignment`
  ADD CONSTRAINT `x2_auth_assignment_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `x2_user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `x2_auth_assignment_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `x2_auth_item` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_auth_item_child`
--
ALTER TABLE `x2_auth_item_child`
  ADD CONSTRAINT `x2_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `x2_auth_item` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `x2_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `x2_auth_item` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_coupon_images`
--
ALTER TABLE `x2_coupon_images`
  ADD CONSTRAINT `x2_coupon_images_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `x2_image` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_entity_attributes`
--
ALTER TABLE `x2_entity_attributes`
  ADD CONSTRAINT `x2_entity_attributes_ibfk_2` FOREIGN KEY (`entity_id`) REFERENCES `x2_entity` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_food_item`
--
ALTER TABLE `x2_food_item`
  ADD CONSTRAINT `x2_food_item_ibfk_1` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `x2_food_item_category` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `x2_food_item_images`
--
ALTER TABLE `x2_food_item_images`
  ADD CONSTRAINT `x2_food_item_images_ibfk_1` FOREIGN KEY (`food_item_id`) REFERENCES `x2_food_item` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `x2_food_item_images_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `x2_image` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_locations`
--
ALTER TABLE `x2_locations`
  ADD CONSTRAINT `x2_locations_ibfk_1` FOREIGN KEY (`CITY_ID`) REFERENCES `x2_city` (`id`);

--
-- Constraints for table `x2_restaurant`
--
ALTER TABLE `x2_restaurant`
  ADD CONSTRAINT `x2_restaurant_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `x2_restaurant_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_restaurant_address`
--
ALTER TABLE `x2_restaurant_address`
  ADD CONSTRAINT `x2_restaurant_address_ibfk_1` FOREIGN KEY (`LOCATION_ID`) REFERENCES `x2_locations` (`ID`),
  ADD CONSTRAINT `x2_restaurant_address_ibfk_2` FOREIGN KEY (`RESTAURANT_ID`) REFERENCES `x2_restaurant` (`ID`);

--
-- Constraints for table `x2_restaurant_contacts`
--
ALTER TABLE `x2_restaurant_contacts`
  ADD CONSTRAINT `x2_restaurant_contacts_ibfk_1` FOREIGN KEY (`RESTAURANT_ID`) REFERENCES `x2_restaurant` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `x2_restaurant_contacts_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `x2_restaurant` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_restaurant_feedback_properties`
--
ALTER TABLE `x2_restaurant_feedback_properties`
  ADD CONSTRAINT `x2_restaurant_feedback_properties_ibfk_1` FOREIGN KEY (`feedback_id`) REFERENCES `x2_entity_attributes` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_restaurant_group`
--
ALTER TABLE `x2_restaurant_group`
  ADD CONSTRAINT `x2_restaurant_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `x2_user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_restaurant_images`
--
ALTER TABLE `x2_restaurant_images`
  ADD CONSTRAINT `x2_restaurant_images_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `x2_restaurant` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `x2_restaurant_images_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `x2_image` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_restaurant_menu`
--
ALTER TABLE `x2_restaurant_menu`
  ADD CONSTRAINT `x2_restaurant_menu_ibfk_1` FOREIGN KEY (`RESTAURANT_ID`) REFERENCES `x2_restaurant` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `x2_restaurant_menu_details`
--
ALTER TABLE `x2_restaurant_menu_details`
  ADD CONSTRAINT `x2_restaurant_menu_details_ibfk_1` FOREIGN KEY (`MENU_ID`) REFERENCES `x2_restaurant_menu` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `x2_restaurant_menu_details_ibfk_2` FOREIGN KEY (`MENU_ITEM_ID`) REFERENCES `x2_food_item` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `x2_restaurant_menu_item_properties`
--
ALTER TABLE `x2_restaurant_menu_item_properties`
  ADD CONSTRAINT `x2_restaurant_menu_item_properties_ibfk_1` FOREIGN KEY (`MENU_ITEM_ID`) REFERENCES `x2_restaurant_menu_details` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `x2_restaurant_menu_item_properties_ibfk_2` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `x2_food_item_property_obsolete` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `x2_restaurant_menu_item_properties_ibfk_3` FOREIGN KEY (`menu_item_id`) REFERENCES `x2_restaurant_menu_details` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `x2_restaurant_menu_item_properties_ibfk_4` FOREIGN KEY (`property_id`) REFERENCES `x2_entity_attributes` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_restaurant_menu_properties`
--
ALTER TABLE `x2_restaurant_menu_properties`
  ADD CONSTRAINT `x2_restaurant_menu_properties_ibfk_1` FOREIGN KEY (`MENU_ID`) REFERENCES `x2_restaurant_menu` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `x2_restaurant_menu_properties_ibfk_2` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `x2_food_item_property_obsolete` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `x2_restaurant_menu_properties_ibfk_3` FOREIGN KEY (`property_id`) REFERENCES `x2_entity_attributes` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_restaurant_properties`
--
ALTER TABLE `x2_restaurant_properties`
  ADD CONSTRAINT `x2_restaurant_properties_ibfk_1` FOREIGN KEY (`RESTAURANT_ID`) REFERENCES `x2_restaurant` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `x2_restaurant_properties_ibfk_3` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `x2_entity_attributes` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `x2_user_address`
--
ALTER TABLE `x2_user_address`
  ADD CONSTRAINT `x2_user_address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `x2_user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `x2_user_address_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `x2_locations` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `x2_user_contacts`
--
ALTER TABLE `x2_user_contacts`
  ADD CONSTRAINT `x2_user_contacts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `x2_user` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
