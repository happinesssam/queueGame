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
			
			addBespoke("head0", "head0");
			
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