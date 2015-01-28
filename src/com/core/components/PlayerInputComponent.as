package com.core.components
{
	import com.core.Controller;
	import com.core.GameObject;

	public class PlayerInputComponent implements Component
	{
		private var controller:Controller;
		private var walkSpeed:Number;
		public function PlayerInputComponent(controller:Controller, walkSpeed:Number = 1)
		{
			this.controller = controller;
			this.walkSpeed = walkSpeed;
		}
		
		public function setup(g:GameObject):void
		{
		}
		
		public function update(g:GameObject, delta:Number):void
		{
			var inputX:Number = controller.get('D') - controller.get('A');
			var inputY:Number = controller.get('W') - controller.get('S');
			
			var velocityX:Number = inputX * walkSpeed;
			var velocityY:Number = inputY * walkSpeed;
			
			g.x += velocityX * delta;
			g.y += velocityY * delta;
		}
		
		public function dispose(g:GameObject):void
		{
			controller = null;
		}
	}
}