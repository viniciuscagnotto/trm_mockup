package  {
	
	import flash.display.MovieClip;
	
	public class TRM extends MovieClip{

		public static var self:TRM;			
		
		public static const STATE_MAIN:int = 0;
		public static const STATE_SELECT_ITEMS:int = 1;
		public static const STATE_SELECT_PACKAGE:int = 2;
		public static const STATE_SUMMARY_ADDRESS:int = 3;
		public static const STATE_PAYMENT:int = 4;
		public static const STATE_ORDERS_LIST:int = 5;
		
		private var statee:int = 0;
		
		public var sceneMain:SceneMain;
		public var sceneSelectItems:SceneSelectItems;
		public var sceneSelectPackage:SceneSelectPackage;
		public var sceneSummaryAddress:SceneSummaryAddress;
		public var scenePayment:ScenePayment;
		public var sceneOrderList:SceneOrdersList;
		
		public function TRM() 
		{
			self = this;

			this.sceneMain = this.addChild(new SceneMain()) as SceneMain;
			this.sceneSelectItems = this.addChild(new SceneSelectItems()) as SceneSelectItems;
			this.sceneSelectPackage = this.addChild(new SceneSelectPackage()) as SceneSelectPackage;
			this.sceneSummaryAddress = this.addChild(new SceneSummaryAddress()) as SceneSummaryAddress;
			this.scenePayment = this.addChild(new ScenePayment()) as ScenePayment;
			this.sceneOrderList = this.addChild(new SceneOrdersList()) as SceneOrdersList;
			
			state = STATE_MAIN;
		}
		
		public function get state():int
		{
			return this.statee;
		}		
		
		public function set state(value:int):void
		{
			this.statee = value;
			
			reset();
			switch(this.statee)
			{
				case STATE_MAIN:
					this.sceneMain.visible = true;
					break;
				case STATE_SELECT_ITEMS:
					break;
				case STATE_SELECT_PACKAGE:
					break;
				case STATE_SUMMARY_ADDRESS:
					break;
				case STATE_PAYMENT:
					break;
				case STATE_ORDERS_LIST:
					break;
				default:
					break;
			}
		}
		
		public function reset(full:Boolean = false):void{
			this.sceneMain.visible = false;
			
			if(full)
			{
				
			}
		}

	}
	
}
