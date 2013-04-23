-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 22, 2013 at 10:39 AM
-- Server version: 5.5.24-log
-- PHP Version: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `magento`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminnotification_inbox`
--

CREATE TABLE IF NOT EXISTS `adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `admin_assert`
--

CREATE TABLE IF NOT EXISTS `admin_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert ID',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert Type',
  `assert_data` text COMMENT 'Assert Data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Assert Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `admin_role`
--

CREATE TABLE IF NOT EXISTS `admin_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_ADMIN_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_ADMIN_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Admin Role Table' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `admin_role`
--

INSERT INTO `admin_role` (`role_id`, `parent_id`, `tree_level`, `sort_order`, `role_type`, `user_id`, `role_name`) VALUES
(1, 0, 1, 1, 'G', 0, 'Administrators'),
(2, 1, 2, 0, 'U', 1, 'Hat');

-- --------------------------------------------------------

--
-- Table structure for table `admin_rule`
--

CREATE TABLE IF NOT EXISTS `admin_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert ID',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role Type',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_ADMIN_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_ADMIN_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin_rule`
--

INSERT INTO `admin_rule` (`rule_id`, `role_id`, `resource_id`, `privileges`, `assert_id`, `role_type`, `permission`) VALUES
(1, 1, 'all', NULL, 0, 'G', 'allow');

-- --------------------------------------------------------

--
-- Table structure for table `admin_user`
--

CREATE TABLE IF NOT EXISTS `admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(40) DEFAULT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User Created Time',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UNQ_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Admin User Table' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin_user`
--

INSERT INTO `admin_user` (`user_id`, `firstname`, `lastname`, `email`, `username`, `password`, `created`, `modified`, `logdate`, `lognum`, `reload_acl_flag`, `is_active`, `extra`, `rp_token`, `rp_token_created_at`) VALUES
(1, 'Hat', 'Dao', 'hat@toprankseo.vn', 'john', '5fc8ae0d637ee3789226d3c87700922f:YQ', '2013-04-22 03:42:10', '2013-04-10 00:26:47', '2013-04-21 20:42:10', 16, 0, 1, 'a:1:{s:11:"configState";a:15:{s:12:"dev_restrict";s:1:"0";s:9:"dev_debug";s:1:"1";s:12:"dev_template";s:1:"0";s:20:"dev_translate_inline";s:1:"0";s:7:"dev_log";s:1:"1";s:6:"dev_js";s:1:"0";s:7:"dev_css";s:1:"0";s:14:"design_package";s:1:"0";s:12:"design_theme";s:1:"1";s:11:"design_head";s:1:"0";s:13:"design_header";s:1:"0";s:13:"design_footer";s:1:"0";s:16:"design_watermark";s:1:"0";s:17:"design_pagination";s:1:"0";s:12:"design_email";s:1:"0";}}', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `api2_acl_attribute`
--

CREATE TABLE IF NOT EXISTS `api2_acl_attribute` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `user_type` varchar(20) NOT NULL COMMENT 'Type of user',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `operation` varchar(20) NOT NULL COMMENT 'Operation',
  `allowed_attributes` text COMMENT 'Allowed attributes',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_ATTRIBUTE_USER_TYPE_RESOURCE_ID_OPERATION` (`user_type`,`resource_id`,`operation`),
  KEY `IDX_API2_ACL_ATTRIBUTE_USER_TYPE` (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Filter ACL Attributes' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `api2_acl_role`
--

CREATE TABLE IF NOT EXISTS `api2_acl_role` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `role_name` varchar(255) NOT NULL COMMENT 'Name of role',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_API2_ACL_ROLE_CREATED_AT` (`created_at`),
  KEY `IDX_API2_ACL_ROLE_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Roles' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `api2_acl_role`
--

INSERT INTO `api2_acl_role` (`entity_id`, `created_at`, `updated_at`, `role_name`) VALUES
(1, '2013-04-10 07:24:05', NULL, 'Guest'),
(2, '2013-04-10 07:24:05', NULL, 'Customer');

-- --------------------------------------------------------

--
-- Table structure for table `api2_acl_rule`
--

CREATE TABLE IF NOT EXISTS `api2_acl_rule` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `privilege` varchar(20) DEFAULT NULL COMMENT 'ACL Privilege',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_RULE_ROLE_ID_RESOURCE_ID_PRIVILEGE` (`role_id`,`resource_id`,`privilege`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Rules' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `api2_acl_user`
--

CREATE TABLE IF NOT EXISTS `api2_acl_user` (
  `admin_id` int(10) unsigned NOT NULL COMMENT 'Admin ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  UNIQUE KEY `UNQ_API2_ACL_USER_ADMIN_ID` (`admin_id`),
  KEY `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Users';

-- --------------------------------------------------------

--
-- Table structure for table `api_assert`
--

CREATE TABLE IF NOT EXISTS `api_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert id',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert type',
  `assert_data` text COMMENT 'Assert additional data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Asserts' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `api_role`
--

CREATE TABLE IF NOT EXISTS `api_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent role id',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role level in tree',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order to display on admin area',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User id',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_API_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_API_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Roles' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `api_rule`
--

CREATE TABLE IF NOT EXISTS `api_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Api rule Id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Api role Id',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Module code',
  `api_privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert id',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role type',
  `api_permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_API_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_API_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Rules' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `api_session`
--

CREATE TABLE IF NOT EXISTS `api_session` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'User id',
  `logdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Login date',
  `sessid` varchar(40) DEFAULT NULL COMMENT 'Sessioin id',
  KEY `IDX_API_SESSION_USER_ID` (`user_id`),
  KEY `IDX_API_SESSION_SESSID` (`sessid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Sessions';

-- --------------------------------------------------------

--
-- Table structure for table `api_user`
--

CREATE TABLE IF NOT EXISTS `api_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User id',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'First name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'Last name',
  `email` varchar(128) DEFAULT NULL COMMENT 'Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'Nickname',
  `api_key` varchar(40) DEFAULT NULL COMMENT 'Api key',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User record create date',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User record modify date',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quantity of log ins',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Refresh ACL flag',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Account status',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Users' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'awaiting',
  `created_time` datetime DEFAULT NULL,
  `deadline_time` datetime DEFAULT NULL,
  `event_time` datetime DEFAULT NULL,
  `agree` decimal(11,2) NOT NULL DEFAULT '0.00',
  `disagree` decimal(11,2) NOT NULL DEFAULT '0.00',
  `agree_weight` decimal(11,3) NOT NULL DEFAULT '0.000',
  `disagree_weight` decimal(11,3) NOT NULL DEFAULT '0.000',
  `category` varchar(255) NOT NULL DEFAULT '',
  `total_bets` decimal(11,2) NOT NULL DEFAULT '0.00',
  `user_post` varchar(255) NOT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`article_id`, `title`, `content`, `status`, `created_time`, `deadline_time`, `event_time`, `agree`, `disagree`, `agree_weight`, `disagree_weight`, `category`, `total_bets`, `user_post`) VALUES
(1, 'thtyhth', 'yththtyht', 'available', '2013-04-16 08:29:28', '2013-05-08 00:00:00', '2013-05-11 00:00:00', '23.45', '0.00', '0.000', '0.000', 'Science', '23.45', 'enjoy3013@gmail.com'),
(2, '2', '2', 'available', '2013-04-26 00:00:00', '2013-04-24 00:00:00', '2013-04-21 00:00:00', '3.02', '5.00', '0.000', '0.000', 'Sports', '8.02', 'enjoy3013@gmail.com'),
(3, '3', '3', 'available', '2013-04-25 00:00:00', '2013-04-30 00:00:00', '2013-05-29 00:00:00', '13.22', '2.22', '0.000', '0.000', 'Other', '15.44', 'enjoy3013@gmail.com'),
(4, 'fdfdf', 'dfdf', 'waiting', '2013-04-16 09:10:37', '2013-04-22 00:00:00', '2013-04-30 00:00:00', '0.00', '232.00', '0.000', '0.000', 'Science', '232.00', 'enjoy3013@gmail.com'),
(5, 'sdfsfsd', 'fsdfsdf', 'available', '2013-04-17 03:42:32', '2013-05-10 00:00:00', '2013-05-11 00:00:00', '32.20', '0.00', '0.000', '0.000', 'Science', '32.20', 'enjoy3013@gmail.com'),
(6, 'cvxvxvxcv', 'dfsfsf', 'available', '2013-04-17 03:47:30', '2013-05-09 00:00:00', '2013-05-11 00:00:00', '0.00', '0.00', '0.000', '0.000', 'Science', '0.00', 'enjoy3013@gmail.com'),
(7, 'manberros', 'manberros', 'available', '2013-04-17 10:01:24', '2013-04-30 00:00:00', '2013-05-01 00:00:00', '0.00', '23.45', '0.000', '0.000', 'Sports ', '23.45', 'enjoy3013@gmail.com'),
(8, 'vxcvxcv', 'cvxcvxcv', 'waiting', '2013-04-18 10:19:07', '2013-04-18 00:00:00', '2013-06-26 00:00:00', '23.00', '0.00', '0.000', '0.000', 'Economics', '23.00', ''),
(9, 'dsfsfd', 'sdfsdf', 'available', '2013-04-18 10:20:59', '2013-04-26 00:00:00', '2013-04-29 00:00:00', '0.00', '234.00', '0.000', '0.000', 'Politics', '234.00', ''),
(10, 'dfsdfsdf', 'sdfsfd', 'waiting', '2013-04-19 03:32:04', NULL, NULL, '23.00', '0.00', '0.000', '0.000', 'Politics', '23.00', 'enjoy3013@gmail.com'),
(11, 'Test balance', 'Test balance', 'awaiting', '2013-04-19 08:12:03', '2013-04-28 00:00:00', '2013-04-30 00:00:00', '3.22', '0.00', '40143.740', '0.000', 'Other', '3.22', 'enjoy3013@gmail.com'),
(12, 'Test balance', 'moah rybak', 'awaiting', '2013-04-19 08:22:23', '2013-05-22 00:00:00', '2013-05-24 00:00:00', '3.22', '0.00', '151394.740', '0.000', 'Other', '3.22', 'enjoy3013@gmail.com'),
(13, 'dfsdfsdf', 'sdfsdfsdfsdf', 'waiting', '2013-04-19 08:32:55', '2013-04-22 00:00:00', '2013-04-24 00:00:00', '3.22', '0.00', '12258.540', '0.000', 'Politics', '3.22', 'enjoy3013@gmail.com'),
(14, 'sdfsdf', 'fsdfsdfsdf', 'available', '2013-04-19 08:37:33', '2013-04-25 00:00:00', '2013-04-27 00:00:00', '0.43', '0.00', '3492.460', '0.000', 'Technology', '0.43', 'enjoy3013@gmail.com'),
(15, 'balance', 'dfsfsdf', 'available', '2013-04-19 08:39:13', '2013-04-23 00:00:00', '2013-04-25 00:00:00', '0.00', '3.78', '0.000', '19807.200', 'Politics', '3.78', 'enjoy3013@gmail.com'),
(16, 'fgdfgdfgdfgdfgdfgdf', 'gdfgdfgdfg', 'waiting', '2013-04-19 08:40:30', '2013-04-22 00:00:00', '2013-04-24 00:00:00', '0.48', '0.00', '1823.520', '0.000', 'Politics', '0.48', 'enjoy3013@gmail.com'),
(17, 'sdfsfsdfsdf', 'sfsdfsdfsdf', 'waiting', '2013-04-19 08:41:40', '2013-04-19 00:00:00', '2013-04-20 00:00:00', '0.00', '0.26', '0.000', '0.000', 'Politics', '0.26', 'enjoy3013@gmail.com'),
(18, 'gggfdgfdgf', 'fgfgfg', 'available', '2013-04-22 02:33:28', '2013-04-24 00:00:00', '2013-04-26 00:00:00', '0.00', '5.22', '0.000', '14229.720', 'Science', '5.22', 'enjoy3013@gmail.com'),
(19, 'fddfbdf', 'bdbfdbdb', 'available', '2013-04-22 02:37:46', '2013-04-23 00:00:00', '2013-04-25 00:00:00', '0.20', '0.00', '256.400', '0.000', 'Technology', '0.20', 'enjoy3013@gmail.com'),
(20, 'fddfbdf', 'bdbfdbdb', 'available', '2013-04-22 02:46:06', '2013-04-23 00:00:00', '2013-04-25 00:00:00', '0.20', '0.00', '254.600', '0.000', 'Technology', '0.20', 'enjoy3013@gmail.com'),
(21, 'dfgdfgdfgdf', 'gdfgfdgfdg', 'waiting', '2013-04-22 02:46:54', '2013-04-22 00:00:00', '2013-04-23 00:00:00', '0.00', '5.22', '0.000', '0.000', 'Sports ', '5.22', 'enjoy3013@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `article_category`
--

CREATE TABLE IF NOT EXISTS `article_category` (
  `category_id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `article_category`
--

INSERT INTO `article_category` (`category_id`, `name`) VALUES
(1, 'Science'),
(2, 'Technology'),
(3, 'Politics'),
(4, 'Economics'),
(5, 'Entertainment'),
(6, 'Sports '),
(7, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `captcha_log`
--

CREATE TABLE IF NOT EXISTS `captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';

-- --------------------------------------------------------

--
-- Table structure for table `cataloginventory_stock`
--

CREATE TABLE IF NOT EXISTS `cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cataloginventory_stock`
--

INSERT INTO `cataloginventory_stock` (`stock_id`, `stock_name`) VALUES
(1, 'Default');

-- --------------------------------------------------------

--
-- Table structure for table `cataloginventory_stock_item`
--

CREATE TABLE IF NOT EXISTS `cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `UNQ_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_STOCK_ID` (`product_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cataloginventory_stock_status`
--

CREATE TABLE IF NOT EXISTS `cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';

-- --------------------------------------------------------

--
-- Table structure for table `cataloginventory_stock_status_idx`
--

CREATE TABLE IF NOT EXISTS `cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';

-- --------------------------------------------------------

--
-- Table structure for table `cataloginventory_stock_status_tmp`
--

CREATE TABLE IF NOT EXISTS `cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';

-- --------------------------------------------------------

--
-- Table structure for table `catalogrule`
--

CREATE TABLE IF NOT EXISTS `catalogrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From Date',
  `to_date` date DEFAULT NULL COMMENT 'To Date',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `sub_is_enable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Rule Enable For Subitems',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_CATALOGRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalogrule_affected_product`
--

CREATE TABLE IF NOT EXISTS `catalogrule_affected_product` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Affected Product';

-- --------------------------------------------------------

--
-- Table structure for table `catalogrule_customer_group`
--

CREATE TABLE IF NOT EXISTS `catalogrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_CATALOGRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Customer Groups Relations';

-- --------------------------------------------------------

--
-- Table structure for table `catalogrule_group_website`
--

CREATE TABLE IF NOT EXISTS `catalogrule_group_website` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';

-- --------------------------------------------------------

--
-- Table structure for table `catalogrule_product`
--

CREATE TABLE IF NOT EXISTS `catalogrule_product` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `EAA51B56FF092A0DCB795D1CEF812B7B` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `IDX_CATALOGRULE_PRODUCT_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `IDX_CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalogrule_product_price`
--

CREATE TABLE IF NOT EXISTS `catalogrule_product_price` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `UNQ_CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalogrule_website`
--

CREATE TABLE IF NOT EXISTS `catalogrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_CATALOGRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Websites Relations';

-- --------------------------------------------------------

--
-- Table structure for table `catalogsearch_fulltext`
--

CREATE TABLE IF NOT EXISTS `catalogsearch_fulltext` (
  `fulltext_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`fulltext_id`),
  UNIQUE KEY `UNQ_CATALOGSEARCH_FULLTEXT_PRODUCT_ID_STORE_ID` (`product_id`,`store_id`),
  FULLTEXT KEY `FTI_CATALOGSEARCH_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Catalog search result table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalogsearch_query`
--

CREATE TABLE IF NOT EXISTS `catalogsearch_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `synonym_for` varchar(255) DEFAULT NULL COMMENT 'Synonym for',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  KEY `IDX_CATALOGSEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `IDX_CATALOGSEARCH_QUERY_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Catalog search query table' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `catalogsearch_query`
--

INSERT INTO `catalogsearch_query` (`query_id`, `query_text`, `num_results`, `popularity`, `redirect`, `synonym_for`, `store_id`, `display_in_terms`, `is_active`, `is_processed`, `updated_at`) VALUES
(1, 'dfdgdfg', 0, 1, NULL, NULL, 1, 1, 1, 1, '2013-04-11 20:45:47'),
(2, 'fddfgdfg', 0, 1, NULL, NULL, 1, 1, 1, 1, '2013-04-18 03:52:49'),
(3, 'ioiuouio', 0, 1, NULL, NULL, 1, 1, 1, 1, '2013-04-18 03:54:52');

-- --------------------------------------------------------

--
-- Table structure for table `catalogsearch_result`
--

CREATE TABLE IF NOT EXISTS `catalogsearch_result` (
  `query_id` int(10) unsigned NOT NULL COMMENT 'Query ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `relevance` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT 'Relevance',
  PRIMARY KEY (`query_id`,`product_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_QUERY_ID` (`query_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_anc_categs_index_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_category_anc_categs_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_anc_categs_index_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_category_anc_categs_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_CATEGORY_ID` (`category_id`),
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_anc_products_index_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_category_anc_products_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_CAT_CTGR_ANC_PRDS_IDX_IDX_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_anc_products_index_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_category_anc_products_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_CAT_CTGR_ANC_PRDS_IDX_TMP_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_entity`
--

CREATE TABLE IF NOT EXISTS `catalog_category_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attriute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_LEVEL` (`level`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_PATH_ENTITY_ID` (`path`,`entity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `catalog_category_entity`
--

INSERT INTO `catalog_category_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `parent_id`, `created_at`, `updated_at`, `path`, `position`, `level`, `children_count`) VALUES
(1, 3, 0, 0, '2013-04-10 00:26:08', '2013-04-10 00:26:08', '1', 0, 0, 1),
(2, 3, 3, 1, '2013-04-10 00:26:09', '2013-04-10 00:26:09', '1/2', 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_entity_datetime`
--

CREATE TABLE IF NOT EXISTS `catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DTIME_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_entity_decimal`
--

CREATE TABLE IF NOT EXISTS `catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DEC_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_entity_int`
--

CREATE TABLE IF NOT EXISTS `catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_INT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `catalog_category_entity_int`
--

INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1, 3, 67, 0, 1, 1),
(2, 3, 67, 1, 1, 1),
(3, 3, 42, 0, 2, 1),
(4, 3, 67, 0, 2, 1),
(5, 3, 42, 1, 2, 1),
(6, 3, 67, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_entity_text`
--

CREATE TABLE IF NOT EXISTS `catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_TEXT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `catalog_category_entity_text`
--

INSERT INTO `catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1, 3, 65, 0, 1, NULL),
(2, 3, 65, 1, 1, NULL),
(3, 3, 65, 0, 2, NULL),
(4, 3, 65, 1, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_entity_varchar`
--

CREATE TABLE IF NOT EXISTS `catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_VCHR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `catalog_category_entity_varchar`
--

INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) VALUES
(1, 3, 41, 0, 1, 'Root Catalog'),
(2, 3, 41, 1, 1, 'Root Catalog'),
(3, 3, 43, 1, 1, 'root-catalog'),
(4, 3, 41, 0, 2, 'Default Category'),
(5, 3, 41, 1, 2, 'Default Category'),
(6, 3, 49, 1, 2, 'PRODUCTS'),
(7, 3, 43, 1, 2, 'default-category');

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_product`
--

CREATE TABLE IF NOT EXISTS `catalog_category_product` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`category_id`,`product_id`),
  KEY `IDX_CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_product_index`
--

CREATE TABLE IF NOT EXISTS `catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `IDX_CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `15D3C269665C74C2219037D534F4B0DC` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_product_index_enbl_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_category_product_index_enbl_idx` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_ENBL_IDX_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_product_index_enbl_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_category_product_index_enbl_tmp` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_ENBL_TMP_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_product_index_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_category_product_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_IDX_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_category_product_index_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_category_product_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_TMP_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_compare_item`
--

CREATE TABLE IF NOT EXISTS `catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_eav_attribute`
--

CREATE TABLE IF NOT EXISTS `catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `is_configurable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Configurable',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  PRIMARY KEY (`attribute_id`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';

--
-- Dumping data for table `catalog_eav_attribute`
--

INSERT INTO `catalog_eav_attribute` (`attribute_id`, `frontend_input_renderer`, `is_global`, `is_visible`, `is_searchable`, `is_filterable`, `is_comparable`, `is_visible_on_front`, `is_html_allowed_on_front`, `is_used_for_price_rules`, `is_filterable_in_search`, `used_in_product_listing`, `used_for_sort_by`, `is_configurable`, `apply_to`, `is_visible_in_advanced_search`, `position`, `is_wysiwyg_enabled`, `is_used_for_promo_rules`) VALUES
(41, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(42, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(43, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(44, NULL, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, NULL, 0, 0, 1, 0),
(45, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(46, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(47, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(48, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(49, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(50, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(51, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(52, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(53, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(54, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(55, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(56, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(57, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(58, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(59, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(60, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(61, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(62, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(63, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(64, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(65, 'adminhtml/catalog_category_helper_sortby_available', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(66, 'adminhtml/catalog_category_helper_sortby_default', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(67, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(68, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(69, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(70, 'adminhtml/catalog_category_helper_pricestep', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(71, NULL, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, NULL, 1, 0, 0, 0),
(72, NULL, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, NULL, 1, 0, 1, 0),
(73, NULL, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, NULL, 1, 0, 1, 0),
(74, NULL, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, NULL, 1, 0, 0, 0),
(75, NULL, 2, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 'simple,configurable,virtual,bundle,downloadable', 1, 0, 0, 0),
(76, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'simple,configurable,virtual,bundle,downloadable', 0, 0, 0, 0),
(77, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'simple,configurable,virtual,bundle,downloadable', 0, 0, 0, 0),
(78, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'simple,configurable,virtual,bundle,downloadable', 0, 0, 0, 0),
(79, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'virtual,downloadable', 0, 0, 0, 0),
(80, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'simple,bundle', 0, 0, 0, 0),
(81, NULL, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 'simple', 1, 0, 0, 0),
(82, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(83, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(84, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(85, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(86, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, NULL, 0, 0, 0, 0),
(87, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, NULL, 0, 0, 0, 0),
(88, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(89, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(90, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'simple,configurable,virtual,bundle,downloadable', 0, 0, 0, 0),
(91, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'simple,configurable,virtual,bundle,downloadable', 0, 0, 0, 0),
(92, NULL, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 'simple', 1, 0, 0, 0),
(93, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, NULL, 0, 0, 0, 0),
(94, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, NULL, 0, 0, 0, 0),
(95, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(96, NULL, 2, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, NULL, 0, 0, 0, 0),
(97, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, NULL, 0, 0, 0, 0),
(98, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(99, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'simple,configurable,virtual,bundle,downloadable', 0, 0, 0, 0),
(100, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'simple,virtual', 0, 0, 0, 0),
(101, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'simple,virtual', 0, 0, 0, 0),
(102, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(103, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(104, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(105, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(106, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(107, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(108, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(109, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(110, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, NULL, 0, 0, 0, 0),
(111, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(112, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, NULL, 0, 0, 0, 0),
(113, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, NULL, 0, 0, 0, 0),
(114, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, NULL, 0, 0, 0, 0),
(115, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(116, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0),
(117, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'simple,configurable,bundle,grouped', 0, 0, 0, 0),
(118, 'adminhtml/catalog_product_helper_form_msrp_enabled', 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'simple,bundle,configurable,virtual,downloadable', 0, 0, 0, 0),
(119, 'adminhtml/catalog_product_helper_form_msrp_price', 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'simple,bundle,configurable,virtual,downloadable', 0, 0, 0, 0),
(120, NULL, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'simple,bundle,configurable,virtual,downloadable', 0, 0, 0, 0),
(121, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, 0),
(122, NULL, 2, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'simple,configurable,virtual,downloadable,bundle', 1, 0, 0, 0),
(123, 'giftmessage/adminhtml_product_helper_form_config', 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, 0),
(124, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'bundle', 0, 0, 0, 0),
(125, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'bundle', 0, 0, 0, 0),
(126, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'bundle', 0, 0, 0, 0),
(127, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'bundle', 0, 0, 0, 0),
(128, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'bundle', 0, 0, 0, 0),
(129, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'downloadable', 0, 0, 0, 0),
(130, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'downloadable', 0, 0, 0, 0),
(131, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'downloadable', 0, 0, 0, 0),
(132, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'downloadable', 0, 0, 0, 0),
(133, NULL, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_bundle_option`
--

CREATE TABLE IF NOT EXISTS `catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_bundle_option_value`
--

CREATE TABLE IF NOT EXISTS `catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_BUNDLE_OPTION_VALUE_OPTION_ID_STORE_ID` (`option_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_bundle_price_index`
--

CREATE TABLE IF NOT EXISTS `catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_bundle_selection`
--

CREATE TABLE IF NOT EXISTS `catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_bundle_selection_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  PRIMARY KEY (`selection_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_bundle_stock_index`
--

CREATE TABLE IF NOT EXISTS `catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_enabled_index`
--

CREATE TABLE IF NOT EXISTS `catalog_product_enabled_index` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  PRIMARY KEY (`product_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Visibility Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_SKU` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_datetime`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_decimal`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_gallery`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_GLR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_group_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_group_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CC12C83765B562314470A24F2BDD0F36` (`entity_id`,`all_groups`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_int`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_media_gallery`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_media_gallery_value`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  PRIMARY KEY (`value_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_text`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_tier_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `E8AB433B9ACB00343ABB312AD2FAB087` (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_entity_varchar`
--

CREATE TABLE IF NOT EXISTS `catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_eav`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_eav_decimal`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_eav_decimal_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_eav_decimal_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_eav_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_eav_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_group_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_group_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_GROUP_PRICE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `IDX_CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_bundle_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_bundle_opt_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_bundle_opt_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_bundle_sel_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_bundle_sel_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_bundle_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_cfg_opt_agr_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_cfg_opt_agr_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_cfg_opt_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_cfg_opt_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_downlod_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_downlod_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_final_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_final_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_opt_agr_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_opt_agr_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_opt_idx`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_opt_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_price_tmp`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_tier_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_index_website`
--

CREATE TABLE IF NOT EXISTS `catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_link`
--

CREATE TABLE IF NOT EXISTS `catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_LNK_TYPE_ID_PRD_ID_LNKED_PRD_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINK_TYPE_ID` (`link_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_link_attribute`
--

CREATE TABLE IF NOT EXISTS `catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `catalog_product_link_attribute`
--

INSERT INTO `catalog_product_link_attribute` (`product_link_attribute_id`, `link_type_id`, `product_link_attribute_code`, `data_type`) VALUES
(1, 1, 'position', 'int'),
(2, 3, 'position', 'int'),
(3, 3, 'qty', 'decimal'),
(4, 4, 'position', 'int'),
(5, 5, 'position', 'int');

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_link_attribute_decimal`
--

CREATE TABLE IF NOT EXISTS `catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_link_attribute_int`
--

CREATE TABLE IF NOT EXISTS `catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_PRODUCT_LINK_ATTRIBUTE_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_link_attribute_varchar`
--

CREATE TABLE IF NOT EXISTS `catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_link_type`
--

CREATE TABLE IF NOT EXISTS `catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `catalog_product_link_type`
--

INSERT INTO `catalog_product_link_type` (`link_type_id`, `code`) VALUES
(1, 'relation'),
(3, 'super'),
(4, 'up_sell'),
(5, 'cross_sell');

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_option`
--

CREATE TABLE IF NOT EXISTS `catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_option_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_option_title`
--

CREATE TABLE IF NOT EXISTS `catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_option_type_price`
--

CREATE TABLE IF NOT EXISTS `catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_option_type_title`
--

CREATE TABLE IF NOT EXISTS `catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_option_type_value`
--

CREATE TABLE IF NOT EXISTS `catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_relation`
--

CREATE TABLE IF NOT EXISTS `catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `IDX_CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_super_attribute`
--

CREATE TABLE IF NOT EXISTS `catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_super_attribute_label`
--

CREATE TABLE IF NOT EXISTS `catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_super_attribute_pricing`
--

CREATE TABLE IF NOT EXISTS `catalog_product_super_attribute_pricing` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `value_index` varchar(255) DEFAULT NULL COMMENT 'Value Index',
  `is_percent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Percent',
  `pricing_value` decimal(12,4) DEFAULT NULL COMMENT 'Pricing Value',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID_VAL_IDX_WS_ID` (`product_super_attribute_id`,`value_index`,`website_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRICING_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Pricing Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_super_link`
--

CREATE TABLE IF NOT EXISTS `catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_product_website`
--

CREATE TABLE IF NOT EXISTS `catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';

-- --------------------------------------------------------

--
-- Table structure for table `checkout_agreement`
--

CREATE TABLE IF NOT EXISTS `checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `checkout_agreement_store`
--

CREATE TABLE IF NOT EXISTS `checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';

-- --------------------------------------------------------

--
-- Table structure for table `cms_block`
--

CREATE TABLE IF NOT EXISTS `cms_block` (
  `block_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Block ID',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Block Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='CMS Block Table' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cms_block`
--

INSERT INTO `cms_block` (`block_id`, `title`, `identifier`, `content`, `creation_time`, `update_time`, `is_active`) VALUES
(1, 'Footer Links', 'footer_links', '<ul>\r\n<li><a href="{{store direct_url="about-magento-demo-store"}}">About Us</a></li>\r\n<li><a href="{{store direct_url="customer-service"}}">Customer Service</a></li>\r\n<li class="last privacy"><a href="{{store direct_url="privacy-policy-cookie-restriction-mode"}}">Privacy Policy</a></li>\r\n</ul>', '2013-04-10 00:25:40', '2013-04-10 00:25:42', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cms_block_store`
--

CREATE TABLE IF NOT EXISTS `cms_block_store` (
  `block_id` smallint(6) NOT NULL COMMENT 'Block ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`block_id`,`store_id`),
  KEY `IDX_CMS_BLOCK_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';

--
-- Dumping data for table `cms_block_store`
--

INSERT INTO `cms_block_store` (`block_id`, `store_id`) VALUES
(1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cms_page`
--

CREATE TABLE IF NOT EXISTS `cms_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Page ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `root_template` varchar(255) DEFAULT NULL COMMENT 'Page Template',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Page Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  PRIMARY KEY (`page_id`),
  KEY `IDX_CMS_PAGE_IDENTIFIER` (`identifier`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='CMS Page Table' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `cms_page`
--

INSERT INTO `cms_page` (`page_id`, `title`, `root_template`, `meta_keywords`, `meta_description`, `identifier`, `content_heading`, `content`, `creation_time`, `update_time`, `is_active`, `sort_order`, `layout_update_xml`, `custom_theme`, `custom_root_template`, `custom_layout_update_xml`, `custom_theme_from`, `custom_theme_to`) VALUES
(1, '404 Not Found 1', 'two_columns_right', 'Page keywords', 'Page description', 'no-route', NULL, '<div class="page-title"><h1>Whoops, our bad...</h1></div>\r\n<dl>\r\n<dt>The page you requested was not found, and we have a fine guess why.</dt>\r\n<dd>\r\n<ul class="disc">\r\n<li>If you typed the URL directly, please make sure the spelling is correct.</li>\r\n<li>If you clicked on a link to get here, the link is outdated.</li>\r\n</ul></dd>\r\n</dl>\r\n<dl>\r\n<dt>What can you do?</dt>\r\n<dd>Have no fear, help is near! There are many ways you can get back on track with Magento Store.</dd>\r\n<dd>\r\n<ul class="disc">\r\n<li><a href="#" onclick="history.go(-1); return false;">Go back</a> to the previous page.</li>\r\n<li>Use the search bar at the top of the page to search for your products.</li>\r\n<li>Follow these links to get you back on track!<br /><a href="{{store url=""}}">Store Home</a> <span class="separator">|</span> <a href="{{store url="customer/account"}}">My Account</a></li></ul></dd></dl>\r\n', '2013-04-10 00:25:40', '2013-04-10 00:25:40', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'Home page', 'homepage', NULL, NULL, 'home', NULL, '<div class="page-title">\r\n<h2>Home Page</h2>\r\n</div>', '2013-04-10 00:25:40', '2013-04-11 19:55:06', 1, 0, '<!--<reference name="content">\r\n        <block type="catalog/product_new" name="home.catalog.product.new" alias="product_new" template="catalog/product/new.phtml" after="cms_page">\r\n            <action method="addPriceBlockType">\r\n                <type>bundle</type>\r\n                <block>bundle/catalog_product_price</block>\r\n                <template>bundle/catalog/product/price.phtml</template>\r\n            </action>\r\n        </block>\r\n        <block type="reports/product_viewed" name="home.reports.product.viewed" alias="product_viewed" template="reports/home_product_viewed.phtml" after="product_new">\r\n            <action method="addPriceBlockType">\r\n                <type>bundle</type>\r\n                <block>bundle/catalog_product_price</block>\r\n                <template>bundle/catalog/product/price.phtml</template>\r\n            </action>\r\n        </block>\r\n        <block type="reports/product_compared" name="home.reports.product.compared" template="reports/home_product_compared.phtml" after="product_viewed">\r\n            <action method="addPriceBlockType">\r\n                <type>bundle</type>\r\n                <block>bundle/catalog_product_price</block>\r\n                <template>bundle/catalog/product/price.phtml</template>\r\n            </action>\r\n        </block>\r\n    </reference>\r\n    <reference name="right">\r\n        <action method="unsetChild"><alias>right.reports.product.viewed</alias></action>\r\n        <action method="unsetChild"><alias>right.reports.product.compared</alias></action>\r\n    </reference>-->', NULL, NULL, NULL, NULL, NULL),
(3, 'Help', 'default', NULL, NULL, 'help', NULL, '<br />\r\n<div class="two-third">\r\n<h6 class="toggle-trigger"><a href="#">What is Bets of Bitcoin?</a></h6>\r\n<div class="toggle-container" style="display: none;">Bets of Bitcoin is a website where you can bet on upcoming real world events. Events can be anything from elections to product launches. Every bet is a statement on the outcome of these events. Bettors bet on if the statement will turn out to be true or false, in other words they agree or disagree with the statement. After the event, site moderators decide if the statement turned out to be true or not. Bets on the losing side is distributed to winners, statement submitter and the site.</div>\r\n<h6 class="toggle-trigger"><a href="#">What is bitcoin?</a></h6>\r\n<div class="toggle-container" style="display: none;">Bitcoin is a peer-to-peer digital currency. It can be used anonymously and with very low transaction fees. It is not controlled by a central authority and total bitcoins that will ever be issued is limited. For more information see <a href="http://www.weusecoins.com">WeUseCoins</a> website or read the <a href="https://en.bitcoin.it/wiki/FAQ">official FAQ</a>.</div>\r\n<h6 class="toggle-trigger"><a href="#">How do I bet on a statement?</a></h6>\r\n<div class="toggle-container" style="display: none;">You need two things to bet on a statement. First you need to <a href="/register">register</a> a free account. Second you need to deposit some bitcoins to the bitcoin address you are given. Then <a href="/list">choose a statement</a> to bet and fill out the form on the right hand side of the statement page. Currently minimum bet is 0.1. Don''t forget, early bets win more.</div>\r\n<h6 class="toggle-trigger"><a href="#">What are the different statement statuses (Available, Waiting, Closed)?</a></h6>\r\n<div class="toggle-container" style="display: none;">Available statements are the ones available for betting, that is they are approved by the moderators and deadline hasn''t passed yet.<br /> Waiting statements are the ones which passed their deadlines, after the event date they will be decided and closed.<br /> Closed statements are the ones which passed their event dates and decided by the moderators.</div>\r\n<h6 class="toggle-trigger"><a href="#">What are the colored bubbles in the statement list?</a></h6>\r\n<div class="toggle-container" style="display: none;">Green bubble represent the amount of agreeing bets.<br /> Red bubble represent the amount of disagreeing bets.<br /> Gray bubble represent the time remaining until the betting deadline.</div>\r\n<h6 class="toggle-trigger"><a href="#">What is the difference between deadline and event date?</a></h6>\r\n<div class="toggle-container" style="display: none;">Deadline day is the last day bets are allowed.<br /> Event day is the day statement refers to.<br /> Deadline must be at least one day, at most four weeks before the event day. All dates refer to end of day Eastern Time.</div>\r\n<h6 class="toggle-trigger"><a href="#">What is a weighted bet?</a></h6>\r\n<div class="toggle-container" style="display: none;">To promote early bettors on a statement, we distribute 45% of the lost bets such that early bettors get a larger share. Each bet is time weighted and get a share from this portion proportional to the weighted value. Weight of a bet is simply the minutes between the time of the bet and betting deadline. For an example, see the answer of "How are the losing bets distributed?".</div>\r\n<h6 class="toggle-trigger"><a href="#">What is the best betting strategy?</a></h6>\r\n<div class="toggle-container" style="display: none;">Betting involves balancing two incentives. Waiting for the deadline may give you extra information about the upcoming event, but early bets earn a higher weight. So bet as soon as you are confident about the result, bet more for higher profits. Also you can always add more bets later on.</div>\r\n<h6 class="toggle-trigger"><a href="#">What happens after I bet?</a></h6>\r\n<div class="toggle-container" style="display: none;">You need to bet before the bet deadline. After the deadline all bets are closed and we wait for the event date. When the event date pass, site moderators decide if the statement turned out to be true or false. Bets on the incorrect side is distributed among winners, statement submitter and site. If the statement turns out to be true or false before the deadline, bet deadline is changed to the end of previous day and bets are closed.</div>\r\n<h6 class="toggle-trigger"><a href="#">How are the losing bets distributed?</a></h6>\r\n<div class="toggle-container" style="display: none;">Here is the breakdown of the distribution:<br /> 45% goes to the bet winners proportional to their bets.<br /> 45% goes to the bet winners proportional to their weighted bets.<br /> 5% goes to the user who submitted the bet.<br /> 5% goes to the site.<br /><br /> Here is an example:<br /> Let''s say total of 10 btc is lost on a statement and there are three users who won:<br /> User A bets 1 btc 6000 minutes before the deadline (weighted bet of 6000), she is also the submitter.<br /> User B bets 3 btc 1000 minutes before the deadline (weighted bet of 3000)<br /> User C bets 1 btc at the last second (weighted bet of 0)<br /> 4.5 btc is distributed proportional to bets:<br /> User A gets 0.9, User B gets 2.7, User C gets 0.9.<br /> 4.5 btc is distributed proportional to weighted bets:<br /> User A gets 3.0, User B gets 1.5, User C gets 0.<br /> User A also receives 0.5 commission as a submitter.<br /> So in total:<br /> User A profits 4.4, User B profits 4.2, User C profits 0.9, and site profits 0.5.<br /> Obviously every winner also receives back the bet they put.<br /> Take home message: Bet early, win more.</div>\r\n<h6 class="toggle-trigger"><a href="#">What happens if the statement can not be decided?</a></h6>\r\n<div class="toggle-container" style="display: none;">If the moderators eventually decide that statement turned out to be undecidable (e.g. sports event is canceled), they will call it a draw and everyone will get their bets back without any commissions.</div>\r\n<h6 class="toggle-trigger"><a href="#">Can I submit multiple bets on the same statement?</a></h6>\r\n<div class="toggle-container" style="display: none;">Yes, as many as you want. You can even bet on the opposite side if you change your mind and want to recover your possible lost.</div>\r\n<h6 class="toggle-trigger"><a href="#">How do I submit a new statement to bet?</a></h6>\r\n<div class="toggle-container" style="display: none;">You can use our <a href="submit">submit page</a>. Just fill out the form and click submit. There is a submission fee of 0.1. Also you need to take a side, by placing a bet on the statement.</div>\r\n<h6 class="toggle-trigger"><a href="#">What are the best practices when submitting a statement?</a></h6>\r\n<div class="toggle-container" style="display: none;">Most important thing is to make it unambiguously decidable. Giving an official source for decision is a huge plus. You should give background and current opinions about the subject in the description. While choosing the statement, look for controversial topics, so that there will be bets on both sides and your chances of getting a higher commission increases.</div>\r\n<h6 class="toggle-trigger"><a href="#">How do I deposit bitcoins to my account?</a></h6>\r\n<div class="toggle-container" style="display: none;">Your deposit address is on your <a href="/profile">profile</a> page. Using your bitcoin software you can send bitcoins to your account. Bitcoins will be available for betting and withdrawal when they are confirmed by the bitcoin network.</div>\r\n<h6 class="toggle-trigger"><a href="#">How long does it take to get my funds confirmed?</a></h6>\r\n<div class="toggle-container" style="display: none;">As any other transaction in the bitcoin network, your deposited funds need to be confirmed. You should be able to see your unconfirmed transaction in your transaction history in a few minutes. They should be available in ten to twenty minutes.</div>\r\n<h6 class="toggle-trigger"><a href="#">How do I withdraw bitcoins from my account?</a></h6>\r\n<div class="toggle-container" style="display: none;">Set a withdrawal <a href="/address">address</a> and fill out the withdrawal <a href="/withdraw">form</a>. Your bitcoins will be send instantly. You can see the details of the transaction in your transactions list on your <a href="/profile">profile</a> page.</div>\r\n<br /> Please let us know if you have a <a href="http://betsofbitcoin.uservoice.com">feature request</a>.</div>', '2013-04-10 00:25:41', '2013-04-16 03:52:13', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Customer Service', 'three_columns', NULL, NULL, 'customer-service', NULL, '<div class="page-title">\r\n<h1>Customer Service</h1>\r\n</div>\r\n<ul class="disc">\r\n<li><a href="#answer1">Shipping &amp; Delivery</a></li>\r\n<li><a href="#answer2">Privacy &amp; Security</a></li>\r\n<li><a href="#answer3">Returns &amp; Replacements</a></li>\r\n<li><a href="#answer4">Ordering</a></li>\r\n<li><a href="#answer5">Payment, Pricing &amp; Promotions</a></li>\r\n<li><a href="#answer6">Viewing Orders</a></li>\r\n<li><a href="#answer7">Updating Account Information</a></li>\r\n</ul>\r\n<dl>\r\n<dt id="answer1">Shipping &amp; Delivery</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id="answer2">Privacy &amp; Security</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id="answer3">Returns &amp; Replacements</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id="answer4">Ordering</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id="answer5">Payment, Pricing &amp; Promotions</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id="answer6">Viewing Orders</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n<dt id="answer7">Updating Account Information</dt>\r\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec, justo.</dd>\r\n</dl>', '2013-04-10 00:25:41', '2013-04-10 00:25:41', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Enable Cookies', 'one_column', NULL, NULL, 'enable-cookies', NULL, '<div class="std">\r\n    <ul class="messages">\r\n        <li class="notice-msg">\r\n            <ul>\r\n                <li>Please enable cookies in your web browser to continue.</li>\r\n            </ul>\r\n        </li>\r\n    </ul>\r\n    <div class="page-title">\r\n        <h1><a name="top"></a>What are Cookies?</h1>\r\n    </div>\r\n    <p>Cookies are short pieces of data that are sent to your computer when you visit a website. On later visits, this data is then returned to that website. Cookies allow us to recognize you automatically whenever you visit our site so that we can personalize your experience and provide you with better service. We also use cookies (and similar browser data, such as Flash cookies) for fraud prevention and other purposes. If your web browser is set to refuse cookies from our website, you will not be able to complete a purchase or take advantage of certain features of our website, such as storing items in your Shopping Cart or receiving personalized recommendations. As a result, we strongly encourage you to configure your web browser to accept cookies from our website.</p>\r\n    <h2 class="subtitle">Enabling Cookies</h2>\r\n    <ul class="disc">\r\n        <li><a href="#ie7">Internet Explorer 7.x</a></li>\r\n        <li><a href="#ie6">Internet Explorer 6.x</a></li>\r\n        <li><a href="#firefox">Mozilla/Firefox</a></li>\r\n        <li><a href="#opera">Opera 7.x</a></li>\r\n    </ul>\r\n    <h3><a name="ie7"></a>Internet Explorer 7.x</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Start Internet Explorer</p>\r\n        </li>\r\n        <li>\r\n            <p>Under the <strong>Tools</strong> menu, click <strong>Internet Options</strong></p>\r\n            <p><img src="{{skin url="images/cookies/ie7-1.gif"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click the <strong>Privacy</strong> tab</p>\r\n            <p><img src="{{skin url="images/cookies/ie7-2.gif"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click the <strong>Advanced</strong> button</p>\r\n            <p><img src="{{skin url="images/cookies/ie7-3.gif"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Put a check mark in the box for <strong>Override Automatic Cookie Handling</strong>, put another check mark in the <strong>Always accept session cookies </strong>box</p>\r\n            <p><img src="{{skin url="images/cookies/ie7-4.gif"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click <strong>OK</strong></p>\r\n            <p><img src="{{skin url="images/cookies/ie7-5.gif"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click <strong>OK</strong></p>\r\n            <p><img src="{{skin url="images/cookies/ie7-6.gif"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Restart Internet Explore</p>\r\n        </li>\r\n    </ol>\r\n    <p class="a-top"><a href="#top">Back to Top</a></p>\r\n    <h3><a name="ie6"></a>Internet Explorer 6.x</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Select <strong>Internet Options</strong> from the Tools menu</p>\r\n            <p><img src="{{skin url="images/cookies/ie6-1.gif"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Privacy</strong> tab</p>\r\n        </li>\r\n        <li>\r\n            <p>Click the <strong>Default</strong> button (or manually slide the bar down to <strong>Medium</strong>) under <strong>Settings</strong>. Click <strong>OK</strong></p>\r\n            <p><img src="{{skin url="images/cookies/ie6-2.gif"}}" alt="" /></p>\r\n        </li>\r\n    </ol>\r\n    <p class="a-top"><a href="#top">Back to Top</a></p>\r\n    <h3><a name="firefox"></a>Mozilla/Firefox</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Click on the <strong>Tools</strong>-menu in Mozilla</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Options...</strong> item in the menu - a new window open</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Privacy</strong> selection in the left part of the window. (See image below)</p>\r\n            <p><img src="{{skin url="images/cookies/firefox.png"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>Expand the <strong>Cookies</strong> section</p>\r\n        </li>\r\n        <li>\r\n            <p>Check the <strong>Enable cookies</strong> and <strong>Accept cookies normally</strong> checkboxes</p>\r\n        </li>\r\n        <li>\r\n            <p>Save changes by clicking <strong>Ok</strong>.</p>\r\n        </li>\r\n    </ol>\r\n    <p class="a-top"><a href="#top">Back to Top</a></p>\r\n    <h3><a name="opera"></a>Opera 7.x</h3>\r\n    <ol>\r\n        <li>\r\n            <p>Click on the <strong>Tools</strong> menu in Opera</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Preferences...</strong> item in the menu - a new window open</p>\r\n        </li>\r\n        <li>\r\n            <p>Click on the <strong>Privacy</strong> selection near the bottom left of the window. (See image below)</p>\r\n            <p><img src="{{skin url="images/cookies/opera.png"}}" alt="" /></p>\r\n        </li>\r\n        <li>\r\n            <p>The <strong>Enable cookies</strong> checkbox must be checked, and <strong>Accept all cookies</strong> should be selected in the &quot;<strong>Normal cookies</strong>&quot; drop-down</p>\r\n        </li>\r\n        <li>\r\n            <p>Save changes by clicking <strong>Ok</strong></p>\r\n        </li>\r\n    </ol>\r\n    <p class="a-top"><a href="#top">Back to Top</a></p>\r\n</div>\r\n', '2013-04-10 00:25:41', '2013-04-10 00:25:41', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Privacy Policy', 'one_column', NULL, NULL, 'privacy-policy-cookie-restriction-mode', 'Privacy Policy', '<p style="color: #ff0000; font-weight: bold; font-size: 13px">\n    Please replace this text with you Privacy Policy.\n    Please add any additional cookies your website uses below (e.g., Google Analytics)\n</p>\n<p>\n    This privacy policy sets out how {{config path="general/store_information/name"}} uses and protects any information\n    that you give {{config path="general/store_information/name"}} when you use this website.\n    {{config path="general/store_information/name"}} is committed to ensuring that your privacy is protected.\n    Should we ask you to provide certain information by which you can be identified when using this website,\n    then you can be assured that it will only be used in accordance with this privacy statement.\n    {{config path="general/store_information/name"}} may change this policy from time to time by updating this page.\n    You should check this page from time to time to ensure that you are happy with any changes.\n</p>\n<h2>What we collect</h2>\n<p>We may collect the following information:</p>\n<ul>\n    <li>name</li>\n    <li>contact information including email address</li>\n    <li>demographic information such as postcode, preferences and interests</li>\n    <li>other information relevant to customer surveys and/or offers</li>\n</ul>\n<p>\n    For the exhaustive list of cookies we collect see the <a href="#list">List of cookies we collect</a> section.\n</p>\n<h2>What we do with the information we gather</h2>\n<p>\n    We require this information to understand your needs and provide you with a better service,\n    and in particular for the following reasons:\n</p>\n<ul>\n    <li>Internal record keeping.</li>\n    <li>We may use the information to improve our products and services.</li>\n    <li>\n        We may periodically send promotional emails about new products, special offers or other information which we\n        think you may find interesting using the email address which you have provided.\n    </li>\n    <li>\n        From time to time, we may also use your information to contact you for market research purposes.\n        We may contact you by email, phone, fax or mail. We may use the information to customise the website\n        according to your interests.\n    </li>\n</ul>\n<h2>Security</h2>\n<p>\n    We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure,\n    we have put in place suitable physical, electronic and managerial procedures to safeguard and secure\n    the information we collect online.\n</p>\n<h2>How we use cookies</h2>\n<p>\n    A cookie is a small file which asks permission to be placed on your computer''s hard drive.\n    Once you agree, the file is added and the cookie helps analyse web traffic or lets you know when you visit\n    a particular site. Cookies allow web applications to respond to you as an individual. The web application\n    can tailor its operations to your needs, likes and dislikes by gathering and remembering information about\n    your preferences.\n</p>\n<p>\n    We use traffic log cookies to identify which pages are being used. This helps us analyse data about web page traffic\n    and improve our website in order to tailor it to customer needs. We only use this information for statistical\n    analysis purposes and then the data is removed from the system.\n</p>\n<p>\n    Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find useful\n    and which you do not. A cookie in no way gives us access to your computer or any information about you,\n    other than the data you choose to share with us. You can choose to accept or decline cookies.\n    Most web browsers automatically accept cookies, but you can usually modify your browser setting\n    to decline cookies if you prefer. This may prevent you from taking full advantage of the website.\n</p>\n<h2>Links to other websites</h2>\n<p>\n    Our website may contain links to other websites of interest. However, once you have used these links\n    to leave our site, you should note that we do not have any control over that other website.\n    Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst\n    visiting such sites and such sites are not governed by this privacy statement.\n    You should exercise caution and look at the privacy statement applicable to the website in question.\n</p>\n<h2>Controlling your personal information</h2>\n<p>You may choose to restrict the collection or use of your personal information in the following ways:</p>\n<ul>\n    <li>\n        whenever you are asked to fill in a form on the website, look for the box that you can click to indicate\n        that you do not want the information to be used by anybody for direct marketing purposes\n    </li>\n    <li>\n        if you have previously agreed to us using your personal information for direct marketing purposes,\n        you may change your mind at any time by writing to or emailing us at\n        {{config path="trans_email/ident_general/email"}}\n    </li>\n</ul>\n<p>\n    We will not sell, distribute or lease your personal information to third parties unless we have your permission\n    or are required by law to do so. We may use your personal information to send you promotional information\n    about third parties which we think you may find interesting if you tell us that you wish this to happen.\n</p>\n<p>\n    You may request details of personal information which we hold about you under the Data Protection Act 1998.\n    A small fee will be payable. If you would like a copy of the information held on you please write to\n    {{config path="general/store_information/address"}}.\n</p>\n<p>\n    If you believe that any information we are holding on you is incorrect or incomplete,\n    please write to or email us as soon as possible, at the above address.\n    We will promptly correct any information found to be incorrect.\n</p>\n<h2><a name="list"></a>List of cookies we collect</h2>\n<p>The table below lists the cookies we collect and what information they store.</p>\n<table class="data-table">\n    <thead>\n        <tr>\n            <th>COOKIE name</th>\n            <th>COOKIE Description</th>\n        </tr>\n    </thead>\n    <tbody>\n        <tr>\n            <th>CART</th>\n            <td>The association with your shopping cart.</td>\n        </tr>\n        <tr>\n            <th>CATEGORY_INFO</th>\n            <td>Stores the category info on the page, that allows to display pages more quickly.</td>\n        </tr>\n        <tr>\n            <th>COMPARE</th>\n            <td>The items that you have in the Compare Products list.</td>\n        </tr>\n        <tr>\n            <th>CURRENCY</th>\n            <td>Your preferred currency</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER</th>\n            <td>An encrypted version of your customer id with the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_AUTH</th>\n            <td>An indicator if you are currently logged into the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_INFO</th>\n            <td>An encrypted version of the customer group you belong to.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_SEGMENT_IDS</th>\n            <td>Stores the Customer Segment ID</td>\n        </tr>\n        <tr>\n            <th>EXTERNAL_NO_CACHE</th>\n            <td>A flag, which indicates whether caching is disabled or not.</td>\n        </tr>\n        <tr>\n            <th>FRONTEND</th>\n            <td>You sesssion ID on the server.</td>\n        </tr>\n        <tr>\n            <th>GUEST-VIEW</th>\n            <td>Allows guests to edit their orders.</td>\n        </tr>\n        <tr>\n            <th>LAST_CATEGORY</th>\n            <td>The last category you visited.</td>\n        </tr>\n        <tr>\n            <th>LAST_PRODUCT</th>\n            <td>The most recent product you have viewed.</td>\n        </tr>\n        <tr>\n            <th>NEWMESSAGE</th>\n            <td>Indicates whether a new message has been received.</td>\n        </tr>\n        <tr>\n            <th>NO_CACHE</th>\n            <td>Indicates whether it is allowed to use cache.</td>\n        </tr>\n        <tr>\n            <th>PERSISTENT_SHOPPING_CART</th>\n            <td>A link to information about your cart and viewing history if you have asked the site.</td>\n        </tr>\n        <tr>\n            <th>POLL</th>\n            <td>The ID of any polls you have recently voted in.</td>\n        </tr>\n        <tr>\n            <th>POLLN</th>\n            <td>Information on what polls you have voted on.</td>\n        </tr>\n        <tr>\n            <th>RECENTLYCOMPARED</th>\n            <td>The items that you have recently compared.            </td>\n        </tr>\n        <tr>\n            <th>STF</th>\n            <td>Information on products you have emailed to friends.</td>\n        </tr>\n        <tr>\n            <th>STORE</th>\n            <td>The store view or language you have selected.</td>\n        </tr>\n        <tr>\n            <th>USER_ALLOWED_SAVE_COOKIE</th>\n            <td>Indicates whether a customer allowed to use cookies.</td>\n        </tr>\n        <tr>\n            <th>VIEWED_PRODUCT_IDS</th>\n            <td>The products that you have recently viewed.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST</th>\n            <td>An encrypted list of products added to your Wishlist.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST_CNT</th>\n            <td>The number of items in your Wishlist.</td>\n        </tr>\n    </tbody>\n</table>', '2013-04-10 00:25:42', '2013-04-10 00:25:42', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cms_page_store`
--

CREATE TABLE IF NOT EXISTS `cms_page_store` (
  `page_id` smallint(6) NOT NULL COMMENT 'Page ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `IDX_CMS_PAGE_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';

--
-- Dumping data for table `cms_page_store`
--

INSERT INTO `cms_page_store` (`page_id`, `store_id`) VALUES
(1, 0),
(4, 0),
(5, 0),
(6, 0),
(2, 1),
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `core_cache`
--

CREATE TABLE IF NOT EXISTS `core_cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `IDX_CORE_CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';

-- --------------------------------------------------------

--
-- Table structure for table `core_cache_option`
--

CREATE TABLE IF NOT EXISTS `core_cache_option` (
  `code` varchar(32) NOT NULL COMMENT 'Code',
  `value` smallint(6) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache Options';

--
-- Dumping data for table `core_cache_option`
--

INSERT INTO `core_cache_option` (`code`, `value`) VALUES
('block_html', 0),
('collections', 0),
('config', 0),
('config_api', 0),
('config_api2', 0),
('eav', 0),
('layout', 0),
('translate', 0);

-- --------------------------------------------------------

--
-- Table structure for table `core_cache_tag`
--

CREATE TABLE IF NOT EXISTS `core_cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `IDX_CORE_CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';

-- --------------------------------------------------------

--
-- Table structure for table `core_config_data`
--

CREATE TABLE IF NOT EXISTS `core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `UNQ_CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Config Data' AUTO_INCREMENT=61 ;

--
-- Dumping data for table `core_config_data`
--

INSERT INTO `core_config_data` (`config_id`, `scope`, `scope_id`, `path`, `value`) VALUES
(1, 'default', 0, 'general/region/display_all', '1'),
(2, 'default', 0, 'general/region/state_required', 'AT,CA,CH,DE,EE,ES,FI,FR,LT,LV,RO,US'),
(3, 'default', 0, 'catalog/category/root_id', '2'),
(4, 'default', 0, 'admin/dashboard/enable_charts', '1'),
(5, 'default', 0, 'web/unsecure/base_url', 'http://my.local/magento/'),
(6, 'default', 0, 'web/secure/base_url', 'http://my.local/magento/'),
(7, 'default', 0, 'general/locale/code', 'en_US'),
(8, 'default', 0, 'general/locale/timezone', 'America/Los_Angeles'),
(9, 'default', 0, 'currency/options/base', 'USD'),
(10, 'default', 0, 'currency/options/default', 'USD'),
(11, 'default', 0, 'currency/options/allow', 'USD'),
(12, 'default', 0, 'dev/restrict/allow_ips', NULL),
(13, 'default', 0, 'dev/debug/profiler', '0'),
(14, 'default', 0, 'dev/template/allow_symlink', '0'),
(15, 'default', 0, 'dev/translate_inline/active', '0'),
(16, 'default', 0, 'dev/translate_inline/active_admin', '0'),
(17, 'default', 0, 'dev/log/active', '1'),
(18, 'default', 0, 'dev/log/file', 'system.log'),
(19, 'default', 0, 'dev/log/exception_file', 'exception.log'),
(20, 'default', 0, 'dev/js/merge_files', '0'),
(21, 'default', 0, 'dev/css/merge_css_files', '0'),
(23, 'default', 0, 'design/package/name', 'default'),
(24, 'default', 0, 'design/package/ua_regexp', 'a:0:{}'),
(25, 'default', 0, 'design/theme/locale', NULL),
(26, 'default', 0, 'design/theme/template', 'bob'),
(27, 'default', 0, 'design/theme/template_ua_regexp', 'a:0:{}'),
(28, 'default', 0, 'design/theme/skin', 'bob'),
(29, 'default', 0, 'design/theme/skin_ua_regexp', 'a:0:{}'),
(30, 'default', 0, 'design/theme/layout', 'bob'),
(31, 'default', 0, 'design/theme/layout_ua_regexp', 'a:0:{}'),
(32, 'default', 0, 'design/theme/default', 'bob'),
(33, 'default', 0, 'design/theme/default_ua_regexp', 'a:0:{}'),
(34, 'default', 0, 'design/head/default_title', 'Magento Commerce'),
(35, 'default', 0, 'design/head/title_prefix', NULL),
(36, 'default', 0, 'design/head/title_suffix', NULL),
(37, 'default', 0, 'design/head/default_description', 'Default Description'),
(38, 'default', 0, 'design/head/default_keywords', 'Magento, Varien, E-commerce'),
(39, 'default', 0, 'design/head/default_robots', 'INDEX,FOLLOW'),
(40, 'default', 0, 'design/head/includes', NULL),
(41, 'default', 0, 'design/head/demonotice', '0'),
(42, 'default', 0, 'design/header/logo_src', 'images/logo.gif'),
(43, 'default', 0, 'design/header/logo_alt', 'Magento Commerce'),
(44, 'default', 0, 'design/header/welcome', 'Default welcome msg!'),
(45, 'default', 0, 'design/footer/copyright', '&copy; 2012 Magento Demo Store. All Rights Reserved.'),
(46, 'default', 0, 'design/footer/absolute_footer', NULL),
(47, 'default', 0, 'design/watermark/image_size', NULL),
(48, 'default', 0, 'design/watermark/image_imageOpacity', NULL),
(49, 'default', 0, 'design/watermark/image_position', 'stretch'),
(50, 'default', 0, 'design/watermark/small_image_size', NULL),
(51, 'default', 0, 'design/watermark/small_image_imageOpacity', NULL),
(52, 'default', 0, 'design/watermark/small_image_position', 'stretch'),
(53, 'default', 0, 'design/watermark/thumbnail_size', NULL),
(54, 'default', 0, 'design/watermark/thumbnail_imageOpacity', NULL),
(55, 'default', 0, 'design/watermark/thumbnail_position', 'stretch'),
(56, 'default', 0, 'design/pagination/pagination_frame', '5'),
(57, 'default', 0, 'design/pagination/pagination_frame_skip', NULL),
(58, 'default', 0, 'design/pagination/anchor_text_for_previous', NULL),
(59, 'default', 0, 'design/pagination/anchor_text_for_next', NULL),
(60, 'default', 0, 'design/email/logo_alt', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `core_email_template`
--

CREATE TABLE IF NOT EXISTS `core_email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Creation',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `UNQ_CORE_EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `core_flag`
--

CREATE TABLE IF NOT EXISTS `core_flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `IDX_CORE_FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Flag' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `core_flag`
--

INSERT INTO `core_flag` (`flag_id`, `flag_code`, `state`, `flag_data`, `last_update`) VALUES
(1, 'admin_notification_survey', 0, 'a:1:{s:13:"survey_viewed";b:1;}', '2013-04-10 00:26:49');

-- --------------------------------------------------------

--
-- Table structure for table `core_layout_link`
--

CREATE TABLE IF NOT EXISTS `core_layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `area` varchar(64) DEFAULT NULL COMMENT 'Area',
  `package` varchar(64) DEFAULT NULL COMMENT 'Package',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  PRIMARY KEY (`layout_link_id`),
  UNIQUE KEY `UNQ_CORE_LAYOUT_LINK_STORE_ID_PACKAGE_THEME_LAYOUT_UPDATE_ID` (`store_id`,`package`,`theme`,`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Link' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `core_layout_update`
--

CREATE TABLE IF NOT EXISTS `core_layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Updates' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `core_resource`
--

CREATE TABLE IF NOT EXISTS `core_resource` (
  `code` varchar(50) NOT NULL COMMENT 'Resource Code',
  `version` varchar(50) DEFAULT NULL COMMENT 'Resource Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resources';

--
-- Dumping data for table `core_resource`
--

INSERT INTO `core_resource` (`code`, `version`, `data_version`) VALUES
('adminnotification_setup', '1.6.0.0', '1.6.0.0'),
('admin_setup', '1.6.1.0', '1.6.1.0'),
('api2_setup', '1.0.0.0', '1.0.0.0'),
('api_setup', '1.6.0.0', '1.6.0.0'),
('article_setup', '0.1.2', '0.1.2'),
('backup_setup', '1.6.0.0', '1.6.0.0'),
('bundle_setup', '1.6.0.0.1', '1.6.0.0.1'),
('captcha_setup', '1.7.0.0.0', '1.7.0.0.0'),
('catalogindex_setup', '1.6.0.0', '1.6.0.0'),
('cataloginventory_setup', '1.6.0.0.2', '1.6.0.0.2'),
('catalogrule_setup', '1.6.0.3', '1.6.0.3'),
('catalogsearch_setup', '1.6.0.0', '1.6.0.0'),
('catalog_setup', '1.6.0.0.14', '1.6.0.0.14'),
('checkout_setup', '1.6.0.0', '1.6.0.0'),
('cms_setup', '1.6.0.0.1', '1.6.0.0.1'),
('compiler_setup', '1.6.0.0', '1.6.0.0'),
('contacts_setup', '1.6.0.0', '1.6.0.0'),
('core_setup', '1.6.0.2', '1.6.0.2'),
('cron_setup', '1.6.0.0', '1.6.0.0'),
('customer_setup', '1.6.2.0.1', '1.6.2.0.1'),
('dataflow_setup', '1.6.0.0', '1.6.0.0'),
('directory_setup', '1.6.0.1', '1.6.0.1'),
('downloadable_setup', '1.6.0.0.2', '1.6.0.0.2'),
('eav_setup', '1.6.0.0', '1.6.0.0'),
('giftmessage_setup', '1.6.0.0', '1.6.0.0'),
('googlecheckout_setup', '1.6.0.1', '1.6.0.1'),
('importexport_setup', '1.6.0.2', '1.6.0.2'),
('index_setup', '1.6.0.0', '1.6.0.0'),
('log_setup', '1.6.0.0', '1.6.0.0'),
('moneybookers_setup', '1.6.0.0', '1.6.0.0'),
('newsletter_setup', '1.6.0.1', '1.6.0.1'),
('oauth_setup', '1.0.0.0', '1.0.0.0'),
('paygate_setup', '1.6.0.0', '1.6.0.0'),
('payment_setup', '1.6.0.0', '1.6.0.0'),
('paypaluk_setup', '1.6.0.0', '1.6.0.0'),
('paypal_setup', '1.6.0.2', '1.6.0.2'),
('persistent_setup', '1.0.0.0', '1.0.0.0'),
('poll_setup', '1.6.0.0', '1.6.0.0'),
('productalert_setup', '1.6.0.0', '1.6.0.0'),
('rating_setup', '1.6.0.0', '1.6.0.0'),
('reports_setup', '1.6.0.0.1', '1.6.0.0.1'),
('review_setup', '1.6.0.0', '1.6.0.0'),
('salesrule_setup', '1.6.0.3', '1.6.0.3'),
('sales_setup', '1.6.0.7', '1.6.0.7'),
('sendfriend_setup', '1.6.0.0', '1.6.0.0'),
('shipping_setup', '1.6.0.0', '1.6.0.0'),
('sitemap_setup', '1.6.0.0', '1.6.0.0'),
('tag_setup', '1.6.0.0', '1.6.0.0'),
('tax_setup', '1.6.0.3', '1.6.0.3'),
('usa_setup', '1.6.0.1', '1.6.0.1'),
('weee_setup', '1.6.0.0', '1.6.0.0'),
('widget_setup', '1.6.0.0', '1.6.0.0'),
('wishlist_setup', '1.6.0.0', '1.6.0.0'),
('xmlconnect_setup', '1.6.0.0', '1.6.0.0');

-- --------------------------------------------------------

--
-- Table structure for table `core_session`
--

CREATE TABLE IF NOT EXISTS `core_session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';

-- --------------------------------------------------------

--
-- Table structure for table `core_store`
--

CREATE TABLE IF NOT EXISTS `core_store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `UNQ_CORE_STORE_CODE` (`code`),
  KEY `IDX_CORE_STORE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `IDX_CORE_STORE_GROUP_ID` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `core_store`
--

INSERT INTO `core_store` (`store_id`, `code`, `website_id`, `group_id`, `name`, `sort_order`, `is_active`) VALUES
(0, 'admin', 0, 0, 'Admin', 0, 1),
(1, 'default', 1, 1, 'Default Store View', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `core_store_group`
--

CREATE TABLE IF NOT EXISTS `core_store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  PRIMARY KEY (`group_id`),
  KEY `IDX_CORE_STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Store Groups' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `core_store_group`
--

INSERT INTO `core_store_group` (`group_id`, `website_id`, `name`, `root_category_id`, `default_store_id`) VALUES
(0, 0, 'Default', 0, 0),
(1, 1, 'Main Website Store', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `core_translate`
--

CREATE TABLE IF NOT EXISTS `core_translate` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `UNQ_CORE_TRANSLATE_STORE_ID_LOCALE_STRING` (`store_id`,`locale`,`string`),
  KEY `IDX_CORE_TRANSLATE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `core_url_rewrite`
--

CREATE TABLE IF NOT EXISTS `core_url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `id_path` varchar(255) DEFAULT NULL COMMENT 'Id Path',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `is_system` smallint(5) unsigned DEFAULT '1' COMMENT 'Defines is Rewrite System',
  `options` varchar(255) DEFAULT NULL COMMENT 'Options',
  `description` varchar(255) DEFAULT NULL COMMENT 'Deascription',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_ID_PATH_IS_SYSTEM_STORE_ID` (`id_path`,`is_system`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_TARGET_PATH_STORE_ID` (`target_path`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_ID_PATH` (`id_path`),
  KEY `IDX_CORE_URL_REWRITE_STORE_ID` (`store_id`),
  KEY `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` (`category_id`),
  KEY `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Url Rewrites' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `core_variable`
--

CREATE TABLE IF NOT EXISTS `core_variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `core_variable_value`
--

CREATE TABLE IF NOT EXISTS `core_variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_VARIABLE_ID` (`variable_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `core_website`
--

CREATE TABLE IF NOT EXISTS `core_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `UNQ_CORE_WEBSITE_CODE` (`code`),
  KEY `IDX_CORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `IDX_CORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Websites' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `core_website`
--

INSERT INTO `core_website` (`website_id`, `code`, `name`, `sort_order`, `default_group_id`, `is_default`) VALUES
(0, 'admin', 'Admin', 0, 0, 0),
(1, 'base', 'Main Website', 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `coupon_aggregated`
--

CREATE TABLE IF NOT EXISTS `coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_RULE_NAME` (`rule_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_aggregated_order`
--

CREATE TABLE IF NOT EXISTS `coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_aggregated_updated`
--

CREATE TABLE IF NOT EXISTS `coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_UPDATED_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Updated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cron_schedule`
--

CREATE TABLE IF NOT EXISTS `cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `IDX_CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `IDX_CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address_entity`
--

CREATE TABLE IF NOT EXISTS `customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address_entity_datetime`
--

CREATE TABLE IF NOT EXISTS `customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CSTR_ADDR_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address_entity_decimal`
--

CREATE TABLE IF NOT EXISTS `customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address_entity_int`
--

CREATE TABLE IF NOT EXISTS `customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address_entity_text`
--

CREATE TABLE IF NOT EXISTS `customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address_entity_varchar`
--

CREATE TABLE IF NOT EXISTS `customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_eav_attribute`
--

CREATE TABLE IF NOT EXISTS `customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';

--
-- Dumping data for table `customer_eav_attribute`
--

INSERT INTO `customer_eav_attribute` (`attribute_id`, `is_visible`, `input_filter`, `multiline_count`, `validate_rules`, `is_system`, `sort_order`, `data_model`) VALUES
(1, 1, NULL, 0, NULL, 1, 10, NULL),
(2, 0, NULL, 0, NULL, 1, 0, NULL),
(3, 1, NULL, 0, NULL, 1, 20, NULL),
(4, 0, NULL, 0, NULL, 0, 30, NULL),
(5, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 40, NULL),
(6, 0, NULL, 0, NULL, 0, 50, NULL),
(7, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 60, NULL),
(8, 0, NULL, 0, NULL, 0, 70, NULL),
(9, 1, NULL, 0, 'a:1:{s:16:"input_validation";s:5:"email";}', 1, 80, NULL),
(10, 1, NULL, 0, NULL, 1, 25, NULL),
(11, 0, 'date', 0, 'a:1:{s:16:"input_validation";s:4:"date";}', 0, 90, NULL),
(12, 0, NULL, 0, NULL, 1, 0, NULL),
(13, 0, NULL, 0, NULL, 1, 0, NULL),
(14, 0, NULL, 0, NULL, 1, 0, NULL),
(15, 0, NULL, 0, 'a:1:{s:15:"max_text_length";i:255;}', 0, 100, NULL),
(16, 0, NULL, 0, NULL, 1, 0, NULL),
(17, 0, NULL, 0, NULL, 0, 0, NULL),
(18, 0, NULL, 0, 'a:0:{}', 0, 110, NULL),
(19, 0, NULL, 0, NULL, 0, 10, NULL),
(20, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 20, NULL),
(21, 0, NULL, 0, NULL, 0, 30, NULL),
(22, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 40, NULL),
(23, 0, NULL, 0, NULL, 0, 50, NULL),
(24, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 60, NULL),
(25, 1, NULL, 2, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 70, NULL),
(26, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 80, NULL),
(27, 1, NULL, 0, NULL, 1, 90, NULL),
(28, 1, NULL, 0, NULL, 1, 100, NULL),
(29, 1, NULL, 0, NULL, 1, 100, NULL),
(30, 1, NULL, 0, 'a:0:{}', 1, 110, 'customer/attribute_data_postcode'),
(31, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 120, NULL),
(32, 1, NULL, 0, 'a:2:{s:15:"max_text_length";i:255;s:15:"min_text_length";i:1;}', 1, 130, NULL),
(33, 0, NULL, 0, NULL, 1, 0, NULL),
(34, 0, NULL, 0, 'a:1:{s:16:"input_validation";s:4:"date";}', 1, 0, NULL),
(35, 1, NULL, 0, NULL, 1, 28, NULL),
(36, 1, NULL, 0, NULL, 1, 140, NULL),
(37, 0, NULL, 0, NULL, 1, 0, NULL),
(38, 0, NULL, 0, NULL, 1, 0, NULL),
(39, 0, NULL, 0, NULL, 1, 0, NULL),
(40, 0, NULL, 0, NULL, 1, 0, NULL),
(134, 1, NULL, 1, NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_eav_attribute_website`
--

CREATE TABLE IF NOT EXISTS `customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `IDX_CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';

-- --------------------------------------------------------

--
-- Table structure for table `customer_entity`
--

CREATE TABLE IF NOT EXISTS `customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `IDX_CUSTOMER_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Customer Entity' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `customer_entity`
--

INSERT INTO `customer_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `website_id`, `email`, `group_id`, `increment_id`, `store_id`, `created_at`, `updated_at`, `is_active`, `disable_auto_group_change`) VALUES
(1, 1, 0, 1, 'enjoy3013@gmail.com', 1, NULL, 1, '2013-04-11 21:53:41', '2013-04-22 02:00:26', 1, 0),
(2, 1, 0, 1, 'enjoy.harpyhunter@yahoo.com', 1, NULL, 1, '2013-04-19 00:42:07', '2013-04-19 00:42:08', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `customer_entity_datetime`
--

CREATE TABLE IF NOT EXISTS `customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_entity_decimal`
--

CREATE TABLE IF NOT EXISTS `customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal' AUTO_INCREMENT=43 ;

--
-- Dumping data for table `customer_entity_decimal`
--

INSERT INTO `customer_entity_decimal` (`value_id`, `entity_type_id`, `attribute_id`, `entity_id`, `value`) VALUES
(1, 1, 134, 1, '20.0000');

-- --------------------------------------------------------

--
-- Table structure for table `customer_entity_int`
--

CREATE TABLE IF NOT EXISTS `customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `customer_entity_int`
--

INSERT INTO `customer_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `entity_id`, `value`) VALUES
(1, 1, 134, 1, 16);

-- --------------------------------------------------------

--
-- Table structure for table `customer_entity_text`
--

CREATE TABLE IF NOT EXISTS `customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_entity_varchar`
--

CREATE TABLE IF NOT EXISTS `customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `customer_entity_varchar`
--

INSERT INTO `customer_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `entity_id`, `value`) VALUES
(1, 1, 5, 1, 'Hat'),
(2, 1, 7, 1, 'dao'),
(3, 1, 12, 1, 'ec740af1610ece27dd75f929c16b5ba0:jW'),
(5, 1, 3, 1, 'Default Store View'),
(6, 1, 5, 2, 'Minh'),
(7, 1, 7, 2, 'Hat'),
(8, 1, 12, 2, '9355a3c18060521e6bea0729f61f1816:fE'),
(10, 1, 3, 2, 'Default Store View');

-- --------------------------------------------------------

--
-- Table structure for table `customer_form_attribute`
--

CREATE TABLE IF NOT EXISTS `customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `IDX_CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';

--
-- Dumping data for table `customer_form_attribute`
--

INSERT INTO `customer_form_attribute` (`form_code`, `attribute_id`) VALUES
('adminhtml_customer', 1),
('adminhtml_customer', 3),
('adminhtml_customer', 4),
('checkout_register', 4),
('customer_account_create', 4),
('customer_account_edit', 4),
('adminhtml_customer', 5),
('checkout_register', 5),
('customer_account_create', 5),
('customer_account_edit', 5),
('adminhtml_customer', 6),
('checkout_register', 6),
('customer_account_create', 6),
('customer_account_edit', 6),
('adminhtml_customer', 7),
('checkout_register', 7),
('customer_account_create', 7),
('customer_account_edit', 7),
('adminhtml_customer', 8),
('checkout_register', 8),
('customer_account_create', 8),
('customer_account_edit', 8),
('adminhtml_checkout', 9),
('adminhtml_customer', 9),
('checkout_register', 9),
('customer_account_create', 9),
('customer_account_edit', 9),
('adminhtml_checkout', 10),
('adminhtml_customer', 10),
('adminhtml_checkout', 11),
('adminhtml_customer', 11),
('checkout_register', 11),
('customer_account_create', 11),
('customer_account_edit', 11),
('adminhtml_checkout', 15),
('adminhtml_customer', 15),
('checkout_register', 15),
('customer_account_create', 15),
('customer_account_edit', 15),
('adminhtml_customer', 17),
('checkout_register', 17),
('customer_account_create', 17),
('customer_account_edit', 17),
('adminhtml_checkout', 18),
('adminhtml_customer', 18),
('checkout_register', 18),
('customer_account_create', 18),
('customer_account_edit', 18),
('adminhtml_customer_address', 19),
('customer_address_edit', 19),
('customer_register_address', 19),
('adminhtml_customer_address', 20),
('customer_address_edit', 20),
('customer_register_address', 20),
('adminhtml_customer_address', 21),
('customer_address_edit', 21),
('customer_register_address', 21),
('adminhtml_customer_address', 22),
('customer_address_edit', 22),
('customer_register_address', 22),
('adminhtml_customer_address', 23),
('customer_address_edit', 23),
('customer_register_address', 23),
('adminhtml_customer_address', 24),
('customer_address_edit', 24),
('customer_register_address', 24),
('adminhtml_customer_address', 25),
('customer_address_edit', 25),
('customer_register_address', 25),
('adminhtml_customer_address', 26),
('customer_address_edit', 26),
('customer_register_address', 26),
('adminhtml_customer_address', 27),
('customer_address_edit', 27),
('customer_register_address', 27),
('adminhtml_customer_address', 28),
('customer_address_edit', 28),
('customer_register_address', 28),
('adminhtml_customer_address', 29),
('customer_address_edit', 29),
('customer_register_address', 29),
('adminhtml_customer_address', 30),
('customer_address_edit', 30),
('customer_register_address', 30),
('adminhtml_customer_address', 31),
('customer_address_edit', 31),
('customer_register_address', 31),
('adminhtml_customer_address', 32),
('customer_address_edit', 32),
('customer_register_address', 32),
('adminhtml_customer', 35),
('adminhtml_customer_address', 36),
('customer_address_edit', 36),
('customer_register_address', 36),
('adminhtml_customer', 134);

-- --------------------------------------------------------

--
-- Table structure for table `customer_group`
--

CREATE TABLE IF NOT EXISTS `customer_group` (
  `customer_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Customer Group Id',
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Customer Group' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `customer_group`
--

INSERT INTO `customer_group` (`customer_group_id`, `customer_group_code`, `tax_class_id`) VALUES
(0, 'NOT LOGGED IN', 3),
(1, 'General', 3),
(2, 'Wholesale', 3),
(3, 'Retailer', 3);

-- --------------------------------------------------------

--
-- Table structure for table `dataflow_batch`
--

CREATE TABLE IF NOT EXISTS `dataflow_batch` (
  `batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `adapter` varchar(128) DEFAULT NULL COMMENT 'Adapter',
  `params` text COMMENT 'Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`batch_id`),
  KEY `IDX_DATAFLOW_BATCH_PROFILE_ID` (`profile_id`),
  KEY `IDX_DATAFLOW_BATCH_STORE_ID` (`store_id`),
  KEY `IDX_DATAFLOW_BATCH_CREATED_AT` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `dataflow_batch_export`
--

CREATE TABLE IF NOT EXISTS `dataflow_batch_export` (
  `batch_export_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Export Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_export_id`),
  KEY `IDX_DATAFLOW_BATCH_EXPORT_BATCH_ID` (`batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Export' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `dataflow_batch_import`
--

CREATE TABLE IF NOT EXISTS `dataflow_batch_import` (
  `batch_import_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Import Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_import_id`),
  KEY `IDX_DATAFLOW_BATCH_IMPORT_BATCH_ID` (`batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Import' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `dataflow_import_data`
--

CREATE TABLE IF NOT EXISTS `dataflow_import_data` (
  `import_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Import Id',
  `session_id` int(11) DEFAULT NULL COMMENT 'Session Id',
  `serial_number` int(11) NOT NULL DEFAULT '0' COMMENT 'Serial Number',
  `value` text COMMENT 'Value',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`import_id`),
  KEY `IDX_DATAFLOW_IMPORT_DATA_SESSION_ID` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Import Data' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `dataflow_profile`
--

CREATE TABLE IF NOT EXISTS `dataflow_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `actions_xml` text COMMENT 'Actions Xml',
  `gui_data` text COMMENT 'Gui Data',
  `direction` varchar(6) DEFAULT NULL COMMENT 'Direction',
  `entity_type` varchar(64) DEFAULT NULL COMMENT 'Entity Type',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `data_transfer` varchar(11) DEFAULT NULL COMMENT 'Data Transfer',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `dataflow_profile`
--

INSERT INTO `dataflow_profile` (`profile_id`, `name`, `created_at`, `updated_at`, `actions_xml`, `gui_data`, `direction`, `entity_type`, `store_id`, `data_transfer`) VALUES
(1, 'Export All Products', '2013-04-10 00:25:39', '2013-04-10 00:25:39', '<action type="catalog/convert_adapter_product" method="load">\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type="catalog/convert_parser_product" method="unparse">\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_mapper_column" method="map">\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_parser_csv" method="unparse">\\r\\n    <var name="delimiter"><![CDATA[,]]></var>\\r\\n    <var name="enclose"><![CDATA["]]></var>\\r\\n    <var name="fieldnames">true</var>\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_adapter_io" method="save">\\r\\n    <var name="type">file</var>\\r\\n    <var name="path">var/export</var>\\r\\n    <var name="filename"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n', 'a:5:{s:4:"file";a:7:{s:4:"type";s:4:"file";s:8:"filename";s:23:"export_all_products.csv";s:4:"path";s:10:"var/export";s:4:"host";s:0:"";s:4:"user";s:0:"";s:8:"password";s:0:"";s:7:"passive";s:0:"";}s:5:"parse";a:5:{s:4:"type";s:3:"csv";s:12:"single_sheet";s:0:"";s:9:"delimiter";s:1:",";s:7:"enclose";s:1:""";s:10:"fieldnames";s:4:"true";}s:3:"map";a:3:{s:14:"only_specified";s:0:"";s:7:"product";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}s:8:"customer";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}}s:7:"product";a:1:{s:6:"filter";a:8:{s:4:"name";s:0:"";s:3:"sku";s:0:"";s:4:"type";s:1:"0";s:13:"attribute_set";s:0:"";s:5:"price";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:3:"qty";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:10:"visibility";s:1:"0";s:6:"status";s:1:"0";}}s:8:"customer";a:1:{s:6:"filter";a:10:{s:9:"firstname";s:0:"";s:8:"lastname";s:0:"";s:5:"email";s:0:"";s:5:"group";s:1:"0";s:10:"adressType";s:15:"default_billing";s:9:"telephone";s:0:"";s:8:"postcode";s:0:"";s:7:"country";s:0:"";s:6:"region";s:0:"";s:10:"created_at";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}}}}', 'export', 'product', 0, 'file'),
(2, 'Export Product Stocks', '2013-04-10 00:25:39', '2013-04-10 00:25:39', '<action type="catalog/convert_adapter_product" method="load">\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type="catalog/convert_parser_product" method="unparse">\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_mapper_column" method="map">\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_parser_csv" method="unparse">\\r\\n    <var name="delimiter"><![CDATA[,]]></var>\\r\\n    <var name="enclose"><![CDATA["]]></var>\\r\\n    <var name="fieldnames">true</var>\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_adapter_io" method="save">\\r\\n    <var name="type">file</var>\\r\\n    <var name="path">var/export</var>\\r\\n    <var name="filename"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n', 'a:5:{s:4:"file";a:7:{s:4:"type";s:4:"file";s:8:"filename";s:25:"export_product_stocks.csv";s:4:"path";s:10:"var/export";s:4:"host";s:0:"";s:4:"user";s:0:"";s:8:"password";s:0:"";s:7:"passive";s:0:"";}s:5:"parse";a:5:{s:4:"type";s:3:"csv";s:12:"single_sheet";s:0:"";s:9:"delimiter";s:1:",";s:7:"enclose";s:1:""";s:10:"fieldnames";s:4:"true";}s:3:"map";a:3:{s:14:"only_specified";s:4:"true";s:7:"product";a:2:{s:2:"db";a:4:{i:1;s:5:"store";i:2;s:3:"sku";i:3;s:3:"qty";i:4;s:11:"is_in_stock";}s:4:"file";a:4:{i:1;s:5:"store";i:2;s:3:"sku";i:3;s:3:"qty";i:4;s:11:"is_in_stock";}}s:8:"customer";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}}s:7:"product";a:1:{s:6:"filter";a:8:{s:4:"name";s:0:"";s:3:"sku";s:0:"";s:4:"type";s:1:"0";s:13:"attribute_set";s:0:"";s:5:"price";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:3:"qty";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:10:"visibility";s:1:"0";s:6:"status";s:1:"0";}}s:8:"customer";a:1:{s:6:"filter";a:10:{s:9:"firstname";s:0:"";s:8:"lastname";s:0:"";s:5:"email";s:0:"";s:5:"group";s:1:"0";s:10:"adressType";s:15:"default_billing";s:9:"telephone";s:0:"";s:8:"postcode";s:0:"";s:7:"country";s:0:"";s:6:"region";s:0:"";s:10:"created_at";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}}}}', 'export', 'product', 0, 'file'),
(3, 'Import All Products', '2013-04-10 00:25:39', '2013-04-10 00:25:39', '<action type="dataflow/convert_parser_csv" method="parse">\\r\\n    <var name="delimiter"><![CDATA[,]]></var>\\r\\n    <var name="enclose"><![CDATA["]]></var>\\r\\n    <var name="fieldnames">true</var>\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n    <var name="adapter">catalog/convert_adapter_product</var>\\r\\n    <var name="method">parse</var>\\r\\n</action>', 'a:5:{s:4:"file";a:7:{s:4:"type";s:4:"file";s:8:"filename";s:23:"export_all_products.csv";s:4:"path";s:10:"var/export";s:4:"host";s:0:"";s:4:"user";s:0:"";s:8:"password";s:0:"";s:7:"passive";s:0:"";}s:5:"parse";a:5:{s:4:"type";s:3:"csv";s:12:"single_sheet";s:0:"";s:9:"delimiter";s:1:",";s:7:"enclose";s:1:""";s:10:"fieldnames";s:4:"true";}s:3:"map";a:3:{s:14:"only_specified";s:0:"";s:7:"product";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}s:8:"customer";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}}s:7:"product";a:1:{s:6:"filter";a:8:{s:4:"name";s:0:"";s:3:"sku";s:0:"";s:4:"type";s:1:"0";s:13:"attribute_set";s:0:"";s:5:"price";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:3:"qty";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:10:"visibility";s:1:"0";s:6:"status";s:1:"0";}}s:8:"customer";a:1:{s:6:"filter";a:10:{s:9:"firstname";s:0:"";s:8:"lastname";s:0:"";s:5:"email";s:0:"";s:5:"group";s:1:"0";s:10:"adressType";s:15:"default_billing";s:9:"telephone";s:0:"";s:8:"postcode";s:0:"";s:7:"country";s:0:"";s:6:"region";s:0:"";s:10:"created_at";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}}}}', 'import', 'product', 0, 'interactive'),
(4, 'Import Product Stocks', '2013-04-10 00:25:39', '2013-04-10 00:25:39', '<action type="dataflow/convert_parser_csv" method="parse">\\r\\n    <var name="delimiter"><![CDATA[,]]></var>\\r\\n    <var name="enclose"><![CDATA["]]></var>\\r\\n    <var name="fieldnames">true</var>\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n    <var name="adapter">catalog/convert_adapter_product</var>\\r\\n    <var name="method">parse</var>\\r\\n</action>', 'a:5:{s:4:"file";a:7:{s:4:"type";s:4:"file";s:8:"filename";s:18:"export_product.csv";s:4:"path";s:10:"var/export";s:4:"host";s:0:"";s:4:"user";s:0:"";s:8:"password";s:0:"";s:7:"passive";s:0:"";}s:5:"parse";a:5:{s:4:"type";s:3:"csv";s:12:"single_sheet";s:0:"";s:9:"delimiter";s:1:",";s:7:"enclose";s:1:""";s:10:"fieldnames";s:4:"true";}s:3:"map";a:3:{s:14:"only_specified";s:0:"";s:7:"product";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}s:8:"customer";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}}s:7:"product";a:1:{s:6:"filter";a:8:{s:4:"name";s:0:"";s:3:"sku";s:0:"";s:4:"type";s:1:"0";s:13:"attribute_set";s:0:"";s:5:"price";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:3:"qty";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:10:"visibility";s:1:"0";s:6:"status";s:1:"0";}}s:8:"customer";a:1:{s:6:"filter";a:10:{s:9:"firstname";s:0:"";s:8:"lastname";s:0:"";s:5:"email";s:0:"";s:5:"group";s:1:"0";s:10:"adressType";s:15:"default_billing";s:9:"telephone";s:0:"";s:8:"postcode";s:0:"";s:7:"country";s:0:"";s:6:"region";s:0:"";s:10:"created_at";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}}}}', 'import', 'product', 0, 'interactive'),
(5, 'Export Customers', '2013-04-10 00:25:39', '2013-04-10 00:25:39', '<action type="customer/convert_adapter_customer" method="load">\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n    <var name="filter/adressType"><![CDATA[default_billing]]></var>\\r\\n</action>\\r\\n\\r\\n<action type="customer/convert_parser_customer" method="unparse">\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_mapper_column" method="map">\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_parser_csv" method="unparse">\\r\\n    <var name="delimiter"><![CDATA[,]]></var>\\r\\n    <var name="enclose"><![CDATA["]]></var>\\r\\n    <var name="fieldnames">true</var>\\r\\n</action>\\r\\n\\r\\n<action type="dataflow/convert_adapter_io" method="save">\\r\\n    <var name="type">file</var>\\r\\n    <var name="path">var/export</var>\\r\\n    <var name="filename"><![CDATA[export_customers.csv]]></var>\\r\\n</action>\\r\\n\\r\\n', 'a:5:{s:4:"file";a:7:{s:4:"type";s:4:"file";s:8:"filename";s:20:"export_customers.csv";s:4:"path";s:10:"var/export";s:4:"host";s:0:"";s:4:"user";s:0:"";s:8:"password";s:0:"";s:7:"passive";s:0:"";}s:5:"parse";a:5:{s:4:"type";s:3:"csv";s:12:"single_sheet";s:0:"";s:9:"delimiter";s:1:",";s:7:"enclose";s:1:""";s:10:"fieldnames";s:4:"true";}s:3:"map";a:3:{s:14:"only_specified";s:0:"";s:7:"product";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}s:8:"customer";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}}s:7:"product";a:1:{s:6:"filter";a:8:{s:4:"name";s:0:"";s:3:"sku";s:0:"";s:4:"type";s:1:"0";s:13:"attribute_set";s:0:"";s:5:"price";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:3:"qty";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:10:"visibility";s:1:"0";s:6:"status";s:1:"0";}}s:8:"customer";a:1:{s:6:"filter";a:10:{s:9:"firstname";s:0:"";s:8:"lastname";s:0:"";s:5:"email";s:0:"";s:5:"group";s:1:"0";s:10:"adressType";s:15:"default_billing";s:9:"telephone";s:0:"";s:8:"postcode";s:0:"";s:7:"country";s:0:"";s:6:"region";s:0:"";s:10:"created_at";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}}}}', 'export', 'customer', 0, 'file'),
(6, 'Import Customers', '2013-04-10 00:25:39', '2013-04-10 00:25:39', '<action type="dataflow/convert_parser_csv" method="parse">\\r\\n    <var name="delimiter"><![CDATA[,]]></var>\\r\\n    <var name="enclose"><![CDATA["]]></var>\\r\\n    <var name="fieldnames">true</var>\\r\\n    <var name="store"><![CDATA[0]]></var>\\r\\n    <var name="adapter">customer/convert_adapter_customer</var>\\r\\n    <var name="method">parse</var>\\r\\n</action>', 'a:5:{s:4:"file";a:7:{s:4:"type";s:4:"file";s:8:"filename";s:19:"export_customer.csv";s:4:"path";s:10:"var/export";s:4:"host";s:0:"";s:4:"user";s:0:"";s:8:"password";s:0:"";s:7:"passive";s:0:"";}s:5:"parse";a:5:{s:4:"type";s:3:"csv";s:12:"single_sheet";s:0:"";s:9:"delimiter";s:1:",";s:7:"enclose";s:1:""";s:10:"fieldnames";s:4:"true";}s:3:"map";a:3:{s:14:"only_specified";s:0:"";s:7:"product";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}s:8:"customer";a:2:{s:2:"db";a:0:{}s:4:"file";a:0:{}}}s:7:"product";a:1:{s:6:"filter";a:8:{s:4:"name";s:0:"";s:3:"sku";s:0:"";s:4:"type";s:1:"0";s:13:"attribute_set";s:0:"";s:5:"price";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:3:"qty";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}s:10:"visibility";s:1:"0";s:6:"status";s:1:"0";}}s:8:"customer";a:1:{s:6:"filter";a:10:{s:9:"firstname";s:0:"";s:8:"lastname";s:0:"";s:5:"email";s:0:"";s:5:"group";s:1:"0";s:10:"adressType";s:15:"default_billing";s:9:"telephone";s:0:"";s:8:"postcode";s:0:"";s:7:"country";s:0:"";s:6:"region";s:0:"";s:10:"created_at";a:2:{s:4:"from";s:0:"";s:2:"to";s:0:"";}}}}', 'import', 'customer', 0, 'interactive');

-- --------------------------------------------------------

--
-- Table structure for table `dataflow_profile_history`
--

CREATE TABLE IF NOT EXISTS `dataflow_profile_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `action_code` varchar(64) DEFAULT NULL COMMENT 'Action Code',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `performed_at` timestamp NULL DEFAULT NULL COMMENT 'Performed At',
  PRIMARY KEY (`history_id`),
  KEY `IDX_DATAFLOW_PROFILE_HISTORY_PROFILE_ID` (`profile_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile History' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `dataflow_profile_history`
--

INSERT INTO `dataflow_profile_history` (`history_id`, `profile_id`, `action_code`, `user_id`, `performed_at`) VALUES
(1, 1, 'create', 0, '2013-04-10 00:25:39'),
(2, 2, 'create', 0, '2013-04-10 00:25:39'),
(3, 3, 'create', 0, '2013-04-10 00:25:39'),
(4, 4, 'create', 0, '2013-04-10 00:25:39'),
(5, 5, 'create', 0, '2013-04-10 00:25:39'),
(6, 6, 'create', 0, '2013-04-10 00:25:39');

-- --------------------------------------------------------

--
-- Table structure for table `dataflow_session`
--

CREATE TABLE IF NOT EXISTS `dataflow_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Session Id',
  `user_id` int(11) NOT NULL COMMENT 'User Id',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'Created Date',
  `file` varchar(255) DEFAULT NULL COMMENT 'File',
  `type` varchar(32) DEFAULT NULL COMMENT 'Type',
  `direction` varchar(32) DEFAULT NULL COMMENT 'Direction',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Comment',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Session' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `design_change`
--

CREATE TABLE IF NOT EXISTS `design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `IDX_DESIGN_CHANGE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `directory_country`
--

CREATE TABLE IF NOT EXISTS `directory_country` (
  `country_id` varchar(2) NOT NULL DEFAULT '' COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';

--
-- Dumping data for table `directory_country`
--

INSERT INTO `directory_country` (`country_id`, `iso2_code`, `iso3_code`) VALUES
('AD', 'AD', 'AND'),
('AE', 'AE', 'ARE'),
('AF', 'AF', 'AFG'),
('AG', 'AG', 'ATG'),
('AI', 'AI', 'AIA'),
('AL', 'AL', 'ALB'),
('AM', 'AM', 'ARM'),
('AN', 'AN', 'ANT'),
('AO', 'AO', 'AGO'),
('AQ', 'AQ', 'ATA'),
('AR', 'AR', 'ARG'),
('AS', 'AS', 'ASM'),
('AT', 'AT', 'AUT'),
('AU', 'AU', 'AUS'),
('AW', 'AW', 'ABW'),
('AX', 'AX', 'ALA'),
('AZ', 'AZ', 'AZE'),
('BA', 'BA', 'BIH'),
('BB', 'BB', 'BRB'),
('BD', 'BD', 'BGD'),
('BE', 'BE', 'BEL'),
('BF', 'BF', 'BFA'),
('BG', 'BG', 'BGR'),
('BH', 'BH', 'BHR'),
('BI', 'BI', 'BDI'),
('BJ', 'BJ', 'BEN'),
('BL', 'BL', 'BLM'),
('BM', 'BM', 'BMU'),
('BN', 'BN', 'BRN'),
('BO', 'BO', 'BOL'),
('BR', 'BR', 'BRA'),
('BS', 'BS', 'BHS'),
('BT', 'BT', 'BTN'),
('BV', 'BV', 'BVT'),
('BW', 'BW', 'BWA'),
('BY', 'BY', 'BLR'),
('BZ', 'BZ', 'BLZ'),
('CA', 'CA', 'CAN'),
('CC', 'CC', 'CCK'),
('CD', 'CD', 'COD'),
('CF', 'CF', 'CAF'),
('CG', 'CG', 'COG'),
('CH', 'CH', 'CHE'),
('CI', 'CI', 'CIV'),
('CK', 'CK', 'COK'),
('CL', 'CL', 'CHL'),
('CM', 'CM', 'CMR'),
('CN', 'CN', 'CHN'),
('CO', 'CO', 'COL'),
('CR', 'CR', 'CRI'),
('CU', 'CU', 'CUB'),
('CV', 'CV', 'CPV'),
('CX', 'CX', 'CXR'),
('CY', 'CY', 'CYP'),
('CZ', 'CZ', 'CZE'),
('DE', 'DE', 'DEU'),
('DJ', 'DJ', 'DJI'),
('DK', 'DK', 'DNK'),
('DM', 'DM', 'DMA'),
('DO', 'DO', 'DOM'),
('DZ', 'DZ', 'DZA'),
('EC', 'EC', 'ECU'),
('EE', 'EE', 'EST'),
('EG', 'EG', 'EGY'),
('EH', 'EH', 'ESH'),
('ER', 'ER', 'ERI'),
('ES', 'ES', 'ESP'),
('ET', 'ET', 'ETH'),
('FI', 'FI', 'FIN'),
('FJ', 'FJ', 'FJI'),
('FK', 'FK', 'FLK'),
('FM', 'FM', 'FSM'),
('FO', 'FO', 'FRO'),
('FR', 'FR', 'FRA'),
('GA', 'GA', 'GAB'),
('GB', 'GB', 'GBR'),
('GD', 'GD', 'GRD'),
('GE', 'GE', 'GEO'),
('GF', 'GF', 'GUF'),
('GG', 'GG', 'GGY'),
('GH', 'GH', 'GHA'),
('GI', 'GI', 'GIB'),
('GL', 'GL', 'GRL'),
('GM', 'GM', 'GMB'),
('GN', 'GN', 'GIN'),
('GP', 'GP', 'GLP'),
('GQ', 'GQ', 'GNQ'),
('GR', 'GR', 'GRC'),
('GS', 'GS', 'SGS'),
('GT', 'GT', 'GTM'),
('GU', 'GU', 'GUM'),
('GW', 'GW', 'GNB'),
('GY', 'GY', 'GUY'),
('HK', 'HK', 'HKG'),
('HM', 'HM', 'HMD'),
('HN', 'HN', 'HND'),
('HR', 'HR', 'HRV'),
('HT', 'HT', 'HTI'),
('HU', 'HU', 'HUN'),
('ID', 'ID', 'IDN'),
('IE', 'IE', 'IRL'),
('IL', 'IL', 'ISR'),
('IM', 'IM', 'IMN'),
('IN', 'IN', 'IND'),
('IO', 'IO', 'IOT'),
('IQ', 'IQ', 'IRQ'),
('IR', 'IR', 'IRN'),
('IS', 'IS', 'ISL'),
('IT', 'IT', 'ITA'),
('JE', 'JE', 'JEY'),
('JM', 'JM', 'JAM'),
('JO', 'JO', 'JOR'),
('JP', 'JP', 'JPN'),
('KE', 'KE', 'KEN'),
('KG', 'KG', 'KGZ'),
('KH', 'KH', 'KHM'),
('KI', 'KI', 'KIR'),
('KM', 'KM', 'COM'),
('KN', 'KN', 'KNA'),
('KP', 'KP', 'PRK'),
('KR', 'KR', 'KOR'),
('KW', 'KW', 'KWT'),
('KY', 'KY', 'CYM'),
('KZ', 'KZ', 'KAZ'),
('LA', 'LA', 'LAO'),
('LB', 'LB', 'LBN'),
('LC', 'LC', 'LCA'),
('LI', 'LI', 'LIE'),
('LK', 'LK', 'LKA'),
('LR', 'LR', 'LBR'),
('LS', 'LS', 'LSO'),
('LT', 'LT', 'LTU'),
('LU', 'LU', 'LUX'),
('LV', 'LV', 'LVA'),
('LY', 'LY', 'LBY'),
('MA', 'MA', 'MAR'),
('MC', 'MC', 'MCO'),
('MD', 'MD', 'MDA'),
('ME', 'ME', 'MNE'),
('MF', 'MF', 'MAF'),
('MG', 'MG', 'MDG'),
('MH', 'MH', 'MHL'),
('MK', 'MK', 'MKD'),
('ML', 'ML', 'MLI'),
('MM', 'MM', 'MMR'),
('MN', 'MN', 'MNG'),
('MO', 'MO', 'MAC'),
('MP', 'MP', 'MNP'),
('MQ', 'MQ', 'MTQ'),
('MR', 'MR', 'MRT'),
('MS', 'MS', 'MSR'),
('MT', 'MT', 'MLT'),
('MU', 'MU', 'MUS'),
('MV', 'MV', 'MDV'),
('MW', 'MW', 'MWI'),
('MX', 'MX', 'MEX'),
('MY', 'MY', 'MYS'),
('MZ', 'MZ', 'MOZ'),
('NA', 'NA', 'NAM'),
('NC', 'NC', 'NCL'),
('NE', 'NE', 'NER'),
('NF', 'NF', 'NFK'),
('NG', 'NG', 'NGA'),
('NI', 'NI', 'NIC'),
('NL', 'NL', 'NLD'),
('NO', 'NO', 'NOR'),
('NP', 'NP', 'NPL'),
('NR', 'NR', 'NRU'),
('NU', 'NU', 'NIU'),
('NZ', 'NZ', 'NZL'),
('OM', 'OM', 'OMN'),
('PA', 'PA', 'PAN'),
('PE', 'PE', 'PER'),
('PF', 'PF', 'PYF'),
('PG', 'PG', 'PNG'),
('PH', 'PH', 'PHL'),
('PK', 'PK', 'PAK'),
('PL', 'PL', 'POL'),
('PM', 'PM', 'SPM'),
('PN', 'PN', 'PCN'),
('PR', 'PR', 'PRI'),
('PS', 'PS', 'PSE'),
('PT', 'PT', 'PRT'),
('PW', 'PW', 'PLW'),
('PY', 'PY', 'PRY'),
('QA', 'QA', 'QAT'),
('RE', 'RE', 'REU'),
('RO', 'RO', 'ROU'),
('RS', 'RS', 'SRB'),
('RU', 'RU', 'RUS'),
('RW', 'RW', 'RWA'),
('SA', 'SA', 'SAU'),
('SB', 'SB', 'SLB'),
('SC', 'SC', 'SYC'),
('SD', 'SD', 'SDN'),
('SE', 'SE', 'SWE'),
('SG', 'SG', 'SGP'),
('SH', 'SH', 'SHN'),
('SI', 'SI', 'SVN'),
('SJ', 'SJ', 'SJM'),
('SK', 'SK', 'SVK'),
('SL', 'SL', 'SLE'),
('SM', 'SM', 'SMR'),
('SN', 'SN', 'SEN'),
('SO', 'SO', 'SOM'),
('SR', 'SR', 'SUR'),
('ST', 'ST', 'STP'),
('SV', 'SV', 'SLV'),
('SY', 'SY', 'SYR'),
('SZ', 'SZ', 'SWZ'),
('TC', 'TC', 'TCA'),
('TD', 'TD', 'TCD'),
('TF', 'TF', 'ATF'),
('TG', 'TG', 'TGO'),
('TH', 'TH', 'THA'),
('TJ', 'TJ', 'TJK'),
('TK', 'TK', 'TKL'),
('TL', 'TL', 'TLS'),
('TM', 'TM', 'TKM'),
('TN', 'TN', 'TUN'),
('TO', 'TO', 'TON'),
('TR', 'TR', 'TUR'),
('TT', 'TT', 'TTO'),
('TV', 'TV', 'TUV'),
('TW', 'TW', 'TWN'),
('TZ', 'TZ', 'TZA'),
('UA', 'UA', 'UKR'),
('UG', 'UG', 'UGA'),
('UM', 'UM', 'UMI'),
('US', 'US', 'USA'),
('UY', 'UY', 'URY'),
('UZ', 'UZ', 'UZB'),
('VA', 'VA', 'VAT'),
('VC', 'VC', 'VCT'),
('VE', 'VE', 'VEN'),
('VG', 'VG', 'VGB'),
('VI', 'VI', 'VIR'),
('VN', 'VN', 'VNM'),
('VU', 'VU', 'VUT'),
('WF', 'WF', 'WLF'),
('WS', 'WS', 'WSM'),
('YE', 'YE', 'YEM'),
('YT', 'YT', 'MYT'),
('ZA', 'ZA', 'ZAF'),
('ZM', 'ZM', 'ZMB'),
('ZW', 'ZW', 'ZWE');

-- --------------------------------------------------------

--
-- Table structure for table `directory_country_format`
--

CREATE TABLE IF NOT EXISTS `directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `UNQ_DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `directory_country_region`
--

CREATE TABLE IF NOT EXISTS `directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Directory Country Region' AUTO_INCREMENT=485 ;

--
-- Dumping data for table `directory_country_region`
--

INSERT INTO `directory_country_region` (`region_id`, `country_id`, `code`, `default_name`) VALUES
(1, 'US', 'AL', 'Alabama'),
(2, 'US', 'AK', 'Alaska'),
(3, 'US', 'AS', 'American Samoa'),
(4, 'US', 'AZ', 'Arizona'),
(5, 'US', 'AR', 'Arkansas'),
(6, 'US', 'AF', 'Armed Forces Africa'),
(7, 'US', 'AA', 'Armed Forces Americas'),
(8, 'US', 'AC', 'Armed Forces Canada'),
(9, 'US', 'AE', 'Armed Forces Europe'),
(10, 'US', 'AM', 'Armed Forces Middle East'),
(11, 'US', 'AP', 'Armed Forces Pacific'),
(12, 'US', 'CA', 'California'),
(13, 'US', 'CO', 'Colorado'),
(14, 'US', 'CT', 'Connecticut'),
(15, 'US', 'DE', 'Delaware'),
(16, 'US', 'DC', 'District of Columbia'),
(17, 'US', 'FM', 'Federated States Of Micronesia'),
(18, 'US', 'FL', 'Florida'),
(19, 'US', 'GA', 'Georgia'),
(20, 'US', 'GU', 'Guam'),
(21, 'US', 'HI', 'Hawaii'),
(22, 'US', 'ID', 'Idaho'),
(23, 'US', 'IL', 'Illinois'),
(24, 'US', 'IN', 'Indiana'),
(25, 'US', 'IA', 'Iowa'),
(26, 'US', 'KS', 'Kansas'),
(27, 'US', 'KY', 'Kentucky'),
(28, 'US', 'LA', 'Louisiana'),
(29, 'US', 'ME', 'Maine'),
(30, 'US', 'MH', 'Marshall Islands'),
(31, 'US', 'MD', 'Maryland'),
(32, 'US', 'MA', 'Massachusetts'),
(33, 'US', 'MI', 'Michigan'),
(34, 'US', 'MN', 'Minnesota'),
(35, 'US', 'MS', 'Mississippi'),
(36, 'US', 'MO', 'Missouri'),
(37, 'US', 'MT', 'Montana'),
(38, 'US', 'NE', 'Nebraska'),
(39, 'US', 'NV', 'Nevada'),
(40, 'US', 'NH', 'New Hampshire'),
(41, 'US', 'NJ', 'New Jersey'),
(42, 'US', 'NM', 'New Mexico'),
(43, 'US', 'NY', 'New York'),
(44, 'US', 'NC', 'North Carolina'),
(45, 'US', 'ND', 'North Dakota'),
(46, 'US', 'MP', 'Northern Mariana Islands'),
(47, 'US', 'OH', 'Ohio'),
(48, 'US', 'OK', 'Oklahoma'),
(49, 'US', 'OR', 'Oregon'),
(50, 'US', 'PW', 'Palau'),
(51, 'US', 'PA', 'Pennsylvania'),
(52, 'US', 'PR', 'Puerto Rico'),
(53, 'US', 'RI', 'Rhode Island'),
(54, 'US', 'SC', 'South Carolina'),
(55, 'US', 'SD', 'South Dakota'),
(56, 'US', 'TN', 'Tennessee'),
(57, 'US', 'TX', 'Texas'),
(58, 'US', 'UT', 'Utah'),
(59, 'US', 'VT', 'Vermont'),
(60, 'US', 'VI', 'Virgin Islands'),
(61, 'US', 'VA', 'Virginia'),
(62, 'US', 'WA', 'Washington'),
(63, 'US', 'WV', 'West Virginia'),
(64, 'US', 'WI', 'Wisconsin'),
(65, 'US', 'WY', 'Wyoming'),
(66, 'CA', 'AB', 'Alberta'),
(67, 'CA', 'BC', 'British Columbia'),
(68, 'CA', 'MB', 'Manitoba'),
(69, 'CA', 'NL', 'Newfoundland and Labrador'),
(70, 'CA', 'NB', 'New Brunswick'),
(71, 'CA', 'NS', 'Nova Scotia'),
(72, 'CA', 'NT', 'Northwest Territories'),
(73, 'CA', 'NU', 'Nunavut'),
(74, 'CA', 'ON', 'Ontario'),
(75, 'CA', 'PE', 'Prince Edward Island'),
(76, 'CA', 'QC', 'Quebec'),
(77, 'CA', 'SK', 'Saskatchewan'),
(78, 'CA', 'YT', 'Yukon Territory'),
(79, 'DE', 'NDS', 'Niedersachsen'),
(80, 'DE', 'BAW', 'Baden-Württemberg'),
(81, 'DE', 'BAY', 'Bayern'),
(82, 'DE', 'BER', 'Berlin'),
(83, 'DE', 'BRG', 'Brandenburg'),
(84, 'DE', 'BRE', 'Bremen'),
(85, 'DE', 'HAM', 'Hamburg'),
(86, 'DE', 'HES', 'Hessen'),
(87, 'DE', 'MEC', 'Mecklenburg-Vorpommern'),
(88, 'DE', 'NRW', 'Nordrhein-Westfalen'),
(89, 'DE', 'RHE', 'Rheinland-Pfalz'),
(90, 'DE', 'SAR', 'Saarland'),
(91, 'DE', 'SAS', 'Sachsen'),
(92, 'DE', 'SAC', 'Sachsen-Anhalt'),
(93, 'DE', 'SCN', 'Schleswig-Holstein'),
(94, 'DE', 'THE', 'Thüringen'),
(95, 'AT', 'WI', 'Wien'),
(96, 'AT', 'NO', 'Niederösterreich'),
(97, 'AT', 'OO', 'Oberösterreich'),
(98, 'AT', 'SB', 'Salzburg'),
(99, 'AT', 'KN', 'Kärnten'),
(100, 'AT', 'ST', 'Steiermark'),
(101, 'AT', 'TI', 'Tirol'),
(102, 'AT', 'BL', 'Burgenland'),
(103, 'AT', 'VB', 'Voralberg'),
(104, 'CH', 'AG', 'Aargau'),
(105, 'CH', 'AI', 'Appenzell Innerrhoden'),
(106, 'CH', 'AR', 'Appenzell Ausserrhoden'),
(107, 'CH', 'BE', 'Bern'),
(108, 'CH', 'BL', 'Basel-Landschaft'),
(109, 'CH', 'BS', 'Basel-Stadt'),
(110, 'CH', 'FR', 'Freiburg'),
(111, 'CH', 'GE', 'Genf'),
(112, 'CH', 'GL', 'Glarus'),
(113, 'CH', 'GR', 'Graubünden'),
(114, 'CH', 'JU', 'Jura'),
(115, 'CH', 'LU', 'Luzern'),
(116, 'CH', 'NE', 'Neuenburg'),
(117, 'CH', 'NW', 'Nidwalden'),
(118, 'CH', 'OW', 'Obwalden'),
(119, 'CH', 'SG', 'St. Gallen'),
(120, 'CH', 'SH', 'Schaffhausen'),
(121, 'CH', 'SO', 'Solothurn'),
(122, 'CH', 'SZ', 'Schwyz'),
(123, 'CH', 'TG', 'Thurgau'),
(124, 'CH', 'TI', 'Tessin'),
(125, 'CH', 'UR', 'Uri'),
(126, 'CH', 'VD', 'Waadt'),
(127, 'CH', 'VS', 'Wallis'),
(128, 'CH', 'ZG', 'Zug'),
(129, 'CH', 'ZH', 'Zürich'),
(130, 'ES', 'A Coruсa', 'A Coruña'),
(131, 'ES', 'Alava', 'Alava'),
(132, 'ES', 'Albacete', 'Albacete'),
(133, 'ES', 'Alicante', 'Alicante'),
(134, 'ES', 'Almeria', 'Almeria'),
(135, 'ES', 'Asturias', 'Asturias'),
(136, 'ES', 'Avila', 'Avila'),
(137, 'ES', 'Badajoz', 'Badajoz'),
(138, 'ES', 'Baleares', 'Baleares'),
(139, 'ES', 'Barcelona', 'Barcelona'),
(140, 'ES', 'Burgos', 'Burgos'),
(141, 'ES', 'Caceres', 'Caceres'),
(142, 'ES', 'Cadiz', 'Cadiz'),
(143, 'ES', 'Cantabria', 'Cantabria'),
(144, 'ES', 'Castellon', 'Castellon'),
(145, 'ES', 'Ceuta', 'Ceuta'),
(146, 'ES', 'Ciudad Real', 'Ciudad Real'),
(147, 'ES', 'Cordoba', 'Cordoba'),
(148, 'ES', 'Cuenca', 'Cuenca'),
(149, 'ES', 'Girona', 'Girona'),
(150, 'ES', 'Granada', 'Granada'),
(151, 'ES', 'Guadalajara', 'Guadalajara'),
(152, 'ES', 'Guipuzcoa', 'Guipuzcoa'),
(153, 'ES', 'Huelva', 'Huelva'),
(154, 'ES', 'Huesca', 'Huesca'),
(155, 'ES', 'Jaen', 'Jaen'),
(156, 'ES', 'La Rioja', 'La Rioja'),
(157, 'ES', 'Las Palmas', 'Las Palmas'),
(158, 'ES', 'Leon', 'Leon'),
(159, 'ES', 'Lleida', 'Lleida'),
(160, 'ES', 'Lugo', 'Lugo'),
(161, 'ES', 'Madrid', 'Madrid'),
(162, 'ES', 'Malaga', 'Malaga'),
(163, 'ES', 'Melilla', 'Melilla'),
(164, 'ES', 'Murcia', 'Murcia'),
(165, 'ES', 'Navarra', 'Navarra'),
(166, 'ES', 'Ourense', 'Ourense'),
(167, 'ES', 'Palencia', 'Palencia'),
(168, 'ES', 'Pontevedra', 'Pontevedra'),
(169, 'ES', 'Salamanca', 'Salamanca'),
(170, 'ES', 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife'),
(171, 'ES', 'Segovia', 'Segovia'),
(172, 'ES', 'Sevilla', 'Sevilla'),
(173, 'ES', 'Soria', 'Soria'),
(174, 'ES', 'Tarragona', 'Tarragona'),
(175, 'ES', 'Teruel', 'Teruel'),
(176, 'ES', 'Toledo', 'Toledo'),
(177, 'ES', 'Valencia', 'Valencia'),
(178, 'ES', 'Valladolid', 'Valladolid'),
(179, 'ES', 'Vizcaya', 'Vizcaya'),
(180, 'ES', 'Zamora', 'Zamora'),
(181, 'ES', 'Zaragoza', 'Zaragoza'),
(182, 'FR', '1', 'Ain'),
(183, 'FR', '2', 'Aisne'),
(184, 'FR', '3', 'Allier'),
(185, 'FR', '4', 'Alpes-de-Haute-Provence'),
(186, 'FR', '5', 'Hautes-Alpes'),
(187, 'FR', '6', 'Alpes-Maritimes'),
(188, 'FR', '7', 'Ardèche'),
(189, 'FR', '8', 'Ardennes'),
(190, 'FR', '9', 'Ariège'),
(191, 'FR', '10', 'Aube'),
(192, 'FR', '11', 'Aude'),
(193, 'FR', '12', 'Aveyron'),
(194, 'FR', '13', 'Bouches-du-Rhône'),
(195, 'FR', '14', 'Calvados'),
(196, 'FR', '15', 'Cantal'),
(197, 'FR', '16', 'Charente'),
(198, 'FR', '17', 'Charente-Maritime'),
(199, 'FR', '18', 'Cher'),
(200, 'FR', '19', 'Corrèze'),
(201, 'FR', '2A', 'Corse-du-Sud'),
(202, 'FR', '2B', 'Haute-Corse'),
(203, 'FR', '21', 'Côte-d''Or'),
(204, 'FR', '22', 'Côtes-d''Armor'),
(205, 'FR', '23', 'Creuse'),
(206, 'FR', '24', 'Dordogne'),
(207, 'FR', '25', 'Doubs'),
(208, 'FR', '26', 'Drôme'),
(209, 'FR', '27', 'Eure'),
(210, 'FR', '28', 'Eure-et-Loir'),
(211, 'FR', '29', 'Finistère'),
(212, 'FR', '30', 'Gard'),
(213, 'FR', '31', 'Haute-Garonne'),
(214, 'FR', '32', 'Gers'),
(215, 'FR', '33', 'Gironde'),
(216, 'FR', '34', 'Hérault'),
(217, 'FR', '35', 'Ille-et-Vilaine'),
(218, 'FR', '36', 'Indre'),
(219, 'FR', '37', 'Indre-et-Loire'),
(220, 'FR', '38', 'Isère'),
(221, 'FR', '39', 'Jura'),
(222, 'FR', '40', 'Landes'),
(223, 'FR', '41', 'Loir-et-Cher'),
(224, 'FR', '42', 'Loire'),
(225, 'FR', '43', 'Haute-Loire'),
(226, 'FR', '44', 'Loire-Atlantique'),
(227, 'FR', '45', 'Loiret'),
(228, 'FR', '46', 'Lot'),
(229, 'FR', '47', 'Lot-et-Garonne'),
(230, 'FR', '48', 'Lozère'),
(231, 'FR', '49', 'Maine-et-Loire'),
(232, 'FR', '50', 'Manche'),
(233, 'FR', '51', 'Marne'),
(234, 'FR', '52', 'Haute-Marne'),
(235, 'FR', '53', 'Mayenne'),
(236, 'FR', '54', 'Meurthe-et-Moselle'),
(237, 'FR', '55', 'Meuse'),
(238, 'FR', '56', 'Morbihan'),
(239, 'FR', '57', 'Moselle'),
(240, 'FR', '58', 'Nièvre'),
(241, 'FR', '59', 'Nord'),
(242, 'FR', '60', 'Oise'),
(243, 'FR', '61', 'Orne'),
(244, 'FR', '62', 'Pas-de-Calais'),
(245, 'FR', '63', 'Puy-de-Dôme'),
(246, 'FR', '64', 'Pyrénées-Atlantiques'),
(247, 'FR', '65', 'Hautes-Pyrénées'),
(248, 'FR', '66', 'Pyrénées-Orientales'),
(249, 'FR', '67', 'Bas-Rhin'),
(250, 'FR', '68', 'Haut-Rhin'),
(251, 'FR', '69', 'Rhône'),
(252, 'FR', '70', 'Haute-Saône'),
(253, 'FR', '71', 'Saône-et-Loire'),
(254, 'FR', '72', 'Sarthe'),
(255, 'FR', '73', 'Savoie'),
(256, 'FR', '74', 'Haute-Savoie'),
(257, 'FR', '75', 'Paris'),
(258, 'FR', '76', 'Seine-Maritime'),
(259, 'FR', '77', 'Seine-et-Marne'),
(260, 'FR', '78', 'Yvelines'),
(261, 'FR', '79', 'Deux-Sèvres'),
(262, 'FR', '80', 'Somme'),
(263, 'FR', '81', 'Tarn'),
(264, 'FR', '82', 'Tarn-et-Garonne'),
(265, 'FR', '83', 'Var'),
(266, 'FR', '84', 'Vaucluse'),
(267, 'FR', '85', 'Vendée'),
(268, 'FR', '86', 'Vienne'),
(269, 'FR', '87', 'Haute-Vienne'),
(270, 'FR', '88', 'Vosges'),
(271, 'FR', '89', 'Yonne'),
(272, 'FR', '90', 'Territoire-de-Belfort'),
(273, 'FR', '91', 'Essonne'),
(274, 'FR', '92', 'Hauts-de-Seine'),
(275, 'FR', '93', 'Seine-Saint-Denis'),
(276, 'FR', '94', 'Val-de-Marne'),
(277, 'FR', '95', 'Val-d''Oise'),
(278, 'RO', 'AB', 'Alba'),
(279, 'RO', 'AR', 'Arad'),
(280, 'RO', 'AG', 'Argeş'),
(281, 'RO', 'BC', 'Bacău'),
(282, 'RO', 'BH', 'Bihor'),
(283, 'RO', 'BN', 'Bistriţa-Năsăud'),
(284, 'RO', 'BT', 'Botoşani'),
(285, 'RO', 'BV', 'Braşov'),
(286, 'RO', 'BR', 'Brăila'),
(287, 'RO', 'B', 'Bucureşti'),
(288, 'RO', 'BZ', 'Buzău'),
(289, 'RO', 'CS', 'Caraş-Severin'),
(290, 'RO', 'CL', 'Călăraşi'),
(291, 'RO', 'CJ', 'Cluj'),
(292, 'RO', 'CT', 'Constanţa'),
(293, 'RO', 'CV', 'Covasna'),
(294, 'RO', 'DB', 'Dâmboviţa'),
(295, 'RO', 'DJ', 'Dolj'),
(296, 'RO', 'GL', 'Galaţi'),
(297, 'RO', 'GR', 'Giurgiu'),
(298, 'RO', 'GJ', 'Gorj'),
(299, 'RO', 'HR', 'Harghita'),
(300, 'RO', 'HD', 'Hunedoara'),
(301, 'RO', 'IL', 'Ialomiţa'),
(302, 'RO', 'IS', 'Iaşi'),
(303, 'RO', 'IF', 'Ilfov'),
(304, 'RO', 'MM', 'Maramureş'),
(305, 'RO', 'MH', 'Mehedinţi'),
(306, 'RO', 'MS', 'Mureş'),
(307, 'RO', 'NT', 'Neamţ'),
(308, 'RO', 'OT', 'Olt'),
(309, 'RO', 'PH', 'Prahova'),
(310, 'RO', 'SM', 'Satu-Mare'),
(311, 'RO', 'SJ', 'Sălaj'),
(312, 'RO', 'SB', 'Sibiu'),
(313, 'RO', 'SV', 'Suceava'),
(314, 'RO', 'TR', 'Teleorman'),
(315, 'RO', 'TM', 'Timiş'),
(316, 'RO', 'TL', 'Tulcea'),
(317, 'RO', 'VS', 'Vaslui'),
(318, 'RO', 'VL', 'Vâlcea'),
(319, 'RO', 'VN', 'Vrancea'),
(320, 'FI', 'Lappi', 'Lappi'),
(321, 'FI', 'Pohjois-Pohjanmaa', 'Pohjois-Pohjanmaa'),
(322, 'FI', 'Kainuu', 'Kainuu'),
(323, 'FI', 'Pohjois-Karjala', 'Pohjois-Karjala'),
(324, 'FI', 'Pohjois-Savo', 'Pohjois-Savo'),
(325, 'FI', 'Etelä-Savo', 'Etelä-Savo'),
(326, 'FI', 'Etelä-Pohjanmaa', 'Etelä-Pohjanmaa'),
(327, 'FI', 'Pohjanmaa', 'Pohjanmaa'),
(328, 'FI', 'Pirkanmaa', 'Pirkanmaa'),
(329, 'FI', 'Satakunta', 'Satakunta'),
(330, 'FI', 'Keski-Pohjanmaa', 'Keski-Pohjanmaa'),
(331, 'FI', 'Keski-Suomi', 'Keski-Suomi'),
(332, 'FI', 'Varsinais-Suomi', 'Varsinais-Suomi'),
(333, 'FI', 'Etelä-Karjala', 'Etelä-Karjala'),
(334, 'FI', 'Päijät-Häme', 'Päijät-Häme'),
(335, 'FI', 'Kanta-Häme', 'Kanta-Häme'),
(336, 'FI', 'Uusimaa', 'Uusimaa'),
(337, 'FI', 'Itä-Uusimaa', 'Itä-Uusimaa'),
(338, 'FI', 'Kymenlaakso', 'Kymenlaakso'),
(339, 'FI', 'Ahvenanmaa', 'Ahvenanmaa'),
(340, 'EE', 'EE-37', 'Harjumaa'),
(341, 'EE', 'EE-39', 'Hiiumaa'),
(342, 'EE', 'EE-44', 'Ida-Virumaa'),
(343, 'EE', 'EE-49', 'Jõgevamaa'),
(344, 'EE', 'EE-51', 'Järvamaa'),
(345, 'EE', 'EE-57', 'Läänemaa'),
(346, 'EE', 'EE-59', 'Lääne-Virumaa'),
(347, 'EE', 'EE-65', 'Põlvamaa'),
(348, 'EE', 'EE-67', 'Pärnumaa'),
(349, 'EE', 'EE-70', 'Raplamaa'),
(350, 'EE', 'EE-74', 'Saaremaa'),
(351, 'EE', 'EE-78', 'Tartumaa'),
(352, 'EE', 'EE-82', 'Valgamaa'),
(353, 'EE', 'EE-84', 'Viljandimaa'),
(354, 'EE', 'EE-86', 'Võrumaa'),
(355, 'LV', 'LV-DGV', 'Daugavpils'),
(356, 'LV', 'LV-JEL', 'Jelgava'),
(357, 'LV', 'Jēkabpils', 'Jēkabpils'),
(358, 'LV', 'LV-JUR', 'Jūrmala'),
(359, 'LV', 'LV-LPX', 'Liepāja'),
(360, 'LV', 'LV-LE', 'Liepājas novads'),
(361, 'LV', 'LV-REZ', 'Rēzekne'),
(362, 'LV', 'LV-RIX', 'Rīga'),
(363, 'LV', 'LV-RI', 'Rīgas novads'),
(364, 'LV', 'Valmiera', 'Valmiera'),
(365, 'LV', 'LV-VEN', 'Ventspils'),
(366, 'LV', 'Aglonas novads', 'Aglonas novads'),
(367, 'LV', 'LV-AI', 'Aizkraukles novads'),
(368, 'LV', 'Aizputes novads', 'Aizputes novads'),
(369, 'LV', 'Aknīstes novads', 'Aknīstes novads'),
(370, 'LV', 'Alojas novads', 'Alojas novads'),
(371, 'LV', 'Alsungas novads', 'Alsungas novads'),
(372, 'LV', 'LV-AL', 'Alūksnes novads'),
(373, 'LV', 'Amatas novads', 'Amatas novads'),
(374, 'LV', 'Apes novads', 'Apes novads'),
(375, 'LV', 'Auces novads', 'Auces novads'),
(376, 'LV', 'Babītes novads', 'Babītes novads'),
(377, 'LV', 'Baldones novads', 'Baldones novads'),
(378, 'LV', 'Baltinavas novads', 'Baltinavas novads'),
(379, 'LV', 'LV-BL', 'Balvu novads'),
(380, 'LV', 'LV-BU', 'Bauskas novads'),
(381, 'LV', 'Beverīnas novads', 'Beverīnas novads'),
(382, 'LV', 'Brocēnu novads', 'Brocēnu novads'),
(383, 'LV', 'Burtnieku novads', 'Burtnieku novads'),
(384, 'LV', 'Carnikavas novads', 'Carnikavas novads'),
(385, 'LV', 'Cesvaines novads', 'Cesvaines novads'),
(386, 'LV', 'Ciblas novads', 'Ciblas novads'),
(387, 'LV', 'LV-CE', 'Cēsu novads'),
(388, 'LV', 'Dagdas novads', 'Dagdas novads'),
(389, 'LV', 'LV-DA', 'Daugavpils novads'),
(390, 'LV', 'LV-DO', 'Dobeles novads'),
(391, 'LV', 'Dundagas novads', 'Dundagas novads'),
(392, 'LV', 'Durbes novads', 'Durbes novads'),
(393, 'LV', 'Engures novads', 'Engures novads'),
(394, 'LV', 'Garkalnes novads', 'Garkalnes novads'),
(395, 'LV', 'Grobiņas novads', 'Grobiņas novads'),
(396, 'LV', 'LV-GU', 'Gulbenes novads'),
(397, 'LV', 'Iecavas novads', 'Iecavas novads'),
(398, 'LV', 'Ikšķiles novads', 'Ikšķiles novads'),
(399, 'LV', 'Ilūkstes novads', 'Ilūkstes novads'),
(400, 'LV', 'Inčukalna novads', 'Inčukalna novads'),
(401, 'LV', 'Jaunjelgavas novads', 'Jaunjelgavas novads'),
(402, 'LV', 'Jaunpiebalgas novads', 'Jaunpiebalgas novads'),
(403, 'LV', 'Jaunpils novads', 'Jaunpils novads'),
(404, 'LV', 'LV-JL', 'Jelgavas novads'),
(405, 'LV', 'LV-JK', 'Jēkabpils novads'),
(406, 'LV', 'Kandavas novads', 'Kandavas novads'),
(407, 'LV', 'Kokneses novads', 'Kokneses novads'),
(408, 'LV', 'Krimuldas novads', 'Krimuldas novads'),
(409, 'LV', 'Krustpils novads', 'Krustpils novads'),
(410, 'LV', 'LV-KR', 'Krāslavas novads'),
(411, 'LV', 'LV-KU', 'Kuldīgas novads'),
(412, 'LV', 'Kārsavas novads', 'Kārsavas novads'),
(413, 'LV', 'Lielvārdes novads', 'Lielvārdes novads'),
(414, 'LV', 'LV-LM', 'Limbažu novads'),
(415, 'LV', 'Lubānas novads', 'Lubānas novads'),
(416, 'LV', 'LV-LU', 'Ludzas novads'),
(417, 'LV', 'Līgatnes novads', 'Līgatnes novads'),
(418, 'LV', 'Līvānu novads', 'Līvānu novads'),
(419, 'LV', 'LV-MA', 'Madonas novads'),
(420, 'LV', 'Mazsalacas novads', 'Mazsalacas novads'),
(421, 'LV', 'Mālpils novads', 'Mālpils novads'),
(422, 'LV', 'Mārupes novads', 'Mārupes novads'),
(423, 'LV', 'Naukšēnu novads', 'Naukšēnu novads'),
(424, 'LV', 'Neretas novads', 'Neretas novads'),
(425, 'LV', 'Nīcas novads', 'Nīcas novads'),
(426, 'LV', 'LV-OG', 'Ogres novads'),
(427, 'LV', 'Olaines novads', 'Olaines novads'),
(428, 'LV', 'Ozolnieku novads', 'Ozolnieku novads'),
(429, 'LV', 'LV-PR', 'Preiļu novads'),
(430, 'LV', 'Priekules novads', 'Priekules novads'),
(431, 'LV', 'Priekuļu novads', 'Priekuļu novads'),
(432, 'LV', 'Pārgaujas novads', 'Pārgaujas novads'),
(433, 'LV', 'Pāvilostas novads', 'Pāvilostas novads'),
(434, 'LV', 'Pļaviņu novads', 'Pļaviņu novads'),
(435, 'LV', 'Raunas novads', 'Raunas novads'),
(436, 'LV', 'Riebiņu novads', 'Riebiņu novads'),
(437, 'LV', 'Rojas novads', 'Rojas novads'),
(438, 'LV', 'Ropažu novads', 'Ropažu novads'),
(439, 'LV', 'Rucavas novads', 'Rucavas novads'),
(440, 'LV', 'Rugāju novads', 'Rugāju novads'),
(441, 'LV', 'Rundāles novads', 'Rundāles novads'),
(442, 'LV', 'LV-RE', 'Rēzeknes novads'),
(443, 'LV', 'Rūjienas novads', 'Rūjienas novads'),
(444, 'LV', 'Salacgrīvas novads', 'Salacgrīvas novads'),
(445, 'LV', 'Salas novads', 'Salas novads'),
(446, 'LV', 'Salaspils novads', 'Salaspils novads'),
(447, 'LV', 'LV-SA', 'Saldus novads'),
(448, 'LV', 'Saulkrastu novads', 'Saulkrastu novads'),
(449, 'LV', 'Siguldas novads', 'Siguldas novads'),
(450, 'LV', 'Skrundas novads', 'Skrundas novads'),
(451, 'LV', 'Skrīveru novads', 'Skrīveru novads'),
(452, 'LV', 'Smiltenes novads', 'Smiltenes novads'),
(453, 'LV', 'Stopiņu novads', 'Stopiņu novads'),
(454, 'LV', 'Strenču novads', 'Strenču novads'),
(455, 'LV', 'Sējas novads', 'Sējas novads'),
(456, 'LV', 'LV-TA', 'Talsu novads'),
(457, 'LV', 'LV-TU', 'Tukuma novads'),
(458, 'LV', 'Tērvetes novads', 'Tērvetes novads'),
(459, 'LV', 'Vaiņodes novads', 'Vaiņodes novads'),
(460, 'LV', 'LV-VK', 'Valkas novads'),
(461, 'LV', 'LV-VM', 'Valmieras novads'),
(462, 'LV', 'Varakļānu novads', 'Varakļānu novads'),
(463, 'LV', 'Vecpiebalgas novads', 'Vecpiebalgas novads'),
(464, 'LV', 'Vecumnieku novads', 'Vecumnieku novads'),
(465, 'LV', 'LV-VE', 'Ventspils novads'),
(466, 'LV', 'Viesītes novads', 'Viesītes novads'),
(467, 'LV', 'Viļakas novads', 'Viļakas novads'),
(468, 'LV', 'Viļānu novads', 'Viļānu novads'),
(469, 'LV', 'Vārkavas novads', 'Vārkavas novads'),
(470, 'LV', 'Zilupes novads', 'Zilupes novads'),
(471, 'LV', 'Ādažu novads', 'Ādažu novads'),
(472, 'LV', 'Ērgļu novads', 'Ērgļu novads'),
(473, 'LV', 'Ķeguma novads', 'Ķeguma novads'),
(474, 'LV', 'Ķekavas novads', 'Ķekavas novads'),
(475, 'LT', 'LT-AL', 'Alytaus Apskritis'),
(476, 'LT', 'LT-KU', 'Kauno Apskritis'),
(477, 'LT', 'LT-KL', 'Klaipėdos Apskritis'),
(478, 'LT', 'LT-MR', 'Marijampolės Apskritis'),
(479, 'LT', 'LT-PN', 'Panevėžio Apskritis'),
(480, 'LT', 'LT-SA', 'Šiaulių Apskritis'),
(481, 'LT', 'LT-TA', 'Tauragės Apskritis'),
(482, 'LT', 'LT-TE', 'Telšių Apskritis'),
(483, 'LT', 'LT-UT', 'Utenos Apskritis'),
(484, 'LT', 'LT-VL', 'Vilniaus Apskritis');

-- --------------------------------------------------------

--
-- Table structure for table `directory_country_region_name`
--

CREATE TABLE IF NOT EXISTS `directory_country_region_name` (
  `locale` varchar(8) NOT NULL DEFAULT '' COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';

--
-- Dumping data for table `directory_country_region_name`
--

INSERT INTO `directory_country_region_name` (`locale`, `region_id`, `name`) VALUES
('en_US', 1, 'Alabama'),
('en_US', 2, 'Alaska'),
('en_US', 3, 'American Samoa'),
('en_US', 4, 'Arizona'),
('en_US', 5, 'Arkansas'),
('en_US', 6, 'Armed Forces Africa'),
('en_US', 7, 'Armed Forces Americas'),
('en_US', 8, 'Armed Forces Canada'),
('en_US', 9, 'Armed Forces Europe'),
('en_US', 10, 'Armed Forces Middle East'),
('en_US', 11, 'Armed Forces Pacific'),
('en_US', 12, 'California'),
('en_US', 13, 'Colorado'),
('en_US', 14, 'Connecticut'),
('en_US', 15, 'Delaware'),
('en_US', 16, 'District of Columbia'),
('en_US', 17, 'Federated States Of Micronesia'),
('en_US', 18, 'Florida'),
('en_US', 19, 'Georgia'),
('en_US', 20, 'Guam'),
('en_US', 21, 'Hawaii'),
('en_US', 22, 'Idaho'),
('en_US', 23, 'Illinois'),
('en_US', 24, 'Indiana'),
('en_US', 25, 'Iowa'),
('en_US', 26, 'Kansas'),
('en_US', 27, 'Kentucky'),
('en_US', 28, 'Louisiana'),
('en_US', 29, 'Maine'),
('en_US', 30, 'Marshall Islands'),
('en_US', 31, 'Maryland'),
('en_US', 32, 'Massachusetts'),
('en_US', 33, 'Michigan'),
('en_US', 34, 'Minnesota'),
('en_US', 35, 'Mississippi'),
('en_US', 36, 'Missouri'),
('en_US', 37, 'Montana'),
('en_US', 38, 'Nebraska'),
('en_US', 39, 'Nevada'),
('en_US', 40, 'New Hampshire'),
('en_US', 41, 'New Jersey'),
('en_US', 42, 'New Mexico'),
('en_US', 43, 'New York'),
('en_US', 44, 'North Carolina'),
('en_US', 45, 'North Dakota'),
('en_US', 46, 'Northern Mariana Islands'),
('en_US', 47, 'Ohio'),
('en_US', 48, 'Oklahoma'),
('en_US', 49, 'Oregon'),
('en_US', 50, 'Palau'),
('en_US', 51, 'Pennsylvania'),
('en_US', 52, 'Puerto Rico'),
('en_US', 53, 'Rhode Island'),
('en_US', 54, 'South Carolina'),
('en_US', 55, 'South Dakota'),
('en_US', 56, 'Tennessee'),
('en_US', 57, 'Texas'),
('en_US', 58, 'Utah'),
('en_US', 59, 'Vermont'),
('en_US', 60, 'Virgin Islands'),
('en_US', 61, 'Virginia'),
('en_US', 62, 'Washington'),
('en_US', 63, 'West Virginia'),
('en_US', 64, 'Wisconsin'),
('en_US', 65, 'Wyoming'),
('en_US', 66, 'Alberta'),
('en_US', 67, 'British Columbia'),
('en_US', 68, 'Manitoba'),
('en_US', 69, 'Newfoundland and Labrador'),
('en_US', 70, 'New Brunswick'),
('en_US', 71, 'Nova Scotia'),
('en_US', 72, 'Northwest Territories'),
('en_US', 73, 'Nunavut'),
('en_US', 74, 'Ontario'),
('en_US', 75, 'Prince Edward Island'),
('en_US', 76, 'Quebec'),
('en_US', 77, 'Saskatchewan'),
('en_US', 78, 'Yukon Territory'),
('en_US', 79, 'Niedersachsen'),
('en_US', 80, 'Baden-Württemberg'),
('en_US', 81, 'Bayern'),
('en_US', 82, 'Berlin'),
('en_US', 83, 'Brandenburg'),
('en_US', 84, 'Bremen'),
('en_US', 85, 'Hamburg'),
('en_US', 86, 'Hessen'),
('en_US', 87, 'Mecklenburg-Vorpommern'),
('en_US', 88, 'Nordrhein-Westfalen'),
('en_US', 89, 'Rheinland-Pfalz'),
('en_US', 90, 'Saarland'),
('en_US', 91, 'Sachsen'),
('en_US', 92, 'Sachsen-Anhalt'),
('en_US', 93, 'Schleswig-Holstein'),
('en_US', 94, 'Thüringen'),
('en_US', 95, 'Wien'),
('en_US', 96, 'Niederösterreich'),
('en_US', 97, 'Oberösterreich'),
('en_US', 98, 'Salzburg'),
('en_US', 99, 'Kärnten'),
('en_US', 100, 'Steiermark'),
('en_US', 101, 'Tirol'),
('en_US', 102, 'Burgenland'),
('en_US', 103, 'Voralberg'),
('en_US', 104, 'Aargau'),
('en_US', 105, 'Appenzell Innerrhoden'),
('en_US', 106, 'Appenzell Ausserrhoden'),
('en_US', 107, 'Bern'),
('en_US', 108, 'Basel-Landschaft'),
('en_US', 109, 'Basel-Stadt'),
('en_US', 110, 'Freiburg'),
('en_US', 111, 'Genf'),
('en_US', 112, 'Glarus'),
('en_US', 113, 'Graubünden'),
('en_US', 114, 'Jura'),
('en_US', 115, 'Luzern'),
('en_US', 116, 'Neuenburg'),
('en_US', 117, 'Nidwalden'),
('en_US', 118, 'Obwalden'),
('en_US', 119, 'St. Gallen'),
('en_US', 120, 'Schaffhausen'),
('en_US', 121, 'Solothurn'),
('en_US', 122, 'Schwyz'),
('en_US', 123, 'Thurgau'),
('en_US', 124, 'Tessin'),
('en_US', 125, 'Uri'),
('en_US', 126, 'Waadt'),
('en_US', 127, 'Wallis'),
('en_US', 128, 'Zug'),
('en_US', 129, 'Zürich'),
('en_US', 130, 'A Coruña'),
('en_US', 131, 'Alava'),
('en_US', 132, 'Albacete'),
('en_US', 133, 'Alicante'),
('en_US', 134, 'Almeria'),
('en_US', 135, 'Asturias'),
('en_US', 136, 'Avila'),
('en_US', 137, 'Badajoz'),
('en_US', 138, 'Baleares'),
('en_US', 139, 'Barcelona'),
('en_US', 140, 'Burgos'),
('en_US', 141, 'Caceres'),
('en_US', 142, 'Cadiz'),
('en_US', 143, 'Cantabria'),
('en_US', 144, 'Castellon'),
('en_US', 145, 'Ceuta'),
('en_US', 146, 'Ciudad Real'),
('en_US', 147, 'Cordoba'),
('en_US', 148, 'Cuenca'),
('en_US', 149, 'Girona'),
('en_US', 150, 'Granada'),
('en_US', 151, 'Guadalajara'),
('en_US', 152, 'Guipuzcoa'),
('en_US', 153, 'Huelva'),
('en_US', 154, 'Huesca'),
('en_US', 155, 'Jaen'),
('en_US', 156, 'La Rioja'),
('en_US', 157, 'Las Palmas'),
('en_US', 158, 'Leon'),
('en_US', 159, 'Lleida'),
('en_US', 160, 'Lugo'),
('en_US', 161, 'Madrid'),
('en_US', 162, 'Malaga'),
('en_US', 163, 'Melilla'),
('en_US', 164, 'Murcia'),
('en_US', 165, 'Navarra'),
('en_US', 166, 'Ourense'),
('en_US', 167, 'Palencia'),
('en_US', 168, 'Pontevedra'),
('en_US', 169, 'Salamanca'),
('en_US', 170, 'Santa Cruz de Tenerife'),
('en_US', 171, 'Segovia'),
('en_US', 172, 'Sevilla'),
('en_US', 173, 'Soria'),
('en_US', 174, 'Tarragona'),
('en_US', 175, 'Teruel'),
('en_US', 176, 'Toledo'),
('en_US', 177, 'Valencia'),
('en_US', 178, 'Valladolid'),
('en_US', 179, 'Vizcaya'),
('en_US', 180, 'Zamora'),
('en_US', 181, 'Zaragoza'),
('en_US', 182, 'Ain'),
('en_US', 183, 'Aisne'),
('en_US', 184, 'Allier'),
('en_US', 185, 'Alpes-de-Haute-Provence'),
('en_US', 186, 'Hautes-Alpes'),
('en_US', 187, 'Alpes-Maritimes'),
('en_US', 188, 'Ardèche'),
('en_US', 189, 'Ardennes'),
('en_US', 190, 'Ariège'),
('en_US', 191, 'Aube'),
('en_US', 192, 'Aude'),
('en_US', 193, 'Aveyron'),
('en_US', 194, 'Bouches-du-Rhône'),
('en_US', 195, 'Calvados'),
('en_US', 196, 'Cantal'),
('en_US', 197, 'Charente'),
('en_US', 198, 'Charente-Maritime'),
('en_US', 199, 'Cher'),
('en_US', 200, 'Corrèze'),
('en_US', 201, 'Corse-du-Sud'),
('en_US', 202, 'Haute-Corse'),
('en_US', 203, 'Côte-d''Or'),
('en_US', 204, 'Côtes-d''Armor'),
('en_US', 205, 'Creuse'),
('en_US', 206, 'Dordogne'),
('en_US', 207, 'Doubs'),
('en_US', 208, 'Drôme'),
('en_US', 209, 'Eure'),
('en_US', 210, 'Eure-et-Loir'),
('en_US', 211, 'Finistère'),
('en_US', 212, 'Gard'),
('en_US', 213, 'Haute-Garonne'),
('en_US', 214, 'Gers'),
('en_US', 215, 'Gironde'),
('en_US', 216, 'Hérault'),
('en_US', 217, 'Ille-et-Vilaine'),
('en_US', 218, 'Indre'),
('en_US', 219, 'Indre-et-Loire'),
('en_US', 220, 'Isère'),
('en_US', 221, 'Jura'),
('en_US', 222, 'Landes'),
('en_US', 223, 'Loir-et-Cher'),
('en_US', 224, 'Loire'),
('en_US', 225, 'Haute-Loire'),
('en_US', 226, 'Loire-Atlantique'),
('en_US', 227, 'Loiret'),
('en_US', 228, 'Lot'),
('en_US', 229, 'Lot-et-Garonne'),
('en_US', 230, 'Lozère'),
('en_US', 231, 'Maine-et-Loire'),
('en_US', 232, 'Manche'),
('en_US', 233, 'Marne'),
('en_US', 234, 'Haute-Marne'),
('en_US', 235, 'Mayenne'),
('en_US', 236, 'Meurthe-et-Moselle'),
('en_US', 237, 'Meuse'),
('en_US', 238, 'Morbihan'),
('en_US', 239, 'Moselle'),
('en_US', 240, 'Nièvre'),
('en_US', 241, 'Nord'),
('en_US', 242, 'Oise'),
('en_US', 243, 'Orne'),
('en_US', 244, 'Pas-de-Calais'),
('en_US', 245, 'Puy-de-Dôme'),
('en_US', 246, 'Pyrénées-Atlantiques'),
('en_US', 247, 'Hautes-Pyrénées'),
('en_US', 248, 'Pyrénées-Orientales'),
('en_US', 249, 'Bas-Rhin'),
('en_US', 250, 'Haut-Rhin'),
('en_US', 251, 'Rhône'),
('en_US', 252, 'Haute-Saône'),
('en_US', 253, 'Saône-et-Loire'),
('en_US', 254, 'Sarthe'),
('en_US', 255, 'Savoie'),
('en_US', 256, 'Haute-Savoie'),
('en_US', 257, 'Paris'),
('en_US', 258, 'Seine-Maritime'),
('en_US', 259, 'Seine-et-Marne'),
('en_US', 260, 'Yvelines'),
('en_US', 261, 'Deux-Sèvres'),
('en_US', 262, 'Somme'),
('en_US', 263, 'Tarn'),
('en_US', 264, 'Tarn-et-Garonne'),
('en_US', 265, 'Var'),
('en_US', 266, 'Vaucluse'),
('en_US', 267, 'Vendée'),
('en_US', 268, 'Vienne'),
('en_US', 269, 'Haute-Vienne'),
('en_US', 270, 'Vosges'),
('en_US', 271, 'Yonne'),
('en_US', 272, 'Territoire-de-Belfort'),
('en_US', 273, 'Essonne'),
('en_US', 274, 'Hauts-de-Seine'),
('en_US', 275, 'Seine-Saint-Denis'),
('en_US', 276, 'Val-de-Marne'),
('en_US', 277, 'Val-d''Oise'),
('en_US', 278, 'Alba'),
('en_US', 279, 'Arad'),
('en_US', 280, 'Argeş'),
('en_US', 281, 'Bacău'),
('en_US', 282, 'Bihor'),
('en_US', 283, 'Bistriţa-Năsăud'),
('en_US', 284, 'Botoşani'),
('en_US', 285, 'Braşov'),
('en_US', 286, 'Brăila'),
('en_US', 287, 'Bucureşti'),
('en_US', 288, 'Buzău'),
('en_US', 289, 'Caraş-Severin'),
('en_US', 290, 'Călăraşi'),
('en_US', 291, 'Cluj'),
('en_US', 292, 'Constanţa'),
('en_US', 293, 'Covasna'),
('en_US', 294, 'Dâmboviţa'),
('en_US', 295, 'Dolj'),
('en_US', 296, 'Galaţi'),
('en_US', 297, 'Giurgiu'),
('en_US', 298, 'Gorj'),
('en_US', 299, 'Harghita'),
('en_US', 300, 'Hunedoara'),
('en_US', 301, 'Ialomiţa'),
('en_US', 302, 'Iaşi'),
('en_US', 303, 'Ilfov'),
('en_US', 304, 'Maramureş'),
('en_US', 305, 'Mehedinţi'),
('en_US', 306, 'Mureş'),
('en_US', 307, 'Neamţ'),
('en_US', 308, 'Olt'),
('en_US', 309, 'Prahova'),
('en_US', 310, 'Satu-Mare'),
('en_US', 311, 'Sălaj'),
('en_US', 312, 'Sibiu'),
('en_US', 313, 'Suceava'),
('en_US', 314, 'Teleorman'),
('en_US', 315, 'Timiş'),
('en_US', 316, 'Tulcea'),
('en_US', 317, 'Vaslui'),
('en_US', 318, 'Vâlcea'),
('en_US', 319, 'Vrancea'),
('en_US', 320, 'Lappi'),
('en_US', 321, 'Pohjois-Pohjanmaa'),
('en_US', 322, 'Kainuu'),
('en_US', 323, 'Pohjois-Karjala'),
('en_US', 324, 'Pohjois-Savo'),
('en_US', 325, 'Etelä-Savo'),
('en_US', 326, 'Etelä-Pohjanmaa'),
('en_US', 327, 'Pohjanmaa'),
('en_US', 328, 'Pirkanmaa'),
('en_US', 329, 'Satakunta'),
('en_US', 330, 'Keski-Pohjanmaa'),
('en_US', 331, 'Keski-Suomi'),
('en_US', 332, 'Varsinais-Suomi'),
('en_US', 333, 'Etelä-Karjala'),
('en_US', 334, 'Päijät-Häme'),
('en_US', 335, 'Kanta-Häme'),
('en_US', 336, 'Uusimaa'),
('en_US', 337, 'Itä-Uusimaa'),
('en_US', 338, 'Kymenlaakso'),
('en_US', 339, 'Ahvenanmaa'),
('en_US', 340, 'Harjumaa'),
('en_US', 341, 'Hiiumaa'),
('en_US', 342, 'Ida-Virumaa'),
('en_US', 343, 'Jõgevamaa'),
('en_US', 344, 'Järvamaa'),
('en_US', 345, 'Läänemaa'),
('en_US', 346, 'Lääne-Virumaa'),
('en_US', 347, 'Põlvamaa'),
('en_US', 348, 'Pärnumaa'),
('en_US', 349, 'Raplamaa'),
('en_US', 350, 'Saaremaa'),
('en_US', 351, 'Tartumaa'),
('en_US', 352, 'Valgamaa'),
('en_US', 353, 'Viljandimaa'),
('en_US', 354, 'Võrumaa'),
('en_US', 355, 'Daugavpils'),
('en_US', 356, 'Jelgava'),
('en_US', 357, 'Jēkabpils'),
('en_US', 358, 'Jūrmala'),
('en_US', 359, 'Liepāja'),
('en_US', 360, 'Liepājas novads'),
('en_US', 361, 'Rēzekne'),
('en_US', 362, 'Rīga'),
('en_US', 363, 'Rīgas novads'),
('en_US', 364, 'Valmiera'),
('en_US', 365, 'Ventspils'),
('en_US', 366, 'Aglonas novads'),
('en_US', 367, 'Aizkraukles novads'),
('en_US', 368, 'Aizputes novads'),
('en_US', 369, 'Aknīstes novads'),
('en_US', 370, 'Alojas novads'),
('en_US', 371, 'Alsungas novads'),
('en_US', 372, 'Alūksnes novads'),
('en_US', 373, 'Amatas novads'),
('en_US', 374, 'Apes novads'),
('en_US', 375, 'Auces novads'),
('en_US', 376, 'Babītes novads'),
('en_US', 377, 'Baldones novads'),
('en_US', 378, 'Baltinavas novads'),
('en_US', 379, 'Balvu novads'),
('en_US', 380, 'Bauskas novads'),
('en_US', 381, 'Beverīnas novads'),
('en_US', 382, 'Brocēnu novads'),
('en_US', 383, 'Burtnieku novads'),
('en_US', 384, 'Carnikavas novads'),
('en_US', 385, 'Cesvaines novads'),
('en_US', 386, 'Ciblas novads'),
('en_US', 387, 'Cēsu novads'),
('en_US', 388, 'Dagdas novads'),
('en_US', 389, 'Daugavpils novads'),
('en_US', 390, 'Dobeles novads'),
('en_US', 391, 'Dundagas novads'),
('en_US', 392, 'Durbes novads'),
('en_US', 393, 'Engures novads'),
('en_US', 394, 'Garkalnes novads'),
('en_US', 395, 'Grobiņas novads'),
('en_US', 396, 'Gulbenes novads'),
('en_US', 397, 'Iecavas novads'),
('en_US', 398, 'Ikšķiles novads'),
('en_US', 399, 'Ilūkstes novads'),
('en_US', 400, 'Inčukalna novads'),
('en_US', 401, 'Jaunjelgavas novads'),
('en_US', 402, 'Jaunpiebalgas novads'),
('en_US', 403, 'Jaunpils novads'),
('en_US', 404, 'Jelgavas novads'),
('en_US', 405, 'Jēkabpils novads'),
('en_US', 406, 'Kandavas novads'),
('en_US', 407, 'Kokneses novads'),
('en_US', 408, 'Krimuldas novads'),
('en_US', 409, 'Krustpils novads'),
('en_US', 410, 'Krāslavas novads'),
('en_US', 411, 'Kuldīgas novads'),
('en_US', 412, 'Kārsavas novads'),
('en_US', 413, 'Lielvārdes novads'),
('en_US', 414, 'Limbažu novads'),
('en_US', 415, 'Lubānas novads'),
('en_US', 416, 'Ludzas novads'),
('en_US', 417, 'Līgatnes novads'),
('en_US', 418, 'Līvānu novads'),
('en_US', 419, 'Madonas novads'),
('en_US', 420, 'Mazsalacas novads'),
('en_US', 421, 'Mālpils novads'),
('en_US', 422, 'Mārupes novads'),
('en_US', 423, 'Naukšēnu novads'),
('en_US', 424, 'Neretas novads'),
('en_US', 425, 'Nīcas novads'),
('en_US', 426, 'Ogres novads'),
('en_US', 427, 'Olaines novads'),
('en_US', 428, 'Ozolnieku novads'),
('en_US', 429, 'Preiļu novads'),
('en_US', 430, 'Priekules novads'),
('en_US', 431, 'Priekuļu novads'),
('en_US', 432, 'Pārgaujas novads'),
('en_US', 433, 'Pāvilostas novads'),
('en_US', 434, 'Pļaviņu novads'),
('en_US', 435, 'Raunas novads'),
('en_US', 436, 'Riebiņu novads'),
('en_US', 437, 'Rojas novads'),
('en_US', 438, 'Ropažu novads'),
('en_US', 439, 'Rucavas novads'),
('en_US', 440, 'Rugāju novads'),
('en_US', 441, 'Rundāles novads'),
('en_US', 442, 'Rēzeknes novads'),
('en_US', 443, 'Rūjienas novads'),
('en_US', 444, 'Salacgrīvas novads'),
('en_US', 445, 'Salas novads'),
('en_US', 446, 'Salaspils novads'),
('en_US', 447, 'Saldus novads'),
('en_US', 448, 'Saulkrastu novads'),
('en_US', 449, 'Siguldas novads'),
('en_US', 450, 'Skrundas novads'),
('en_US', 451, 'Skrīveru novads'),
('en_US', 452, 'Smiltenes novads'),
('en_US', 453, 'Stopiņu novads'),
('en_US', 454, 'Strenču novads'),
('en_US', 455, 'Sējas novads'),
('en_US', 456, 'Talsu novads'),
('en_US', 457, 'Tukuma novads'),
('en_US', 458, 'Tērvetes novads'),
('en_US', 459, 'Vaiņodes novads'),
('en_US', 460, 'Valkas novads'),
('en_US', 461, 'Valmieras novads'),
('en_US', 462, 'Varakļānu novads'),
('en_US', 463, 'Vecpiebalgas novads'),
('en_US', 464, 'Vecumnieku novads'),
('en_US', 465, 'Ventspils novads'),
('en_US', 466, 'Viesītes novads'),
('en_US', 467, 'Viļakas novads'),
('en_US', 468, 'Viļānu novads'),
('en_US', 469, 'Vārkavas novads'),
('en_US', 470, 'Zilupes novads'),
('en_US', 471, 'Ādažu novads'),
('en_US', 472, 'Ērgļu novads'),
('en_US', 473, 'Ķeguma novads'),
('en_US', 474, 'Ķekavas novads'),
('en_US', 475, 'Alytaus Apskritis'),
('en_US', 476, 'Kauno Apskritis'),
('en_US', 477, 'Klaipėdos Apskritis'),
('en_US', 478, 'Marijampolės Apskritis'),
('en_US', 479, 'Panevėžio Apskritis'),
('en_US', 480, 'Šiaulių Apskritis'),
('en_US', 481, 'Tauragės Apskritis'),
('en_US', 482, 'Telšių Apskritis'),
('en_US', 483, 'Utenos Apskritis'),
('en_US', 484, 'Vilniaus Apskritis');

-- --------------------------------------------------------

--
-- Table structure for table `directory_currency_rate`
--

CREATE TABLE IF NOT EXISTS `directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `IDX_DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';

--
-- Dumping data for table `directory_currency_rate`
--

INSERT INTO `directory_currency_rate` (`currency_from`, `currency_to`, `rate`) VALUES
('EUR', 'EUR', '1.000000000000'),
('EUR', 'USD', '1.415000000000'),
('USD', 'EUR', '0.706700000000'),
('USD', 'USD', '1.000000000000');

-- --------------------------------------------------------

--
-- Table structure for table `downloadable_link`
--

CREATE TABLE IF NOT EXISTS `downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `downloadable_link_price`
--

CREATE TABLE IF NOT EXISTS `downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `downloadable_link_purchased`
--

CREATE TABLE IF NOT EXISTS `downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `downloadable_link_purchased_item`
--

CREATE TABLE IF NOT EXISTS `downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `downloadable_link_title`
--

CREATE TABLE IF NOT EXISTS `downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Title Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `downloadable_sample`
--

CREATE TABLE IF NOT EXISTS `downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `downloadable_sample_title`
--

CREATE TABLE IF NOT EXISTS `downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID` (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_attribute`
--

CREATE TABLE IF NOT EXISTS `eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) DEFAULT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  KEY `IDX_EAV_ATTRIBUTE_ENTITY_TYPE_ID` (`entity_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Attribute' AUTO_INCREMENT=135 ;

--
-- Dumping data for table `eav_attribute`
--

INSERT INTO `eav_attribute` (`attribute_id`, `entity_type_id`, `attribute_code`, `attribute_model`, `backend_model`, `backend_type`, `backend_table`, `frontend_model`, `frontend_input`, `frontend_label`, `frontend_class`, `source_model`, `is_required`, `is_user_defined`, `default_value`, `is_unique`, `note`) VALUES
(1, 1, 'website_id', NULL, 'customer/customer_attribute_backend_website', 'static', NULL, NULL, 'select', 'Associate to Website', NULL, 'customer/customer_attribute_source_website', 1, 0, NULL, 0, NULL),
(2, 1, 'store_id', NULL, 'customer/customer_attribute_backend_store', 'static', NULL, NULL, 'select', 'Create In', NULL, 'customer/customer_attribute_source_store', 1, 0, NULL, 0, NULL),
(3, 1, 'created_in', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Created From', NULL, NULL, 0, 0, NULL, 0, NULL),
(4, 1, 'prefix', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Prefix', NULL, NULL, 0, 0, NULL, 0, NULL),
(5, 1, 'firstname', NULL, NULL, 'varchar', NULL, NULL, 'text', 'First Name', NULL, NULL, 1, 0, NULL, 0, NULL),
(6, 1, 'middlename', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Middle Name/Initial', NULL, NULL, 0, 0, NULL, 0, NULL),
(7, 1, 'lastname', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Last Name', NULL, NULL, 1, 0, NULL, 0, NULL),
(8, 1, 'suffix', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Suffix', NULL, NULL, 0, 0, NULL, 0, NULL),
(9, 1, 'email', NULL, NULL, 'static', NULL, NULL, 'text', 'Email', NULL, NULL, 1, 0, NULL, 0, NULL),
(10, 1, 'group_id', NULL, NULL, 'static', NULL, NULL, 'select', 'Group', NULL, 'customer/customer_attribute_source_group', 1, 0, NULL, 0, NULL),
(11, 1, 'dob', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, 'eav/entity_attribute_frontend_datetime', 'date', 'Date Of Birth', NULL, NULL, 0, 0, NULL, 0, NULL),
(12, 1, 'password_hash', NULL, 'customer/customer_attribute_backend_password', 'varchar', NULL, NULL, 'hidden', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(13, 1, 'default_billing', NULL, 'customer/customer_attribute_backend_billing', 'int', NULL, NULL, 'text', 'Default Billing Address', NULL, NULL, 0, 0, NULL, 0, NULL),
(14, 1, 'default_shipping', NULL, 'customer/customer_attribute_backend_shipping', 'int', NULL, NULL, 'text', 'Default Shipping Address', NULL, NULL, 0, 0, NULL, 0, NULL),
(15, 1, 'taxvat', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Tax/VAT Number', NULL, NULL, 0, 0, NULL, 0, NULL),
(16, 1, 'confirmation', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Is Confirmed', NULL, NULL, 0, 0, NULL, 0, NULL),
(17, 1, 'created_at', NULL, NULL, 'static', NULL, NULL, 'date', 'Created At', NULL, NULL, 0, 0, NULL, 0, NULL),
(18, 1, 'gender', NULL, NULL, 'int', NULL, NULL, 'select', 'Gender', NULL, 'eav/entity_attribute_source_table', 0, 0, NULL, 0, NULL),
(19, 2, 'prefix', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Prefix', NULL, NULL, 0, 0, NULL, 0, NULL),
(20, 2, 'firstname', NULL, NULL, 'varchar', NULL, NULL, 'text', 'First Name', NULL, NULL, 1, 0, NULL, 0, NULL),
(21, 2, 'middlename', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Middle Name/Initial', NULL, NULL, 0, 0, NULL, 0, NULL),
(22, 2, 'lastname', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Last Name', NULL, NULL, 1, 0, NULL, 0, NULL),
(23, 2, 'suffix', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Suffix', NULL, NULL, 0, 0, NULL, 0, NULL),
(24, 2, 'company', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Company', NULL, NULL, 0, 0, NULL, 0, NULL),
(25, 2, 'street', NULL, 'customer/entity_address_attribute_backend_street', 'text', NULL, NULL, 'multiline', 'Street Address', NULL, NULL, 1, 0, NULL, 0, NULL),
(26, 2, 'city', NULL, NULL, 'varchar', NULL, NULL, 'text', 'City', NULL, NULL, 1, 0, NULL, 0, NULL),
(27, 2, 'country_id', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Country', NULL, 'customer/entity_address_attribute_source_country', 1, 0, NULL, 0, NULL),
(28, 2, 'region', NULL, 'customer/entity_address_attribute_backend_region', 'varchar', NULL, NULL, 'text', 'State/Province', NULL, NULL, 0, 0, NULL, 0, NULL),
(29, 2, 'region_id', NULL, NULL, 'int', NULL, NULL, 'hidden', 'State/Province', NULL, 'customer/entity_address_attribute_source_region', 0, 0, NULL, 0, NULL),
(30, 2, 'postcode', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Zip/Postal Code', NULL, NULL, 1, 0, NULL, 0, NULL),
(31, 2, 'telephone', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Telephone', NULL, NULL, 1, 0, NULL, 0, NULL),
(32, 2, 'fax', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Fax', NULL, NULL, 0, 0, NULL, 0, NULL),
(33, 1, 'rp_token', NULL, NULL, 'varchar', NULL, NULL, 'hidden', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(34, 1, 'rp_token_created_at', NULL, NULL, 'datetime', NULL, NULL, 'date', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(35, 1, 'disable_auto_group_change', NULL, 'customer/attribute_backend_data_boolean', 'static', NULL, NULL, 'boolean', 'Disable Automatic Group Change Based on VAT ID', NULL, NULL, 0, 0, NULL, 0, NULL),
(36, 2, 'vat_id', NULL, NULL, 'varchar', NULL, NULL, 'text', 'VAT number', NULL, NULL, 0, 0, NULL, 0, NULL),
(37, 2, 'vat_is_valid', NULL, NULL, 'int', NULL, NULL, 'text', 'VAT number validity', NULL, NULL, 0, 0, NULL, 0, NULL),
(38, 2, 'vat_request_id', NULL, NULL, 'varchar', NULL, NULL, 'text', 'VAT number validation request ID', NULL, NULL, 0, 0, NULL, 0, NULL),
(39, 2, 'vat_request_date', NULL, NULL, 'varchar', NULL, NULL, 'text', 'VAT number validation request date', NULL, NULL, 0, 0, NULL, 0, NULL),
(40, 2, 'vat_request_success', NULL, NULL, 'int', NULL, NULL, 'text', 'VAT number validation request success', NULL, NULL, 0, 0, NULL, 0, NULL),
(41, 3, 'name', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Name', NULL, NULL, 1, 0, NULL, 0, NULL),
(42, 3, 'is_active', NULL, NULL, 'int', NULL, NULL, 'select', 'Is Active', NULL, 'eav/entity_attribute_source_boolean', 1, 0, NULL, 0, NULL),
(43, 3, 'url_key', NULL, 'catalog/category_attribute_backend_urlkey', 'varchar', NULL, NULL, 'text', 'URL Key', NULL, NULL, 0, 0, NULL, 0, NULL),
(44, 3, 'description', NULL, NULL, 'text', NULL, NULL, 'textarea', 'Description', NULL, NULL, 0, 0, NULL, 0, NULL),
(45, 3, 'image', NULL, 'catalog/category_attribute_backend_image', 'varchar', NULL, NULL, 'image', 'Image', NULL, NULL, 0, 0, NULL, 0, NULL),
(46, 3, 'meta_title', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Page Title', NULL, NULL, 0, 0, NULL, 0, NULL),
(47, 3, 'meta_keywords', NULL, NULL, 'text', NULL, NULL, 'textarea', 'Meta Keywords', NULL, NULL, 0, 0, NULL, 0, NULL),
(48, 3, 'meta_description', NULL, NULL, 'text', NULL, NULL, 'textarea', 'Meta Description', NULL, NULL, 0, 0, NULL, 0, NULL),
(49, 3, 'display_mode', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Display Mode', NULL, 'catalog/category_attribute_source_mode', 0, 0, NULL, 0, NULL),
(50, 3, 'landing_page', NULL, NULL, 'int', NULL, NULL, 'select', 'CMS Block', NULL, 'catalog/category_attribute_source_page', 0, 0, NULL, 0, NULL),
(51, 3, 'is_anchor', NULL, NULL, 'int', NULL, NULL, 'select', 'Is Anchor', NULL, 'eav/entity_attribute_source_boolean', 0, 0, NULL, 0, NULL),
(52, 3, 'path', NULL, NULL, 'static', NULL, NULL, 'text', 'Path', NULL, NULL, 0, 0, NULL, 0, NULL),
(53, 3, 'position', NULL, NULL, 'static', NULL, NULL, 'text', 'Position', NULL, NULL, 0, 0, NULL, 0, NULL),
(54, 3, 'all_children', NULL, NULL, 'text', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(55, 3, 'path_in_store', NULL, NULL, 'text', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(56, 3, 'children', NULL, NULL, 'text', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(57, 3, 'url_path', NULL, NULL, 'varchar', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(58, 3, 'custom_design', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Custom Design', NULL, 'core/design_source_design', 0, 0, NULL, 0, NULL),
(59, 3, 'custom_design_from', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, NULL, 'date', 'Active From', NULL, NULL, 0, 0, NULL, 0, NULL),
(60, 3, 'custom_design_to', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, NULL, 'date', 'Active To', NULL, NULL, 0, 0, NULL, 0, NULL),
(61, 3, 'page_layout', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Page Layout', NULL, 'catalog/category_attribute_source_layout', 0, 0, NULL, 0, NULL),
(62, 3, 'custom_layout_update', NULL, 'catalog/attribute_backend_customlayoutupdate', 'text', NULL, NULL, 'textarea', 'Custom Layout Update', NULL, NULL, 0, 0, NULL, 0, NULL),
(63, 3, 'level', NULL, NULL, 'static', NULL, NULL, 'text', 'Level', NULL, NULL, 0, 0, NULL, 0, NULL),
(64, 3, 'children_count', NULL, NULL, 'static', NULL, NULL, 'text', 'Children Count', NULL, NULL, 0, 0, NULL, 0, NULL),
(65, 3, 'available_sort_by', NULL, 'catalog/category_attribute_backend_sortby', 'text', NULL, NULL, 'multiselect', 'Available Product Listing Sort By', NULL, 'catalog/category_attribute_source_sortby', 1, 0, NULL, 0, NULL),
(66, 3, 'default_sort_by', NULL, 'catalog/category_attribute_backend_sortby', 'varchar', NULL, NULL, 'select', 'Default Product Listing Sort By', NULL, 'catalog/category_attribute_source_sortby', 1, 0, NULL, 0, NULL),
(67, 3, 'include_in_menu', NULL, NULL, 'int', NULL, NULL, 'select', 'Include in Navigation Menu', NULL, 'eav/entity_attribute_source_boolean', 1, 0, '1', 0, NULL),
(68, 3, 'custom_use_parent_settings', NULL, NULL, 'int', NULL, NULL, 'select', 'Use Parent Category Settings', NULL, 'eav/entity_attribute_source_boolean', 0, 0, NULL, 0, NULL),
(69, 3, 'custom_apply_to_products', NULL, NULL, 'int', NULL, NULL, 'select', 'Apply To Products', NULL, 'eav/entity_attribute_source_boolean', 0, 0, NULL, 0, NULL),
(70, 3, 'filter_price_range', NULL, NULL, 'decimal', NULL, NULL, 'text', 'Layered Navigation Price Step', NULL, NULL, 0, 0, NULL, 0, NULL),
(71, 4, 'name', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Name', NULL, NULL, 1, 0, NULL, 0, NULL),
(72, 4, 'description', NULL, NULL, 'text', NULL, NULL, 'textarea', 'Description', NULL, NULL, 1, 0, NULL, 0, NULL),
(73, 4, 'short_description', NULL, NULL, 'text', NULL, NULL, 'textarea', 'Short Description', NULL, NULL, 1, 0, NULL, 0, NULL),
(74, 4, 'sku', NULL, 'catalog/product_attribute_backend_sku', 'static', NULL, NULL, 'text', 'SKU', NULL, NULL, 1, 0, NULL, 1, NULL),
(75, 4, 'price', NULL, 'catalog/product_attribute_backend_price', 'decimal', NULL, NULL, 'price', 'Price', NULL, NULL, 1, 0, NULL, 0, NULL),
(76, 4, 'special_price', NULL, 'catalog/product_attribute_backend_price', 'decimal', NULL, NULL, 'price', 'Special Price', NULL, NULL, 0, 0, NULL, 0, NULL),
(77, 4, 'special_from_date', NULL, 'catalog/product_attribute_backend_startdate', 'datetime', NULL, NULL, 'date', 'Special Price From Date', NULL, NULL, 0, 0, NULL, 0, NULL),
(78, 4, 'special_to_date', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, NULL, 'date', 'Special Price To Date', NULL, NULL, 0, 0, NULL, 0, NULL),
(79, 4, 'cost', NULL, 'catalog/product_attribute_backend_price', 'decimal', NULL, NULL, 'price', 'Cost', NULL, NULL, 0, 1, NULL, 0, NULL),
(80, 4, 'weight', NULL, NULL, 'decimal', NULL, NULL, 'weight', 'Weight', NULL, NULL, 1, 0, NULL, 0, NULL),
(81, 4, 'manufacturer', NULL, NULL, 'int', NULL, NULL, 'select', 'Manufacturer', NULL, NULL, 0, 1, NULL, 0, NULL),
(82, 4, 'meta_title', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Meta Title', NULL, NULL, 0, 0, NULL, 0, NULL),
(83, 4, 'meta_keyword', NULL, NULL, 'text', NULL, NULL, 'textarea', 'Meta Keywords', NULL, NULL, 0, 0, NULL, 0, NULL),
(84, 4, 'meta_description', NULL, NULL, 'varchar', NULL, NULL, 'textarea', 'Meta Description', NULL, NULL, 0, 0, NULL, 0, 'Maximum 255 chars'),
(85, 4, 'image', NULL, NULL, 'varchar', NULL, 'catalog/product_attribute_frontend_image', 'media_image', 'Base Image', NULL, NULL, 0, 0, NULL, 0, NULL),
(86, 4, 'small_image', NULL, NULL, 'varchar', NULL, 'catalog/product_attribute_frontend_image', 'media_image', 'Small Image', NULL, NULL, 0, 0, NULL, 0, NULL),
(87, 4, 'thumbnail', NULL, NULL, 'varchar', NULL, 'catalog/product_attribute_frontend_image', 'media_image', 'Thumbnail', NULL, NULL, 0, 0, NULL, 0, NULL),
(88, 4, 'media_gallery', NULL, 'catalog/product_attribute_backend_media', 'varchar', NULL, NULL, 'gallery', 'Media Gallery', NULL, NULL, 0, 0, NULL, 0, NULL),
(89, 4, 'old_id', NULL, NULL, 'int', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(90, 4, 'group_price', NULL, 'catalog/product_attribute_backend_groupprice', 'decimal', NULL, NULL, 'text', 'Group Price', NULL, NULL, 0, 0, NULL, 0, NULL),
(91, 4, 'tier_price', NULL, 'catalog/product_attribute_backend_tierprice', 'decimal', NULL, NULL, 'text', 'Tier Price', NULL, NULL, 0, 0, NULL, 0, NULL),
(92, 4, 'color', NULL, NULL, 'int', NULL, NULL, 'select', 'Color', NULL, NULL, 0, 1, NULL, 0, NULL),
(93, 4, 'news_from_date', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, NULL, 'date', 'Set Product as New from Date', NULL, NULL, 0, 0, NULL, 0, NULL),
(94, 4, 'news_to_date', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, NULL, 'date', 'Set Product as New to Date', NULL, NULL, 0, 0, NULL, 0, NULL),
(95, 4, 'gallery', NULL, NULL, 'varchar', NULL, NULL, 'gallery', 'Image Gallery', NULL, NULL, 0, 0, NULL, 0, NULL),
(96, 4, 'status', NULL, NULL, 'int', NULL, NULL, 'select', 'Status', NULL, 'catalog/product_status', 1, 0, NULL, 0, NULL),
(97, 4, 'url_key', NULL, 'catalog/product_attribute_backend_urlkey', 'varchar', NULL, NULL, 'text', 'URL Key', NULL, NULL, 0, 0, NULL, 0, NULL),
(98, 4, 'url_path', NULL, NULL, 'varchar', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(99, 4, 'minimal_price', NULL, NULL, 'decimal', NULL, NULL, 'price', 'Minimal Price', NULL, NULL, 0, 0, NULL, 0, NULL),
(100, 4, 'is_recurring', NULL, NULL, 'int', NULL, NULL, 'select', 'Enable Recurring Profile', NULL, 'eav/entity_attribute_source_boolean', 0, 0, NULL, 0, 'Products with recurring profile participate in catalog as nominal items.'),
(101, 4, 'recurring_profile', NULL, 'catalog/product_attribute_backend_recurring', 'text', NULL, NULL, 'text', 'Recurring Payment Profile', NULL, NULL, 0, 0, NULL, 0, NULL),
(102, 4, 'visibility', NULL, NULL, 'int', NULL, NULL, 'select', 'Visibility', NULL, 'catalog/product_visibility', 1, 0, '4', 0, NULL),
(103, 4, 'custom_design', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Custom Design', NULL, 'core/design_source_design', 0, 0, NULL, 0, NULL),
(104, 4, 'custom_design_from', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, NULL, 'date', 'Active From', NULL, NULL, 0, 0, NULL, 0, NULL),
(105, 4, 'custom_design_to', NULL, 'eav/entity_attribute_backend_datetime', 'datetime', NULL, NULL, 'date', 'Active To', NULL, NULL, 0, 0, NULL, 0, NULL),
(106, 4, 'custom_layout_update', NULL, 'catalog/attribute_backend_customlayoutupdate', 'text', NULL, NULL, 'textarea', 'Custom Layout Update', NULL, NULL, 0, 0, NULL, 0, NULL),
(107, 4, 'page_layout', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Page Layout', NULL, 'catalog/product_attribute_source_layout', 0, 0, NULL, 0, NULL),
(108, 4, 'category_ids', NULL, NULL, 'static', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(109, 4, 'options_container', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Display Product Options In', NULL, 'catalog/entity_product_attribute_design_options_container', 0, 0, 'container2', 0, NULL),
(110, 4, 'required_options', NULL, NULL, 'static', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(111, 4, 'has_options', NULL, NULL, 'static', NULL, NULL, 'text', NULL, NULL, NULL, 0, 0, NULL, 0, NULL),
(112, 4, 'image_label', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Image Label', NULL, NULL, 0, 0, NULL, 0, NULL),
(113, 4, 'small_image_label', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Small Image Label', NULL, NULL, 0, 0, NULL, 0, NULL),
(114, 4, 'thumbnail_label', NULL, NULL, 'varchar', NULL, NULL, 'text', 'Thumbnail Label', NULL, NULL, 0, 0, NULL, 0, NULL),
(115, 4, 'created_at', NULL, 'eav/entity_attribute_backend_time_created', 'static', NULL, NULL, 'text', NULL, NULL, NULL, 1, 0, NULL, 0, NULL),
(116, 4, 'updated_at', NULL, 'eav/entity_attribute_backend_time_updated', 'static', NULL, NULL, 'text', NULL, NULL, NULL, 1, 0, NULL, 0, NULL),
(117, 4, 'country_of_manufacture', NULL, NULL, 'varchar', NULL, NULL, 'select', 'Country of Manufacture', NULL, 'catalog/product_attribute_source_countryofmanufacture', 0, 0, NULL, 0, NULL),
(118, 4, 'msrp_enabled', NULL, 'catalog/product_attribute_backend_msrp', 'varchar', NULL, NULL, 'select', 'Apply MAP', NULL, 'catalog/product_attribute_source_msrp_type_enabled', 0, 0, '2', 0, NULL),
(119, 4, 'msrp_display_actual_price_type', NULL, 'catalog/product_attribute_backend_boolean', 'varchar', NULL, NULL, 'select', 'Display Actual Price', NULL, 'catalog/product_attribute_source_msrp_type_price', 0, 0, '4', 0, NULL),
(120, 4, 'msrp', NULL, 'catalog/product_attribute_backend_price', 'decimal', NULL, NULL, 'price', 'Manufacturer''s Suggested Retail Price', NULL, NULL, 0, 0, NULL, 0, NULL),
(121, 4, 'enable_googlecheckout', NULL, NULL, 'int', NULL, NULL, 'select', 'Is Product Available for Purchase with Google Checkout', NULL, 'eav/entity_attribute_source_boolean', 0, 0, '1', 0, NULL),
(122, 4, 'tax_class_id', NULL, NULL, 'int', NULL, NULL, 'select', 'Tax Class', NULL, 'tax/class_source_product', 1, 0, NULL, 0, NULL),
(123, 4, 'gift_message_available', NULL, 'catalog/product_attribute_backend_boolean', 'varchar', NULL, NULL, 'select', 'Allow Gift Message', NULL, 'eav/entity_attribute_source_boolean', 0, 0, NULL, 0, NULL),
(124, 4, 'price_type', NULL, NULL, 'int', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, 0, NULL),
(125, 4, 'sku_type', NULL, NULL, 'int', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, 0, NULL),
(126, 4, 'weight_type', NULL, NULL, 'int', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, 0, NULL),
(127, 4, 'price_view', NULL, NULL, 'int', NULL, NULL, 'select', 'Price View', NULL, 'bundle/product_attribute_source_price_view', 1, 0, NULL, 0, NULL),
(128, 4, 'shipment_type', NULL, NULL, 'int', NULL, NULL, NULL, 'Shipment', NULL, NULL, 1, 0, NULL, 0, NULL),
(129, 4, 'links_purchased_separately', NULL, NULL, 'int', NULL, NULL, NULL, 'Links can be purchased separately', NULL, NULL, 1, 0, NULL, 0, NULL),
(130, 4, 'samples_title', NULL, NULL, 'varchar', NULL, NULL, NULL, 'Samples title', NULL, NULL, 1, 0, NULL, 0, NULL),
(131, 4, 'links_title', NULL, NULL, 'varchar', NULL, NULL, NULL, 'Links title', NULL, NULL, 1, 0, NULL, 0, NULL),
(132, 4, 'links_exist', NULL, NULL, 'int', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, '0', 0, NULL),
(133, 3, 'thumbnail', NULL, 'catalog/category_attribute_backend_image', 'varchar', NULL, NULL, 'image', 'Thumbnail Image', NULL, NULL, 0, 0, NULL, 0, NULL),
(134, 1, 'balance', NULL, NULL, 'decimal', NULL, NULL, 'price', 'Some textual description', NULL, NULL, 0, 0, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `eav_attribute_group`
--

CREATE TABLE IF NOT EXISTS `eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `IDX_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group' AUTO_INCREMENT=18 ;

--
-- Dumping data for table `eav_attribute_group`
--

INSERT INTO `eav_attribute_group` (`attribute_group_id`, `attribute_set_id`, `attribute_group_name`, `sort_order`, `default_id`) VALUES
(1, 1, 'General', 1, 1),
(2, 2, 'General', 1, 1),
(3, 3, 'General', 10, 1),
(4, 3, 'General Information', 2, 0),
(5, 3, 'Display Settings', 20, 0),
(6, 3, 'Custom Design', 30, 0),
(7, 4, 'General', 1, 1),
(8, 4, 'Prices', 2, 0),
(9, 4, 'Meta Information', 3, 0),
(10, 4, 'Images', 4, 0),
(11, 4, 'Recurring Profile', 5, 0),
(12, 4, 'Design', 6, 0),
(13, 5, 'General', 1, 1),
(14, 6, 'General', 1, 1),
(15, 7, 'General', 1, 1),
(16, 8, 'General', 1, 1),
(17, 4, 'Gift Options', 7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `eav_attribute_label`
--

CREATE TABLE IF NOT EXISTS `eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_attribute_option`
--

CREATE TABLE IF NOT EXISTS `eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `eav_attribute_option`
--

INSERT INTO `eav_attribute_option` (`option_id`, `attribute_id`, `sort_order`) VALUES
(1, 18, 0),
(2, 18, 1);

-- --------------------------------------------------------

--
-- Table structure for table `eav_attribute_option_value`
--

CREATE TABLE IF NOT EXISTS `eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `eav_attribute_option_value`
--

INSERT INTO `eav_attribute_option_value` (`value_id`, `option_id`, `store_id`, `value`) VALUES
(1, 1, 0, 'Male'),
(2, 2, 0, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `eav_attribute_set`
--

CREATE TABLE IF NOT EXISTS `eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `IDX_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `eav_attribute_set`
--

INSERT INTO `eav_attribute_set` (`attribute_set_id`, `entity_type_id`, `attribute_set_name`, `sort_order`) VALUES
(1, 1, 'Default', 1),
(2, 2, 'Default', 1),
(3, 3, 'Default', 1),
(4, 4, 'Default', 1),
(5, 5, 'Default', 1),
(6, 6, 'Default', 1),
(7, 7, 'Default', 1),
(8, 8, 'Default', 1);

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity`
--

CREATE TABLE IF NOT EXISTS `eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_attribute`
--

CREATE TABLE IF NOT EXISTS `eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes' AUTO_INCREMENT=133 ;

--
-- Dumping data for table `eav_entity_attribute`
--

INSERT INTO `eav_entity_attribute` (`entity_attribute_id`, `entity_type_id`, `attribute_set_id`, `attribute_group_id`, `attribute_id`, `sort_order`) VALUES
(1, 1, 1, 1, 1, 10),
(2, 1, 1, 1, 2, 0),
(3, 1, 1, 1, 3, 20),
(4, 1, 1, 1, 4, 30),
(5, 1, 1, 1, 5, 40),
(6, 1, 1, 1, 6, 50),
(7, 1, 1, 1, 7, 60),
(8, 1, 1, 1, 8, 70),
(9, 1, 1, 1, 9, 80),
(10, 1, 1, 1, 10, 25),
(11, 1, 1, 1, 11, 90),
(12, 1, 1, 1, 12, 0),
(13, 1, 1, 1, 13, 0),
(14, 1, 1, 1, 14, 0),
(15, 1, 1, 1, 15, 100),
(16, 1, 1, 1, 16, 0),
(17, 1, 1, 1, 17, 86),
(18, 1, 1, 1, 18, 110),
(19, 2, 2, 2, 19, 10),
(20, 2, 2, 2, 20, 20),
(21, 2, 2, 2, 21, 30),
(22, 2, 2, 2, 22, 40),
(23, 2, 2, 2, 23, 50),
(24, 2, 2, 2, 24, 60),
(25, 2, 2, 2, 25, 70),
(26, 2, 2, 2, 26, 80),
(27, 2, 2, 2, 27, 90),
(28, 2, 2, 2, 28, 100),
(29, 2, 2, 2, 29, 100),
(30, 2, 2, 2, 30, 110),
(31, 2, 2, 2, 31, 120),
(32, 2, 2, 2, 32, 130),
(33, 1, 1, 1, 33, 111),
(34, 1, 1, 1, 34, 112),
(35, 1, 1, 1, 35, 28),
(36, 2, 2, 2, 36, 140),
(37, 2, 2, 2, 37, 132),
(38, 2, 2, 2, 38, 133),
(39, 2, 2, 2, 39, 134),
(40, 2, 2, 2, 40, 135),
(41, 3, 3, 4, 41, 1),
(42, 3, 3, 4, 42, 2),
(43, 3, 3, 4, 43, 3),
(44, 3, 3, 4, 44, 4),
(45, 3, 3, 4, 45, 5),
(46, 3, 3, 4, 46, 6),
(47, 3, 3, 4, 47, 7),
(48, 3, 3, 4, 48, 8),
(49, 3, 3, 5, 49, 10),
(50, 3, 3, 5, 50, 20),
(51, 3, 3, 5, 51, 30),
(52, 3, 3, 4, 52, 12),
(53, 3, 3, 4, 53, 13),
(54, 3, 3, 4, 54, 14),
(55, 3, 3, 4, 55, 15),
(56, 3, 3, 4, 56, 16),
(57, 3, 3, 4, 57, 17),
(58, 3, 3, 6, 58, 10),
(59, 3, 3, 6, 59, 30),
(60, 3, 3, 6, 60, 40),
(61, 3, 3, 6, 61, 50),
(62, 3, 3, 6, 62, 60),
(63, 3, 3, 4, 63, 24),
(64, 3, 3, 4, 64, 25),
(65, 3, 3, 5, 65, 40),
(66, 3, 3, 5, 66, 50),
(67, 3, 3, 4, 67, 10),
(68, 3, 3, 6, 68, 5),
(69, 3, 3, 6, 69, 6),
(70, 3, 3, 5, 70, 51),
(71, 4, 4, 7, 71, 1),
(72, 4, 4, 7, 72, 2),
(73, 4, 4, 7, 73, 3),
(74, 4, 4, 7, 74, 4),
(75, 4, 4, 8, 75, 1),
(76, 4, 4, 8, 76, 3),
(77, 4, 4, 8, 77, 4),
(78, 4, 4, 8, 78, 5),
(79, 4, 4, 8, 79, 6),
(80, 4, 4, 7, 80, 5),
(81, 4, 4, 9, 82, 1),
(82, 4, 4, 9, 83, 2),
(83, 4, 4, 9, 84, 3),
(84, 4, 4, 10, 85, 1),
(85, 4, 4, 10, 86, 2),
(86, 4, 4, 10, 87, 3),
(87, 4, 4, 10, 88, 4),
(88, 4, 4, 7, 89, 6),
(89, 4, 4, 8, 90, 2),
(90, 4, 4, 8, 91, 7),
(91, 4, 4, 7, 93, 7),
(92, 4, 4, 7, 94, 8),
(93, 4, 4, 10, 95, 5),
(94, 4, 4, 7, 96, 9),
(95, 4, 4, 7, 97, 10),
(96, 4, 4, 7, 98, 11),
(97, 4, 4, 8, 99, 8),
(98, 4, 4, 11, 100, 1),
(99, 4, 4, 11, 101, 2),
(100, 4, 4, 7, 102, 12),
(101, 4, 4, 12, 103, 1),
(102, 4, 4, 12, 104, 2),
(103, 4, 4, 12, 105, 3),
(104, 4, 4, 12, 106, 4),
(105, 4, 4, 12, 107, 5),
(106, 4, 4, 7, 108, 13),
(107, 4, 4, 12, 109, 6),
(108, 4, 4, 7, 110, 14),
(109, 4, 4, 7, 111, 15),
(110, 4, 4, 7, 112, 16),
(111, 4, 4, 7, 113, 17),
(112, 4, 4, 7, 114, 18),
(113, 4, 4, 7, 115, 19),
(114, 4, 4, 7, 116, 20),
(115, 4, 4, 7, 117, 21),
(116, 4, 4, 8, 118, 9),
(117, 4, 4, 8, 119, 10),
(118, 4, 4, 8, 120, 11),
(119, 4, 4, 8, 121, 12),
(120, 4, 4, 8, 122, 13),
(121, 4, 4, 17, 123, 1),
(122, 4, 4, 7, 124, 22),
(123, 4, 4, 7, 125, 23),
(124, 4, 4, 7, 126, 24),
(125, 4, 4, 8, 127, 14),
(126, 4, 4, 7, 128, 25),
(127, 4, 4, 7, 129, 26),
(128, 4, 4, 7, 130, 27),
(129, 4, 4, 7, 131, 28),
(130, 4, 4, 7, 132, 29),
(131, 3, 3, 4, 133, 4),
(132, 1, 1, 1, 134, 0);

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_datetime`
--

CREATE TABLE IF NOT EXISTS `eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_decimal`
--

CREATE TABLE IF NOT EXISTS `eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_int`
--

CREATE TABLE IF NOT EXISTS `eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_store`
--

CREATE TABLE IF NOT EXISTS `eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `IDX_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_text`
--

CREATE TABLE IF NOT EXISTS `eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_type`
--

CREATE TABLE IF NOT EXISTS `eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT '' COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT '' COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `eav_entity_type`
--

INSERT INTO `eav_entity_type` (`entity_type_id`, `entity_type_code`, `entity_model`, `attribute_model`, `entity_table`, `value_table_prefix`, `entity_id_field`, `is_data_sharing`, `data_sharing_key`, `default_attribute_set_id`, `increment_model`, `increment_per_store`, `increment_pad_length`, `increment_pad_char`, `additional_attribute_table`, `entity_attribute_collection`) VALUES
(1, 'customer', 'customer/customer', 'customer/attribute', 'customer/entity', NULL, NULL, 1, 'default', 1, 'eav/entity_increment_numeric', 0, 8, '0', 'customer/eav_attribute', 'customer/attribute_collection'),
(2, 'customer_address', 'customer/address', 'customer/attribute', 'customer/address_entity', NULL, NULL, 1, 'default', 2, NULL, 0, 8, '0', 'customer/eav_attribute', 'customer/address_attribute_collection'),
(3, 'catalog_category', 'catalog/category', 'catalog/resource_eav_attribute', 'catalog/category', NULL, NULL, 1, 'default', 3, NULL, 0, 8, '0', 'catalog/eav_attribute', 'catalog/category_attribute_collection'),
(4, 'catalog_product', 'catalog/product', 'catalog/resource_eav_attribute', 'catalog/product', NULL, NULL, 1, 'default', 4, NULL, 0, 8, '0', 'catalog/eav_attribute', 'catalog/product_attribute_collection'),
(5, 'order', 'sales/order', NULL, 'sales/order', NULL, NULL, 1, 'default', 0, 'eav/entity_increment_numeric', 1, 8, '0', NULL, NULL),
(6, 'invoice', 'sales/order_invoice', NULL, 'sales/invoice', NULL, NULL, 1, 'default', 0, 'eav/entity_increment_numeric', 1, 8, '0', NULL, NULL),
(7, 'creditmemo', 'sales/order_creditmemo', NULL, 'sales/creditmemo', NULL, NULL, 1, 'default', 0, 'eav/entity_increment_numeric', 1, 8, '0', NULL, NULL),
(8, 'shipment', 'sales/order_shipment', NULL, 'sales/shipment', NULL, NULL, 1, 'default', 0, 'eav/entity_increment_numeric', 1, 8, '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `eav_entity_varchar`
--

CREATE TABLE IF NOT EXISTS `eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eav_form_element`
--

CREATE TABLE IF NOT EXISTS `eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `UNQ_EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `IDX_EAV_FORM_ELEMENT_TYPE_ID` (`type_id`),
  KEY `IDX_EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Form Element' AUTO_INCREMENT=53 ;

--
-- Dumping data for table `eav_form_element`
--

INSERT INTO `eav_form_element` (`element_id`, `type_id`, `fieldset_id`, `attribute_id`, `sort_order`) VALUES
(1, 1, NULL, 20, 0),
(2, 1, NULL, 22, 1),
(3, 1, NULL, 24, 2),
(4, 1, NULL, 9, 3),
(5, 1, NULL, 25, 4),
(6, 1, NULL, 26, 5),
(7, 1, NULL, 28, 6),
(8, 1, NULL, 30, 7),
(9, 1, NULL, 27, 8),
(10, 1, NULL, 31, 9),
(11, 1, NULL, 32, 10),
(12, 2, NULL, 20, 0),
(13, 2, NULL, 22, 1),
(14, 2, NULL, 24, 2),
(15, 2, NULL, 9, 3),
(16, 2, NULL, 25, 4),
(17, 2, NULL, 26, 5),
(18, 2, NULL, 28, 6),
(19, 2, NULL, 30, 7),
(20, 2, NULL, 27, 8),
(21, 2, NULL, 31, 9),
(22, 2, NULL, 32, 10),
(23, 3, NULL, 20, 0),
(24, 3, NULL, 22, 1),
(25, 3, NULL, 24, 2),
(26, 3, NULL, 25, 3),
(27, 3, NULL, 26, 4),
(28, 3, NULL, 28, 5),
(29, 3, NULL, 30, 6),
(30, 3, NULL, 27, 7),
(31, 3, NULL, 31, 8),
(32, 3, NULL, 32, 9),
(33, 4, NULL, 20, 0),
(34, 4, NULL, 22, 1),
(35, 4, NULL, 24, 2),
(36, 4, NULL, 25, 3),
(37, 4, NULL, 26, 4),
(38, 4, NULL, 28, 5),
(39, 4, NULL, 30, 6),
(40, 4, NULL, 27, 7),
(41, 4, NULL, 31, 8),
(42, 4, NULL, 32, 9),
(43, 5, 1, 5, 0),
(44, 5, 1, 7, 1),
(45, 5, 1, 9, 2),
(46, 5, 2, 24, 0),
(47, 5, 2, 31, 1),
(48, 5, 2, 25, 2),
(49, 5, 2, 26, 3),
(50, 5, 2, 28, 4),
(51, 5, 2, 30, 5),
(52, 5, 2, 27, 6);

-- --------------------------------------------------------

--
-- Table structure for table `eav_form_fieldset`
--

CREATE TABLE IF NOT EXISTS `eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `UNQ_EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  KEY `IDX_EAV_FORM_FIELDSET_TYPE_ID` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `eav_form_fieldset`
--

INSERT INTO `eav_form_fieldset` (`fieldset_id`, `type_id`, `code`, `sort_order`) VALUES
(1, 5, 'general', 1),
(2, 5, 'address', 2);

-- --------------------------------------------------------

--
-- Table structure for table `eav_form_fieldset_label`
--

CREATE TABLE IF NOT EXISTS `eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';

--
-- Dumping data for table `eav_form_fieldset_label`
--

INSERT INTO `eav_form_fieldset_label` (`fieldset_id`, `store_id`, `label`) VALUES
(1, 0, 'Personal Information'),
(2, 0, 'Address Information');

-- --------------------------------------------------------

--
-- Table structure for table `eav_form_type`
--

CREATE TABLE IF NOT EXISTS `eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `UNQ_EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `IDX_EAV_FORM_TYPE_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Eav Form Type' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `eav_form_type`
--

INSERT INTO `eav_form_type` (`type_id`, `code`, `label`, `is_system`, `theme`, `store_id`) VALUES
(1, 'checkout_onepage_register', 'checkout_onepage_register', 1, '', 0),
(2, 'checkout_onepage_register_guest', 'checkout_onepage_register_guest', 1, '', 0),
(3, 'checkout_onepage_billing_address', 'checkout_onepage_billing_address', 1, '', 0),
(4, 'checkout_onepage_shipping_address', 'checkout_onepage_shipping_address', 1, '', 0),
(5, 'checkout_multishipping_register', 'checkout_multishipping_register', 1, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `eav_form_type_entity`
--

CREATE TABLE IF NOT EXISTS `eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `IDX_EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';

--
-- Dumping data for table `eav_form_type_entity`
--

INSERT INTO `eav_form_type_entity` (`type_id`, `entity_type_id`) VALUES
(1, 1),
(2, 1),
(5, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `gift_message`
--

CREATE TABLE IF NOT EXISTS `gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Recipient',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gift Message' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `googlecheckout_notification`
--

CREATE TABLE IF NOT EXISTS `googlecheckout_notification` (
  `serial_number` varchar(64) NOT NULL COMMENT 'Serial Number',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Checkout Notification Table';

-- --------------------------------------------------------

--
-- Table structure for table `importexport_importdata`
--

CREATE TABLE IF NOT EXISTS `importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import Data Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `index_event`
--

CREATE TABLE IF NOT EXISTS `index_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `type` varchar(64) NOT NULL COMMENT 'Type',
  `entity` varchar(64) NOT NULL COMMENT 'Entity',
  `entity_pk` bigint(20) DEFAULT NULL COMMENT 'Entity Primary Key',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `old_data` mediumtext COMMENT 'Old Data',
  `new_data` mediumtext COMMENT 'New Data',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `UNQ_INDEX_EVENT_TYPE_ENTITY_ENTITY_PK` (`type`,`entity`,`entity_pk`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Index Event' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `index_event`
--

INSERT INTO `index_event` (`event_id`, `type`, `entity`, `entity_pk`, `created_at`, `old_data`, `new_data`) VALUES
(1, 'save', 'catalog_category', 1, '2013-04-10 00:26:09', NULL, 'a:5:{s:35:"cataloginventory_stock_match_result";b:0;s:34:"catalog_product_price_match_result";b:0;s:24:"catalog_url_match_result";b:1;s:37:"catalog_category_product_match_result";b:1;s:35:"catalogsearch_fulltext_match_result";b:1;}'),
(2, 'save', 'catalog_category', 2, '2013-04-10 00:26:10', NULL, 'a:5:{s:35:"cataloginventory_stock_match_result";b:0;s:34:"catalog_product_price_match_result";b:0;s:24:"catalog_url_match_result";b:1;s:37:"catalog_category_product_match_result";b:1;s:35:"catalogsearch_fulltext_match_result";b:1;}');

-- --------------------------------------------------------

--
-- Table structure for table `index_process`
--

CREATE TABLE IF NOT EXISTS `index_process` (
  `process_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Process Id',
  `indexer_code` varchar(32) NOT NULL COMMENT 'Indexer Code',
  `status` varchar(15) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `ended_at` timestamp NULL DEFAULT NULL COMMENT 'Ended At',
  `mode` varchar(9) NOT NULL DEFAULT 'real_time' COMMENT 'Mode',
  PRIMARY KEY (`process_id`),
  UNIQUE KEY `UNQ_INDEX_PROCESS_INDEXER_CODE` (`indexer_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Index Process' AUTO_INCREMENT=10 ;

--
-- Dumping data for table `index_process`
--

INSERT INTO `index_process` (`process_id`, `indexer_code`, `status`, `started_at`, `ended_at`, `mode`) VALUES
(1, 'catalog_product_attribute', 'require_reindex', NULL, NULL, 'real_time'),
(2, 'catalog_product_price', 'require_reindex', NULL, NULL, 'real_time'),
(3, 'catalog_url', 'require_reindex', '2013-04-10 00:26:10', '2013-04-10 00:26:10', 'real_time'),
(4, 'catalog_product_flat', 'require_reindex', NULL, NULL, 'real_time'),
(5, 'catalog_category_flat', 'require_reindex', NULL, NULL, 'real_time'),
(6, 'catalog_category_product', 'require_reindex', '2013-04-10 00:26:10', '2013-04-10 00:26:10', 'real_time'),
(7, 'catalogsearch_fulltext', 'require_reindex', '2013-04-10 00:26:10', '2013-04-10 00:26:10', 'real_time'),
(8, 'cataloginventory_stock', 'require_reindex', NULL, NULL, 'real_time'),
(9, 'tag_summary', 'require_reindex', NULL, NULL, 'real_time');

-- --------------------------------------------------------

--
-- Table structure for table `index_process_event`
--

CREATE TABLE IF NOT EXISTS `index_process_event` (
  `process_id` int(10) unsigned NOT NULL COMMENT 'Process Id',
  `event_id` bigint(20) unsigned NOT NULL COMMENT 'Event Id',
  `status` varchar(7) NOT NULL DEFAULT 'new' COMMENT 'Status',
  PRIMARY KEY (`process_id`,`event_id`),
  KEY `IDX_INDEX_PROCESS_EVENT_EVENT_ID` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process Event';

-- --------------------------------------------------------

--
-- Table structure for table `log_customer`
--

CREATE TABLE IF NOT EXISTS `log_customer` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `login_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Login Time',
  `logout_at` timestamp NULL DEFAULT NULL COMMENT 'Logout Time',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_LOG_CUSTOMER_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Log Customers Table' AUTO_INCREMENT=22 ;

--
-- Dumping data for table `log_customer`
--

INSERT INTO `log_customer` (`log_id`, `visitor_id`, `customer_id`, `login_at`, `logout_at`, `store_id`) VALUES
(1, 6, 1, '2013-04-12 04:54:03', '2013-04-11 21:54:03', 1),
(2, 7, 1, '2013-04-12 04:56:27', '2013-04-11 21:56:27', 1),
(3, 8, 1, '2013-04-12 05:02:55', '2013-04-11 22:02:55', 1),
(4, 9, 1, '2013-04-12 03:19:25', NULL, 1),
(5, 13, 1, '2013-04-12 03:48:57', NULL, 1),
(6, 14, 1, '2013-04-14 19:33:11', NULL, 1),
(7, 15, 1, '2013-04-15 21:29:51', NULL, 1),
(8, 16, 1, '2013-04-15 21:53:55', NULL, 1),
(9, 22, 1, '2013-04-16 00:13:08', NULL, 1),
(10, 23, 1, '2013-04-16 19:21:14', NULL, 1),
(11, 25, 1, '2013-04-17 02:34:16', NULL, 1),
(12, 28, 1, '2013-04-18 09:39:33', '2013-04-18 02:39:33', 1),
(13, 29, 1, '2013-04-18 09:47:32', '2013-04-18 02:47:32', 1),
(14, 30, 1, '2013-04-18 02:48:12', NULL, 1),
(15, 31, 1, '2013-04-19 07:34:02', '2013-04-19 00:34:01', 1),
(16, 32, 2, '2013-04-19 08:10:33', '2013-04-19 01:10:33', 1),
(17, 33, 1, '2013-04-19 01:11:32', NULL, 1),
(18, 34, 1, '2013-04-21 19:25:38', NULL, 1),
(19, 36, 1, '2013-04-22 07:11:03', '2013-04-22 00:11:03', 1),
(20, 37, 1, '2013-04-22 07:27:54', '2013-04-22 00:27:54', 1),
(21, 38, 1, '2013-04-22 00:28:10', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `log_quote`
--

CREATE TABLE IF NOT EXISTS `log_quote` (
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Deletion Time',
  PRIMARY KEY (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Quotes Table';

--
-- Dumping data for table `log_quote`
--

INSERT INTO `log_quote` (`quote_id`, `visitor_id`, `created_at`, `deleted_at`) VALUES
(1, 6, '2013-04-11 21:53:46', NULL),
(2, 32, '2013-04-19 00:42:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `log_summary`
--

CREATE TABLE IF NOT EXISTS `log_summary` (
  `summary_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Summary ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Type ID',
  `visitor_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Visitor Count',
  `customer_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Count',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date',
  PRIMARY KEY (`summary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `log_summary_type`
--

CREATE TABLE IF NOT EXISTS `log_summary_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type ID',
  `type_code` varchar(64) DEFAULT NULL COMMENT 'Type Code',
  `period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Period',
  `period_type` varchar(6) NOT NULL DEFAULT 'MINUTE' COMMENT 'Period Type',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Log Summary Types Table' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `log_summary_type`
--

INSERT INTO `log_summary_type` (`type_id`, `type_code`, `period`, `period_type`) VALUES
(1, 'hour', 1, 'HOUR'),
(2, 'day', 1, 'DAY');

-- --------------------------------------------------------

--
-- Table structure for table `log_url`
--

CREATE TABLE IF NOT EXISTS `log_url` (
  `url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'URL ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `visit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Visit Time',
  PRIMARY KEY (`url_id`),
  KEY `IDX_LOG_URL_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Table';

--
-- Dumping data for table `log_url`
--

INSERT INTO `log_url` (`url_id`, `visitor_id`, `visit_time`) VALUES
(1, 1, '2013-04-10 00:34:40'),
(2, 2, '2013-04-10 19:13:02'),
(3, 2, '2013-04-10 19:52:33'),
(4, 2, '2013-04-10 19:52:47'),
(5, 2, '2013-04-10 19:55:07'),
(6, 2, '2013-04-10 19:58:01'),
(7, 2, '2013-04-10 19:58:08'),
(8, 2, '2013-04-10 19:58:13'),
(9, 2, '2013-04-10 19:58:19'),
(10, 2, '2013-04-10 19:58:23'),
(11, 2, '2013-04-10 20:14:54'),
(12, 3, '2013-04-11 01:41:58'),
(13, 3, '2013-04-11 01:43:51'),
(14, 3, '2013-04-11 01:44:01'),
(15, 3, '2013-04-11 02:13:55'),
(16, 3, '2013-04-11 02:20:26'),
(17, 3, '2013-04-11 03:13:51'),
(18, 3, '2013-04-11 03:21:54'),
(19, 4, '2013-04-11 19:17:41'),
(20, 4, '2013-04-11 19:40:46'),
(21, 4, '2013-04-11 19:41:46'),
(22, 4, '2013-04-11 19:41:54'),
(23, 4, '2013-04-11 19:44:45'),
(24, 4, '2013-04-11 19:55:20'),
(25, 4, '2013-04-11 19:55:24'),
(26, 4, '2013-04-11 19:55:25'),
(27, 4, '2013-04-11 20:03:47'),
(28, 4, '2013-04-11 20:03:52'),
(29, 4, '2013-04-11 20:03:55'),
(30, 4, '2013-04-11 20:06:56'),
(31, 4, '2013-04-11 20:07:03'),
(32, 4, '2013-04-11 20:07:04'),
(33, 4, '2013-04-11 20:07:06'),
(34, 4, '2013-04-11 20:07:07'),
(35, 4, '2013-04-11 20:07:09'),
(36, 4, '2013-04-11 20:07:10'),
(37, 4, '2013-04-11 20:08:45'),
(38, 4, '2013-04-11 20:08:52'),
(39, 4, '2013-04-11 20:08:54'),
(40, 4, '2013-04-11 20:08:55'),
(41, 4, '2013-04-11 20:08:57'),
(42, 4, '2013-04-11 20:08:58'),
(43, 4, '2013-04-11 20:15:14'),
(44, 4, '2013-04-11 20:15:18'),
(45, 4, '2013-04-11 20:15:24'),
(46, 4, '2013-04-11 20:15:26'),
(47, 4, '2013-04-11 20:15:27'),
(48, 4, '2013-04-11 20:15:29'),
(49, 4, '2013-04-11 20:15:31'),
(50, 4, '2013-04-11 20:15:32'),
(51, 4, '2013-04-11 20:15:37'),
(52, 4, '2013-04-11 20:15:42'),
(53, 4, '2013-04-11 20:15:44'),
(54, 4, '2013-04-11 20:15:45'),
(55, 4, '2013-04-11 20:15:47'),
(56, 4, '2013-04-11 20:15:49'),
(57, 4, '2013-04-11 20:16:29'),
(58, 4, '2013-04-11 20:16:35'),
(59, 4, '2013-04-11 20:16:37'),
(60, 4, '2013-04-11 20:16:38'),
(61, 4, '2013-04-11 20:16:40'),
(62, 4, '2013-04-11 20:16:41'),
(63, 4, '2013-04-11 20:18:06'),
(64, 4, '2013-04-11 20:18:12'),
(65, 4, '2013-04-11 20:18:14'),
(66, 4, '2013-04-11 20:18:15'),
(67, 4, '2013-04-11 20:18:17'),
(68, 4, '2013-04-11 20:18:19'),
(69, 4, '2013-04-11 20:19:23'),
(70, 4, '2013-04-11 20:19:29'),
(71, 4, '2013-04-11 20:19:30'),
(72, 4, '2013-04-11 20:19:32'),
(73, 4, '2013-04-11 20:19:33'),
(74, 4, '2013-04-11 20:19:34'),
(75, 4, '2013-04-11 20:20:43'),
(76, 4, '2013-04-11 20:20:49'),
(77, 4, '2013-04-11 20:20:50'),
(78, 4, '2013-04-11 20:20:51'),
(79, 4, '2013-04-11 20:20:53'),
(80, 4, '2013-04-11 20:20:54'),
(81, 4, '2013-04-11 20:21:26'),
(82, 4, '2013-04-11 20:21:32'),
(83, 4, '2013-04-11 20:21:34'),
(84, 4, '2013-04-11 20:21:35'),
(85, 4, '2013-04-11 20:21:36'),
(86, 4, '2013-04-11 20:21:38'),
(87, 4, '2013-04-11 20:23:41'),
(88, 4, '2013-04-11 20:23:47'),
(89, 4, '2013-04-11 20:23:48'),
(90, 4, '2013-04-11 20:23:50'),
(91, 4, '2013-04-11 20:23:51'),
(92, 4, '2013-04-11 20:23:52'),
(93, 4, '2013-04-11 20:24:21'),
(94, 4, '2013-04-11 20:24:24'),
(95, 4, '2013-04-11 20:24:26'),
(96, 4, '2013-04-11 20:25:27'),
(97, 4, '2013-04-11 20:25:33'),
(98, 4, '2013-04-11 20:25:34'),
(99, 4, '2013-04-11 20:25:36'),
(100, 4, '2013-04-11 20:25:37'),
(101, 4, '2013-04-11 20:25:39'),
(102, 4, '2013-04-11 20:29:41'),
(103, 4, '2013-04-11 20:33:24'),
(104, 4, '2013-04-11 20:33:30'),
(105, 4, '2013-04-11 20:33:31'),
(106, 4, '2013-04-11 20:33:33'),
(107, 4, '2013-04-11 20:33:34'),
(108, 4, '2013-04-11 20:33:36'),
(109, 4, '2013-04-11 20:33:37'),
(110, 4, '2013-04-11 20:34:57'),
(111, 4, '2013-04-11 20:35:46'),
(112, 4, '2013-04-11 20:35:53'),
(113, 4, '2013-04-11 20:35:54'),
(114, 4, '2013-04-11 20:35:56'),
(115, 4, '2013-04-11 20:35:58'),
(116, 4, '2013-04-11 20:35:59'),
(117, 4, '2013-04-11 20:36:17'),
(118, 4, '2013-04-11 20:36:24'),
(119, 4, '2013-04-11 20:36:25'),
(120, 4, '2013-04-11 20:36:28'),
(121, 4, '2013-04-11 20:36:29'),
(122, 4, '2013-04-11 20:36:31'),
(123, 4, '2013-04-11 20:37:09'),
(124, 4, '2013-04-11 20:37:16'),
(125, 4, '2013-04-11 20:37:17'),
(126, 4, '2013-04-11 20:37:19'),
(127, 4, '2013-04-11 20:37:20'),
(128, 4, '2013-04-11 20:37:22'),
(129, 4, '2013-04-11 20:40:50'),
(130, 4, '2013-04-11 20:40:56'),
(131, 4, '2013-04-11 20:40:58'),
(132, 4, '2013-04-11 20:40:59'),
(133, 4, '2013-04-11 20:41:01'),
(134, 4, '2013-04-11 20:41:03'),
(135, 4, '2013-04-11 20:42:54'),
(136, 4, '2013-04-11 20:42:59'),
(137, 4, '2013-04-11 20:43:01'),
(138, 4, '2013-04-11 20:43:02'),
(139, 4, '2013-04-11 20:43:03'),
(140, 4, '2013-04-11 20:43:04'),
(141, 4, '2013-04-11 20:45:31'),
(142, 4, '2013-04-11 20:45:37'),
(143, 4, '2013-04-11 20:45:38'),
(144, 4, '2013-04-11 20:45:39'),
(145, 4, '2013-04-11 20:45:41'),
(146, 4, '2013-04-11 20:45:42'),
(147, 4, '2013-04-11 20:45:48'),
(148, 4, '2013-04-11 20:46:05'),
(149, 4, '2013-04-11 20:57:27'),
(150, 4, '2013-04-11 20:57:33'),
(151, 4, '2013-04-11 20:57:35'),
(152, 4, '2013-04-11 20:57:36'),
(153, 4, '2013-04-11 20:57:37'),
(154, 4, '2013-04-11 20:57:38'),
(155, 4, '2013-04-11 20:59:09'),
(156, 4, '2013-04-11 20:59:16'),
(157, 4, '2013-04-11 20:59:17'),
(158, 4, '2013-04-11 20:59:18'),
(159, 4, '2013-04-11 20:59:20'),
(160, 4, '2013-04-11 20:59:22'),
(161, 4, '2013-04-11 21:03:08'),
(162, 5, '2013-04-11 21:04:58'),
(163, 4, '2013-04-11 21:05:19'),
(164, 4, '2013-04-11 21:05:50'),
(165, 4, '2013-04-11 21:09:55'),
(166, 4, '2013-04-11 21:11:17'),
(167, 4, '2013-04-11 21:11:25'),
(168, 4, '2013-04-11 21:11:44'),
(169, 4, '2013-04-11 21:11:54'),
(170, 4, '2013-04-11 21:11:58'),
(171, 4, '2013-04-11 21:12:49'),
(172, 4, '2013-04-11 21:23:48'),
(173, 4, '2013-04-11 21:25:02'),
(174, 4, '2013-04-11 21:25:47'),
(175, 4, '2013-04-11 21:25:51'),
(176, 4, '2013-04-11 21:26:28'),
(177, 4, '2013-04-11 21:28:48'),
(178, 4, '2013-04-11 21:39:26'),
(179, 4, '2013-04-11 21:39:31'),
(180, 4, '2013-04-11 21:41:12'),
(181, 4, '2013-04-11 21:42:16'),
(182, 4, '2013-04-11 21:45:49'),
(183, 6, '2013-04-11 21:46:08'),
(184, 6, '2013-04-11 21:47:35'),
(185, 6, '2013-04-11 21:47:50'),
(186, 6, '2013-04-11 21:48:03'),
(187, 6, '2013-04-11 21:49:00'),
(188, 6, '2013-04-11 21:50:13'),
(189, 6, '2013-04-11 21:50:30'),
(190, 6, '2013-04-11 21:52:07'),
(191, 6, '2013-04-11 21:53:12'),
(192, 6, '2013-04-11 21:53:46'),
(193, 6, '2013-04-11 21:53:50'),
(194, 6, '2013-04-11 21:54:03'),
(195, 7, '2013-04-11 21:54:05'),
(196, 7, '2013-04-11 21:54:11'),
(197, 7, '2013-04-11 21:54:14'),
(198, 7, '2013-04-11 21:54:23'),
(199, 7, '2013-04-11 21:55:50'),
(200, 7, '2013-04-11 21:56:01'),
(201, 7, '2013-04-11 21:56:04'),
(202, 7, '2013-04-11 21:56:18'),
(203, 7, '2013-04-11 21:56:21'),
(204, 7, '2013-04-11 21:56:27'),
(205, 8, '2013-04-11 21:56:30'),
(206, 8, '2013-04-11 21:56:38'),
(207, 8, '2013-04-11 21:59:04'),
(208, 8, '2013-04-11 21:59:08'),
(209, 8, '2013-04-11 21:59:56'),
(210, 8, '2013-04-11 22:01:02'),
(211, 8, '2013-04-11 22:02:36'),
(212, 8, '2013-04-11 22:02:47'),
(213, 8, '2013-04-11 22:02:50'),
(214, 8, '2013-04-11 22:02:55'),
(215, 9, '2013-04-11 22:02:58'),
(216, 9, '2013-04-11 22:03:04'),
(217, 9, '2013-04-11 22:04:06'),
(218, 9, '2013-04-11 22:04:11'),
(219, 9, '2013-04-11 22:05:05'),
(220, 9, '2013-04-11 22:05:39'),
(221, 9, '2013-04-11 22:07:09'),
(222, 9, '2013-04-11 22:11:15'),
(223, 9, '2013-04-11 22:12:19'),
(224, 9, '2013-04-11 22:12:26'),
(225, 9, '2013-04-11 22:13:36'),
(226, 9, '2013-04-11 22:13:44'),
(227, 9, '2013-04-11 22:14:30'),
(228, 9, '2013-04-11 22:14:41'),
(229, 9, '2013-04-11 22:14:57'),
(230, 9, '2013-04-11 22:15:19'),
(231, 9, '2013-04-11 22:15:24'),
(232, 9, '2013-04-11 22:18:26'),
(233, 9, '2013-04-11 22:18:31'),
(234, 9, '2013-04-11 22:18:36'),
(235, 9, '2013-04-11 22:23:12'),
(236, 9, '2013-04-11 22:23:20'),
(237, 10, '2013-04-11 22:28:14'),
(238, 11, '2013-04-11 22:31:49'),
(239, 12, '2013-04-11 22:32:05'),
(240, 9, '2013-04-11 22:33:24'),
(241, 9, '2013-04-11 22:33:52'),
(242, 9, '2013-04-11 22:36:01'),
(243, 9, '2013-04-11 22:36:21'),
(244, 9, '2013-04-11 22:36:26'),
(245, 9, '2013-04-11 22:39:44'),
(246, 9, '2013-04-11 22:48:58'),
(247, 9, '2013-04-11 22:50:03'),
(248, 9, '2013-04-11 22:56:38'),
(249, 9, '2013-04-11 23:02:41'),
(250, 9, '2013-04-11 23:23:27'),
(251, 9, '2013-04-11 23:23:30'),
(252, 9, '2013-04-11 23:58:52'),
(253, 9, '2013-04-12 00:10:33'),
(254, 9, '2013-04-12 00:10:41'),
(255, 9, '2013-04-12 00:13:08'),
(256, 9, '2013-04-12 00:17:29'),
(257, 9, '2013-04-12 00:17:38'),
(258, 9, '2013-04-12 00:17:57'),
(259, 9, '2013-04-12 00:18:16'),
(260, 9, '2013-04-12 00:20:15'),
(261, 9, '2013-04-12 00:20:20'),
(262, 9, '2013-04-12 00:20:25'),
(263, 9, '2013-04-12 00:20:30'),
(264, 9, '2013-04-12 00:20:33'),
(265, 9, '2013-04-12 00:20:38'),
(266, 9, '2013-04-12 01:18:23'),
(267, 9, '2013-04-12 01:20:10'),
(268, 9, '2013-04-12 01:23:47'),
(269, 9, '2013-04-12 01:27:26'),
(270, 9, '2013-04-12 01:28:33'),
(271, 9, '2013-04-12 01:28:42'),
(272, 9, '2013-04-12 01:28:43'),
(273, 9, '2013-04-12 01:28:53'),
(274, 9, '2013-04-12 01:37:04'),
(275, 9, '2013-04-12 01:37:17'),
(276, 9, '2013-04-12 01:39:00'),
(277, 9, '2013-04-12 01:39:08'),
(278, 9, '2013-04-12 02:20:04'),
(279, 9, '2013-04-12 02:20:05'),
(280, 9, '2013-04-12 02:20:50'),
(281, 9, '2013-04-12 02:21:31'),
(282, 9, '2013-04-12 02:21:32'),
(283, 9, '2013-04-12 02:22:10'),
(284, 9, '2013-04-12 02:22:33'),
(285, 9, '2013-04-12 02:23:48'),
(286, 9, '2013-04-12 02:23:51'),
(287, 9, '2013-04-12 02:26:24'),
(288, 9, '2013-04-12 02:26:58'),
(289, 9, '2013-04-12 02:27:01'),
(290, 9, '2013-04-12 02:34:30'),
(291, 9, '2013-04-12 02:34:35'),
(292, 9, '2013-04-12 02:36:48'),
(293, 9, '2013-04-12 02:37:09'),
(294, 9, '2013-04-12 02:37:11'),
(295, 9, '2013-04-12 02:41:01'),
(296, 9, '2013-04-12 02:41:07'),
(297, 9, '2013-04-12 02:41:08'),
(298, 9, '2013-04-12 02:41:12'),
(299, 9, '2013-04-12 02:41:28'),
(300, 9, '2013-04-12 02:41:31'),
(301, 9, '2013-04-12 02:42:19'),
(302, 9, '2013-04-12 02:42:34'),
(303, 9, '2013-04-12 02:42:37'),
(304, 9, '2013-04-12 02:46:21'),
(305, 9, '2013-04-12 02:46:26'),
(306, 9, '2013-04-12 02:46:29'),
(307, 9, '2013-04-12 02:55:45'),
(308, 9, '2013-04-12 02:55:55'),
(309, 9, '2013-04-12 02:59:07'),
(310, 9, '2013-04-12 02:59:09'),
(311, 9, '2013-04-12 03:00:30'),
(312, 9, '2013-04-12 03:01:59'),
(313, 9, '2013-04-12 03:02:38'),
(314, 9, '2013-04-12 03:02:39'),
(315, 9, '2013-04-12 03:02:43'),
(316, 9, '2013-04-12 03:02:44'),
(317, 9, '2013-04-12 03:02:51'),
(318, 9, '2013-04-12 03:02:52'),
(319, 9, '2013-04-12 03:03:07'),
(320, 9, '2013-04-12 03:07:21'),
(321, 9, '2013-04-12 03:07:24'),
(322, 9, '2013-04-12 03:07:28'),
(323, 9, '2013-04-12 03:09:38'),
(324, 9, '2013-04-12 03:11:27'),
(325, 9, '2013-04-12 03:11:58'),
(326, 9, '2013-04-12 03:13:02'),
(327, 9, '2013-04-12 03:13:14'),
(328, 9, '2013-04-12 03:13:38'),
(329, 9, '2013-04-12 03:13:41'),
(330, 9, '2013-04-12 03:16:54'),
(331, 9, '2013-04-12 03:16:55'),
(332, 9, '2013-04-12 03:16:57'),
(333, 9, '2013-04-12 03:16:58'),
(334, 9, '2013-04-12 03:19:13'),
(335, 9, '2013-04-12 03:19:25'),
(336, 9, '2013-04-12 03:19:30'),
(337, 9, '2013-04-12 03:25:52'),
(338, 9, '2013-04-12 03:25:58'),
(339, 9, '2013-04-12 03:26:34'),
(340, 9, '2013-04-12 03:27:10'),
(341, 9, '2013-04-12 03:27:15'),
(342, 9, '2013-04-12 03:27:21'),
(343, 9, '2013-04-12 03:27:25'),
(344, 9, '2013-04-12 03:28:09'),
(345, 9, '2013-04-12 03:29:35'),
(346, 9, '2013-04-12 03:29:38'),
(347, 9, '2013-04-12 03:29:47'),
(348, 9, '2013-04-12 03:29:53'),
(349, 9, '2013-04-12 03:34:26'),
(350, 9, '2013-04-12 03:34:34'),
(351, 9, '2013-04-12 03:34:37'),
(352, 9, '2013-04-12 03:34:40'),
(353, 9, '2013-04-12 03:34:49'),
(354, 9, '2013-04-12 03:36:50'),
(355, 9, '2013-04-12 03:36:52'),
(356, 13, '2013-04-12 03:37:21'),
(357, 13, '2013-04-12 03:39:40'),
(358, 13, '2013-04-12 03:39:43'),
(359, 13, '2013-04-12 03:40:57'),
(360, 13, '2013-04-12 03:41:03'),
(361, 13, '2013-04-12 03:48:39'),
(362, 13, '2013-04-12 03:48:43'),
(363, 13, '2013-04-12 03:48:57'),
(364, 13, '2013-04-12 03:49:00'),
(365, 13, '2013-04-12 04:01:41'),
(366, 13, '2013-04-12 04:01:47'),
(367, 13, '2013-04-12 04:01:51'),
(368, 13, '2013-04-12 04:01:56'),
(369, 13, '2013-04-12 04:01:59'),
(370, 13, '2013-04-12 04:02:02'),
(371, 13, '2013-04-12 04:02:08'),
(372, 13, '2013-04-12 04:02:23'),
(373, 14, '2013-04-14 19:08:29'),
(374, 14, '2013-04-14 19:30:53'),
(375, 14, '2013-04-14 19:32:48'),
(376, 14, '2013-04-14 19:32:54'),
(377, 14, '2013-04-14 19:33:11'),
(378, 14, '2013-04-14 19:33:16'),
(379, 14, '2013-04-14 19:33:22'),
(380, 14, '2013-04-14 19:33:23'),
(381, 14, '2013-04-14 19:34:48'),
(382, 14, '2013-04-14 19:34:53'),
(383, 14, '2013-04-14 20:03:42'),
(384, 14, '2013-04-14 20:03:45'),
(385, 14, '2013-04-14 20:08:38'),
(386, 14, '2013-04-14 20:08:41'),
(387, 14, '2013-04-14 20:30:57'),
(388, 14, '2013-04-14 20:31:02'),
(389, 14, '2013-04-14 20:34:59'),
(390, 14, '2013-04-14 20:37:40'),
(391, 14, '2013-04-14 20:37:46'),
(392, 14, '2013-04-14 20:38:33'),
(393, 14, '2013-04-14 20:39:02'),
(394, 14, '2013-04-14 20:39:16'),
(395, 14, '2013-04-14 20:39:27'),
(396, 14, '2013-04-14 20:41:58'),
(397, 14, '2013-04-14 20:42:05'),
(398, 14, '2013-04-14 20:42:12'),
(399, 14, '2013-04-14 20:42:26'),
(400, 14, '2013-04-14 20:42:31'),
(401, 14, '2013-04-14 21:03:05'),
(402, 14, '2013-04-14 21:08:57'),
(403, 14, '2013-04-14 21:09:31'),
(404, 14, '2013-04-14 21:11:45'),
(405, 14, '2013-04-14 21:12:23'),
(406, 14, '2013-04-14 21:14:24'),
(407, 14, '2013-04-14 21:16:38'),
(408, 14, '2013-04-14 21:17:00'),
(409, 14, '2013-04-14 21:20:28'),
(410, 14, '2013-04-14 21:24:29'),
(411, 14, '2013-04-14 21:25:20'),
(412, 14, '2013-04-14 21:33:19'),
(413, 14, '2013-04-14 21:44:50'),
(414, 14, '2013-04-14 21:45:52'),
(415, 14, '2013-04-14 21:46:39'),
(416, 14, '2013-04-14 21:47:08'),
(417, 14, '2013-04-14 21:50:22'),
(418, 14, '2013-04-14 21:50:42'),
(419, 14, '2013-04-14 21:58:10'),
(420, 14, '2013-04-14 21:58:59'),
(421, 14, '2013-04-14 22:04:00'),
(422, 14, '2013-04-14 22:05:48'),
(423, 14, '2013-04-14 22:11:26'),
(424, 14, '2013-04-14 22:19:30'),
(425, 14, '2013-04-14 22:20:06'),
(426, 14, '2013-04-14 22:21:04'),
(427, 14, '2013-04-14 22:26:11'),
(428, 14, '2013-04-14 22:28:49'),
(429, 14, '2013-04-14 22:28:51'),
(430, 14, '2013-04-14 22:32:42'),
(431, 14, '2013-04-14 22:36:13'),
(432, 14, '2013-04-14 22:38:12'),
(433, 14, '2013-04-14 22:38:25'),
(434, 14, '2013-04-14 22:38:43'),
(435, 14, '2013-04-14 22:42:16'),
(436, 14, '2013-04-14 22:42:23'),
(437, 14, '2013-04-14 22:44:54'),
(438, 14, '2013-04-14 22:51:58'),
(439, 14, '2013-04-14 22:52:34'),
(440, 14, '2013-04-14 22:53:05'),
(441, 14, '2013-04-14 22:53:19'),
(442, 14, '2013-04-14 22:53:24'),
(443, 14, '2013-04-14 22:53:52'),
(444, 14, '2013-04-14 22:56:00'),
(445, 14, '2013-04-14 22:56:05'),
(446, 14, '2013-04-14 22:56:10'),
(447, 14, '2013-04-14 22:56:21'),
(448, 14, '2013-04-14 23:01:02'),
(449, 14, '2013-04-14 23:01:03'),
(450, 14, '2013-04-14 23:01:08'),
(451, 14, '2013-04-14 23:01:31'),
(452, 14, '2013-04-14 23:01:42'),
(453, 14, '2013-04-14 23:01:51'),
(454, 14, '2013-04-14 23:03:51'),
(455, 14, '2013-04-14 23:03:56'),
(456, 14, '2013-04-14 23:04:24'),
(457, 14, '2013-04-14 23:56:02'),
(458, 14, '2013-04-14 23:56:21'),
(459, 14, '2013-04-14 23:56:26'),
(460, 14, '2013-04-15 00:07:48'),
(461, 14, '2013-04-15 00:08:02'),
(462, 14, '2013-04-15 00:08:15'),
(463, 14, '2013-04-15 00:10:18'),
(464, 14, '2013-04-15 00:10:24'),
(465, 14, '2013-04-15 00:11:28'),
(466, 14, '2013-04-15 00:11:36'),
(467, 14, '2013-04-15 00:12:24'),
(468, 14, '2013-04-15 00:12:29'),
(469, 14, '2013-04-15 00:12:34'),
(470, 14, '2013-04-15 00:13:22'),
(471, 14, '2013-04-15 00:13:55'),
(472, 14, '2013-04-15 00:14:04'),
(473, 14, '2013-04-15 00:15:32'),
(474, 14, '2013-04-15 00:15:53'),
(475, 14, '2013-04-15 00:16:52'),
(476, 14, '2013-04-15 00:18:32'),
(477, 14, '2013-04-15 00:21:08'),
(478, 14, '2013-04-15 00:21:12'),
(479, 14, '2013-04-15 00:22:16'),
(480, 14, '2013-04-15 00:22:43'),
(481, 14, '2013-04-15 00:27:52'),
(482, 14, '2013-04-15 00:29:03'),
(483, 14, '2013-04-15 00:34:06'),
(484, 14, '2013-04-15 00:36:51'),
(485, 14, '2013-04-15 00:43:09'),
(486, 14, '2013-04-15 00:45:56'),
(487, 14, '2013-04-15 00:46:14'),
(488, 14, '2013-04-15 00:46:55'),
(489, 14, '2013-04-15 00:58:11'),
(490, 14, '2013-04-15 01:19:21'),
(491, 14, '2013-04-15 01:19:35'),
(492, 14, '2013-04-15 01:19:48'),
(493, 14, '2013-04-15 01:20:00'),
(494, 14, '2013-04-15 01:20:40'),
(495, 14, '2013-04-15 01:21:23'),
(496, 14, '2013-04-15 01:21:34'),
(497, 14, '2013-04-15 01:21:43'),
(498, 14, '2013-04-15 01:22:09'),
(499, 14, '2013-04-15 01:22:14'),
(500, 14, '2013-04-15 01:38:40'),
(501, 14, '2013-04-15 01:47:25'),
(502, 14, '2013-04-15 01:47:30'),
(503, 14, '2013-04-15 01:47:37'),
(504, 14, '2013-04-15 01:53:30'),
(505, 14, '2013-04-15 01:53:39'),
(506, 14, '2013-04-15 01:54:05'),
(507, 14, '2013-04-15 01:54:09'),
(508, 14, '2013-04-15 01:54:15'),
(509, 14, '2013-04-15 01:54:20'),
(510, 14, '2013-04-15 01:56:32'),
(511, 14, '2013-04-15 02:14:22'),
(512, 14, '2013-04-15 02:54:09'),
(513, 14, '2013-04-15 02:55:05'),
(514, 14, '2013-04-15 02:59:39'),
(515, 14, '2013-04-15 02:59:42'),
(516, 14, '2013-04-15 03:01:54'),
(517, 14, '2013-04-15 03:03:42'),
(518, 14, '2013-04-15 03:04:25'),
(519, 14, '2013-04-15 03:10:23'),
(520, 14, '2013-04-15 03:11:09'),
(521, 14, '2013-04-15 03:35:18'),
(522, 14, '2013-04-15 03:36:41'),
(523, 14, '2013-04-15 03:38:46'),
(524, 14, '2013-04-15 03:38:52'),
(525, 14, '2013-04-15 03:42:20'),
(526, 14, '2013-04-15 03:46:43'),
(527, 14, '2013-04-15 03:47:20'),
(528, 14, '2013-04-15 03:47:50'),
(529, 14, '2013-04-15 03:50:24'),
(530, 15, '2013-04-15 19:12:51'),
(531, 15, '2013-04-15 19:13:24'),
(532, 15, '2013-04-15 19:22:18'),
(533, 15, '2013-04-15 19:22:27'),
(534, 15, '2013-04-15 19:22:35'),
(535, 15, '2013-04-15 19:22:41'),
(536, 15, '2013-04-15 19:22:42'),
(537, 15, '2013-04-15 19:56:35'),
(538, 15, '2013-04-15 19:57:21'),
(539, 15, '2013-04-15 19:58:23'),
(540, 15, '2013-04-15 20:12:59'),
(541, 15, '2013-04-15 20:13:57'),
(542, 15, '2013-04-15 20:33:09'),
(543, 15, '2013-04-15 20:36:34'),
(544, 15, '2013-04-15 21:27:38'),
(545, 15, '2013-04-15 21:27:47'),
(546, 15, '2013-04-15 21:29:37'),
(547, 15, '2013-04-15 21:29:41'),
(548, 15, '2013-04-15 21:29:51'),
(549, 15, '2013-04-15 21:29:55'),
(550, 15, '2013-04-15 21:31:15'),
(551, 15, '2013-04-15 21:31:20'),
(552, 15, '2013-04-15 21:31:24'),
(553, 15, '2013-04-15 21:34:57'),
(554, 15, '2013-04-15 21:35:25'),
(555, 15, '2013-04-15 21:36:28'),
(556, 15, '2013-04-15 21:36:54'),
(557, 15, '2013-04-15 21:36:58'),
(558, 15, '2013-04-15 21:37:01'),
(559, 15, '2013-04-15 21:40:56'),
(560, 15, '2013-04-15 21:41:14'),
(561, 15, '2013-04-15 21:42:25'),
(562, 15, '2013-04-15 21:45:52'),
(563, 15, '2013-04-15 21:45:54'),
(564, 15, '2013-04-15 21:46:17'),
(565, 15, '2013-04-15 21:47:14'),
(566, 15, '2013-04-15 21:47:31'),
(567, 15, '2013-04-15 21:47:37'),
(568, 15, '2013-04-15 21:47:53'),
(569, 15, '2013-04-15 21:48:16'),
(570, 16, '2013-04-15 21:52:58'),
(571, 16, '2013-04-15 21:53:02'),
(572, 16, '2013-04-15 21:53:10'),
(573, 16, '2013-04-15 21:53:13'),
(574, 16, '2013-04-15 21:53:55'),
(575, 16, '2013-04-15 21:53:57'),
(576, 16, '2013-04-15 21:54:02'),
(577, 16, '2013-04-15 21:54:15'),
(578, 16, '2013-04-15 21:56:07'),
(579, 16, '2013-04-15 21:58:05'),
(580, 16, '2013-04-15 21:58:18'),
(581, 16, '2013-04-15 21:58:41'),
(582, 16, '2013-04-15 22:12:48'),
(583, 16, '2013-04-15 22:13:02'),
(584, 16, '2013-04-15 22:20:10'),
(585, 16, '2013-04-15 22:20:42'),
(586, 16, '2013-04-15 22:21:31'),
(587, 16, '2013-04-15 22:22:26'),
(588, 16, '2013-04-15 22:22:28'),
(589, 16, '2013-04-15 22:22:29'),
(590, 16, '2013-04-15 22:23:48'),
(591, 16, '2013-04-15 22:24:02'),
(592, 16, '2013-04-15 22:24:04'),
(593, 16, '2013-04-15 22:24:05'),
(594, 16, '2013-04-15 22:24:24'),
(595, 16, '2013-04-15 22:27:11'),
(596, 16, '2013-04-15 22:31:37'),
(597, 16, '2013-04-15 22:40:36'),
(598, 16, '2013-04-15 22:40:41'),
(599, 16, '2013-04-15 22:40:49'),
(600, 16, '2013-04-15 22:44:41'),
(601, 16, '2013-04-15 22:44:46'),
(602, 16, '2013-04-15 22:50:36'),
(603, 16, '2013-04-15 22:50:41'),
(604, 16, '2013-04-15 22:56:19'),
(605, 16, '2013-04-15 22:58:14'),
(606, 22, '2013-04-16 00:12:51'),
(607, 22, '2013-04-16 00:12:55'),
(608, 22, '2013-04-16 00:12:59'),
(609, 22, '2013-04-16 00:13:08'),
(610, 22, '2013-04-16 00:13:11'),
(611, 22, '2013-04-16 00:13:33'),
(612, 22, '2013-04-16 00:13:36'),
(613, 22, '2013-04-16 00:13:37'),
(614, 22, '2013-04-16 00:14:47'),
(615, 22, '2013-04-16 00:14:54'),
(616, 22, '2013-04-16 00:16:40'),
(617, 22, '2013-04-16 00:16:44'),
(618, 22, '2013-04-16 00:20:54'),
(619, 22, '2013-04-16 00:29:49'),
(620, 22, '2013-04-16 00:30:18'),
(621, 22, '2013-04-16 00:30:38'),
(622, 22, '2013-04-16 00:35:31'),
(623, 22, '2013-04-16 00:36:08'),
(624, 22, '2013-04-16 00:43:50'),
(625, 22, '2013-04-16 00:44:23'),
(626, 22, '2013-04-16 00:44:41'),
(627, 22, '2013-04-16 00:46:20'),
(628, 22, '2013-04-16 00:46:26'),
(629, 22, '2013-04-16 00:46:32'),
(630, 22, '2013-04-16 00:46:36'),
(631, 22, '2013-04-16 00:52:17'),
(632, 22, '2013-04-16 00:55:12'),
(633, 22, '2013-04-16 00:55:35'),
(634, 22, '2013-04-16 00:56:18'),
(635, 22, '2013-04-16 00:56:23'),
(636, 22, '2013-04-16 01:01:02'),
(637, 22, '2013-04-16 01:01:06'),
(638, 22, '2013-04-16 01:06:49'),
(639, 22, '2013-04-16 01:08:17'),
(640, 22, '2013-04-16 01:08:46'),
(641, 22, '2013-04-16 01:08:50'),
(642, 22, '2013-04-16 01:12:35'),
(643, 22, '2013-04-16 01:15:27'),
(644, 22, '2013-04-16 01:16:18'),
(645, 22, '2013-04-16 01:16:27'),
(646, 22, '2013-04-16 01:16:32'),
(647, 22, '2013-04-16 01:16:36'),
(648, 22, '2013-04-16 01:17:25'),
(649, 22, '2013-04-16 01:17:56'),
(650, 22, '2013-04-16 01:18:24'),
(651, 22, '2013-04-16 01:18:42'),
(652, 22, '2013-04-16 01:18:51'),
(653, 22, '2013-04-16 01:20:37'),
(654, 22, '2013-04-16 01:20:42'),
(655, 22, '2013-04-16 01:20:47'),
(656, 22, '2013-04-16 01:24:14'),
(657, 22, '2013-04-16 01:24:22'),
(658, 22, '2013-04-16 01:24:27'),
(659, 22, '2013-04-16 01:24:31'),
(660, 22, '2013-04-16 01:24:36'),
(661, 22, '2013-04-16 01:24:40'),
(662, 22, '2013-04-16 01:24:45'),
(663, 22, '2013-04-16 01:24:52'),
(664, 22, '2013-04-16 01:25:28'),
(665, 22, '2013-04-16 01:25:33'),
(666, 22, '2013-04-16 01:25:36'),
(667, 22, '2013-04-16 01:25:45'),
(668, 22, '2013-04-16 01:25:49'),
(669, 22, '2013-04-16 01:27:49'),
(670, 22, '2013-04-16 01:29:14'),
(671, 22, '2013-04-16 01:29:29'),
(672, 22, '2013-04-16 01:29:30'),
(673, 22, '2013-04-16 01:29:32'),
(674, 22, '2013-04-16 01:29:36'),
(675, 22, '2013-04-16 01:30:03'),
(676, 22, '2013-04-16 01:30:08'),
(677, 22, '2013-04-16 01:32:45'),
(678, 22, '2013-04-16 01:33:46'),
(679, 22, '2013-04-16 01:33:50'),
(680, 22, '2013-04-16 01:33:56'),
(681, 22, '2013-04-16 01:35:22'),
(682, 22, '2013-04-16 01:35:31'),
(683, 22, '2013-04-16 01:35:35'),
(684, 22, '2013-04-16 01:36:16'),
(685, 22, '2013-04-16 01:36:21'),
(686, 22, '2013-04-16 01:36:31'),
(687, 22, '2013-04-16 01:36:49'),
(688, 22, '2013-04-16 01:36:56'),
(689, 22, '2013-04-16 01:37:27'),
(690, 22, '2013-04-16 01:37:32'),
(691, 22, '2013-04-16 01:40:02'),
(692, 22, '2013-04-16 01:41:36'),
(693, 22, '2013-04-16 01:41:53'),
(694, 22, '2013-04-16 01:41:57'),
(695, 22, '2013-04-16 01:42:49'),
(696, 22, '2013-04-16 01:42:54'),
(697, 22, '2013-04-16 01:42:57'),
(698, 22, '2013-04-16 01:43:02'),
(699, 22, '2013-04-16 01:43:06'),
(700, 22, '2013-04-16 01:43:10'),
(701, 22, '2013-04-16 01:43:18'),
(702, 22, '2013-04-16 01:45:47'),
(703, 22, '2013-04-16 01:45:52'),
(704, 22, '2013-04-16 01:45:55'),
(705, 22, '2013-04-16 01:45:59'),
(706, 22, '2013-04-16 01:51:26'),
(707, 22, '2013-04-16 01:51:31'),
(708, 22, '2013-04-16 01:51:35'),
(709, 22, '2013-04-16 01:51:38'),
(710, 22, '2013-04-16 01:51:44'),
(711, 22, '2013-04-16 01:53:59'),
(712, 22, '2013-04-16 01:54:33'),
(713, 22, '2013-04-16 01:54:39'),
(714, 22, '2013-04-16 01:55:01'),
(715, 22, '2013-04-16 01:59:28'),
(716, 22, '2013-04-16 01:59:41'),
(717, 22, '2013-04-16 02:00:25'),
(718, 22, '2013-04-16 02:00:37'),
(719, 22, '2013-04-16 02:04:00'),
(720, 22, '2013-04-16 02:04:08'),
(721, 22, '2013-04-16 02:04:37'),
(722, 22, '2013-04-16 02:05:23'),
(723, 22, '2013-04-16 02:05:28'),
(724, 22, '2013-04-16 02:05:32'),
(725, 22, '2013-04-16 02:05:38'),
(726, 22, '2013-04-16 02:05:49'),
(727, 22, '2013-04-16 02:06:21'),
(728, 22, '2013-04-16 02:06:27'),
(729, 22, '2013-04-16 02:06:32'),
(730, 22, '2013-04-16 02:09:09'),
(731, 22, '2013-04-16 02:09:13'),
(732, 22, '2013-04-16 02:09:17'),
(733, 22, '2013-04-16 02:10:37'),
(734, 22, '2013-04-16 02:10:39'),
(735, 22, '2013-04-16 02:11:49'),
(736, 22, '2013-04-16 02:11:52'),
(737, 22, '2013-04-16 02:12:17'),
(738, 22, '2013-04-16 02:13:34'),
(739, 22, '2013-04-16 02:13:51'),
(740, 22, '2013-04-16 02:15:02'),
(741, 22, '2013-04-16 03:09:43'),
(742, 22, '2013-04-16 03:09:48'),
(743, 22, '2013-04-16 03:09:54'),
(744, 22, '2013-04-16 03:09:58'),
(745, 22, '2013-04-16 03:10:03'),
(746, 22, '2013-04-16 03:10:08'),
(747, 22, '2013-04-16 03:26:29'),
(748, 22, '2013-04-16 03:26:30'),
(749, 22, '2013-04-16 03:27:01'),
(750, 22, '2013-04-16 03:27:08'),
(751, 22, '2013-04-16 03:27:12'),
(752, 22, '2013-04-16 03:27:16'),
(753, 22, '2013-04-16 03:27:23'),
(754, 22, '2013-04-16 03:27:34'),
(755, 22, '2013-04-16 03:39:41'),
(756, 22, '2013-04-16 03:39:45'),
(757, 22, '2013-04-16 03:39:46'),
(758, 22, '2013-04-16 03:39:53'),
(759, 22, '2013-04-16 03:39:57'),
(760, 22, '2013-04-16 03:40:02'),
(761, 22, '2013-04-16 03:40:10'),
(762, 22, '2013-04-16 03:43:36'),
(763, 22, '2013-04-16 03:43:40'),
(764, 22, '2013-04-16 03:44:19'),
(765, 22, '2013-04-16 03:44:26'),
(766, 22, '2013-04-16 03:45:49'),
(767, 22, '2013-04-16 03:45:56'),
(768, 22, '2013-04-16 03:46:14'),
(769, 22, '2013-04-16 03:46:31'),
(770, 22, '2013-04-16 03:46:39'),
(771, 22, '2013-04-16 03:47:15'),
(772, 22, '2013-04-16 03:49:27'),
(773, 22, '2013-04-16 03:49:43'),
(774, 22, '2013-04-16 03:49:48'),
(775, 22, '2013-04-16 03:49:52'),
(776, 22, '2013-04-16 03:50:45'),
(777, 22, '2013-04-16 03:50:49'),
(778, 22, '2013-04-16 03:50:54'),
(779, 22, '2013-04-16 03:52:21'),
(780, 22, '2013-04-16 03:52:26'),
(781, 22, '2013-04-16 03:52:31'),
(782, 22, '2013-04-16 03:52:33'),
(783, 23, '2013-04-16 19:14:53'),
(784, 23, '2013-04-16 19:16:35'),
(785, 23, '2013-04-16 19:17:38'),
(786, 23, '2013-04-16 19:17:49'),
(787, 23, '2013-04-16 19:18:03'),
(788, 23, '2013-04-16 19:18:08'),
(789, 23, '2013-04-16 19:18:17'),
(790, 23, '2013-04-16 19:20:58'),
(791, 23, '2013-04-16 19:20:59'),
(792, 23, '2013-04-16 19:21:14'),
(793, 23, '2013-04-16 19:21:17'),
(794, 23, '2013-04-16 19:24:28'),
(795, 23, '2013-04-16 19:25:23'),
(796, 23, '2013-04-16 19:25:26'),
(797, 23, '2013-04-16 19:27:35'),
(798, 23, '2013-04-16 19:27:51'),
(799, 23, '2013-04-16 19:29:04'),
(800, 23, '2013-04-16 19:29:24'),
(801, 23, '2013-04-16 19:35:43'),
(802, 23, '2013-04-16 19:36:28'),
(803, 23, '2013-04-16 19:44:08'),
(804, 23, '2013-04-16 19:45:08'),
(805, 23, '2013-04-16 19:45:46'),
(806, 23, '2013-04-16 19:46:09'),
(807, 23, '2013-04-16 19:46:17'),
(808, 23, '2013-04-16 19:46:25'),
(809, 23, '2013-04-16 19:46:28'),
(810, 23, '2013-04-16 19:46:45'),
(811, 23, '2013-04-16 19:46:47'),
(812, 23, '2013-04-16 19:47:44'),
(813, 23, '2013-04-16 19:49:28'),
(814, 23, '2013-04-16 19:49:58'),
(815, 23, '2013-04-16 19:50:11'),
(816, 23, '2013-04-16 19:50:14'),
(817, 23, '2013-04-16 19:50:50'),
(818, 23, '2013-04-16 19:52:06'),
(819, 23, '2013-04-16 19:52:09'),
(820, 23, '2013-04-16 19:53:43'),
(821, 23, '2013-04-16 19:53:45'),
(822, 23, '2013-04-16 19:53:52'),
(823, 23, '2013-04-16 19:56:32'),
(824, 23, '2013-04-16 19:56:35'),
(825, 23, '2013-04-16 19:56:43'),
(826, 23, '2013-04-16 20:06:27'),
(827, 23, '2013-04-16 20:06:30'),
(828, 23, '2013-04-16 20:06:39'),
(829, 23, '2013-04-16 20:16:01'),
(830, 23, '2013-04-16 20:20:53'),
(831, 23, '2013-04-16 20:21:07'),
(832, 23, '2013-04-16 20:22:27'),
(833, 23, '2013-04-16 20:23:37'),
(834, 23, '2013-04-16 20:24:04'),
(835, 23, '2013-04-16 20:24:29'),
(836, 23, '2013-04-16 20:24:31'),
(837, 23, '2013-04-16 20:24:42'),
(838, 23, '2013-04-16 20:38:48'),
(839, 23, '2013-04-16 20:39:34'),
(840, 23, '2013-04-16 20:40:53'),
(841, 23, '2013-04-16 20:40:56'),
(842, 23, '2013-04-16 20:41:27'),
(843, 23, '2013-04-16 20:41:45'),
(844, 23, '2013-04-16 20:42:11'),
(845, 23, '2013-04-16 20:42:33'),
(846, 23, '2013-04-16 20:42:36'),
(847, 23, '2013-04-16 20:47:14'),
(848, 23, '2013-04-16 20:47:30'),
(849, 23, '2013-04-16 20:47:33'),
(850, 23, '2013-04-16 20:47:51'),
(851, 23, '2013-04-16 20:49:11'),
(852, 23, '2013-04-16 20:50:58'),
(853, 23, '2013-04-16 20:55:20'),
(854, 23, '2013-04-16 20:55:30'),
(855, 23, '2013-04-16 21:01:52'),
(856, 23, '2013-04-16 21:02:10'),
(857, 23, '2013-04-16 21:02:52'),
(858, 23, '2013-04-16 21:43:47'),
(859, 23, '2013-04-16 21:48:40'),
(860, 23, '2013-04-16 21:49:53'),
(861, 23, '2013-04-16 21:49:59'),
(862, 23, '2013-04-16 21:50:05'),
(863, 23, '2013-04-16 21:50:11'),
(864, 23, '2013-04-16 21:50:36'),
(865, 23, '2013-04-16 21:51:38'),
(866, 23, '2013-04-16 21:52:17'),
(867, 23, '2013-04-16 21:55:07'),
(868, 23, '2013-04-16 21:55:23'),
(869, 23, '2013-04-16 22:04:50'),
(870, 23, '2013-04-16 22:04:57'),
(871, 23, '2013-04-16 22:05:11'),
(872, 23, '2013-04-16 22:05:17'),
(873, 23, '2013-04-16 22:10:04'),
(874, 23, '2013-04-16 22:10:59'),
(875, 23, '2013-04-16 22:13:23'),
(876, 23, '2013-04-16 22:21:47'),
(877, 23, '2013-04-16 22:29:51'),
(878, 23, '2013-04-16 22:36:16'),
(879, 23, '2013-04-16 22:36:28'),
(880, 23, '2013-04-16 22:37:49'),
(881, 23, '2013-04-16 22:39:14'),
(882, 23, '2013-04-16 22:40:40'),
(883, 23, '2013-04-16 22:40:56'),
(884, 23, '2013-04-16 22:41:43'),
(885, 23, '2013-04-16 22:41:50'),
(886, 23, '2013-04-16 22:42:01'),
(887, 23, '2013-04-16 22:42:07'),
(888, 23, '2013-04-16 22:45:18'),
(889, 23, '2013-04-16 23:00:49'),
(890, 23, '2013-04-16 23:00:54'),
(891, 23, '2013-04-16 23:49:18'),
(892, 23, '2013-04-16 23:53:01'),
(893, 23, '2013-04-16 23:56:57'),
(894, 23, '2013-04-16 23:57:27'),
(895, 23, '2013-04-16 23:59:18'),
(896, 23, '2013-04-16 23:59:25'),
(897, 23, '2013-04-17 00:02:44'),
(898, 23, '2013-04-17 00:04:06'),
(899, 23, '2013-04-17 00:04:24'),
(900, 23, '2013-04-17 00:05:17'),
(901, 23, '2013-04-17 00:06:09'),
(902, 23, '2013-04-17 00:06:25'),
(903, 23, '2013-04-17 00:09:08'),
(904, 23, '2013-04-17 00:11:47'),
(905, 24, '2013-04-17 00:12:15'),
(906, 24, '2013-04-17 00:12:17'),
(907, 24, '2013-04-17 00:12:20'),
(908, 24, '2013-04-17 00:12:22'),
(909, 24, '2013-04-17 00:12:25'),
(910, 24, '2013-04-17 00:12:27'),
(911, 24, '2013-04-17 00:12:30'),
(912, 24, '2013-04-17 00:12:32'),
(913, 24, '2013-04-17 00:12:34'),
(914, 24, '2013-04-17 00:12:37'),
(915, 24, '2013-04-17 00:12:39'),
(916, 24, '2013-04-17 00:12:42'),
(917, 24, '2013-04-17 00:12:44'),
(918, 24, '2013-04-17 00:12:47'),
(919, 24, '2013-04-17 00:12:49'),
(920, 24, '2013-04-17 00:12:52'),
(921, 24, '2013-04-17 00:12:54'),
(922, 24, '2013-04-17 00:12:57'),
(923, 24, '2013-04-17 00:12:59'),
(924, 24, '2013-04-17 00:13:02'),
(925, 24, '2013-04-17 00:13:04'),
(926, 24, '2013-04-17 00:13:09'),
(927, 24, '2013-04-17 00:13:12'),
(928, 24, '2013-04-17 00:13:14'),
(929, 24, '2013-04-17 00:13:17'),
(930, 24, '2013-04-17 00:13:19'),
(931, 24, '2013-04-17 00:13:22'),
(932, 24, '2013-04-17 00:13:24'),
(933, 24, '2013-04-17 00:13:27'),
(934, 24, '2013-04-17 00:13:29'),
(935, 24, '2013-04-17 00:13:32'),
(936, 24, '2013-04-17 00:13:34'),
(937, 24, '2013-04-17 00:13:36'),
(938, 24, '2013-04-17 00:13:39'),
(939, 24, '2013-04-17 00:13:41'),
(940, 24, '2013-04-17 00:13:44'),
(941, 24, '2013-04-17 00:13:46'),
(942, 24, '2013-04-17 00:13:48'),
(943, 24, '2013-04-17 00:13:51'),
(944, 24, '2013-04-17 00:13:53'),
(945, 24, '2013-04-17 00:13:56'),
(946, 24, '2013-04-17 00:13:58'),
(947, 24, '2013-04-17 00:14:18'),
(948, 24, '2013-04-17 00:14:19'),
(949, 24, '2013-04-17 00:14:29'),
(950, 24, '2013-04-17 00:14:32'),
(951, 24, '2013-04-17 00:14:35'),
(952, 24, '2013-04-17 00:14:39'),
(953, 24, '2013-04-17 00:14:43'),
(954, 24, '2013-04-17 00:14:46'),
(955, 24, '2013-04-17 00:14:49'),
(956, 24, '2013-04-17 00:14:51'),
(957, 24, '2013-04-17 00:14:53'),
(958, 25, '2013-04-17 00:15:38'),
(959, 25, '2013-04-17 00:16:07'),
(960, 25, '2013-04-17 00:23:15'),
(961, 25, '2013-04-17 00:25:15'),
(962, 25, '2013-04-17 00:25:27'),
(963, 25, '2013-04-17 00:26:36'),
(964, 25, '2013-04-17 00:27:19'),
(965, 25, '2013-04-17 00:27:23'),
(966, 25, '2013-04-17 00:27:58'),
(967, 25, '2013-04-17 00:28:08'),
(968, 25, '2013-04-17 00:28:33'),
(969, 25, '2013-04-17 00:29:00'),
(970, 25, '2013-04-17 00:29:09'),
(971, 25, '2013-04-17 00:29:51'),
(972, 25, '2013-04-17 00:30:33'),
(973, 25, '2013-04-17 00:31:03'),
(974, 25, '2013-04-17 00:31:43'),
(975, 25, '2013-04-17 00:31:55'),
(976, 25, '2013-04-17 00:32:12'),
(977, 25, '2013-04-17 00:32:55'),
(978, 25, '2013-04-17 00:33:26'),
(979, 25, '2013-04-17 00:34:13'),
(980, 25, '2013-04-17 00:36:28'),
(981, 25, '2013-04-17 00:40:06'),
(982, 25, '2013-04-17 00:40:10'),
(983, 25, '2013-04-17 00:42:28'),
(984, 25, '2013-04-17 00:42:32'),
(985, 25, '2013-04-17 00:43:32'),
(986, 25, '2013-04-17 00:43:36'),
(987, 25, '2013-04-17 00:43:44'),
(988, 25, '2013-04-17 00:45:29'),
(989, 25, '2013-04-17 00:45:33'),
(990, 25, '2013-04-17 00:45:40'),
(991, 25, '2013-04-17 00:46:17'),
(992, 25, '2013-04-17 00:47:53'),
(993, 25, '2013-04-17 00:49:06'),
(994, 25, '2013-04-17 00:51:11'),
(995, 25, '2013-04-17 00:51:37'),
(996, 25, '2013-04-17 00:52:15'),
(997, 25, '2013-04-17 00:52:33'),
(998, 25, '2013-04-17 00:52:45'),
(999, 25, '2013-04-17 00:54:53'),
(1000, 25, '2013-04-17 00:55:27'),
(1001, 25, '2013-04-17 00:56:40'),
(1002, 25, '2013-04-17 00:57:35'),
(1003, 25, '2013-04-17 01:01:35'),
(1004, 25, '2013-04-17 01:02:49'),
(1005, 25, '2013-04-17 01:03:28'),
(1006, 25, '2013-04-17 01:03:55'),
(1007, 25, '2013-04-17 01:04:14'),
(1008, 26, '2013-04-17 01:04:37'),
(1009, 25, '2013-04-17 01:05:04'),
(1010, 25, '2013-04-17 01:07:07'),
(1011, 25, '2013-04-17 01:07:35'),
(1012, 25, '2013-04-17 01:07:39'),
(1013, 25, '2013-04-17 01:07:56'),
(1014, 25, '2013-04-17 01:08:11'),
(1015, 25, '2013-04-17 01:16:26'),
(1016, 25, '2013-04-17 01:16:54'),
(1017, 25, '2013-04-17 01:17:07'),
(1018, 25, '2013-04-17 01:18:03'),
(1019, 25, '2013-04-17 01:18:14'),
(1020, 25, '2013-04-17 01:18:33'),
(1021, 25, '2013-04-17 01:18:55'),
(1022, 25, '2013-04-17 01:20:11'),
(1023, 25, '2013-04-17 01:20:26'),
(1024, 25, '2013-04-17 01:22:31'),
(1025, 25, '2013-04-17 01:22:45'),
(1026, 25, '2013-04-17 01:28:48'),
(1027, 25, '2013-04-17 01:34:52'),
(1028, 25, '2013-04-17 01:48:55'),
(1029, 25, '2013-04-17 01:49:10'),
(1030, 25, '2013-04-17 01:49:19'),
(1031, 25, '2013-04-17 01:49:32'),
(1032, 25, '2013-04-17 01:49:37'),
(1033, 25, '2013-04-17 01:49:42'),
(1034, 25, '2013-04-17 01:56:47'),
(1035, 25, '2013-04-17 02:14:41'),
(1036, 25, '2013-04-17 02:17:09'),
(1037, 25, '2013-04-17 02:23:34'),
(1038, 25, '2013-04-17 02:24:09'),
(1039, 25, '2013-04-17 02:25:03'),
(1040, 25, '2013-04-17 02:28:25'),
(1041, 25, '2013-04-17 02:28:32'),
(1042, 25, '2013-04-17 02:29:09'),
(1043, 25, '2013-04-17 02:29:29'),
(1044, 25, '2013-04-17 02:31:57'),
(1045, 25, '2013-04-17 02:33:22'),
(1046, 25, '2013-04-17 02:34:02'),
(1047, 25, '2013-04-17 02:34:04'),
(1048, 25, '2013-04-17 02:34:06'),
(1049, 25, '2013-04-17 02:34:16'),
(1050, 25, '2013-04-17 02:34:20'),
(1051, 25, '2013-04-17 02:34:25'),
(1052, 25, '2013-04-17 02:35:47'),
(1053, 25, '2013-04-17 03:00:44'),
(1054, 25, '2013-04-17 03:01:24'),
(1055, 25, '2013-04-17 03:01:27'),
(1056, 25, '2013-04-17 03:06:39'),
(1057, 25, '2013-04-17 03:06:44'),
(1058, 25, '2013-04-17 03:06:54'),
(1059, 25, '2013-04-17 03:06:59'),
(1060, 25, '2013-04-17 03:07:11'),
(1061, 25, '2013-04-17 03:08:15'),
(1062, 25, '2013-04-17 03:08:21'),
(1063, 25, '2013-04-17 03:08:26'),
(1064, 25, '2013-04-17 03:08:30'),
(1065, 25, '2013-04-17 03:09:36'),
(1066, 25, '2013-04-17 03:14:41'),
(1067, 25, '2013-04-17 03:14:46'),
(1068, 25, '2013-04-17 03:14:50'),
(1069, 25, '2013-04-17 03:16:06'),
(1070, 25, '2013-04-17 03:16:11'),
(1071, 25, '2013-04-17 03:16:16'),
(1072, 25, '2013-04-17 03:16:21'),
(1073, 25, '2013-04-17 03:16:41'),
(1074, 25, '2013-04-17 03:16:50'),
(1075, 25, '2013-04-17 03:16:54'),
(1076, 25, '2013-04-17 03:16:59'),
(1077, 25, '2013-04-17 03:24:45'),
(1078, 25, '2013-04-17 03:26:33'),
(1079, 25, '2013-04-17 03:26:52'),
(1080, 25, '2013-04-17 03:27:53'),
(1081, 25, '2013-04-17 03:27:54'),
(1082, 27, '2013-04-17 19:37:47'),
(1083, 27, '2013-04-17 19:43:43'),
(1084, 27, '2013-04-17 19:43:58'),
(1085, 27, '2013-04-17 19:47:41'),
(1086, 27, '2013-04-17 19:48:08'),
(1087, 27, '2013-04-17 19:57:07'),
(1088, 27, '2013-04-17 19:57:19'),
(1089, 27, '2013-04-17 19:58:42'),
(1090, 27, '2013-04-17 19:58:43'),
(1091, 27, '2013-04-17 19:59:20'),
(1092, 27, '2013-04-17 20:04:14'),
(1093, 27, '2013-04-17 20:09:50'),
(1094, 27, '2013-04-17 20:10:47'),
(1095, 27, '2013-04-17 20:32:52'),
(1096, 27, '2013-04-17 20:33:35'),
(1097, 27, '2013-04-17 20:35:04'),
(1098, 27, '2013-04-17 20:35:18'),
(1099, 27, '2013-04-17 20:36:17'),
(1100, 27, '2013-04-17 20:36:23'),
(1101, 27, '2013-04-17 20:36:37'),
(1102, 27, '2013-04-17 20:38:02'),
(1103, 27, '2013-04-17 20:42:37'),
(1104, 27, '2013-04-17 20:47:11'),
(1105, 27, '2013-04-17 21:02:50'),
(1106, 27, '2013-04-17 21:03:03'),
(1107, 27, '2013-04-17 21:03:40'),
(1108, 27, '2013-04-17 21:03:58'),
(1109, 27, '2013-04-17 21:05:13'),
(1110, 27, '2013-04-17 21:11:25'),
(1111, 27, '2013-04-17 21:14:23'),
(1112, 27, '2013-04-17 21:14:45'),
(1113, 27, '2013-04-17 21:15:30'),
(1114, 27, '2013-04-17 21:16:05'),
(1115, 27, '2013-04-17 21:17:12'),
(1116, 27, '2013-04-17 21:19:23'),
(1117, 27, '2013-04-17 21:19:41'),
(1118, 27, '2013-04-17 21:29:31'),
(1119, 27, '2013-04-17 21:31:52'),
(1120, 27, '2013-04-17 21:31:56'),
(1121, 27, '2013-04-17 21:32:07'),
(1122, 27, '2013-04-17 21:32:43'),
(1123, 27, '2013-04-17 21:32:47'),
(1124, 27, '2013-04-17 21:33:02'),
(1125, 27, '2013-04-17 21:33:03'),
(1126, 27, '2013-04-17 21:33:05'),
(1127, 27, '2013-04-17 21:33:06'),
(1128, 27, '2013-04-17 21:33:07'),
(1129, 27, '2013-04-17 21:34:48'),
(1130, 27, '2013-04-17 21:34:55'),
(1131, 27, '2013-04-17 21:35:26'),
(1132, 27, '2013-04-17 21:36:10'),
(1133, 27, '2013-04-17 21:36:13'),
(1134, 27, '2013-04-17 21:36:57'),
(1135, 27, '2013-04-17 21:37:01'),
(1136, 27, '2013-04-17 21:37:17'),
(1137, 27, '2013-04-17 21:37:22'),
(1138, 27, '2013-04-17 21:37:25'),
(1139, 27, '2013-04-17 21:37:27'),
(1140, 27, '2013-04-17 21:37:29'),
(1141, 27, '2013-04-17 21:37:30'),
(1142, 27, '2013-04-17 21:37:31'),
(1143, 27, '2013-04-17 21:37:52'),
(1144, 27, '2013-04-17 21:37:55'),
(1145, 27, '2013-04-17 21:38:07'),
(1146, 27, '2013-04-17 21:38:09'),
(1147, 27, '2013-04-17 21:38:11'),
(1148, 27, '2013-04-17 21:38:12'),
(1149, 27, '2013-04-17 21:38:13'),
(1150, 27, '2013-04-17 21:38:56'),
(1151, 27, '2013-04-17 21:38:58'),
(1152, 27, '2013-04-17 21:42:03'),
(1153, 27, '2013-04-17 21:42:07'),
(1154, 27, '2013-04-17 21:42:39'),
(1155, 27, '2013-04-17 21:42:41'),
(1156, 27, '2013-04-17 21:42:42'),
(1157, 27, '2013-04-17 21:42:44'),
(1158, 27, '2013-04-17 21:42:45'),
(1159, 27, '2013-04-17 21:42:47'),
(1160, 27, '2013-04-17 21:43:56'),
(1161, 27, '2013-04-17 21:44:00'),
(1162, 27, '2013-04-17 21:44:13'),
(1163, 27, '2013-04-17 21:44:15'),
(1164, 27, '2013-04-17 21:44:17'),
(1165, 27, '2013-04-17 21:44:18'),
(1166, 27, '2013-04-17 21:44:19'),
(1167, 27, '2013-04-17 21:44:21'),
(1168, 27, '2013-04-17 21:48:47'),
(1169, 27, '2013-04-17 21:48:53'),
(1170, 27, '2013-04-17 21:48:56'),
(1171, 27, '2013-04-17 21:48:57'),
(1172, 27, '2013-04-17 21:48:58'),
(1173, 27, '2013-04-17 21:48:59'),
(1174, 27, '2013-04-17 21:49:01'),
(1175, 27, '2013-04-17 21:50:37'),
(1176, 27, '2013-04-17 21:50:41'),
(1177, 27, '2013-04-17 21:50:46'),
(1178, 27, '2013-04-17 21:50:47'),
(1179, 27, '2013-04-17 21:50:49'),
(1180, 27, '2013-04-17 21:50:50'),
(1181, 27, '2013-04-17 21:55:40'),
(1182, 27, '2013-04-17 22:00:42'),
(1183, 27, '2013-04-17 22:03:19'),
(1184, 27, '2013-04-17 22:06:04'),
(1185, 27, '2013-04-17 22:06:40'),
(1186, 27, '2013-04-17 22:07:33'),
(1187, 27, '2013-04-17 22:12:44'),
(1188, 27, '2013-04-17 22:12:57'),
(1189, 27, '2013-04-17 22:12:59'),
(1190, 27, '2013-04-17 22:13:18'),
(1191, 27, '2013-04-17 22:15:58'),
(1192, 27, '2013-04-17 22:17:52'),
(1193, 27, '2013-04-17 22:19:52'),
(1194, 27, '2013-04-17 22:21:43'),
(1195, 27, '2013-04-17 22:22:37'),
(1196, 27, '2013-04-17 22:23:22'),
(1197, 27, '2013-04-17 22:27:42'),
(1198, 27, '2013-04-17 22:29:52'),
(1199, 27, '2013-04-17 22:30:59'),
(1200, 28, '2013-04-18 00:18:33'),
(1201, 28, '2013-04-18 00:41:30'),
(1202, 28, '2013-04-18 00:42:12'),
(1203, 28, '2013-04-18 01:20:26'),
(1204, 28, '2013-04-18 01:20:31'),
(1205, 28, '2013-04-18 01:31:57'),
(1206, 28, '2013-04-18 02:09:05'),
(1207, 28, '2013-04-18 02:10:28'),
(1208, 28, '2013-04-18 02:10:32'),
(1209, 28, '2013-04-18 02:11:22'),
(1210, 28, '2013-04-18 02:11:25'),
(1211, 28, '2013-04-18 02:12:28'),
(1212, 28, '2013-04-18 02:12:35'),
(1213, 28, '2013-04-18 02:12:42'),
(1214, 28, '2013-04-18 02:12:49'),
(1215, 28, '2013-04-18 02:13:19'),
(1216, 28, '2013-04-18 02:13:23'),
(1217, 28, '2013-04-18 02:27:59'),
(1218, 28, '2013-04-18 02:28:00'),
(1219, 28, '2013-04-18 02:28:11'),
(1220, 28, '2013-04-18 02:28:15'),
(1221, 28, '2013-04-18 02:38:23'),
(1222, 28, '2013-04-18 02:39:33'),
(1223, 29, '2013-04-18 02:39:35'),
(1224, 29, '2013-04-18 02:39:43'),
(1225, 29, '2013-04-18 02:40:37'),
(1226, 29, '2013-04-18 02:40:44'),
(1227, 29, '2013-04-18 02:40:47'),
(1228, 29, '2013-04-18 02:42:13'),
(1229, 29, '2013-04-18 02:42:21'),
(1230, 29, '2013-04-18 02:42:25'),
(1231, 29, '2013-04-18 02:42:31'),
(1232, 29, '2013-04-18 02:47:13'),
(1233, 29, '2013-04-18 02:47:20'),
(1234, 29, '2013-04-18 02:47:23'),
(1235, 29, '2013-04-18 02:47:32'),
(1236, 30, '2013-04-18 02:47:34'),
(1237, 30, '2013-04-18 02:47:42'),
(1238, 30, '2013-04-18 02:47:52'),
(1239, 30, '2013-04-18 02:48:00'),
(1240, 30, '2013-04-18 02:48:05'),
(1241, 30, '2013-04-18 02:48:12'),
(1242, 30, '2013-04-18 02:48:15'),
(1243, 30, '2013-04-18 02:50:20'),
(1244, 30, '2013-04-18 02:50:31'),
(1245, 30, '2013-04-18 02:53:55'),
(1246, 30, '2013-04-18 02:59:33'),
(1247, 30, '2013-04-18 02:59:36'),
(1248, 30, '2013-04-18 03:01:51'),
(1249, 30, '2013-04-18 03:03:20'),
(1250, 30, '2013-04-18 03:03:26'),
(1251, 30, '2013-04-18 03:07:24'),
(1252, 30, '2013-04-18 03:07:26'),
(1253, 30, '2013-04-18 03:08:10'),
(1254, 30, '2013-04-18 03:08:27'),
(1255, 30, '2013-04-18 03:08:29'),
(1256, 30, '2013-04-18 03:08:41'),
(1257, 30, '2013-04-18 03:08:44'),
(1258, 30, '2013-04-18 03:08:59'),
(1259, 30, '2013-04-18 03:09:03'),
(1260, 30, '2013-04-18 03:09:05'),
(1261, 30, '2013-04-18 03:09:06'),
(1262, 30, '2013-04-18 03:09:21'),
(1263, 30, '2013-04-18 03:09:52'),
(1264, 30, '2013-04-18 03:10:15'),
(1265, 30, '2013-04-18 03:10:17'),
(1266, 30, '2013-04-18 03:10:26'),
(1267, 30, '2013-04-18 03:10:29'),
(1268, 30, '2013-04-18 03:13:33'),
(1269, 30, '2013-04-18 03:13:35'),
(1270, 30, '2013-04-18 03:15:38'),
(1271, 30, '2013-04-18 03:15:44'),
(1272, 30, '2013-04-18 03:16:23'),
(1273, 30, '2013-04-18 03:16:37'),
(1274, 30, '2013-04-18 03:16:42'),
(1275, 30, '2013-04-18 03:17:00'),
(1276, 30, '2013-04-18 03:19:08'),
(1277, 30, '2013-04-18 03:20:34'),
(1278, 30, '2013-04-18 03:20:44'),
(1279, 30, '2013-04-18 03:20:59'),
(1280, 30, '2013-04-18 03:27:06'),
(1281, 30, '2013-04-18 03:27:14'),
(1282, 30, '2013-04-18 03:27:20'),
(1283, 30, '2013-04-18 03:27:24'),
(1284, 30, '2013-04-18 03:28:18'),
(1285, 30, '2013-04-18 03:28:23'),
(1286, 30, '2013-04-18 03:28:33'),
(1287, 30, '2013-04-18 03:28:40'),
(1288, 30, '2013-04-18 03:28:46'),
(1289, 30, '2013-04-18 03:28:49'),
(1290, 30, '2013-04-18 03:28:52'),
(1291, 30, '2013-04-18 03:40:42'),
(1292, 30, '2013-04-18 03:44:06'),
(1293, 30, '2013-04-18 03:44:10'),
(1294, 30, '2013-04-18 03:44:12'),
(1295, 30, '2013-04-18 03:48:23'),
(1296, 30, '2013-04-18 03:48:31'),
(1297, 30, '2013-04-18 03:51:30'),
(1298, 30, '2013-04-18 03:51:55'),
(1299, 30, '2013-04-18 03:52:49'),
(1300, 30, '2013-04-18 03:53:28'),
(1301, 30, '2013-04-18 03:54:52'),
(1302, 31, '2013-04-18 19:27:33'),
(1303, 31, '2013-04-18 19:30:17'),
(1304, 31, '2013-04-18 19:30:29'),
(1305, 31, '2013-04-18 19:30:33'),
(1306, 31, '2013-04-18 19:31:57'),
(1307, 31, '2013-04-18 19:36:19'),
(1308, 31, '2013-04-18 19:39:26'),
(1309, 31, '2013-04-18 19:40:20'),
(1310, 31, '2013-04-18 19:40:26'),
(1311, 31, '2013-04-18 19:41:38'),
(1312, 31, '2013-04-18 19:56:05'),
(1313, 31, '2013-04-18 19:57:32'),
(1314, 31, '2013-04-18 20:14:27'),
(1315, 31, '2013-04-18 20:14:33'),
(1316, 31, '2013-04-18 20:15:11'),
(1317, 31, '2013-04-18 20:15:46'),
(1318, 31, '2013-04-18 20:15:54'),
(1319, 31, '2013-04-18 20:15:59'),
(1320, 31, '2013-04-18 20:17:21'),
(1321, 31, '2013-04-18 20:17:27'),
(1322, 31, '2013-04-18 20:18:19'),
(1323, 31, '2013-04-18 20:18:20'),
(1324, 31, '2013-04-18 20:19:15'),
(1325, 31, '2013-04-18 20:19:20'),
(1326, 31, '2013-04-18 20:19:28'),
(1327, 31, '2013-04-18 20:19:33'),
(1328, 31, '2013-04-18 20:19:38'),
(1329, 31, '2013-04-18 20:19:46'),
(1330, 31, '2013-04-18 20:20:04'),
(1331, 31, '2013-04-18 20:20:10'),
(1332, 31, '2013-04-18 20:20:50'),
(1333, 31, '2013-04-18 20:20:53'),
(1334, 31, '2013-04-18 20:20:59'),
(1335, 31, '2013-04-18 20:22:30'),
(1336, 31, '2013-04-18 20:22:37'),
(1337, 31, '2013-04-18 20:22:42'),
(1338, 31, '2013-04-18 20:23:46'),
(1339, 31, '2013-04-18 20:23:52'),
(1340, 31, '2013-04-18 20:23:58'),
(1341, 31, '2013-04-18 20:24:03'),
(1342, 31, '2013-04-18 20:25:27'),
(1343, 31, '2013-04-18 20:25:32'),
(1344, 31, '2013-04-18 20:28:05'),
(1345, 31, '2013-04-18 20:32:04'),
(1346, 31, '2013-04-18 20:32:07'),
(1347, 31, '2013-04-18 20:34:16'),
(1348, 31, '2013-04-18 20:34:19'),
(1349, 31, '2013-04-18 20:34:30'),
(1350, 31, '2013-04-18 20:34:33'),
(1351, 31, '2013-04-18 20:34:40'),
(1352, 31, '2013-04-18 20:34:43'),
(1353, 31, '2013-04-18 20:36:48'),
(1354, 31, '2013-04-18 20:36:50'),
(1355, 31, '2013-04-18 20:37:09'),
(1356, 31, '2013-04-18 20:37:13'),
(1357, 31, '2013-04-18 20:37:15'),
(1358, 31, '2013-04-18 20:37:20'),
(1359, 31, '2013-04-18 20:37:23'),
(1360, 31, '2013-04-18 20:37:30'),
(1361, 31, '2013-04-18 20:37:33'),
(1362, 31, '2013-04-18 20:53:02'),
(1363, 31, '2013-04-18 20:53:05'),
(1364, 31, '2013-04-18 20:54:14'),
(1365, 31, '2013-04-18 20:54:16'),
(1366, 31, '2013-04-18 20:54:39'),
(1367, 31, '2013-04-18 20:54:41'),
(1368, 31, '2013-04-18 20:55:51'),
(1369, 31, '2013-04-18 20:55:54'),
(1370, 31, '2013-04-18 20:56:45'),
(1371, 31, '2013-04-18 20:56:49'),
(1372, 31, '2013-04-18 20:56:53'),
(1373, 31, '2013-04-18 20:57:15'),
(1374, 31, '2013-04-18 20:57:37'),
(1375, 31, '2013-04-18 20:57:39'),
(1376, 31, '2013-04-18 20:57:45'),
(1377, 31, '2013-04-18 20:57:54'),
(1378, 31, '2013-04-18 20:57:57'),
(1379, 31, '2013-04-18 20:58:27'),
(1380, 31, '2013-04-18 20:58:31'),
(1381, 31, '2013-04-18 20:58:35'),
(1382, 31, '2013-04-18 20:59:07'),
(1383, 31, '2013-04-18 20:59:13'),
(1384, 31, '2013-04-18 20:59:18'),
(1385, 31, '2013-04-18 21:03:49'),
(1386, 31, '2013-04-18 21:03:54'),
(1387, 31, '2013-04-18 21:16:52'),
(1388, 31, '2013-04-18 21:19:41'),
(1389, 31, '2013-04-18 21:20:41'),
(1390, 31, '2013-04-18 21:21:16'),
(1391, 31, '2013-04-18 21:22:15'),
(1392, 31, '2013-04-18 21:22:27'),
(1393, 31, '2013-04-18 21:41:54'),
(1394, 31, '2013-04-18 21:42:08'),
(1395, 31, '2013-04-18 21:42:12'),
(1396, 31, '2013-04-18 21:42:44'),
(1397, 31, '2013-04-18 21:43:16'),
(1398, 31, '2013-04-18 21:43:22'),
(1399, 31, '2013-04-18 21:45:07'),
(1400, 31, '2013-04-18 21:47:27'),
(1401, 31, '2013-04-18 21:51:13'),
(1402, 31, '2013-04-18 21:53:17'),
(1403, 31, '2013-04-18 21:53:20'),
(1404, 31, '2013-04-18 21:53:26'),
(1405, 31, '2013-04-18 21:53:58'),
(1406, 31, '2013-04-18 21:54:01'),
(1407, 31, '2013-04-18 21:54:05'),
(1408, 31, '2013-04-18 21:59:35'),
(1409, 31, '2013-04-18 21:59:39'),
(1410, 31, '2013-04-18 21:59:41'),
(1411, 31, '2013-04-18 22:05:15'),
(1412, 31, '2013-04-18 22:05:30'),
(1413, 31, '2013-04-18 22:16:17'),
(1414, 31, '2013-04-18 22:35:42'),
(1415, 31, '2013-04-18 22:35:48'),
(1416, 31, '2013-04-18 23:19:29'),
(1417, 31, '2013-04-18 23:23:00'),
(1418, 31, '2013-04-18 23:24:03'),
(1419, 31, '2013-04-18 23:57:39'),
(1420, 31, '2013-04-19 00:10:32'),
(1421, 31, '2013-04-19 00:10:36'),
(1422, 31, '2013-04-19 00:18:22'),
(1423, 31, '2013-04-19 00:19:21'),
(1424, 31, '2013-04-19 00:19:27'),
(1425, 31, '2013-04-19 00:34:01'),
(1426, 32, '2013-04-19 00:34:05'),
(1427, 32, '2013-04-19 00:34:11'),
(1428, 32, '2013-04-19 00:34:16'),
(1429, 32, '2013-04-19 00:34:19'),
(1430, 32, '2013-04-19 00:35:11'),
(1431, 32, '2013-04-19 00:36:42'),
(1432, 32, '2013-04-19 00:37:11'),
(1433, 32, '2013-04-19 00:37:23'),
(1434, 32, '2013-04-19 00:37:54'),
(1435, 32, '2013-04-19 00:38:00'),
(1436, 32, '2013-04-19 00:39:20'),
(1437, 32, '2013-04-19 00:39:30'),
(1438, 32, '2013-04-19 00:42:14'),
(1439, 32, '2013-04-19 00:42:19'),
(1440, 32, '2013-04-19 00:47:07'),
(1441, 32, '2013-04-19 00:47:39'),
(1442, 32, '2013-04-19 01:10:33'),
(1443, 33, '2013-04-19 01:10:37'),
(1444, 33, '2013-04-19 01:10:46'),
(1445, 33, '2013-04-19 01:11:24'),
(1446, 33, '2013-04-19 01:11:32'),
(1447, 33, '2013-04-19 01:11:36'),
(1448, 33, '2013-04-19 01:11:40'),
(1449, 33, '2013-04-19 01:12:04'),
(1450, 33, '2013-04-19 01:12:07'),
(1451, 33, '2013-04-19 01:12:18'),
(1452, 33, '2013-04-19 01:12:20'),
(1453, 33, '2013-04-19 01:22:02'),
(1454, 33, '2013-04-19 01:22:23'),
(1455, 33, '2013-04-19 01:22:26'),
(1456, 33, '2013-04-19 01:22:29'),
(1457, 33, '2013-04-19 01:22:32'),
(1458, 33, '2013-04-19 01:22:42'),
(1459, 33, '2013-04-19 01:22:48'),
(1460, 33, '2013-04-19 01:23:03'),
(1461, 33, '2013-04-19 01:23:09'),
(1462, 33, '2013-04-19 01:23:12'),
(1463, 33, '2013-04-19 01:23:17'),
(1464, 33, '2013-04-19 01:23:44'),
(1465, 33, '2013-04-19 01:27:21'),
(1466, 33, '2013-04-19 01:32:25'),
(1467, 33, '2013-04-19 01:32:56'),
(1468, 33, '2013-04-19 01:32:58'),
(1469, 33, '2013-04-19 01:33:12'),
(1470, 33, '2013-04-19 01:33:17'),
(1471, 33, '2013-04-19 01:33:22'),
(1472, 33, '2013-04-19 01:33:50'),
(1473, 33, '2013-04-19 01:33:52'),
(1474, 33, '2013-04-19 01:35:33'),
(1475, 33, '2013-04-19 01:35:35'),
(1476, 33, '2013-04-19 01:35:39'),
(1477, 33, '2013-04-19 01:37:33'),
(1478, 33, '2013-04-19 01:37:36'),
(1479, 33, '2013-04-19 01:37:39'),
(1480, 33, '2013-04-19 01:37:42'),
(1481, 33, '2013-04-19 01:38:21'),
(1482, 33, '2013-04-19 01:38:56'),
(1483, 33, '2013-04-19 01:39:13'),
(1484, 33, '2013-04-19 01:39:15'),
(1485, 33, '2013-04-19 01:39:26'),
(1486, 33, '2013-04-19 01:39:29'),
(1487, 33, '2013-04-19 01:40:15'),
(1488, 33, '2013-04-19 01:40:30'),
(1489, 33, '2013-04-19 01:40:33'),
(1490, 33, '2013-04-19 01:40:47'),
(1491, 33, '2013-04-19 01:40:50'),
(1492, 33, '2013-04-19 01:41:25'),
(1493, 33, '2013-04-19 01:41:41'),
(1494, 33, '2013-04-19 01:41:43'),
(1495, 33, '2013-04-19 01:42:06'),
(1496, 33, '2013-04-19 01:42:09'),
(1497, 34, '2013-04-21 19:23:46'),
(1498, 34, '2013-04-21 19:25:24'),
(1499, 34, '2013-04-21 19:25:38'),
(1500, 34, '2013-04-21 19:25:42'),
(1501, 34, '2013-04-21 19:33:11'),
(1502, 34, '2013-04-21 19:33:29'),
(1503, 34, '2013-04-21 19:33:32'),
(1504, 34, '2013-04-21 19:33:36'),
(1505, 34, '2013-04-21 19:33:39'),
(1506, 34, '2013-04-21 19:37:34'),
(1507, 34, '2013-04-21 19:46:07'),
(1508, 34, '2013-04-21 19:46:10'),
(1509, 34, '2013-04-21 19:46:14'),
(1510, 34, '2013-04-21 19:46:17'),
(1511, 34, '2013-04-21 19:46:40'),
(1512, 34, '2013-04-21 19:46:55'),
(1513, 34, '2013-04-21 19:46:57'),
(1514, 34, '2013-04-21 19:47:01'),
(1515, 34, '2013-04-21 19:47:04'),
(1516, 34, '2013-04-21 19:51:19'),
(1517, 34, '2013-04-21 19:51:23'),
(1518, 34, '2013-04-21 19:51:25'),
(1519, 34, '2013-04-21 19:51:30'),
(1520, 34, '2013-04-21 19:51:35'),
(1521, 34, '2013-04-21 19:51:38'),
(1522, 34, '2013-04-21 19:54:39'),
(1523, 34, '2013-04-21 19:54:42'),
(1524, 34, '2013-04-21 19:54:45'),
(1525, 34, '2013-04-21 19:54:50'),
(1526, 34, '2013-04-21 19:54:54'),
(1527, 34, '2013-04-21 19:54:57'),
(1528, 34, '2013-04-21 20:05:01'),
(1529, 34, '2013-04-21 20:05:06'),
(1530, 34, '2013-04-21 20:05:09'),
(1531, 34, '2013-04-21 20:06:36'),
(1532, 34, '2013-04-21 20:06:58'),
(1533, 34, '2013-04-21 20:07:04'),
(1534, 34, '2013-04-21 20:07:07'),
(1535, 34, '2013-04-21 20:08:24'),
(1536, 34, '2013-04-21 20:08:27'),
(1537, 34, '2013-04-21 20:08:30'),
(1538, 34, '2013-04-21 20:09:02'),
(1539, 34, '2013-04-21 20:09:05'),
(1540, 34, '2013-04-21 20:09:10'),
(1541, 34, '2013-04-21 20:09:13'),
(1542, 34, '2013-04-21 20:09:16'),
(1543, 34, '2013-04-21 20:09:21'),
(1544, 34, '2013-04-21 20:09:33'),
(1545, 34, '2013-04-21 20:09:36'),
(1546, 34, '2013-04-21 20:09:50'),
(1547, 34, '2013-04-21 20:09:53'),
(1548, 34, '2013-04-21 20:09:56'),
(1549, 34, '2013-04-21 20:12:43'),
(1550, 34, '2013-04-21 20:12:46'),
(1551, 34, '2013-04-21 20:12:49'),
(1552, 34, '2013-04-21 20:12:54'),
(1553, 34, '2013-04-21 20:13:00'),
(1554, 34, '2013-04-21 20:13:03'),
(1555, 34, '2013-04-21 20:15:12'),
(1556, 34, '2013-04-21 20:15:16'),
(1557, 34, '2013-04-21 20:15:18');
INSERT INTO `log_url` (`url_id`, `visitor_id`, `visit_time`) VALUES
(1558, 34, '2013-04-21 20:16:16'),
(1559, 34, '2013-04-21 20:16:19'),
(1560, 34, '2013-04-21 20:16:24'),
(1561, 34, '2013-04-21 20:32:09'),
(1562, 34, '2013-04-21 20:32:22'),
(1563, 34, '2013-04-21 20:32:25'),
(1564, 36, '2013-04-21 20:37:58'),
(1565, 36, '2013-04-21 20:38:02'),
(1566, 36, '2013-04-21 20:38:10'),
(1567, 36, '2013-04-21 20:38:13'),
(1568, 36, '2013-04-21 20:38:17'),
(1569, 36, '2013-04-21 20:38:20'),
(1570, 36, '2013-04-21 20:38:23'),
(1571, 36, '2013-04-21 20:38:30'),
(1572, 36, '2013-04-21 20:43:09'),
(1573, 36, '2013-04-21 20:43:11'),
(1574, 36, '2013-04-21 20:43:18'),
(1575, 36, '2013-04-21 20:43:21'),
(1576, 36, '2013-04-21 20:43:26'),
(1577, 36, '2013-04-21 20:43:31'),
(1578, 36, '2013-04-21 20:43:34'),
(1579, 36, '2013-04-21 20:43:44'),
(1580, 36, '2013-04-21 20:43:50'),
(1581, 36, '2013-04-21 20:43:53'),
(1582, 36, '2013-04-21 20:58:19'),
(1583, 36, '2013-04-21 21:43:14'),
(1584, 36, '2013-04-21 21:43:22'),
(1585, 36, '2013-04-21 21:43:25'),
(1586, 36, '2013-04-21 21:43:29'),
(1587, 36, '2013-04-21 22:23:49'),
(1588, 36, '2013-04-21 22:23:55'),
(1589, 36, '2013-04-21 22:31:53'),
(1590, 36, '2013-04-21 22:45:17'),
(1591, 36, '2013-04-21 22:48:46'),
(1592, 36, '2013-04-21 22:51:22'),
(1593, 36, '2013-04-21 22:52:06'),
(1594, 36, '2013-04-21 22:53:09'),
(1595, 36, '2013-04-21 22:53:57'),
(1596, 36, '2013-04-21 22:54:50'),
(1597, 36, '2013-04-21 22:56:07'),
(1598, 36, '2013-04-21 22:56:25'),
(1599, 36, '2013-04-21 22:56:45'),
(1600, 36, '2013-04-21 22:56:54'),
(1601, 36, '2013-04-21 22:58:42'),
(1602, 36, '2013-04-21 22:59:38'),
(1603, 36, '2013-04-21 23:00:41'),
(1604, 36, '2013-04-21 23:01:46'),
(1605, 36, '2013-04-21 23:02:48'),
(1606, 36, '2013-04-21 23:02:52'),
(1607, 36, '2013-04-21 23:03:04'),
(1608, 36, '2013-04-21 23:03:45'),
(1609, 36, '2013-04-21 23:05:42'),
(1610, 36, '2013-04-21 23:55:30'),
(1611, 36, '2013-04-21 23:56:57'),
(1612, 36, '2013-04-21 23:58:34'),
(1613, 36, '2013-04-21 23:59:05'),
(1614, 36, '2013-04-22 00:01:04'),
(1615, 36, '2013-04-22 00:01:25'),
(1616, 36, '2013-04-22 00:01:50'),
(1617, 36, '2013-04-22 00:01:54'),
(1618, 36, '2013-04-22 00:01:57'),
(1619, 36, '2013-04-22 00:02:45'),
(1620, 36, '2013-04-22 00:02:49'),
(1621, 36, '2013-04-22 00:02:53'),
(1622, 36, '2013-04-22 00:08:19'),
(1623, 36, '2013-04-22 00:08:55'),
(1624, 36, '2013-04-22 00:08:58'),
(1625, 36, '2013-04-22 00:09:01'),
(1626, 36, '2013-04-22 00:10:13'),
(1627, 36, '2013-04-22 00:10:18'),
(1628, 36, '2013-04-22 00:10:22'),
(1629, 36, '2013-04-22 00:10:27'),
(1630, 36, '2013-04-22 00:10:36'),
(1631, 36, '2013-04-22 00:10:39'),
(1632, 36, '2013-04-22 00:10:56'),
(1633, 36, '2013-04-22 00:10:58'),
(1634, 36, '2013-04-22 00:11:03'),
(1635, 37, '2013-04-22 00:11:07'),
(1636, 37, '2013-04-22 00:11:12'),
(1637, 37, '2013-04-22 00:11:21'),
(1638, 37, '2013-04-22 00:11:23'),
(1639, 37, '2013-04-22 00:11:29'),
(1640, 37, '2013-04-22 00:11:32'),
(1641, 37, '2013-04-22 00:12:17'),
(1642, 37, '2013-04-22 00:14:29'),
(1643, 37, '2013-04-22 00:14:42'),
(1644, 37, '2013-04-22 00:14:45'),
(1645, 37, '2013-04-22 00:15:33'),
(1646, 37, '2013-04-22 00:15:36'),
(1647, 37, '2013-04-22 00:20:02'),
(1648, 37, '2013-04-22 00:20:06'),
(1649, 37, '2013-04-22 00:20:11'),
(1650, 37, '2013-04-22 00:20:22'),
(1651, 37, '2013-04-22 00:20:24'),
(1652, 37, '2013-04-22 00:22:56'),
(1653, 37, '2013-04-22 00:23:11'),
(1654, 37, '2013-04-22 00:23:14'),
(1655, 37, '2013-04-22 00:23:38'),
(1656, 37, '2013-04-22 00:23:40'),
(1657, 37, '2013-04-22 00:24:12'),
(1658, 37, '2013-04-22 00:24:21'),
(1659, 37, '2013-04-22 00:24:24'),
(1660, 37, '2013-04-22 00:27:10'),
(1661, 37, '2013-04-22 00:27:25'),
(1662, 37, '2013-04-22 00:27:49'),
(1663, 37, '2013-04-22 00:27:54'),
(1664, 38, '2013-04-22 00:27:57'),
(1665, 38, '2013-04-22 00:28:02'),
(1666, 38, '2013-04-22 00:28:10'),
(1667, 38, '2013-04-22 00:28:12'),
(1668, 38, '2013-04-22 00:30:08'),
(1669, 38, '2013-04-22 00:30:19'),
(1670, 38, '2013-04-22 00:30:22'),
(1671, 38, '2013-04-22 00:30:31'),
(1672, 38, '2013-04-22 00:30:33'),
(1673, 38, '2013-04-22 00:30:36'),
(1674, 38, '2013-04-22 00:30:39'),
(1675, 38, '2013-04-22 00:31:28'),
(1676, 38, '2013-04-22 00:31:38'),
(1677, 38, '2013-04-22 00:31:40'),
(1678, 38, '2013-04-22 00:33:17'),
(1679, 38, '2013-04-22 00:33:27'),
(1680, 38, '2013-04-22 00:33:29'),
(1681, 38, '2013-04-22 00:33:54'),
(1682, 38, '2013-04-22 00:33:57'),
(1683, 38, '2013-04-22 00:34:55'),
(1684, 38, '2013-04-22 00:35:04'),
(1685, 38, '2013-04-22 00:35:06'),
(1686, 38, '2013-04-22 00:35:10'),
(1687, 38, '2013-04-22 00:35:13'),
(1688, 38, '2013-04-22 00:35:22'),
(1689, 38, '2013-04-22 00:36:46'),
(1690, 38, '2013-04-22 00:36:57'),
(1691, 38, '2013-04-22 00:36:59'),
(1692, 38, '2013-04-22 00:37:53'),
(1693, 38, '2013-04-22 00:37:56'),
(1694, 38, '2013-04-22 00:38:02'),
(1695, 38, '2013-04-22 00:38:05'),
(1696, 38, '2013-04-22 00:38:42'),
(1697, 38, '2013-04-22 00:38:50'),
(1698, 38, '2013-04-22 00:38:53'),
(1699, 38, '2013-04-22 00:39:23'),
(1700, 38, '2013-04-22 00:39:26'),
(1701, 38, '2013-04-22 00:39:29'),
(1702, 38, '2013-04-22 00:51:04'),
(1703, 38, '2013-04-22 00:51:15'),
(1704, 38, '2013-04-22 00:51:34'),
(1705, 38, '2013-04-22 00:51:40'),
(1706, 38, '2013-04-22 00:51:46'),
(1707, 38, '2013-04-22 00:52:07'),
(1708, 38, '2013-04-22 00:54:54'),
(1709, 38, '2013-04-22 01:01:24'),
(1710, 38, '2013-04-22 01:02:09'),
(1711, 38, '2013-04-22 01:03:02'),
(1712, 38, '2013-04-22 01:05:56'),
(1713, 38, '2013-04-22 01:06:13'),
(1714, 38, '2013-04-22 01:06:13'),
(1715, 38, '2013-04-22 01:06:14'),
(1716, 38, '2013-04-22 01:06:19'),
(1717, 38, '2013-04-22 01:06:56'),
(1718, 38, '2013-04-22 01:10:38'),
(1719, 38, '2013-04-22 01:13:36'),
(1720, 38, '2013-04-22 01:16:07'),
(1721, 38, '2013-04-22 01:18:24'),
(1722, 38, '2013-04-22 01:18:32'),
(1723, 38, '2013-04-22 01:18:47'),
(1724, 38, '2013-04-22 01:18:52'),
(1725, 38, '2013-04-22 01:18:58'),
(1726, 38, '2013-04-22 01:19:03'),
(1727, 38, '2013-04-22 01:19:09'),
(1728, 38, '2013-04-22 01:19:18'),
(1729, 38, '2013-04-22 01:21:06'),
(1730, 38, '2013-04-22 01:21:14'),
(1731, 38, '2013-04-22 01:21:50'),
(1732, 38, '2013-04-22 01:25:23'),
(1733, 38, '2013-04-22 01:25:28'),
(1734, 38, '2013-04-22 01:25:32'),
(1735, 38, '2013-04-22 01:25:53'),
(1736, 38, '2013-04-22 01:25:59'),
(1737, 38, '2013-04-22 01:26:04'),
(1738, 38, '2013-04-22 01:26:11'),
(1739, 38, '2013-04-22 01:27:05'),
(1740, 38, '2013-04-22 01:27:26'),
(1741, 38, '2013-04-22 01:27:43'),
(1742, 38, '2013-04-22 01:33:40'),
(1743, 38, '2013-04-22 01:35:57'),
(1744, 38, '2013-04-22 01:40:21'),
(1745, 38, '2013-04-22 01:40:23'),
(1746, 38, '2013-04-22 01:40:25'),
(1747, 38, '2013-04-22 01:48:33'),
(1748, 38, '2013-04-22 01:53:31'),
(1749, 38, '2013-04-22 01:53:32'),
(1750, 38, '2013-04-22 01:59:44'),
(1751, 38, '2013-04-22 01:59:49'),
(1752, 38, '2013-04-22 02:00:29'),
(1753, 39, '2013-04-22 03:28:58'),
(1754, 39, '2013-04-22 03:35:12'),
(1755, 39, '2013-04-22 03:35:50'),
(1756, 39, '2013-04-22 03:35:54'),
(1757, 39, '2013-04-22 03:35:56'),
(1758, 39, '2013-04-22 03:36:15');

-- --------------------------------------------------------

--
-- Table structure for table `log_url_info`
--

CREATE TABLE IF NOT EXISTS `log_url_info` (
  `url_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'URL ID',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL',
  `referer` varchar(255) DEFAULT NULL COMMENT 'Referrer',
  PRIMARY KEY (`url_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Log URL Info Table' AUTO_INCREMENT=1759 ;

--
-- Dumping data for table `log_url_info`
--

INSERT INTO `log_url_info` (`url_id`, `url`, `referer`) VALUES
(1, 'http://my.local/magento/', NULL),
(2, 'http://my.local/magento/', NULL),
(3, 'http://my.local/magento/mage_news', NULL),
(4, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/mage_news'),
(5, 'http://my.local/magento/news', NULL),
(6, 'http://my.local/magento/', 'http://stackoverflow.com/questions/6321987/magento-geturl-for-custom-extension'),
(7, 'http://my.local/magento/index.php/', 'http://my.local/magento/news'),
(8, 'http://my.local/magento/index.php/mage_news', NULL),
(9, 'http://my.local/magento/index.php/mage/news', NULL),
(10, 'http://my.local/magento/index.php/news', NULL),
(11, 'http://my.local/magento/index.php/Mage/News', NULL),
(12, 'http://my.local/magento/', NULL),
(13, 'http://my.local/magento/News/News', NULL),
(14, 'http://my.local/magento/index.php/News/News', NULL),
(15, 'http://my.local/magento/index.php/news', NULL),
(16, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/news'),
(17, 'http://my.local/magento/index.php', NULL),
(18, 'http://my.local/magento/index.php', NULL),
(19, 'http://my.local/magento/', NULL),
(20, 'http://my.local/magento/', NULL),
(21, 'http://my.local/magento/', NULL),
(22, 'http://my.local/magento/', NULL),
(23, 'http://my.local/magento/', NULL),
(24, 'http://my.local/magento/', NULL),
(25, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(26, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(27, 'http://my.local/magento/', NULL),
(28, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(29, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(30, 'http://my.local/magento/', NULL),
(31, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(32, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(33, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(34, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(35, 'http://my.local/magento/skin/frontend/default/bob/img/menu-arrow.png', 'http://my.local/magento/'),
(36, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(37, 'http://my.local/magento/', NULL),
(38, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(39, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(40, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(41, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(42, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(43, 'http://my.local/magento/', NULL),
(44, 'http://my.local/magento/js/js/custom.js', 'http://my.local/magento/'),
(45, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(46, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(47, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(48, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(49, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(50, 'http://my.local/magento/', NULL),
(51, 'http://my.local/magento/js/js/custom.js', 'http://my.local/magento/'),
(52, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(53, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(54, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(55, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(56, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(57, 'http://my.local/magento/', NULL),
(58, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(59, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(60, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(61, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(62, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(63, 'http://my.local/magento/', NULL),
(64, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(65, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(66, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(67, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(68, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(69, 'http://my.local/magento/', NULL),
(70, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(71, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(72, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(73, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(74, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(75, 'http://my.local/magento/', NULL),
(76, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(77, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(78, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(79, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(80, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(81, 'http://my.local/magento/', NULL),
(82, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(83, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(84, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(85, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(86, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(87, 'http://my.local/magento/', NULL),
(88, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(89, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(90, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(91, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(92, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(93, 'http://my.local/magento/', NULL),
(94, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(95, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(96, 'http://my.local/magento/', NULL),
(97, 'http://my.local/magento/skin/frontend/base/default/images/banner_txt.png', 'http://my.local/magento/'),
(98, 'http://my.local/magento/skin/frontend/default/bob/img/header-glow.png', 'http://my.local/magento/'),
(99, 'http://my.local/magento/skin/frontend/default/bob/img/bg/patterns/noise.png', 'http://my.local/magento/'),
(100, 'http://my.local/magento/skin/frontend/default/bob/img/menu-bg.png', 'http://my.local/magento/'),
(101, 'http://my.local/magento/skin/frontend/base/default/images/slide.jpg', 'http://my.local/magento/'),
(102, 'http://my.local/magento/', NULL),
(103, 'http://my.local/magento/', NULL),
(104, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(105, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(106, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(107, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(108, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(109, 'http://my.local/magento/skin/frontend/default/bob/img/menu-arrow.png', 'http://my.local/magento/'),
(110, 'http://my.local/magento/', NULL),
(111, 'http://my.local/magento/', NULL),
(112, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(113, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(114, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(115, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(116, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(117, 'http://my.local/magento/', NULL),
(118, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(119, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(120, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(121, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(122, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(123, 'http://my.local/magento/', NULL),
(124, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(125, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(126, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(127, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(128, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(129, 'http://my.local/magento/', NULL),
(130, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(131, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(132, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(133, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(134, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(135, 'http://my.local/magento/', NULL),
(136, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(137, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(138, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(139, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(140, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(141, 'http://my.local/magento/', NULL),
(142, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(143, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(144, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(145, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(146, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(147, 'http://my.local/magento/index.php/catalogsearch/result/?q=dfdgdfg', 'http://my.local/magento/'),
(148, 'http://my.local/magento/', 'http://my.local/magento/index.php/catalogsearch/result/?q=dfdgdfg'),
(149, 'http://my.local/magento/', 'http://my.local/magento/index.php/catalogsearch/result/?q=dfdgdfg'),
(150, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(151, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(152, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(153, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(154, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(155, 'http://my.local/magento/', 'http://my.local/magento/index.php/catalogsearch/result/?q=dfdgdfg'),
(156, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Info.png', 'http://my.local/magento/'),
(157, 'http://my.local/magento/skin/frontend/default/bob/img/tabs.png', 'http://my.local/magento/'),
(158, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Green.png', 'http://my.local/magento/'),
(159, 'http://my.local/magento/skin/frontend/default/bob/img/tabs-divider.png', 'http://my.local/magento/'),
(160, 'http://my.local/magento/skin/frontend/default/bob/img/bottom-shadow.png', 'http://my.local/magento/'),
(161, 'http://my.local/magento/', 'http://my.local/magento/index.php/catalogsearch/result/?q=dfdgdfg'),
(162, 'http://my.local/magento/skin/adminhtml/base/default/images/media/about_us_img.jpg', NULL),
(163, 'http://my.local/magento/about-magento-demo-store', NULL),
(164, 'http://my.local/magento/', 'http://my.local/magento/index.php/catalogsearch/result/?q=dfdgdfg'),
(165, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(166, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(167, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(168, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(169, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(170, 'http://my.local/magento/', 'http://my.local/magento/index.php/customer/account/login/'),
(171, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(172, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(173, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(174, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(175, 'http://my.local/magento/', 'http://my.local/magento/index.php/customer/account/login/'),
(176, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(177, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(178, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(179, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(180, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(181, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(182, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(183, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(184, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(185, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(186, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(187, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(188, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(189, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(190, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(191, 'http://my.local/magento/index.php/customer/account/create/', 'http://my.local/magento/index.php/customer/account/login/'),
(192, 'http://my.local/magento/index.php/customer/account/createpost/', 'http://my.local/magento/index.php/customer/account/create/'),
(193, 'http://my.local/magento/index.php/customer/account/index/', 'http://my.local/magento/index.php/customer/account/create/'),
(194, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/customer/account/index/'),
(195, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/index/'),
(196, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(197, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(198, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(199, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(200, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(201, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/login/'),
(202, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(203, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(204, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/customer/account/'),
(205, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/'),
(206, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(207, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(208, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(209, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(210, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(211, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(212, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(213, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(214, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/customer/account/'),
(215, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/'),
(216, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/'),
(217, 'http://my.local/magento/', 'http://my.local/'),
(218, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(219, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(220, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/login/'),
(221, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/login/'),
(222, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/login/'),
(223, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(224, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(225, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(226, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(227, 'http://my.local/magento/index.php/customer/account/login/', NULL),
(228, 'http://my.local/magento/index.php/customer/account/create/', NULL),
(229, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/create/'),
(230, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/create/'),
(231, 'http://my.local/magento/index.php//customer/account/login', 'http://my.local/magento/index.php/'),
(232, 'http://my.local/magento/index.php//customer/account/login', 'http://my.local/magento/index.php/'),
(233, 'http://my.local/magento/index.php//customer/account/login', 'http://my.local/magento/index.php/'),
(234, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php//customer/account/login'),
(235, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/login'),
(236, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/login'),
(237, 'http://my.local/magento/skin/adminhtml/base/default/images/media/about_us_img.jpg', NULL),
(238, 'http://my.local/magento/skin/adminhtml/base/default/images/media/about_us_img.jpg', NULL),
(239, 'http://my.local/magento/skin/adminhtml/base/default/images/media/about_us_img.jpg', NULL),
(240, 'http://my.local/magento/index.php/help', NULL),
(241, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/help'),
(242, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/help'),
(243, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(244, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/'),
(245, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/help'),
(246, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(247, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/'),
(248, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/'),
(249, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/help'),
(250, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/help'),
(251, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/help'),
(252, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/help'),
(253, 'http://my.local/magento/index.php/article/index', NULL),
(254, 'http://my.local/magento/index.php/article/', NULL),
(255, 'http://my.local/magento/index.php/article/index/index', NULL),
(256, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/index'),
(257, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/index'),
(258, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/index'),
(259, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/'),
(260, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/login'),
(261, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/'),
(262, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/help'),
(263, 'http://my.local/magento/', 'http://my.local/magento/index.php/'),
(264, 'http://my.local/magento/index.php/', 'http://my.local/magento/'),
(265, 'http://my.local/magento/', 'http://my.local/magento/index.php/'),
(266, 'http://my.local/magento/index.php/', 'http://my.local/magento/'),
(267, 'http://my.local/magento/', NULL),
(268, 'http://my.local/magento/article/index', NULL),
(269, 'http://my.local/magento/article/index', NULL),
(270, 'http://my.local/magento/article/index', NULL),
(271, 'http://my.local/magento/article/adminhtml', NULL),
(272, 'http://my.local/magento/article/adminhtml', NULL),
(273, 'http://my.local/magento/article/', NULL),
(274, 'http://my.local/magento/', NULL),
(275, 'http://my.local/magento/', NULL),
(276, 'http://my.local/magento/index.php/', 'http://my.local/magento/'),
(277, 'http://my.local/magento/index.php/', 'http://my.local/magento/'),
(278, 'http://my.local/magento/index.php/article/new', NULL),
(279, 'http://my.local/magento/index.php/article/new', NULL),
(280, 'http://my.local/magento/index.php/article/index/new', NULL),
(281, 'http://my.local/magento/index.php/article/new', 'http://my.local/magento/index.php/article/index/new'),
(282, 'http://my.local/magento/index.php/article/new', 'http://my.local/magento/index.php/article/index/new'),
(283, 'http://my.local/magento/index.php/article/index/new', NULL),
(284, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(285, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(286, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(287, 'http://my.local/magento/index.php/article/index/new', NULL),
(288, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(289, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(290, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(291, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(292, 'http://my.local/magento/index.php/article/index/new', NULL),
(293, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(294, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(295, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(296, 'http://my.local/magento/index.php/article/index/new', NULL),
(297, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(298, 'http://my.local/magento/index.php/article/index/new', NULL),
(299, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(300, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(301, 'http://my.local/magento/index.php/article/index/new', NULL),
(302, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(303, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(304, 'http://my.local/magento/index.php/article/index/new', NULL),
(305, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(306, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(307, 'http://my.local/magento/index.php/article/index/', NULL),
(308, 'http://my.local/magento/index.php/article/index/new', NULL),
(309, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(310, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(311, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(312, 'http://my.local/magento/index.php/article/index/new', NULL),
(313, 'http://my.local/magento/index.php/article/new', NULL),
(314, 'http://my.local/magento/index.php/article/new', NULL),
(315, 'http://my.local/magento/index.php/article/new', NULL),
(316, 'http://my.local/magento/index.php/article/new', NULL),
(317, 'http://my.local/magento/index.php/article/new/index', NULL),
(318, 'http://my.local/magento/index.php/article/new/index', NULL),
(319, 'http://my.local/magento/index.php/article/index/new', NULL),
(320, 'http://my.local/magento/index.php/article/index/new', NULL),
(321, 'http://my.local/magento/js/custom/jquery.tools.min.js.js', 'http://my.local/magento/index.php/article/index/new'),
(322, 'http://my.local/magento/skin/frontend/default/bob/css/h80.png', 'http://my.local/magento/index.php/article/index/new'),
(323, 'http://my.local/magento/index.php/article/index/new', NULL),
(324, 'http://my.local/magento/index.php/article/index/new', NULL),
(325, 'http://my.local/magento/index.php/article/index/new', NULL),
(326, 'http://my.local/magento/index.php/article/index/new', NULL),
(327, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(328, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(329, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(330, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/article/index/'),
(331, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/article/index/'),
(332, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/article/index/'),
(333, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/article/index/'),
(334, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/customer/account/login'),
(335, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login'),
(336, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login'),
(337, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(338, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(339, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(340, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(341, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(342, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(343, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(344, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/help'),
(345, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/'),
(346, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/'),
(347, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(348, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(349, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(350, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(351, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/help'),
(352, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(353, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(354, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/'),
(355, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/'),
(356, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(357, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(358, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(359, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(360, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(361, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/login/'),
(362, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/login/'),
(363, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(364, 'http://my.local/magento/index.php/customer/account/index/', 'http://my.local/magento/index.php/customer/account/login/'),
(365, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/index/'),
(366, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(367, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(368, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(369, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/help'),
(370, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(371, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(372, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/'),
(373, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/'),
(374, 'http://my.local/magento/', NULL),
(375, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(376, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(377, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(378, 'http://my.local/magento/index.php/customer/account/index/', 'http://my.local/magento/index.php/customer/account/login/'),
(379, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(380, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(381, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(382, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/'),
(383, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/help'),
(384, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(385, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(386, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(387, 'http://my.local/magento/', NULL),
(388, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(389, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(390, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(391, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(392, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(393, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(394, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(395, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(396, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(397, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(398, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(399, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(400, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(401, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(402, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(403, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(404, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(405, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(406, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(407, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(408, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(409, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(410, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(411, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(412, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(413, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(414, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(415, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(416, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(417, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(418, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(419, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(420, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(421, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(422, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(423, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(424, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(425, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(426, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(427, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(428, 'http://my.local/magento/', NULL),
(429, 'http://my.local/magento/', NULL),
(430, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(431, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(432, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(433, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(434, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(435, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(436, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/'),
(437, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(438, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(439, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(440, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(441, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(442, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets'),
(443, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets'),
(444, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets'),
(445, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets'),
(446, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&sorting=-totalBets'),
(447, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&sorting=-totalBets'),
(448, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(449, 'http://my.local/magento/index.php/article/index/?status=closed&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(450, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=closed&category=All&sorting=-totalBets'),
(451, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(452, 'http://my.local/magento/index.php/article/index/?status=available&category=Economics&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(453, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=Economics&sorting=-totalBets'),
(454, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(455, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(456, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(457, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/'),
(458, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(459, 'http://my.local/magento/index.php/article/index/?status=closed&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(460, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=closed&category=All&sorting=-totalBets'),
(461, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets'),
(462, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets'),
(463, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets'),
(464, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(465, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(466, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(467, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(468, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(469, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(470, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(471, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(472, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(473, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets'),
(474, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&sorting=-totalBets'),
(475, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(476, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets'),
(477, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(478, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets'),
(479, 'http://my.local/magento/index.php/article/index/?status=available&category=Economics', NULL),
(480, 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports', NULL),
(481, 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports', NULL);
INSERT INTO `log_url_info` (`url_id`, `url`, `referer`) VALUES
(482, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports'),
(483, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(484, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(485, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(486, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(487, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(488, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(489, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/'),
(490, 'http://my.local/magento/index.php/article/index/', NULL),
(491, 'http://my.local/magento/index.php/article/index/?status=available&category=Sports&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/'),
(492, 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets', NULL),
(493, 'http://my.local/magento/index.php/article/index/', NULL),
(494, 'http://my.local/magento/index.php/article/index/', NULL),
(495, 'http://my.local/magento/index.php/article/index/', NULL),
(496, 'http://my.local/magento/index.php/article/index/?status=available&category=Sports&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/'),
(497, 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets', NULL),
(498, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets'),
(499, 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets', NULL),
(500, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets'),
(501, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/'),
(502, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=-deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(503, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=-deadlineTime'),
(504, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(505, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(506, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(507, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/article/index/new'),
(508, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(509, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(510, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(511, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(512, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(513, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(514, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(515, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(516, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(517, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(518, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(519, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(520, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(521, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(522, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(523, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(524, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(525, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(526, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(527, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(528, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(529, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(530, 'http://my.local/magento/', NULL),
(531, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(532, 'http://my.local/magento/index.php/article/index/?status=available&category=Sports&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/'),
(533, 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets', NULL),
(534, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets'),
(535, 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets', NULL),
(536, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(537, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=Waiting&category=Sports&sorting=-totalBets'),
(538, 'http://my.local/magento/index.php/', NULL),
(539, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(540, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(541, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/'),
(542, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/help'),
(543, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/help'),
(544, 'http://my.local/magento/', NULL),
(545, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(546, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(547, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(548, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(549, 'http://my.local/magento/index.php/customer/account/index/', 'http://my.local/magento/index.php/customer/account/login/'),
(550, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/index/'),
(551, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(552, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(553, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(554, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(555, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(556, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(557, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(558, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(559, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(560, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(561, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(562, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(563, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(564, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(565, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(566, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(567, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(568, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(569, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(570, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(571, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(572, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(573, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/login/'),
(574, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(575, 'http://my.local/magento/index.php/customer/account/index/', 'http://my.local/magento/index.php/customer/account/login/'),
(576, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(577, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(578, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(579, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(580, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(581, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(582, 'http://my.local/magento/index.php/article/index/new', NULL),
(583, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(584, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(585, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(586, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(587, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(588, 'http://my.local/magento/index.php/article/index/thanhcong/', 'http://my.local/magento/index.php/article/index/new'),
(589, 'http://my.local/magento/index.php/article/index/thanhcong/', 'http://my.local/magento/index.php/article/index/new'),
(590, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/thanhcong/'),
(591, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(592, 'http://my.local/magento/index.php/article/index/thanhcong/', 'http://my.local/magento/index.php/article/index/new'),
(593, 'http://my.local/magento/index.php/article/index/thanhcong/', 'http://my.local/magento/index.php/article/index/new'),
(594, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/thanhcong/'),
(595, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/thanhcong/'),
(596, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(597, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(598, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/'),
(599, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(600, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(601, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(602, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(603, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(604, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(605, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(606, 'http://my.local/magento/index.php/article/index/', NULL),
(607, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(608, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(609, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(610, 'http://my.local/magento/index.php/customer/account/index/', 'http://my.local/magento/index.php/customer/account/login/'),
(611, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/customer/account/index/'),
(612, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(613, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(614, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(615, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(616, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(617, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(618, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(619, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(620, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(621, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(622, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(623, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(624, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(625, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(626, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(627, 'http://my.local/magento/index.php/article/index/?status=active&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/'),
(628, 'http://my.local/magento/index.php/article/index/?status=active&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=active&category=Science&order=total_bets'),
(629, 'http://my.local/magento/index.php/article/index/?status=active&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=active&category=Science&order=total_bets'),
(630, 'http://my.local/magento/index.php/article/index/?status=active&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=active&category=Technology&order=total_bets'),
(631, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=active&category=Politics&order=total_bets'),
(632, 'http://my.local/magento/index.php/article/index/?status=active&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=active&category=Technology&order=total_bets'),
(633, 'http://my.local/magento/index.php/article/index/?status=active&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=active&category=Technology&order=total_bets'),
(634, 'http://my.local/magento/index.php/article/index/?status=active&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=active&category=Politics&order=total_bets'),
(635, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=active&category=Science&order=total_bets'),
(636, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=active&category=Science&order=total_bets'),
(637, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(638, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(639, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(640, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(641, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(642, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(643, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(644, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(645, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(646, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(647, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(648, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(649, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(650, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=total_bets'),
(651, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=total_bets'),
(652, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(653, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(654, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/'),
(655, 'http://my.local/magento/index.php/article/index/?status=available&category=Economics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(656, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Economics&order=total_bets'),
(657, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(658, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(659, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=-deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(660, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=-deadlineTime'),
(661, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(662, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(663, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(664, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(665, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(666, 'http://my.local/magento/index.php/article/index/?status=available&category=Entertainment&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=total_bets'),
(667, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=Entertainment&order=total_bets'),
(668, 'http://my.local/magento/index.php/article/index/?status=waiting&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(669, 'http://my.local/magento/index.php/article/index/?status=waiting&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=Technology&order=total_bets'),
(670, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/?status=waiting&category=Science&order=total_bets'),
(671, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(672, 'http://my.local/magento/index.php/article/index/thanhcong/', 'http://my.local/magento/index.php/article/index/new'),
(673, 'http://my.local/magento/index.php/article/index/thanhcong/', 'http://my.local/magento/index.php/article/index/new'),
(674, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/thanhcong/'),
(675, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/'),
(676, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(677, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(678, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(679, 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(680, 'http://my.local/magento/index.php/article/index/?status=available&oder=', 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets'),
(681, 'http://my.local/magento/index.php/article/index/?status=available&oder=', 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets'),
(682, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime', 'http://my.local/magento/index.php/article/index/?status=available&oder='),
(683, 'http://my.local/magento/index.php/article/index/?status=available&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=deadlineTime'),
(684, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&oder='),
(685, 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(686, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets'),
(687, 'http://my.local/magento/index.php/article/index/?status=available&category=Sports%20&order=total_bets', 'http://my.local/magento/index.php/article/index/'),
(688, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Sports%20&order=total_bets'),
(689, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Sports%20&order=total_bets'),
(690, 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(691, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets'),
(692, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets'),
(693, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(694, 'http://my.local/magento/index.php/article/index/?status=available&category=All&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(695, 'http://my.local/magento/index.php/article/index/?status=available&category=All&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&sorting=-totalBets'),
(696, 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=All&oder='),
(697, 'http://my.local/magento/index.php/article/index/?status=waiting&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=All&oder='),
(698, 'http://my.local/magento/index.php/article/index/?status=waiting&oder=total_bets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=Science&order=total_bets'),
(699, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&oder=total_bets'),
(700, 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(701, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(702, 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(703, 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=All&sorting=totalBets'),
(704, 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=deadline_time'),
(705, 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-deadline_time'),
(706, 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-deadline_time'),
(707, 'http://my.local/magento/index.php/article/index/?status=available&category=All', 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-total_bets'),
(708, 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=All'),
(709, 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=deadline_time'),
(710, 'http://my.local/magento/index.php/article/index/?status=available&oder=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-deadline_time'),
(711, 'http://my.local/magento/index.php/article/index/?status=available&oder=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=All&order=-deadline_time'),
(712, 'http://my.local/magento/index.php/article/index/?status=available&category=&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&oder=-deadline_time'),
(713, 'http://my.local/magento/index.php/article/index/?status=available&category=', 'http://my.local/magento/index.php/article/index/?status=available&category=&order=-deadline_time'),
(714, 'http://my.local/magento/index.php/article/index/?status=available&category=', 'http://my.local/magento/index.php/article/index/?status=available&category='),
(715, 'http://my.local/magento/index.php/article/index/', NULL),
(716, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/'),
(717, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/'),
(718, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=-total_bets', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(719, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=-total_bets', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(720, 'http://my.local/magento/index.php/article/index/?status=&category=&oder=-total_bets', NULL),
(721, 'http://my.local/magento/index.php/article/index/?status=&category=&oder=total_bets', NULL),
(722, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/?status=&category=&oder=total_bets'),
(723, 'http://my.local/magento/index.php/article/index/?status=&category=', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(724, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/?status=&category='),
(725, 'http://my.local/magento/index.php/article/index/?status=&category=&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(726, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=deadline_time'),
(727, 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-deadline_time'),
(728, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-created_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time'),
(729, 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-created_time'),
(730, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time'),
(731, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(732, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(733, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(734, 'http://my.local/magento/index.php/article/index/index/', 'http://my.local/magento/index.php/article/index/new'),
(735, 'http://my.local/magento/index.php/article/index/index/', 'http://my.local/magento/index.php/article/index/new'),
(736, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(737, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(738, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(739, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(740, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(741, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(742, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(743, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/'),
(744, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/help'),
(745, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(746, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(747, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(748, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(749, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/'),
(750, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(751, 'http://my.local/magento/index.php/article/index/?status=&category=&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-deadline_time'),
(752, 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=deadline_time'),
(753, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-created_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time'),
(754, 'http://my.local/magento/index.php/article/index/?status=&category=&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-created_time'),
(755, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=deadline_time'),
(756, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=deadline_time'),
(757, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=deadline_time'),
(758, 'http://my.local/magento/index.php/article/index/?status=available&category=Entertainment&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=deadline_time'),
(759, 'http://my.local/magento/index.php/article/index/?status=available&category=Sports%20&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Entertainment&order=deadline_time'),
(760, 'http://my.local/magento/index.php/article/index/?status=available&category=Other&order=deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Sports%20&order=deadline_time'),
(761, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/?status=available&category=Other&order=deadline_time'),
(762, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/help'),
(763, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(764, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(765, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(766, 'http://my.local/magento/index.php/customer/address/edit/', 'http://my.local/magento/index.php/customer/account/'),
(767, 'http://my.local/magento/index.php/customer/address/edit/', 'http://my.local/magento/index.php/customer/account/'),
(768, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(769, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(770, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(771, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(772, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(773, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(774, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(775, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(776, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(777, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(778, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(779, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(780, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(781, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/help'),
(782, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(783, 'http://my.local/magento/', NULL),
(784, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(785, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/'),
(786, 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(787, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=available&oder=total_bets'),
(788, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=-total_bets', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=total_bets'),
(789, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=-total_bets'),
(790, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/'),
(791, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/'),
(792, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login'),
(793, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login'),
(794, 'http://my.local/magento/index.php/article', NULL),
(795, 'http://my.local/magento/index.php/customer/account/login', 'http://my.local/magento/index.php/article'),
(796, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(797, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/'),
(798, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(799, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(800, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(801, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(802, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(803, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(804, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(805, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(806, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article'),
(807, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(808, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(809, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(810, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/edit/'),
(811, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/edit/'),
(812, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(813, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(814, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(815, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(816, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(817, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(818, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(819, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(820, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(821, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/edit/'),
(822, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(823, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(824, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(825, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/'),
(826, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(827, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/edit/'),
(828, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(829, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(830, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(831, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(832, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(833, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(834, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(835, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(836, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(837, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/');
INSERT INTO `log_url_info` (`url_id`, `url`, `referer`) VALUES
(838, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(839, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(840, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(841, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(842, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(843, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(844, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(845, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(846, 'http://my.local/magento/index.php/article/index/index/', 'http://my.local/magento/index.php/article/index/new'),
(847, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(848, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(849, 'http://my.local/magento/index.php/article/index/index/', 'http://my.local/magento/index.php/article/index/new'),
(850, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(851, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(852, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(853, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(854, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Cancel.png', 'http://my.local/magento/index.php/article/index/new'),
(855, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(856, 'http://my.local/magento/index.php/article/index/new', NULL),
(857, 'http://my.local/magento/index.php/article/index/new', NULL),
(858, 'http://my.local/magento/index.php/article/index/new', NULL),
(859, 'http://my.local/magento/index.php/article/index/new', NULL),
(860, 'http://my.local/magento/index.php/article/index/new', NULL),
(861, 'http://my.local/magento/index.php/article/index/new', NULL),
(862, 'http://my.local/magento/index.php/article/index/new', NULL),
(863, 'http://my.local/magento/index.php/article/index/new', NULL),
(864, 'http://my.local/magento/index.php/article/index/new', NULL),
(865, 'http://my.local/magento/index.php/article/index/new', NULL),
(866, 'http://my.local/magento/index.php/article/index/new', NULL),
(867, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(868, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(869, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(870, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(871, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(872, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(873, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(874, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(875, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(876, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(877, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(878, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(879, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(880, 'http://my.local/magento/index.php/article/index/new', NULL),
(881, 'http://my.local/magento/index.php/article/index/new', NULL),
(882, 'http://my.local/magento/index.php/article/index/new', NULL),
(883, 'http://my.local/magento/index.php/article/index/new', NULL),
(884, 'http://my.local/magento/index.php/article/index/new', NULL),
(885, 'http://my.local/magento/index.php/article/index/new', NULL),
(886, 'http://my.local/magento/index.php/article/index/new', NULL),
(887, 'http://my.local/magento/index.php/article/index/new', NULL),
(888, 'http://my.local/magento/index.php/article/index/new', NULL),
(889, 'http://my.local/magento/', NULL),
(890, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(891, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(892, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(893, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(894, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(895, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(896, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(897, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(898, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(899, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(900, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(901, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(902, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(903, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(904, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(905, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(906, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(907, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(908, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(909, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(910, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(911, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(912, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(913, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(914, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(915, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(916, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(917, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(918, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(919, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(920, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(921, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(922, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(923, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(924, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(925, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(926, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(927, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(928, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(929, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(930, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(931, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(932, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(933, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(934, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(935, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(936, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(937, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(938, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(939, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(940, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(941, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(942, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(943, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(944, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(945, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(946, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(947, 'http://my.local/magento/', NULL),
(948, 'http://my.local/magento/', NULL),
(949, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(950, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(951, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(952, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(953, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(954, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(955, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(956, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(957, 'http://my.local/magento/index.php/article/index/new/', 'http://my.local/magento/'),
(958, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(959, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(960, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(961, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(962, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(963, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(964, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(965, 'http://my.local/magento/js/custom/jquery-1.5.1.js', 'http://my.local/magento/index.php/article/index/new'),
(966, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(967, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(968, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(969, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(970, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(971, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(972, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(973, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(974, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(975, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(976, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/'),
(977, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(978, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(979, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(980, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(981, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(982, 'http://my.local/magento/skin/frontend/default/bob/css/h80.png', 'http://my.local/magento/index.php/article/index/new'),
(983, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(984, 'http://my.local/magento/skin/frontend/default/bob/css/h80.png', 'http://my.local/magento/index.php/article/index/new'),
(985, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(986, 'http://my.local/magento/skin/frontend/default/bob/css/h80.png', 'http://my.local/magento/index.php/article/index/new'),
(987, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(988, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(989, 'http://my.local/magento/skin/frontend/default/bob/css/h80.png', 'http://my.local/magento/index.php/article/index/new'),
(990, 'http://my.local/magento/skin/frontend/default/bob/css/h80.png', NULL),
(991, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(992, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(993, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(994, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(995, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(996, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(997, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(998, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(999, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1000, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1001, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1002, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1003, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1004, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1005, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1006, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1007, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1008, 'http://my.local/magento/index.php/article/index/new', NULL),
(1009, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1010, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1011, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1012, 'http://my.local/magento/js/custom/jquery-1.8.2.min.js', 'http://my.local/magento/index.php/article/index/new'),
(1013, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1014, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1015, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1016, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1017, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1018, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1019, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1020, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1021, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1022, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1023, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1024, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1025, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1026, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1027, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1028, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(1029, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/help'),
(1030, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(1031, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1032, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/new'),
(1033, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1034, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1035, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1036, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1037, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1038, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1039, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1040, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1041, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1042, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1043, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1044, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1045, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1046, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(1047, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(1048, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(1049, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1050, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1051, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1052, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1053, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1054, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1055, 'http://my.local/magento/index.php/article/index/index/', 'http://my.local/magento/index.php/article/index/new'),
(1056, 'http://my.local/magento/index.php/article/index/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/index/'),
(1057, 'http://my.local/magento/index.php/article/index/index/?status=&category=&order=-deadline_time', 'http://my.local/magento/index.php/article/index/index/?status=&category=&order=-total_bets'),
(1058, 'http://my.local/magento/index.php/article/index/index/?status=&category=&order=deadline_time', 'http://my.local/magento/index.php/article/index/index/?status=&category=&order=-deadline_time'),
(1059, 'http://my.local/magento/index.php/article/index/index/?status=&category=', 'http://my.local/magento/index.php/article/index/index/?status=&category=&order=deadline_time'),
(1060, 'http://my.local/magento/index.php/article/index/index/', NULL),
(1061, 'http://my.local/magento/index.php/article/index/index/', NULL),
(1062, 'http://my.local/magento/index.php/article/index/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/index/'),
(1063, 'http://my.local/magento/index.php/article/index/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=waiting&category=&oder='),
(1064, 'http://my.local/magento/index.php/article/index/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=closed&category=&oder='),
(1065, 'http://my.local/magento/index.php/article/index/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=available&category=&oder='),
(1066, 'http://my.local/magento/index.php/article/index/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=closed&category=&oder='),
(1067, 'http://my.local/magento/index.php/article/index/index/?status=available&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/index/?status=available&category=&oder='),
(1068, 'http://my.local/magento/index.php/article/index/index/?status=available&oder=total_bets', 'http://my.local/magento/index.php/article/index/index/?status=available&category=Technology&order=total_bets'),
(1069, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/index/?status=available&oder=total_bets'),
(1070, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(1071, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1072, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(1073, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1074, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-created_time', 'http://my.local/magento/index.php/article/index/'),
(1075, 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-created_time'),
(1076, 'http://my.local/magento/index.php/article/index/?status=&category=', 'http://my.local/magento/index.php/article/index/?status=&category=&order=created_time'),
(1077, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/?status=&category='),
(1078, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/?status=&category='),
(1079, 'http://my.local/magento/index.php/article/index/new', NULL),
(1080, 'http://my.local/magento/index.php/article/index/new', NULL),
(1081, 'http://my.local/magento/index.php/article/index/new', NULL),
(1082, 'http://my.local/magento/index.php/', NULL),
(1083, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1084, 'http://my.local/magento/index.php/article/index/new', NULL),
(1085, 'http://my.local/magento/index.php/article/index/new', NULL),
(1086, 'http://my.local/magento/index.php/article/index/new', NULL),
(1087, 'http://my.local/magento/index.php/article/index/new', NULL),
(1088, 'http://my.local/magento/index.php/article/index/new', NULL),
(1089, 'http://my.local/magento/index.php/article/index/new', NULL),
(1090, 'http://my.local/magento/index.php/article/index/new', NULL),
(1091, 'http://my.local/magento/index.php/article/index/new', NULL),
(1092, 'http://my.local/magento/index.php/article/index/new', NULL),
(1093, 'http://my.local/magento/index.php/article/index/new', NULL),
(1094, 'http://my.local/magento/index.php/article/index/new', NULL),
(1095, 'http://my.local/magento/index.php/article/index/new', NULL),
(1096, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1097, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1098, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1099, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1100, 'http://my.local/magento/js/custom/jquery-1.7.2.js', 'http://my.local/magento/index.php/article/index/new'),
(1101, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1102, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1103, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1104, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1105, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1106, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1107, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1108, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1109, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1110, 'http://my.local/magento/index.php/article/index/new', NULL),
(1111, 'http://my.local/magento/index.php/article/index/new', NULL),
(1112, 'http://my.local/magento/index.php/article/index/new', NULL),
(1113, 'http://my.local/magento/index.php/article/index/new', NULL),
(1114, 'http://my.local/magento/index.php/article/index/new', NULL),
(1115, 'http://my.local/magento/index.php/article/index/new', NULL),
(1116, 'http://my.local/magento/index.php/article/index/new', NULL),
(1117, 'http://my.local/magento/index.php/article/index/new', NULL),
(1118, 'http://my.local/magento/index.php/article/index/new', NULL),
(1119, 'http://my.local/magento/index.php/article/index/new', NULL),
(1120, 'http://my.local/magento/skin/frontend/base/default/css/jquery-ui-1.9.1.custom.min.css.css', 'http://my.local/magento/index.php/article/index/new'),
(1121, 'http://my.local/magento/index.php/article/index/new', NULL),
(1122, 'http://my.local/magento/index.php/article/index/new', NULL),
(1123, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1124, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1125, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_d8e7f3_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1126, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_flat_55_fbec88_40x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1127, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_85_dfeffc_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1128, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_75_d0e5f5_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1129, 'http://my.local/magento/index.php/article/index/new', NULL),
(1130, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_f5f8f9_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1131, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_217bc0_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1132, 'http://my.local/magento/index.php/article/index/new', NULL),
(1133, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1134, 'http://my.local/magento/index.php/article/index/new', NULL),
(1135, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1136, 'http://my.local/magento/index.php/article/index/new', NULL),
(1137, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1138, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1139, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_flat_55_fbec88_40x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1140, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_75_d0e5f5_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1141, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_d8e7f3_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1142, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_85_dfeffc_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1143, 'http://my.local/magento/index.php/article/index/new', NULL),
(1144, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1145, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_85_dfeffc_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1146, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_d8e7f3_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1147, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1148, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_75_d0e5f5_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1149, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_flat_55_fbec88_40x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1150, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_f5f8f9_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1151, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_217bc0_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1152, 'http://my.local/magento/index.php/article/index/new', NULL),
(1153, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1154, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_85_dfeffc_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1155, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1156, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_d8e7f3_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1157, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_flat_55_fbec88_40x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1158, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_75_d0e5f5_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1159, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_217bc0_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1160, 'http://my.local/magento/index.php/article/index/new', NULL),
(1161, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1162, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1163, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_d8e7f3_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1164, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_85_dfeffc_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1165, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_flat_55_fbec88_40x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1166, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_75_d0e5f5_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1167, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_217bc0_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1168, 'http://my.local/magento/index.php/article/index/new', NULL),
(1169, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1170, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-icons_d8e7f3_256x240.png', 'http://my.local/magento/index.php/article/index/new'),
(1171, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_75_d0e5f5_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1172, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1173, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_flat_55_fbec88_40x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1174, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_85_dfeffc_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1175, 'http://my.local/magento/index.php/article/index/new', NULL),
(1176, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_inset-hard_100_fcfdfd_1x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1177, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_flat_55_fbec88_40x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1178, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png', 'http://my.local/magento/index.php/article/index/new'),
(1179, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_75_d0e5f5_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1180, 'http://my.local/magento/skin/frontend/default/bob/css/images/ui-bg_glass_85_dfeffc_1x400.png', 'http://my.local/magento/index.php/article/index/new'),
(1181, 'http://my.local/magento/index.php/article/index/new', NULL),
(1182, 'http://my.local/magento/index.php/article/index/new', NULL),
(1183, 'http://my.local/magento/index.php/article/index/new', NULL),
(1184, 'http://my.local/magento/index.php/article/index/new', NULL),
(1185, 'http://my.local/magento/index.php/article/index/new', NULL),
(1186, 'http://my.local/magento/index.php/article/index/new', NULL),
(1187, 'http://my.local/magento/index.php/article/index/new', NULL),
(1188, 'http://my.local/magento/index.php/article/index/new', NULL),
(1189, 'http://my.local/magento/index.php/article/index/new', NULL),
(1190, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1191, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1192, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1193, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1194, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1195, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1196, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1197, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1198, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1199, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1200, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1201, 'http://my.local/magento/index.php/', NULL),
(1202, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1203, 'http://my.local/magento/index.php/article/index/item?id=5', NULL),
(1204, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=5'),
(1205, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/item?id=5'),
(1206, 'http://my.local/magento/index.php/article/index/item?id=5', NULL),
(1207, 'http://my.local/magento/index.php/article/index/item?id=3', NULL),
(1208, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=3'),
(1209, 'http://my.local/magento/index.php/article/index/item?id=3', NULL),
(1210, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=3'),
(1211, 'http://my.local/magento/index.php/article/index/item?id=3', NULL),
(1212, 'http://my.local/magento/index.php/article/index/item?id=2', NULL),
(1213, 'http://my.local/magento/index.php/article/index/item?id=3', NULL),
(1214, 'http://my.local/magento/index.php/article/index/item?id=5', NULL),
(1215, 'http://my.local/magento/index.php/article/index/item?id=5', NULL),
(1216, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=5'),
(1217, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/item?id=5'),
(1218, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/item?id=5'),
(1219, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1220, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1221, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1222, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/article/index/new'),
(1223, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/article/index/new'),
(1224, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1225, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1226, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(1227, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1228, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/login/'),
(1229, 'http://my.local/magento/index.php/article/index/item?id=4/', 'http://my.local/magento/index.php/article/index/'),
(1230, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=4/'),
(1231, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/login/'),
(1232, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1233, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1234, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/login/'),
(1235, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/article/index/new'),
(1236, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/article/index/new'),
(1237, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1238, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/article/index/new'),
(1239, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1240, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(1241, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1242, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1243, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/'),
(1244, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(1245, 'http://my.local/magento/index.php/article/index/', NULL),
(1246, 'http://my.local/magento/index.php/article/index/item', NULL),
(1247, 'http://my.local/magento/index.php/article/index/', NULL),
(1248, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=999'),
(1249, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=999'),
(1250, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=999'),
(1251, 'http://my.local/magento/index.php/article/index/item?id=999', NULL),
(1252, 'http://my.local/magento/index.php/article/index/', NULL),
(1253, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=999'),
(1254, 'http://my.local/magento/index.php/article/index/item?id=999', NULL),
(1255, 'http://my.local/magento/index.php/article/index/', NULL),
(1256, 'http://my.local/magento/index.php/article/index/item?id=4/', 'http://my.local/magento/index.php/article/index/'),
(1257, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1258, 'http://my.local/magento/index.php/article/index/item?id=5/', 'http://my.local/magento/index.php/article/index/'),
(1259, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=5/'),
(1260, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1261, 'http://my.local/magento/index.php/article/index/', NULL),
(1262, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=999'),
(1263, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=999'),
(1264, 'http://my.local/magento/index.php/article/index/item?id=999', NULL),
(1265, 'http://my.local/magento/index.php/article/index/', NULL),
(1266, 'http://my.local/magento/index.php/article/index/item?id=5', NULL),
(1267, 'http://my.local/magento/index.php/article/index/', NULL),
(1268, 'http://my.local/magento/index.php/article/index/item?id=dfsfd', NULL),
(1269, 'http://my.local/magento/index.php/article/index/', NULL),
(1270, 'http://my.local/magento/index.php/article/index/', NULL),
(1271, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(1272, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/'),
(1273, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1274, 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets', 'http://my.local/magento/index.php/article/index/'),
(1275, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/?status=available&category=Science&order=total_bets'),
(1276, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1277, 'http://my.local/magento/index.php/article/index/index/', 'http://my.local/magento/index.php/article/index/new'),
(1278, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/index/'),
(1279, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1280, 'http://my.local/magento/index.php/article/index/index/', 'http://my.local/magento/index.php/article/index/new'),
(1281, 'http://my.local/magento/index.php/article/index/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/index/'),
(1282, 'http://my.local/magento/index.php/article/index/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=waiting&category=&oder='),
(1283, 'http://my.local/magento/index.php/article/index/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=closed&category=&oder='),
(1284, 'http://my.local/magento/index.php/article/index/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=closed&category=&oder='),
(1285, 'http://my.local/magento/index.php/article/index/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/index/?status=waiting&category=&oder='),
(1286, 'http://my.local/magento/index.php/article/index/index/?status=available&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/index/?status=available&category=&oder='),
(1287, 'http://my.local/magento/index.php/article/index/index/?status=available&category=&order=-deadline_time', 'http://my.local/magento/index.php/article/index/index/?status=available&category=&order=-total_bets'),
(1288, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/index/?status=available&category=&order=-deadline_time'),
(1289, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/help'),
(1290, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(1291, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1292, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/'),
(1293, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/help'),
(1294, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/help'),
(1295, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1296, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(1297, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1298, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(1299, 'http://my.local/magento/index.php/catalogsearch/result/?q=fddfgdfg', 'http://my.local/magento/index.php/'),
(1300, 'http://my.local/magento/index.php/', NULL),
(1301, 'http://my.local/magento/index.php/catalogsearch/result/?q=ioiuouio', 'http://my.local/magento/index.php/'),
(1302, 'http://my.local/magento/index.php/', NULL),
(1303, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(1304, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1305, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/');
INSERT INTO `log_url_info` (`url_id`, `url`, `referer`) VALUES
(1306, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1307, 'http://my.local/magento/index.php/', NULL),
(1308, 'http://my.local/magento/index.php/', NULL),
(1309, 'http://my.local/magento/index.php/', NULL),
(1310, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/'),
(1311, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1312, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1313, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1314, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1315, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1316, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/'),
(1317, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1318, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1319, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1320, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1321, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1322, 'http://my.local/magento/index.php/article/index/item?id=2/', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1323, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1324, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1325, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1326, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1327, 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1328, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(1329, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1330, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1331, 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1332, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(1333, 'http://my.local/magento/index.php/article/index/?status=waiting&category=Technology&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1334, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&oder=total_bets', 'http://my.local/magento/index.php/article/index/?status=waiting&category=Technology&order=total_bets'),
(1335, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&oder=total_bets'),
(1336, 'http://my.local/magento/index.php/article/index/?status=available&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&oder='),
(1337, 'http://my.local/magento/index.php/article/index/?status=available&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&oder='),
(1338, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=available&oder='),
(1339, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/'),
(1340, 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1341, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(1342, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1343, 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1344, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(1345, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1346, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1347, 'http://my.local/magento/index.php/article/index/item?id=10/', 'http://my.local/magento/index.php/article/index/'),
(1348, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1349, 'http://my.local/magento/index.php/article/index/item?id=2/', 'http://my.local/magento/index.php/article/index/'),
(1350, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1351, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1352, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1353, 'http://my.local/magento/index.php/article/index/item?id=3/', 'http://my.local/magento/index.php/article/index/'),
(1354, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1355, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1356, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1357, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1358, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1359, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1360, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1361, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1362, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1363, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1364, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1365, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1366, 'http://my.local/magento/index.php/article/index/item?id=1/', 'http://my.local/magento/index.php/article/index/'),
(1367, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1368, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1369, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=9/'),
(1370, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1371, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=9/'),
(1372, 'http://my.local/magento/index.php/article/index/item?id=0/', NULL),
(1373, 'http://my.local/magento/index.php/article/index/item?id=0/', NULL),
(1374, 'http://my.local/magento/index.php/article/index/item?id=0/', NULL),
(1375, 'http://my.local/magento/index.php/article/index/', NULL),
(1376, 'http://my.local/magento/index.php/article/index/item?id=9/', 'http://my.local/magento/index.php/article/index/'),
(1377, 'http://my.local/magento/index.php/article/index/item?id=vjgjghj/', NULL),
(1378, 'http://my.local/magento/index.php/article/index/', NULL),
(1379, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1380, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1381, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(1382, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1383, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/'),
(1384, 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1385, 'http://my.local/magento/index.php/article/index/?status=closed&category=Politics&order=total_bets', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(1386, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&oder=total_bets', 'http://my.local/magento/index.php/article/index/?status=closed&category=Politics&order=total_bets'),
(1387, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&oder=total_bets'),
(1388, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&oder=total_bets'),
(1389, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&oder=total_bets'),
(1390, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&oder=total_bets'),
(1391, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&oder=total_bets'),
(1392, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&oder=total_bets'),
(1393, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(1394, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1395, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1396, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1397, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1398, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1399, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1400, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1401, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1402, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1403, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1404, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1405, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1406, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1407, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1408, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1409, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1410, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1411, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(1412, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1413, 'http://my.local/magento/index.php/', NULL),
(1414, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(1415, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/'),
(1416, 'http://my.local/magento/index.php/', NULL),
(1417, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1418, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/'),
(1419, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1420, 'http://my.local/magento/index.php/', NULL),
(1421, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(1422, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1423, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(1424, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(1425, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/'),
(1426, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/'),
(1427, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1428, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1429, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1430, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1431, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1432, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1433, 'http://my.local/magento/index.php/custommer/account/', 'http://my.local/magento/index.php/'),
(1434, 'http://my.local/magento/index.php/custommer/account/create', NULL),
(1435, 'http://my.local/magento/index.php/custommer/account/register', NULL),
(1436, 'http://my.local/magento/index.php/customer/account/register', NULL),
(1437, 'http://my.local/magento/index.php/customer/account/create', NULL),
(1438, 'http://my.local/magento/index.php/customer/account/createpost/', 'http://my.local/magento/index.php/customer/account/create'),
(1439, 'http://my.local/magento/index.php/customer/account/index/', 'http://my.local/magento/index.php/customer/account/create'),
(1440, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(1441, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/index/'),
(1442, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/article/index/new'),
(1443, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/article/index/new'),
(1444, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1445, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(1446, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1447, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1448, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1449, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1450, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1451, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1452, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1453, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1454, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1455, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1456, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1457, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1458, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1459, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1460, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1461, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(1462, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(1463, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1464, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1465, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1466, 'http://my.local/magento/index.php/article/index/new', NULL),
(1467, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1468, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1469, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/'),
(1470, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1471, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1472, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1473, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1474, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1475, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1476, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(1477, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1478, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1479, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1480, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1481, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1482, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(1483, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1484, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1485, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1486, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1487, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1488, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1489, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1490, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1491, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1492, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1493, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1494, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1495, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1496, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1497, 'http://my.local/magento/', NULL),
(1498, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(1499, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1500, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1501, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1502, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1503, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1504, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1505, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1506, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1507, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1508, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1509, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1510, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1511, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/customer/account/'),
(1512, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/new'),
(1513, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1514, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1515, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1516, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1517, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1518, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1519, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1520, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1521, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1522, 'http://my.local/magento/index.php/article/index/', NULL),
(1523, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1524, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1525, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1526, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1527, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1528, 'http://my.local/magento/index.php/article/index/', NULL),
(1529, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1530, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1531, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1532, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1533, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1534, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1535, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1536, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1537, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1538, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/'),
(1539, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/'),
(1540, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1541, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1542, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1543, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1544, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1545, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1546, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1547, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1548, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1549, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1550, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1551, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1552, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1553, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1554, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1555, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1556, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1557, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1558, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/'),
(1559, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/'),
(1560, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1561, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1562, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1563, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1564, 'http://my.local/magento/index.php/', NULL),
(1565, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/'),
(1566, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1567, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1568, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1569, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1570, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1571, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1572, 'http://my.local/magento/', NULL),
(1573, 'http://my.local/magento/', NULL),
(1574, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/'),
(1575, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/'),
(1576, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1577, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1578, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1579, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1580, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1581, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1582, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(1583, 'http://my.local/magento/index.php/', NULL),
(1584, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1585, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(1586, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(1587, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/'),
(1588, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/'),
(1589, 'http://my.local/magento/index.php/', NULL),
(1590, 'http://my.local/magento/index.php/', NULL),
(1591, 'http://my.local/magento/index.php/', NULL),
(1592, 'http://my.local/magento/index.php/', NULL),
(1593, 'http://my.local/magento/index.php/', NULL),
(1594, 'http://my.local/magento/index.php/', NULL),
(1595, 'http://my.local/magento/index.php/', NULL),
(1596, 'http://my.local/magento/index.php/', NULL),
(1597, 'http://my.local/magento/index.php/', NULL),
(1598, 'http://my.local/magento/index.php/', NULL),
(1599, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1600, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(1601, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(1602, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/'),
(1603, 'http://my.local/magento/items/', NULL),
(1604, 'http://my.local/magento/', NULL),
(1605, 'http://my.local/magento/index.php/article/index/item?id=15/', 'http://my.local/magento/'),
(1606, 'http://my.local/magento/skin/frontend/default/bob/img/knobs-icons/Knob%20Download.png', 'http://my.local/magento/index.php/article/index/item?id=15/'),
(1607, 'http://my.local/magento/', NULL),
(1608, 'http://my.local/magento/', NULL),
(1609, 'http://my.local/magento/', NULL),
(1610, 'http://my.local/magento/', NULL),
(1611, 'http://my.local/magento/', NULL),
(1612, 'http://my.local/magento/', NULL),
(1613, 'http://my.local/magento/', NULL),
(1614, 'http://my.local/magento/', NULL),
(1615, 'http://my.local/magento/', NULL),
(1616, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/'),
(1617, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1618, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1619, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/customer/account/'),
(1620, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1621, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/article/index/'),
(1622, 'http://my.local/magento/index.php/', 'http://my.local/magento/index.php/article/index/new'),
(1623, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1624, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/new'),
(1625, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(1626, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(1627, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1628, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/new'),
(1629, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1630, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1631, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1632, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1633, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1634, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1635, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1636, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1637, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1638, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/login/'),
(1639, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1640, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1641, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1642, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1643, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1644, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1645, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1646, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1647, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1648, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1649, 'http://my.local/magento/index.php/customer/account/edit/', NULL),
(1650, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1651, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1652, 'http://my.local/magento/index.php/customer/account/edit/change_password', NULL),
(1653, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/change_password'),
(1654, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/change_password'),
(1655, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1656, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1657, 'http://my.local/magento/index.php/customer/account/edit/', NULL),
(1658, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1659, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1660, 'http://my.local/magento/index.php/customer/account/edit/', NULL),
(1661, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1662, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1663, 'http://my.local/magento/index.php/customer/account/logout/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1664, 'http://my.local/magento/index.php/customer/account/logoutSuccess/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1665, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/logoutSuccess/'),
(1666, 'http://my.local/magento/index.php/customer/account/loginPost/', 'http://my.local/magento/index.php/customer/account/login/'),
(1667, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/login/'),
(1668, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1669, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1670, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1671, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1672, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1673, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1674, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1675, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1676, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1677, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1678, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1679, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1680, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1681, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1682, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1683, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1684, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1685, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1686, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1687, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1688, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1689, 'http://my.local/magento/index.php/customer/account/edit/changepass/1/', 'http://my.local/magento/index.php/customer/account/'),
(1690, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1691, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/changepass/1/'),
(1692, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1693, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1694, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1695, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1696, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1697, 'http://my.local/magento/index.php/customer/account/editPost/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1698, 'http://my.local/magento/index.php/customer/account/edit/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1699, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/edit/'),
(1700, 'http://my.local/magento/index.php/customer/account/login/', 'http://my.local/magento/index.php/article/index/'),
(1701, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1702, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1703, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1704, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/customer/account/'),
(1705, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/'),
(1706, 'http://my.local/magento/index.php/article/index/?status=&category=', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(1707, 'http://my.local/magento/index.php/article/index/?status=&category=', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(1708, 'http://my.local/magento/index.php/article/index/?status=&category=', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(1709, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=&category='),
(1710, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=&category='),
(1711, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1712, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1713, 'http://my.local/magento/index.php/catalog/category/view/', 'http://my.local/magento/index.php/article/index/'),
(1714, 'http://my.local/magento/index.php/catalog/category/view/', 'http://my.local/magento/index.php/article/index/'),
(1715, 'http://my.local/magento/index.php/catalog/category/view/', 'http://my.local/magento/index.php/article/index/'),
(1716, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1717, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1718, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1719, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1720, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1721, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1722, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets', 'http://my.local/magento/index.php/article/index/'),
(1723, 'http://my.local/magento/index.php/article/index/?status=&category=&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-total_bets'),
(1724, 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=&category=&order=-deadline_time'),
(1725, 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Technology&order=-deadline_time'),
(1726, 'http://my.local/magento/index.php/article/index/?status=available&category=Economics&order=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Politics&order=-deadline_time'),
(1727, 'http://my.local/magento/index.php/article/index/?status=available&oder=-deadline_time', 'http://my.local/magento/index.php/article/index/?status=available&category=Economics&order=-deadline_time'),
(1728, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&oder=-deadline_time'),
(1729, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&oder=-deadline_time');
INSERT INTO `log_url_info` (`url_id`, `url`, `referer`) VALUES
(1730, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1731, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1732, 'http://my.local/magento/index.php/help', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1733, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/help'),
(1734, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/new'),
(1735, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/'),
(1736, 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1737, 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=closed&category=&oder='),
(1738, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1739, 'http://my.local/magento/index.php/article/index/?status=available&category=&oder=', 'http://my.local/magento/index.php/article/index/?status=waiting&category=&oder='),
(1740, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/?status=available&category=&oder='),
(1741, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1742, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1743, 'http://my.local/magento/index.php/customer/account/', 'http://my.local/magento/index.php/article/index/'),
(1744, 'http://my.local/magento/index.php/article/index/', NULL),
(1745, 'http://my.local/magento/index.php/', NULL),
(1746, 'http://my.local/magento/index.php/customer/account/', NULL),
(1747, 'http://my.local/magento/index.php/', NULL),
(1748, 'http://my.local/magento/index.php/article/index/success', NULL),
(1749, 'http://my.local/magento/index.php/article/index/success', NULL),
(1750, 'http://my.local/magento/index.php/', NULL),
(1751, 'http://my.local/magento/index.php/article/index/new', 'http://my.local/magento/index.php/'),
(1752, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1753, 'http://my.local/magento/index.php/', NULL),
(1754, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1755, 'http://my.local/magento/index.php/article/index/item?id=1/', 'http://my.local/magento/index.php/article/index/'),
(1756, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/article/index/'),
(1757, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/'),
(1758, 'http://my.local/magento/index.php/article/index/', 'http://my.local/magento/index.php/');

-- --------------------------------------------------------

--
-- Table structure for table `log_visitor`
--

CREATE TABLE IF NOT EXISTS `log_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Last Visit Time',
  `last_url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Last URL ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Log Visitors Table' AUTO_INCREMENT=40 ;

--
-- Dumping data for table `log_visitor`
--

INSERT INTO `log_visitor` (`visitor_id`, `session_id`, `first_visit_at`, `last_visit_at`, `last_url_id`, `store_id`) VALUES
(1, 'vi5j00h4hfvus0j5jq82p67md3', '2013-04-10 00:34:37', '2013-04-10 00:34:40', 1, 1),
(2, '07r5f4gl1ib6lg5dg55cvkfau3', '2013-04-10 19:12:59', '2013-04-10 20:14:54', 11, 1),
(3, '04u5tjr1pqt1ap9flgg6k0on90', '2013-04-11 01:41:56', '2013-04-11 03:21:53', 18, 1),
(4, '6vmdb4ke7ovp57k7r6fc1q9md6', '2013-04-11 19:17:28', '2013-04-11 21:45:49', 182, 1),
(5, 'b10iefa163tbm2jbvakap6a512', '2013-04-11 21:04:57', '2013-04-11 21:04:58', 162, 1),
(6, 'mse7bbu0j2o7d73p0ns4eekle7', '2013-04-11 21:46:07', '2013-04-11 21:54:03', 194, 1),
(7, '76d6u97g4g77uohg6sa0n8nkg5', '2013-04-11 21:54:05', '2013-04-11 21:56:27', 204, 1),
(8, '8737d98epfhteq8r8niujhe312', '2013-04-11 21:56:29', '2013-04-11 22:02:55', 214, 1),
(9, 'cif5t6a8555evdrv0gt6fjldi5', '2013-04-11 22:02:57', '2013-04-12 03:36:52', 355, 1),
(10, 'ahkcmbd2dsh9uchrgl18qmtoo3', '2013-04-11 22:28:12', '2013-04-11 22:28:14', 237, 1),
(11, '8gght04hb31ng3s2vrvm0kg1t0', '2013-04-11 22:31:48', '2013-04-11 22:31:49', 238, 1),
(12, '01mngnefirm9gofm056upu3t73', '2013-04-11 22:32:04', '2013-04-11 22:32:05', 239, 1),
(13, 'h72diugvvl3hsnqqm6lp6cbq55', '2013-04-12 03:37:20', '2013-04-12 04:02:23', 372, 1),
(14, 'erqkn97r6h2327kg85u1160gt2', '2013-04-14 19:08:21', '2013-04-15 03:50:24', 529, 1),
(15, 'iitemhe8phpn11en7rh4oakhu5', '2013-04-15 19:12:44', '2013-04-15 21:48:16', 569, 1),
(16, 'j1ftktuc0pnkh34qptojnq4m22', '2013-04-15 21:52:57', '2013-04-15 22:58:14', 605, 1),
(17, 'amh2tan2legnpslfnvplusoig5', '2013-04-16 00:07:10', '2013-04-16 00:07:10', 0, 1),
(18, 'amh2tan2legnpslfnvplusoig5', '2013-04-16 00:07:28', '2013-04-16 00:07:28', 0, 1),
(19, 'amh2tan2legnpslfnvplusoig5', '2013-04-16 00:07:32', '2013-04-16 00:07:32', 0, 1),
(20, 'amh2tan2legnpslfnvplusoig5', '2013-04-16 00:07:56', '2013-04-16 00:07:56', 0, 1),
(21, 'amh2tan2legnpslfnvplusoig5', '2013-04-16 00:08:18', '2013-04-16 00:08:18', 0, 1),
(22, 'ih3nl0mibb483vkrnskjs0vod2', '2013-04-16 00:12:50', '2013-04-16 03:52:33', 782, 1),
(23, 'srrput6sm9m93u4fp3p41npud6', '2013-04-16 19:14:48', '2013-04-17 00:11:47', 904, 1),
(24, 'k150dt9su53cm2jjcn0i0agom6', '2013-04-17 00:12:14', '2013-04-17 00:14:53', 957, 1),
(25, '34nmo4qaibi5oifv1k3d38fot6', '2013-04-17 00:15:37', '2013-04-17 03:27:54', 1081, 1),
(26, 'tucdb5a0d39uvog5hcu4gpvd92', '2013-04-17 01:04:37', '2013-04-17 01:04:37', 1008, 1),
(27, '0gcc59rh7crgrpkfflgv1godo4', '2013-04-17 19:37:45', '2013-04-17 22:30:59', 1199, 1),
(28, '035v7gbhk47peep3vnprr4b7u1', '2013-04-18 00:18:27', '2013-04-18 02:39:33', 1222, 1),
(29, 'k06tiv1abp58gbu74t2o6a8of6', '2013-04-18 02:39:34', '2013-04-18 02:47:32', 1235, 1),
(30, 'gtf42eqaadcih4gm4vnp8jfcg6', '2013-04-18 02:47:33', '2013-04-18 03:54:52', 1301, 1),
(31, '5602fuksperv1ubfnfn8m20to1', '2013-04-18 19:27:30', '2013-04-19 00:34:01', 1425, 1),
(32, 'rdu19j20bcnb3v1i486s6jkub7', '2013-04-19 00:34:04', '2013-04-19 01:10:33', 1442, 1),
(33, '1m52ilcve4aps3nquafoogcci1', '2013-04-19 01:10:35', '2013-04-19 01:42:09', 1496, 1),
(34, 'e6o7amumg0h9fja69310cgrfa3', '2013-04-21 19:23:40', '2013-04-21 20:32:25', 1563, 1),
(35, '8g9nkjk1ipemncokl5co2le065', '2013-04-21 20:37:44', '2013-04-21 20:37:44', 0, 1),
(36, 'i57d2ll97338kpbdda4sqrrlo5', '2013-04-21 20:37:57', '2013-04-22 00:11:03', 1634, 1),
(37, '9h0al6s574idv8dnav9ln42ad0', '2013-04-22 00:11:05', '2013-04-22 00:27:54', 1663, 1),
(38, 'jrokqo51nurk02d1ivdv5ef466', '2013-04-22 00:27:56', '2013-04-22 02:00:29', 1752, 1),
(39, 'f1um311dl3vbs6mfbu3nth8t43', '2013-04-22 03:28:55', '2013-04-22 03:36:15', 1758, 1);

-- --------------------------------------------------------

--
-- Table structure for table `log_visitor_info`
--

CREATE TABLE IF NOT EXISTS `log_visitor_info` (
  `visitor_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `http_referer` varchar(255) DEFAULT NULL COMMENT 'HTTP Referrer',
  `http_user_agent` varchar(255) DEFAULT NULL COMMENT 'HTTP User-Agent',
  `http_accept_charset` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Charset',
  `http_accept_language` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Language',
  `server_addr` bigint(20) DEFAULT NULL COMMENT 'Server Address',
  `remote_addr` bigint(20) DEFAULT NULL COMMENT 'Remote Address',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Info Table';

--
-- Dumping data for table `log_visitor_info`
--

INSERT INTO `log_visitor_info` (`visitor_id`, `http_referer`, `http_user_agent`, `http_accept_charset`, `http_accept_language`, `server_addr`, `remote_addr`) VALUES
(1, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(2, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(3, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(4, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(5, NULL, NULL, NULL, NULL, 2130706433, 2130706433),
(6, 'http://my.local/magento/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(7, 'http://my.local/magento/index.php/customer/account/index/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(8, 'http://my.local/magento/index.php/customer/account/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(9, 'http://my.local/magento/index.php/customer/account/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(10, NULL, NULL, NULL, NULL, 2130706433, 2130706433),
(11, NULL, NULL, NULL, NULL, 2130706433, 2130706433),
(12, NULL, NULL, NULL, NULL, 2130706433, 2130706433),
(13, 'http://my.local/magento/index.php/customer/account/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(14, 'http://my.local/magento/index.php/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(15, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(16, 'http://my.local/magento/index.php/article/index/new', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(17, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(18, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(19, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(20, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(21, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(22, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(23, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(24, 'http://my.local/magento/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(25, 'http://my.local/magento/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(26, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(27, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(28, 'http://my.local/magento/index.php/article/index/new', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(29, 'http://my.local/magento/index.php/article/index/new', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(30, 'http://my.local/magento/index.php/article/index/new', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(31, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(32, 'http://my.local/magento/index.php/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(33, 'http://my.local/magento/index.php/article/index/new', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(34, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(35, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(36, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(37, 'http://my.local/magento/index.php/customer/account/edit/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(38, 'http://my.local/magento/index.php/customer/account/edit/', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433),
(39, NULL, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'en-US,en;q=0.8', 2130706433, 2130706433);

-- --------------------------------------------------------

--
-- Table structure for table `log_visitor_online`
--

CREATE TABLE IF NOT EXISTS `log_visitor_online` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `visitor_type` varchar(1) NOT NULL COMMENT 'Visitor Type',
  `remote_addr` bigint(20) NOT NULL COMMENT 'Remote Address',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NULL DEFAULT NULL COMMENT 'Last Visit Time',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `last_url` varchar(255) DEFAULT NULL COMMENT 'Last URL',
  PRIMARY KEY (`visitor_id`),
  KEY `IDX_LOG_VISITOR_ONLINE_VISITOR_TYPE` (`visitor_type`),
  KEY `IDX_LOG_VISITOR_ONLINE_FIRST_VISIT_AT_LAST_VISIT_AT` (`first_visit_at`,`last_visit_at`),
  KEY `IDX_LOG_VISITOR_ONLINE_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Online Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_problem`
--

CREATE TABLE IF NOT EXISTS `newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_queue`
--

CREATE TABLE IF NOT EXISTS `newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template Id',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_queue_link`
--

CREATE TABLE IF NOT EXISTS `newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID` (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_queue_store_link`
--

CREATE TABLE IF NOT EXISTS `newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `IDX_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscriber`
--

CREATE TABLE IF NOT EXISTS `newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_template`
--

CREATE TABLE IF NOT EXISTS `newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_text_preprocessed` text COMMENT 'Template Text Preprocessed',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `IDX_NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `IDX_NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Template' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_consumer`
--

CREATE TABLE IF NOT EXISTS `oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` varchar(255) DEFAULT NULL COMMENT 'Callback URL',
  `rejected_callback_url` varchar(255) NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `IDX_OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `IDX_OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_nonce`
--

CREATE TABLE IF NOT EXISTS `oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  UNIQUE KEY `UNQ_OAUTH_NONCE_NONCE` (`nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='oauth_nonce';

-- --------------------------------------------------------

--
-- Table structure for table `oauth_token`
--

CREATE TABLE IF NOT EXISTS `oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` varchar(255) NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_TOKEN_TOKEN` (`token`),
  KEY `IDX_OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  KEY `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `paypal_cert`
--

CREATE TABLE IF NOT EXISTS `paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `IDX_PAYPAL_CERT_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `paypal_payment_transaction`
--

CREATE TABLE IF NOT EXISTS `paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `paypal_settlement_report`
--

CREATE TABLE IF NOT EXISTS `paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` timestamp NULL DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `UNQ_PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `paypal_settlement_report_row`
--

CREATE TABLE IF NOT EXISTS `paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT '' COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  PRIMARY KEY (`row_id`),
  KEY `IDX_PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `persistent_session`
--

CREATE TABLE IF NOT EXISTS `persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  KEY `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `poll`
--

CREATE TABLE IF NOT EXISTS `poll` (
  `poll_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Poll Id',
  `poll_title` varchar(255) DEFAULT NULL COMMENT 'Poll title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  `date_posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date posted',
  `date_closed` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  `active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is active',
  `closed` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is closed',
  `answers_display` smallint(6) DEFAULT NULL COMMENT 'Answers display',
  PRIMARY KEY (`poll_id`),
  KEY `IDX_POLL_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Poll' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `poll`
--

INSERT INTO `poll` (`poll_id`, `poll_title`, `votes_count`, `store_id`, `date_posted`, `date_closed`, `active`, `closed`, `answers_display`) VALUES
(1, 'What is your favorite color', 7, 0, '2013-04-10 07:26:15', NULL, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `poll_answer`
--

CREATE TABLE IF NOT EXISTS `poll_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Answer Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `answer_title` varchar(255) DEFAULT NULL COMMENT 'Answer title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `answer_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Answers display',
  PRIMARY KEY (`answer_id`),
  KEY `IDX_POLL_ANSWER_POLL_ID` (`poll_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Poll Answers' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `poll_answer`
--

INSERT INTO `poll_answer` (`answer_id`, `poll_id`, `answer_title`, `votes_count`, `answer_order`) VALUES
(1, 1, 'Green', 4, 0),
(2, 1, 'Red', 1, 0),
(3, 1, 'Black', 0, 0),
(4, 1, 'Magenta', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `poll_store`
--

CREATE TABLE IF NOT EXISTS `poll_store` (
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`poll_id`,`store_id`),
  KEY `IDX_POLL_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Store';

--
-- Dumping data for table `poll_store`
--

INSERT INTO `poll_store` (`poll_id`, `store_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `poll_vote`
--

CREATE TABLE IF NOT EXISTS `poll_vote` (
  `vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `poll_answer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll answer id',
  `ip_address` bigint(20) DEFAULT NULL COMMENT 'Poll answer id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer id',
  `vote_time` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_POLL_VOTE_POLL_ANSWER_ID` (`poll_answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Vote' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `product_alert_price`
--

CREATE TABLE IF NOT EXISTS `product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `product_alert_stock`
--

CREATE TABLE IF NOT EXISTS `product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE IF NOT EXISTS `rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Frontend',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `UNQ_RATING_RATING_CODE` (`rating_code`),
  KEY `IDX_RATING_ENTITY_ID` (`entity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Ratings' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`rating_id`, `entity_id`, `rating_code`, `position`) VALUES
(1, 1, 'Quality', 0),
(2, 1, 'Value', 0),
(3, 1, 'Price', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rating_entity`
--

CREATE TABLE IF NOT EXISTS `rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Rating entities' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `rating_entity`
--

INSERT INTO `rating_entity` (`entity_id`, `entity_code`) VALUES
(1, 'product'),
(2, 'product_review'),
(3, 'review');

-- --------------------------------------------------------

--
-- Table structure for table `rating_option`
--

CREATE TABLE IF NOT EXISTS `rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on frontend',
  PRIMARY KEY (`option_id`),
  KEY `IDX_RATING_OPTION_RATING_ID` (`rating_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Rating options' AUTO_INCREMENT=16 ;

--
-- Dumping data for table `rating_option`
--

INSERT INTO `rating_option` (`option_id`, `rating_id`, `code`, `value`, `position`) VALUES
(1, 1, '1', 1, 1),
(2, 1, '2', 2, 2),
(3, 1, '3', 3, 3),
(4, 1, '4', 4, 4),
(5, 1, '5', 5, 5),
(6, 2, '1', 1, 1),
(7, 2, '2', 2, 2),
(8, 2, '3', 3, 3),
(9, 2, '4', 4, 4),
(10, 2, '5', 5, 5),
(11, 3, '1', 1, 1),
(12, 3, '2', 2, 2),
(13, 3, '3', 3, 3),
(14, 3, '4', 4, 4),
(15, 3, '5', 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `rating_option_vote`
--

CREATE TABLE IF NOT EXISTS `rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(16) NOT NULL COMMENT 'Customer IP',
  `remote_ip_long` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Customer IP converted to long integer format',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  KEY `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating option values' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rating_option_vote_aggregated`
--

CREATE TABLE IF NOT EXISTS `rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rating_store`
--

CREATE TABLE IF NOT EXISTS `rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';

-- --------------------------------------------------------

--
-- Table structure for table `rating_title`
--

CREATE TABLE IF NOT EXISTS `rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_TITLE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';

-- --------------------------------------------------------

--
-- Table structure for table `report_compared_product_index`
--

CREATE TABLE IF NOT EXISTS `report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `report_event`
--

CREATE TABLE IF NOT EXISTS `report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `IDX_REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `IDX_REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `IDX_REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `IDX_REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `IDX_REPORT_EVENT_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `report_event_types`
--

CREATE TABLE IF NOT EXISTS `report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `report_event_types`
--

INSERT INTO `report_event_types` (`event_type_id`, `event_name`, `customer_login`) VALUES
(1, 'catalog_product_view', 0),
(2, 'sendfriend_product', 0),
(3, 'catalog_product_compare_add_product', 0),
(4, 'checkout_cart_add_product', 0),
(5, 'wishlist_add_product', 0),
(6, 'wishlist_share', 0);

-- --------------------------------------------------------

--
-- Table structure for table `report_viewed_product_aggregated_daily`
--

CREATE TABLE IF NOT EXISTS `report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `report_viewed_product_aggregated_monthly`
--

CREATE TABLE IF NOT EXISTS `report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `report_viewed_product_aggregated_yearly`
--

CREATE TABLE IF NOT EXISTS `report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `report_viewed_product_index`
--

CREATE TABLE IF NOT EXISTS `report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE IF NOT EXISTS `review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `IDX_REVIEW_ENTITY_ID` (`entity_id`),
  KEY `IDX_REVIEW_STATUS_ID` (`status_id`),
  KEY `IDX_REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review base information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `review_detail`
--

CREATE TABLE IF NOT EXISTS `review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `IDX_REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `IDX_REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `IDX_REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review detail information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `review_entity`
--

CREATE TABLE IF NOT EXISTS `review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Review entities' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `review_entity`
--

INSERT INTO `review_entity` (`entity_id`, `entity_code`) VALUES
(1, 'product'),
(2, 'customer'),
(3, 'category');

-- --------------------------------------------------------

--
-- Table structure for table `review_entity_summary`
--

CREATE TABLE IF NOT EXISTS `review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review aggregates' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `review_status`
--

CREATE TABLE IF NOT EXISTS `review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Review statuses' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `review_status`
--

INSERT INTO `review_status` (`status_id`, `status_code`) VALUES
(1, 'Approved'),
(2, 'Pending'),
(3, 'Not Approved');

-- --------------------------------------------------------

--
-- Table structure for table `review_store`
--

CREATE TABLE IF NOT EXISTS `review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `IDX_REVIEW_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';

-- --------------------------------------------------------

--
-- Table structure for table `salesrule`
--

CREATE TABLE IF NOT EXISTS `salesrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL COMMENT 'Discount Step',
  `simple_free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Simple Free Shipping',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Coupon',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `salesrule_coupon`
--

CREATE TABLE IF NOT EXISTS `salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `IDX_SALESRULE_COUPON_RULE_ID` (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `salesrule_coupon_usage`
--

CREATE TABLE IF NOT EXISTS `salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_COUPON_ID` (`coupon_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';

-- --------------------------------------------------------

--
-- Table structure for table `salesrule_customer`
--

CREATE TABLE IF NOT EXISTS `salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `salesrule_customer_group`
--

CREATE TABLE IF NOT EXISTS `salesrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';

-- --------------------------------------------------------

--
-- Table structure for table `salesrule_label`
--

CREATE TABLE IF NOT EXISTS `salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `UNQ_SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `IDX_SALESRULE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_SALESRULE_LABEL_RULE_ID` (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `salesrule_product_attribute`
--

CREATE TABLE IF NOT EXISTS `salesrule_product_attribute` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';

-- --------------------------------------------------------

--
-- Table structure for table `salesrule_website`
--

CREATE TABLE IF NOT EXISTS `salesrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_SALESRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';

-- --------------------------------------------------------

--
-- Table structure for table `sales_bestsellers_aggregated_daily`
--

CREATE TABLE IF NOT EXISTS `sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_bestsellers_aggregated_monthly`
--

CREATE TABLE IF NOT EXISTS `sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_bestsellers_aggregated_yearly`
--

CREATE TABLE IF NOT EXISTS `sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_billing_agreement`
--

CREATE TABLE IF NOT EXISTS `sales_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_billing_agreement_order`
--

CREATE TABLE IF NOT EXISTS `sales_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_creditmemo`
--

CREATE TABLE IF NOT EXISTS `sales_flat_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREATED_AT` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_creditmemo_comment`
--

CREATE TABLE IF NOT EXISTS `sales_flat_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_creditmemo_grid`
--

CREATE TABLE IF NOT EXISTS `sales_flat_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_creditmemo_item`
--

CREATE TABLE IF NOT EXISTS `sales_flat_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_invoice`
--

CREATE TABLE IF NOT EXISTS `sales_flat_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_CREATED_AT` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_invoice_comment`
--

CREATE TABLE IF NOT EXISTS `sales_flat_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_invoice_grid`
--

CREATE TABLE IF NOT EXISTS `sales_flat_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_BILLING_NAME` (`billing_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_invoice_item`
--

CREATE TABLE IF NOT EXISTS `sales_flat_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_ITEM_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_order`
--

CREATE TABLE IF NOT EXISTS `sales_flat_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(255) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(255) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(255) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(255) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(255) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(255) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(50) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(255) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_STATE` (`state`),
  KEY `IDX_SALES_FLAT_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `IDX_SALES_FLAT_ORDER_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_ORDER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_order_address`
--

CREATE TABLE IF NOT EXISTS `sales_flat_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_ADDRESS_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_order_grid`
--

CREATE TABLE IF NOT EXISTS `sales_flat_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_order_item`
--

CREATE TABLE IF NOT EXISTS `sales_flat_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `is_nominal` int(11) NOT NULL DEFAULT '0' COMMENT 'Is Nominal',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `hidden_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_order_payment`
--

CREATE TABLE IF NOT EXISTS `sales_flat_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(255) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(255) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(255) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_status_description` varchar(255) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(255) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(255) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(255) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(255) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(255) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(255) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_trans_id` varchar(255) DEFAULT NULL COMMENT 'Cc Trans Id',
  `paybox_request_number` varchar(255) DEFAULT NULL COMMENT 'Paybox Request Number',
  `address_status` varchar(255) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_PAYMENT_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_order_status_history`
--

CREATE TABLE IF NOT EXISTS `sales_flat_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_quote`
--

CREATE TABLE IF NOT EXISTS `sales_flat_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(32) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `IDX_SALES_FLAT_QUOTE_STORE_ID` (`store_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `sales_flat_quote`
--

INSERT INTO `sales_flat_quote` (`entity_id`, `store_id`, `created_at`, `updated_at`, `converted_at`, `is_active`, `is_virtual`, `is_multi_shipping`, `items_count`, `items_qty`, `orig_order_id`, `store_to_base_rate`, `store_to_quote_rate`, `base_currency_code`, `store_currency_code`, `quote_currency_code`, `grand_total`, `base_grand_total`, `checkout_method`, `customer_id`, `customer_tax_class_id`, `customer_group_id`, `customer_email`, `customer_prefix`, `customer_firstname`, `customer_middlename`, `customer_lastname`, `customer_suffix`, `customer_dob`, `customer_note`, `customer_note_notify`, `customer_is_guest`, `remote_ip`, `applied_rule_ids`, `reserved_order_id`, `password_hash`, `coupon_code`, `global_currency_code`, `base_to_global_rate`, `base_to_quote_rate`, `customer_taxvat`, `customer_gender`, `subtotal`, `base_subtotal`, `subtotal_with_discount`, `base_subtotal_with_discount`, `is_changed`, `trigger_recollect`, `ext_shipping_info`, `gift_message_id`, `is_persistent`) VALUES
(1, 1, '2013-04-11 21:53:43', '2013-04-11 21:53:43', NULL, 1, 0, 0, 0, '0.0000', 0, '1.0000', '1.0000', 'USD', 'USD', 'USD', '0.0000', '0.0000', NULL, 1, 3, 1, 'enjoy3013@gmail.com', NULL, 'hat', NULL, 'dao', NULL, NULL, NULL, 1, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 'USD', '1.0000', '1.0000', NULL, NULL, '0.0000', '0.0000', '0.0000', '0.0000', 1, 0, NULL, NULL, 0),
(2, 1, '2013-04-19 00:42:10', '2013-04-19 00:42:10', NULL, 1, 0, 0, 0, '0.0000', 0, '1.0000', '1.0000', 'USD', 'USD', 'USD', '0.0000', '0.0000', NULL, 2, 3, 1, 'enjoy.harpyhunter@yahoo.com', NULL, 'Minh', NULL, 'Hat', NULL, NULL, NULL, 1, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 'USD', '1.0000', '1.0000', NULL, NULL, '0.0000', '0.0000', '0.0000', '0.0000', 1, 0, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_quote_address`
--

CREATE TABLE IF NOT EXISTS `sales_flat_quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `middlename` varchar(40) DEFAULT NULL COMMENT 'Middlename',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(255) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID` (`quote_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `sales_flat_quote_address`
--

INSERT INTO `sales_flat_quote_address` (`address_id`, `quote_id`, `created_at`, `updated_at`, `customer_id`, `save_in_address_book`, `customer_address_id`, `address_type`, `email`, `prefix`, `firstname`, `middlename`, `lastname`, `suffix`, `company`, `street`, `city`, `region`, `region_id`, `postcode`, `country_id`, `telephone`, `fax`, `same_as_billing`, `free_shipping`, `collect_shipping_rates`, `shipping_method`, `shipping_description`, `weight`, `subtotal`, `base_subtotal`, `subtotal_with_discount`, `base_subtotal_with_discount`, `tax_amount`, `base_tax_amount`, `shipping_amount`, `base_shipping_amount`, `shipping_tax_amount`, `base_shipping_tax_amount`, `discount_amount`, `base_discount_amount`, `grand_total`, `base_grand_total`, `customer_notes`, `applied_taxes`, `discount_description`, `shipping_discount_amount`, `base_shipping_discount_amount`, `subtotal_incl_tax`, `base_subtotal_total_incl_tax`, `hidden_tax_amount`, `base_hidden_tax_amount`, `shipping_hidden_tax_amount`, `base_shipping_hidden_tax_amnt`, `shipping_incl_tax`, `base_shipping_incl_tax`, `vat_id`, `vat_is_valid`, `vat_request_id`, `vat_request_date`, `vat_request_success`, `gift_message_id`) VALUES
(1, 1, '2013-04-11 21:53:43', '2013-04-11 21:53:43', 1, 0, NULL, 'billing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, 'a:0:{}', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, '0.0000', '0.0000', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, '2013-04-11 21:53:43', '2013-04-11 21:53:43', 1, 0, NULL, 'shipping', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, 'a:0:{}', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, '0.0000', '0.0000', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 2, '2013-04-19 00:42:10', '2013-04-19 00:42:10', 2, 0, NULL, 'billing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, 'a:0:{}', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, '0.0000', '0.0000', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 2, '2013-04-19 00:42:10', '2013-04-19 00:42:10', 2, 0, NULL, 'shipping', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, 'a:0:{}', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, '0.0000', '0.0000', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_quote_address_item`
--

CREATE TABLE IF NOT EXISTS `sales_flat_quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `free_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Free Shipping',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_quote_item`
--

CREATE TABLE IF NOT EXISTS `sales_flat_quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_quote_item_option`
--

CREATE TABLE IF NOT EXISTS `sales_flat_quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_quote_payment`
--

CREATE TABLE IF NOT EXISTS `sales_flat_quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  PRIMARY KEY (`payment_id`),
  KEY `IDX_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID` (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_quote_shipping_rate`
--

CREATE TABLE IF NOT EXISTS `sales_flat_quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `IDX_SALES_FLAT_QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_shipment`
--

CREATE TABLE IF NOT EXISTS `sales_flat_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_shipment_comment`
--

CREATE TABLE IF NOT EXISTS `sales_flat_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_shipment_grid`
--

CREATE TABLE IF NOT EXISTS `sales_flat_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_shipment_item`
--

CREATE TABLE IF NOT EXISTS `sales_flat_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ITEM_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_flat_shipment_track`
--

CREATE TABLE IF NOT EXISTS `sales_flat_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_CREATED_AT` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_invoiced_aggregated`
--

CREATE TABLE IF NOT EXISTS `sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_invoiced_aggregated_order`
--

CREATE TABLE IF NOT EXISTS `sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_aggregated_created`
--

CREATE TABLE IF NOT EXISTS `sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_CREATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_aggregated_updated`
--

CREATE TABLE IF NOT EXISTS `sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_UPDATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Updated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_status`
--

CREATE TABLE IF NOT EXISTS `sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

--
-- Dumping data for table `sales_order_status`
--

INSERT INTO `sales_order_status` (`status`, `label`) VALUES
('canceled', 'Canceled'),
('closed', 'Closed'),
('complete', 'Complete'),
('fraud', 'Suspected Fraud'),
('holded', 'On Hold'),
('payment_review', 'Payment Review'),
('pending', 'Pending'),
('pending_payment', 'Pending Payment'),
('pending_paypal', 'Pending PayPal'),
('processing', 'Processing');

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_status_label`
--

CREATE TABLE IF NOT EXISTS `sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `IDX_SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_status_state`
--

CREATE TABLE IF NOT EXISTS `sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  PRIMARY KEY (`status`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

--
-- Dumping data for table `sales_order_status_state`
--

INSERT INTO `sales_order_status_state` (`status`, `state`, `is_default`) VALUES
('canceled', 'canceled', 1),
('closed', 'closed', 1),
('complete', 'complete', 1),
('fraud', 'payment_review', 0),
('holded', 'holded', 1),
('payment_review', 'payment_review', 1),
('pending', 'new', 1),
('pending_payment', 'pending_payment', 1),
('processing', 'processing', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_tax`
--

CREATE TABLE IF NOT EXISTS `sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  `hidden` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Hidden',
  PRIMARY KEY (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_tax_item`
--

CREATE TABLE IF NOT EXISTS `sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `UNQ_SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_TAX_ID` (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_payment_transaction`
--

CREATE TABLE IF NOT EXISTS `sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_recurring_profile`
--

CREATE TABLE IF NOT EXISTS `sales_recurring_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `state` varchar(20) NOT NULL COMMENT 'State',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `reference_id` varchar(32) DEFAULT NULL COMMENT 'Reference Id',
  `subscriber_name` varchar(150) DEFAULT NULL COMMENT 'Subscriber Name',
  `start_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Start Datetime',
  `internal_reference_id` varchar(42) NOT NULL COMMENT 'Internal Reference Id',
  `schedule_description` varchar(255) NOT NULL COMMENT 'Schedule Description',
  `suspension_threshold` smallint(5) unsigned DEFAULT NULL COMMENT 'Suspension Threshold',
  `bill_failed_later` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Bill Failed Later',
  `period_unit` varchar(20) NOT NULL COMMENT 'Period Unit',
  `period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Frequency',
  `period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Max Cycles',
  `billing_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Billing Amount',
  `trial_period_unit` varchar(20) DEFAULT NULL COMMENT 'Trial Period Unit',
  `trial_period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Frequency',
  `trial_period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Max Cycles',
  `trial_billing_amount` text COMMENT 'Trial Billing Amount',
  `currency_code` varchar(3) NOT NULL COMMENT 'Currency Code',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `init_amount` decimal(12,4) DEFAULT NULL COMMENT 'Init Amount',
  `init_may_fail` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Init May Fail',
  `order_info` text NOT NULL COMMENT 'Order Info',
  `order_item_info` text NOT NULL COMMENT 'Order Item Info',
  `billing_address_info` text NOT NULL COMMENT 'Billing Address Info',
  `shipping_address_info` text COMMENT 'Shipping Address Info',
  `profile_vendor_info` text COMMENT 'Profile Vendor Info',
  `additional_info` text COMMENT 'Additional Info',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_INTERNAL_REFERENCE_ID` (`internal_reference_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_recurring_profile_order`
--

CREATE TABLE IF NOT EXISTS `sales_recurring_profile_order` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_ORDER_PROFILE_ID_ORDER_ID` (`profile_id`,`order_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_ORDER_ORDER_ID` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile Order' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_refunded_aggregated`
--

CREATE TABLE IF NOT EXISTS `sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_refunded_aggregated_order`
--

CREATE TABLE IF NOT EXISTS `sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_shipping_aggregated`
--

CREATE TABLE IF NOT EXISTS `sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_SHPP_AGGRED_PERIOD_STORE_ID_ORDER_STS_SHPP_DESCRIPTION` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_shipping_aggregated_order`
--

CREATE TABLE IF NOT EXISTS `sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `C05FAE47282EEA68654D0924E946761F` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sendfriend_log`
--

CREATE TABLE IF NOT EXISTS `sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer IP address',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_SENDFRIEND_LOG_IP` (`ip`),
  KEY `IDX_SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_tablerate`
--

CREATE TABLE IF NOT EXISTS `shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `D60821CDB2AFACEE1566CFC02D0D4CAA` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sitemap`
--

CREATE TABLE IF NOT EXISTS `sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `IDX_SITEMAP_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Sitemap' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  `first_customer_id` int(10) unsigned DEFAULT NULL COMMENT 'First Customer Id',
  `first_store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'First Store Id',
  PRIMARY KEY (`tag_id`),
  KEY `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`first_customer_id`),
  KEY `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` (`first_store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tag_properties`
--

CREATE TABLE IF NOT EXISTS `tag_properties` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_PROPERTIES_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Properties';

-- --------------------------------------------------------

--
-- Table structure for table `tag_relation`
--

CREATE TABLE IF NOT EXISTS `tag_relation` (
  `tag_relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Relation Id',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Store Id',
  `active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Active',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`tag_relation_id`),
  UNIQUE KEY `UNQ_TAG_RELATION_TAG_ID_CUSTOMER_ID_PRODUCT_ID_STORE_ID` (`tag_id`,`customer_id`,`product_id`,`store_id`),
  KEY `IDX_TAG_RELATION_PRODUCT_ID` (`product_id`),
  KEY `IDX_TAG_RELATION_TAG_ID` (`tag_id`),
  KEY `IDX_TAG_RELATION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_TAG_RELATION_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Relation' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tag_summary`
--

CREATE TABLE IF NOT EXISTS `tag_summary` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `customers` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customers',
  `products` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Products',
  `uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Uses',
  `historical_uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Historical Uses',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_SUMMARY_STORE_ID` (`store_id`),
  KEY `IDX_TAG_SUMMARY_TAG_ID` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Summary';

-- --------------------------------------------------------

--
-- Table structure for table `tax_calculation`
--

CREATE TABLE IF NOT EXISTS `tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `IDX_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `IDX_TAX_CALC_TAX_CALC_RATE_ID_CSTR_TAX_CLASS_ID_PRD_TAX_CLASS_ID` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tax Calculation' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tax_calculation`
--

INSERT INTO `tax_calculation` (`tax_calculation_id`, `tax_calculation_rate_id`, `tax_calculation_rule_id`, `customer_tax_class_id`, `product_tax_class_id`) VALUES
(1, 1, 1, 3, 2),
(2, 2, 1, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tax_calculation_rate`
--

CREATE TABLE IF NOT EXISTS `tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALC_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `IDX_TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `CA799F1E2CB843495F601E56C84A626D` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tax_calculation_rate`
--

INSERT INTO `tax_calculation_rate` (`tax_calculation_rate_id`, `tax_country_id`, `tax_region_id`, `tax_postcode`, `code`, `rate`, `zip_is_range`, `zip_from`, `zip_to`) VALUES
(1, 'US', 12, '*', 'US-CA-*-Rate 1', '8.2500', NULL, NULL, NULL),
(2, 'US', 43, '*', 'US-NY-*-Rate 1', '8.3750', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tax_calculation_rate_title`
--

CREATE TABLE IF NOT EXISTS `tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_calculation_rule`
--

CREATE TABLE IF NOT EXISTS `tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALC_RULE_PRIORITY_POSITION_TAX_CALC_RULE_ID` (`priority`,`position`,`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tax_calculation_rule`
--

INSERT INTO `tax_calculation_rule` (`tax_calculation_rule_id`, `code`, `priority`, `position`) VALUES
(1, 'Retail Customer-Taxable Goods-Rate 1', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tax_class`
--

CREATE TABLE IF NOT EXISTS `tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tax Class' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tax_class`
--

INSERT INTO `tax_class` (`class_id`, `class_name`, `class_type`) VALUES
(2, 'Taxable Goods', 'PRODUCT'),
(3, 'Retail Customer', 'CUSTOMER'),
(4, 'Shipping', 'PRODUCT');

-- --------------------------------------------------------

--
-- Table structure for table `tax_order_aggregated_created`
--

CREATE TABLE IF NOT EXISTS `tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `FCA5E2C02689EB2641B30580D7AACF12` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_order_aggregated_updated`
--

CREATE TABLE IF NOT EXISTS `tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `DB0AF14011199AA6CD31D5078B90AA8D` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregated Updated' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `weee_discount`
--

CREATE TABLE IF NOT EXISTS `weee_discount` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  KEY `IDX_WEEE_DISCOUNT_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_DISCOUNT_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_DISCOUNT_CUSTOMER_GROUP_ID` (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Discount';

-- --------------------------------------------------------

--
-- Table structure for table `weee_tax`
--

CREATE TABLE IF NOT EXISTS `weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` varchar(255) NOT NULL DEFAULT '*' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`value_id`),
  KEY `IDX_WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_TAX_COUNTRY` (`country`),
  KEY `IDX_WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `widget`
--

CREATE TABLE IF NOT EXISTS `widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `IDX_WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `widget_instance`
--

CREATE TABLE IF NOT EXISTS `widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `package_theme` varchar(255) DEFAULT NULL COMMENT 'Package Theme',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `widget_instance_page`
--

CREATE TABLE IF NOT EXISTS `widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Block Reference',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `widget_instance_page_layout`
--

CREATE TABLE IF NOT EXISTS `widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `UNQ_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID` (`layout_update_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE IF NOT EXISTS `wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  PRIMARY KEY (`wishlist_id`),
  UNIQUE KEY `UNQ_WISHLIST_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_WISHLIST_SHARED` (`shared`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist_item`
--

CREATE TABLE IF NOT EXISTS `wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `IDX_WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `IDX_WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_WISHLIST_ITEM_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist items' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist_item_option`
--

CREATE TABLE IF NOT EXISTS `wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_A014B30B04B72DD0EAB3EECD779728D6` (`wishlist_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `xmlconnect_application`
--

CREATE TABLE IF NOT EXISTS `xmlconnect_application` (
  `application_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Application Id',
  `name` varchar(255) NOT NULL COMMENT 'Application Name',
  `code` varchar(32) NOT NULL COMMENT 'Application Code',
  `type` varchar(32) NOT NULL COMMENT 'Device Type',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `active_from` date DEFAULT NULL COMMENT 'Active From',
  `active_to` date DEFAULT NULL COMMENT 'Active To',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `browsing_mode` smallint(5) unsigned DEFAULT '0' COMMENT 'Browsing Mode',
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `UNQ_XMLCONNECT_APPLICATION_CODE` (`code`),
  KEY `FK_XMLCONNECT_APPLICATION_STORE_ID_CORE_STORE_STORE_ID` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Application' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `xmlconnect_config_data`
--

CREATE TABLE IF NOT EXISTS `xmlconnect_config_data` (
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  `category` varchar(60) NOT NULL DEFAULT 'default' COMMENT 'Category',
  `path` varchar(250) NOT NULL COMMENT 'Path',
  `value` text NOT NULL COMMENT 'Value',
  UNIQUE KEY `UNQ_XMLCONNECT_CONFIG_DATA_APPLICATION_ID_CATEGORY_PATH` (`application_id`,`category`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Configuration Data';

-- --------------------------------------------------------

--
-- Table structure for table `xmlconnect_history`
--

CREATE TABLE IF NOT EXISTS `xmlconnect_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `params` blob COMMENT 'Params',
  `title` varchar(200) NOT NULL COMMENT 'Title',
  `activation_key` varchar(255) NOT NULL COMMENT 'Activation Key',
  `name` varchar(255) NOT NULL COMMENT 'Application Name',
  `code` varchar(32) NOT NULL COMMENT 'Application Code',
  PRIMARY KEY (`history_id`),
  KEY `FK_8F08B9513373BC19F49EE3EF8340E270` (`application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect History' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `xmlconnect_notification_template`
--

CREATE TABLE IF NOT EXISTS `xmlconnect_notification_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `name` varchar(255) NOT NULL COMMENT 'Template Name',
  `push_title` varchar(140) NOT NULL COMMENT 'Push Notification Title',
  `message_title` varchar(255) NOT NULL COMMENT 'Message Title',
  `content` text NOT NULL COMMENT 'Message Content',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  `application_id` smallint(5) unsigned NOT NULL COMMENT 'Application Id',
  PRIMARY KEY (`template_id`),
  KEY `FK_F9927C7518A907CF5C350942FD296DC3` (`application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Notification Template' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `xmlconnect_queue`
--

CREATE TABLE IF NOT EXISTS `xmlconnect_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `exec_time` timestamp NULL DEFAULT NULL COMMENT 'Scheduled Execution Time',
  `template_id` int(10) unsigned NOT NULL COMMENT 'Template Id',
  `push_title` varchar(140) NOT NULL COMMENT 'Push Notification Title',
  `message_title` varchar(255) DEFAULT '' COMMENT 'Message Title',
  `content` text COMMENT 'Message Content',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  `type` varchar(12) NOT NULL COMMENT 'Type of Notification',
  PRIMARY KEY (`queue_id`),
  KEY `FK_2019AEC5FC55A516965583447CA26B14` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Xmlconnect Notification Queue' AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_rule`
--
ALTER TABLE `admin_rule`
  ADD CONSTRAINT `FK_ADMIN_RULE_ROLE_ID_ADMIN_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `admin_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `api2_acl_rule`
--
ALTER TABLE `api2_acl_rule`
  ADD CONSTRAINT `FK_API2_ACL_RULE_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `api2_acl_user`
--
ALTER TABLE `api2_acl_user`
  ADD CONSTRAINT `FK_API2_ACL_USER_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `api_rule`
--
ALTER TABLE `api_rule`
  ADD CONSTRAINT `FK_API_RULE_ROLE_ID_API_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `api_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `api_session`
--
ALTER TABLE `api_session`
  ADD CONSTRAINT `FK_API_SESSION_USER_ID_API_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `api_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cataloginventory_stock_item`
--
ALTER TABLE `cataloginventory_stock_item`
  ADD CONSTRAINT `FK_CATINV_STOCK_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATINV_STOCK_ITEM_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cataloginventory_stock_status`
--
ALTER TABLE `cataloginventory_stock_status`
  ADD CONSTRAINT `FK_CATINV_STOCK_STS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATINV_STOCK_STS_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATINV_STOCK_STS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalogrule_customer_group`
--
ALTER TABLE `catalogrule_customer_group`
  ADD CONSTRAINT `FK_CATALOGRULE_CUSTOMER_GROUP_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalogrule_group_website`
--
ALTER TABLE `catalogrule_group_website`
  ADD CONSTRAINT `FK_CATALOGRULE_GROUP_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATRULE_GROUP_WS_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalogrule_product`
--
ALTER TABLE `catalogrule_product`
  ADD CONSTRAINT `FK_CATALOGRULE_PRODUCT_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATALOGRULE_PRODUCT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATRULE_PRD_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATRULE_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalogrule_product_price`
--
ALTER TABLE `catalogrule_product_price`
  ADD CONSTRAINT `FK_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATRULE_PRD_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATRULE_PRD_PRICE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalogrule_website`
--
ALTER TABLE `catalogrule_website`
  ADD CONSTRAINT `FK_CATALOGRULE_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATALOGRULE_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalogsearch_query`
--
ALTER TABLE `catalogsearch_query`
  ADD CONSTRAINT `FK_CATALOGSEARCH_QUERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalogsearch_result`
--
ALTER TABLE `catalogsearch_result`
  ADD CONSTRAINT `FK_CATALOGSEARCH_RESULT_QUERY_ID_CATALOGSEARCH_QUERY_QUERY_ID` FOREIGN KEY (`query_id`) REFERENCES `catalogsearch_query` (`query_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATSRCH_RESULT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_category_entity_datetime`
--
ALTER TABLE `catalog_category_entity_datetime`
  ADD CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_category_entity_decimal`
--
ALTER TABLE `catalog_category_entity_decimal`
  ADD CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_category_entity_int`
--
ALTER TABLE `catalog_category_entity_int`
  ADD CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_category_entity_text`
--
ALTER TABLE `catalog_category_entity_text`
  ADD CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_category_entity_varchar`
--
ALTER TABLE `catalog_category_entity_varchar`
  ADD CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_category_product`
--
ALTER TABLE `catalog_category_product`
  ADD CONSTRAINT `FK_CAT_CTGR_PRD_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_category_product_index`
--
ALTER TABLE `catalog_category_product_index`
  ADD CONSTRAINT `FK_CATALOG_CATEGORY_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_PRD_IDX_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CTGR_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_compare_item`
--
ALTER TABLE `catalog_compare_item`
  ADD CONSTRAINT `FK_CATALOG_COMPARE_ITEM_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CATALOG_COMPARE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_CMP_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_eav_attribute`
--
ALTER TABLE `catalog_eav_attribute`
  ADD CONSTRAINT `FK_CATALOG_EAV_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_bundle_option`
--
ALTER TABLE `catalog_product_bundle_option`
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_bundle_option_value`
--
ALTER TABLE `catalog_product_bundle_option_value`
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_bundle_price_index`
--
ALTER TABLE `catalog_product_bundle_price_index`
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_bundle_selection`
--
ALTER TABLE `catalog_product_bundle_selection`
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_bundle_selection_price`
--
ALTER TABLE `catalog_product_bundle_selection_price`
  ADD CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DCF37523AA05D770A70AA4ED7C2616E4` FOREIGN KEY (`selection_id`) REFERENCES `catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_enabled_index`
--
ALTER TABLE `catalog_product_enabled_index`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENABLED_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity`
--
ALTER TABLE `catalog_product_entity`
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_datetime`
--
ALTER TABLE `catalog_product_entity_datetime`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_decimal`
--
ALTER TABLE `catalog_product_entity_decimal`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_gallery`
--
ALTER TABLE `catalog_product_entity_gallery`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_group_price`
--
ALTER TABLE `catalog_product_entity_group_price`
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_GROUP_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_GROUP_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DF909D22C11B60B1E5E3EE64AB220ECE` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_int`
--
ALTER TABLE `catalog_product_entity_int`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_INT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_media_gallery`
--
ALTER TABLE `catalog_product_entity_media_gallery`
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_media_gallery_value`
--
ALTER TABLE `catalog_product_entity_media_gallery_value`
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_VAL_ID_CAT_PRD_ENTT_MDA_GLR_VAL_ID` FOREIGN KEY (`value_id`) REFERENCES `catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_text`
--
ALTER TABLE `catalog_product_entity_text`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_tier_price`
--
ALTER TABLE `catalog_product_entity_tier_price`
  ADD CONSTRAINT `FK_6E08D719F0501DD1D8E6D4EFF2511C85` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_entity_varchar`
--
ALTER TABLE `catalog_product_entity_varchar`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_index_eav`
--
ALTER TABLE `catalog_product_index_eav`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_INDEX_EAV_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_EAV_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_EAV_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_index_eav_decimal`
--
ALTER TABLE `catalog_product_index_eav_decimal`
  ADD CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_index_group_price`
--
ALTER TABLE `catalog_product_index_group_price`
  ADD CONSTRAINT `FK_195DF97C81B0BDD6A2EEC50F870E16D1` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_GROUP_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_GROUP_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_index_price`
--
ALTER TABLE `catalog_product_index_price`
  ADD CONSTRAINT `FK_CAT_PRD_IDX_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_index_tier_price`
--
ALTER TABLE `catalog_product_index_tier_price`
  ADD CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_index_website`
--
ALTER TABLE `catalog_product_index_website`
  ADD CONSTRAINT `FK_CAT_PRD_IDX_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_link`
--
ALTER TABLE `catalog_product_link`
  ADD CONSTRAINT `FK_CAT_PRD_LNK_LNKED_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_LNK_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_link_attribute`
--
ALTER TABLE `catalog_product_link_attribute`
  ADD CONSTRAINT `FK_CAT_PRD_LNK_ATTR_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_link_attribute_decimal`
--
ALTER TABLE `catalog_product_link_attribute_decimal`
  ADD CONSTRAINT `FK_AB2EFA9A14F7BCF1D5400056203D14B6` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_LNK_ATTR_DEC_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_link_attribute_int`
--
ALTER TABLE `catalog_product_link_attribute_int`
  ADD CONSTRAINT `FK_CAT_PRD_LNK_ATTR_INT_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_D6D878F8BA2A4282F8DDED7E6E3DE35C` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_link_attribute_varchar`
--
ALTER TABLE `catalog_product_link_attribute_varchar`
  ADD CONSTRAINT `FK_CAT_PRD_LNK_ATTR_VCHR_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DEE9C4DA61CFCC01DFCF50F0D79CEA51` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_option`
--
ALTER TABLE `catalog_product_option`
  ADD CONSTRAINT `FK_CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_option_price`
--
ALTER TABLE `catalog_product_option_price`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_OPT_PRICE_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_option_title`
--
ALTER TABLE `catalog_product_option_title`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_OPT_TTL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_option_type_price`
--
ALTER TABLE `catalog_product_option_type_price`
  ADD CONSTRAINT `FK_B523E3378E8602F376CC415825576B7F` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_OPT_TYPE_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_option_type_title`
--
ALTER TABLE `catalog_product_option_type_title`
  ADD CONSTRAINT `FK_C085B9CF2C2A302E8043FDEA1937D6A2` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_OPT_TYPE_TTL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_option_type_value`
--
ALTER TABLE `catalog_product_option_type_value`
  ADD CONSTRAINT `FK_CAT_PRD_OPT_TYPE_VAL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_relation`
--
ALTER TABLE `catalog_product_relation`
  ADD CONSTRAINT `FK_CAT_PRD_RELATION_CHILD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_super_attribute`
--
ALTER TABLE `catalog_product_super_attribute`
  ADD CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `catalog_product_super_attribute_label`
--
ALTER TABLE `catalog_product_super_attribute_label`
  ADD CONSTRAINT `FK_309442281DF7784210ED82B2CC51E5D5` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_SPR_ATTR_LBL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_super_attribute_pricing`
--
ALTER TABLE `catalog_product_super_attribute_pricing`
  ADD CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRICING_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CDE8813117106CFAA3AD209358F66332` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_super_link`
--
ALTER TABLE `catalog_product_super_link`
  ADD CONSTRAINT `FK_CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_SPR_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `catalog_product_website`
--
ALTER TABLE `catalog_product_website`
  ADD CONSTRAINT `FK_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CAT_PRD_WS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `checkout_agreement_store`
--
ALTER TABLE `checkout_agreement_store`
  ADD CONSTRAINT `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CHKT_AGRT_STORE_AGRT_ID_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `checkout_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cms_block_store`
--
ALTER TABLE `cms_block_store`
  ADD CONSTRAINT `FK_CMS_BLOCK_STORE_BLOCK_ID_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CMS_BLOCK_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cms_page_store`
--
ALTER TABLE `cms_page_store`
  ADD CONSTRAINT `FK_CMS_PAGE_STORE_PAGE_ID_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CMS_PAGE_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `core_layout_link`
--
ALTER TABLE `core_layout_link`
  ADD CONSTRAINT `FK_CORE_LAYOUT_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_LYT_LNK_LYT_UPDATE_ID_CORE_LYT_UPDATE_LYT_UPDATE_ID` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `core_store`
--
ALTER TABLE `core_store`
  ADD CONSTRAINT `FK_CORE_STORE_GROUP_ID_CORE_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `core_store_group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_STORE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `core_store_group`
--
ALTER TABLE `core_store_group`
  ADD CONSTRAINT `FK_CORE_STORE_GROUP_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `core_translate`
--
ALTER TABLE `core_translate`
  ADD CONSTRAINT `FK_CORE_TRANSLATE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `core_url_rewrite`
--
ALTER TABLE `core_url_rewrite`
  ADD CONSTRAINT `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_URL_REWRITE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `core_variable_value`
--
ALTER TABLE `core_variable_value`
  ADD CONSTRAINT `FK_CORE_VARIABLE_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_VARIABLE_VALUE_VARIABLE_ID_CORE_VARIABLE_VARIABLE_ID` FOREIGN KEY (`variable_id`) REFERENCES `core_variable` (`variable_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `coupon_aggregated`
--
ALTER TABLE `coupon_aggregated`
  ADD CONSTRAINT `FK_COUPON_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `coupon_aggregated_order`
--
ALTER TABLE `coupon_aggregated_order`
  ADD CONSTRAINT `FK_COUPON_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `coupon_aggregated_updated`
--
ALTER TABLE `coupon_aggregated_updated`
  ADD CONSTRAINT `FK_COUPON_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_address_entity`
--
ALTER TABLE `customer_address_entity`
  ADD CONSTRAINT `FK_CUSTOMER_ADDRESS_ENTITY_PARENT_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_address_entity_datetime`
--
ALTER TABLE `customer_address_entity_datetime`
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_address_entity_decimal`
--
ALTER TABLE `customer_address_entity_decimal`
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_address_entity_int`
--
ALTER TABLE `customer_address_entity_int`
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_address_entity_text`
--
ALTER TABLE `customer_address_entity_text`
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_address_entity_varchar`
--
ALTER TABLE `customer_address_entity_varchar`
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_eav_attribute`
--
ALTER TABLE `customer_eav_attribute`
  ADD CONSTRAINT `FK_CSTR_EAV_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_eav_attribute_website`
--
ALTER TABLE `customer_eav_attribute_website`
  ADD CONSTRAINT `FK_CSTR_EAV_ATTR_WS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_EAV_ATTR_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_entity`
--
ALTER TABLE `customer_entity`
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `customer_entity_datetime`
--
ALTER TABLE `customer_entity_datetime`
  ADD CONSTRAINT `FK_CSTR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_entity_decimal`
--
ALTER TABLE `customer_entity_decimal`
  ADD CONSTRAINT `FK_CSTR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_entity_int`
--
ALTER TABLE `customer_entity_int`
  ADD CONSTRAINT `FK_CSTR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_entity_text`
--
ALTER TABLE `customer_entity_text`
  ADD CONSTRAINT `FK_CSTR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_entity_varchar`
--
ALTER TABLE `customer_entity_varchar`
  ADD CONSTRAINT `FK_CSTR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CSTR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_form_attribute`
--
ALTER TABLE `customer_form_attribute`
  ADD CONSTRAINT `FK_CSTR_FORM_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dataflow_batch`
--
ALTER TABLE `dataflow_batch`
  ADD CONSTRAINT `FK_DATAFLOW_BATCH_PROFILE_ID_DATAFLOW_PROFILE_PROFILE_ID` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_DATAFLOW_BATCH_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `dataflow_batch_export`
--
ALTER TABLE `dataflow_batch_export`
  ADD CONSTRAINT `FK_DATAFLOW_BATCH_EXPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `dataflow_batch_import`
--
ALTER TABLE `dataflow_batch_import`
  ADD CONSTRAINT `FK_DATAFLOW_BATCH_IMPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `dataflow_import_data`
--
ALTER TABLE `dataflow_import_data`
  ADD CONSTRAINT `FK_DATAFLOW_IMPORT_DATA_SESSION_ID_DATAFLOW_SESSION_SESSION_ID` FOREIGN KEY (`session_id`) REFERENCES `dataflow_session` (`session_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `dataflow_profile_history`
--
ALTER TABLE `dataflow_profile_history`
  ADD CONSTRAINT `FK_AEA06B0C500063D3CE6EA671AE776645` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `design_change`
--
ALTER TABLE `design_change`
  ADD CONSTRAINT `FK_DESIGN_CHANGE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `directory_country_region_name`
--
ALTER TABLE `directory_country_region_name`
  ADD CONSTRAINT `FK_D7CFDEB379F775328EB6F62695E2B3E1` FOREIGN KEY (`region_id`) REFERENCES `directory_country_region` (`region_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `downloadable_link`
--
ALTER TABLE `downloadable_link`
  ADD CONSTRAINT `FK_DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `downloadable_link_price`
--
ALTER TABLE `downloadable_link_price`
  ADD CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `downloadable_link_purchased`
--
ALTER TABLE `downloadable_link_purchased`
  ADD CONSTRAINT `FK_DL_LNK_PURCHASED_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DL_LNK_PURCHASED_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `downloadable_link_purchased_item`
--
ALTER TABLE `downloadable_link_purchased_item`
  ADD CONSTRAINT `FK_46CC8E252307CE62F00A8F1887512A39` FOREIGN KEY (`purchased_id`) REFERENCES `downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_B219BF25756700DEE44550B21220ECCE` FOREIGN KEY (`order_item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `downloadable_link_title`
--
ALTER TABLE `downloadable_link_title`
  ADD CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `downloadable_sample`
--
ALTER TABLE `downloadable_sample`
  ADD CONSTRAINT `FK_DL_SAMPLE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `downloadable_sample_title`
--
ALTER TABLE `downloadable_sample_title`
  ADD CONSTRAINT `FK_DL_SAMPLE_TTL_SAMPLE_ID_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `downloadable_sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_attribute`
--
ALTER TABLE `eav_attribute`
  ADD CONSTRAINT `FK_EAV_ATTRIBUTE_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_attribute_group`
--
ALTER TABLE `eav_attribute_group`
  ADD CONSTRAINT `FK_EAV_ATTR_GROUP_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_attribute_label`
--
ALTER TABLE `eav_attribute_label`
  ADD CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_attribute_option`
--
ALTER TABLE `eav_attribute_option`
  ADD CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_attribute_option_value`
--
ALTER TABLE `eav_attribute_option_value`
  ADD CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ATTR_OPT_VAL_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `eav_attribute_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_attribute_set`
--
ALTER TABLE `eav_attribute_set`
  ADD CONSTRAINT `FK_EAV_ATTR_SET_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity`
--
ALTER TABLE `eav_entity`
  ADD CONSTRAINT `FK_EAV_ENTITY_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity_attribute`
--
ALTER TABLE `eav_entity_attribute`
  ADD CONSTRAINT `FK_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTT_ATTR_ATTR_GROUP_ID_EAV_ATTR_GROUP_ATTR_GROUP_ID` FOREIGN KEY (`attribute_group_id`) REFERENCES `eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity_datetime`
--
ALTER TABLE `eav_entity_datetime`
  ADD CONSTRAINT `FK_EAV_ENTITY_DATETIME_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity_decimal`
--
ALTER TABLE `eav_entity_decimal`
  ADD CONSTRAINT `FK_EAV_ENTITY_DECIMAL_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity_int`
--
ALTER TABLE `eav_entity_int`
  ADD CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity_store`
--
ALTER TABLE `eav_entity_store`
  ADD CONSTRAINT `FK_EAV_ENTITY_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTT_STORE_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity_text`
--
ALTER TABLE `eav_entity_text`
  ADD CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_entity_varchar`
--
ALTER TABLE `eav_entity_varchar`
  ADD CONSTRAINT `FK_EAV_ENTITY_VARCHAR_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_form_element`
--
ALTER TABLE `eav_form_element`
  ADD CONSTRAINT `FK_EAV_FORM_ELEMENT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_FORM_ELEMENT_FIELDSET_ID_EAV_FORM_FIELDSET_FIELDSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_FORM_ELEMENT_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_form_fieldset`
--
ALTER TABLE `eav_form_fieldset`
  ADD CONSTRAINT `FK_EAV_FORM_FIELDSET_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_form_fieldset_label`
--
ALTER TABLE `eav_form_fieldset_label`
  ADD CONSTRAINT `FK_EAV_FORM_FIELDSET_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_FORM_FSET_LBL_FSET_ID_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_form_type`
--
ALTER TABLE `eav_form_type`
  ADD CONSTRAINT `FK_EAV_FORM_TYPE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eav_form_type_entity`
--
ALTER TABLE `eav_form_type_entity`
  ADD CONSTRAINT `FK_EAV_FORM_TYPE_ENTITY_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EAV_FORM_TYPE_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `index_process_event`
--
ALTER TABLE `index_process_event`
  ADD CONSTRAINT `FK_INDEX_PROCESS_EVENT_EVENT_ID_INDEX_EVENT_EVENT_ID` FOREIGN KEY (`event_id`) REFERENCES `index_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_INDEX_PROCESS_EVENT_PROCESS_ID_INDEX_PROCESS_PROCESS_ID` FOREIGN KEY (`process_id`) REFERENCES `index_process` (`process_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newsletter_problem`
--
ALTER TABLE `newsletter_problem`
  ADD CONSTRAINT `FK_NEWSLETTER_PROBLEM_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_NLTTR_PROBLEM_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newsletter_queue`
--
ALTER TABLE `newsletter_queue`
  ADD CONSTRAINT `FK_NEWSLETTER_QUEUE_TEMPLATE_ID_NEWSLETTER_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `newsletter_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newsletter_queue_link`
--
ALTER TABLE `newsletter_queue_link`
  ADD CONSTRAINT `FK_NEWSLETTER_QUEUE_LINK_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_NLTTR_QUEUE_LNK_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newsletter_queue_store_link`
--
ALTER TABLE `newsletter_queue_store_link`
  ADD CONSTRAINT `FK_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_NLTTR_QUEUE_STORE_LNK_QUEUE_ID_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newsletter_subscriber`
--
ALTER TABLE `newsletter_subscriber`
  ADD CONSTRAINT `FK_NEWSLETTER_SUBSCRIBER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `oauth_token`
--
ALTER TABLE `oauth_token`
  ADD CONSTRAINT `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_OAUTH_TOKEN_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `oauth_consumer` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `paypal_cert`
--
ALTER TABLE `paypal_cert`
  ADD CONSTRAINT `FK_PAYPAL_CERT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `paypal_settlement_report_row`
--
ALTER TABLE `paypal_settlement_report_row`
  ADD CONSTRAINT `FK_E183E488F593E0DE10C6EBFFEBAC9B55` FOREIGN KEY (`report_id`) REFERENCES `paypal_settlement_report` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `persistent_session`
--
ALTER TABLE `persistent_session`
  ADD CONSTRAINT `FK_PERSISTENT_SESSION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `poll`
--
ALTER TABLE `poll`
  ADD CONSTRAINT `FK_POLL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `poll_answer`
--
ALTER TABLE `poll_answer`
  ADD CONSTRAINT `FK_POLL_ANSWER_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `poll_store`
--
ALTER TABLE `poll_store`
  ADD CONSTRAINT `FK_POLL_STORE_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_POLL_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `poll_vote`
--
ALTER TABLE `poll_vote`
  ADD CONSTRAINT `FK_POLL_VOTE_POLL_ANSWER_ID_POLL_ANSWER_ANSWER_ID` FOREIGN KEY (`poll_answer_id`) REFERENCES `poll_answer` (`answer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_alert_price`
--
ALTER TABLE `product_alert_price`
  ADD CONSTRAINT `FK_PRD_ALERT_PRICE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_ALERT_PRICE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_ALERT_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_alert_stock`
--
ALTER TABLE `product_alert_stock`
  ADD CONSTRAINT `FK_PRD_ALERT_STOCK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_ALERT_STOCK_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_ALERT_STOCK_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `FK_RATING_ENTITY_ID_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `rating_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating_option`
--
ALTER TABLE `rating_option`
  ADD CONSTRAINT `FK_RATING_OPTION_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating_option_vote`
--
ALTER TABLE `rating_option_vote`
  ADD CONSTRAINT `FK_RATING_OPTION_VOTE_OPTION_ID_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `rating_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating_option_vote_aggregated`
--
ALTER TABLE `rating_option_vote_aggregated`
  ADD CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating_store`
--
ALTER TABLE `rating_store`
  ADD CONSTRAINT `FK_RATING_STORE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_RATING_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating_title`
--
ALTER TABLE `rating_title`
  ADD CONSTRAINT `FK_RATING_TITLE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_RATING_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report_compared_product_index`
--
ALTER TABLE `report_compared_product_index`
  ADD CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `report_event`
--
ALTER TABLE `report_event`
  ADD CONSTRAINT `FK_REPORT_EVENT_EVENT_TYPE_ID_REPORT_EVENT_TYPES_EVENT_TYPE_ID` FOREIGN KEY (`event_type_id`) REFERENCES `report_event_types` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_EVENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report_viewed_product_aggregated_daily`
--
ALTER TABLE `report_viewed_product_aggregated_daily`
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report_viewed_product_aggregated_monthly`
--
ALTER TABLE `report_viewed_product_aggregated_monthly`
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report_viewed_product_aggregated_yearly`
--
ALTER TABLE `report_viewed_product_aggregated_yearly`
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report_viewed_product_index`
--
ALTER TABLE `report_viewed_product_index`
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `FK_REVIEW_ENTITY_ID_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `review_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REVIEW_STATUS_ID_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `review_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `review_detail`
--
ALTER TABLE `review_detail`
  ADD CONSTRAINT `FK_REVIEW_DETAIL_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REVIEW_DETAIL_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REVIEW_DETAIL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `review_entity_summary`
--
ALTER TABLE `review_entity_summary`
  ADD CONSTRAINT `FK_REVIEW_ENTITY_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `review_store`
--
ALTER TABLE `review_store`
  ADD CONSTRAINT `FK_REVIEW_STORE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_REVIEW_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `salesrule_coupon`
--
ALTER TABLE `salesrule_coupon`
  ADD CONSTRAINT `FK_SALESRULE_COUPON_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `salesrule_coupon_usage`
--
ALTER TABLE `salesrule_coupon_usage`
  ADD CONSTRAINT `FK_SALESRULE_COUPON_USAGE_COUPON_ID_SALESRULE_COUPON_COUPON_ID` FOREIGN KEY (`coupon_id`) REFERENCES `salesrule_coupon` (`coupon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALESRULE_COUPON_USAGE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `salesrule_customer`
--
ALTER TABLE `salesrule_customer`
  ADD CONSTRAINT `FK_SALESRULE_CUSTOMER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALESRULE_CUSTOMER_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `salesrule_customer_group`
--
ALTER TABLE `salesrule_customer_group`
  ADD CONSTRAINT `FK_SALESRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALESRULE_CUSTOMER_GROUP_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `salesrule_label`
--
ALTER TABLE `salesrule_label`
  ADD CONSTRAINT `FK_SALESRULE_LABEL_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALESRULE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `salesrule_product_attribute`
--
ALTER TABLE `salesrule_product_attribute`
  ADD CONSTRAINT `FK_SALESRULE_PRD_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_SALESRULE_PRD_ATTR_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_SALESRULE_PRD_ATTR_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `salesrule_website`
--
ALTER TABLE `salesrule_website`
  ADD CONSTRAINT `FK_SALESRULE_WEBSITE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALESRULE_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_bestsellers_aggregated_daily`
--
ALTER TABLE `sales_bestsellers_aggregated_daily`
  ADD CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_bestsellers_aggregated_monthly`
--
ALTER TABLE `sales_bestsellers_aggregated_monthly`
  ADD CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_bestsellers_aggregated_yearly`
--
ALTER TABLE `sales_bestsellers_aggregated_yearly`
  ADD CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_billing_agreement`
--
ALTER TABLE `sales_billing_agreement`
  ADD CONSTRAINT `FK_SALES_BILLING_AGREEMENT_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_BILLING_AGREEMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_billing_agreement_order`
--
ALTER TABLE `sales_billing_agreement_order`
  ADD CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_AGRT_ID_SALES_BILLING_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `sales_billing_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_creditmemo`
--
ALTER TABLE `sales_flat_creditmemo`
  ADD CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_creditmemo_comment`
--
ALTER TABLE `sales_flat_creditmemo_comment`
  ADD CONSTRAINT `FK_B0FCB0B5467075BE63D474F2CD5F7804` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_creditmemo_grid`
--
ALTER TABLE `sales_flat_creditmemo_grid`
  ADD CONSTRAINT `FK_78C711B225167A11CC077B03D1C8E1CC` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_creditmemo_item`
--
ALTER TABLE `sales_flat_creditmemo_item`
  ADD CONSTRAINT `FK_306DAC836C699F0B5E13BE486557AC8A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_invoice`
--
ALTER TABLE `sales_flat_invoice`
  ADD CONSTRAINT `FK_SALES_FLAT_INVOICE_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_INVOICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_invoice_comment`
--
ALTER TABLE `sales_flat_invoice_comment`
  ADD CONSTRAINT `FK_5C4B36BBE5231A76AB8018B281ED50BC` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_invoice_grid`
--
ALTER TABLE `sales_flat_invoice_grid`
  ADD CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_ENTT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_invoice_item`
--
ALTER TABLE `sales_flat_invoice_item`
  ADD CONSTRAINT `FK_SALES_FLAT_INVOICE_ITEM_PARENT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_order`
--
ALTER TABLE `sales_flat_order`
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_order_address`
--
ALTER TABLE `sales_flat_order_address`
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_ADDRESS_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_order_grid`
--
ALTER TABLE `sales_flat_order_grid`
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_ENTITY_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_order_item`
--
ALTER TABLE `sales_flat_order_item`
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_order_payment`
--
ALTER TABLE `sales_flat_order_payment`
  ADD CONSTRAINT `FK_SALES_FLAT_ORDER_PAYMENT_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_order_status_history`
--
ALTER TABLE `sales_flat_order_status_history`
  ADD CONSTRAINT `FK_CE7C71E74CB74DDACED337CEE6753D5E` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_quote`
--
ALTER TABLE `sales_flat_quote`
  ADD CONSTRAINT `FK_SALES_FLAT_QUOTE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_quote_address`
--
ALTER TABLE `sales_flat_quote_address`
  ADD CONSTRAINT `FK_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_quote_address_item`
--
ALTER TABLE `sales_flat_quote_address_item`
  ADD CONSTRAINT `FK_2EF8E28181D666D94D4E30DC2B0F80BF` FOREIGN KEY (`quote_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_A345FC758F20C314169CE27DCE53477F` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_address_item` (`address_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_B521389746C00700D1B2B76EBBE53854` FOREIGN KEY (`quote_address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_quote_item`
--
ALTER TABLE `sales_flat_quote_item`
  ADD CONSTRAINT `FK_B201DEB5DE51B791AF5C5BF87053C5A7` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_quote_item_option`
--
ALTER TABLE `sales_flat_quote_item_option`
  ADD CONSTRAINT `FK_5F20E478CA64B6891EA8A9D6C2735739` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_quote_payment`
--
ALTER TABLE `sales_flat_quote_payment`
  ADD CONSTRAINT `FK_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_quote_shipping_rate`
--
ALTER TABLE `sales_flat_quote_shipping_rate`
  ADD CONSTRAINT `FK_B1F177EFB73D3EDF5322BA64AC48D150` FOREIGN KEY (`address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_shipment`
--
ALTER TABLE `sales_flat_shipment`
  ADD CONSTRAINT `FK_SALES_FLAT_SHIPMENT_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_SHIPMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_shipment_comment`
--
ALTER TABLE `sales_flat_shipment_comment`
  ADD CONSTRAINT `FK_C2D69CC1FB03D2B2B794B0439F6650CF` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_shipment_grid`
--
ALTER TABLE `sales_flat_shipment_grid`
  ADD CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_ENTT_ID_SALES_FLAT_SHIPMENT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_shipment_item`
--
ALTER TABLE `sales_flat_shipment_item`
  ADD CONSTRAINT `FK_3AECE5007D18F159231B87E8306FC02A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_flat_shipment_track`
--
ALTER TABLE `sales_flat_shipment_track`
  ADD CONSTRAINT `FK_BCD2FA28717D29F37E10A153E6F2F841` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_invoiced_aggregated`
--
ALTER TABLE `sales_invoiced_aggregated`
  ADD CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_invoiced_aggregated_order`
--
ALTER TABLE `sales_invoiced_aggregated_order`
  ADD CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_order_aggregated_created`
--
ALTER TABLE `sales_order_aggregated_created`
  ADD CONSTRAINT `FK_SALES_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_order_aggregated_updated`
--
ALTER TABLE `sales_order_aggregated_updated`
  ADD CONSTRAINT `FK_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_order_status_label`
--
ALTER TABLE `sales_order_status_label`
  ADD CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_order_status_state`
--
ALTER TABLE `sales_order_status_state`
  ADD CONSTRAINT `FK_SALES_ORDER_STATUS_STATE_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_order_tax_item`
--
ALTER TABLE `sales_order_tax_item`
  ADD CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_ITEM_ID_SALES_FLAT_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_TAX_ID_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `sales_order_tax` (`tax_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_payment_transaction`
--
ALTER TABLE `sales_payment_transaction`
  ADD CONSTRAINT `FK_B99FF1A06402D725EBDB0F3A7ECD47A2` FOREIGN KEY (`parent_id`) REFERENCES `sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DA51A10B2405B64A4DAEF77A64F0DAAD` FOREIGN KEY (`payment_id`) REFERENCES `sales_flat_order_payment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_PAYMENT_TRANSACTION_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_recurring_profile`
--
ALTER TABLE `sales_recurring_profile`
  ADD CONSTRAINT `FK_SALES_RECURRING_PROFILE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SALES_RECURRING_PROFILE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_recurring_profile_order`
--
ALTER TABLE `sales_recurring_profile_order`
  ADD CONSTRAINT `FK_7FF85741C66DCD37A4FBE3E3255A5A01` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_B8A7A5397B67455786E55461748C59F4` FOREIGN KEY (`profile_id`) REFERENCES `sales_recurring_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales_refunded_aggregated`
--
ALTER TABLE `sales_refunded_aggregated`
  ADD CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_refunded_aggregated_order`
--
ALTER TABLE `sales_refunded_aggregated_order`
  ADD CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_shipping_aggregated`
--
ALTER TABLE `sales_shipping_aggregated`
  ADD CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_shipping_aggregated_order`
--
ALTER TABLE `sales_shipping_aggregated_order`
  ADD CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sitemap`
--
ALTER TABLE `sitemap`
  ADD CONSTRAINT `FK_SITEMAP_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tag`
--
ALTER TABLE `tag`
  ADD CONSTRAINT `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`first_customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`first_store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `tag_properties`
--
ALTER TABLE `tag_properties`
  ADD CONSTRAINT `FK_TAG_PROPERTIES_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAG_PROPERTIES_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tag_relation`
--
ALTER TABLE `tag_relation`
  ADD CONSTRAINT `FK_TAG_RELATION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAG_RELATION_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAG_RELATION_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAG_RELATION_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tag_summary`
--
ALTER TABLE `tag_summary`
  ADD CONSTRAINT `FK_TAG_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAG_SUMMARY_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tax_calculation`
--
ALTER TABLE `tax_calculation`
  ADD CONSTRAINT `FK_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAX_CALC_TAX_CALC_RATE_ID_TAX_CALC_RATE_TAX_CALC_RATE_ID` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAX_CALC_TAX_CALC_RULE_ID_TAX_CALC_RULE_TAX_CALC_RULE_ID` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tax_calculation_rate_title`
--
ALTER TABLE `tax_calculation_rate_title`
  ADD CONSTRAINT `FK_37FB965F786AD5897BB3AE90470C42AB` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TAX_CALCULATION_RATE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tax_order_aggregated_created`
--
ALTER TABLE `tax_order_aggregated_created`
  ADD CONSTRAINT `FK_TAX_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tax_order_aggregated_updated`
--
ALTER TABLE `tax_order_aggregated_updated`
  ADD CONSTRAINT `FK_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `weee_discount`
--
ALTER TABLE `weee_discount`
  ADD CONSTRAINT `FK_WEEE_DISCOUNT_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WEEE_DISCOUNT_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WEEE_DISCOUNT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `weee_tax`
--
ALTER TABLE `weee_tax`
  ADD CONSTRAINT `FK_WEEE_TAX_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WEEE_TAX_COUNTRY_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `directory_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WEEE_TAX_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WEEE_TAX_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `widget_instance_page`
--
ALTER TABLE `widget_instance_page`
  ADD CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_INSTANCE_ID_WIDGET_INSTANCE_INSTANCE_ID` FOREIGN KEY (`instance_id`) REFERENCES `widget_instance` (`instance_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `widget_instance_page_layout`
--
ALTER TABLE `widget_instance_page_layout`
  ADD CONSTRAINT `FK_0A5D06DCEC6A6845F50E5FAAC5A1C96D` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_LYT_PAGE_ID_WIDGET_INSTANCE_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `widget_instance_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `FK_WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlist_item`
--
ALTER TABLE `wishlist_item`
  ADD CONSTRAINT `FK_WISHLIST_ITEM_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WISHLIST_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WISHLIST_ITEM_WISHLIST_ID_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlist_item_option`
--
ALTER TABLE `wishlist_item_option`
  ADD CONSTRAINT `FK_A014B30B04B72DD0EAB3EECD779728D6` FOREIGN KEY (`wishlist_item_id`) REFERENCES `wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `xmlconnect_application`
--
ALTER TABLE `xmlconnect_application`
  ADD CONSTRAINT `FK_XMLCONNECT_APPLICATION_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `xmlconnect_config_data`
--
ALTER TABLE `xmlconnect_config_data`
  ADD CONSTRAINT `FK_31EE36D814216200D7C0723145AC510E` FOREIGN KEY (`application_id`) REFERENCES `xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `xmlconnect_history`
--
ALTER TABLE `xmlconnect_history`
  ADD CONSTRAINT `FK_8F08B9513373BC19F49EE3EF8340E270` FOREIGN KEY (`application_id`) REFERENCES `xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `xmlconnect_notification_template`
--
ALTER TABLE `xmlconnect_notification_template`
  ADD CONSTRAINT `FK_F9927C7518A907CF5C350942FD296DC3` FOREIGN KEY (`application_id`) REFERENCES `xmlconnect_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `xmlconnect_queue`
--
ALTER TABLE `xmlconnect_queue`
  ADD CONSTRAINT `FK_2019AEC5FC55A516965583447CA26B14` FOREIGN KEY (`template_id`) REFERENCES `xmlconnect_notification_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
