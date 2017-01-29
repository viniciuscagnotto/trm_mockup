package  {
	
	public class UserInfo {

		public static var SELECTED_ITEMS:Vector.<Boolean> = new <Boolean>[];
		public static var SELECTED_PACKAGE:int = -1
		
		public static function init(numItems:int):void
		{
			for(var i:int = 0; i < numItems; i++)
				SELECTED_ITEMS.push(false);
		}
		
		public static function turnItem(index:int, on:Boolean):void
		{
			SELECTED_ITEMS[index] = on;
		}
		
		public static function turnAllItems(on:Boolean):void
		{
			for(var i:int = 0; i < SELECTED_ITEMS.length; i++)
				SELECTED_ITEMS[i] = on;
		}

	}
	
}
