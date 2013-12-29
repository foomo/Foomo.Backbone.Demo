<?php

/**
\Foomo\HTMLDocument::getInstance()->addBody('
<script>
	var Backbone = window["Backbone"];
	var Backbone;
	alert(Backbone);
</script>
');
return ;
*/
/* @var $model Foomo\Backbone\Demo\Frontend\Model */
/* @var $view Foomo\MVC\View */
$getHeight = function($code) use($view) {
	return $view->escape((count(explode(PHP_EOL, $code)) + 2) * 15.5);
};
\Foomo\HTMLDocument::getInstance()->addJavascriptToBody(<<<JS
	console.log("jasmineOptions", jasmine.getEnv());
JS
);
foreach($model->demos as $demo) {
	$demo->code = file_get_contents($demo->code);
	$demo->template = file_get_contents($demo->template);
	$demoName = ucfirst($demo->name);
	$jsonTemplate = json_encode($demo->template);
	\Foomo\HTMLDocument::getInstance()->addJavascriptToBody(<<<JS
		window.demo{$demoName} = new {$demoName}View({el:$('#demoApp{$demoName}'), template:_.template({$jsonTemplate})});
		if(Demo.Specs.specify{$demoName}) {
			Demo.Specs.specify{$demoName}();
		}
JS
);
}
?>
<?= $view->partial('header') ?>
<div class="clearfix"></div>
<div class="page">
	<div class="intro">
		<?
			foreach($model->demos as $demo) :

		?>
			<div class="span12">
				<h2><?= $view->escape($demo->label) ?></h2>
			</div>
			<div class="clearfix"></div>
			<div class="span6 demo pull-left" id="demoApp<?= ucfirst($demo->name) ?>" class="container well well-small span9">
			</div>
			<div class="span5 pull-right">
				<?= $demo->description ?>
			</div>
			<div class="clearfix"></div>
		<? endforeach; ?>
	</div>

	<div class="clearfix"></div>

	<div id="html-reporter"></div>

</div>
<?= $view->partial('footer') ?>
