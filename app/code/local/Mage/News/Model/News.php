<?php 

class Mage_News_Model_News extends Mage_Core_Model_Abstract
{
    
    public function _construct()
    {
        parent::_construct();
        $this->init('News/News');
    }
}