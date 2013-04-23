<?php

class Bob_Article_Block_Index extends Mage_Core_Block_Template
{
	protected function _prepareLayout(){
		
		//var_dump(count(Mage::getModel('article/category')->getCollection()));die;
		
		$connection = Mage::getSingleton('core/resource')->getConnection('core_write');
		$categories = $connection->fetchAll('SELECT `name` FROM `article_category`');
		$this->setCategories($categories);
		parent::_prepareLayout();
	}
}