package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.components.Anchor;
	import ld28.components.FitCircleToSize;
	import ld28.components.Position;
	import ld28.components.Size;
	import ld28.nodes.AlphaTweenNode;
	import ld28.nodes.FitCircleToSizeNode;
	import ld28.nodes.FitSizeAroundOtherEntityNode;
	
	public class FitCircleToSizeSystem extends ListIteratingSystem {
		
		public function FitCircleToSizeSystem() {
			super(FitCircleToSizeNode, updateNode);
		}
		
		private function updateNode(node:FitCircleToSizeNode, time:Number):void {
			if (node.fitCircleToSize.align == FitCircleToSize.ALIGN_AROUND) {
				if (node.size.align == Size.ALIGN_CENTER_CENTER) {
					var diag:Number = Math.sqrt(node.size.size.x * node.size.size.x + node.size.size.y * node.size.size.y);
					node.circle.radius = diag / 2;
				}
			}
		}
	}
}
