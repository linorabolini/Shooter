package com.core.screens 
{
	/**
	 * ...
	 * @author 
	 */
	public class Transition 
	{
		private var screenManager:ScreenManager;
		private var _screen:String;
		public var id:String;
		
		public function Transition(id:String,screenManager:ScreenManager) 
		{
			this.id = id;
			this.screenManager = screenManager;
		}
		
		public function goto(name:String):Transition
		{
			_screen = name;
			return this;
		}
		
		public function get screen():String {
			return _screen;
		}
		
		public function onEvent(event:String):Transition
		{
			return screenManager.onEvent(event);
		}
		
	}

}