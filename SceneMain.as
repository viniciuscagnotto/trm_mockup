package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class SceneMain extends MovieClip {

		private var startButton:MovieClip;
		private var startButtonInitialY:int;
		
		public function SceneMain() {
			startButton = this.getChildByName("startBtn") as MovieClip;
			startButton.addEventListener(MouseEvent.MOUSE_DOWN, this.mousePress);
			startButton.addEventListener(MouseEvent.CLICK, this.mouseRelease);
			startButtonInitialY = startButton.y;
		}
		
		private function mousePress(e:MouseEvent):void{
			startButton.y = startButtonInitialY + 3;
		}
		
		private function mouseRelease(e:MouseEvent):void{
			startButton.y = startButtonInitialY;
			TRM.self.state = TRM.STATE_SELECT_ITEMS;
		}

	}
	
}
