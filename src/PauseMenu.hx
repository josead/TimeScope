package ;

import engine.Button;
import engine.GameElement;
import openfl.display.Bitmap;
import motion.Actuate;
import openfl.Assets;
import engine.SoundManager;
import engine.ScoreManager;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class PauseMenu extends GameElement
{
	var tint: Bitmap;
	var glow: Bitmap;
	var triangle: Bitmap;
	var scene: Level;
	var resume: Button;
	var exit: Button;
	
	public function new(currentScene: Level) 
	{
		super();
		
		this.visible = false;
		
		tint = new Bitmap(Assets.getBitmapData('img/pausefill.png'));
		glow = new Bitmap(Assets.getBitmapData('img/pauseglow.png'));
		triangle = new Bitmap(Assets.getBitmapData('img/pausetriangle.png'));
		
		glow.y = 210;
		triangle.y = glow.y + 100;
		triangle.x = 20;
		
		this.scene = currentScene;
		this.addChild(tint);
		this.addChild(glow);
		this.addChild(triangle);
		
		resume = new Button('img/resume.png', deactivate);
		exit = new Button('img/exit.png', goMenu);
		
		resume.y = triangle.y + 70;
		resume.x = triangle.x + 135;
		exit.y = resume.y + 100;
		exit.x = resume.x;
		
		this.addChild(resume);
		this.addChild(exit);
		
	}
	
	public function deactivate(_) {
		this.visible = false;
		scene.unPause();
	}
	
	public function activate() {
		this.visible = true;
	}
	
	function goMenu(_) {
		ScoreManager.setGems(scene.localGems);
		SoundManager.stop();
		SoundManager.playMusic('audio/menu.ogg');
		Main.getInstance().setScene('mainmenu'); 
	}
	
}