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


?><div class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container-fluid">
			<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="brand" href="#">Backbone.Components</a>
			<div class="nav-collapse collapse">
				<p class="navbar-text pull-right">
					&nbsp;
				</p>
				<ul class="nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">About</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div>
</div>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span3">
			<div class="well sidebar-nav">
				<ul class="nav nav-list">
					<? foreach($model->demos as $demo): ?>
						<li><a href="#<?= $demo->name ?>" title="<?= $view->escape($demo->description) ?>"><?= $view->escape($demo->label) ?></a></li>
					<? endforeach; ?>
				</ul>
			</div><!--/.well -->
		</div><!--/span-->
		<div class="span9">
