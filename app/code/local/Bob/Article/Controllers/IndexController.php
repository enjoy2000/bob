<?php
class Bob_Article_IndexController extends Mage_Core_Controller_Front_Action
{
	
	public function indexAction()
	{        
		$this->loadLayout();
        //Mage::getSingleton('customer/session')->getCustomer()->setBalance(89548)->save();
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
                    $bet = Mage::getModel('article/bet');
                    $log = Mage::getModel('article/log');
                    $form = $this->getRequest()->getPost();
                    //echo $customer->getBalance() - 0.10 - $form['betAmount'];die;                    
                    $article = Mage::getModel('article/article');
                    $timeweight = Mage::helper('article')->getTimeWeight($form['deadlinetime']);
                    
                    if($form['betSide'] == 1){
                        $article->setAgree($form['betAmount']);
                        $article->setAgreeWeight($timeweight*$form['betAmount']);
                        $betAmount = $form['betAmount'];
                        $bet->setAgree($form['betAmount']);
                        $bet->setAgreeWeight($timeweight*$form['betAmount']);
                    }
                    elseif($form['betSide'] == 2){
                        $article->setDisagree($form['betAmount']);
                        $article->setDisagreeWeight($timeweight*$form['betAmount']);
                        $betAmount = $form['betAmount'];
                        $bet->setDisagree($form['betAmount']);
                        $bet->setDisagreeWeight($timeweight*$form['betAmount']);
                    }
                    else{
                        Mage::throwException('You have to choose side to bet.');
                    }
                    
                    $article->setTitle($form['title'])
                            ->setContent($form['content'])
                            ->setDeadlineTime($form['deadlinetime'])
                            ->setEventTime($form['eventtime'])
                            ->setCreatedTime($time)
                            ->setCategory($form['category'])
                            ->setTotalBets($form['betAmount'])
                            ->setStatus('available')
                            ->setUserPost($customer->getId())
                            ->save();
                            
                    $customer->setBalance($customer->getBalance() - 0.10 - $betAmount)->save();                    //write log
                    
                    $bet->setCustomerId($customer->getId())
                        ->setBetDate(date("Y-m-d H:i:s"));
                    if($article->isObjectNew()){
                        $bet->setArticleId($article->getArticleId())->save();
                        $log_txt = '<a href="'. Mage::getUrl('article/index/item?id=') . $article->getArticleId() . '>Bet</a>';
                    }
                    
                    $log->setCustomerId($customer->getId())
                        ->setAmount(-1*$this->getRequest()->getPost('betAmount'))
                        ->setCreatedDate(date("Y-m-d H:i:s"))
                        ->setLog($log_txt)
                        ->save();
                    $this->_redirect('*/*/');
                    
                } catch (Exception $e){
                    Mage::getSingleton('article/article')->addError($e->getMessage());
                    $this->_redirect('*/*/new');
                }
            }
            else{
                echo Mage::helper('article')->__('Not enough balance.');
                $this->_redirect('*/*/new');
            }            
        }
    }
    
    public function itemAction()
    {
        $this->loadLayout();       
        if(!$this->getRequest()->getParam('id')){
            $this->_redirect('*/*/');
        }
        $item = Mage::getModel('article/article')->load($this->getRequest()->getParam('id')); 
                 
		$id = $this->getRequest()->getParam('id'); 
        if(($this->getRequest()->getParam('id') >= 1) && ($this->getRequest()->getParam('id') <= count(Mage::getModel('article/article')->getCollection()))){
            
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
        $customer = Mage::getSingleton('customer/session')->getCustomer();
        $bet = Mage::getModel('article/bet');
        $log = Mage::getModel('article/log');
        $article = Mage::getModel('article/article');
        
        $log_txt = '<a href="'. Mage::getUrl('article/index/item?id=') . $this->getRequest()->getPost('itemId') . '>Bet</a>';
        
        if($this->getRequest()->getPost()){
            $item = Mage::getModel('article/article')->load($this->getRequest()->getPost('itemId'));
            $bet->setCustomerId($customer->getId())
                ->setArticleId($this->getRequest()->getPost('itemId'))
                ->setBetDate(date("Y-m-d H:i:s"));
            
            if($customer->getBalance() > $this->getRequest()->getPost('amount')){
                if($this->getRequest()->getPost('betSide') == 1){
                    if($this->getRequest()->getPost('amount') % 0.010 != 0){                    
                        Mage::throwException('Your bet must be a multiple of 0.010.');
                    }
                    else{
                        $bet->setAgree($this->getRequest()->getPost('amount'))
                            ->setAgreeWeight(Mage::helper('article')->getTimeWeight($item->getDeadlineTime()) * $this->getRequest()->getPost('amount'))
                            ->save();
                        
                        $customer->setBalance($customer->getBalance() - $this->getRequest()->getPost('amount'))->save();
                        
                        $log->setCustomerId($customer->getId())
                            ->setAmount(-1*$this->getRequest()->getPost('amount'))
                            ->setCreatedDate(date("Y-m-d H:i:s"))
                            ->setLog($log_txt)
                            ->save();
                        
                        $article->setAgree($article->getAgree() + $this->getRequest()->getPost('amount'))
                                ->setAgreeWeight($article->getAgreeWeight()+ Mage::helper('article')->getTimeWeight($item->getDeadlineTime()) * $this->getRequest()->getPost('amount'))
                                ->save();
                        
                        $this->_redirect('*/*/success');
                    }
                }
                elseif($this->getRequest()->getPost('betSide') == 2){
                    if($this->getRequest()->getPost('amount') % 0.010 != 0){                    
                        Mage::throwException('Your bet must be a multiple of 0.010.');
                    }
                    else{
                        $bet->setDisagree($this->getRequest()->getPost('amount'))
                            ->setDisagreeWeight(Mage::helper('article')->getTimeWeight($item->getDeadlineTime()) * $this->getRequest()->getPost('amount'))
                            ->save();
                        
                        $customer->setBalance($customer->getBalance() - $this->getRequest()->getPost('amount'))->save();
                        
                        $log->setCustomerId($customer->getId())
                            ->setAmount(-1*$this->getRequest()->getPost('amount'))
                            ->setCreatedDate(date("Y-m-d H:i:s"))
                            ->setLog($log_txt)
                            ->save();
                        
                        $article->setDisagree($article->getDisagree() + $this->getRequest()->getPost('amount'))
                                ->setDisagreeWeight($article->getDisagreeWeight()+ Mage::helper('article')->getTimeWeight($item->getDeadlineTime()) * $this->getRequest()->getPost('amount'))
                                ->save();
                        
                        $this->_redirect('*/*/success');
                    }
                }
                else{
                    Mage::getSingleton('adinhtml/session')->addError(Mage::helper('article')->__('You have to choose bet side.'));
                    Mage::throwException('You have to choose bet side.');
                }
            }
            else{
                Mage::getSingleton('adminhtml/session')->addError(Mage::helper('article')->__('Not enough balance.'));
                throw new Exception('Not enough balance2');
            }
        }
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
    
    public function successAction(){
    	$this->loadLayout();
        $this->renderLayout();       
    }
}