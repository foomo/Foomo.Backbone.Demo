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
use Foomo\MVC;
use Foomo\SimpleData;

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
		$this->model->page = 'default';
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
	public function actionDemo($name = '')
	{
		$this->model->page = 'demo';
		$this->loadDemos($name);
	}
	public function actionTestAll()
	{
		$this->model->page = 'test';
		$this->loadDemos();
	}
	private function loadDemos($current = null)
	{
		$tsDir = Module::getBaseDir('typescript');
		$rawData = array();
		foreach(SimpleData::read(\Foomo\Backbone\Demo\Module::getBaseDir('simpleData'))->data as $name => $data) {
			$rawData[$name] = SimpleData\VoMapper::map($data, new Demo);
		}
		foreach($rawData as $demo) {
			$demo->description = file_get_contents($demo->description);
			$demo->code = $tsDir . DIRECTORY_SEPARATOR .  $demo->name . '.ts';
			$demo->template = $tsDir . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . ucfirst($demo->name) . 'View.html';
			$this->model->demos[$demo->name] = $demo;
		}
		if(!$current) {
			$keys = array_keys($this->model->demos);
			$current = $keys[0];
			// MVC::redirect('demo', array($current));
		}
		$this->model->demo = $this->model->demos[$current];
	}
}
