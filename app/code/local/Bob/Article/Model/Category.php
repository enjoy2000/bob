<?php
 
class Bob_Article_Model_Category extends Mage_Core_Model_Abstract
{
    public function _construct()
    {
        parent::_construct();
        $this->_init('article/category');
    }
}