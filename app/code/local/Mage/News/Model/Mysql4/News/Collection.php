<?php

class Mage_News_Model_Mysql4_News_Collection extends Mage_Core_Model_Mysql4_Collection_Abstract
{
    
    public function _construct()
    {
        //parrent::_construct();
        $this->init('News/News');
    }
}