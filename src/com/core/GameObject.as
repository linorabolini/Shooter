package com.core
{	
	import com.core.components.Component;
	
	import flash.display.Sprite;

	public class GameObject extends Sprite
	{
		public var components:Array;
		public var isActive:Boolean = true;
		public var toDelete:Boolean = false;
		private var elapsed:Number = 0;
		
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
			if(toDelete)
				return
			
			toDelete = true;
			
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
			if(!isActive || toDelete)
				return
				
			for each(var component:Component in components)
			{
				component.update(this, delta);
			}
		}
		
		public function activate():void
		{
			this.visible = isActive = true;
			for each(var component:Component in components)
			{
				component.activate(this);
			}
		}
		
		public function deactivate():void
		{
			this.visible = isActive = false;
			for each(var component:Component in components)
			{
				component.deactivate(this);
			}
		}
	}
}