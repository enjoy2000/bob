<?php
 
class Bob_Article_Block_Adminhtml_Category extends Mage_Adminhtml_Block_Widget_Grid_Container
{
    public function __construct()
    {
        $this->_controller = 'adminhtml_category';
        $this->_blockGroup = 'article';
        $this->_headerText = Mage::helper('article')->__('Categories Manager');
        $this->_addButtonLabel = Mage::helper('article')->__('Add Category');
        parent::__construct();
    }
}