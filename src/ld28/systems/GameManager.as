package ld28.systems {
	import ash.core.ComponentMatchingFamily;
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import ld28.components.AlphaTween;
	import ld28.components.Anchor;
	import ld28.components.Circle;
	import ld28.components.Collision;
	import ld28.components.Display;
	import ld28.components.Lifetime;
	import ld28.components.Player;
	import ld28.components.Position;
	import ld28.components.Redrawing;
	import ld28.components.Size;
	import ld28.components.SpatialHashed;
	import ld28.components.Timer;
	import ld28.EntityCreator;
	import ld28.graphics.CircleView;
	import ld28.graphics.TextView;
	import ld28.nodes.GameStateNode;
	import ld28.nodes.MembranChainNode;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class GameManager extends System {
		private var creator:EntityCreator;
		private var engine:Engine;
		private var game:GameStateNode;
		private var entities:Dictionary = new Dictionary();
		private var membranChainNodes:NodeList = null;
		
		public function GameManager(creator:EntityCreator) {
			this.creator = creator;
		}
		
		override public function addToEngine(engine:Engine):void {
			this.engine = engine;
			var gameNodeList:NodeList = engine.getNodeList(GameStateNode);
			if (!gameNodeList.empty) {
				game = gameNodeList.head;
			} else {
				game = GameStateNode(ComponentMatchingFamily(engine.getFamily(GameStateNode)).nodeByEntity(engine.getEntityByName("game")));
				
				if (!game) {
					game = null;
				}
			}
		}
		
		override public function removeFromEngine(engine:Engine):void {
			game = null;
		}
		
		internal function state_init(time:Number):void {
			var position:Position;
			var display:Display;
			var textView:TextView;
			var size:Size;
			//init
			creator.createPlayer();
			
			entities["controls"] = creator.createText("Controls: W,A,S,D,Space");
			position = Position(entities["controls"].get(Position));
			position.position.x = 100;
			position.position.y = 50;
			display = Display(entities["controls"].get(Display));
			textView = TextView(display.displayObject);
			textView.textField.defaultTextFormat.align = TextFormatAlign.LEFT;
			textView.textField.autoSize = TextFieldAutoSize.LEFT;
			
			entities["move_here_text"] = creator.createText("Move here");
			position = Position(entities["move_here_text"].get(Position));
			position.position.x = 200;
			position.position.y = 150;
			size = Size(entities["move_here_text"].get(Size));
			display = Display(entities["move_here_text"].get(Display));
			textView = TextView(display.displayObject);
			textView.textField.y -= 10;
			
			entities["move_here_circle"] = creator.createCircle(10, 0xffffff, 0.1);
			entities["move_here_circle"].add(new Collision());
			entities["move_here_circle"].add(new SpatialHashed());
			entities["move_here_circle"].add(new Anchor(entities["move_here_text"]));
			display = Display(entities["move_here_circle"].get(Display));
			entities["move_here_circle"].add(new Redrawing(CircleView(display.displayObject)));
			game.gameState.state = "move_here";
		}
		
		internal function state_move_here(time:Number):void {
			var size:Size;
			var circle:Circle;
			var display:Display;
			var circleView:CircleView;
			var collision:Collision;
			var textView:TextView;
			var format:TextFormat;
			var entity:Entity;
			
			if (entities["move_here_text"]) {
				
				if (entities["move_here_circle"]) {
					size = Size(entities["move_here_text"].get(Size));
					circle = Circle(entities["move_here_circle"].get(Circle));
					circle.radius = size.size.x / 2;
					size = Size(entities["move_here_circle"].get(Size));
					size.size.x = circle.radius * 2;
					size.size.y = circle.radius * 2;
					display = Display(entities["move_here_circle"].get(Display));
					circleView = CircleView(display.displayObject);
					circleView._radius = circle.radius;
				}
				
				collision = Collision(entities["move_here_circle"].get(Collision));
				if (collision) {
					for each (entity in collision.collidingEntities) {
						if (entity.has(Player)) {
							if ((Circle(entity.get(Circle)).radius + Circle(entities["move_here_circle"].get(Circle)).radius) >= Point.distance(Position(entity.get(Position)).position, Position(entities["move_here_circle"].get(Position)).position)) {
								
								var tmp:Entity = creator.createFloatingText("Good job!", 2);
								display = Display(tmp.get(Display));
								textView = TextView(display.displayObject);
								
								format = new TextFormat();
								format.color = 0x52B600;
								format.size = 30;
								textView.textField.defaultTextFormat = format;
								
								tmp.add(new Anchor(entities["move_here_text"]));
								entities["move_here_circle"].remove(Collision);
								
								entities["move_here_circle"].add(new Lifetime(5));
								entities["move_here_circle"].add(new Timer());
								entities["move_here_circle"].add(new AlphaTween(0, 5));
								
								entities["move_here_text"].add(new Lifetime(5));
								entities["move_here_text"].add(new Timer());
								entities["move_here_text"].add(new AlphaTween(0, 5));
								
								delete entities["move_here_text"];
								delete entities["move_here_circle"];
								
								var i:int;
								// spawn energy particles
								for (i = 0; i < 10; i++) {
									creator.createEnergyParticle();
								}
								// spawn energy producers
								for (i = 0; i < 2; i++) {
									creator.createEnergyProducer();
								}
								// spawn membran parts
								for (i = 0; i < 20; i++) {
									creator.createMembranPart();
								}
								game.gameState.state = "alive";
								
								membranChainNodes = engine.getNodeList(MembranChainNode);
							}
						}
					}
				}
			}
		
		}
		
		internal function state_alive(time:Number):void {
		/* empty */
		}
		
		override public function update(time:Number):void {
			var display:Display;
			if (game) {
				if (entities["controls"]) {
					display = Display(entities["controls"].get(Display));
					display.container.setChildIndex(display.displayObject, display.container.numChildren - 1);
				}
				if (entities["move_here_text"]) {
					display = Display(entities["move_here_text"].get(Display));
					display.container.setChildIndex(display.displayObject, display.container.numChildren - 1);
				}
				if (game.gameState.state == "") {
					state_init(time);
				} else if (game.gameState.state == "move_here") {
					state_move_here(time);
				} else if (game.gameState.state == "alive") {
					state_alive(time);
				}
				
			}
		}
	
	}

}