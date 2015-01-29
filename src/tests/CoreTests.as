package tests
{
	import com.core.Controller;
	import com.core.GameObject;
	import com.core.components.ImageComponent;
	import com.core.components.InventoryComponent;
	import com.core.components.PlayerInputComponent;
	import com.core.items.Weapon;
	
	import flash.ui.Keyboard;
	
	import flexunit.framework.*;

	public class CoreTests
	{		
		[Test( description = "How a GameObject would be created" )]
		public function gameObjectCreationTest():void
		{
			var go:GameObject = new GameObject();
			Assert.assertEquals(go.x, 0);
			Assert.assertEquals(go.y, 0);
			Assert.assertEquals(go.components.length, 0);
		}
		
		[Test( description = "The Image component test" )]
		public function gameObjectShouldAllowImageComponents():void
		{
			var view:ImageComponent = new ImageComponent("bullet");
			var go:GameObject = new GameObject([view]);
			
			Assert.assertEquals(go.components.length, 1);
			Assert.assertEquals(view.parent, go);
		}
		
		[Test( description = "The Controller should save controller status" )]
		public function controllerShouldSaveKeyStatus():void
		{
			var controller:Controller = new Controller({
				'A': Controller.FALSE,
				'B': Controller.FALSE,
				'C': Controller.FALSE
			});
			
			Assert.assertEquals(controller.get('A'), Controller.FALSE);
			Assert.assertEquals(controller.get('B'), Controller.FALSE);
			Assert.assertEquals(controller.get('C'), Controller.FALSE);
			Assert.assertEquals(controller.get('D'), Controller.FALSE);
			
			controller.set('A', Controller.TRUE);
			controller.set('C', 0.5);
			
			Assert.assertEquals(controller.get('A'), Controller.TRUE);
			Assert.assertEquals(controller.get('B'), Controller.FALSE);
			Assert.assertEquals(controller.get('C'), 0.5);
		}
		
		[Test( description = "The Keyboard component test" )]
		public function gameObjectShouldAllowPlayerInputController():void
		{
			var controller:Controller = new Controller();
			var inventory:InventoryComponent = new InventoryComponent();
			var input:PlayerInputComponent = new PlayerInputComponent(controller, inventory);
			var go:GameObject = new GameObject([input]);
			
			Assert.assertEquals(go.components.length, 1);
			Assert.assertEquals(go.x, 0);
			
			controller.set('A', Controller.TRUE);
			controller.set('W', Controller.TRUE);
			go.update(1);
			controller.set('A', Controller.FALSE);
			controller.set('W', Controller.FALSE);
			
			Assert.assertEquals(go.x, -1);
			Assert.assertEquals(go.y, -1);
			
			controller.set('S', Controller.TRUE);
			controller.set('D', Controller.TRUE);
			go.update(1);
			
			Assert.assertEquals(go.x, 0);
			Assert.assertEquals(go.y, 0);
		}
		
		[Test( description = "Test for the Inventory component" )]
		public function gameObjectShouldBeAllowedToHaveAnInventory():void
		{
			var inventory:InventoryComponent = new InventoryComponent();
			Assert.assertNotNull(inventory.selectedItem);
			
			var weapon:Weapon = new Weapon();
			inventory.addItem(weapon);

			Assert.assertEquals(inventory.selectedItem, weapon);
		}
		
		[Test( description = "Weapons test" )]
		public function weaponsShouldBeAbleToFire():void
		{
			var character:GameObject = new GameObject();
			var bullet:GameObject = new GameObject();
			bullet.deactivate();
			
			character.x = 100;
			character.y = 150;
			
			var weapon:Weapon = new Weapon([bullet]);
			
			Assert.assertFalse(bullet.isActive);
			
			weapon.doUse(character);
			
			Assert.assertTrue(bullet.isActive);
			Assert.assertTrue(bullet.x == character.x);
			Assert.assertTrue(bullet.y == character.y);
			Assert.assertTrue(bullet.rotation == character.rotation);
			
		}
	}
}