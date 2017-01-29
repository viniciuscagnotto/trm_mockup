package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	public class SceneSelectItems extends MovieClip{

		private var itemsComp:MovieClip;
		private var items:Vector.<Item>;
		
		private var photoContainer:MovieClip;
		private var itemName:TextField;
		private var itemDescription:TextField;
		private var addButton:MovieClip;
		
		public function SceneSelectItems() {
			
			itemsComp = new MovieClip();
			items = new <Item>[
				(itemsComp.addChild(new Item("BRINQUEDOS", false)) as Item),
				(itemsComp.addChild(new Item("Bolinha Frozen", true, "1 Bolinha pula pula temática do filme Frozen", 0.25, new PhotoFrozen())) as Item),
				(itemsComp.addChild(new Item("Bolinha Turma da Mônica", true, "1 Bolinha pula pula temática da Turma da Mônica", 0.25, new PhotoMonica())) as Item),
				(itemsComp.addChild(new Item("Miniatura Heróis", true, "1 Miniatura de super herói (Vingadores/Liga da Justiça", 0.40, new PhotoMiniaturasHerois())) as Item),
				(itemsComp.addChild(new Item("Miniatura Sortida", true, "1 Miniatura de infantil sortida", 0.20, new PhotoMiniaturas())) as Item),
				(itemsComp.addChild(new Item("GULOSEIMAS", false)) as Item),
				(itemsComp.addChild(new Item("Pirulitos", true, "2 Pirulitos", 0.30, new PhotoChicletes())) as Item),
				(itemsComp.addChild(new Item("Balas de Goma", true, "Pacotinho com 5 balas de goma", 0.40, new PhotoChicletes())) as Item),
				(itemsComp.addChild(new Item("Chicletes", true, "Pacotinho com 4 chicletes", 0.30, new PhotoChicletes())) as Item),
				(itemsComp.addChild(new Item("OUTROS", false)) as Item),
				(itemsComp.addChild(new Item("Chaveiro Heróis", true, "1 Chaveiro de super herói", 2.5, new PhotoChaveirosHerois())) as Item),
				(itemsComp.addChild(new Item("Adesivos", true, "1 cápsula com mini adesivos", 0.10, new PhotoAdesivos())) as Item)
			];
			
			photoContainer = this.getChildByName("container") as MovieClip;
			itemName = this.getChildByName("itemTitle") as TextField;
			itemDescription = this.getChildByName("itemDesc") as TextField;
			
			addButton = this.getChildByName("addBtn") as MovieClip;
			addButton.visible = false;
			addButton.addEventListener(MouseEvent.MOUSE_DOWN, this.addBtnPress);
			addButton.addEventListener(MouseEvent.CLICK, this.addBtnRelease);
		}
		
		public function get numItems():int
		{
			var count:int = 0;
			for(var i:int = 0; i < items.length; i++)
				if(items[i].isSelectable) count++;
			return count;
		}
		
		public function selectItem(item:Item):void{
			removePhoto();
			photoContainer.addChild(item.photo);
			itemName.text = item.itemName;
			itemDescription.text = item.description;
		}
		
		public function removePhoto():void{
			for(var i:int = 0; i < items.length; i++){
				if(items[i].photo.parent == photoContainer)
					photoContainer.removeChild(items[i].photo);
			}
		}
		
		private function addBtnPress(e:MouseEvent):void{
			
		}
		
		private function addBtnRelease(e:MouseEvent):void{
			
		}

	}
	
}
