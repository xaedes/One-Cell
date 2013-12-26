package ld28.components {
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class GameState {
		private var _state:String = "";
		private var _lastState:String = "";
		public var initialized:Boolean = false;
		
		public function get state():String {
			return _state;
		}
		
		public function set state(value:String):void {
			if (_state != value) {
				this.initialized = false;
			}
			_lastState = _state;
			_state = value;
		}
		
		public function get lastState():String {
			return _lastState;
		}
		
		public function GameState() {
		
		}
	
	}

}