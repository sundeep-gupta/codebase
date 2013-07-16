-- MySQL dump 9.11
--
-- Host: localhost    Database: certs3-dev2
-- ------------------------------------------------------
-- Server version	4.0.20-standard-log

--
-- Table structure for table `bucket`
--

DROP TABLE bucket;
DROP TABLE bucketDuration;
DROP TABLE bucketLog;
DROP TABLE company;
DROP TABLE email;
DROP TABLE emailPrefix;
DROP TABLE event;
DROP TABLE file;
DROP TABLE logEntry;
DROP TABLE logSubject;
DROP TABLE payment;
DROP TABLE permission;
DROP TABLE platform;
DROP TABLE prefix;
DROP TABLE prefixUser;
DROP TABLE priceList;
DROP TABLE product;
DROP TABLE productNumber;
DROP TABLE productPriceList;
DROP TABLE productPriceListPlatform;
DROP TABLE productPriceListStatus;
DROP TABLE productPriceListStep;
DROP TABLE program;
DROP TABLE programMTA;
DROP TABLE sponsorCompany;
DROP TABLE status;
DROP TABLE statusSet;
DROP TABLE step;
DROP TABLE timeframe;
DROP TABLE user;
DROP TABLE userPermission;
DROP TABLE userProductPriceList;

CREATE TABLE bucket (
  id int(10) unsigned NOT NULL auto_increment,
  company_id int(10) unsigned NOT NULL default '0',
  description varchar(50) default NULL,
  comment varchar(100) default NULL,
  balance int(10) unsigned default NULL,
  hourlyRate int(10) unsigned default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY bucket_FKIndex1 (company_id)
) TYPE=MyISAM;

--
-- Dumping data for table `bucket`
--


--
-- Table structure for table `bucketDuration`
--

CREATE TABLE bucketDuration (
  id int(10) unsigned NOT NULL auto_increment,
  description varchar(50) default NULL,
  weight int(10) unsigned default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `bucketDuration`
--


--
-- Table structure for table `bucketLog`
--

CREATE TABLE bucketLog (
  id int(10) unsigned NOT NULL auto_increment,
  bucket_id int(10) unsigned default NULL,
  amount int(11) default NULL,
  dateTime datetime default NULL,
  description varchar(50) default NULL,
  PRIMARY KEY  (id),
  KEY bucketLog_FKIndex1 (bucket_id)
) TYPE=MyISAM;

--
-- Dumping data for table `bucketLog`
--


--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(25) default NULL,
  `address1` varchar(50) default NULL,
  `address2` varchar(50) default NULL,
  `city` varchar(25) default NULL,
  `state` char(2) default NULL,
  `zip` varchar(8) default NULL,
  `country` varchar(25) default NULL,
  `active` tinyint(1) unsigned default '1',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;

--
-- Dumping data for table `company`
--

INSERT INTO company VALUES (1,'KeyLabs',NULL,NULL,NULL,NULL,NULL,NULL,1);

--
-- Table structure for table `email`
--

CREATE TABLE email (
  id int(10) unsigned NOT NULL auto_increment,
  description varchar(100) default NULL,
  subject varchar(50) default NULL,
  body text,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `email`
--


--
-- Table structure for table `emailPriceList`
--

CREATE TABLE `emailPrefix` (
  `prefix_id` int(10) unsigned NOT NULL default '0',
  `email_id` int(10) unsigned NOT NULL default '0',
  KEY `emailPriceList_FKIndex1` (`email_id`),
  KEY `emailPrefix_FKIndex2` (`prefix_id`)
) TYPE=MyISAM;


--
-- Dumping data for table `emailPriceList`
--

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `description` varchar(100) default NULL,
  `schedStartDate` date default NULL,
  `estDuration` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


--
-- Dumping data for table `event`
--
INSERT INTO event VALUES (1,'Rich\'s Birthday!',2005-06-19, 1);

--
-- Table structure for table `file`
--

CREATE TABLE file (
  id int(10) unsigned NOT NULL auto_increment,
  product_id int(10) unsigned NOT NULL default '0',
  description varchar(100) default NULL,
  path varchar(255) default NULL,
  name varchar(255) default NULL,
  type varchar(255) default NULL,
  PRIMARY KEY  (id),
  KEY file_FKIndex1 (product_id)
) TYPE=MyISAM;

--
-- Dumping data for table `file`
--


--
-- Table structure for table `logEntry`
--

CREATE TABLE logEntry (
  id int(10) unsigned NOT NULL auto_increment,
  productPriceList_id int(10) unsigned default NULL,
  logSubject_id int(10) unsigned NOT NULL default '0',
  user_id int(10) unsigned default NULL,
  entryTime datetime default NULL,
  comment text,
  PRIMARY KEY  (id),
  KEY logEntry_index2254 (productPriceList_id),
  KEY logEntry_index2255 (logSubject_id),
  KEY logEntry_index2256 (user_id)
) TYPE=MyISAM;

--
-- Dumping data for table `logEntry`
--


--
-- Table structure for table `logSubject`
--

CREATE TABLE logSubject (
  id int(10) unsigned NOT NULL auto_increment,
  subject varchar(25) default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `logSubject`
--

INSERT INTO logSubject Values(1, 'Imported from old system', 1);


--
-- Table structure for table `payment`
--

CREATE TABLE payment (
  id int(10) unsigned NOT NULL auto_increment,
  method varchar(15) default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `payment`
--

INSERT INTO payment VALUES (1,'Other',1);

--
-- Table structure for table `permission`
--

CREATE TABLE permission (
  id int(10) unsigned NOT NULL auto_increment,
  permission varchar(100) default NULL,
  description varchar(100) default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `permission`
--

INSERT INTO permission VALUES (1,'KeyLabs','Keylabs Edit Permission');
INSERT INTO permission VALUES (2,'prefix-1','Permission for CIPC prefix');
INSERT INTO permission VALUES (3,'prefix-2','Permission for RFID prefix');
INSERT INTO permission VALUES (4,'prefix-3','Permission for CSA prefix');
INSERT INTO permission VALUES (5,'prefix-4','Permission for CWN prefix');
INSERT INTO permission VALUES (6,'prefix-5','Permission for CCX prefix');
INSERT INTO permission VALUES (7,'prefix-6','Permission for CMC prefix');
INSERT INTO permission VALUES (8,'prefix-7','Permission for EBAY prefix');
INSERT INTO permission VALUES (9,'prefix-8','Permission for HPUX prefix');
INSERT INTO permission VALUES (10,'prefix-9','Permission for SJDBC prefix');
INSERT INTO permission VALUES (11,'prefix-10','Permission for LNX prefix');
INSERT INTO permission VALUES (12,'prefix-11','Permission for RN prefix');
INSERT INTO permission VALUES (13,'prefix-12','Permission for SR prefix');
INSERT INTO permission VALUES (14,'prefix-13','Permission for ST prefix');
INSERT INTO permission VALUES (15,'prefix-14','Permission for WHQL prefix');
INSERT INTO permission VALUES (16,'prefix-15','Permission for NOVLY prefix');

--
-- Table structure for table `platform`
--

CREATE TABLE platform (
  id int(10) unsigned NOT NULL auto_increment,
  priceList_id int(10) unsigned NOT NULL default '0',
  name varchar(100) default NULL,
  version varchar(25) default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY platform_FKIndex1 (priceList_id)
) TYPE=MyISAM;

--
-- Dumping data for table `platform`
--


--
-- Table structure for table `prefix`
--

CREATE TABLE prefix (
  id int(10) unsigned NOT NULL auto_increment,
  prefix varchar(5) default NULL,
  number int(10) unsigned default NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY prefix_index2471 (prefix)
) TYPE=MyISAM;

--
-- Dumping data for table `prefix`
--

INSERT INTO prefix VALUES (1,'CIPC',99);
INSERT INTO prefix VALUES (2,'RFID',99);
INSERT INTO prefix VALUES (3,'CSA',99);
INSERT INTO prefix VALUES (4,'CWN',99);
INSERT INTO prefix VALUES (5,'CCX',99);
INSERT INTO prefix VALUES (6,'CMC',99);
INSERT INTO prefix VALUES (7,'EBAY',99);
INSERT INTO prefix VALUES (8,'HPUX',99);
INSERT INTO prefix VALUES (9,'SJDBC',99);
INSERT INTO prefix VALUES (10,'LNX', 99);
INSERT INTO prefix VALUES (11,'RN',99);
INSERT INTO prefix VALUES (12,'SR',99);
INSERT INTO prefix VALUES (13,'ST',99);
INSERT INTO prefix VALUES (14,'WHQL',99);
INSERT INTO prefix VALUES (15,'NOVLY',99);

--
-- Table structure for table `prefixUser`
--

CREATE TABLE prefixUser (
  id int(10) unsigned NOT NULL auto_increment,
  user_id int(10) unsigned default NULL,
  prefix_id int(10) unsigned default NULL,
  mandatory tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY prefixUser_index2466 (prefix_id),
  KEY prefixUser_index2468 (user_id)
) TYPE=MyISAM;

--
-- Dumping data for table `prefixUser`
--


--
-- Table structure for table `priceList`
--

CREATE TABLE priceList (
  id int(10) unsigned NOT NULL auto_increment,
  program_id int(10) unsigned NOT NULL default '0',
  prefix_id int(10) unsigned NOT NULL default '0',
  statusSet_id int(10) unsigned default NULL,
  SKU varchar(12) default NULL,
  registerable tinyint(1) unsigned default '1',
  price int(10) unsigned default NULL,
  description varchar(100) default NULL,
  PRIMARY KEY  (id),
  KEY priceList_index2293 (statusSet_id),
  KEY priceList_FKIndex1 (prefix_id),
  KEY priceList_FKIndex2 (program_id)
) TYPE=MyISAM;

--
-- Dumping data for table `priceList`
--

INSERT INTO priceList VALUES (1,1,8,NULL,'CTKN02010103',0,3000,'HP-UX Standard');
INSERT INTO priceList VALUES (2,1,8,NULL,'CTKN02010104',0,2000,'HP-UX Re-certify');
INSERT INTO priceList VALUES (3,2,0,NULL,'CTKN02091201',0,5000,'Cisco AeroNet Partial Test  (by Invitation only)');
INSERT INTO priceList VALUES (4,2,0,NULL,'CTKN02091202',0,10000,'Cisco AeroNet Full Test  (by Invitation only)');
INSERT INTO priceList VALUES (5,2,4,NULL,'CIKN05031101',0,5500,'Cisco TDP-Wireless Net. Client');
INSERT INTO priceList VALUES (6,3,3,NULL,'CTKN02010108',0,6750,'Cisco TDP-Security: Application Security');
INSERT INTO priceList VALUES (7,3,0,NULL,'CTKN02010114',0,3750,'Cisco TDP-Security: Application Security - Re-Cert');
INSERT INTO priceList VALUES (8,3,3,NULL,'CTKN02010105',0,6750,'Cisco TDP-Security: Identity');
INSERT INTO priceList VALUES (9,3,0,NULL,'CTKN02010111',0,3750,'Cisco TDP-Security: Identity - Re-Cert');
INSERT INTO priceList VALUES (10,3,0,NULL,'CTKN02010110',0,8750,'Cisco TDP-Security: Identity-PKI / Certification Authority');
INSERT INTO priceList VALUES (11,3,0,NULL,'CTKN02010116',0,4750,'Cisco TDP-Security: Identity-PKI / Certification Authority - Re-Cert');
INSERT INTO priceList VALUES (12,3,3,NULL,'CTKN02010106',0,6750,'Cisco TDP-Security: Perimeter Security');
INSERT INTO priceList VALUES (13,3,0,NULL,'CTKN02010112',0,3750,'Cisco TDP-Security: Perimeter Security - Re-Cert');
INSERT INTO priceList VALUES (14,3,3,NULL,'CTKN02010109',0,7750,'Cisco TDP-Security: Security Connectivity (VPN Product)');
INSERT INTO priceList VALUES (15,3,0,NULL,'CTKN02010115',0,4250,'Cisco TDP-Security: Security Connectivity (VPN Product) - Re-Cert');
INSERT INTO priceList VALUES (16,3,3,NULL,'CTKN02010107',0,6750,'Cisco TDP-Security: Security Management & Monitoring');
INSERT INTO priceList VALUES (17,3,0,NULL,'CTKN02010113',0,3750,'Cisco TDP-Security: Security Management & Monitoring - Re-Cert');
INSERT INTO priceList VALUES (18,4,6,NULL,'CTKN02010117',0,2000,'Cisco Management Connection - Local');
INSERT INTO priceList VALUES (19,4,6,NULL,'CTKN02010118',0,1000,'Cisco Management Connection - Remote');
INSERT INTO priceList VALUES (20,5,0,NULL,'CTKN02010119',0,1000,'Cisco NMS - Network Test (Required)');
INSERT INTO priceList VALUES (21,5,0,NULL,'CTKN02010120',0,1000,'Cisco NMS - System Test');
INSERT INTO priceList VALUES (22,5,0,NULL,'CTKN02010121',0,1000,'Cisco NMS - On-going Custom');
INSERT INTO priceList VALUES (23,6,5,NULL,'CTKN02091801',0,5500,'CCX 1.0 - Up to Two OS Platforms');
INSERT INTO priceList VALUES (24,6,5,NULL,'CTKN02091802',0,7000,'CCX 1.0 - Three OS Platforms');
INSERT INTO priceList VALUES (25,6,5,NULL,'CTKN02091803',0,8500,'CCX 1.0 - Four OS Platforms');
INSERT INTO priceList VALUES (26,6,5,NULL,'CTKN02091804',0,10000,'CCX 1.0 - Five OS Platforms');
INSERT INTO priceList VALUES (27,6,5,NULL,'CIKN05031102',0,5500,'CCX 2.0 - 1 ASD');
INSERT INTO priceList VALUES (28,6,5,NULL,'CIKN05031103',0,6500,'CCX 2.0 - 2 ASDs or 2 OS');
INSERT INTO priceList VALUES (29,6,5,NULL,'CIKN05031104',0,8000,'CCX 2.0 - 3 ASDs or 3 OS');
INSERT INTO priceList VALUES (30,6,5,NULL,'CIKN05031105',0,9500,'CCX 2.0 - 4 ASDs or 4 OS');
INSERT INTO priceList VALUES (31,6,5,NULL,'CIKN05031106',0,11000,'CCX 2.0 - 5 ASDs or 5 OS');
INSERT INTO priceList VALUES (32,6,5,NULL,'CIKN05031107',0,7500,'CCX 3.0 - 1 ASD');
INSERT INTO priceList VALUES (33,6,5,NULL,'CIKN05031108',0,8500,'CCX 3.0 - 2 ASDs or 2 OS');
INSERT INTO priceList VALUES (34,6,5,NULL,'CIKN05031109',0,10000,'CCX 3.0 - 3 ASDs or 3 OS');
INSERT INTO priceList VALUES (35,6,5,NULL,'CIKN05031110',0,11500,'CCX 3.0 - 4 ASDs or 4 OS');
INSERT INTO priceList VALUES (36,6,5,NULL,'CIKN05031111',0,13000,'CCX 3.0 - 5 ASDs or 5 OS');
INSERT INTO priceList VALUES (37,7,1,NULL,'CIKN05031112',0,8400,'Tier 1 - platform agent, CAB, uncategorized solution, etc');
INSERT INTO priceList VALUES (38,7,1,NULL,'CIKN05031113',0,2400,'Tier 1 - Delta Test');
INSERT INTO priceList VALUES (39,7,1,NULL,'CIKN05031114',0,6000,'Tier 2 - voice mail, voice recording, call center, ACD, endpoint, conferencing');
INSERT INTO priceList VALUES (40,7,1,NULL,'CIKN05031115',0,2000,'Tier 2 - Delta Test');
INSERT INTO priceList VALUES (41,7,1,NULL,'CIKN05031116',0,3600,'Tier 3 - monitoring application, configuration application, , IVR');
INSERT INTO priceList VALUES (42,7,1,NULL,'CIKN05031117',0,1200,'Tier 3 - Delta Test');
INSERT INTO priceList VALUES (43,7,1,NULL,'CIKN05031118',0,2400,'Tier 4 - CME CAB');
INSERT INTO priceList VALUES (44,7,1,NULL,'CIKN05031119',0,1200,'Tier 4 - Delta Test');
INSERT INTO priceList VALUES (45,7,1,NULL,'CIKN05031120',0,1200,'Tier 5 - XML applications');
INSERT INTO priceList VALUES (46,7,1,NULL,'CIKN05031121',0,1200,'Tier 5 - Delta Test');
INSERT INTO priceList VALUES (47,8,2,NULL,'CIKN05031122',0,3000,'Cisco RFID Cert');
INSERT INTO priceList VALUES (48,9,0,NULL,'CIKN05031123',0,7500,'Cisco ICM Cert');
INSERT INTO priceList VALUES (49,10,0,NULL,'CIKN05031124',0,7500,'Cisco Network Admission Control (NAC) Cert');
INSERT INTO priceList VALUES (50,11,7,NULL,'CTKN02010122',1,5000,'eBay - Standard');
INSERT INTO priceList VALUES (51,11,7,NULL,'CTKN02010123',1,2500,'eBay - Re-Certify');
INSERT INTO priceList VALUES (52,12,0,NULL,'CTKN02010124',0,3000,'Sun Jiro - Standard');
INSERT INTO priceList VALUES (53,12,0,NULL,'CTKN02010125',0,1500,'Sun Jiro - Re-Certify');
INSERT INTO priceList VALUES (54,13,10,NULL,'CTKN02010126',1,2000,'Linux Tested - Server & Workstation');
INSERT INTO priceList VALUES (55,13,10,NULL,'CTKN02010127',1,1500,'Linux Tested - Server Only');
INSERT INTO priceList VALUES (56,13,10,NULL,'CTKN02010128',1,1000,'Linux Tested - Workstation Only');
INSERT INTO priceList VALUES (57,13,10,NULL,'CTKN02010129',1,1500,'Linux Tested - Laptop');
INSERT INTO priceList VALUES (58,13,10,NULL,'CTKN02010130',1,800,'Linux Tested - KVM Switch');
INSERT INTO priceList VALUES (59,13,10,NULL,'CTKN02010131',1,1000,'Linux Tested - UPS');
INSERT INTO priceList VALUES (60,13,10,NULL,'CTKN02010132',1,800,'Linux Tested - Device Driver / Controller SCSI');
INSERT INTO priceList VALUES (61,13,10,NULL,'CTKN02010133',1,1000,'Linux Tested - Device Driver / Controller RAID');
INSERT INTO priceList VALUES (62,13,10,NULL,'CTKN02010134',1,800,'Linux Tested - LAN Adapter');
INSERT INTO priceList VALUES (63,13,10,NULL,'CTKN02010135',1,1000,'Linux Tested - WAN Adapter');
INSERT INTO priceList VALUES (64,13,10,NULL,'CTKN02010136',1,800,'Linux Tested - Printer');
INSERT INTO priceList VALUES (65,13,10,NULL,'CTKN02010137',1,800,'Linux Tested - Print Server');
INSERT INTO priceList VALUES (66,13,10,NULL,'CTKN02010138',1,800,'Linux Tested - NIC');
INSERT INTO priceList VALUES (67,13,10,NULL,'CTKN02010139',1,800,'Linux Tested - Modem');
INSERT INTO priceList VALUES (68,13,10,NULL,'CTKN02010140',1,800,'Linux Tested - Memory');
INSERT INTO priceList VALUES (69,13,10,NULL,'CTKN02010141',1,800,'Linux Tested - ATA / IDE');
INSERT INTO priceList VALUES (70,13,10,NULL,'CTKN02010142',1,800,'Linux Tested - SCSI');
INSERT INTO priceList VALUES (71,13,10,NULL,'CTKN02010143',1,600,'Linux Tested - 2D Video Cards');
INSERT INTO priceList VALUES (72,13,10,NULL,'CTKN02010144',1,800,'Linux Tested - 3D Video Cards');
INSERT INTO priceList VALUES (73,13,10,NULL,'CTKN02010145',1,800,'Linux Tested - Combo Cards');
INSERT INTO priceList VALUES (74,13,10,NULL,'CTKN02010146',1,600,'Linux Tested - Sound Cards');
INSERT INTO priceList VALUES (75,13,10,NULL,'CTKN02010147',1,800,'Linux Tested - Pro Sound Cards');
INSERT INTO priceList VALUES (76,13,10,NULL,'CTKN02010148',1,1000,'Linux Tested - Keyboard');
INSERT INTO priceList VALUES (77,13,10,NULL,'CTKN02010149',1,0,'Linux Tested - Storage Device');
INSERT INTO priceList VALUES (78,14,15,NULL,'CTKN02010150',1,600,'Novell Yes - Client Software');
INSERT INTO priceList VALUES (79,14,15,NULL,'CTKN02010151',1,600,'Novell Yes - Java Software');
INSERT INTO priceList VALUES (80,14,15,NULL,'CTKN02010152',1,600,'Novell Yes -  KVM Switch');
INSERT INTO priceList VALUES (81,14,15,NULL,'CTKN02010153',1,2500,'Novell Yes - LAN Driver');
INSERT INTO priceList VALUES (82,14,15,NULL,'CTKN02010154',1,2000,'Novell Yes - Storage Device');
INSERT INTO priceList VALUES (83,14,15,NULL,'CTKN02010155',1,2000,'Novell Yes - Device Controller');
INSERT INTO priceList VALUES (84,14,15,NULL,'CTKN02010156',1,4000,'Novell Yes - File Server & Workstation');
INSERT INTO priceList VALUES (85,14,15,NULL,'CTKN02010157',1,3000,'Novell Yes - File Server Only');
INSERT INTO priceList VALUES (86,14,15,NULL,'CTKN02010158',1,1000,'Novell Yes - Workstation Only');
INSERT INTO priceList VALUES (87,14,15,NULL,'CTKN02010159',1,1500,'Novell Yes - Workstation 2 Processor');
INSERT INTO priceList VALUES (88,14,15,NULL,'CTKN02010160',1,2000,'Novell Yes - Workstation 3 Processor');
INSERT INTO priceList VALUES (89,14,15,NULL,'CTKN02010161',1,2500,'Novell Yes - Workstation 4 Processor');
INSERT INTO priceList VALUES (90,14,15,NULL,'CTKN02010162',1,4500,'Novell Yes - Network Printer');
INSERT INTO priceList VALUES (91,14,15,NULL,'CTKN02010163',1,4500,'Novell Yes - Print Server');
INSERT INTO priceList VALUES (92,14,15,NULL,'CTKN02010164',1,3200,'Novell Yes - Parallel / Serial Printer');
INSERT INTO priceList VALUES (93,14,15,NULL,'CTKN02010165',1,0,'Novell Yes - Backup Application');
INSERT INTO priceList VALUES (94,14,15,NULL,'CTKN02010166',1,0,'Novell Yes - NLM Application');
INSERT INTO priceList VALUES (95,15,11,NULL,'CTKN02010167',1,7500,'RealPlayer - Standard');
INSERT INTO priceList VALUES (96,15,11,NULL,'CTKN02010168',1,5500,'RealPlayer - Re-Certification');
INSERT INTO priceList VALUES (97,15,11,NULL,'CTKN02010169',1,12500,'RealPlayer - Standard +1 Player');
INSERT INTO priceList VALUES (98,15,11,NULL,'CTKN02010170',1,12500,'RealPlayer - Standard +1 Server');
INSERT INTO priceList VALUES (99,15,11,NULL,'CTKN02010171',1,17500,'RealPlayer - Standard +2 Players');
INSERT INTO priceList VALUES (100,15,11,NULL,'CTKN02010172',1,22500,'RealPlayer - Standard +3 Players');
INSERT INTO priceList VALUES (101,15,11,NULL,'CTKN02010173',1,27500,'RealPlayer - Standard +4 Players');
INSERT INTO priceList VALUES (102,15,11,NULL,'CTKN02010174',1,32500,'RealPlayer - Standard +5 Players');
INSERT INTO priceList VALUES (103,15,11,NULL,'CTKN02010175',1,37500,'RealPlayer - Standard +1 Server & 5 Players');
INSERT INTO priceList VALUES (104,15,11,NULL,'CTKN02010176',1,0,'RealPlayer - Re-Certification - Multi-Players');
INSERT INTO priceList VALUES (105,16,11,NULL,'CTKN02051001',1,52750,'RealServer Certification (by Invitation only)');
INSERT INTO priceList VALUES (106,16,11,NULL,'CTKN02051002',1,49175,'RealProxy Certification (by Invitation only)');
INSERT INTO priceList VALUES (107,16,0,NULL,'CTKN02051003',0,12682,'Expedite Fee (2 week test in 1 week)');
INSERT INTO priceList VALUES (108,17,12,NULL,'CTKN02010177',1,2500,'Sun Solaris Ready - SCSI Device');
INSERT INTO priceList VALUES (109,17,12,NULL,'CTKN02010178',1,2500,'Sun Solaris Ready - PCI Card');
INSERT INTO priceList VALUES (110,17,12,NULL,'CTKN02010179',1,3000,'Sun Solaris Ready - Printer');
INSERT INTO priceList VALUES (111,17,12,NULL,'CTKN02010180',1,1000,'Sun Solaris Ready - Monitor');
INSERT INTO priceList VALUES (112,17,12,NULL,'CTKN02010181',1,2000,'Sun Solaris Ready - KVM Switch');
INSERT INTO priceList VALUES (113,17,12,NULL,'CTKN02010182',1,2000,'Sun Solaris Ready - Input Device');
INSERT INTO priceList VALUES (114,17,12,NULL,'CTKN02010183',1,250,'Sun Solaris Ready - SBUS Cards');
INSERT INTO priceList VALUES (115,17,12,NULL,'CTKN02010184',1,250,'Sun Solaris Ready - Smart Cards');
INSERT INTO priceList VALUES (116,18,9,NULL,'CTKN02010185',1,2000,'Sun JDBC - Remote');
INSERT INTO priceList VALUES (117,18,9,NULL,'CTKN02010186',1,4000,'Sun JDBC - Local');
INSERT INTO priceList VALUES (118,18,9,NULL,'CTKN02010187',1,1000,'Sun JDBC - Re-Certify Remote');
INSERT INTO priceList VALUES (119,18,9,NULL,'CTKN02010188',1,3000,'Sun JDBC - Re-Certify Local');
INSERT INTO priceList VALUES (120,19,13,NULL,'CTKN02010189',1,2000,'SunTone Applications - Standard');
INSERT INTO priceList VALUES (121,19,13,NULL,'CTKN02010190',1,1000,'SunTone Applications - Re-Certify');
INSERT INTO priceList VALUES (122,20,14,NULL,'CTKN02010191',1,1500,'Microsoft WHQL - Audio Device');
INSERT INTO priceList VALUES (123,20,14,NULL,'CTKN02010192',1,1500,'Microsoft WHQL - Display');
INSERT INTO priceList VALUES (124,20,14,NULL,'CTKN02010193',1,3000,'Microsoft WHQL - Enterprise Storage');
INSERT INTO priceList VALUES (125,20,14,NULL,'CTKN02010194',1,1000,'Microsoft WHQL - Input Device');
INSERT INTO priceList VALUES (126,20,14,NULL,'CTKN02010195',1,1100,'Microsoft WHQL - KVM Switch');
INSERT INTO priceList VALUES (127,20,14,NULL,'CTKN02010196',1,2500,'Microsoft WHQL - Network WAN');
INSERT INTO priceList VALUES (128,20,14,NULL,'CTKN02010197',1,3000,'Microsoft WHQL - SCSI Storage Tape');
INSERT INTO priceList VALUES (129,20,14,NULL,'CTKN02010198',1,1000,'Microsoft WHQL - Scanner');
INSERT INTO priceList VALUES (130,20,14,NULL,'CTKN02010199',1,1000,'Microsoft WHQL - Camera');
INSERT INTO priceList VALUES (131,20,14,NULL,'CTKN02010200',1,4000,'Microsoft WHQL - IDE ATAPI Storage');
INSERT INTO priceList VALUES (132,20,14,NULL,'CTKN03082901',1,5400,'Microsoft WHQL - HBA 32-bit Standalone');
INSERT INTO priceList VALUES (133,20,14,NULL,'CTKN03082902',1,3800,'Microsoft WHQL - HBA 32-bit Cluster');
INSERT INTO priceList VALUES (134,20,14,NULL,'CTKN03082903',1,6200,'Microsoft WHQL - HBA 64-bit Standalone');
INSERT INTO priceList VALUES (135,20,14,NULL,'CTKN03082904',1,5300,'Microsoft WHQL - HBA 64-bit Cluster');
INSERT INTO priceList VALUES (136,20,14,NULL,'CTKN03082905',1,1000,'Microsoft WHQL - HBA Regression Day 32-bit');
INSERT INTO priceList VALUES (137,20,14,NULL,'CTKN03082906',1,1500,'Microsoft WHQL - HBA Regression Day 64-bit');
INSERT INTO priceList VALUES (138,20,14,NULL,'CTKN02010201',1,1500,'Microsoft WHQL - DVD');
INSERT INTO priceList VALUES (139,20,14,NULL,'CTKN02010202',1,6500,'Microsoft WHQL - Server');
INSERT INTO priceList VALUES (140,20,14,NULL,'CTKN02010203',1,4500,'Microsoft WHQL - Workstation');
INSERT INTO priceList VALUES (141,20,14,NULL,'CTKN02010204',1,1500,'Microsoft WHQL - USB Device');
INSERT INTO priceList VALUES (142,20,14,NULL,'CTKN02010205',1,0,'Microsoft WHQL - Printer');
INSERT INTO priceList VALUES (143,20,14,NULL,'CTKN02010206',1,0,'Microsoft WHQL - RAID Cluster Storage');
INSERT INTO priceList VALUES (144,20,14,NULL,'CTKN02010207',1,0,'Microsoft WHQL - RAID Fiber Storage');
INSERT INTO priceList VALUES (145,20,14,NULL,'CTKN02010208',1,0,'Microsoft WHQL - RAID SCSI Storage');

--
-- Table structure for table `product`
--

CREATE TABLE product (
  id int(10) unsigned NOT NULL auto_increment,
  company_id int(10) unsigned NOT NULL default '0',
  name varchar(50) default NULL,
  version varchar(10) default NULL,
  comment text,
  createDate date default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY product_FKIndex1 (company_id)
) TYPE=MyISAM;

--
-- Dumping data for table `product`
--


--
-- Table structure for table `productNumber`
--

CREATE TABLE productNumber (
  id int(10) unsigned NOT NULL auto_increment,
  priceList_id int(10) unsigned NOT NULL default '0',
  productPriceList_id int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (id),
  KEY productNumber_FKIndex2 (priceList_id)
) TYPE=MyISAM;

--
-- Dumping data for table `productNumber`
--


--
-- Table structure for table `productPriceList`
--

CREATE TABLE productPriceList (
  id int(10) unsigned NOT NULL auto_increment,
  payment_id int(10) unsigned NOT NULL default '0',
  status_id int(10) unsigned NOT NULL default '0',
  technical_id int(10) unsigned NOT NULL default '0',
  submission_id int(10) unsigned NOT NULL default '0',
  engineer_id int(10) unsigned NOT NULL default '0',
  programMTA_id int(10) unsigned NOT NULL default '0',
  product_id int(10) unsigned NOT NULL default '0',
  priceList_id int(10) unsigned NOT NULL default '0',
  timeframe_id int(10) unsigned NOT NULL default '0',
  registeredDate date default NULL,
  schedStartDate date default NULL,
  estDuration int(10) unsigned default NULL,
  number int(10) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY productPriceList_index2259 (technical_id),
  KEY productPriceList_index2260 (submission_id),
  KEY productPriceList_index2261 (engineer_id),
  KEY productPriceList_index2262 (programMTA_id),
  KEY productPriceList_index2263 (timeframe_id),
  KEY productPriceList_index2264 (priceList_id),
  KEY productPriceList_index2265 (technical_id),
  KEY productPriceList_FKIndex1 (status_id),
  KEY productPriceList_FKIndex2 (payment_id)
) TYPE=MyISAM;

--
-- Dumping data for table `productPriceList`
--


--
-- Table structure for table `productPriceListPlatform`
--

CREATE TABLE productPriceListPlatform (
  productPriceList_id int(10) unsigned NOT NULL default '0',
  platform_id int(10) unsigned NOT NULL default '0',
  KEY productPriceListPlatform_FKIndex1 (platform_id),
  KEY productPriceListPlatform_FKIndex2 (productPriceList_id)
) TYPE=MyISAM;

--
-- Dumping data for table `productPriceListPlatform`
--


--
-- Table structure for table `productPriceListStatus`
--

CREATE TABLE productPriceListStatus (
  productPriceList_id int(10) unsigned NOT NULL default '0',
  status_id int(10) unsigned NOT NULL default '0',
  whenMet datetime NOT NULL default '0000-00-00 00:00:00',
  KEY productStatus_FKIndex2 (status_id),
  KEY productStatus_FKIndex3 (productPriceList_id)
) TYPE=MyISAM;

--
-- Dumping data for table `productPriceListStatus`
--


--
-- Table structure for table `productPriceListStep`
--

CREATE TABLE productPriceListStep (
  productPriceList_id int(10) unsigned NOT NULL default '0',
  step_id int(10) unsigned NOT NULL default '0',
  whenMet datetime NOT NULL default '0000-00-00 00:00:00',
  KEY productStep_FKIndex1 (step_id),
  KEY productStep_FKIndex3 (productPriceList_id)
) TYPE=MyISAM;

--
-- Dumping data for table `productPriceListStep`
--


--
-- Table structure for table `program`
--

CREATE TABLE program (
  id int(10) unsigned NOT NULL auto_increment,
  sponsorCompany_id int(10) unsigned NOT NULL default '0',
  programName varchar(100) default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY program_FKIndex1 (sponsorCompany_id)
) TYPE=MyISAM;

--
-- Dumping data for table `program`
--

INSERT INTO program VALUES (1,2,'HP-UX',1);
INSERT INTO program VALUES (2,1,'Cisco Tech Dev Prog - Wireless Networking',1);
INSERT INTO program VALUES (3,1,'Cisco Tech Dev Prog - Security',1);
INSERT INTO program VALUES (4,1,'Cisco Management Connection',1);
INSERT INTO program VALUES (5,1,'Cisco NMS Integration',1);
INSERT INTO program VALUES (6,1,'Cisco Windows Client Extensions Program (CCX)',1);
INSERT INTO program VALUES (7,1,'Cisco Tech Dev Prog - VoIP',1);
INSERT INTO program VALUES (8,1,'Cisco RFID Cert',1);
INSERT INTO program VALUES (9,1,'Cisco ICM Cert',1);
INSERT INTO program VALUES (10,1,'Cisco Network Admission Control (NAC) Cert',1);
INSERT INTO program VALUES (11,3,'eBay API Program',1);
INSERT INTO program VALUES (12,4,'Jiro Enabled Certification',1);
INSERT INTO program VALUES (13,5,'Linux Tested',1);
INSERT INTO program VALUES (14,6,'Novell Yes',1);
INSERT INTO program VALUES (15,7,'RealNetworks RealPlayer Plug-in',1);
INSERT INTO program VALUES (16,7,'RealNetworks - Certified RealSystem Powered',1);
INSERT INTO program VALUES (17,4,'Solaris Ready',1);
INSERT INTO program VALUES (18,4,'Sun JDBC Program',1);
INSERT INTO program VALUES (19,4,'SunTone Applications',1);
INSERT INTO program VALUES (20,8,'WHQL Pre-Testing',1);

--
-- Table structure for table `programMTA`
--

CREATE TABLE programMTA (
  id int(10) unsigned NOT NULL auto_increment,
  program_id int(10) unsigned default NULL,
  mtaText text,
  active int(10) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY programMTA_FKIndex1 (program_id)
) TYPE=MyISAM;

--
-- Dumping data for table `programMTA`
--


--
-- Table structure for table `sponsorCompany`
--

CREATE TABLE sponsorCompany (
  id int(10) unsigned NOT NULL auto_increment,
  companyName varchar(100) default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `sponsorCompany`
--

INSERT INTO sponsorCompany VALUES (1,'Cisco Systems');
INSERT INTO sponsorCompany VALUES (2,'Hewlett Packard');
INSERT INTO sponsorCompany VALUES (3,'eBay');
INSERT INTO sponsorCompany VALUES (4,'Sun Microsystems');
INSERT INTO sponsorCompany VALUES (5,'KeyLabs');
INSERT INTO sponsorCompany VALUES (6,'Novell');
INSERT INTO sponsorCompany VALUES (7,'Real Networks');
INSERT INTO sponsorCompany VALUES (8,'Microsoft');

--
-- Table structure for table `status`
--

CREATE TABLE status (
  id int(10) unsigned NOT NULL auto_increment,
  prefix_id int(10) unsigned NOT NULL default '0',
  name varchar(20) default NULL,
  orderIndex int(10) unsigned default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY status_index2382 (prefix_id)
) TYPE=MyISAM;

--
-- Dumping data for table `status`
--

INSERT INTO status VALUES (1,1,'Registered',1,1);
INSERT INTO status VALUES (2,2,'Registered',1,1);
INSERT INTO status VALUES (3,3,'Registered',1,1);
INSERT INTO status VALUES (4,4,'Registered',1,1);

--ccx
INSERT INTO status VALUES (5,5,'Registered',1,1);
INSERT INTO status VALUES (6,5,'Testing Complete',2,1);
INSERT INTO status VALUES (7,5,'Testing Failure',3,1);
INSERT INTO status VALUES (8,5,'Cancelled / Long Term Hold',4,1);
INSERT INTO status VALUES (9,5,'Waiting on WECA / WHQL Certification',5,1);
INSERT INTO status VALUES (10,5,'Payment Verified',7,1);
INSERT INTO status VALUES (11,5,'Testing Begins',8,1);

--cipc
INSERT INTO status VALUES (12,1,'Testing Failure',2,1);
INSERT INTO status VALUES (13,1,'Cancelled / Long Term Hold',3,1);
INSERT INTO status VALUES (14,1,'Cisco Complete',4,1);
INSERT INTO status VALUES (15,1,'Testing Scheduled',5,1);
INSERT INTO status VALUES (16,1,'KeyLabs Testing Complete',6,1);
INSERT INTO status VALUES (17,1,'Payment Verified',7,1);
INSERT INTO status VALUES (18,1,'Questionnaire Received',8,1);
INSERT INTO status VALUES (19,1,'On Hold',9,1);

--cmc
INSERT INTO status Values (20,6,'Registered',1,1);
INSERT INTO status VALUES (21,6,'Certification Complete',2,1);
INSERT INTO status VALUES (22,6,'Certification Failed',3,1);
INSERT INTO status VALUES (23,6,'Cancelled / Long-Term Hold',4,1);

--csa
INSERT INTO status VALUES (24,3,'Cancelled / Long-Term Hold',2,1);
INSERT INTO status VALUES (25,3,'Testing Complete',3,1);
INSERT INTO status VALUES (26,3,'Payment Received',4,1);
INSERT INTO status VALUES (27,3,'Testing Begins',5,1);

--cwn 4
INSERT INTO status VALUES (28,4,'Testing Complete',2,1);
INSERT INTO status VALUES (29,4,'Cancelled / Long Term Hold',3,1);
INSERT INTO status VALUES (30,4,'Testing Failure',4,1);
INSERT INTO status VALUES (31,4,'Payment Verified',5,1);

--ebay 7
INSERT INTO status VALUES (32,7,'Registered',1,1);
INSERT INTO status VALUES (33,7,'Testing Complete',2,1);
INSERT INTO status VALUES (34,7,'Cancelled / Long-Term Hold',3,1);

--hpux 8
INSERT INTO status VALUES (35,8,'Registered',1,1);
INSERT INTO status VALUES (36,8,'Certification Complete',2,1);
INSERT INTO status VALUES (37,8,'Participation Denied',3,1);
INSERT INTO status VALUES (38,8,'PreTest',4,1);

--jdbc 9
INSERT INTO status VALUES (39,9,'Registered',1,1);
INSERT INTO status VALUES (40,9,'Testing Complete',2,1);
INSERT INTO status VALUES (41,9,'Cancelled / Long-Term Hold',3,1);

--lnx 10
INSERT INTO status VALUES (42,10,'Registered',1,1);
INSERT INTO status VALUES (43,10,'Failed Testing',2,1);
INSERT INTO status VALUES (44,10,'Testing Complete',3,1);
INSERT INTO status VALUES (45,10,'Cancelled / Long-Term Hold',4,1);

--rn 11
INSERT INTO status VALUES (46,11,'Registered',1,1);
INSERT INTO status VALUES (47,11,'Certification Complete',2,1);
INSERT INTO status VALUES (48,11,'Certification Failed',3,1);
INSERT INTO status VALUES (49,11,'Cancelled / Long-Term Hold',4,1);

--sr 12
INSERT INTO status VALUES (50,12,'Registered',1,1);
INSERT INTO status VALUES (51,12,'Cancelled / Long-Term Hold',2,1);
INSERT INTO status VALUES (52,12,'Testing Failure',3,1);
INSERT INTO status VALUES (53,12,'On hold',4,1);
INSERT INTO status VALUES (54,12,'Participation Denied',5,1);
INSERT INTO status VALUES (55,12,'Testing Complete',6,1);
INSERT INTO status VALUES (56,12,'Third Party Testing Complete',7,1);
INSERT INTO status VALUES (57,12,'Participation Approved',8,1);
INSERT INTO status VALUES (58,12,'PreTest',9,1);

--st 13
INSERT INTO status VALUES (59,13,'Registered',1,1);
INSERT INTO status VALUES (60,13,'Certification Complete',2,1);
INSERT INTO status VALUES (61,13,'Cancelled / Long-Term Hold',3,1);
INSERT INTO status VALUES (62,13,'Eligible',4,1);
INSERT INTO status VALUES (63,13,'On hold',5,1);
INSERT INTO status VALUES (64,13,'PreTest',6,1);
INSERT INTO status VALUES (65,13,'Waiting for Reference',7,1);

--whql 14
INSERT INTO status VALUES (66,14,'Registered',1,1);
INSERT INTO status VALUES (67,14,'Testing Complete',2,1);
INSERT INTO status VALUES (68,14,'Testing Failure',3,1);
INSERT INTO status VALUES (69,14,'Cancelled / Long-Term Hold',4,1);

--novly 15
INSERT INTO status VALUES (70,15,'Registered',1,1);
INSERT INTO status VALUES (71,15,'Certification Complete',2,1);
INSERT INTO status VALUES (72,15,'Cancelled / Long-Term Hold',3,1);
INSERT INTO status VALUES (73,15,'Failed Certification',4,1);

--
-- Table structure for table `statusSet`
--

CREATE TABLE statusSet (
  id int(10) unsigned NOT NULL default '0',
  status_id int(10) unsigned NOT NULL default '0',
  step_id int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (id,status_id,step_id),
  KEY Table_11_FKIndex1 (status_id),
  KEY Table_11_FKIndex2 (step_id),
  KEY statusSet_index2419 (id)
) TYPE=MyISAM;

--
-- Dumping data for table `statusSet`
--


--
-- Table structure for table `step`
--

CREATE TABLE step (
  id int(10) unsigned NOT NULL auto_increment,
  prefix_id int(10) unsigned default NULL,
  name varchar(20) default NULL,
  orderIndex int(10) unsigned default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY step_index2379 (prefix_id)
) TYPE=MyISAM;

--
-- Dumping data for table `step`
--


--
-- Table structure for table `timeframe`
--

CREATE TABLE timeframe (
  id int(10) unsigned NOT NULL auto_increment,
  name varchar(10) default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table `timeframe`
--

INSERT INTO timeframe VALUES (1,'Other',1);

--
-- Table structure for table `user`
--

CREATE TABLE user (
  id int(10) unsigned NOT NULL auto_increment,
  company_id int(10) unsigned NOT NULL default '0',
  name varchar(25) default NULL,
  title varchar(50) default NULL,
  initials varchar(4) default NULL,
  email varchar(30) default NULL,
  phone varchar(20) default NULL,
  pass varchar(100) default NULL,
  lastLogin datetime default NULL,
  active tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY user_FKIndex1 (company_id)
) TYPE=MyISAM;

--
-- Dumping data for table `user`
--

INSERT INTO user VALUES (1,1,'Staff','Staff','stf',NULL,NULL,NULL,NULL,1);
UPDATE user SET id=0 WHERE id=1;
INSERT INTO user VALUES (2,1,'Patrick Felt','Super Admin','pgf','pfelt@keylabs.com','801-852-9533','fatpelt',NULL,1);

--
-- Table structure for table `userPermission`
--

CREATE TABLE userPermission (
  user_id int(10) unsigned NOT NULL auto_increment,
  permission_id int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (user_id,permission_id),
  KEY userPermission_index2240 (user_id),
  KEY userPermission_index2241 (permission_id)
) TYPE=MyISAM;

--
-- Dumping data for table `userPermission`
--

INSERT INTO userPermission VALUES (2,1);
INSERT INTO userPermission VALUES (2,2);
INSERT INTO userPermission VALUES (2,3);
INSERT INTO userPermission VALUES (2,4);
INSERT INTO userPermission VALUES (2,5);
INSERT INTO userPermission VALUES (2,6);
INSERT INTO userPermission VALUES (2,7);
INSERT INTO userPermission VALUES (2,8);
INSERT INTO userPermission VALUES (2,9);
INSERT INTO userPermission VALUES (2,10);
INSERT INTO userPermission VALUES (2,11);
INSERT INTO userPermission VALUES (2,12);
INSERT INTO userPermission VALUES (2,13);
INSERT INTO userPermission VALUES (2,14);
INSERT INTO userPermission VALUES (2,15);
INSERT INTO userPermission VALUES (2,16);

--
-- Table structure for table `userProductPriceList`
--

CREATE TABLE userProductPriceList (
  id int(10) unsigned NOT NULL auto_increment,
  user_id int(10) unsigned NOT NULL default '0',
  productPriceList_id int(10) unsigned NOT NULL default '0',
  mandatory tinyint(1) unsigned default NULL,
  PRIMARY KEY  (id),
  KEY userProductPriceList_index2348 (productPriceList_id),
  KEY userProductPriceList_index2350 (user_id)
) TYPE=MyISAM;

--
-- Dumping data for table `userProductPriceList`
--


