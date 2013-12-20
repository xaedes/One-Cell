package ld28.systems {
	import ash.core.ComponentMatchingFamily;
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import ld28.components.Display;
	import ld28.components.Position;
	import ld28.EntityCreator;
	import ld28.graphics.TextView;
	import ld28.nodes.GameStateNode;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class GameManager extends System {
		private var creator:EntityCreator;
		private var game:GameStateNode;
		
		public function GameManager(creator:EntityCreator) {
			this.creator = creator;
		}
		
		override public function addToEngine(engine:Engine):void {
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
		
		override public function update(time:Number):void {
			if (game) {
				if (game.gameState.state == "") {
					//init
					var i:int;
					// spawn energy particles
					for (i = 0; i < 100; i++) {
						creator.createEnergyParticle();
					}
					// spawn energy producers
					for (i = 0; i < 10; i++) {
						creator.createEnergyProducer();
					}
					// spawn membran parts
					for (i = 0; i < 100; i++) {
						creator.createMembranPart();
					}
					creator.createPlayer();
					var text:Entity = creator.createText("Controls: WASD Space");
					var position:Position = Position(text.get(Position));
					position.position.x = 100;
					position.position.y = 50;
					var display:Display = Display(text.get(Display));
					var textView:TextView = TextView(display.displayObject);
					textView.textField.defaultTextFormat.align = TextFormatAlign.LEFT;
					textView.textField.autoSize = TextFieldAutoSize.LEFT;
					game.gameState.state = "alive";
					
				} else if (game.gameState.state == "alive") {
					
				}
			}
		}
	
	}

}