package tests
{
	import flash.ui.Keyboard;
	
	import flexunit.framework.*;
	
	import com.core.GameObject;
	import com.core.components.ImageComponent;
	import com.core.components.PlayerInputComponent;
	import com.core.Controller;

	public class CharacterTest
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
			var view:ImageComponent = new ImageComponent("exampleImage");
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
			var input:PlayerInputComponent = new PlayerInputComponent(controller);
			var go:GameObject = new GameObject([input]);
			
			Assert.assertEquals(go.components.length, 1);
			Assert.assertEquals(go.x, 0);
			
			controller.set('A', Controller.TRUE);
			controller.set('W', Controller.TRUE);
			go.update(1);
			controller.set('A', Controller.FALSE);
			controller.set('W', Controller.FALSE);
			
			Assert.assertEquals(go.x, -1);
			Assert.assertEquals(go.y, 1);
			
			controller.set('S', Controller.TRUE);
			controller.set('D', Controller.TRUE);
			go.update(1);
			
			Assert.assertEquals(go.x, 0);
			Assert.assertEquals(go.y, 0);
		}
	}
}