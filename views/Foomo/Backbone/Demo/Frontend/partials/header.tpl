<?php

/* @var $model Foomo\Backbone\Demo\Frontend\Model */
/* @var $view Foomo\MVC\View */
$debug = true;
\Foomo\HTMLDocument::getInstance()->addStylesheets(array(
	Foomo\Less::create(Foomo\Backbone\Demo\Module::getBaseDir('less') . DIRECTORY_SEPARATOR . 'Frontend.less')
		->watch($debug)
		->compress(!$debug)
		->compile()
		->getOutputPath(),
	Foomo\Backbone\Demo\Module::getHtdocsPath('bootstrap/css/' . ($debug?'bootstrap':'bootstrap.min') . '.css'),
	Foomo\Backbone\Demo\Module::getHtdocsPath('bootstrap/css/' . ($debug?'bootstrap-responsive':'bootstrap-responsive.min') . '.css'),
));


?>
<div class="container-narrow">

	<div class="masthead">
		<div class="pull-left">
			<h3 class="muted">Backbone.Components</h3>
			<div>
				<ul>
					<? foreach($model->demos as $demo): ?>
						<li><?= $view->link($demo->label, 'demo', array($demo->name), array('title' => $view->escape(trim(strip_tags($demo->description))))) ?></li>
					<? endforeach; ?>
				</ul>
			</div>
		</div>
		<ul class="nav nav-pills pull-right">
			<li class="<?= $model->page=='default'?'active':'' ?>"><?= $view->link('Home') ?></li>
			<li class="<?= $model->page=='demo'?'active':'' ?>"><?= $view->link('Demos', 'demo') ?></li>
		</ul>
		<div class="clearfix"></div>
	</div>

	<hr>

	<div class="row-fluid">
