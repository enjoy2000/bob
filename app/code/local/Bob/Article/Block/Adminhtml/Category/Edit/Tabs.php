<?php
 
class Bob_Article_Block_Adminhtml_Category_Edit_Tabs extends Mage_Adminhtml_Block_Widget_Tabs
{
 
    public function __construct()
    {
        parent::__construct();
        $this->setId('article_tabs');
        $this->setDestElementId('edit_form');
        $this->setTitle(Mage::helper('article')->__('News Information'));
    }
 
    protected function _beforeToHtml()
    {
        $this->addTab('form_section', array(
            'label'     => Mage::helper('article')->__('Item Information'),
            'title'     => Mage::helper('article')->__('Item Information'),
            'content'   => $this->getLayout()->createBlock('article/adminhtml_category_edit_tab_form')->toHtml(),
        ));
       
        return parent::_beforeToHtml();
    }
}