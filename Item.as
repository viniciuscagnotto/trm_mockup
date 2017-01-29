package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	public class Item extends MovieClip{

		public static const TYPE_ITEM:int = 0;
		public static const TYPE_PACKAGE:int = 1;
		
		public var index:int;
		public var type:int;
		
		public var isSelectable:Boolean;
		public var itemName:String;
		public var description:String;
		public var value:Number;
		public var photo:MovieClip;
		
		private var normalBg:MovieClip;
		private var categoryBg:MovieClip;
		private var selectedBg:MovieClip;
		private var itemText:TextField;
		
		public function Item(index:int = -1, type:int = -1, itemName:String = "", isSelectable:Boolean = false, description:String = "", value:Number = 0, photo:MovieClip = null) {
			this.index = index;
			this.type = type;
			this.itemName = itemName;
			this.isSelectable = isSelectable;
			this.description = description;
			this.value = value;
			this.photo = photo;
			
			normalBg = this.getChildByName("normal") as MovieClip;
			normalBg.visible = isSelectable;
			
			categoryBg = this.getChildByName("category") as MovieClip;
			categoryBg.visible = !isSelectable;
			
			selectedBg = this.getChildByName("selected") as MovieClip;
			selectedBg.visible = false;
			
			itemText = this.getChildByName("title") as TextField;
			itemText.text = itemName;
			
			if(isSelectable){
				switch(type){
					case TYPE_ITEM:
						this.addEventListener(MouseEvent.CLICK, selectItem);
						break;
					case TYPE_PACKAGE:
						this.addEventListener(MouseEvent.CLICK, selectPackage);
						break;
				}
				
			}
		}
		
		public function update(index:int, itemName:String):void{
			this.index = index;
			this.itemName = itemName;
			itemText.text = itemName;
			normalBg.visible = true;
		}
		
		public function selectItem(e:MouseEvent):void
		{
			TRM.self.sceneSelectItems.unselectAll();
			if(normalBg.visible)
			{
				normalBg.visible = false;
				TRM.self.sceneSelectItems.selectItem(this);
			}
			else
			{
				normalBg.visible = true;
				
			}
			
			selectedBg.visible = !normalBg.visible;
		}
		
		public function selectPackage(e:MouseEvent):void
		{
			TRM.self.sceneSelectPackage.unselectAll();
			if(normalBg.visible)
			{
				normalBg.visible = false;
				TRM.self.sceneSelectPackage.selectItem(this);
			}
			else
			{
				normalBg.visible = true;
				
			}
			
			selectedBg.visible = !normalBg.visible;
		}


		public function turn(on:Boolean):void
		{
			if(!isSelectable) return;
			normalBg.visible = true;
			selectedBg.visible = false;
		}
		
		public function reset():void
		{
			this.index = -1;
			this.itemName = "";
			itemText.text = "";
		}
		
	}
	
}
