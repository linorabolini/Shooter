package com.core.utils {
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class Shaker {

		private var _velocity:Point;
		private var _position:Point;
		private var _target:Object;
		private var _drag:Number;
		private var _elasticity:Number;
		
		/**
		 * Instantiates the Shaker 
		 * 
		 */		
		public function Shaker() {
			_velocity = new Point();
			_position = new Point();
		}
		
		/**
		 * Sets up the shaker 
		 * @param target
		 * @param drag
		 * @param elasticity
		 * 
		 */		
		public function setUp(target:Object,drag:Number = 0.1,elasticity:Number = 0.1):void {
			_target = target;
			_drag = drag;
			_elasticity = elasticity;
		}

		/**
		 * Fires the Shaker 
		 * @param powerX
		 * @param powerY
		 * 
		 */		
		public function shake(powerX:Number, powerY:Number):void {
			_velocity.x += powerX;
			_velocity.y += powerY;
		}

		/**
		 * Randomly fires the shaker 
		 * @param power
		 * 
		 */		
		public function shakeRandom(power:Number):void {
			_velocity = Point.polar(power, Math.random() * Math.PI * 2);
		}
		
		/**
		 * Update the shaker's forces (needed) 
		 * @param delta
		 * 
		 */		
		public function update(delta:Number):void {
			_velocity.x -= _velocity.x * _drag * delta;
			_velocity.y -= _velocity.y * _drag * delta;

			_velocity.x -= (_position.x) * _elasticity * delta;
			_velocity.y -= (_position.y) * _elasticity * delta;

			_position.x += (_velocity.x) * delta;
			_position.y += (_velocity.y) * delta;

			_target.x = _position.x;
			_target.y = _position.y;
		}

	}

}