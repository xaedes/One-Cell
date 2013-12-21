package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.nodes.AutoResizingRectViewNode;
	
	public class AutoResizingRectViewSystem extends ListIteratingSystem {
		
		public function AutoResizingRectViewSystem() {
			super(AutoResizingRectViewNode, updateNode);
		
		}
		
		private function updateNode(node:AutoResizingRectViewNode, time:Number):void {
			//set (x,y) of rect to (0,0) because it is already displayed with offset of node.position.position
			node.autoResizingRectView.rectView._rect.x = 0;
			node.autoResizingRectView.rectView._rect.y = 0;
			
			// set dimensions
			node.autoResizingRectView.rectView._rect.width = node.size.size.x;
			node.autoResizingRectView.rectView._rect.height = node.size.size.y;
		}
	}

}