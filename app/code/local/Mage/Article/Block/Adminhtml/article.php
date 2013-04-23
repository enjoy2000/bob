<?php

class Mage_Article_Block_Adminhtml_article extends Mage_Adminhtml_Block_Widget_Grid_Container
{
    
    public function __construct()
    {
        $this->_controller = 'adminhtml_article';
        $this->_blockGroup = 'article';
        $this->_headerText = Mage::helper('article')->__('Item Manager');
        $this->addButtonLabel = Mage::helper('article')->__('Add Item');
        parent::__construct();
    }
}