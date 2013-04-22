<?php
 
class Bob_Article_Block_Adminhtml_Article_Edit extends Mage_Adminhtml_Block_Widget_Form_Container
{
    public function __construct()
    {
        parent::__construct();
               
        $this->_objectId = 'id';
        $this->_blockGroup = 'article';
        $this->_controller = 'adminhtml_article';
 
        $this->_updateButton('save', 'label', Mage::helper('article')->__('Save Item'));
        $this->_updateButton('delete', 'label', Mage::helper('article')->__('Delete Item'));
    }
 
    public function getHeaderText()
    {
        if( Mage::registry('article_data') && Mage::registry('article_data')->getId() ) {
            return Mage::helper('article')->__("Edit Item '%s'", $this->htmlEscape(Mage::registry('article_data')->getTitle()));
        } else {
            return Mage::helper('article')->__('Add Item');
        }
    }
}