package com.core.utils 
{
	/**
	 * ...
	 * @author Lino Rabolini
	 */
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	 
	public dynamic class Settings extends Object 
	{
		
		private var _jsonLoader:URLLoader = new URLLoader();
		private var _callback:Function = null;
		private var filesToLoad:int;
		
		/**
		 * Init the structure 
		 * 
		 */		
		public function Settings() 
		{
			filesToLoad = 0;
			_jsonLoader.addEventListener(Event.COMPLETE, processJson);
			_jsonLoader.addEventListener(IOErrorEvent.IO_ERROR, _notify);
		}
		
		/**
		 * Error handler
		 * @param e
		 * 
		 */		
		private function _notify(e:IOErrorEvent):void {
			trace("error");
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, _notify);
		}
		
		/**
		 * Loads a file from a path 
		 * @param file:String
		 * 
		 */		
		public function loadFile(file:String):void {
			filesToLoad++;
			try {
				_jsonLoader.load( new URLRequest(file) );
			} catch (error:Error) {
				// handle issue if file is not able to be loaded
				
				var data:Object = {
					"gameData": {
						"ballStartPos":	{
							"x":400,
							"y": 240
						},
						"paddle":{
							"maxSpeed" : 3,
							"bouncingForce" : 1.0
						},
						"ball": {
							"initialSpeed": 3,
							"speedIncrement": 0.2,
							"forceDecrement": 0.97
						}
					}
				}
				
				ObjectUtil.copy(data, this, true);
				filesToLoad--;
				if (filesToLoad == 0 && _callback != null)
					_callback();
			}
		}
		
		/**
		 * Load several files 
		 * @param files
		 * 
		 */		
		public function loadFiles(files:Array):void {
			for each (var file:String in files)
				loadFile(file);
		}
		
		/**
		 * Process JSON 
		 * @param e
		 * 
		 */		
		public function processJson(e:Event):void {
			filesToLoad--;
			
			var temp:Object;
			var stringJson:String = String (e.target.data);
			
			temp = JSON.parse(stringJson);
			
			ObjectUtil.copy(temp, this, true);
			
			if (filesToLoad == 0 && _callback != null)
				_callback();
		}
		
		/**
		 * Handles the load end event 
		 * @param callback
		 * @return 
		 * 
		 */		
		public function onLoad(callback:Function):Settings 
		{
			_callback = callback;
			return this
		}
		
		
	}

}