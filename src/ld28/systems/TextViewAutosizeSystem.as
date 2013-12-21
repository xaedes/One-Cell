package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import ld28.components.Anchor;
	import ld28.components.Position;
	import ld28.graphics.TextView;
	import ld28.nodes.AlphaTweenNode;
	import ld28.nodes.TextViewAutosizeNode;
	
	public class TextViewAutosizeSystem extends ListIteratingSystem {
		
		public function TextViewAutosizeSystem() {
			super(TextViewAutosizeNode, updateNode);
		}
		
		private function updateNode(node:TextViewAutosizeNode, time:Number):void {
			if (node.textViewAutosize.textView == null) {
				node.textViewAutosize.textView = TextView(node.display.displayObject);
			}
			//trace(node.textViewAutosize.textView.getRect(node.textViewAutosize.textView.stage));
			var rect:Rectangle = node.textViewAutosize.textView.getRect(node.textViewAutosize.textView.stage);
			node.size.size.x = rect.width;
			node.size.size.y = rect.height;
		}
	}
}
