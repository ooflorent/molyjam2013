package sacrifice.managers
{
	public class Level
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Level(background:String, blocks:String, lethal:String, foreground:String)
		{
			this.background = background;
			this.blocks = blocks;
			this.lethal = lethal;
			this.foreground = foreground;
		}
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public var background:String;
		public var blocks:String;
		public var lethal:String;
		public var foreground:String;
	}
}