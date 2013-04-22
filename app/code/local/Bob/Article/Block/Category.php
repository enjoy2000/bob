<?php

class Bob_Article_Block_Category extends Mage_Core_Block_Template
{
    public function indexAction()
    {
        $connection = Mage::getSingleton('core/resource')->getConnection('core_write');
        $connection->fetchAll('SELECT * FROM `article_category`');
    }
}