package com.core.components
{
	import com.core.GameObject;
	
	import flash.geom.Point;

	public class ZombieMover implements Component
	{
		private const TO_RAD:Number = Math.PI/180; // should be moved to utils
		private var speed:int;
		private var velocity:Point;
		private var targets:Array;

		private var currentTarget:GameObject;
		public function ZombieMover(targets:Array, speed:int=1)
		{
			this.speed = speed;
			this.targets = targets;
		}
		
		public function setup(g:GameObject):void
		{
		}
		
		public function update(g:GameObject, delta:Number):void
		{
			currentTarget = getTarget();
			
			if(!currentTarget)
				return

			velocity = getDirection(g);
			velocity.normalize(speed * delta);
			
			g.x += velocity.x;
			g.y += velocity.y;
			
			var angle:Number = Math.atan2(-velocity.y, -velocity.x);
			g.rotation = angle * 180 / Math.PI;
		}
		
		private function getTarget():GameObject
		{
			// TODO make more smart zombies
			if(targets.length)
				return targets[0]; // player 2 will have fun.
			else
				return null
		}
		
		public function getDirection(g:GameObject):Point
		{
			return new Point(currentTarget.x - g.x, currentTarget.y - g.y);
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