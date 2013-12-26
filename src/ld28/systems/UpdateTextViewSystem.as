package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.nodes.UpdateTextViewNode;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class UpdateTextViewSystem extends ListIteratingSystem {
		
		public function UpdateTextViewSystem() {
			super(UpdateTextViewNode, updateNode);
		
		}
		
		private function updateNode(node:UpdateTextViewNode, time:Number):void {
			node.updateTextView.view.text = node.text.text;
		}
	}

}