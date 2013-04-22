<?php
 
$installer = $this;
 
$installer->startSetup();
 
$installer->run("
 
-- DROP TABLE IF EXISTS {$this->getTable('article')};
CREATE TABLE {$this->getTable('article')} (
  `article_id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `content` text NOT NULL default '',
  `status` varchar(20) NOT NULL default '0',
  `created_time` datetime NULL,
  `deadline_time` datetime NULL,
  `event_time` datetime NULL,
  `agree` decimal(11,2) NOT NULL default '0',
  `disagree` decimal(11,2) NOT NULL default '0',
  `agree_weight` int(11) NOT NULL default '0',
  `disagree_weight` int(11) NOT NULL default '0',
  `category` varchar(255) NOT NULL default '',
  `total_bets` decimal(11,2) NOT NULL default '0',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
    ");
 
$installer->endSetup();