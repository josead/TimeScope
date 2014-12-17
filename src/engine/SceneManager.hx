package engine;

import flash.display.Sprite;
import flash.display.BitmapData;
import openfl.display.Tilesheet;
import flash.geom.Rectangle;
import flash.geom.Point;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class SceneManager extends GameElement {

	var currentScene:Scene;
	public var sceneMap(default,null):Map<String,Scene>;

	private function new(){
		super();
		currentScene=null;
		sceneMap=new Map<String,Scene>();
	}


	public function setScene(name:String){
		if(!sceneMap.exists(name)){
			trace(sceneMap);
			trace("LA ESCENA "+name+" NO EXISTE!");
			return;
		}

		if(currentScene!=null){
			this.removeChild(currentScene);
			childs.remove(currentScene);
			currentScene=null;
		}

		currentScene=sceneMap.get(name);
		this.addChild(currentScene);
		this.childs.push(currentScene);
		currentScene.show();
	}

}