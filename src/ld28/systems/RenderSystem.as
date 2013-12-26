package ld28.systems {
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import ld28.components.Display;
	import ld28.components.Position;
	import ld28.components.PositionTween;
	import ld28.components.Size;
	import ld28.nodes.RenderNode;
	import ld28.Utils;
	
	public class RenderSystem extends System {
		public var container:DisplayObjectContainer;
		
		private var nodes:NodeList;
		
		public function RenderSystem(container:DisplayObjectContainer) {
			this.container = container;
		}
		
		override public function addToEngine(engine:Engine):void {
			nodes = engine.getNodeList(RenderNode);
			for (var node:RenderNode = nodes.head; node; node = node.next) {
				addToDisplay(node);
			}
			nodes.nodeAdded.add(addToDisplay);
			nodes.nodeRemoved.add(removeFromDisplay);
		}
		
		private function addToDisplay(node:RenderNode):void {
			node.display.container = container;
			container.addChild(node.display.displayObject);
		}
		
		private function removeFromDisplay(node:RenderNode):void {
			node.display.container = null;
			container.removeChild(node.display.displayObject);
		}
		
		override public function update(time:Number):void {
			var node:RenderNode;
			var position:Position;
			var display:Display;
			var displayObject:DisplayObject;
			
			for (node = nodes.head; node; node = node.next) {
				var additional:Point = new Point(0, 0);
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;
				
				if (node.entity.has(PositionTween)) {
					var positionTween:PositionTween = PositionTween(node.entity.get(PositionTween));
					if (positionTween.current) {
						Utils.pointAdd(additional, positionTween.current);
					}
				}
				//if (node.entity.has(Size)) {
				//var size:Size = Size(node.entity.get(Size));
				//Utils.pointSub(additional, size.alignOffset);
				//
				//}
				
				displayObject.x = position.position.x + additional.x;
				displayObject.y = position.position.y + additional.y;
					//container.setChildIndex
			}
		}
		
		override public function removeFromEngine(engine:Engine):void {
			nodes = null;
		}
	}
}
