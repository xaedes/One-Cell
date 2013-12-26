package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import flash.geom.Rectangle;
	import ld28.nodes.AutosizeNode;
	
	public class AutosizeSystem extends ListIteratingSystem {
		
		public function AutosizeSystem() {
			super(AutosizeNode, updateNode);
		}
		
		private function updateNode(node:AutosizeNode, time:Number):void {
			var rect:Rectangle = node.autosize.displayObject.getRect(node.autosize.displayObject.parent);
			
			node.size.size.x = rect.width;
			node.size.size.y = rect.height;
		}
	}
}
