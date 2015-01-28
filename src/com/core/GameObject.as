package com.core
{	
	import flash.display.Sprite;
	import com.core.components.Component;

	public class GameObject extends Sprite
	{
		public var components:Array;
		public var toDelete:Boolean = false;
		
		/**
		 * General Game Object 
		 * @param view
		 * 
		 */		
		public function GameObject(components:Array=null)
		{
			this.components = [];
			if(components != null)
			{
				this.addComponents(components);
			}
			
		}
		
		public function addComponents(components:Array):void
		{
			for each(var component:Component in components)
			{
				this.addComponent(component);
			}
		}
		
		public function addComponent(component:Component):void
		{
			component.setup(this);
			this.components.push(component);
		}
		
		/**
		 * Dispose the game object 
		 * 
		 */		
		public function dispose():void {
			toDelete=true;
			
			for each(var component:Component in components)
			{
				component.dispose(this);
			}
		}

		/**
		 * Virtual Update 
		 * @param delta
		 * 
		 */		
		public function update(delta:Number):void
		{
			for each(var component:Component in components)
			{
				component.update(this, delta);
			}
		}
	}
}