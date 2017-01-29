package  {
	import flash.display.MovieClip;
	
	public class Item extends MovieClip{

		public var isSelectable:Boolean;
		public var itemName:String;
		public var description:String;
		public var value:Number;
		public var photo:MovieClip;
		
		public function Item(itemName:String, isSelectable:Boolean, description:String = "", value:Number = 0, photo:MovieClip = null) {
			this.itemName = itemName;
			this.isSelectable = isSelectable;
			this.description = description;
			this.value = value;
			this.photo = photo;
		}

	}
	
}
