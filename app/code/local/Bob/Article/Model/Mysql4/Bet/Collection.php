<?php
 
class Bob_Article_Model_Mysql4_Bet_Collection extends Mage_Core_Model_Mysql4_Collection_Abstract
{
    public function _construct()
    {
        //parent::__construct();
        $this->_init('article/bet');
    }
}