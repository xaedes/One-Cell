package ld28.systems {
	import ash.core.ComponentMatchingFamily;
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import ld28.Assets;
	import ld28.components.Audio;
	import ld28.components.Breakable;
	import ld28.components.Collision;
	import ld28.components.Display;
	import ld28.components.DistanceConstraint;
	import ld28.components.Player;
	import ld28.components.Position;
	import ld28.components.Radar;
	import ld28.EntityCreator;
	import ld28.GameConfig;
	import ld28.nodes.DistanceConstraintNode;
	import ld28.nodes.EnergyCollectingCollisionNode;
	import ld28.nodes.EnergyParticleCollisionNode;
	import ld28.nodes.MembranNode;
	import ld28.Utils;
	
	public class MembranSystem extends System {
		private var creator:EntityCreator;
		
		private var nodes:NodeList;
		private var family:ComponentMatchingFamily;
		
		public function MembranSystem(creator:EntityCreator) {
			this.creator = creator;
		}
		
		override public function addToEngine(engine:Engine):void {
			nodes = engine.getNodeList(MembranNode);
			family = ComponentMatchingFamily(engine.getFamily(MembranNode));
		}
		
		public function removeConnection(connection:Entity) {
		
		}
		
		override public function update(time:Number):void {
			var node1:MembranNode;
			var connection:Entity;
			var constraint:DistanceConstraint;
			//var n:int = 0;
			for (node1 = nodes.head; node1; node1 = node1.next) {
				// deal with broken connections
				
				for (var i:int = 0; i < node1.membran.connections.length; i++) {
					connection = Entity(node1.membran.connections[i]);
					if (connection.has(Breakable)) {
						var breakable:Breakable = connection.get(Breakable);
						if (breakable.broken) {
							// remove connection
							//trace("plop");
							constraint = connection.get(DistanceConstraint);
							
							if (node1.membran.connected[constraint.entity1]) {
								delete node1.membran.connected[constraint.entity1];
							}
							if (node1.membran.connected[constraint.entity2]) {
								delete node1.membran.connected[constraint.entity2];
							}
							creator.destroyEntity(connection);
							if (node1.membran.straigthener) {
								creator.destroyEntity(node1.membran.straigthener);
								node1.membran.straigthener = null;
							}
							
							node1.membran.connections.splice(i, 1);
							i--;
								//connection
						}
					}
				}
				
				if (node1.membran.connections.length < 2) {
					// try to add more
					var radarCollisions:Collision = node1.radar.entity.get(Collision);
					for each (var entity:Entity in radarCollisions.collidingEntities) {
						//n++;
						if (entity == node1.entity) {
							continue;
						}
						var node2:MembranNode = MembranNode(family.entities[entity]);
						if (node2) {
							if (node1.membran.connected[entity]) {
								continue;
							}
							if (node2.membran.connections.length < 2) {
								//trace("foo");
								
								connection = creator.createConnection(node1.entity, node2.entity);
								var breakable:Breakable = connection.get(Breakable);
								breakable.maximumDistance *= 1.5;
								constraint = connection.get(DistanceConstraint);
								constraint.strength *= 2.5;
								node1.membran.connections.push(connection);
								node2.membran.connections.push(connection);
								node1.membran.connected[node2.entity] = connection;
								node2.membran.connected[node1.entity] = connection;
								
								checkCompleteness(node1);
								checkCompleteness(node2);
								
								if (node1.membran.connections.length >= 2) {
									break;
								}
							}
						}
					}
				}
				
			}
			//trace("MembranSystem", n);
		}
		
		protected function checkCompleteness(node:MembranNode):void {
			if (node.membran.connections.length == 2) {
				
				var keys:Array = Utils.getKeys(node.membran.connected);
				if (keys.length >= 2) {
					var connection:Entity = creator.createConnection(Entity(keys[0]), Entity(keys[1]), 50);
					connection.remove(Display);
					connection.remove(Breakable);
					if (connection.has(DistanceConstraintNode)) {
						var constraint:DistanceConstraintNode = connection.get(DistanceConstraintNode);
						var r:Number = 0.6;
						constraint.distanceConstraint.strength *= Utils.randomRange(1 - r, 1 + r);
						constraint.distanceConstraint.distance *= Utils.randomRange(1 - r, 1 + r);
					}
					node.membran.straigthener = connection;
				}
			}
		
		}
		
		override public function removeFromEngine(engine:Engine):void {
			nodes = null;
			family = null;
		}
	}
}
