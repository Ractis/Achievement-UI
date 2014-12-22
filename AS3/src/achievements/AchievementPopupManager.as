package achievements
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class AchievementPopupManager extends Sprite 
	{
		[Embed(source = "assets/achievement.jpg")]
		static private const DummyAchievementImg:Class;
		
		private var api:IDotaAPI;
		private var numSlots:int = 3;
		private var activePopups:Vector.<AchievementPopup>;
		private var queuedPopups:Vector.<AchievementPopup>;
		
		public function AchievementPopupManager() 
		{
			super();
			
			activePopups = new Vector.<AchievementPopup>();
			queuedPopups = new Vector.<AchievementPopup>();
			
			// Test
			var devButton:Sprite = new Sprite();
		//	addChild( devButton );
			var g:Graphics = devButton.graphics;
			g.beginFill( 0xFFFFFF );
			g.drawRect( 0, 0, 50, 50 );
			g.endFill();
			devButton.addEventListener( MouseEvent.CLICK, function ( evt:MouseEvent ):void
			{
				testPopup();
			} );
		}
		
		public function onLoaded( api:IDotaAPI ):void
		{
			this.api = api;
			
			// Register event listeners
			api.SubscribeToGameEvent( "test_achievement_popup",		_onTestAchievementPopup );
			api.SubscribeToGameEvent( "achievement_unlocked",		_onAchievementUnlocked );
			
			Utils.Log( "Initialized AchievementPopupManager" );
		}
		
		public function testPopup():void
		{
			_queueAchievementPopup( new AchievementPopup( "Achievement Unlocked!", "F in Chemistry", new DummyAchievementImg() ) );
		}
		
		private function _onTestAchievementPopup( eventData:Object ):void 
		{
			testPopup();
		}
		
		private function _onAchievementUnlocked( eventData:Object ):void 
		{
			try
			{
				var achievementID:int	= eventData.achievementID;
				var playerID:int		= eventData.playerID;
				
				Utils.Log( "Achievement unlocked." );
				Utils.Log( "  - Achievement ID : " + achievementID );
				Utils.Log( "  - Player ID : " + playerID );
				
				if ( api.localPlayerID != playerID )
				{
					// It's not me.
					return;
				}
				
				// Grab the localized text
				var achievementName:String = "#ACHIEVEMENT_" + achievementID + "_NAME";
				var achievementDesc:String = "#ACHIEVEMENT_" + achievementID + "_DESCRIPTION";
				
				// Load the icon
				var achievementIcon:DisplayObject = Utils.LoadTexture( "images/achievements/" + achievementID + "_on.png" );
				
				// Queue the popup
				_queueAchievementPopup( new AchievementPopup( "#ACHIEVEMENT_UNLOCKED", achievementName, achievementIcon ) );
			}
			catch ( e:Error )
			{
				Utils.LogError( e );
			}
		}
		
		private function _queueAchievementPopup( newPopup:AchievementPopup ):void
		{
			addChildAt( newPopup, 0 );
			if ( activePopups.length > 0 )
			{
				activePopups[activePopups.length - 1].nextPopup = newPopup;
			}
			activePopups.push( newPopup );
			newPopup.x = stage.stageWidth - newPopup.width;
			newPopup.animate( function ():void
			{
				activePopups.shift();
			} );
		}
	}

}