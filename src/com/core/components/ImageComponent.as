package com.core.components
{
	import flash.display.Bitmap;
	import com.core.global.AssetManager;
	import com.core.GameObject;

	public class ImageComponent extends Bitmap implements Component
	{
		public function ImageComponent(resourceId:String)
		{
			if(resourceId)
				withResource(resourceId);
			
			super();
		}
		
		private function withResource(id:String):ImageComponent
		{
			this.bitmapData = AssetManager.instance.getResource(id).bitmapData;
			return this
		}
		
		public function center():ImageComponent
		{
			this.x = -this.width/2;
			this.y = -this.height/2;
			
			return this
		}
		
		public function activate(g:GameObject):void
		{
		}
		
		public function deactivate(g:GameObject):void
		{
		}
		
		public function setup(go:GameObject):void
		{
			go.addChild(this);
		}
		
		public function dispose(go:GameObject):void
		{
			go.removeChild(this);
		}
		
		public function update(go:GameObject, delta:Number):void
		{
		}
	}
}