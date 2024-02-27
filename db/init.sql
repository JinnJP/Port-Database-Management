-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: sahapan
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-16 22:35:58
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: car_part
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `car_brand`
--

CREATE DATABASE src;
CREATE DATABASE dest;
USE src;

DROP TABLE IF EXISTS `car_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car_brand` (
  `car_brand_id` char(2) NOT NULL DEFAULT '',
  `car_brand_name` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`car_brand_id`),
  UNIQUE KEY `car_brand_name` (`car_brand_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO src.car_brand (car_brand_id, car_brand_name)
VALUES (1, "tesla"),
       (2, "toyota"),
       (3, "hyundai"),
       (4, "ford"),
       (5, "bmw");
--
-- Table structure for table `car_series`
--

DROP TABLE IF EXISTS `car_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car_series` (
  `car_series_id` char(3) NOT NULL DEFAULT '',
  `car_series_name` varchar(25) NOT NULL DEFAULT '',
  `car_brand_id` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`car_series_id`,`car_brand_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cust`
--

DROP TABLE IF EXISTS `cust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cust` (
  `cust_id` varchar(15) NOT NULL DEFAULT '',
  `cust_name` varchar(30) NOT NULL DEFAULT '',
  `cust_addr` varchar(30) NOT NULL DEFAULT '',
  `cust_city` varchar(15) NOT NULL DEFAULT '',
  `cust_tel` varchar(30) NOT NULL DEFAULT '',
  `cust_fax` varchar(15) NOT NULL DEFAULT '',
  `cust_email` varchar(20) NOT NULL DEFAULT '',
  `group_id` char(2) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dealer`
--

DROP TABLE IF EXISTS `dealer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dealer` (
  `dealer_id` varchar(4) NOT NULL DEFAULT '',
  `dealer_name` varchar(40) NOT NULL DEFAULT '',
  `dealer_addr` varchar(60) NOT NULL DEFAULT '',
  `dealer_city` varchar(20) NOT NULL DEFAULT '',
  `dealer_tel` varchar(15) NOT NULL DEFAULT '',
  `dealer_fax` varchar(15) NOT NULL DEFAULT '',
  `dealer_email` varchar(30) NOT NULL DEFAULT '',
  `agent_name` varchar(40) NOT NULL DEFAULT '',
  `agent_tel` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`dealer_id`),
  UNIQUE KEY `deler_name` (`dealer_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edit_productname`
--

DROP TABLE IF EXISTS `edit_productname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edit_productname` (
  `edit_list` int unsigned NOT NULL AUTO_INCREMENT,
  `old_product_id` varchar(30) NOT NULL DEFAULT '',
  `edit_product_id` varchar(30) NOT NULL DEFAULT '',
  `edit_product_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`edit_list`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edit_record`
--

DROP TABLE IF EXISTS `edit_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edit_record` (
  `edit_id` int unsigned NOT NULL AUTO_INCREMENT,
  `prod_id` varchar(45) NOT NULL DEFAULT '',
  `edit_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `from_amount` smallint unsigned NOT NULL DEFAULT '0',
  `to_amount` smallint unsigned NOT NULL DEFAULT '0',
  `employer_id` varchar(15) NOT NULL DEFAULT '',
  `supervisor_id` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`edit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee_list`
--

DROP TABLE IF EXISTS `employee_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_list` (
  `emp_id` varchar(15) NOT NULL,
  `emp_password` varchar(25) NOT NULL,
  `emp_name` varchar(45) NOT NULL,
  `emp_last_name` varchar(60) NOT NULL,
  `emp_address` varchar(100) NOT NULL,
  `emp_tel` varchar(25) NOT NULL,
  `emp_level` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_detail_name`
--

DROP TABLE IF EXISTS `group_detail_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_detail_name` (
  `group_list_id` char(3) NOT NULL DEFAULT '',
  `sub_group_list_id` char(3) NOT NULL DEFAULT '',
  `prop1_name` varchar(15) NOT NULL DEFAULT '',
  `prop2_name` varchar(15) NOT NULL DEFAULT '',
  `prop3_name` varchar(15) NOT NULL DEFAULT '',
  `prop4_name` varchar(15) NOT NULL DEFAULT '',
  `prop5_name` varchar(15) NOT NULL DEFAULT '',
  `prop6_name` varchar(15) NOT NULL DEFAULT '',
  `prop7_name` varchar(15) NOT NULL DEFAULT '',
  `prop8_name` varchar(15) NOT NULL DEFAULT '',
  `prop9_name` varchar(15) NOT NULL DEFAULT '',
  `prop10_name` varchar(15) NOT NULL DEFAULT '',
  `prop11_name` varchar(15) NOT NULL DEFAULT '',
  `prop12_name` varchar(15) NOT NULL DEFAULT '',
  `prop13_name` varchar(15) NOT NULL DEFAULT '',
  `prop14_name` varchar(15) NOT NULL DEFAULT '',
  `prop15_name` varchar(15) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grouplist`
--

DROP TABLE IF EXISTS `grouplist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grouplist` (
  `groupList_id` char(3) NOT NULL DEFAULT '',
  `groupList_name` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`groupList_id`),
  UNIQUE KEY `group_list_name` (`groupList_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `in_bill`
--

DROP TABLE IF EXISTS `in_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_bill` (
  `invoice` varchar(15) NOT NULL DEFAULT '',
  `bill_date` date NOT NULL DEFAULT '0000-00-00',
  `dealer_id` varchar(15) NOT NULL DEFAULT '',
  `prod_id` varchar(30) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `unit_prc` double NOT NULL DEFAULT '0',
  `user_name` varchar(20) NOT NULL DEFAULT '',
  `upd_date` date NOT NULL DEFAULT '0000-00-00',
  `bill_no` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`prod_id`,`bill_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_list`
--

DROP TABLE IF EXISTS `invoice_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_list` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cust_id` varchar(15) NOT NULL DEFAULT '',
  `bill_no` int unsigned NOT NULL DEFAULT '0',
  `upd_date` date NOT NULL DEFAULT '0000-00-00',
  `status` varchar(5) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31660 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loct`
--

DROP TABLE IF EXISTS `loct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loct` (
  `loct_id` varchar(20) NOT NULL DEFAULT '',
  `loct_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`loct_id`),
  UNIQUE KEY `loct_name` (`loct_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mapping_product_id`
--

DROP TABLE IF EXISTS `mapping_product_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mapping_product_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` varchar(30) NOT NULL DEFAULT '',
  `dealer_id` varchar(10) NOT NULL DEFAULT '',
  `dealer_product_id` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8224 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nakhonaliyont_em`
--

DROP TABLE IF EXISTS `nakhonaliyont_em`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nakhonaliyont_em` (
  `employeeslist` int unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(15) NOT NULL DEFAULT '',
  `name` varchar(45) NOT NULL DEFAULT '',
  `lastname` varchar(45) NOT NULL DEFAULT '',
  `address` varchar(150) NOT NULL DEFAULT '',
  `dadname` varchar(45) NOT NULL DEFAULT '',
  `momname` varchar(45) NOT NULL DEFAULT '',
  `tel1` varchar(45) NOT NULL DEFAULT '',
  `level` char(3) NOT NULL DEFAULT '',
  `brithday` varchar(45) NOT NULL DEFAULT '',
  `revenue` varchar(45) NOT NULL DEFAULT '',
  `holiday` varchar(100) NOT NULL DEFAULT '',
  `picture` blob NOT NULL,
  PRIMARY KEY (`employeeslist`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nakhonaliyont_ho2554`
--

DROP TABLE IF EXISTS `nakhonaliyont_ho2554`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nakhonaliyont_ho2554` (
  `holiday_list` int unsigned NOT NULL AUTO_INCREMENT,
  `date_l` char(2) NOT NULL DEFAULT '',
  `month_l` char(2) NOT NULL DEFAULT '',
  `status` varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`holiday_list`)
) ENGINE=MyISAM AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_tb`
--

DROP TABLE IF EXISTS `order_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_tb` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `prod_id` varchar(45) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '',
  `employee_id` varchar(15) NOT NULL DEFAULT '',
  `order_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dealer` varchar(15) NOT NULL DEFAULT '',
  `amount_order` smallint unsigned NOT NULL DEFAULT '0',
  `invoice_rec` varchar(15) NOT NULL DEFAULT '',
  `amount_in` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=241853 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `out_bill`
--

DROP TABLE IF EXISTS `out_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `out_bill` (
  `invoice` varchar(10) NOT NULL DEFAULT '',
  `cust_id` varchar(15) NOT NULL DEFAULT '',
  `prod_id` varchar(30) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `prod_unit_prc` double NOT NULL DEFAULT '0',
  `upd_date` date NOT NULL DEFAULT '0000-00-00',
  `bill_no` int unsigned NOT NULL DEFAULT '0',
  `prod_discount` double unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`prod_id`,`bill_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `part_stock_used`
--

DROP TABLE IF EXISTS `part_stock_used`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `part_stock_used` (
  `prod_used_id` int unsigned NOT NULL,
  `main_purpose` varchar(30) NOT NULL,
  `sub_purpose` varchar(45) NOT NULL,
  `detail` varchar(50) NOT NULL,
  `prod_id` varchar(30) NOT NULL,
  `prod_amount` varchar(5) NOT NULL,
  `prod_avg_prc` varchar(10) NOT NULL,
  `employee_id` varchar(45) NOT NULL,
  `upd_date` date NOT NULL,
  `prod_location_id` varchar(10) NOT NULL,
  `account_id` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod`
--

DROP TABLE IF EXISTS `prod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod` (
  `prod_id` varchar(30) NOT NULL DEFAULT '',
  `prod_name` varchar(50) NOT NULL DEFAULT '',
  `prod_on_hand` int NOT NULL DEFAULT '0',
  `prod_unit_name` varchar(15) NOT NULL DEFAULT '0',
  `prod_min_on_hand` varchar(5) NOT NULL DEFAULT '0',
  `prod_unit_prc` double unsigned NOT NULL DEFAULT '0',
  `prod_factory_id` varchar(30) NOT NULL DEFAULT '-',
  `prod_factory_name` varchar(30) NOT NULL DEFAULT '-',
  `prod_barcode_id` varchar(18) NOT NULL DEFAULT '',
  `prod_short_id` varchar(15) NOT NULL DEFAULT '-',
  `prod_upd_date` date NOT NULL DEFAULT '0000-00-00',
  `loct_id` varchar(20) DEFAULT NULL,
  `prod_price_b` double unsigned NOT NULL DEFAULT '0',
  `prod_price_c` double unsigned NOT NULL DEFAULT '0',
  `prod_price_d` double unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`prod_id`),
  KEY `prod_index` (`prod_id`,`prod_barcode_id`) USING BTREE,
  KEY `Index_fulltext` (`prod_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_detail`
--

DROP TABLE IF EXISTS `prod_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_detail` (
  `prod_id` varchar(15) NOT NULL DEFAULT '',
  `prop1` varchar(20) NOT NULL DEFAULT '-',
  `prop2` varchar(20) NOT NULL DEFAULT '-',
  `prop3` varchar(20) NOT NULL DEFAULT '-',
  `prop4` varchar(20) NOT NULL DEFAULT '-',
  `prop5` varchar(20) NOT NULL DEFAULT '-',
  `prop6` varchar(20) NOT NULL DEFAULT '-',
  `prop7` varchar(20) NOT NULL DEFAULT '-',
  `prop8` varchar(20) NOT NULL DEFAULT '-',
  `prop9` varchar(20) NOT NULL DEFAULT '-',
  `prop10` varchar(20) NOT NULL DEFAULT '-',
  `prop11` varchar(20) NOT NULL DEFAULT '-',
  `prop12` varchar(20) NOT NULL DEFAULT '-',
  `prop13` varchar(20) NOT NULL DEFAULT '-',
  `prop14` varchar(20) NOT NULL DEFAULT '-',
  `prop15` varchar(20) NOT NULL DEFAULT '-'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_used_reason`
--

DROP TABLE IF EXISTS `prod_used_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_used_reason` (
  `id` varchar(20) NOT NULL DEFAULT '',
  `details` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `producer`
--

DROP TABLE IF EXISTS `producer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producer` (
  `producer_id` char(3) NOT NULL DEFAULT '',
  `producer_name` varchar(15) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `return_bill`
--

DROP TABLE IF EXISTS `return_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `return_bill` (
  `invoice` varchar(10) NOT NULL DEFAULT '',
  `cust_id` varchar(15) NOT NULL DEFAULT '',
  `prod_id` varchar(30) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `prod_unit_prc` double NOT NULL DEFAULT '0',
  `upd_date` date NOT NULL DEFAULT '0000-00-00',
  `bill_no` int unsigned NOT NULL DEFAULT '0',
  `prod_discount` double DEFAULT NULL,
  PRIMARY KEY (`prod_id`,`bill_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `barcode_tracking_id` int unsigned NOT NULL AUTO_INCREMENT,
  `lastest_update` date NOT NULL DEFAULT '0000-00-00',
  `Invoice_no` mediumint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`barcode_tracking_id`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_grouplist`
--

DROP TABLE IF EXISTS `sub_grouplist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_grouplist` (
  `sub_grouplist_id` char(3) NOT NULL DEFAULT '',
  `sub_grouplist_name` varchar(40) NOT NULL DEFAULT '',
  `grouplist_id` char(3) DEFAULT NULL,
  PRIMARY KEY (`sub_grouplist_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_in_bill`
--

DROP TABLE IF EXISTS `temp_in_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_in_bill` (
  `bill_no` int unsigned NOT NULL DEFAULT '0',
  `invoice` varchar(15) NOT NULL DEFAULT '',
  `bill_date` date NOT NULL DEFAULT '0000-00-00',
  `dealer_id` varchar(15) NOT NULL DEFAULT '',
  `prod_id` varchar(30) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `unit_prc` double NOT NULL DEFAULT '0',
  `user_name` varchar(20) NOT NULL DEFAULT '',
  `upd_date` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`bill_no`,`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `type_id` varchar(15) NOT NULL DEFAULT '',
  `type_name` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` varchar(15) NOT NULL DEFAULT '',
  `user_name` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(15) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL DEFAULT '',
  `level` enum('1','2','3') NOT NULL DEFAULT '3'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_detail`
--

DROP TABLE IF EXISTS `user_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_detail` (
  `user_id` varchar(15) NOT NULL DEFAULT '',
  `addr` varchar(40) NOT NULL DEFAULT '',
  `tel1` varchar(10) NOT NULL DEFAULT '',
  `tel2` varchar(10) NOT NULL DEFAULT '',
  `fax` varchar(10) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(10) NOT NULL DEFAULT '',
  `password` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `level` enum('1','2','3') NOT NULL DEFAULT '1',
  `address` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-16 22:35:58
