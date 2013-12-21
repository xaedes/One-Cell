package ld28.systems {
	import ash.core.Entity;
	import ash.tools.ListIteratingSystem;
	import flash.geom.Point;
	import ld28.components.Position;
	import ld28.nodes.BreakingConnectionNode;
	
	public class BreakingConnectionSystem extends ListIteratingSystem {
		
		public function BreakingConnectionSystem() {
			super(BreakingConnectionNode, updateNode);
		}
		
		private function updateNode(node:BreakingConnectionNode, time:Number):void {
			
			var pos1:Position = node.distanceConstraint.entity1.get(Position);
			var pos2:Position = node.distanceConstraint.entity2.get(Position);
			if ((pos1) && (pos2)) {
				if (Point.distance(pos1.position, pos2.position) > node.breakable.maximumDistance) {
					node.breakable.broken = true;
				}
			}
		}
	}
}
