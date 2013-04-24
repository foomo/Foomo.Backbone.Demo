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

$model->demo->code = file_get_contents($model->demo->code);
$model->demo->template = file_get_contents($model->demo->template);
?>
<?= $view->partial('header') ?>
<div class="clearfix"></div>
<? $demo = $model->demo ?>
<div class="page">
	<div class="intro">
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
	</div>

	<div class="clearfix"></div>

	<div class="app">
		<div id="tabs"> <!-- Only required for left/right tabs -->
			<ul class="nav nav-tabs">
				<li class="active">
					<a href="#template" data-toggle="tab">Template</a>
				</li>
				<li>
					<a href="#code" data-toggle="tab">Code</a>
				</li>
				<li>
					<a href="#both" data-toggle="tab">Both</a>
				</li>
				<li>
					<a href="#test" data-toggle="tab">Test</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active" id="template">
					<iframe
						src="<?= $view->url('template', array($demo->name)) ?>"
						height="<?= $getHeight($demo->template) ?>"
					></iframe>
				</div>
				<div class="tab-pane" id="code">
					<iframe
						src="<?= $view->url('code', array($demo->name)) ?>"
						height="<?= $getHeight($demo->code) ?>"
					></iframe>
				</div>
				<div class="tab-pane" id="both">
					<div class="span6 pull-left">
						<iframe
							src="<?= $view->url('template', array($demo->name)) ?>"
							height="<?= $getHeight($demo->code) ?>"
						></iframe>
					</div>
					<div class="span6 pull-left">
						<iframe
							src="<?= $view->url('code', array($demo->name)) ?>"
							height="<?= $getHeight($demo->code) ?>"
						></iframe>

					</div>
					<div class="clearfix"></div>
				</div>
				<div class="tab-pane" id="test">
					<a id="runJasmineSpec" class="btn">Run Spec</a>
					<div id="reporter"></div>
					<script>
						$(document).ready(function() {
							if(Demo.Specs.specify<?= ucfirst($demo->name) ?>) {
								Demo.Specs.specify<?= ucfirst($demo->name) ?>();
								var jasmineEnv = jasmine.getEnv();
								jasmineEnv.updateInterval = 1000;
								var htmlReporter = new jasmine.HtmlReporter();
								jasmineEnv.addReporter(htmlReporter);
								jasmineEnv.specFilter = function(spec) {
									return htmlReporter.specFilter(spec);
								};
								$('#runJasmineSpec').click(function() {
									jasmineEnv.execute();
									$('#reporter').append($('#HTMLReporter'));
								});
							} else {
								$('#runJasmineSpec').hide();
							}
						});
					</script>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('#tabs a').click(function (e) {
				e.preventDefault();
				$(this).tab('show');
			})
		});
	</script>

</div>
<?= $view->partial('footer') ?>
