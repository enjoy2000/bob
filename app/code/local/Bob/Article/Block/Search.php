<?php

class Bob_Article_Block_Search extends Mage_Core_Block_Template
{
	protected function _prepareLayout(){
		
		if($this->getRequest()->getQuery('s')){
		    $posts = Mage::getModel('article/article')->getCollection()->addFieldToFilter('status', $this->getRequest()->getQuery('s'));
		}
        else{
            $posts = Mage::getModel('article/article')->getCollection()->addFieldToFilter('status', 'available');
        }
        $this->setPosts($posts);
		parent::_prepareLayout();
	}
}
        