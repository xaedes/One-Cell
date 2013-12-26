package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.nodes.UpdateLabeledCircleNode;
	
	public class UpdateLabeledCircleSystem extends ListIteratingSystem {
		
		public function UpdateLabeledCircleSystem() {
			super(UpdateLabeledCircleNode, updateNode);
		}
		
		private function updateNode(node:UpdateLabeledCircleNode, time:Number):void {
			
			node.updateLabeledCircle.view.textView.x = -node.updateLabeledCircle.view.textView.width / 2;
			node.updateLabeledCircle.view.textView.y = -node.updateLabeledCircle.view.textView.height / 2;
			node.circle.radius = node.padding.padding + 0.5 * Math.sqrt(node.updateLabeledCircle.view.textView.width * node.updateLabeledCircle.view.textView.width + node.updateLabeledCircle.view.textView.height * node.updateLabeledCircle.view.textView.height);
		}
	}
}
