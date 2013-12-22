package ld28.systems {
	import ash.core.Entity;
	import ash.tools.ListIteratingSystem;
	import flash.utils.Dictionary;
	import ld28.components.AlphaTween;
	import ld28.components.Anchor;
	import ld28.components.CanBeContainedInMembranChains;
	import ld28.components.Display;
	import ld28.components.Lifetime;
	import ld28.components.Membran;
	import ld28.components.MembranChain;
	import ld28.components.Player;
	import ld28.components.Position;
	import ld28.components.Redrawing;
	import ld28.components.Timer;
	import ld28.EntityCreator;
	import ld28.etc.TraverseResult;
	import ld28.graphics.CircleView;
	import ld28.nodes.MembranChainContainedEntitesNode;
	import ld28.Utils;
	
	public class MembranChainContainedEntitesSystem extends ListIteratingSystem {
		public var creator:EntityCreator;
		
		public function MembranChainContainedEntitesSystem(creator:EntityCreator) {
			super(MembranChainContainedEntitesNode, updateNode);
			this.creator = creator;
		
		}
		
		private function updateNode(node:MembranChainContainedEntitesNode, time:Number):void {
			if (node.membranChain.circular == false) {
				Utils.dictionaryClean(node.membranChain.containedEntities);
				return;
			}
			var position:Position;
			for (var obj:Object in node.collision.collidingEntities) {
				var entity:Entity = Entity(obj);
				//dont contain the membran parts
				if (node.membranChain.partEntities[entity])
					continue;
				
				if (entity.has(CanBeContainedInMembranChains)) {
					var canBeContainedInMembranChains:CanBeContainedInMembranChains = CanBeContainedInMembranChains(entity.get(CanBeContainedInMembranChains));
					if (entity.has(Position)) {
						position = Position(entity.get(Position));
						
						// test if entity is contained in membran chain or not
						//  - simplyfy to position of entity inside concav polygon build by membran part entities positions
						// -> test position inside or outside of concav polygon
						// use Ray casting algorithm (http://en.wikipedia.org/wiki/Point_in_polygon) for this
						// cast ray along x-axis -> look for intersections in y-axis to find intersecting connections
						// count intersections
						var intersections:int = 0;
						var direction:int = -1;
						var lastY:Number;
						var lastX:Number;
						var thisY:Number;
						var thisX:Number;
						lastX = Position(node.membranChainOrderedEntities.ordered[node.membranChainOrderedEntities.ordered.length - 1].get(Position)).position.x;
						lastY = Position(node.membranChainOrderedEntities.ordered[node.membranChainOrderedEntities.ordered.length - 1].get(Position)).position.y;
						for (var i:int = 0; i < node.membranChainOrderedEntities.ordered.length; i++) {
							thisY = Position(node.membranChainOrderedEntities.ordered[i].get(Position)).position.y;
							thisX = Position(node.membranChainOrderedEntities.ordered[i].get(Position)).position.x;
							if ((position.position.y >= Math.min(lastY, thisY)) && (position.position.y <= Math.max(lastY, thisY))) {
								// intersection
								var intersectX:Number = lastX + (thisX - lastX) * (position.position.y - lastY) / (thisY - lastY);
								if (direction == 0) {
									if (intersectX >= position.position.x) {
										direction = 1;
									} else {
										direction = -1;
									}
									intersections++;
								} else {
									if (direction == 1) {
										if (intersectX >= position.position.x) {
											intersections++;
											
										}
									} else if (direction == -1) {
										if (intersectX <= position.position.x) {
											intersections++;
										}
									}
								}
							}
							lastX = thisX;
							lastY = thisY;
						}
						if ((intersections > 0) && (intersections % 2 == 1)) { // inside
							if (!node.membranChain.containedEntities[entity]) {
								node.membranChain.containedEntities[entity] = entity;
								canBeContainedInMembranChains.addMembranChain(node.entity);
									//var time:Number = 1;
									////var circle:Entity = creator.createCircle(10, 0xBCE8FF, 0.6);
									//var circle:Entity = creator.createCircle(10, 0xFF0000, 0.6);
									//var display:Display = Display(circle.get(Display));
									//var circlePosition:Position = Position(circle.get(Position));
									//circlePosition.position.x = position.position.x;
									//circlePosition.position.y = position.position.y;
									//circle.add(new Anchor(entity));
									//circle.add(new Lifetime(time));
									//circle.add(new Timer());
									//circle.add(new Redrawing(CircleView(display.displayObject)));
									//circle.add(new AlphaTween(0, time));
							}
							
						} else {
							if (node.membranChain.containedEntities[entity]) {
								canBeContainedInMembranChains.removeMembranChain(node.entity);
								delete node.membranChain.containedEntities[entity];
							}
						}
						
					}
				}
			}
		
		}
	}

}