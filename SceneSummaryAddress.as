package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	public class SceneSummaryAddress extends MovieClip{

		private var qtd:TextField;
		private var items:TextField;
		private var pack:TextField;
		private var total:TextField;
		
		private var nextButton:MovieClip;
		private var nextButtonInitialY:int;
		
		public function SceneSummaryAddress() 
		{
			qtd = this.getChildByName("qtdKits") as TextField;
			items = this.getChildByName("itemsList") as TextField;
			pack = this.getChildByName("packName") as TextField;
			total = this.getChildByName("totalValue") as TextField;
			
			nextButton = this.getChildByName("nextBtn") as MovieClip;
			nextButton.addEventListener(MouseEvent.MOUSE_DOWN, this.nextBtnPress);
			nextButton.addEventListener(MouseEvent.CLICK, this.nextBtnRelease);
			nextButtonInitialY = nextButton.y;
		}
		
		public function update():void
		{
			qtd.text = TRM.self.sceneSelectPackage.qtdKits.text + " LEMBRANCINHAS COM:";
			
			var itemText:String = "";
			for(var i:int = 0; i < UserInfo.SELECTED_ITEMS.length; i++)
			{
				if(UserInfo.SELECTED_ITEMS[i])
					itemText += "- " + TRM.self.sceneSelectItems.items[i].itemName + "\n";
			}
			
			items.text = itemText;
			pack.text = "Embalagem " + TRM.self.sceneSelectPackage.items[UserInfo.SELECTED_PACKAGE].itemName;
			total.text = TRM.self.sceneSelectPackage.totalValueText.text;
		}
		
		private function nextBtnPress(e:MouseEvent):void{
			nextButton.y = nextButtonInitialY + 3;
		}
		
		private function nextBtnRelease(e:MouseEvent):void{
			nextButton.y = nextButtonInitialY;
			TRM.self.state = TRM.STATE_PAYMENT;
		}
		

	}
	
}
