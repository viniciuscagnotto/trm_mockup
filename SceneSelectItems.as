package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	public class SceneSelectItems extends MovieClip{

		public var items:Vector.<Item>;
		public var selectedItems:Vector.<Item>;
		
		private var photoContainer:MovieClip;
		private var itemName:TextField;
		private var itemDescription:TextField;
		private var totalText:TextField;
		
		private var addButton:MovieClip;
		private var addButtonInitialY:int;
		
		private var nextButton:MovieClip;
		private var nextButtonInitialY:int;
		
		private var availableContainer:MovieClip;
		private var selectedContainer:MovieClip;
		
		private var currentItem:Item;
		
		public function SceneSelectItems() {
			
			availableContainer = this.getChildByName("availableComp") as MovieClip;
			selectedContainer = this.getChildByName("selectedComp") as MovieClip;
			currentItem = null;
			
			items = new <Item>[
				(availableContainer.addChild(new Item(0, "BRINQUEDOS", false)) as Item),
				(availableContainer.addChild(new Item(1, "Bolinha Frozen", true, "1 Bolinha pula pula temática do filme Frozen", 0.25, new PhotoFrozen())) as Item),
				(availableContainer.addChild(new Item(2, "Bolinha Turma da Mônica", true, "1 Bolinha pula pula temática da Turma da Mônica", 0.25, new PhotoMonica())) as Item),
				(availableContainer.addChild(new Item(3, "Miniatura Heróis", true, "1 Miniatura de super herói", 0.40, new PhotoMiniaturasHerois())) as Item),
				(availableContainer.addChild(new Item(4, "Miniatura Sortida", true, "1 Miniatura infantil sortida", 0.20, new PhotoMiniaturas())) as Item),
				(availableContainer.addChild(new Item(5, "GULOSEIMAS", false)) as Item),
				(availableContainer.addChild(new Item(6, "Pirulitos", true, "2 Pirulitos", 0.30, new PhotoChicletes())) as Item),
				(availableContainer.addChild(new Item(7, "Balas de Goma", true, "Pacotinho com 5 balas de goma", 0.40, new PhotoChicletes())) as Item),
				(availableContainer.addChild(new Item(8, "Chicletes", true, "Pacotinho com 4 chicletes", 0.30, new PhotoChicletes())) as Item),
				(availableContainer.addChild(new Item(9, "OUTROS", false)) as Item),
				(availableContainer.addChild(new Item(10, "Chaveiro Heróis", true, "1 Chaveiro de super herói", 2.5, new PhotoChaveirosHerois())) as Item),
				(availableContainer.addChild(new Item(11, "Adesivos", true, "1 cápsula com mini adesivos", 0.10, new PhotoAdesivos())) as Item)
			];
			
			selectedItems = new <Item>[];
			for(var i:int = 0; i < items.length; i++)
			{
				items[i].y = 33*i;
				selectedItems.push(selectedContainer.addChild(new Item()) as Item);
				selectedItems[i].y = 33*i;
				selectedItems[i].visible = false;
				selectedItems[i].addEventListener(MouseEvent.CLICK, removeItem);
			}
			
			photoContainer = this.getChildByName("container") as MovieClip;
			itemName = this.getChildByName("itemTitle") as TextField;
			itemDescription = this.getChildByName("itemDesc") as TextField;
			totalText = this.getChildByName("totalValue") as TextField;
			
			addButton = this.getChildByName("addBtn") as MovieClip;
			addButton.visible = false;
			addButton.addEventListener(MouseEvent.MOUSE_DOWN, this.addBtnPress);
			addButton.addEventListener(MouseEvent.CLICK, this.addBtnRelease);
			addButtonInitialY = addButton.y;
			
			nextButton = this.getChildByName("nextBtn") as MovieClip;
			nextButton.visible = false;
			nextButton.addEventListener(MouseEvent.MOUSE_DOWN, this.nextBtnPress);
			nextButton.addEventListener(MouseEvent.CLICK, this.nextBtnRelease);
			nextButtonInitialY = nextButton.y;
		}
		
		public function get numItems():int
		{
			return items.length;
		}
		
		public function selectItem(item:Item):void{
			currentItem = item;
			removePhoto();
			photoContainer.addChild(item.photo);
			itemName.text = item.itemName;
			itemDescription.text = item.description + " (R$" + item.value + ")";
			addButton.visible = true;
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
		
		private function addBtnPress(e:MouseEvent):void{
			addButton.y = addButtonInitialY + 3;
		}
		
		private function addBtnRelease(e:MouseEvent):void{
			addButton.y = addButtonInitialY;
			addItem();
		}
		
		private function addItem():void{
			for(var i:int = 0; i < selectedItems.length; i++)
				if(selectedItems[i].index == currentItem.index) return;
			
			var newItem:Item = getNextAvailableItemToAdd();
			if(!newItem) return;
			
			nextButton.visible = true;
			UserInfo.turnItem(currentItem.index, true);
			
			newItem.update(currentItem.index, currentItem.itemName);
			newItem.visible = true;
			
			updateValue();
		}
		
		private function updateValue():void{
			var totalValue:Number = 0;
			for(var i:int = 0; i < UserInfo.SELECTED_ITEMS.length; i++)
				totalValue += UserInfo.SELECTED_ITEMS[i] ? items[i].value : 0;
			
			totalText.text = "KIT R$" + (int(totalValue*100)/100);
		}
		
		private function getNextAvailableItemToAdd():Item{
			for(var i:int = 0; i < selectedItems.length; i++)
				if(!selectedItems[i].visible) return selectedItems[i];
			return null;
		}
		
		private function nextBtnPress(e:MouseEvent):void{
			nextButton.y = nextButtonInitialY + 3;
		}
		
		private function nextBtnRelease(e:MouseEvent):void{
			nextButton.y = nextButtonInitialY;
			TRM.self.state = TRM.STATE_SELECT_PACKAGE;
		}
		
		private function removeItem(e:MouseEvent):void{
			var item:Item = e.currentTarget as Item;
			UserInfo.turnItem(item.index, false);
			updateValue();			
			
			var objIndex:int = selectedItems.indexOf(item);
			var i:int;
			for(i = objIndex+1; i < selectedItems.length;i++)
			{
				var nextObject:Item = selectedItems[i];
				if(nextObject.index != -1)
				{
					selectedItems[i-1].update(nextObject.index, nextObject.itemName);
				}
				else
				{
					selectedItems[i-1].reset();
					selectedItems[i-1].visible = false;
					break;
				}
			}
			
			for(i = 0; i < UserInfo.SELECTED_ITEMS.length; i++)
				if(UserInfo.SELECTED_ITEMS[i]) return;
			nextButton.visible = false;
		}

	}
	
}
