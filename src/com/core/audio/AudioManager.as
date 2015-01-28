package com.core.audio
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	public class AudioManager extends Object
	{
		public static var sounds:Object;
		public static var soundChannels:Object;
		public function AudioManager()
		{
			super();
			sounds = {};
			soundChannels = {};
		}
		
		public function registerFx(name:String,path:String):AudioManager {
			var snd:Sound = new Sound();
			snd.load(new URLRequest(path));
			sounds[name] = snd;
			
			return this;
		}
		/**
		 * Plays a sound 
		 * @param name
		 * 
		 */		
		public function play(name:String) :void {
			soundChannels[name] = getSound(name).play();
		}
		
		/**
		 * Loops a sound 
		 * @param name
		 * 
		 */		
		public function loop(name:String) :void {
			soundChannels[name] = getSound(name).play(0,9999999);
		}
		
		/**
		 * Stops a sound 
		 * @param name
		 * 
		 */		
		public function stop(name:String) :void {
			if (getSoundChannel(name) != null)
				getSoundChannel(name).stop();
		}
		
		/**
		 * Gets a sound
		 * @param name
		 * @return a sound
		 * 
		 */		
		public function getSound(name:String):Sound {
			return sounds[name];
		}
		
		/**
		 * Gets a sound channel 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getSoundChannel(name:String):SoundChannel {
			return soundChannels[name];
		}
		
		/**
		 * Disposes the AudioManager 
		 * 
		 */		
		public function dispose():void {
			sounds = null;
			soundChannels = null;
		}
	}
}