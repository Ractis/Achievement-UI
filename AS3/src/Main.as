package 
{
	import achievements.AchievementPopupManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends MovieClip implements IDotaAPI 
	{
		// element details filled out by game engine
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		
		private var _achievementPopupManager:AchievementPopupManager;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			try {
				
				// Create modules
				addChild( _achievementPopupManager = new AchievementPopupManager() );
				
			} catch ( e:Error ) {
				Utils.LogError( e );
			}
		}
		
		public function onLoaded():void
		{
			try
			{
				Utils.Log( "========================================" );
				Utils.Log( "  Initializing ..." );
				Utils.Log( "========================================" );
				
				visible = true;
				
				// Initialize modules
				_achievementPopupManager.onLoaded( this );
			}
			catch ( e:Error )
			{
				Utils.LogError( e );
			}
		}
		
		// called by the game engine after onLoaded and whenever the screen size is changed
		public function onScreenSizeChanged():void
		{
		}
		
		public function SubscribeToGameEvent( eventName:String, callback:Function ):void
		{
			gameAPI.SubscribeToGameEvent( eventName, callback );
		}
		
		public function SendServerCommand( command:String ):void
		{
			// command.length <= 512
			gameAPI.SendServerCommand( command );
		}
		
		public function get gameTime():Number
		{
			return globals.Game.Time();
		}
		
		public function get localPlayerID():int
		{
			return globals.Players.GetLocalPlayer();
		}
		
	}
	
}