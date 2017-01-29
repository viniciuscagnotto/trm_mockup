package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	public class Item extends MovieClip{

		public var index:int;
		
		public var isSelectable:Boolean;
		public var itemName:String;
		public var description:String;
		public var value:Number;
		public var photo:MovieClip;
		
		private var normalBg:MovieClip;
		private var categoryBg:MovieClip;
		private var selectedBg:MovieClip;
		private var itemText:TextField;
		
		public function Item(index:int = -1, itemName:String = "", isSelectable:Boolean = false, description:String = "", value:Number = 0, photo:MovieClip = null) {
			this.index = index;
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
			
			if(isSelectable)
				this.addEventListener(MouseEvent.CLICK, select);
		}
		
		public function update(index:int, itemName:String):void{
			this.index = index;
			this.itemName = itemName;
			itemText.text = itemName;
			normalBg.visible = true;
		}
		
		public function select(e:MouseEvent):void{
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
