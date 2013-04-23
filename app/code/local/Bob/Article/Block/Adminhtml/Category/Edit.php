<?php
 
class Bob_Article_Block_Adminhtml_Category_Edit extends Mage_Adminhtml_Block_Widget_Form_Container
{
    public function __construct()
    {
        parent::__construct();
               
        $this->_objectId = 'id';
        $this->_blockGroup = 'article';
        $this->_controller = 'adminhtml_category';
 
        $this->_updateButton('save', 'label', Mage::helper('article')->__('Save Category'));
        $this->_updateButton('delete', 'label', Mage::helper('article')->__('Delete Category'));
    }
 
    public function getHeaderText()
    {
        if( Mage::registry('category_data') && Mage::registry('category_data')->getId() ) {
            return Mage::helper('article')->__("Edit Item '%s'", $this->htmlEscape(Mage::registry('category_data')->getTitle()));
        } else {
            return Mage::helper('article')->__('Add Item');
        }
    }
}