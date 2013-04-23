<?php

class Mage_News_Adminhtml_NewsController extends Mage_Adminhtml_Controller_Action
{
    
    protected function _initAction()
    {
        $this->loadLayout()
                ->_setActiveMenu('news/items')
                ->_addBreadcrumb(Mage::helper('adminhtml')->__('Items Manager'), Mage::helper('adminhtml')->__('Items Manager'));
        return $this;
    }
    
    public function indexAction()
    {
        $this->_initAction();
        $this->_addContent($this->getLayout()->createBlock('news/adminhtml_news'));
        $this->renderLayout();
    }
    
    public function editAction()
    {
        $newsID =  $this->getRequest()->getParam('id');
        $newsModel = Mage::getModel('News/News')->load($newsID);
        
        if($newsModel->getId() || $newsID ==  0){
            
            Mage::register('news_data', $newsModel);
            
            $this->loadLayout();
            $this->_setActiveMenu('news/items');
            
            $this->_addBreadcrumb(Mage::helper('adminhtml')->__('Items Manager'), Mage::helper('adminhtml')->__('Items Manager'));
            $this->_addBreadcrumb(Mage::helper('adminhtml')->__('Items News'), Mage::helper('adminhtml')->__('Items News'));
            
            $this->getLayout()->getBlock('head')->setCanLoadExtJs(true);
            
            $this->addContent($this->getLayout()->createBlock('news/adminhtml_news_edit'))
                ->_addLeft($this->getLayout()->createBlock('news/adminhtml_news_edit_tabs'));
        } else {
            Mage::getSingleton('adminhtml/session')->addError(Mage::helper('news')->__('Item do not exist.'));
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
                $newsModel = Mage::getModel('News/News');
                
                $newsModel->setId($this->getRequest()->getParam('id'))
                        ->setTitle($postData['title'])
                        ->setContent($postData['content'])
                        ->setStatus($postData['status'])
                        ->save();
                
                Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('adminhtml')->__('Item was successly saved.'));
                Mage::getSingleton('adminhtml/session')->setNewsData(false);
                $this->_redirect('*/*/');
                return;
            } catch(Exception $e){
                Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
                Mage::getSingleton('adminhtml/session')->setNewsData($this->getRequest()->getPost());
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
                $newsModel = Mage::getModel('News/News');
                
                $newsModel->setId($this->getRequest()->getParam('id'))
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
            $this->getLayout()->createBlock('news/adminhtml_news_grid')->toHtml()
        );
    }
    
    public function altertiveAction()
    {
        if($this->getRequest()->getParam('id') > 0){
            try{
                $newsmodel = Mage::getModel('News/News');
                $newsmodel->setId($this->getRequest()->getParam('id'))->delete();
                Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('adminhtml')->__('Item was successly deleted.'));
                $this->_redirect('*/*/');
            } catch (Exception $e){
                Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
                $this->_redirect('*/*/edit', array('id' => $this->getRequest()->getParam('id')));
            }
        }
        $this->_redirect('*/*/');
    }
}












