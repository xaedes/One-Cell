package ld28.components {
	import ash.core.Entity;
	import flash.utils.Dictionary;
	import ld28.Utils;
	
	public class Membran {
		public var connections:Vector.<Entity> = new Vector.<Entity>();
		public var straigthener:Entity = null;
		public var connected:Dictionary = new Dictionary();
		
		public function Membran() {
		
		}
		
		/**
		 * Gives next MembranPart Entity, that is connected.
		 *
		 * When prev == null (default) the first connected MembranPart Entity  is returned.
		 * When prev != null the other connected MembranPart Entity (except prev) is returned.
		 *
		 * When no connected MembranPart Entity is found null is returned.
		 *
		 * @param	prev=null
		 * @return
		 */
		public function nextPart(prev:Entity = null):Entity {
			var keys:Array = Utils.getKeys(connected);
			for each (var key:Object in keys) {
				if (prev && (key == prev)) {
					continue;
				}
				return Entity(key);
			}
			return null;
		}
	}

}