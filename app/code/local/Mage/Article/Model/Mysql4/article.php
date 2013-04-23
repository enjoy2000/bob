<?php

class Mage_Article_Model_Mysql4_article extends Mage_Core_Model_Mysql4_Abstract
{
    
    public function _construct()
    {
        $this->init('article/article' , 'article_id');
    }
}