<?php

class Mage_Article_Block_Adminhtml_article_Edit_Tab_Form extends Mage_Adminhtml_Block_Widget_Form
{
    
    protected function _prepareForm()
    {
        $form = new Varien_Data_Form();
        $this->setForm($form);
        $fieldset = $form->addFieldset('article_form', array('legend' => Mage::helper('article')->__('Item information')));
        
        $fieldset->addField('title', 'text', array(
                                    'label'     => Mage::helper('article')->__('Title'),                                    
                                    'class'     => 'required-entry',
                                    'required'  => true,
                                    'name'      => 'title'
        ));
        
        $fieldset->addField('status', 'select', array(
                                    'label'     => Mage::helper('article')->__('Status'),
                                    'name'      => 'status',
                                    'values'    => array(
                                        array(
                                            'value' => 1,
                                            'label' => Mage::helper('article')->__('Active')
                                        ),
                                        array(
                                            'value' => 0,
                                            'label' => Mage::helper('article')->__('Inactive')
                                        )
                                    )
        )); 
        
        $fieldset->addField('content', 'editor', array(
                                    'name'          => 'content',
                                    'label'         => Mage::helper('article')->__('Content'),
                                    'title'         => Mage::helper('article')->__('Content'),
                                    'style'         => 'width: 98%, height: 400px',
                                    'wysiwyg'       => false,                                    
                                    'required'      => true
        ));
        
        if(Mage::getSingleton('adminhtml/session')->getarticleData()){
            $form->setValues(Mage::getSingleton('adminhtml/session')->getarticleData());
            Mage::getSingleton('adminhtml/session')->setarticleData(null);
        } elseif(Mage::registry('article_data')){
            $form->setValues(Mage::registry('article_data')->getData());
        }
        return parent::_prepareForm();
    }
}