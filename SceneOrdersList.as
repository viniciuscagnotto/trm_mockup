package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class SceneOrdersList extends MovieClip{

		private var newOrderButton:MovieClip;
		private var newOrderButtonInitialY:int;
		
		public function SceneOrdersList() {
			newOrderButton = this.getChildByName("newOrderBtn") as MovieClip;
			newOrderButton.addEventListener(MouseEvent.MOUSE_DOWN, this.newOrderBtnPress);
			newOrderButton.addEventListener(MouseEvent.CLICK, this.newOrderBtnRelease);
			newOrderButtonInitialY = newOrderButton.y;
		}
		
		private function newOrderBtnPress(e:MouseEvent):void{
			newOrderButton.y = newOrderButtonInitialY + 3;
		}
		
		private function newOrderBtnRelease(e:MouseEvent):void{
			newOrderButton.y = newOrderButtonInitialY;
			TRM.self.state = TRM.STATE_MAIN_START_OVER;
		}

	}
	
}
