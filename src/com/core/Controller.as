package com.core
{
	
	public class Controller
	{
		public static const TRUE:Number = 1;
		public static const FALSE:Number = 0;
		public static const MOUSE_X:String = 'MouseX';
		public static const MOUSE_Y:String = 'MouseY';
		public static const MOUSE_LEFT:String = 'MouseL';
		public static const MOUSE_RIGHT:String = 'MouseR';
		
		private var status:Object;
		
		
		public function Controller(initialStatus:Object=null)
		{
			this.status = initialStatus || {};
		}

		public function set(inputCode:String, value:Number):void
		{
			status[inputCode] = value;
		}

		public function get(inputCode:String):Number
		{
			return status[inputCode] || FALSE;
		}

	}
}