<?php

/* @var $model Foomo\Backbone\Demo\Frontend\Model */
/* @var $view Foomo\MVC\View */
$foo = $_SERVER['REQUEST_URI'];
$getHeight = function($code) use($view) {
	return $view->escape((count(explode(PHP_EOL, $code)) + 2) * 15.5);
}
?>
<?= $view->partial('header') ?>
<div class="well span9">
	<h1>Components, backbone style.</h1>
	<p>This is our idea, of how to to html components backbone style.</p>
</div>
<div class="clearfix"></div>
<? foreach($model->demos as $demo): ?>
	<div>
		<div>
			<h2><?= $view->escape($demo->label) ?></h2>
			<div>
				<?= $view->escape($demo->description) ?>
			</div>
		</div>

		<div class="row-fluid">
			<h3>App</h3>
			<div class="demo" id="demoApp<?= ucfirst($demo->name) ?>" class="container well well-small span9"></div>
			<script>
				$(document).ready(function() {
					window.demo<?= ucfirst($demo->name) ?> = new <?= ucfirst($demo->name) ?>View({el:$('#demoApp<?= ucfirst($demo->name) ?>'), template:_.template(<?= json_encode($demo->template) ?>)});
				});
			</script>
		</div>

		<div class="row-fluid">
			<h3>Template</h3>
			<iframe
				class="container well well-small span9"
				src="<?= $view->url('template', array($demo->name)) ?>"
				height="<?= $getHeight($demo->template) ?>"
			></iframe>
		</div>

		<div class="row-fluid">
			<h3>Code</h3>
			<iframe
				class="container well well-small span9"
				src="<?= $view->url('code', array($demo->name)) ?>"
				height="<?= $getHeight($demo->code) ?>"
			></iframe>
		</div>

	</div>
<? endforeach; ?>
<?= $view->partial('footer') ?>
