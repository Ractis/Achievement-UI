package  
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Utils 
	{
		
		public static function CreateLabel( text:String, fontType:String, funcDefaultTextFormat:Function = null ):TextField
		{
			var tf:TextField = new TextField();
			tf.selectable = false;
			
			var format:TextFormat = new TextFormat();
			format.font = fontType;
			format.color = 0xDDDDDD;
			if ( funcDefaultTextFormat != null )
			{
				funcDefaultTextFormat( format );
			}
			tf.defaultTextFormat = format;
			tf.text = text;
			tf.setTextFormat( format );
		//	tf.autoSize = TextFieldAutoSize.LEFT;
			tf.autoSize = TextFieldAutoSize.NONE;
			
			return tf;
		}
		
		public static function ItemNameToTexture( itemName:String ):Loader
		{
			return LoadTexture( itemName.replace( "item_", "images\\items\\" ) + ".png" );
		}
		
		public static function LoadTexture( textureName:String ):Loader
		{
			var texture:Loader = new Loader();
			texture.load( new URLRequest( textureName ) );
			return texture;
		}
		
		static public function Log( ...rest ):void 
		{
			trace( "[Achievement-UI] " + rest );
		}
		
		static public function LogError( e:Error ):void 
		{
			Log( e.message );
			Log( "\n" + e.getStackTrace() );
		}
		
	}

}