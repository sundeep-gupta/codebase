-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2013 at 07:34 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `itrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskname` varchar(512) NOT NULL,
  `type` varchar(100) NOT NULL,
  `state` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`id`, `taskname`, `type`, `state`) VALUES
(2, 'have cranberry juice', 'UrgentNImportant', 0),
(3, 'explain shahin', 'NUrgentImportant', 0),
(4, 'Drink water', 'NUrgentNImportant', 1),
(5, 'Drink water', 'UrgentNImportant', 0),
(6, 'Eat Kufta', 'NUrgentImportant', 1),
(7, 'Enter Task Here..', '', 0),
(8, 'Enter Task Here..', 'UrgentImportant', 1),
(9, 'shahin', 'UrgentNImportant', 0),
(10, 'hello', 'NUrgentImportant', 0),
(11, 'Enter Task Here..', 'NUrgentNImportant', 0),
(12, 'time', 'NUrgentImportant', 0),
(13, 'Eat chicken', 'UrgentImportant', 0),
(14, 'Talk to Shahin', 'NUrgentImportant', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
