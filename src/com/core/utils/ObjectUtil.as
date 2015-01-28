package com.core.utils
{
	/** Utility functions to operate on generic Object instances. */
	public class ObjectUtil
	{
		/** Return wether or not the argument is an Object instance. */
		public static function isObject(obj:Object):Boolean
		{
			return !!(obj && typeof obj == 'object'); 
		}
		
		/** Copy the object data into another (possibly existing) object. */
		public static function copy(src:Object, target:Object = null, deep:Boolean = false):Object
		{
			if (!target)
				target = {};

			for (var key:String in src)
			{
				var old:Object = target[key];
				var repl:Object = src[key];
				
				if (deep && isObject(old) && isObject(repl))
					copy(repl, old, true);
				else
					target[key] = repl;
			}
			return target;
		}
		
		/** Finds a value within a list and returns the key */
		public static function find(list:Object, value:Object):String
		{
			for (var key:String in list)
				if (list[key] === value)
					return key;
			return null;
		}
		
		/** Returns whether a list contains a certain value */
		public static function contains(list:Object, value:Object):Boolean
		{
			return find(list,value) !== null;
		}
		
		/** Converts an object into an array of values */
		public static function values(src:Object):Array
		{
			var values:Array = [], i:int = 0;
			for each (var object:Object in src)
				values[i++] = object;
			return values;
		}
		
		/** Returns an array with the keys of the src object */
		public static function keys(src:Object):Array
		{
			var keys:Array = [], i:int = 0;
			for (var key:Object in src)
				keys[i++] = key;
			return keys;
		}

		/** Returns whether an object has no key at all */
		public static function isEmpty(obj:Object):Boolean
		{
			for (var key:Object in obj)
				return false;
			return true;
		}
	
	}
}
