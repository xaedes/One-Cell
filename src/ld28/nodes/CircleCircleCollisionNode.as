package ld28.nodes {
	import ash.core.Node;
	import ld28.components.Circle;
	import ld28.components.CircleCircleCollision;
	import ld28.components.Collision;
	import ld28.components.Position;
	
	public class CircleCircleCollisionNode extends Node {
		public var circleCollision:CircleCircleCollision;
		public var collision:Collision;
		public var circle:Circle;
		public var position:Position;
	
	}

}