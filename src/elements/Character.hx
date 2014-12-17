package elements;

import engine.*;
import flash.display.Bitmap;
import openfl.Assets;
import motion.Actuate;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class Character extends GameElement
{
	var mov:CharAnimation;
	var scene:Level;
	public var lane: Int;

	
	public function new(currentScene:Level) 
	{
		super();
		
		mov = new CharAnimation( Assets.getBitmapData('img/char.png'), 9, 2);
		mov.x = 165;
		mov.y = 500;
		this.addChild(mov);
		this.childs.push(mov);
		this.scene = currentScene;
		this.lane = 1;


	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		
		//Control de lineas nuevo para el swipe, a lo croto.
		lane += InputManager.getInstance().ReturnDirection();
		changeLane(lane);
		InputManager.getInstance().reset();
	}
	
	function changeLane(lane:Int) {
		switch (lane) {
			case 0: {
				if (mov.x >= 5) mov.x -= 10;
			}
			case 1: {
				if (mov.x <= 165) mov.x += 10;
				if (mov.x > 165) mov.x -= 10;
			}
			case 2: {
				if (mov.x <= 340) mov.x +=10;
			}
		}
	}
	
}