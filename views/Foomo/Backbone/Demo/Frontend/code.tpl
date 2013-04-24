<?php

/* @var $model Foomo\Backbone\Demo\Frontend\Model */
/* @var $view Foomo\MVC\View */
?>
<?= $view->partial('geshi', array('code' => file_get_contents($model->demo->code), 'language' => 'Javascript')) ?>