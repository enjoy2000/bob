<?php
 
class Bob_Article_Block_Adminhtml_Article_Grid extends Mage_Adminhtml_Block_Widget_Grid
{
    public function __construct()
    {
        parent::__construct();
        $this->setId('articleGrid');
        // This is the primary key of the database
        $this->setDefaultSort('article_id');
        $this->setDefaultDir('ASC');
        $this->setSaveParametersInSession(true);
        $this->setUseAjax(true);
    }
 
    protected function _prepareCollection()
    {
        $collection = Mage::getModel('article/article')->getCollection();
        $this->setCollection($collection);
        return parent::_prepareCollection();
    }
 
    protected function _prepareColumns()
    {
        $this->addColumn('article_id', array(
            'header'    => Mage::helper('article')->__('ID'),
            'align'     =>'right',
            'width'     => '50px',
            'index'     => 'article_id',
        ));
 
        $this->addColumn('title', array(
            'header'    => Mage::helper('article')->__('Title'),
            'align'     =>'left',
            'index'     => 'title',
        ));
                
        $this->addColumn('decision', array(
            'header'    => Mage::helper('article')->__('decision'),
            'width'     => '120px',
            'index'     => 'decision',
            'type'      => 'options',
            'options'   => array(
                '1'   => 'True',
                '0'   => 'False',
            )
        ));
 
        $this->addColumn('created_time', array(
            'header'    => Mage::helper('article')->__('Creation Time'),
            'align'     => 'left',
            'width'     => '120px',
            'type'      => 'date',
            'default'   => '--',
            'index'     => 'created_time',
        ));
 
        $this->addColumn('deadline_time', array(
            'header'    => Mage::helper('article')->__('Deadline Time'),
            'align'     => 'left',
            'width'     => '120px',
            'type'      => 'date',
            'default'   => '--',
            'index'     => 'deadline_time',
        ));
        
        $this->addColumn('event_time', array(
            'header'    => Mage::helper('article')->__('Event Time'),
            'align'     => 'left',
            'width'     => '120px',
            'type'      => 'date',
            'default'   => '--',
            'index'     => 'event_time',
        ));   
 
 
        $this->addColumn('status', array(
 
            'header'    => Mage::helper('article')->__('Status'),
            'align'     => 'left',
            'width'     => '80px',
            'index'     => 'status',
            'type'      => 'options',
            'options'   => array(
                'awaiting'   => 'awaiting',
                'available'  => 'available',
                'waiting'    => 'waiting',
                'closed'     => 'closed',                
                'rejected'   => 'rejected',
            ),
        ));
 
        return parent::_prepareColumns();
    }


    protected function _prepareMassaction()
    {
    	$this->setMassactionIdField('article_id');
    	$this->getMassactionBlock()->setFormFieldName('article_id');
    
    	$this->getMassactionBlock()->addItem('delete', array(
    			'label'    => Mage::helper('article')->__('Delete'),
    			'url'      => $this->getUrl('*/*/massDelete'),
    			'confirm'  => Mage::helper('article')->__('Are you sure?')
    	));
    
    	$this->getMassactionBlock()->addItem('awaiting', array(
    			'label'    => Mage::helper('article')->__('Awaiting'),
    			'url'      => $this->getUrl('*/*/massawaiting')
    	));
    
    	$this->getMassactionBlock()->addItem('available', array(
    			'label'    => Mage::helper('article')->__('Available'),
    			'url'      => $this->getUrl('*/*/massAvailable')
    	));
        
        $this->getMassactionBlock()->addItem('waiting', array(
    			'label'    => Mage::helper('article')->__('Waiting'),
    			'url'      => $this->getUrl('*/*/massWaiting')
    	));
        
        $this->getMassactionBlock()->addItem('closed', array(
    			'label'    => Mage::helper('article')->__('Closed'),
    			'url'      => $this->getUrl('*/*/massClosed')
    	));
        
        $this->getMassactionBlock()->addItem('rejected', array(
    			'label'    => Mage::helper('article')->__('Rejected'),
    			'url'      => $this->getUrl('*/*/massRejected')
    	));
    
    	return $this;
    }
 
    public function getRowUrl($row)
    {
        return $this->getUrl('*/*/edit', array('id' => $row->getId()));
    }
 
    public function getGridUrl()
    {
      return $this->getUrl('*/*/grid', array('_current'=>true));
    }
 
 
}