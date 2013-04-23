<?php

class Mage_Article_Model_Mysql4_article_Collection extends Mage_Core_Model_Mysql4_Collection_Abstract
{
    
    public function _construct()
    {
        //parrent::_construct();
        $this->init('article/article');
    }
}