package engine;
import openfl.display.Sprite;
import motion.Actuate;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class Line extends GameElement
{
	public var speed:Float;
	var back:Background;
	var accel:Float;
	
	public function new(back:Background) 
	{
		super();

		this.graphics.beginFill(0x115084);
		this.graphics.drawRect(0, 0, 540, 1);
		this.graphics.endFill();
		this.back = back;
	}
	
	public function spawn() {
		this.speed = 0;
		this.y = 310;
		this.accel = 0.05;
		back.childs.push(this);
		back.addChild(this);
		back.activeLines.push(this);
		Actuate.transform(this, 20).color(0xff235e, 1);
	}
	
	public function die(){
		back.childs.remove(this);
		back.removeChild(this);
	}
	
	override public function updateLogic(time:Float) 
	{
		super.updateLogic(time);
		this.speed += accel;
		this.y += this.speed;
		this.accel += 0.000002;
		if(this.y > 1080) die();
	}
	
}