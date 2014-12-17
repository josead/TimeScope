package engine;

import flash.display.Stage;
import flash.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.Assets;
import openfl.Lib;
import openfl.geom.Point;

class InputManager {
	
	private static var instance:InputManager = null;
	var dir:Int = 0;
	private var mouseDownPoint:Point;
	private var mouseDownTime:Int;
	
	public static function getInstance():InputManager{
		if(instance==null){
			instance=new InputManager();
		}
		return instance;
	} 
	
	private function new () {
		
	}
	
	public function suscribe(stage:Stage){
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	private function onMouseDown (event:MouseEvent):Void {
		mouseDownPoint = new Point (event.stageX, event.stageY);
		mouseDownTime = Lib.getTimer ();
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
 
	private function onMouseUp (event:MouseEvent):Void{
		var differenceX:Float = event.stageX - mouseDownPoint.x;
		var differenceY:Float = event.stageY - mouseDownPoint.y;
		var differenceTime:Float = (Lib.getTimer () - mouseDownTime) / 1000;
		if (Math.abs (differenceX) > Math.abs (differenceY) && Math.abs (differenceX) > 60 && differenceTime < 3) {
			if (differenceX > 0) {
				right();
			} else {
				left();
			}
		}
		Lib.current.stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	private function left() {
		dir = -1;
	}
	
	private function right() {
		dir = 1;
	}
	
	public function reset() {
		dir = 0;
	}
	
	public function ReturnDirection():Int {
		return dir;
	}
    
}
