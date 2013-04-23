<?php 

class Mage_Article_Block_Adminhtml_article_Edit_Tabs extends Mage_Adminhtml_Block_Widget_Tabs
{
    
    public function __construct()
    {
        parent::__construct();
        $this->setId('article_tabs');
        $this->setDestElementId('edit_form');
        $this->setTitle(Mage::helper('article')->__('article Information'));      
    }
    
    public function _beforeToHtml()
    {
        $this->addTab('form_section', array(
                                'label'     => Mage::helper('article')->__('Item Information'),                                
                                'title'     => Mage::helper('article')->__('Item Information'),
                                'content'   => $this->getLayout()->createBlock('article/adminhtml_article_edit_tab_form')->toHtml()
        ));
        
        return parent::_beforeToHtml();
    }
}