package com.core.items
{
	import com.core.GameObject;
	
	public class NullInventoryItem implements InventoryItem
	{
		public function NullInventoryItem()
		{
		}
		
		public function doUse(by:GameObject):void
		{
		}
		
		public function setup(g:GameObject):void
		{
		}
		
		public function update(g:GameObject, delta:Number):void
		{
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