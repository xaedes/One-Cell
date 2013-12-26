package ld28.nodes {
	import ash.core.Node;
	import ld28.components.Attracting;
	import ld28.components.Attractor;
	import ld28.components.AttractorController;
	import ld28.components.StateMachine;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class AttractorControllerNode extends Node {
		public var attractorController:AttractorController;
		public var attractor:Attractor;
		public var stateMachine:StateMachine;
	
	}

}