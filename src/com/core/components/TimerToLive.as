package com.core.components
{
	import com.core.GameObject;
	
	public class TimerToLive implements Component
	{
		private var time:Number;
		private var elapsed:Number;
		public function TimerToLive(time:Number)
		{
			this.time = time;
		}
		
		public function setup(g:GameObject):void
		{
			elapsed = 0;
		}
		
		public function update(g:GameObject, delta:Number):void
		{
			elapsed += delta;
			if(elapsed > time)
				g.deactivate();
		}
		
		public function activate(g:GameObject):void
		{
			setup(g);
		}
		
		public function deactivate(g:GameObject):void
		{
		}
		
		public function dispose(g:GameObject):void
		{
		}
	}
}