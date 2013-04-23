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

namespace Foomo\Backbone\Demo\Frontend;

use Foomo\Backbone\Demo\Vo\Demo;
use Foomo\Backbone\Demo\Module;

/**
 * @link www.foomo.org
 * @license www.gnu.org/licenses/lgpl.txt
 * @author jan
 */
class Controller
{
	/**
	 * my model
	 *
	 * @var Model
	 */
	public $model;
	public function actionDefault()
	{
		$this->loadDemos();
	}
	public function actionTemplate($name)
	{
		$this->loadDemos($name);
	}
	public function actionCode($name)
	{
		$this->loadDemos($name);
	}
	private function loadDemos($current = null)
	{
		$tsDir = Module::getBaseDir('typescript');
		foreach(
			array(
				'simple' => array(
					'description' => 'A simple thingie',
					'label' => 'Simple'
				)
			) as $name => $data
		) {
			$demo = new Demo();
			$demo->name = $name;
			$demo->label = $data['label'];
			$demo->description = $data['description'];
			$demo->code = file_get_contents($tsDir . DIRECTORY_SEPARATOR .  $name . '.ts');
			$demo->template = file_get_contents($tsDir . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . ucfirst($name) . 'View.html');
			$this->model->demos[$demo->name] = $demo;
		}
		if($current) {
			$this->model->demo = $this->model->demos[$name];
		}
	}
}
