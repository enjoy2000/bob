<?php

class Mage_News_Block_Adminhtml_News extends Mage_Adminhtml_Block_Widget_Grid_Container
{
    
    public function __construct()
    {
        $this->_controller = 'adminhtml_news';
        $this->_blockGroup = 'News';
        $this->_headerText = Mage::helper('news')->__('Item Manager');
        $this->addButtonLabel = Mage::helper('news')->__('Add Item');
        parent::__construct();
    }
}