package com.core.screens
{
	import flash.display.*;
	
	/**
	 * Screen Manager
	 */
	public class ScreenManager extends Object
	{
		private var current:ScreenManager;
		public var name:String;
		protected var transitions:Object;
		protected var screens:Object;
		
		protected var stage:DisplayObjectContainer;
		protected var Asset:Class;
		protected var screenInstance:Screen;

		public function ScreenManager(stage:DisplayObjectContainer, Asset:Class = null)
		{
			this.stage = stage;
			this.Asset = Asset;
			this.transitions = { };
			this.screens = { };
		}

		/**
		 * Register a screen.
		 *
		 * @param name Unique id for the screen.
		 * @param Asset Reference to a DisplayObject-derived class. The instance will be created and added to the stage when the state is entered.
		 */
		public function registerScreen(name:String, Asset:Class = null):ScreenManager
		{
			var screen:ScreenManager = new ScreenManager(stage, Asset);
			screens[name] = screen;
			screen.name = name;
			return this;
		}
		
		/**
		 * Exits a Screen 
		 * @param data
		 * 
		 */		
		public function exitScreen(data:* = null):void
		{
			current.exit(data);
			current = null;
		}

		/**
		 * Enters a Screen 
		 * @param name
		 * @param data
		 * 
		 */		
		public function enterScreen(name:String, data:* = null):void
		{
			current = getScreen(name);
			current.enter(data);
		}
		
		/**
		 * Updates current Screen 
		 * @param delta
		 * 
		 */		
		public function update(delta:Number):void {
			if(current && current.screenInstance)
				current.screenInstance.update(delta);
		}
		
		/** Return the <code>IState</code> instance with the given id. */
		public function getScreen(name:String):ScreenManager
		{
			if (!screens[name])
				throw new Error('Unknown state: ' + name);
			return screens[name];
		}
		
		public function onEvent(event:String):Transition {
			if (!transitions[event]) 
				transitions[event] = new Transition(event, this);
			return transitions[event];
		}

		/** @inheritDoc */
		public function enter(data:* = null):void
		{
			if (Asset != null)
			{
				screenInstance = new Asset();
				screenInstance.name = name;
				stage.addChild(screenInstance);
				screenInstance.enter(data);
			}
		}
		
		/** @inheritDoc */
		public function dispatchEvent(event:String, data:* = null):void 
		{
			if (transitions[event])
				goto(transitions[event].screen,data);
		}
		
		public function goto(name:String, data:* = null):void
		{
			if (current && current.name == name) return;
			exitScreen(data);
			enterScreen(name, data);
		}

		/** @inheritDoc */
		public function exit(data:* = null):void
		{
			if (screenInstance != null)
			{
				screenInstance.exit(data);
				screenInstance.dispose();
				screenInstance = null;
			}
		}
		
		/** dispose all substates. */
		public function dispose():void
		{
			for (var name:String in screens)
			{
				getScreen(name).dispose();
				delete screens[name];
			}
			
			for (var id:String in transitions)
			{
				delete transitions[id];
			}
		}
		
		public function start(name:String):void 
		{
			enterScreen(name);
		}

	}
}
