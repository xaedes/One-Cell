package ld28.systems {
	import ash.tools.ListIteratingSystem;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import ld28.nodes.AudioNode;
	
	public class AudioSystem extends ListIteratingSystem {
		public function AudioSystem() {
			super(AudioNode, updateNode);
		}
		
		private function updateNode(node:AudioNode, time:Number):void {
			for each (var obj:Object in node.audio.toPlay) {
				var type:Class = obj.sound;
				var transform:SoundTransform = obj.transform;
				var sound:Sound = new type();
				sound.play(0, 1, transform);
			}
			node.audio.toPlay.length = 0;
		}
	}
}
