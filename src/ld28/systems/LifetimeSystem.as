package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.components.Anchor;
	import ld28.components.Position;
	import ld28.EntityCreator;
	import ld28.nodes.AnchorNode;
	import ld28.nodes.LifetimeNode;
	
	public class LifetimeSystem extends ListIteratingSystem {
		private var creator:EntityCreator;
		
		public function LifetimeSystem(creator:EntityCreator) {
			this.creator = creator;
			super(LifetimeNode, updateNode);
		}
		
		private function updateNode(node:LifetimeNode, time:Number):void {
			if (node.timer.seconds > node.lifetime.lifetime) {
				creator.destroyEntity(node.entity);
			}
		}
	}
}
