package com.core.components
{
	import com.core.GameObject;
	import flash.geom.Point;
	
	public class BasicMover implements Component
	{
		private const TO_RAD:Number = Math.PI/180; // should be moved to utils
		private var speed:int;
		private var velocity:Point;
		public function BasicMover(speed:int=10)
		{
			this.speed = speed;
		}
		
		public function setup(g:GameObject):void
		{
		}
		
		public function update(g:GameObject, delta:Number):void
		{
			velocity = getDirection(g);
			velocity.normalize(-speed * delta);
			
			g.x += velocity.x;
			g.y += velocity.y;
		}
		
		public function getDirection(g:GameObject):Point
		{
			return new Point(Math.cos(g.rotation * TO_RAD), Math.sin(g.rotation * TO_RAD));
		}
		
		public function activate(g:GameObject):void
		{
		}
		
		public function deactivate(g:GameObject):void
		{
		}
		
		public function dispose(g:GameObject):void
		{
		}

	}
}