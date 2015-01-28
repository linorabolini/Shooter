package com.core.components
{
	import flash.display.Bitmap;
	import com.core.GameObject;

	public class ImageComponent extends Bitmap implements Component
	{
		public function ImageComponent(resourceUrl:String)
		{
			// TODO load resource here
			super();
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