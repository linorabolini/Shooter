package com.core.global
{   
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class AssetManager
	{
		[Embed(source = '../resources/bullet.png')]private static const BulletAsset:Class;
		[Embed(source = '../resources/player.png')] private static const PlayerAsset:Class;
		[Embed(source = '../resources/zombie.png')] private static const ZombieAsset:Class;

		private static var _instance:AssetManager = null;
		private static var resources:Dictionary = new Dictionary();
		
		public function AssetManager() 
		{
			if (_instance) throw Error("Sorry, only one instance of this class is allowed");
			loadResources();
		}   
		
		private function loadResources():void
		{
			resources["bullet"] = new BulletAsset();
			resources["player"] = new PlayerAsset();
			resources["zombie"] = new ZombieAsset();
		}
		
		
		public function getResource(image:String):* 
		{
			return resources[image];
		}
		
		static public function get instance():AssetManager 
		{
			if (!_instance) _instance = new AssetManager();
			return _instance;
		}
		
	}
	
}