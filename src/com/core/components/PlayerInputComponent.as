package com.core.components
{
	import com.core.Controller;
	import com.core.GameObject;
	
	import flash.geom.Point;

	public class PlayerInputComponent implements Component
	{
		private var controller:Controller;
		private var walkSpeed:Number;
		private var inventory:InventoryComponent;
		public function PlayerInputComponent(controller:Controller, inventory:InventoryComponent, walkSpeed:Number = 1)
		{
			this.controller = controller;
			this.inventory = inventory;
			this.walkSpeed = walkSpeed;
		}
		
		public function setup(g:GameObject):void
		{
		}
		
		public function update(g:GameObject, delta:Number):void
		{
			updatePosition(g, delta);
			updateRotation(g, delta);
			updateInventory(g, delta);
		}
		
		private function updateInventory(g:GameObject, delta:Number):void
		{
			var input:Number = controller.get(Controller.MOUSE_LEFT);
			//var input:Number = controller.get('Q');
			if(input == Controller.TRUE)
			{
				inventory.selectedItem.doUse(g);
			}
		}
		
		private function updateRotation(g:GameObject, delta:Number):void
		{
			var inputX:Number = controller.get(Controller.MOUSE_X);
			var inputY:Number = controller.get(Controller.MOUSE_Y);
			
			var angle:Number = Math.atan2(g.y - inputY, g.x - inputX);
			g.rotation = angle * 180 / Math.PI;
		}
		
		private function updatePosition(g:GameObject, delta:Number):void
		{
			var inputX:Number = controller.get('D') - controller.get('A');
			var inputY:Number = controller.get('S') - controller.get('W');
			
			var velocityX:Number = inputX * walkSpeed;
			var velocityY:Number = inputY * walkSpeed;
			
			g.x += velocityX * delta;
			g.y += velocityY * delta;
		}
		
		public function activate(g:GameObject):void
		{
		}
		
		public function deactivate(g:GameObject):void
		{
		}
		
		public function dispose(g:GameObject):void
		{
			controller = null;
		}
	}
}