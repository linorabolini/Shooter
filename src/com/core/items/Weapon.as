package com.core.items
{
	import com.core.GameObject;
	import com.core.components.Component;
	import com.core.global.audio;

	public class Weapon implements InventoryItem
	{
		private var bullets:Array;
		private var elapsed:Number = 0;
		private var delay:Number = 10;
		private var canFire:Boolean = true;
		
		public function Weapon(bullets:Array=null)
		{
			this.bullets = bullets || [];
		}
		
		public function doUse(by:GameObject):void
		{
			var bullet:GameObject = this.getBullet();
			if (bullet)
				this.fire(bullet, by);
		}
		
		private function fire(bullet:GameObject, by:GameObject):void
		{
			if(!canFire)
				return
			
			bullet.x = by.x;
			bullet.y = by.y;
			bullet.rotation = by.rotation;
			bullet.activate();
			elapsed = 0;
			canFire = false;
			audio.play('shoot');
		}
		
		public function getBullet():GameObject 
		{
			for ( var i:int = 0; i < bullets.length; ++i) 
			{
				if ( !bullets[i].isActive ) return bullets[i];
			}
			return null;
		}
		
		public function setup(g:GameObject):void
		{
		}
		
		public function activate(g:GameObject):void
		{
		}
		
		public function deactivate(g:GameObject):void
		{
		}
		
		public function update(g:GameObject, delta:Number):void
		{
			elapsed += delta;
			if(elapsed > delay)
			{
				elapsed -= delay;
				canFire = true;
			}
		}
		
		public function dispose(g:GameObject):void
		{
			this.bullets = null;
		}
	}
}