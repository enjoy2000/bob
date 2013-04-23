<?php

class Mage_Article_Adminhtml_articleController extends Mage_Adminhtml_Controller_Action
{
    
    protected function _initAction()
    {
        $this->loadLayout()
                ->_setActiveMenu('article/items')
                ->_addBreadcrumb(Mage::helper('adminhtml')->__('Items Manager'), Mage::helper('adminhtml')->__('Items Manager'));
        return $this;
    }
    
    public function indexAction()
    {
        $this->_initAction();
        $this->_addContent($this->getLayout()->createBlock('article/adminhtml_article'));
        $this->renderLayout();
    }
    
    public function editAction()
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
    
    public function newAction(){
        $this->_forward('edit');
    }
    
    public function saveAction()
    {
        if($this->getRequest()->getPost()){
            try{
                $postData = $this->getRequest()->getPost();
                $articleModel = Mage::getModel('article/article');
                
                $articleModel->setId($this->getRequest()->getParam('id'))
                        ->setTitle($postData['title'])
                        ->setContent($postData['content'])
                        ->setStatus($postData['status'])
                        ->save();
                
                Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('adminhtml')->__('Item was successly saved.'));
                Mage::getSingleton('adminhtml/session')->setarticleData(false);
                $this->_redirect('*/*/');
                return;
            } catch(Exception $e){
                Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
                Mage::getSingleton('adminhtml/session')->setarticleData($this->getRequest()->getPost());
                $this->_redirect('*/*/edit', array('id'=> $this->getRequest()->getParam('id')));
                return;
            }
        }
        $this->_redirect('*/*/');
    }
    
    public function deleteAction()
    {
        if($this->getRequest()->getParam('id') > 0){
            try{
                $articleModel = Mage::getModel('article/article');
                
                $articleModel->setId($this->getRequest()->getParam('id'))
                            ->delete();
                            
                Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('adminhtml')->__('Item was successly deleted.'));
                $this->_redirect('*/*/');                
            } catch(Exception $e){
                Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
                $this->_redirect('*/*/edit', array('id' => $this->getRequest()->getParam('id')));
            }
        }
        $this->_redirect('*/*/');
    }
    
    public function gridAction()
    {
        $this->loadLayout();
        $this->getResponse()->setBody(
            $this->getLayout()->createBlock('article/adminhtml_article_grid')->toHtml()
        );
    }
}












