package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.DLLNode;
	import flash.geom.Rectangle;
	import ld28.components.Size;
	import ld28.etc.GridCell;
	import ld28.GameConfig;
	import ld28.nodes.SpatialHashingNode;
	
	// spatial hashing
	//  "Basically, you establish a grid and mark down what's in touch with each grid. (It 
	//   doesn't have to be perfect -- it could be what axis-aligned bounding boxes are in 
	//   each grid, even.) Then, later you go through the relevant cells of the grid and 
	//   check if everything in each relevant cell is actually intersecting with anything 
	//   else in the cell."
	// http://stackoverflow.com/a/6908607/798588
	
	public class SpatialHashingSystem extends ListIteratingSystem {
		private var config:GameConfig;
		
		public var gridSize:Number;
		public var gridWidth:int;
		public var gridHeight:int;
		private var grid:Array2;
		
		public function SpatialHashingSystem(config:GameConfig, gridSize:Number = 50) {
			super(SpatialHashingNode, updateNode, addNode, removeNode);
			//this.profilingEnabled = false;
			this.config = config;
			this.gridSize = gridSize;
			this.gridWidth = int(Math.max(2, Math.ceil(this.config.width / this.gridSize)));
			this.gridHeight = int(Math.max(2, Math.ceil(this.config.height / this.gridSize)));
			this.grid = new Array2(gridWidth, gridHeight);
			for (var x:int = 0; x < gridWidth; x++) {
				for (var y:int = 0; y < gridHeight; y++) {
					grid.set(x, y, new GridCell(x, y, gridSize));
				}
			}
		}
		
		//public function getNodes(x:int, y:int):NodeList {
		//return GridCell(grid.get(x, y)).nodeList;
		//}
		
		private function addNode(node:SpatialHashingNode):void {
			var rect:Rectangle = getBoundingRect(node);
			var left:int = int(Math.floor(rect.left / gridSize));
			var right:int = int(Math.floor(rect.right / gridSize));
			var top:int = int(Math.floor(rect.top / gridSize));
			var bottom:int = int(Math.floor(rect.bottom / gridSize));
			
			node.spatialHashed.left = left;
			node.spatialHashed.right = right;
			node.spatialHashed.top = top;
			node.spatialHashed.bottom = bottom;
			
			for (var x:int = left; x <= right; x++) {
				for (var y:int = top; y <= bottom; y++) {
					var cell:GridCell = getCell(x, y);
					node.spatialHashed.dllNodes.append(cell.nodes.append(node));
				}
			}
		}
		
		public function getCell(x:int, y:int):GridCell {
			x = int(Math.max(0, Math.min(gridWidth - 1, x)));
			y = int(Math.max(0, Math.min(gridHeight - 1, y)));
			
			return GridCell(grid.get(x, y));
		}
		
		private function removeNode(node:SpatialHashingNode):void {
			for (var walker:DLLNode = node.spatialHashed.dllNodes.head; walker; walker = walker.next) {
				DLLNode(walker.val).unlink();
			}
			node.spatialHashed.dllNodes.clear();
		}
		
		private function getBoundingRect(node:SpatialHashingNode):Rectangle {
			var rect:Rectangle = new Rectangle();
			rect.width = node.size.size.x;
			rect.height = node.size.size.y;
			if ((node.size.align == Size.ALIGN_TOP_LEFT) || (node.size.align == Size.ALIGN_TOP_CENTER) || (node.size.align == Size.ALIGN_TOP_RIGHT)) {
				rect.y = node.position.position.y;
			}
			if ((node.size.align == Size.ALIGN_CENTER_LEFT) || (node.size.align == Size.ALIGN_CENTER_CENTER) || (node.size.align == Size.ALIGN_CENTER_RIGHT)) {
				rect.y = node.position.position.y - node.size.size.y / 2;
			}
			if ((node.size.align == Size.ALIGN_BOTTOM_LEFT) || (node.size.align == Size.ALIGN_BOTTOM_CENTER) || (node.size.align == Size.ALIGN_BOTTOM_RIGHT)) {
				rect.y = node.position.position.y - node.size.size.y;
			}
			if ((node.size.align == Size.ALIGN_TOP_LEFT) || (node.size.align == Size.ALIGN_CENTER_LEFT) || (node.size.align == Size.ALIGN_BOTTOM_LEFT)) {
				rect.x = node.position.position.x;
			}
			if ((node.size.align == Size.ALIGN_TOP_CENTER) || (node.size.align == Size.ALIGN_CENTER_CENTER) || (node.size.align == Size.ALIGN_BOTTOM_CENTER)) {
				rect.x = node.position.position.x - node.size.size.x / 2;
			}
			if ((node.size.align == Size.ALIGN_TOP_RIGHT) || (node.size.align == Size.ALIGN_CENTER_RIGHT) || (node.size.align == Size.ALIGN_BOTTOM_RIGHT)) {
				rect.x = node.position.position.x - node.size.size.x;
			}
			return rect;
		}
		
		private function updateNode(node:SpatialHashingNode, time:Number):void {
			var rect:Rectangle = getBoundingRect(node);
			
			var left:int = int(Math.floor(rect.left / gridSize));
			var right:int = int(Math.floor(rect.right / gridSize));
			var top:int = int(Math.floor(rect.top / gridSize));
			var bottom:int = int(Math.floor(rect.bottom / gridSize));
			
			if ((left != node.spatialHashed.left) || (right != node.spatialHashed.right) || (top != node.spatialHashed.top) || (bottom != node.spatialHashed.bottom)) {
				removeNode(node);
				addNode(node);
					//trace("boing");
			}
		
		}
	}
}
