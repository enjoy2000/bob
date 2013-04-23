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
        }else{
            $articles->addFieldToFilter('status', 'available');
        }
        Mage::register('articles', $articles);       
        $this->getLayout()->getBlock('article')->setData('articles', $articles);        
        
		$this->renderLayout();    
	}
    
    public function newAction()
    {
        $this->loadLayout();
        
        $connection = Mage::getSingleton('core/resource')->getConnection('core_write');
        $categories = $connection->fetchAll('SELECT `name` FROM `article_category`');
        $this->getLayout()->getBlock('article/new')->setData('categories', $categories);
        $this->renderLayout();        
        
        $time = date("Y-m-d H:i:s");
        if (!Mage::getSingleton('customer/session')->isLoggedIn()) {
            $session = Mage::getSingleton('customer/session');
            $session->setAfterAuthUrl( Mage::helper('core/url')->getCurrentUrl() );
            $session->setBeforeAuthUrl( Mage::helper('core/url')->getCurrentUrl() );
            $this->_redirect('customer/account/login/');
            return $this;
        }
        if($this->getRequest()->getPost()){
            $customer = Mage::getSingleton('customer/session')->getCustomer();
            //echo $customer->getBalance();die;
            if($customer->getBalance() > (0.10 + $this->getRequest()->getPost('betAmount')) ){
                try{                    
                    $form = $this->getRequest()->getPost();
                    //echo $customer->getBalance() - 0.10 - $form['betAmount'];die;
                    $article = Mage::getModel('article/article');
                    $timeweight = Mage::helper('article')->getTimeWeight($form['deadlinetime']);
                    if($form['betSide'] == 1){
                        $article->setAgree($form['betAmount']);
                        $article->setAgreeWeight($timeweight*$form['betAmount']);
                    }
                    elseif($form['betSide'] == 2){
                        $article->setDisagree($form['betAmount']);
                        $article->setDisagreeWeight($timeweight*$form['betAmount']);
                    }
                    else{
                        return;
                    }
                    $article->setTitle($form['title'])
                            ->setContent($form['content'])
                            ->setDeadlineTime($form['deadlinetime'])
                            ->setEventTime($form['eventtime'])
                            ->setCreatedTime($time)
                            ->setCategory($form['category'])
                            ->setTotalBets($form['betAmount'])
                            ->setStatus('available')
                            ->setUserPost($customer->getEmail())
                            ->save();
                    $customer->setBalance(17)->save();
                    //write log
                    $this->_redirect('*/*/');
                } catch (Exception $e){
                    Mage::getSingleton('article/article')->addError($e->getMessage());
                    $this->_redirect('*/*/new');
                }
            }
            else{
                die('Not enough balance.');
            }            
        }
    }
    
    public function itemAction()
    {
               
        if(!$this->getRequest()->getParam('id')){
            $this->_redirect('*/*/');
        }
        $this->loadLayout();
        if(($this->getRequest()->getParam('id') > 1) && ($this->getRequest()->getParam('id') < count(Mage::getModel('article/article')->getCollection()))){
            $item = Mage::getModel('article/article')->load($this->getRequest()->getParam('id'));
            if(is_object($item)){
                $this->getLayout()->getBlock('article/item')->setData('item', $item);
            } else{
                $this->_redirect('*/*/');
            }
        } else{
            $this->_redirect('*/*/');
        }             
        $this->renderLayout();
        
    }
    
    public function betAction()
    {
        
    }
    
    public function statusAction()
    {
        $conf_merchantAccountNumber = "U0832731";
        $conf_merchantStoreName = "bob-sci";
        $conf_merchantSecurityWord = "Frogface101@";
        $conf_merchantEmail = "enjoy3013@gmail.com";
        
        $str = 
          $_REQUEST["lr_paidto"].":".
          $_REQUEST["lr_paidby"].":".
          stripslashes($_REQUEST["lr_store"]).":".
          $_REQUEST["lr_amnt"].":".
          $_REQUEST["lr_transfer"].":".
          $_REQUEST["lr_currency"].":".
          $conf_merchantSecurityWord;
          
        //Calculating hash
        $hash = strtoupper(bin2hex(mhash(MHASH_SHA256, $str)));  
        
        //Let's check that all parameters exist and match and that the hash 
        //string we computed matches the hash string that was sent by LR system.
        if (isset($_REQUEST["lr_paidto"]) &&  
            $_REQUEST["lr_paidto"] == strtoupper($conf_merchantAccountNumber) &&
            isset($_REQUEST["lr_store"]) && 
            stripslashes($_REQUEST["lr_store"]) == $conf_merchantStoreName &&
            isset($_REQUEST["lr_encrypted"]) &&
            $_REQUEST["lr_encrypted"] == $hash) {
        
            $customer = Mage::getSingleton('customer/session')->getCustomer();
            $customer->setBalance($customer->getBalance + $_REQUEST('lr_amnt'));
        
          $msgBody = "Payment was verified and is successful.\n\n";
        }
        else {
        
        // This block is for the code in case that the payment verification has 
        // failed.
        // In our example write the response to the body of the email we are 
        // going to send.
          $msgBody = "Invalid response. Sent hash didn't match the computed hash.\n";
        }
        
        // Let's get all the data sent by LR and add it to our email.
        $msgBody .= "Received data\n";
        $reqKeys = array_keys ($_REQUEST);
        foreach($reqKeys as &$key) {
          $msgBody .= $key." = ".$_REQUEST[$key]."\n";
        }
    }
    
    public function testAction(){
    	$customer = Mage::getSingleton('customer/session')->getCustomer();
    	$customer->setBalance(11.11)->save();
    	var_dump($customer);
    }

    public function test2Action()
    {
        if($this->getRequest()->getParam('id') > 0){
            try{
                $model = Mage::getModel('article/article');
                $model->setId($this->getRequest()->getParam('id'))->delete();
                Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('article')->__('Item was successly deleted.'));
                $this->_redirect('*/*/');
            } catch(Exception $e){
                Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
                $this->_redirect('*/*/edit', 'id' => $this->getRequest()->getParam('id'));
            }
        }
        $this->_redirect('*/*/');
    }

    public function test3Action()
    {

    }
}