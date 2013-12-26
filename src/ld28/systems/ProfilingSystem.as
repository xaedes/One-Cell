package ld28.systems {
	import ash.core.Engine;
	import ash.core.System;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class ProfilingSystem extends System {
		private var engine:Engine = null;
		private var sortedProfiledSystems:Array = null;
		
		public function ProfilingSystem() {
			super();
		}
		
		override public function addToEngine(engine:Engine):void {
			this.engine = engine;
			engine.profilingEnabled = true;
			sortedProfiledSystems = new Array();
			for each (var system:System in engine.systems) {
				if (system.profilingEnabled) {
					sortedProfiledSystems.push(system);
				}
			}
			sortedProfiledSystems.sortOn("profilingTimePerUpdate");
		}
		
		override public function removeFromEngine(engine:Engine):void {
			this.engine = null;
			this.sortedProfiledSystems = null;
		}
		
		override public function update(time:Number):void {
			var system:System;
			if (engine && engine.profilingEnabled && sortedProfiledSystems && sortedProfiledSystems.length > 0) {
				sortedProfiledSystems.sortOn("profilingTimePerUpdate");
				var totalTimePerUpdate:Number = 0;
				trace("Profiling");
				trace("----------");
				for each (system in sortedProfiledSystems) {
					totalTimePerUpdate += system.profilingTimePerUpdate;
				}
				for each (system in sortedProfiledSystems) {
					trace(system, Math.round(1000 * system.profilingTimePerUpdate / totalTimePerUpdate) / 10 + "%");
				}
			}
		}
	}

}