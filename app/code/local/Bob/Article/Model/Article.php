<?php
 
class Bob_Article_Model_Article extends Mage_Core_Model_Abstract
{
    public function _construct()
    {
        parent::_construct();
        $this->_init('article/article');
    }
    
    protected function _beforeSave()
    {        
        parent::_beforeSave();
    }
    
    protected function _afterSave()
    {    
        
        parent::_afterSave();
    } 
}