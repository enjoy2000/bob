<?php
 
class Bob_Article_Adminhtml_ArticleController extends Mage_Adminhtml_Controller_Action
{
 
    protected function _initAction()
    {
        $this->loadLayout()
            ->_setActiveMenu('article/items')
            ->_addBreadcrumb(Mage::helper('adminhtml')->__('Items Manager'), Mage::helper('adminhtml')->__('Item Manager'));
        return $this;
    }   
   
    public function indexAction() {
        $this->_initAction();       
        
        $this->renderLayout();
    }
 
    public function editAction()
    {
        $articleId     = $this->getRequest()->getParam('id');
        $articleModel  = Mage::getModel('article/article')->load($articleId);
 
        if ($articleModel->getId() || $articleId == 0) {
 
            Mage::register('article_data', $articleModel);
 
            $this->loadLayout();
            $this->_setActiveMenu('article/items');
           
            $this->_addBreadcrumb(Mage::helper('adminhtml')->__('Item Manager'), Mage::helper('adminhtml')->__('Item Manager'));
            $this->_addBreadcrumb(Mage::helper('adminhtml')->__('Item News'), Mage::helper('adminhtml')->__('Item News'));
           
            $this->getLayout()->getBlock('head')->setCanLoadExtJs(true);
           
            $this->_addContent($this->getLayout()->createBlock('article/adminhtml_article_edit'))
                 ->_addLeft($this->getLayout()->createBlock('article/adminhtml_article_edit_tabs'));
               
            $this->renderLayout();
        } else {
            Mage::getSingleton('adminhtml/session')->addError(Mage::helper('article')->__('Item does not exist'));
            $this->_redirect('*/*/');
        }
    }
   
    public function newAction()
    {
        $this->_forward('edit');
    }
   
    public function saveAction()
    {
        if ( $this->getRequest()->getPost() ) {
            try {
                $postData = $this->getRequest()->getPost();
                $articleModel = Mage::getModel('article/article');
               
                $articleModel->setId($this->getRequest()->getParam('id'))
                    ->setTitle($postData['title'])
                    ->setContent($postData['content'])
                    ->setStatus($postData['status'])
                    ->save();
               
                Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('adminhtml')->__('Item was successfully saved'));
                Mage::getSingleton('adminhtml/session')->setArticleData(false);
 
                $this->_redirect('*/*/');
                return;
            } catch (Exception $e) {
                Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
                Mage::getSingleton('adminhtml/session')->setArticleData($this->getRequest()->getPost());
                $this->_redirect('*/*/edit', array('id' => $this->getRequest()->getParam('id')));
                return;
            }
        }
        $this->_redirect('*/*/');
    }
   
    public function deleteAction()
    {
        if( $this->getRequest()->getParam('id') > 0 ) {
            try {
                $articleModel = Mage::getModel('article/article');
               
                $articleModel->setId($this->getRequest()->getParam('id'))
                    ->delete();
                   
                Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('adminhtml')->__('Item was successfully deleted'));
                $this->_redirect('*/*/');
            } catch (Exception $e) {
                Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
                $this->_redirect('*/*/edit', array('id' => $this->getRequest()->getParam('id')));
            }
        }
        $this->_redirect('*/*/');
    }
    /**
     * Product grid for AJAX request.
     * Sort and filter result for example.
     */
    public function gridAction()
    {
        $this->loadLayout();
        $this->getResponse()->setBody(
               $this->getLayout()->createBlock('article/adminhtml_article_grid')->toHtml()
        );
    }
    
    public function massDeleteAction(){
    	$articleIds = $this->getRequest()->get('article_id');
    	var_dump($articleIds);
    }
}