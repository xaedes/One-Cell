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
	import ld28.components.Membran;
	import ld28.components.MembranChain;
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
			var tmpNode:MembranNode;
			var node1:MembranNode;
			var pos1:Position;
			var pos2:Position;
			var text:Entity;
			var textPosition:Position;
			var connection:Entity;
			var constraint:DistanceConstraint;
			var membranChain1:MembranChain;
			var membranChain2:MembranChain;
			
			// deal with broken connections
			for (node1 = nodes.head; node1; node1 = node1.next) {
				for (var i:int = 0; i < int(Math.min(2, node1.membran.connections.length)); i++) {
					connection = Entity(node1.membran.connections[i]);
					if (connection.has(Breakable)) {
						var breakable:Breakable = connection.get(Breakable);
						if (breakable.broken) {
							// get constraint
							constraint = connection.get(DistanceConstraint);
							
							pos1 = Position(constraint.entity1.get(Position));
							pos2 = Position(constraint.entity2.get(Position));
							
							// create floating text "plop"
							text = creator.createFloatingText("plop", 1);
							textPosition = Position(text.get(Position));
							textPosition.position.x = (pos1.position.x + pos2.position.x) / 2;
							textPosition.position.y = (pos1.position.y + pos2.position.y) / 2;
							
							// remove connection
							if (node1.membran.connected[constraint.entity1]) {
								delete node1.membran.connected[constraint.entity1];
							}
							if (node1.membran.connected[constraint.entity2]) {
								delete node1.membran.connected[constraint.entity2];
							}
							creator.destroyEntity(connection);
							
							// remove straigthener
							if (node1.membran.straigthener) {
								creator.destroyEntity(node1.membran.straigthener);
								node1.membran.connections.splice(node1.membran.connections.length - 1, 1);
								node1.membran.straigthener = null;
							}
							
							//remove connection
							node1.membran.connections.splice(i, 1);
							i--;
							
								// refresh membran chain infos
								//this.refreshMembranChains(constraint.entity1);
								//this.refreshMembranChains(constraint.entity2);
						}
					}
				}
			}
			
			// try to add more
			for (node1 = nodes.head; node1; node1 = node1.next) {
				if (node1.membran.connections.length < 2) {
					// not fully connected
					var radarCollisions:Collision = node1.radar.entity.get(Collision);
					for each (var entity:Entity in radarCollisions.collidingEntities) {
						//n++;
						if (entity == node1.entity) {
							// skip collision with itself
							continue;
						}
						// get colliding MembranNode
						var node2:MembranNode = MembranNode(family.entities[entity]);
						if (node2) {
							// node2 = colliding MembranNode
							
							if (node1.membran.connected[entity]) {
								// no self connections
								continue;
							}
							if (node2.membran.connections.length < 2) {
								// other node is not fully connected
								// (try to) detect triangle
								var triangle = false;
								for (var foo:Object in node1.membran.connected) {
									tmpNode = MembranNode(family.entities[foo]);
									if (tmpNode.membran.connected[node2.entity]) {
										triangle = true;
									}
								}
								//no triangles
								if (triangle) {
									continue;
								}
								//
								//join membranChain
								//if (Utils.getKeys(node1.membranChain.partEntities).length == 0) {
								//node1.membranChain.partEntities[node1.entity] = node1.entity;
								//}
								//if (Utils.getKeys(node2.membranChain.partEntities).length == 0) {
								//node2.membranChain.partEntities[node2.entity] = node2.entity;
								//}
								//membranChain1 = node1.membranChain;
								//membranChain2 = node2.membranChain;
								//trace(membranChain1 == membranChain2);
								//MembranChain.join(membranChain1, membranChain2);
								
								// create connection
								connection = creator.createConnection(node1.entity, node2.entity);
								var breakable:Breakable = connection.get(Breakable);
								breakable.maximumDistance *= 1.5;
								constraint = connection.get(DistanceConstraint);
								constraint.strength *= 2.5;
								node1.membran.connections.push(connection);
								node2.membran.connections.push(connection);
								node1.membran.connected[node2.entity] = connection;
								node2.membran.connected[node1.entity] = connection;
								
								// check for complete nodes and add straigtheners if so
								checkCompleteness(node1);
								checkCompleteness(node2);
								
								// create floating text "><"
								pos1 = Position(node1.entity.get(Position));
								pos2 = Position(node2.entity.get(Position));
								
								text = creator.createFloatingText("><", 1);
								textPosition = Position(text.get(Position));
								textPosition.position.x = (pos1.position.x + pos2.position.x) / 2;
								textPosition.position.y = (pos1.position.y + pos2.position.y) / 2;
								
								//if node1 is fully connected dont look for more
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
		
		protected function refreshMembranChains(entity:Entity):void {
			var part:Object = null;
			var chain:MembranChain = null;
			var current:Entity = entity;
			var last:Entity = null;
			var membranChain:MembranChain = MembranChain(entity.get(MembranChain));
			while (current) {
				if (membranChain.partEntities[current]) {
					membranChain.circular = true;
				}
				membranChain.partEntities[current] = current;
				membranChain.size++;
				if (membranChain.circular = true) {
					break;
				}
				current = Membran(current.get(Membran)).nextPart(last);
				last = current;
			}
			for (part in membranChain.partEntities) {
				chain = MembranChain(part.get(MembranChain));
				if (!chain) {
					chain = new MembranChain();
				}
				if (chain) {
					chain.circular = membranChain.circular;
					chain.size = membranChain.size;
					chain.partEntities = new Dictionary();
					for (part in membranChain.partEntities) {
						chain.partEntities[part] = part;
					}
						//chain.partEntities = joined.partEntities;
				} else {
					part.add(membranChain);
				}
			}
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
