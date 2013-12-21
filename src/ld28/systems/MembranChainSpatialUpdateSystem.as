package ld28.systems {
	import ash.core.Entity;
	import ash.tools.ListIteratingSystem;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ld28.components.Circle;
	import ld28.components.Position;
	import ld28.graphics.RectView;
	import ld28.nodes.MembranChainSpatialUpdateNode;
	
	public class MembranChainSpatialUpdateSystem extends ListIteratingSystem {
		
		public function MembranChainSpatialUpdateSystem() {
			super(MembranChainSpatialUpdateNode, updateNode);
		}
		
		private function updateNode(node:MembranChainSpatialUpdateNode, time:Number):void {
			
			// calculate bounding box
			var min:Point = null; //top-left
			var max:Point = null; //bottom-right
			for (var obj:Object in node.membranChain.partEntities) {
				var part:Entity = Entity(obj);
				var position:Position = Position(part.get(Position));
				var circle:Circle = Circle(part.get(Circle));
				if (min == null) {
					min = position.position.clone();
				}
				if (max == null) {
					max = position.position.clone();
				}
				min.x = Math.min(min.x, position.position.x - circle.radius);
				min.y = Math.min(min.y, position.position.y - circle.radius);
				
				max.x = Math.max(max.x, position.position.x + circle.radius);
				max.y = Math.max(max.y, position.position.y + circle.radius);
			}
			
			node.position.position.x = min.x;
			node.position.position.y = min.y;
			node.size.size.x = max.x - min.x;
			node.size.size.y = max.y - min.y;
		}
	}
}
