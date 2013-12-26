package {
	import com.flashdynamix.utils.SWFProfiler;
	import flash.display.Sprite;
	import flash.events.Event;
	import ld28.Game;
	
	[SWF(width='800',height='600',frameRate='60',backgroundColor='#000000')]
	
	public class Main extends Sprite {
		private var game:Game;
		
		public function Main():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			SWFProfiler.init(this.stage, this);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			game = new Game(this, stage.stageWidth, stage.stageHeight);
			game.start();
		}
	
	}

}