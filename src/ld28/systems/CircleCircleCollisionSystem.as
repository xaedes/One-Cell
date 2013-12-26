package ld28.systems {
	import ash.core.ComponentMatchingFamily;
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.geom.Point;
	import ld28.nodes.CircleCircleCollisionNode;
	import ld28.Utils;
	
	public class CircleCircleCollisionSystem extends System {
		private var nodes:NodeList;
		private var family:ComponentMatchingFamily;
		
		public function CircleCircleCollisionSystem() {
		}
		
		override public function addToEngine(engine:Engine):void {
			nodes = engine.getNodeList(CircleCircleCollisionNode);
			family = ComponentMatchingFamily(engine.getFamily(CircleCircleCollisionNode));
		}
		
		override public function update(time:Number):void {
			var node1:CircleCircleCollisionNode;
			// clear all collisions
			for (node1 = nodes.head; node1; node1 = node1.next) {
				node1.circleCollision.clear();
			}
			
			// iterate over all possible collisions and check for circle circle collisions
			for (node1 = nodes.head; node1; node1 = node1.next) {
				for each (var entity:Entity in node1.collision.collidingEntities) {
					var node2:CircleCircleCollisionNode = CircleCircleCollisionNode(family.entities[entity]);
					if (node2) {
						handleCollision(node1, node2);
					}
				}
			}
		}
		
		protected function handleCollision(node1:CircleCircleCollisionNode, node2:CircleCircleCollisionNode):void {
			var radiusSum:Number = node1.circle.radius + node2.circle.radius;
			if (Point.distance(node1.position.position, node2.position.position) <= radiusSum) {
				node1.circleCollision.collidingEntities[node2.entity] = node2.entity;
				node2.circleCollision.collidingEntities[node1.entity] = node1.entity;
			}
		}
		
		override public function removeFromEngine(engine:Engine):void {
			nodes = null;
			family = null;
		}
	}
}
