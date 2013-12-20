package ld28 {
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.fsm.EntityState;
	import ash.fsm.EntityStateMachine;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.net.LocalConnection;
	import flash.ui.Keyboard;
	import ld28.components.AlphaTween;
	import ld28.components.Anchor;
	import ld28.components.Attractable;
	import ld28.components.Attracting;
	import ld28.components.Attractor;
	import ld28.components.AttractorController;
	import ld28.components.Audio;
	import ld28.components.Breakable;
	import ld28.components.Circle;
	import ld28.components.Collision;
	import ld28.components.Display;
	import ld28.components.DistanceConstraint;
	import ld28.components.EnergyCollecting;
	import ld28.components.EnergyParticle;
	import ld28.components.EnergyProducer;
	import ld28.components.EnergyStorage;
	import ld28.components.EnergyStorageEmitter;
	import ld28.components.EnergyStorageWarning;
	import ld28.components.GameState;
	import ld28.components.Gravity;
	import ld28.components.HasEnergyStorageView;
	import ld28.components.Lifetime;
	import ld28.components.Mass;
	import ld28.components.Membran;
	import ld28.components.Motion;
	import ld28.components.KeyboardMotionControls;
	import ld28.components.MouseMotionControls;
	import ld28.components.Mover;
	import ld28.components.Player;
	import ld28.components.Position;
	import ld28.components.PositionTween;
	import ld28.components.Radar;
	import ld28.components.Redrawing;
	import ld28.components.Size;
	import ld28.components.SolidCollision;
	import ld28.components.SpatialHashed;
	import ld28.components.Text;
	import ld28.components.TextViewAutosize;
	import ld28.components.Timer;
	import ld28.easing.Easing;
	import ld28.graphics.CircleView;
	import ld28.graphics.EnergyParticleView;
	import ld28.graphics.EnergyProducerView;
	import ld28.graphics.LineView;
	import ld28.graphics.MembranPartView;
	import ld28.graphics.MoverView;
	import ld28.graphics.TextView;
	
	public class EntityCreator {
		private var engine:Engine;
		private var config:GameConfig;
		
		public function EntityCreator(engine:Engine, config:GameConfig) {
			this.engine = engine;
			this.config = config;
		}
		
		public function destroyEntity(entity:Entity):void {
			engine.removeEntity(entity);
		}
		
		public function createGame():Entity {
			var gameEntity:Entity = new Entity("game");
			gameEntity.add(new GameState());
			engine.addEntity(gameEntity);
			return gameEntity;
		}
		
		public function createPlayer():Entity {
			var entity:Entity = new Entity();
			
			var radius:Number = 20;
			var density:Number = 100;
			
			var pos:Point = new Point(config.width / 2, config.height / 2);
			
			var attractor:Entity = createAttractor(radius * 3, 5);
			attractor.add(new Anchor(entity));
			attractor.add(new AttractorController(Keyboard.SPACE));
			
			var moverView:MoverView = new MoverView(radius);
			with (entity) {
				add(new Player());
				add(new Position(pos.x, pos.y));
				add(new Size(new Point(radius * 2, radius * 2)));
				add(new Circle(radius));
				add(new Display(moverView));
				add(new Mover(0.001));
				//add(new Mover(0.0));
				add(new Motion(0, 0, 0.95));
				add(new EnergyStorage(10, 5));
				add(new HasEnergyStorageView(moverView.energyStorageView));
				add(new KeyboardMotionControls(Keyboard.A, Keyboard.D, Keyboard.W, Keyboard.S, 1000));
				//add(new MouseMotionControls(100));
				
				add(new Audio());
				add(new EnergyStorageEmitter(0.1, radius + 3, 1, 10, 0, 1, 1));
				add(new Mass(radius * radius * Math.PI * density));
				add(new Collision());
				add(new SolidCollision(0.9));
				add(new EnergyCollecting());
				add(new SpatialHashed());
				add(new EnergyStorageWarning(0.3, 2, 1));
				
			}
			
			engine.addEntity(entity);
			return entity;
		}
		
		public function createEnergyParticle(energyAmount:Number = 1):Entity {
			var entity:Entity = new Entity();
			
			var radius:Number = 2;
			var density:Number = 1;
			var pos:Point = new Point(Utils.randomRange(0, config.width), Utils.randomRange(0, config.height));
			
			//var view:CircleView = new CircleView(radius, 0xFFF4BA);
			var view:EnergyParticleView = new EnergyParticleView(entity);
			with (entity) {
				add(new Position(pos.x, pos.y));
				add(new Size(new Point(radius * 2, radius * 2)));
				add(new Circle(radius));
				add(new Redrawing(view));
				add(new Display(view));
				add(new Motion(Utils.randomRange(-10, 10), Utils.randomRange(-10, 10), 0.999));
				add(new EnergyStorage(energyAmount, energyAmount));
				add(new Collision());
				add(new EnergyParticle());
				add(new SpatialHashed());
				add(new Mass(radius * radius * Math.PI * density));
				add(new SolidCollision(0.6));
				add(new Timer());
				add(new Lifetime(5));
				add(new Attractable(-1));
					//add(new Gravity(new Point(config.width / 2, 3 * config.height / 4), 5));
			}
			
			engine.addEntity(entity);
			return entity;
		}
		
		public function createEnergyProducer():Entity {
			var entity:Entity = new Entity();
			
			var radius:Number = 10;
			var density:Number = 1;
			var _maxEnergy:Number = Utils.randomRange(5, 15);
			var pos:Point = new Point(Utils.randomRange(0, config.width), Utils.randomRange(0, config.height));
			
			var energyProducerView:EnergyProducerView = new EnergyProducerView(radius);
			with (entity) {
				add(new Position(pos.x, pos.y));
				add(new Size(new Point(radius * 2, radius * 2)));
				add(new Circle(radius));
				add(new Display(energyProducerView));
				add(new Motion(Utils.randomRange(-50, 50), Utils.randomRange(-50, 50), 0.995));
				add(new EnergyStorage(_maxEnergy, Utils.randomRange(0, _maxEnergy)));
				add(new Collision());
				//add(new EnergyProducer(0.1, 0.03));
				add(new EnergyProducer(0.1, 0.2));
				add(new EnergyStorageEmitter(0.01, radius + 3, 0, 30, 1, 2, 5));
				add(new HasEnergyStorageView(energyProducerView.energyStorageView));
				add(new Mass(radius * radius * Math.PI * density));
				add(new SolidCollision(0.05));
				add(new EnergyCollecting());
				add(new SpatialHashed());
				add(new Attractable(1));
				add(new Gravity(new Point(config.width / 2, 1 * config.height / 4), 3));
			}
			engine.addEntity(entity);
			return entity;
		}
		
		public function createRadar(radius:Number):Entity {
			var entity:Entity = new Entity();
			engine.addEntity(entity);
			
			var view:CircleView = new CircleView(radius, 0xFFFFFF, 0.1);
			with (entity) {
				add(new Position(0, 0));
				add(new Size(new Point(radius * 2, radius * 2)));
				add(new Circle(radius));
				add(new Display(view));
				add(new Collision());
				add(new SpatialHashed());
			}
			return entity;
		}
		
		public function createMembranPart():Entity {
			var entity:Entity = new Entity();
			
			var radius:Number = 10;
			var radarRadius:Number = 20;
			var density:Number = 0.1;
			
			var pos:Point = new Point(Utils.randomRange(0, config.width), Utils.randomRange(0, config.height));
			
			var radar:Entity = createRadar(radarRadius);
			radar.add(new Anchor(entity));
			
			var membranPartView:MembranPartView = new MembranPartView(radius);
			with (entity) {
				add(new Position(pos.x, pos.y));
				add(new Size(new Point(radius * 2, radius * 2)));
				add(new Circle(radius));
				add(new SpatialHashed());
				add(new Mass(radius * radius * Math.PI * density));
				add(new SolidCollision(1));
				add(new Collision());
				add(new Display(membranPartView));
				add(new Motion(Utils.randomRange(-50, 50), Utils.randomRange(-50, 50), 0.95));
				add(new Radar(radar));
				add(new Membran());
				add(new Attractable(1));
			}
			
			engine.addEntity(entity);
			return entity;
		}
		
		public function createConnection(entity1:Entity, entity2:Entity, distance:Number = 10):Entity {
			if (!(entity1.has(Position) && entity2.has(Position))) {
				return null;
			}
			
			var entity:Entity = new Entity();
			
			var pos1:Position = Position(entity1.get(Position));
			var pos2:Position = Position(entity2.get(Position));
			
			var view:LineView = new LineView(pos1.position, pos2.position, 0.5 * 2 * 0.6 * 10, 0x35AAFF);
			with (entity) {
				add(new Position(0, 0));
				add(new Redrawing(view));
				add(new Display(view));
				add(new DistanceConstraint(entity1, entity2, distance, 1, 0.45));
				add(new Breakable(distance * 3));
			}
			
			engine.addEntity(entity);
			return entity;
		}
		
		public function createAttractor(radius:Number, strength:Number):Entity {
			var entity:Entity = createRadar(radius);
			entity.remove(Display);
			entity.remove(Collision);
			var state:EntityState;
			var fsm:EntityStateMachine = new EntityStateMachine(entity);
			
			var view:CircleView = new CircleView(radius, 0xFFFFFF, 0.1);
			state = fsm.createState("active");
			with (state) {
				add(Attracting).withInstance(new Attracting(strength));
				add(Collision).withInstance(new Collision());
				add(Display).withInstance(new Display(view));
				
			}
			state = fsm.createState("inactive");
			with (state) {
				// empty
			}
			
			with (entity) {
				add(new Attractor(fsm));
			}
			fsm.changeState("inactive");
			return entity;
		}
		
		public function createText(text:String = ""):Entity {
			var entity:Entity = new Entity();
			
			var textComponent:Text = new Text(text);
			var view:TextView = new TextView(textComponent);
			with (entity) {
				add(new Position(0, 0));
				add(textComponent);
				add(new Display(view));
				add(new Redrawing(view));
				add(new Size(new Point()));
				add(new TextViewAutosize(view));
				
			}
			
			engine.addEntity(entity);
			return entity;
		}
		
		public function createFloatingText(text:String = "", lifetime:Number = 2, outfading_length:Number = 60):Entity {
			var entity:Entity = createText(text);
			with (entity) {
				entity.add(new Timer());
				entity.add(new Lifetime(lifetime));
				entity.add(new AlphaTween(0, lifetime, Easing.easeInOutSine));
				entity.add(new PositionTween(new Point(0, -outfading_length), lifetime, Easing.easeInOutSine));
			}
			return entity;
		}
		
		public function createCircle(radius:Number, color:uint = 0xFFFFFF, alpha:Number = 1):Entity {
			var entity:Entity = new Entity();
			var view:CircleView = new CircleView(radius, color, alpha);
			with (entity) {
				add(new Position(0, 0));
				add(new Circle(radius));
				add(new Size(new Point(radius * 2, radius * 2)));
				add(new Display(view));
			}
			engine.addEntity(entity);
			return entity;
		}
	
	}
}
