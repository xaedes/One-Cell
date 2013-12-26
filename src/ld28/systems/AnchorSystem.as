package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import flash.geom.Point;
	import ld28.components.Anchor;
	import ld28.components.Position;
	import ld28.components.Size;
	import ld28.nodes.AnchorNode;
	import ld28.Utils;
	
	public class AnchorSystem extends ListIteratingSystem {
		
		public function AnchorSystem() {
			super(AnchorNode, updateNode);
		}
		
		private function updateNode(node:AnchorNode, time:Number):void {
			var position:Position = node.position;
			var anchor:Anchor = node.anchor;
			
			var anchorPosition:Position = anchor.entity.get(Position);
			
			position.position.x = anchorPosition.position.x + anchor.offset.x;
			position.position.y = anchorPosition.position.y + anchor.offset.y;
			
			if (anchor.entity.has(Size) && node.entity.has(Size)) {
				var size:Size = node.entity.get(Size);
				var anchorSize:Size = anchor.entity.get(Size);
				//
				//if((node.anchor.align==Anchor.ALIGN_TOP_LEFT)
				
				//var entityAlignOffset:Point = Size.getAlignOffset(size.size, node.anchor.align);
				//var anchorAlignOffset:Point = Size.getAlignOffset(anchorSize.size, node.anchor.align);
				//Utils.pointAdd(position.position, entityAlignOffset);
				//Utils.pointSub(position.position, anchorAlignOffset);
				Utils.pointAdd(position.position, size.alignOffset);
				Utils.pointSub(position.position, anchorSize.alignOffset);
				
				Utils.pointSub(position.position, Size.getAlignOffset(size.size, node.anchor.align));
				Utils.pointAdd(position.position, Size.getAlignOffset(anchorSize.size, node.anchor.align));
				
					//Utils.pointAdd(position.position, size.alignOffset);
					//Utils.pointSub(position.position, anchorSize.alignOffset);
			}
		}
	}
}
