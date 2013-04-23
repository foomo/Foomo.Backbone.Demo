<?php

/* @var $model Foomo\Backbone\Demo\Frontend\Model */
/* @var $view Foomo\MVC\View */

?>
<?= $view->partial('geshi', array('code' => $model->demo->template, 'language' => 'html4strict')) ?>