package ld28.systems {
	import ash.core.ComponentMatchingFamily;
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import de.polygonal.ds.ArrayedStack;
	import de.polygonal.ds.Stack;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import ld28.Assets;
	import ld28.components.Audio;
	import ld28.components.Breakable;
	import ld28.components.CircleCircleCollision;
	import ld28.components.Collision;
	import ld28.components.Display;
	import ld28.components.DistanceConstraint;
	import ld28.components.Membran;
	import ld28.components.MembranChain;
	import ld28.components.MembranChainOrderedEntities;
	import ld28.components.MembranChainUpdateOrderedEntities;
	import ld28.components.Player;
	import ld28.components.Position;
	import ld28.components.Radar;
	import ld28.EntityCreator;
	import ld28.etc.TraverseResult;
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
		
		override public function update(time:Number):void {
			
			dealWithBrokenConnections();
			tryToAddMore();
		}
		
		protected function tryToAddMore():void {
			var tmpNode:MembranNode;
			var node1:MembranNode;
			var pos1:Position;
			var pos2:Position;
			var text:Entity;
			var textPosition:Position;
			var connection:Entity;
			var constraint:DistanceConstraint;
			var chain1:MembranChain;
			var chain2:MembranChain;
			
			// try to add more
			for (node1 = nodes.head; node1; node1 = node1.next) {
				if (node1.membran.connections.length < 2) {
					// not fully connected
					//var radarCollisions:CircleCircleCollision = node1.radar.entity.get(CircleCircleCollision);
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
							chain1 = MembranChain(node1.membran.chain.get(MembranChain));
							if (chain1.partEntities[node2.entity] && chain1.size <= 3) {
								// prevent rings of size <= 3
								continue;
							}
							if (node2.membran.connections.length < 2) {
								// other node is not fully connected
								
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
								
								// refresh MembranChains
								refreshMembranChains(node1.entity);
								
								// play join audio
								node1.audio.play(Assets.MembranConnectionJoin);
								
								//if node1 is fully connected dont look for more
								if (node1.membran.connections.length >= 2) {
									break;
								}
								
							}
						}
					}
				}
			}
		}
		
		protected function dealWithBrokenConnections():void {
			var pos1:Position;
			var pos2:Position;
			var text:Entity;
			var textPosition:Position;
			var connection:Entity;
			var constraint:DistanceConstraint;
			
			var node:MembranNode;
			for (node = nodes.head; node; node = node.next) {
				for (var i:int = 0; i < node.membran.connections.length; i++) {
					
					connection = Entity(node.membran.connections[i]);
					if (connection.has(Breakable)) {
						var breakable:Breakable = connection.get(Breakable);
						if (breakable.broken) {
							// play break audio
							node.audio.play(Assets.MembranConnectionBreak);
							
							// get constraint
							constraint = connection.get(DistanceConstraint);
							
							// get positions of connected entities for position of following floating text
							pos1 = Position(constraint.entity1.get(Position));
							pos2 = Position(constraint.entity2.get(Position));
							
							// create floating text "plop"
							text = creator.createFloatingText("plop", 1);
							textPosition = Position(text.get(Position));
							textPosition.position.x = (pos1.position.x + pos2.position.x) / 2;
							textPosition.position.y = (pos1.position.y + pos2.position.y) / 2;
							
							// clean membran entites from connection
							cleanMembranFromConnection(constraint.entity1, connection);
							cleanMembranFromConnection(constraint.entity2, connection);
							
							//refresh membran chain infos
							this.refreshMembranChains(constraint.entity1);
							this.refreshMembranChains(constraint.entity2);
							
							// destroy connection
							creator.destroyEntity(connection);
							
							// start from begin
							i = -1; // with immediate ++1 from for loop i==0 next loop start
						}
					}
				}
			}
		}
		
		internal function cleanMembranFromConnection(membranEntity:Entity, connectionEntity:Entity):void {
			if (!membranEntity.has(Membran) || !connectionEntity.has(DistanceConstraint)) {
				return;
			}
			var membran:Membran = membranEntity.get(Membran);
			var constraint:DistanceConstraint = connectionEntity.get(DistanceConstraint);
			
			// remove connection
			var idx:int = membran.connections.indexOf(connectionEntity);
			if (idx >= 0)
				membran.connections.splice(idx, 1);
			
			if (membranEntity == constraint.entity1) {
				delete membran.connected[constraint.entity2];
			} else if (membranEntity == constraint.entity2) {
				delete membran.connected[constraint.entity1];
			} else {
				//trace();
				throw new Error("Either entity1 or entity2 should be node, what is happening?");
			}
			
			// remove straigthener as this is only used when membran is fully connected
			if (membran.straigthener) {
				creator.destroyEntity(membran.straigthener);
				membran.straigthener = null;
			}
		}
		
		/**
		 * traverses whole chain over each entity
		 * @param	startMembranEntity
		 * @param	callback=function(current:Entity, accumulator:Object, visited:Dictionary)
		 * @param	accumulator
		 * @return  TraverseResults
		 */
		static public function traverseMembranChain(startMembranEntity:Entity, callback:Function, accumulator:Object = null):TraverseResult {
			var stack:Stack = new ArrayedStack(2);
			
			stack.push(startMembranEntity);
			
			var current:Entity;
			var membran:Membran;
			var results:TraverseResult = new TraverseResult(accumulator);
			var called:Dictionary;
			if (callback != null) {
				called = new Dictionary(accumulator)
			}
			var all_fully_connected:Boolean = true;
			
			results.remarks["circular"] = false;
			
			while (!stack.isEmpty()) {
				current = Entity(stack.pop());
				if (results.visited[current]) {
					results.remarks["circular"] = true;
				}
				results.visited[current] = current;
				results.numVisited++;
				if (current) {
					if (current.has(Membran)) {
						
						if (callback != null) {
							if (!called[current]) {
								callback.call(null, current, accumulator, results.visited);
								called[current] = current;
							}
						}
						
						membran = current.get(Membran);
						
						all_fully_connected &&= (membran.connections.length == 2);
						
						for (var i:int = 0; i < membran.connections.length; i++) {
							var connection:Entity = membran.connections[i];
							if (connection.has(DistanceConstraint)) {
								var constraint:DistanceConstraint = connection.get(DistanceConstraint);
								if (current == constraint.entity2) {
									if (!results.visited[constraint.entity1]) {
										stack.push(constraint.entity1);
									}
								}
								if (current == constraint.entity1) {
									if (!results.visited[constraint.entity2]) {
										stack.push(constraint.entity2);
									}
								}
							}
						}
					}
				}
			}
			if (all_fully_connected) {
				results.remarks["circular"] = true;
			}
			return results;
		}
		
		internal function refreshMembranChains(entity:Entity):void {
			// traverse to get info about chain
			var result:TraverseResult = traverseMembranChain(entity, null, null);
			
			// create new membran chain 
			var membranChainEntity:Entity = creator.createMembranChain();
			var membranChain:MembranChain = MembranChain(membranChainEntity.get(MembranChain));
			
			// fill membran chain with info about chain
			for (var current:Object in result.visited) {
				membranChain.addPart(Entity(current));
			}
			membranChain.circular = result.remarks["circular"];
			// update order order of parts
			if (membranChainEntity.has(MembranChainOrderedEntities) && !membranChainEntity.has(MembranChainUpdateOrderedEntities)) {
				membranChainEntity.add(new MembranChainUpdateOrderedEntities());
			}
			// apply new chain to all entities of chain
			traverseMembranChain(entity, function(current:Entity, accumulator:Object, visited:Dictionary):void {
					if (current.has(Membran)) {
						var membran:Membran = Membran(current.get(Membran));
						// remove old membran chain
						if (membran.chain.has(MembranChain)) {
							var chain:MembranChain = membran.chain.get(MembranChain);
							chain.removePart(current);
							// destroy old chain if it now has zero size
							if (chain.size == 0) {
								creator.destroyEntity(membran.chain);
								membran.chain = null;
							}
						}
						// apply new chain
						membran.chain = membranChainEntity;
					}
				}, null);
		}
		
		internal function checkCompleteness(node:MembranNode):void {
			if (node.membran.connections.length == 2) {
				
				var keys:Array = Utils.getKeys(node.membran.connected);
				if (keys.length == 2) {
					var connection:Entity = creator.createConnection(Entity(keys[0]), Entity(keys[1]), 50);
					connection.remove(Display);
					connection.remove(Breakable);
					if (connection.has(DistanceConstraint)) {
						var constraint:DistanceConstraint = connection.get(DistanceConstraint);
						
						var r1:Number = 0.2;
						var r2:Number = 0.6;
						constraint.strength *= Utils.randomRange(1 - r1, 1 + r2);
						constraint.distance *= Utils.randomRange(1 - r1, 1 + r2);
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
