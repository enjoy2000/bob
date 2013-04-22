<?php
 
class Bob_Article_Block_Adminhtml_Article extends Mage_Adminhtml_Block_Widget_Grid_Container
{
    public function __construct()
    {
        $this->_controller = 'adminhtml_article';
        $this->_blockGroup = 'article';
        $this->_headerText = Mage::helper('article')->__('Item Manager');
        $this->_addButtonLabel = Mage::helper('article')->__('Add Item');
        parent::__construct();
    }
}