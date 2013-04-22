<?php

/*
 * This file is part of the foomo Opensource Framework.
 * 
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */

namespace Foomo\Backbone\Demo;
 
/**
 * @link www.foomo.org
 * @license www.gnu.org/licenses/lgpl.txt
 * @author jan
 */
 
use Foomo\Less;
use Foomo\MVC;
use Foomo\Router\MVC\AppRunner;
use Foomo\Router\MVC\URLHandler;
use Foomo\Timer;

class Router extends \Foomo\Router {
	private $app;
	public function __construct()
	{
		parent::__construct();
		$this->app = new Frontend();
		$this->addRoutes(array(
		));
	}
	private static function setupDoc($debug = true)
	{
		$doc = \Foomo\HTMLDocument::getInstance();
		// less
		$doc->addStylesheets(array(
			Less::create(Module::getBaseDir('less') . DIRECTORY_SEPARATOR . 'Frontend.less')
				->watch($debug)
				->compress(!$debug)
				->compile()
				->getOutputPath(),
			Module::getHtdocsPath('bootstrap/css/' . ($debug?'bootstrap':'bootstrap.min') . '.css'),
			Module::getHtdocsPath('bootstrap/css/' . ($debug?'bootstrap-responsive':'bootstrap-responsive.min') . '.css'),
		));
		// backbone
		$doc->addJavascripts(array(
			\Foomo\JS::create(\Foomo\Backbone\Module::getHtdocsDir('js') . DIRECTORY_SEPARATOR . 'bootstrap.js')
				->watch()
				->compile()
				->getOutputPath()
			,
			\Foomo\JS::create(\Foomo\Backbone\Demo\Module::getHtdocsDir('js') . DIRECTORY_SEPARATOR . 'bootstrap.js')
				->watch()
				->compile()
				->getOutputPath()
			,
			\Foomo\TypeScript::create(\Foomo\Backbone\Module::getBaseDir('typescript') . DIRECTORY_SEPARATOR . 'demo.ts')
				->displayCompilerErrors()
				->compile()
				->getOutputPath()

		));
		// bootstrap
	}
	public static function run()
	{
		self::setupDoc();
		URLHandler::strictParameterHandling(true);
		URLHandler::exposeClassId(false);
		MVC::hideScript(true);
		$router = new self();
		return AppRunner::run($router->app, $router, '');
	}
}
