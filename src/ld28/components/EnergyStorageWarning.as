package ld28.components {
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class EnergyStorageWarning {
		public var warningUnderPercent:Number = 0.2;
		public var countdown:Number = 0;
		public var interval:Number;
		public var fading_time:Number;
		
		public function EnergyStorageWarning(warningUnderPercent:Number = 0.2, interval:Number = 2, fading_time:Number = 2) {
			this.warningUnderPercent = warningUnderPercent;
			this.fading_time = fading_time;
			this.interval = interval;
		}
	
	}

}