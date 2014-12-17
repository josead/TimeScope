package ;

import engine.Scene;
import openfl.Assets;
import motion.Actuate;
import engine.SoundManager;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class Intro extends Scene
{

	var logo: Bitmap;
	
	public function new() 
	{
		super();
		logo = new Bitmap( Assets.getBitmapData('img/togglelogo.png'));
		logo.x = 155;
		logo.y = 260;
		logo.alpha = 0;
		addChild(logo);
		Actuate.tween(logo,4,{alpha:1}).onComplete(function() { Main.getInstance().setScene('mainmenu'); SoundManager.playMusic('audio/menu.ogg');} );
		SoundManager.playSound('audio/intro.ogg');
	}

	
}