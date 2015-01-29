package com.core.items
{
	import com.core.GameObject;
	import com.core.components.Component;

	public interface InventoryItem extends Component
	{
		function doUse(by:GameObject):void;
	}
}