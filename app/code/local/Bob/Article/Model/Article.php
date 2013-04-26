<?php
 
class Bob_Article_Model_Article extends Mage_Core_Model_Abstract
{
    public function _construct()
    {
        parent::_construct();
        $this->_init('article/article');
    }
    
    protected function _beforeSave()
    {        
        parent::_beforeSave();
    }
    
    protected function _afterSave()
    {    
        $article = Mage::getModel('article/article')->load($this->getArticleId());
        if($this->getDecision() == 0){
            $bets = Mage::getModel('article/bet')->getCollection()
                    ->addFieldToFilter('article_id', $this->getArticleId())
                    ->addFieldToFilter('status', '1')
                    ->addFieldToFilter('disagree', array(
                            'gt' => '0'
                    ))
                    ->load();
            if(count($bets) < 1){
                Mage::getSingleton('adminhtml/session')->addError(Mage::helper('adminhtml')->__('This statement was closed.'));
            }
            else{
                $amount = 0;
                $submitter = Mage::getModel('customer/customer')->load($article->getUserPost());
                $submitter->setBalance($submitter->getBalance() + $article->getAgree()*0.05)->save();
                $log = Mage::getModel('article/log');
                $log_txt = '<a href="' . Mage::getUrl('article/index/item?id=' . $article->getArticleId()) . '">Submitter</a>';
                $log_txt2 = '<a href="' . Mage::getUrl('article/index/item?id=' . $article->getArticleId()) . '">Win in bet</a>';
                $log->setCustomerId($submitter->getId())
                    ->setCreatedDate(date("Y-m-d H:i:s"))
                    ->setAmount($article->getAgree()*0.05)
                    ->setLog($log_txt)
                    ->save();
                foreach($bets as $bet){
                    $percentBet = $bet->getDisagree()/$article->getDisagree();
                    $percentWeight = $bet->getDisagreeWeight()/$article->getDisagreeWeight();
                    $customer = Mage::getModel('customer/customer')->load($bet->getCustomerId());
                    $customer->setBalance($customer->getBalance() + ($percentBet + $percentWeight)*$article->getAgree()*0.45 )
                             ->save();    
                    $bet->setStatus(0)->save();
                    $amount = $amount + ($percentBet + $percentWeight)*$article->getAgree()*0.45;
                }
                $log = Mage::getModel('article/log'); 
                $log->setCustomerId($customer->getId())
                    ->setCreatedDate(date("Y-m-d H:i:s"))
                    ->setAmount($amount)
                    ->setLog($log_txt2)
                    ->save();
                $article->setStatus('closed')
                    ->save();    
            }            
        }
        elseif($this->getDecision() == 1){
            $bets = Mage::getModel('article/bet')->getCollection()
                    ->addFieldToFilter('article_id', $article->getArticleId())
                    ->addFieldToFilter('status', '1')
                    ->addFieldToFilter('agree', array(
                            'gt' => '0'
                    ))
                    ->load();
            if(count($bets) < 1){
                Mage::getSingleton('adminhtml/session')->addError(Mage::helper('adminhtml')->__('This statement was closed.'));
            }
            else{
                $submitter = Mage::getModel('customer/customer')->load($article->getUserPost());
                $submitter->setBalance($submitter->getBalance() + $article->getDisagree()*0.05)->save();
                $log = Mage::getModel('article/log');
                $log_txt = '<a href="' . Mage::getUrl('article/index/item?id=' . $article->getArticleId()) . '">Submitter</a>';
                $log_txt2 = '<a href="' . Mage::getUrl('article/index/item?id=' . $article->getArticleId()) . '">Win in bet</a>';
                
                $log->setCustomerId($submitter->getId())
                    ->setCreatedDate(date("Y-m-d H:i:s"))
                    ->setAmount($article->getDisagree()*0.05)
                    ->setLog($log_txt)
                    ->save();
                foreach($bets as $bet){
                    $percentBet = $bet->getAgree()/$article->getAgree();
                    $percentWeight = $bet->getAgreeWeight()/$article->getAgreeWeight();
                    $customer = Mage::getModel('customer/customer')->load($bet->getCustomerId());
                    $customer->setBalance($customer->getBalance() + ($percentBet + $percentWeight)*$article->getDisagree()*0.45 )->save();
                    
                    $log = Mage::getModel('article/log'); 
                    $log->setCustomerId($customer->getId())
                        ->setCreatedDate(date("Y-m-d H:i:s"))
                        ->setAmount(($percentBet + $percentWeight)*$article->getDisagree()*0.45)
                        ->setLog($log_txt2)
                        ->save();
                    $bet->setStatus('0')->save();
                }
                $article->setStatus('closed')
                    ->save();     
            }  
        }
        parent::_afterSave();
    } 
}