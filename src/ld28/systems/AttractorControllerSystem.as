package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import ld28.components.Anchor;
	import ld28.components.Position;
	import ld28.input.KeyPoll;
	import ld28.nodes.AnchorNode;
	import ld28.nodes.AttractorControllerNode;
	
	public class AttractorControllerSystem extends ListIteratingSystem {
		private var keyPoll:KeyPoll;
		
		public function AttractorControllerSystem(keyPoll:KeyPoll) {
			this.keyPoll = keyPoll;
			super(AttractorControllerNode, updateNode);
		}
		
		private function updateNode(node:AttractorControllerNode, time:Number):void {
			if (keyPoll.isDown(node.attractorController.activate)) {
				node.stateMachine.fsm.changeState("active");
			} else {
				node.stateMachine.fsm.changeState("inactive");
					//node.attractor.strength = 0;		
			}
		}
	}
}
