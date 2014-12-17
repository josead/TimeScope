package ;

import engine.*;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.Assets;

/**
 * ...
 * @author Dario Fernandez Torre
 */

class Main extends SceneManager 
{
	private static var instance:SceneManager = null;
	
	public static function getInstance():SceneManager {
		return instance;	
	}

	public function new() 
	{
		super();
		instance=this;
		
		stage.addEventListener(flash.events.Event.ENTER_FRAME,gameLoop);
		InputManager.getInstance().suscribe(stage);
		
		sceneMap.set('intro', new Intro());
		sceneMap.set('mainmenu', new MainMenu());
		sceneMap.set('options', new OptionsMenu());
		
		setScene('intro');
	}
	
	function gameLoop(e){
		this.updateLogic(1/60);
	}
	
}
