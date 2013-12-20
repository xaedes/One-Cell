package ld28.systems {
	import ash.core.ComponentMatchingFamily;
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import ld28.EntityCreator;
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
					
					game.gameState.state = "alive";
					
				} else if (game.gameState.state == "alive") {
					
				}
			}
		}
	
	}

}