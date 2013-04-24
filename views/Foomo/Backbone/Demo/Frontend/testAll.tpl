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

?>
<?= $view->partial('header') ?>
<div class="clearfix"></div>
<div class="page">
	<div class="intro">
		<?
			foreach($model->demos as $demo) :
				$demo->code = file_get_contents($demo->code);
				$demo->template = file_get_contents($demo->template);

		?>
			<div class="span12">
				<h2><?= $view->escape($demo->label) ?></h2>
			</div>
			<div class="clearfix"></div>
			<div class="span6 demo pull-left" id="demoApp<?= ucfirst($demo->name) ?>" class="container well well-small span9">
				<script>
					$(document).ready(function() {
						window.demo<?= ucfirst($demo->name) ?> = new <?= ucfirst($demo->name) ?>View({el:$('#demoApp<?= ucfirst($demo->name) ?>'), template:_.template(<?= json_encode($demo->template) ?>)});
					});
				</script>
			</div>
			<div class="span5 pull-right">
				<?= $demo->description ?>
			</div>
			<div class="clearfix"></div>
		<? endforeach; ?>
	</div>

	<div class="clearfix"></div>

	<div>
		<div id="reporter"></div>
		<script>
			$(document).ready(function() {
				var jasmineEnv = jasmine.getEnv();
				jasmineEnv.updateInterval = 1000;
				var htmlReporter = new jasmine.HtmlReporter();
				jasmineEnv.addReporter(htmlReporter);
				jasmineEnv.specFilter = function(spec) {
					return htmlReporter.specFilter(spec);
				};
<? foreach($model->demos as $demo) : ?>
				if(Demo.Specs.specify<?= ucfirst($demo->name) ?>) {
					Demo.Specs.specify<?= ucfirst($demo->name) ?>();
				}
<? endforeach; ?>
				jasmineEnv.execute();
			});
		</script>
	</div>
</div>
<?= $view->partial('footer') ?>
