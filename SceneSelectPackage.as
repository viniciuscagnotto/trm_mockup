package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class SceneSelectPackage extends MovieClip{

		public var items:Vector.<Item>;
		
		private var photoContainer:MovieClip;
		private var itemName:TextField;
		private var itemDescription:TextField;
		
		private var totalKit:TextField;
		public var qtdKits:TextField;
		public var totalValueText:TextField;
		private var totalKitValue:Number;
		
		private var nextButton:MovieClip;
		private var nextButtonInitialY:int;
		
		private var availableContainer:MovieClip;
		
		private var currentItem:Item;
		
		public function SceneSelectPackage() {
			
			availableContainer = this.getChildByName("availableComp") as MovieClip;
			currentItem = null;
			
			items = new <Item>[
				(availableContainer.addChild(new Item(0, Item.TYPE_PACKAGE, "PADRÃO", false)) as Item),
				(availableContainer.addChild(new Item(1, Item.TYPE_PACKAGE, "Vermelha", true, "Embalagens Vermelhas", 0, new PhotoSaquinhos())) as Item),
				(availableContainer.addChild(new Item(2, Item.TYPE_PACKAGE, "Azul", true, "Embalagens Azuis", 0, new PhotoSaquinhos())) as Item),
				(availableContainer.addChild(new Item(3, Item.TYPE_PACKAGE, "Verde", true, "Embalagens Verdes", 0, new PhotoSaquinhos())) as Item),
				(availableContainer.addChild(new Item(4, Item.TYPE_PACKAGE, "Coloridas", true, "Embalagens Coloridas", 0, new PhotoSaquinhos())) as Item),
				(availableContainer.addChild(new Item(5, Item.TYPE_PACKAGE, "ESPECIAIS", false)) as Item),
				(availableContainer.addChild(new Item(6, Item.TYPE_PACKAGE, "Disney", true, "Embalagens da Disney", 0.07, new PhotoSaquinhos())) as Item),
				(availableContainer.addChild(new Item(7, Item.TYPE_PACKAGE, "Frozen", true, "Embalagens da Frozen", 0.07, new PhotoSaquinhos())) as Item),
				(availableContainer.addChild(new Item(8, Item.TYPE_PACKAGE, "Galinha Pintadinha", true, "Embalagens da Galinha Pintadinha", 0.07, new PhotoSaquinhos())) as Item)
			];
			
			for(var i:int = 0; i < items.length; i++)
				items[i].y = 33*i;
			
			photoContainer = this.getChildByName("container") as MovieClip;
			itemName = this.getChildByName("itemTitle") as TextField;
			itemDescription = this.getChildByName("itemDesc") as TextField;
			
			totalKit = this.getChildByName("kitTotal") as TextField;
			qtdKits = this.getChildByName("qtd") as TextField;
			qtdKits.restrict = "0-9";
			qtdKits.addEventListener(Event.CHANGE, onChangeQtd);
			totalValueText = this.getChildByName("orderTotal") as TextField;
			
			nextButton = this.getChildByName("nextBtn") as MovieClip;
			nextButton.addEventListener(MouseEvent.MOUSE_DOWN, this.nextBtnPress);
			nextButton.addEventListener(MouseEvent.CLICK, this.nextBtnRelease);
			nextButtonInitialY = nextButton.y;
		}
		
		public function setupInitialPackage():void
		{
			qtdKits.text = "30";
			UserInfo.SELECTED_PACKAGE = items[1].index;
			items[1].selectPackage(null);
		}
		
		public function update():void
		{
			updateValues();
		}
		
		public function selectItem(item:Item):void{
			currentItem = item;
			removePhoto();
			photoContainer.addChild(item.photo);
			itemName.text = item.itemName;
			var textDesc:String = item.description;
			if(item.value == 0) textDesc += " (Sem custo adicional)";
			else textDesc += " (R$" + item.value + ")";
			itemDescription.text = textDesc;
			
			UserInfo.SELECTED_PACKAGE = item.index;
			updateValues();
		}
		
		public function unselectAll():void
		{
			currentItem = null;
			for(var i:int = 0; i < items.length; i++)
				items[i].turn(false);
		}
		
		public function removePhoto():void{
			for(var i:int = 0; i < items.length; i++){
				if(items[i].photo && items[i].photo.parent == photoContainer)
					photoContainer.removeChild(items[i].photo);
			}
		}
		
		private function updateValues():void
		{
			TRM.self.sceneSelectItems.updateValue();
			updateKitValue();
			updateTotalValue();
		}
		
		private function updateKitValue():void
		{
			totalKitValue = 0;
			for(var i:int = 0; i < UserInfo.SELECTED_ITEMS.length; i++)
				totalKitValue += UserInfo.SELECTED_ITEMS[i] ? TRM.self.sceneSelectItems.items[i].value : 0;
			
			totalKitValue += items[UserInfo.SELECTED_PACKAGE].value;
			totalKit.text = "KIT R$" + (int(totalKitValue*100)/100);
		}
		
		private function updateTotalValue():void
		{
			var kitsQtd:int = int(qtdKits.text);
			var totalOrderValue:Number = int((kitsQtd*totalKitValue)*100)/100;
			totalValueText.text = "R$ " + totalOrderValue;
		}
		
		private function nextBtnPress(e:MouseEvent):void{
			nextButton.y = nextButtonInitialY + 3;
		}
		
		private function nextBtnRelease(e:MouseEvent):void{
			nextButton.y = nextButtonInitialY;
			TRM.self.state = TRM.STATE_SUMMARY_ADDRESS;
		}
		
		private function onChangeQtd(e:Event):void
		{
			if(qtdKits.text == "") return;
			updateValues();
		}
		
	}
	
}
