package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ScenePayment extends MovieClip{

		private var endButton:MovieClip;
		private var endButtonInitialY:int;
		
		public function ScenePayment() {
			
			endButton = this.getChildByName("endBtn") as MovieClip;
			endButton.addEventListener(MouseEvent.MOUSE_DOWN, this.endBtnPress);
			endButton.addEventListener(MouseEvent.CLICK, this.endBtnRelease);
			endButtonInitialY = endButton.y;
			
		}
		
		private function endBtnPress(e:MouseEvent):void{
			endButton.y = endButtonInitialY + 3;
		}
		
		private function endBtnRelease(e:MouseEvent):void{
			endButton.y = endButtonInitialY;
			TRM.self.state = TRM.STATE_ORDERS_LIST;
		}

	}
	
}
