package ld28.components {
	import flash.media.SoundTransform;
	
	public class Audio {
		public var toPlay:Vector.<Object> = new Vector.<Object>();
		
		public function play(sound:Class, vol:Number = 1, panning:Number = 0):void {
			toPlay.push({sound: sound, transform: new SoundTransform(vol, panning)});
		}
	}
}
