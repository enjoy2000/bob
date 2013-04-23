<?php

class Mage_News_Model_Mysql4_News extends Mage_Core_Model_Mysql4_Abstract
{
    
    public function _construct()
    {
        $this->init('News/News' , 'News_id');
    }
}