package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.components.Anchor;
	import ld28.components.Position;
	import ld28.nodes.AlphaTweenNode;
	
	public class AlphaTweenSystem extends ListIteratingSystem {
		
		public function AlphaTweenSystem() {
			super(AlphaTweenNode, updateNode);
		}
		
		private function updateNode(node:AlphaTweenNode, time:Number):void {
			if (node.tween.start == -1) {
				node.tween.start = node.display.displayObject.alpha
			}
			if ((node.tween.destination >= 0) && (node.tween.start >= 0) && (node.tween.time > 0)) {
				node.display.displayObject.alpha = node.tween.ease.call(null, node.timer.seconds, node.tween.start, node.tween.destination - node.tween.start, node.tween.time);
			}
		}
	}
}
