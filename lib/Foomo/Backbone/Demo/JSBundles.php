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

class JSBundles {
	public static function demo($debug = null)
	{
		$debug = self::getDebug($debug);
		return \Foomo\JS\Bundle::create('backbone-demo')
			->debug($debug)
			->merge(
				\Foomo\TypeScript\Bundle::create(
					'demo',
					Module::getBaseDir('typescript')
				)
				->debug($debug)
			)
			->merge(
				\Foomo\JS\Bundle::create('')
					->addJavaScripts(array(
						\Foomo\Backbone\Demo\Module::getHtdocsDir('js') . DIRECTORY_SEPARATOR . 'bootstrap.js'
					))
					->addDependency(\Foomo\Backbone\JSBundles::backboneComponents($debug))
					->debug($debug)
			)
		;
	}
	private static function getDebug($debug)
	{
		if(is_null($debug)) {
			$debug = !\Foomo\Config::isProductionMode();
		}
		return $debug;
	}

}
