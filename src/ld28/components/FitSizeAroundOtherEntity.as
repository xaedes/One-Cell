package ld28.components {
	import ash.core.Entity;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class FitSizeAroundOtherEntity {
		public var otherEntity:Entity;
		public var padding:Number;
		
		public function FitSizeAroundOtherEntity(otherEntity:Entity, padding:Number = 0) {
			this.otherEntity = otherEntity;
			this.padding = padding;
		}
	
	}

}