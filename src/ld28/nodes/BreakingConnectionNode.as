package ld28.nodes {
	import ash.core.Node;
	import ld28.components.Breakable;
	import ld28.components.DistanceConstraint;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class BreakingConnectionNode extends Node {
		public var breakable:Breakable;
		public var distanceConstraint:DistanceConstraint;
	}

}