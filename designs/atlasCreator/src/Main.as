package
{
	import com.utterlySuperb.display.textureAtlas.AssetCreator;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Sam Bellman
	 */
	public class Main extends Sprite 
	{
		private static const SAVE_DIR:String = "C:\\Users\\Sam\\Documents\\work\\haxe\\\queueGame\\build\\bin\\assets\\images\\";
		
		private var ac:AssetCreator;
		private var assetNumLoaded:int = 0;
		private var assets:Vector.<AssetInfo>;
		
		public function Main() 
		{
			super();
			//AssetCreator.DEBUG = true;
			
			assets = new Vector.<AssetInfo>();
			ac = new AssetCreator(1, "atlas");
			ac.setOutputSize(1024, 1024);
			addChild(ac);
			
			addBespoke("body0", "body0");
			addBespoke("body1", "body1");
			addBespoke("body2", "body2");
			addBespoke("body3", "body3");
			addBespoke("box", "box");
			addBespoke("bread", "bread");
			addBespoke("carrot", "carrot");
			addBespoke("cart", "cart");
			addBespoke("counter", "counter");
			addBespoke("crisps", "crisps");
			addBespoke("feet", "feet");
			addBespoke("floorTile", "floorTile");
			addBespoke("head0", "head0");
			addBespoke("head1", "head1");
			addBespoke("head2", "head2");
			addBespoke("head3", "head3");
			addBespoke("head4", "head4");
			addBespoke("juice", "juice");
			addBespoke("bananas", "bananas");
			addBespoke("ketchup", "ketchup");
			addBespoke("lettuce", "lettuce");
			addBespoke("teller", "teller");
			addBespoke("toiletPaper", "toiletPaper");
			
			addBespoke("buttonYellowBigOver", "yellow_button00");
			addBespoke("buttonYellowBigDown", "yellow_button01");
			addBespoke("buttonYellowBigUp", "yellow_button02");
			addBespoke("buttonYellowSmallOver", "yellow_button07");
			addBespoke("buttonYellowSmallDown", "yellow_button08");
			addBespoke("buttonYellowSmallUp", "yellow_button09");
			
			addBespoke("buttonBlueBigOver", "blue_button00");
			addBespoke("buttonBlueBigDown", "blue_button01");
			addBespoke("buttonBlueBigUp", "blue_button02");
			addBespoke("buttonBlueSmallOver", "blue_button07");
			addBespoke("buttonBlueSmallDown", "blue_button08");
			addBespoke("buttonBlueSmallUp", "blue_button09");
			
			addBespoke("play", "play");
			addBespoke("pause", "pause");
			
			addBespoke("paying0", "paying0");
			addBespoke("paying1", "paying1");
			
			addBespoke("audioOff", "audioOff");
			addBespoke("audioOn", "audioOn");
			
			addBespoke("medal0", "medal_gold");
			addBespoke("medal1", "medal_silver");
			addBespoke("medal2", "medal_bronze");
			
			loadAssets();
		}
		
		private function addBespoke(id:String, fileName:String):void
		{
			assets.push(new AssetInfo(id, fileName, "assets\\"));
		}
		
		private function loadAssets():void
		{
			assetNumLoaded = 0;
			loadAsset();
		}
		
		private function loadAsset():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, assetLoaded);
			trace(assets[assetNumLoaded].path);
			loader.load(new URLRequest(assets[assetNumLoaded].path));
		}
		
		private function assetLoaded(e:Event):void
		{
			var li:LoaderInfo = e.target as LoaderInfo;
			//chars[assetNumLoaded].asset = li.loader.content as Bitmap;
			var mc:MovieClip = new MovieClip();

			mc.addChild(li.loader);			
			ac.addAnimation(assets[assetNumLoaded].id, mc);
			

			if (++assetNumLoaded < assets.length)
			{
				loadAsset();
			}
			else
			{
				ac.addEventListener(Event.COMPLETE, atlasDone);
				ac.start(new File(SAVE_DIR));
			}
		}
		
		private function atlasDone(e:Event):void 
		{
			trace("Done!");
		}
	}
	
}
internal class AssetInfo
{
	public var id:String;
	public var path:String;
	public function AssetInfo(id:String, path:String, pathPrefix:String)
	{
		this.id = id;
		this.path = pathPrefix + path + ".png" ;
	}
}