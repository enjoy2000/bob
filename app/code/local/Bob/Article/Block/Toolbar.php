<?php
class Blog_User_Block_Posts extends Mage_Catalog_Block_Product_List
{
    protected function _beforeToHtml()
    {
        $toolbar = $this->getToolbarBlock();
        $collection = $this->_getPostsCollection();
        $toolbar->setCollection($collection);     /*(Add toolbar to collection)*/
        return parent::_beforeToHtml();
    }
}