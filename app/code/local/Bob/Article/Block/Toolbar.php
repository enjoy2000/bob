<?php
class Bob_Article_Block_Toolbar extends Mage_Catalog_Block_Product_List
{
    protected function _beforeToHtml()
    {
        $toolbar = $this->getToolbarBlock();
        $collection = $this->_getPostsCollection();
        $toolbar->setCollection($collection);     /*(Add toolbar to collection)*/
        return parent::_beforeToHtml();
    }
}