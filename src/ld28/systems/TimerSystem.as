package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.components.Anchor;
	import ld28.components.Position;
	import ld28.nodes.TimerNode;
	
	public class TimerSystem extends ListIteratingSystem {
		
		public function TimerSystem() {
			super(TimerNode, updateNode);
		}
		
		private function updateNode(node:TimerNode, time:Number):void {
			node.timer.seconds += time;
		}
	}
}
