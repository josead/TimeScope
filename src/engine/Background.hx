package engine;

import motion.Actuate;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.geom.Transform;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class Background extends GameElement
{
	public var BackG:Bitmap;
	public var BackGL: Bitmap;
	public var hPlane:Bitmap;
	public var fPlane:Bitmap;
	public var sprite:Sprite;
	public var lines(default,null):Array<Line>;
	public var activeLines(default, null):Array<Line>;
	public var lineTimer:Float;
	var increase:Float;
	
	public function new(BG:String, BGL:String, Horizon:String, Floor:String) 
	{
		super();
		BackG = new Bitmap(Assets.getBitmapData(BG));
		BackGL = new Bitmap(Assets.getBitmapData(BGL));
		hPlane = new Bitmap(Assets.getBitmapData(Horizon));
		fPlane = new Bitmap(Assets.getBitmapData(Floor));
		
		sprite = new Sprite();
		sprite.addChild(hPlane);
		
		lines = new Array<Line>();
		activeLines = new Array<Line>();
		for (i in 0 ... 1000) lines.push(new Line(this));
		lineTimer = 0;
		
		addChild(BackG);
		addChild(BackGL);
		addChild(sprite);
		addChild(fPlane);
		
		//hPlane.y = 355;
		//hPlane.x = 15;
		BackG.y = -175;
		BackGL.y = 320;
		fPlane.y = 310;
		fPlane.x = -20;
		
		sprite.x = 15;
		sprite.y = 180;
		Actuate.tween(sprite, 0.5, { x:20, y:190, width:530, height:117 } ).repeat();
		
		increase = 0;
	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		lineTimer -= time + increase;
		if (lineTimer < 0) {
			lineTimer = 0.35;
			if (lines.length > 0) lines.pop().spawn();
			if (lines.length == 0) for (i in 0 ... 100) lines.push(new Line(this));
		}
		setChildIndex(fPlane, this.numChildren - 1);
       	increase+= 0.000002;
	}
	
}