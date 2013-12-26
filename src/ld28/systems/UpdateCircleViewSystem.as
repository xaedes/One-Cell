package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.components.Anchor;
	import ld28.components.Position;
	import ld28.components.Size;
	import ld28.nodes.AlphaTweenNode;
	import ld28.nodes.FitSizeAroundOtherEntityNode;
	import ld28.nodes.UpdateCircleViewNode;
	
	public class UpdateCircleViewSystem extends ListIteratingSystem {
		
		public function UpdateCircleViewSystem() {
			super(UpdateCircleViewNode, updateNode);
		}
		
		private function updateNode(node:UpdateCircleViewNode, time:Number):void {
			node.updateCircleView.circleView.radius = node.circle.radius;
		}
	}
}
