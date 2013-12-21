package ld28 {
	import ash.core.Engine;
	import ash.tick.FrameTickProvider;
	import flash.display.DisplayObjectContainer;
	import ld28.input.KeyPoll;
	import ld28.input.MousePoll;
	import ld28.systems.AlphaTweenSystem;
	import ld28.systems.AnchorSystem;
	import ld28.systems.AttractorControllerSystem;
	import ld28.systems.AttractorSystem;
	import ld28.systems.AudioSystem;
	import ld28.systems.AutoResizingRectViewSystem;
	import ld28.systems.BreakingConnectionSystem;
	import ld28.systems.CollisionWithSpatialHashingSystem;
	import ld28.systems.DistanceConstraintSystem;
	import ld28.systems.EnergyCollectingCollisionSystem;
	import ld28.systems.EnergyProducerSystem;
	import ld28.systems.EnergyStorageEmitterSystem;
	import ld28.systems.EnergyStorageViewSystem;
	import ld28.systems.EnergyStorageWarningSystem;
	import ld28.systems.GameManager;
	import ld28.systems.GravitySystem;
	import ld28.systems.KeyboardMotionControlSystem;
	import ld28.systems.LifetimeSystem;
	import ld28.systems.MembranChainSpatialUpdateSystem;
	import ld28.systems.MembranSystem;
	import ld28.systems.MovementSystem;
	import ld28.systems.PositionTweenSystem;
	import ld28.systems.RedrawingSystem;
	import ld28.systems.RenderSystem;
	import ld28.systems.SolidCollisionSystem;
	import ld28.systems.SpatialHashingSystem;
	import ld28.systems.TextViewAutosizeSystem;
	import ld28.systems.TimerSystem;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class Game {
		private var container:DisplayObjectContainer;
		private var engine:Engine;
		private var tickProvider:FrameTickProvider;
		private var creator:EntityCreator;
		private var keyPoll:KeyPoll;
		private var mousePoll:MousePoll;
		private var config:GameConfig;
		
		public function Game(container:DisplayObjectContainer, width:Number, height:Number) {
			this.container = container;
			prepare(width, height);
		}
		
		// todo 
		// - add simple circle to be drawn
		//   - add entity for it
		//   - add movement
		
		private function prepare(width:Number, height:Number):void {
			engine = new Engine();
			keyPoll = new KeyPoll(container.stage);
			mousePoll = new MousePoll(container.stage);
			config = new GameConfig();
			config.width = width;
			config.height = height;
			creator = new EntityCreator(engine, config);
			
			// create game entity
			creator.createGame();
			
			// add systems 
			// todo: add priorites (CollisionSystem < SolidCollisionSystem, CollisionSystem < EnergyCollectingCollisionSystem)
			var spatialHashingSystem:SpatialHashingSystem = new SpatialHashingSystem(config, 10);
			var k:int = 0;
			engine.addSystem(new RedrawingSystem(), k++);
			engine.addSystem(new AnchorSystem(), k++);
			engine.addSystem(new MovementSystem(config), k++);
			engine.addSystem(new GravitySystem(), k++);
			engine.addSystem(new KeyboardMotionControlSystem(keyPoll), k++);
			//engine.addSystem(new MouseMotionControlSystem(mousePoll), k++);
			engine.addSystem(new EnergyStorageViewSystem(), k++);
			//engine.addSystem(new CollisionSystem(), 0);
			engine.addSystem(spatialHashingSystem, k++);
			engine.addSystem(new CollisionWithSpatialHashingSystem(spatialHashingSystem), k++);
			engine.addSystem(new EnergyCollectingCollisionSystem(creator, config), k++);
			engine.addSystem(new SolidCollisionSystem(), k++);
			engine.addSystem(new EnergyStorageEmitterSystem(creator), k++);
			engine.addSystem(new AudioSystem(), k++);
			engine.addSystem(new EnergyProducerSystem(), k++);
			engine.addSystem(new MembranSystem(creator), k++);
			engine.addSystem(new DistanceConstraintSystem(), k++);
			engine.addSystem(new BreakingConnectionSystem(), k++);
			engine.addSystem(new TimerSystem(), k++);
			engine.addSystem(new LifetimeSystem(creator), k++);
			engine.addSystem(new AttractorSystem(), k++);
			engine.addSystem(new AttractorControllerSystem(keyPoll), k++);
			engine.addSystem(new GameManager(creator), k++);
			engine.addSystem(new AlphaTweenSystem(), k++);
			engine.addSystem(new PositionTweenSystem(), k++);
			engine.addSystem(new EnergyStorageWarningSystem(creator), k++);
			engine.addSystem(new TextViewAutosizeSystem(), k++);
			engine.addSystem(new MembranChainSpatialUpdateSystem(), k++);
			engine.addSystem(new AutoResizingRectViewSystem(), k++);
			engine.addSystem(new RenderSystem(container), k++);
		
		}
		
		public function start():void {
			tickProvider = new FrameTickProvider(container);
			tickProvider.add(engine.update);
			tickProvider.start();
		}
	}

}