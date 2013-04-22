<?php
class Bob_Article_IndexController extends Mage_Core_Controller_Front_Action
{
	
	public function indexAction()
	{        
		$this->loadLayout();
        $connection = Mage::getSingleton('core/resource')->getConnection('core_write');
        $categories = $connection->fetchAll('SELECT `name` FROM `article_category`');
        $this->getLayout()->getBlock('article')->setData('categories', $categories);
        $request = $this->getRequest();        
        
        $articles = Mage::getModel('article/article')->getCollection();
        $articles->setPageSize(10);        
        if(!$request->getParam('order')){
            $articles->setOrder('total_bets', 'DESC');
        }
        else{
            if(substr($request->getParam('order'), 0, 1) == '-'){
                $order = substr($request->getParam('order'), 1);
                $articles->setOrder($order, 'ASC');
            }
            else{
                $articles->setOrder($request->getParam('order'), 'DESC');
            }
        }
        if($_GET){
            if($request->getParam('category')){
                $articles->addFieldToFilter('category', $request->getParam('category'));
                if(!$request->getParam('status')){
                    $articles->addFieldToFilter('status', 'available');
                }
                else{
                    $articles->addFieldToFilter('status'  , $request->getParam('status')); 
                }       
                $articles->load();
            }
            else{
                if(!$request->getParam('status')){
                    $articles->addFieldToFilter('status', 'available');
                }
                else{
                    $articles->addFieldToFilter('status'  , $request->getParam('status')); 
                }          
                $articles->load();
            }            
        }
        Mage::register('articles', $articles);       
        $this->getLayout()->getBlock('article')->setData('articles', $articles);
        
        $time = time();
        foreach($articles as $article){
            $deadline = strtotime($article->getDeadlineTime());
            $diff = $time - $deadline;
            if($diff > 0){
                $article->setStatus('waiting')->save();
            }            
        }
		$this->renderLayout();    
	}
    
    public function newAction()
    {
        $this->loadLayout();
        
        $connection = Mage::getSingleton('core/resource')->getConnection('core_write');
        $categories = $connection->fetchAll('SELECT `name` FROM `article_category`');
        $this->getLayout()->getBlock('article/new')->setData('categories', $categories);
        $this->renderLayout();
        
        
        if(!Mage::helper('customer')->isLoggedIn()){
            return Mage::app()->getFrontController()->getResponse()->setRedirect(Mage::getUrl('customer/account'));
        }
        $time = date("Y-m-d H:i:s");
        if($this->getRequest()->getPost()){
            try{
                $form = $this->getRequest()->getPost();
                $article = Mage::getModel('article/article');
                
                if($form['betSide'] == 1){
                    $article->setAgree($form['betAmount']);
                }
                elseif($form['betSide'] == 2){
                    $article->setDisagree($form['betAmount']);
                }
                else{
                    echo 'You have to choose side to bid';
                    return;
                }
                $article->setTitle($form['title'])
                        ->setContent($form['content'])
                        ->setDeadlineTime($form['deadlinetime'])
                        ->setEventTime($form['eventtime'])
                        ->setCreatedTime($time)
                        ->setCategory($form['category'])
                        ->setTotalBets($form['betAmount'])
                        ->save();
                
                $this->_redirect('*/*/index');
            } catch (Exception $e){
                Mage::getSingleton('article/article')->addError($e->getMessage());
                $this->_redirect('*/*/new');
            }            
        }
    }
}