package engine;

import flash.display.Sprite;

/**
 * ...
 * @author Dario Fernandez Torre
 */

class GameElement extends Sprite{
	
	var childs:Array<GameElement>;
	var state:Int;
	
	public function new () {
		super();	
		state=0;	
		childs=new Array<GameElement>();
	}
	
	public function updateLogic(time:Float){
		var hijo:GameElement;
		if (state == 0) {
			for(hijo in childs){
				hijo.updateLogic(time);
			}
		}
	}
	
	public function pauseGame() {
		state = 1;
	}
	
	public function resumeGame() {
		state = 0;
	}

}