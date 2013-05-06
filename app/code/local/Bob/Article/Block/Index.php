<?php

class Bob_Article_Block_Index extends Mage_Core_Block_Template
{
    public function __construct()
    {
        parent::__construct();
        $request = $this->getRequest();
        $articles = Mage::getModel('article/article')->getCollection();
        $articles->setPageSize(10);
        $articles->setCurPage($request->getQuery('10'));  
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
            $articles->addFieldToFilter('status', 'available')->load();
        }
        $this->setCollection($articles);
    }
 
    protected function _prepareLayout()
    {
        parent::_prepareLayout();
 
        $pager = $this->getLayout()->createBlock('page/html_pager', 'custom.pager');
        $pager->setPageVarName(10);
        $pager->setShowPerPage(10);
        $pager->setLimit(10);
        $pager->setLimitVarName(10);
        $pager->setCollection($this->getCollection());
        $pager->canShowNextJump();
        $this->setChild('pager', $pager);
        $this->getCollection()->load();
        return $this;
    }
 
    public function getPagerHtml()
    {
        return $this->getChildHtml('pager');
    }
    
    protected function _beforeToHtml()
    {
    	parent::_beforeToHtml();
    	$this->getCollection()->setCurPage($this->getRequest()->getQuery('10'))->load();
    	return $this;
    }
}