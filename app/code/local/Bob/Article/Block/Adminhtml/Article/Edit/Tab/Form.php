<?php
 
class Bob_Article_Block_Adminhtml_Article_Edit_Tab_Form extends Mage_Adminhtml_Block_Widget_Form
{
    protected function _prepareForm()
    {
        $form = new Varien_Data_Form();
        $this->setForm($form);
        $fieldset = $form->addFieldset('article_form', array('legend'=>Mage::helper('article')->__('Item information')));
       
        $fieldset->addField('title', 'text', array(
            'label'     => Mage::helper('article')->__('Title'),
            'class'     => 'required-entry',
            'required'  => true,
            'name'      => 'title',
        ));
        
        $fieldset->addField('decision', 'select', array(
            'label'     => Mage::helper('article')->__('Decision'),
            'name'      => 'decision',
            'values'    => array(
                array(
                    'value'     => 'NULL',
                    'label'     => Mage::helper('article')->__(' '),
                ),
                array(
                    'value'     => '1',
                    'label'     => Mage::helper('article')->__('True'),
                ),
 
                array(
                    'value'     => '0',
                    'label'     => Mage::helper('article')->__('False'),
                ),
                )
        ));
 
        $fieldset->addField('status', 'select', array(
            'label'     => Mage::helper('article')->__('Status'),
            'name'      => 'status',
            'values'    => array(
                array(
                    'value'     => 'awaiting',
                    'label'     => Mage::helper('article')->__('Awaiting'),
                ),
 
                array(
                    'value'     => 'available',
                    'label'     => Mage::helper('article')->__('Available'),
                ),
                array(
                    'value'     => 'waiting',
                    'label'     => Mage::helper('article')->__('Waiting'),
                ),
                array(
                    'value'     => 'closed',
                    'label'     => Mage::helper('article')->__('Closed'),
                ),
                array(
                    'value'     => 'rejected',
                    'label'     => Mage::helper('article')->__('Rejected'),
                )
            ),
        ));
       
        $fieldset->addField('content', 'editor', array(
            'name'      => 'content',
            'label'     => Mage::helper('article')->__('Content'),
            'title'     => Mage::helper('article')->__('Content'),
            'style'     => 'width:98%; height:400px;',
            'wysiwyg'   => false,
            'required'  => true,
        ));
       
        if ( Mage::getSingleton('adminhtml/session')->getArticleData() )
        {
            $form->setValues(Mage::getSingleton('adminhtml/session')->getArticleData());
            Mage::getSingleton('adminhtml/session')->setArticleData(null);
        } elseif ( Mage::registry('article_data') ) {
            $form->setValues(Mage::registry('article_data')->getData());
        }
        return parent::_prepareForm();
    }
}