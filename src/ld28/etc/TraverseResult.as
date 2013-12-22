package ld28.etc {
	import flash.utils.Dictionary;
	
	public class TraverseResult {
		public var visited:Dictionary;
		public var remarks:Dictionary;
		public var accumulator:Object;
		public var numVisited:int = 0;
		
		public function TraverseResult(accumulator:Object = null, visited:Dictionary = null, remarks:Dictionary = null) {
			this.accumulator = accumulator;
			this.visited = visited ? visited : new Dictionary();
			this.remarks = remarks ? remarks : new Dictionary();
		}
	
	}

}