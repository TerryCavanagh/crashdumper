package;


import crashdumper.CrashDumper;
import crashdumper.SessionData;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import haxe.CallStack;
import openfl.Assets;
import openfl.events.MouseEvent;
import openfl.events.UncaughtErrorEvent;
import openfl.Lib;
import openfl.text.TextField;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		var t:TextField = new TextField();
		t.width = stage.stageWidth;
		t.text = "Click the red square to CRASH!";
		t.text += "\nA crash dump will be generated in the application's folder under \\log\\errors\\";
		addChild(t);
		
		var bitmap = new Bitmap (new BitmapData(200, 200, false, 0x00FF0000));
		addChild (bitmap);
		
		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2;
		
		
		//CrashDumper stuff:
		
		var unique_id:String = SessionData.generateID("example_app_");
		var crashDumper = new CrashDumper(unique_id);
		
		//Here is where you would load your config and/or save data from file
		//(in this example, we just grab a fake config.xml from assets, 
		//but you should load them from wherever your app stores them)
		
		var fakeConfigFile:String = Assets.getText("assets/config.xml");
		crashDumper.session.files.set("config.xml", fakeConfigFile);
		
		//we're set, add event listener
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(m:MouseEvent)
	{
		//Intentional crash, pick your poison:
		
		nullReference();
		//invalidCast();
		//stackOverflow();
		//memoryLeak();
		//infiniteLoop();
	}
	
	private function doNothing():Void
	{
		//do nothing
	}
	
	private function infiniteLoop():Void
	{
		while (true)
		{
			doNothing();
		}
	}
	
	private function nullReference():Void
	{
		var b:BitmapData = null;
		b.clone();
	}
	
	private function stackOverflow():Void
	{
		stackOverflow();
	}
	
	private function memoryLeak():Void
	{
		var a:Array<Int> = [1, 2, 3];
		while (true)
		{
			a.push(123);
		}
	}
	
	private function invalidCast():Void
	{
		var crazy:Map<String, Array<Bool>> = new Map<String, Array<Bool>>();
		var sprite:Sprite = cast(crazy, Sprite);
	}
}