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
	import ld28.components.CircleCircleCollision;
	import ld28.components.Display;
	import ld28.components.EnergyStorage;
	import ld28.components.Lifetime;
	import ld28.components.Mover;
	import ld28.components.Position;
	import ld28.components.Timer;
	import ld28.components.Size;
	import ld28.EntityCreator;
	import ld28.graphics.TextView;
	import ld28.nodes.GameStateNode;
	import ld28.Utils;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	
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
		private var reflectionType:Type;
		
		public function GameManager(creator:EntityCreator) {
			this.creator = creator;
			this.reflectionType = Type.forInstance(this);
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
		
		public function state_start_init(time:Number):void {
			var position:Position;
			var display:Display;
			var textView:TextView;
			var size:Size;
			
			entities["player"] = creator.createPlayer();
			
			entities["controls"] = creator.createText("Controls: W,A,S,D,Space");
			position = Position(entities["controls"].get(Position));
			position.position.x = 100;
			position.position.y = 50;
			display = Display(entities["controls"].get(Display));
			textView = TextView(display.displayObject);
			textView.textField.defaultTextFormat.align = TextFormatAlign.LEFT;
			textView.textField.autoSize = TextFieldAutoSize.LEFT;
			
			game.gameState.initialized = true;
		}
		
		internal function blendOutEntity(entity:Entity, t:Number = 1):void {
			entity.add(new Timer());
			entity.add(new Lifetime(t));
			entity.add(new AlphaTween(0, t));
		}
		
		public function state_start(time:Number):void {
			game.gameState.state = "move_here";
		}
		
		public function state_move_here_init(time:Number):void {
			// player can move for free
			Mover(entities["player"].get(Mover)).energyConsumption = 0;
			
			// give player goal to move to
			entities[game.gameState.state + "_goal"] = creator.createLabeledCircle("Move here", 200, 250);
			
			game.gameState.initialized = true;
		}
		
		public function state_move_here(time:Number):void {
			if (CircleCircleCollision(entities[game.gameState.state + "_goal"].get(CircleCircleCollision)).collidingEntities[entities["player"]]) {
				// give player positive feedback
				entities[game.gameState.state + "_good_job"] = creator.createFloatingText("Good job!");
				var position:Position = Position(entities[game.gameState.state + "_good_job"].get(Position));
				var textView:TextView = TextView(Display(entities[game.gameState.state + "_good_job"].get(Display)).displayObject);
				Utils.pointSet(position.position, Position(entities[game.gameState.state + "_goal"].get(Position)).position);
				Utils.pointAdd(position.position, new Point(0, -60));
				textView.textField.defaultTextFormat = new TextFormat(null, 30, 0x52B600);
				
				// remove old goal
				blendOutEntity(entities[game.gameState.state + "_goal"]);
				delete entities[game.gameState.state + "_goal"];
				
				game.gameState.state = "learn_about_energy";
			}
		}
		
		public function state_learn_about_energy_init(time:Number):void {
			// player movement now costs a lot of energy
			Mover(entities["player"].get(Mover)).energyConsumption = 0.006;
			
			// give player goal to move to
			entities[game.gameState.state + "_goal"] = creator.createLabeledCircle("Now move here", 500, 350);
			
			// tell player that he consumes energy while moving
			entities[game.gameState.state + "_hint1"] = creator.createFloatingText("Moving consumes energy", 5);
			entities[game.gameState.state + "_hint1"].add(new Anchor(entities["player"], new Point(0, -60)));
			
			game.gameState.initialized = true;
		}
		
		public function state_learn_about_energy(time:Number):void {
			var energyStorage:EnergyStorage = EnergyStorage(entities["player"].get(EnergyStorage));
			
			if ((energyStorage.maxEnergy > 0) && (energyStorage.energy <= 0)) {
				// tell player that movement is not possible without energy
				if (!entities[game.gameState.state + "_hint2"]) {
					entities[game.gameState.state + "_hint2"] = creator.createFloatingText("Without energy you can not move", 5);
					entities[game.gameState.state + "_hint2"].add(new Anchor(entities["player"], new Point(0, -60)));
				}
			}
		
			//var minEnergy = energyStorage.maxEnergy * 0.1;
			//if (energyStorage.energy < minEnergy)
			//energyStorage.energy = minEnergy;
		}
		
		//internal function state_build_ring(time:Number):void {
		//var chains:NodeList = engine.getNodeList(MembranChainNode);
		//if (chains.size == 1) {
		//
		//}
		//}
		
		public function state_alive_init(time:Number):void {
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
			game.gameState.initialized = true;
		}
		
		public function state_alive(time:Number):void {
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
					game.gameState.state = "start";
				}
				var method_name:String = "state_" + game.gameState.state;
				if (!game.gameState.initialized) {
					var method_init_name:String = method_name + "_init";
					var state_init_handler:Method = this.reflectionType.getMethod(method_init_name);
					if (state_init_handler) {
						state_init_handler.invoke(this, [time]);
					} else {
						// no init handler, so skip initialization
						game.gameState.initialized = true;
					}
				}
				var state_handler:Method = this.reflectionType.getMethod(method_name);
				if (state_handler) {
					state_handler.invoke(this, [time]);
				} else {
					throw new Error("game state handler for state '" + method_name + "' not implemented");
				}
				
			}
		}
	
	}

}