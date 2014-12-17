package engine;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Assets;

class Button extends Sprite {

	var image:Bitmap;
	
	public function new(img:String, callback:Event->Void){
		super();
		image = new Bitmap(Assets.getBitmapData(img));
		this.addChild(image);
		this.addEventListener(openfl.events.MouseEvent.CLICK,callback);
	}

}