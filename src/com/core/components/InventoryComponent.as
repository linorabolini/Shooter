package com.core.components
{
	import com.core.GameObject;
	import com.core.items.InventoryItem;
	import com.core.items.NullInventoryItem;
	import com.core.items.Weapon;
	
	public class InventoryComponent implements Component
	{
		public var selectedItem:InventoryItem;
		private var items:Array;
		
		// TODO enable remove item
		// enable switch item
		// enable all things inventories allow
		private var nullItem:NullInventoryItem;
		
		public function InventoryComponent()
		{
			this.items = [];
			this.nullItem = new NullInventoryItem();
			this.selectedItem = nullItem;
		}
		
		public function setup(g:GameObject):void
		{
		}
		
		public function update(g:GameObject, delta:Number):void
		{
			this.selectedItem.update(g, delta);
		}
		
		public function activate(g:GameObject):void
		{
		}
		
		public function deactivate(g:GameObject):void
		{
		}
		
		public function dispose(g:GameObject):void
		{
			selectedItem = null;
			
			for each(var item:InventoryItem in items)
			{
				item.dispose(g);
			}
			
			this.items = null;
		}
		
		public function addItem(item:InventoryItem):void
		{
			items.push(item);
			selectedItem = item;
		}

	}
}