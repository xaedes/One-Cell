package ld28.systems {
	import ash.core.Entity;
	import ash.tools.ListIteratingSystem;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import ld28.components.Anchor;
	import ld28.components.Display;
	import ld28.components.EnergyStorageWarning;
	import ld28.components.Position;
	import ld28.EntityCreator;
	import ld28.graphics.TextView;
	import ld28.nodes.AlphaTweenNode;
	import ld28.nodes.EnergyStorageWarningNode;
	
	public class EnergyStorageWarningSystem extends ListIteratingSystem {
		private var creator:EntityCreator;
		
		public function EnergyStorageWarningSystem(creator:EntityCreator) {
			super(EnergyStorageWarningNode, updateNode);
			this.creator = creator;
		}
		
		private function updateNode(node:EnergyStorageWarningNode, time:Number):void {
			var text:Entity;
			var textPosition:Position;
			
			if (node.energyStorage.energy / node.energyStorage.maxEnergy < node.energyStorageWarning.warningUnderPercent) {
				if (node.energyStorageWarning.countdown <= 0) {
					text = creator.createFloatingText("Energy low!", node.energyStorageWarning.fading_time);
					text.add(new Anchor(node.entity));
					var display:Display = Display(text.get(Display));
					var textView:TextView = TextView(display.displayObject);
					
					var format:TextFormat = new TextFormat();
					format.color = 0xFFB600;
					textView.textField.defaultTextFormat = format;
					
					node.energyStorageWarning.countdown = node.energyStorageWarning.interval;
				} else {
					node.energyStorageWarning.countdown -= time;
				}
			}
		
		}
	}
}
