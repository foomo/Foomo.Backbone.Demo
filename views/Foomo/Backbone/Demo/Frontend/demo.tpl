<?php

/* @var $model Foomo\Backbone\Demo\Frontend\Model */
/* @var $view Foomo\MVC\View */

$getHeight = function($code) use($view) {
	return $view->escape((count(explode(PHP_EOL, $code)) + 2) * 15.5);
};

$model->demo->code = file_get_contents($model->demo->code);
$model->demo->template = file_get_contents($model->demo->template);

$demo = $model->demo;

$demoName = ucfirst($demo->name);
$jsonTemplate = json_encode($demo->template);
\Foomo\HTMLDocument::getInstance()
	->addJavascriptToBody(<<<JS
		window.demo{$demoName} = new {$demoName}View({
			el:$('#demoApp{$demoName}'),
			template:_.template({$jsonTemplate})
		});
		if(Demo.Specs.specify{$demoName}) {
			Demo.Specs.specify{$demoName}();
			$("#runJasmineSpec").click(function() {
				jasmine.getEnv().execute();
			});
		} else {
			$("#runJasmineSpec").hide();
		}
		$("#tabs a").click(function (e) {
			e.preventDefault();
			$(this).tab("show");
		})
JS
)
;

?>
<?= $view->partial('header') ?>
<div class="clearfix"></div>
<div class="page">
	<div class="intro">
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
	</div>

	<div class="clearfix"></div>

	<div class="app">
		<div id="tabs">
			<!-- Only required for left/right tabs -->
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
			</div>
			<div>
				<a id="runJasmineSpec" class="btn">(Re)Run Spec</a>
				<div id="html-reporter"></div>
			</div>
		</div>
	</div>
</div>
<?= $view->partial('footer') ?>
