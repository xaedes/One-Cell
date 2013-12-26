package ld28.systems {
	import ash.core.Entity;
	import ash.tools.ListIteratingSystem;
	import flash.events.TouchEvent;
	import flash.utils.Dictionary;
	import ld28.components.AlphaTween;
	import ld28.components.Anchor;
	import ld28.components.Display;
	import ld28.components.Lifetime;
	import ld28.components.Redrawing;
	import ld28.components.Timer;
	import ld28.EntityCreator;
	import ld28.etc.TraverseResult;
	import ld28.graphics.CircleView;
	import ld28.nodes.MembranChainOrderedEntitiesNode;
	import ld28.Utils;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class MembranChainOrderedEntitiesSystem extends ListIteratingSystem {
		public var creator:EntityCreator;
		
		public function MembranChainOrderedEntitiesSystem(creator:EntityCreator) {
			super(MembranChainOrderedEntitiesNode, updateNode);
			this.creator = creator;
		
		}
		
		private function updateNode(node:MembranChainOrderedEntitiesNode, time:Number):void {
			if (node.membranChainOrderedEntities.needsUpdate) {
				var start:Entity = null;
				if (node.membranChain.circular) {
					start = Entity(Utils.getIthKey(node.membranChain.partEntities, 0));
				} else {
					// get tail of membran chain
					var results:TraverseResult = MembranSystem.traverseMembranChain(Entity(Utils.getIthKey(node.membranChain.partEntities, 0)), function(current:Entity, accumulator:Object, visited:Dictionary):void {
							if (accumulator == null) {
								accumulator = new Dictionary();
								accumulator["tail"] = null;
							}
							accumulator["tail"] = current;
						}, new Dictionary());
					start = Entity(results.accumulator["tail"]); // one of the tails
				}
				//trace("blob", start);
				if (start) {
					
					// clean old ordered list
					node.membranChainOrderedEntities.ordered.splice(0, node.membranChainOrderedEntities.ordered.length);
					// traverse from start and put all walked entities in ordered list
					MembranSystem.traverseMembranChain(start, function(current:Entity, accumulator:Object, visited:Dictionary):void {
							node.membranChainOrderedEntities.ordered.push(current);
							
							//just for fun and debugging add visuals when order updated
							var time:Number = 1;
							var circle:Entity = creator.createCircle(10, 0xBCE8FF, 0.6);
							var display:Display = Display(circle.get(Display));
							circle.add(new Anchor(current));
							circle.add(new Lifetime(time));
							circle.add(new Timer());
							circle.add(new Redrawing(CircleView(display.displayObject)));
							circle.add(new AlphaTween(0, time));
						}, null);
				}
				node.membranChainOrderedEntities.needsUpdate = false;
			}
		}
	}

}