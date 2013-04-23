<?php
class Mage_Article_IndexController extends Mage_Core_Controller_Front_Action
{
	
	public function indexAction()
	{
		$this->loadLayout();
		$this->renderLayout();
	}
    
    public function newAction()
    {
        $articleID =  $this->getRequest()->getParam('id');
        $articleModel = Mage::getModel('article/article')->load($articleID);
        
        if($articleModel->getId() || $articleID ==  0){
            
            Mage::register('article_data', $articleModel);
            
            $this->loadLayout();
            $this->_setActiveMenu('article/items');
            
            $this->_addBreadcrumb(Mage::helper('adminhtml')->__('Items Manager'), Mage::helper('adminhtml')->__('Items Manager'));
            $this->_addBreadcrumb(Mage::helper('adminhtml')->__('Items article'), Mage::helper('adminhtml')->__('Items article'));
            
            $this->getLayout()->getBlock('head')->setCanLoadExtJs(true);
            
            $this->addContent($this->getLayout()->createBlock('article/adminhtml_article_edit'))
                ->_addLeft($this->getLayout()->createBlock('article/adminhtml_article_edit_tabs'));
        } else {
            Mage::getSingleton('adminhtml/session')->addError(Mage::helper('article')->__('Item do not exist.'));
            $this->redirect('*/*/');
        }
    }
}