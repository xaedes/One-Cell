package ld28.etc {
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class TraverseResult {
		public var visited:Dictionary;
		public var remarks:Dictionary;
		
		public function TraverseResult(visited:Dictionary = null, remarks:Dictionary = null) {
			this.visited = visited ? visited : new Dictionary();
			this.remarks = remarks ? remarks : new Dictionary();
		}
	
	}

}