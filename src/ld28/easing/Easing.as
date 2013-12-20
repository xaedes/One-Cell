package ld28.easing {
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class Easing {
		//http://www.gizma.com/easing/#l
		
		/**
		 * simple linear tweening - no easing, no acceleration
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function linearTween(t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b;
		}
		;
		
		/**
		 * quadratic easing in - accelerating from zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInQuad(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			return c * t * t + b;
		}
		;
		
		/**
		 * quadratic easing out - decelerating to zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeOutQuad(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			return -c * t * (t - 2) + b;
		}
		;
		
		/**
		 * quadratic easing in/out - acceleration until halfway, then deceleration
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInOutQuad(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d / 2;
			if (t < 1)
				return c / 2 * t * t + b;
			t--;
			return -c / 2 * (t * (t - 2) - 1) + b;
		}
		;
		
		/**
		 * cubic easing in - accelerating from zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInCubic(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			return c * t * t * t + b;
		}
		;
		
		/**
		 * cubic easing out - decelerating to zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeOutCubic(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			t--;
			return c * (t * t * t + 1) + b;
		}
		;
		
		/**
		 * cubic easing in/out - acceleration until halfway, then deceleration
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInOutCubic(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d / 2;
			if (t < 1)
				return c / 2 * t * t * t + b;
			t -= 2;
			return c / 2 * (t * t * t + 2) + b;
		}
		;
		
		/**
		 * quartic easing in - accelerating from zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInQuart(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			return c * t * t * t * t + b;
		}
		;
		
		/**
		 * quartic easing out - decelerating to zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeOutQuart(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			t--;
			return -c * (t * t * t * t - 1) + b;
		}
		;
		
		/**
		 * quartic easing in/out - acceleration until halfway, then deceleration
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInOutQuart(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d / 2;
			if (t < 1)
				return c / 2 * t * t * t * t + b;
			t -= 2;
			return -c / 2 * (t * t * t * t - 2) + b;
		}
		;
		
		/**
		 * quintic easing in - accelerating from zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInQuint(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			return c * t * t * t * t * t + b;
		}
		;
		
		/**
		 * quintic easing out - decelerating to zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeOutQuint(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			t--;
			return c * (t * t * t * t * t + 1) + b;
		}
		;
		
		/**
		 * quintic easing in/out - acceleration until halfway, then deceleration
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInOutQuint(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d / 2;
			if (t < 1)
				return c / 2 * t * t * t * t * t + b;
			t -= 2;
			return c / 2 * (t * t * t * t * t + 2) + b;
		}
		;
		
		/**
		 * sinusoidal easing in - accelerating from zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInSine(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
		}
		;
		
		/**
		 * sinusoidal easing out - decelerating to zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeOutSine(t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.sin(t / d * (Math.PI / 2)) + b;
		}
		;
		
		/**
		 * sinusoidal easing in/out - accelerating until halfway, then decelerating
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInOutSine(t:Number, b:Number, c:Number, d:Number):Number {
			return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
		}
		;
		
		/**
		 * exponential easing in - accelerating from zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInExpo(t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.pow(2, 10 * (t / d - 1)) + b;
		}
		;
		
		/**
		 * exponential easing out - decelerating to zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeOutExpo(t:Number, b:Number, c:Number, d:Number):Number {
			return c * (-Math.pow(2, -10 * t / d) + 1) + b;
		}
		;
		
		/**
		 * exponential easing in/out - accelerating until halfway, then decelerating
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInOutExpo(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d / 2;
			if (t < 1)
				return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
			t--;
			return c / 2 * (-Math.pow(2, -10 * t) + 2) + b;
		}
		;
		
		/**
		 * circular easing in - accelerating from zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInCirc(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			return -c * (Math.sqrt(1 - t * t) - 1) + b;
		}
		;
		
		/**
		 * circular easing out - decelerating to zero velocity
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeOutCirc(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d;
			t--;
			return c * Math.sqrt(1 - t * t) + b;
		}
		;
		
		/**
		 * circular easing in/out - acceleration until halfway, then deceleration
		 * @param	t: current time
		 * @param	b: start value (begin)
		 * @param	c: change in value
		 * @param	d: duration
		 * @return
		 */
		static public function easeInOutCirc(t:Number, b:Number, c:Number, d:Number):Number {
			t /= d / 2;
			if (t < 1)
				return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b;
			t -= 2;
			return c / 2 * (Math.sqrt(1 - t * t) + 1) + b;
		}
		;
	
		//public function ease(t, b, c, d):Number {
		//
		//}
	
	}

}