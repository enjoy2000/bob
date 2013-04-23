<?php 

class Mage_Article_Model_article extends Mage_Core_Model_Abstract
{
    
    public function _construct()
    {
        parent::_construct();
        $this->init('article/article');
    }
}