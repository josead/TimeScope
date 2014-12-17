package ;
import engine.*;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.media.Sound;
import openfl.media.SoundChannel;

//PROVISORIO
import motion.Actuate;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class MainMenu extends Scene
{
	var logo:Animation;
	var play:Button;
	var shop:Button;
	var options:Button;
	var leaderboard:Button;
	var copyright:Bitmap;
	
	public function new() 
	{
		super();
		
		logo = new Animation( Assets.getBitmapData('img/logo.png'), 5, 2);
		play = new Button('img/MainMenu/play.png', callPlay);
		shop = new Button('img/MainMenu/shop.png', callShop);
		options = new Button('img/MainMenu/options.png', callOptions);
		leaderboard = new Button('img/MainMenu/leaderboard.png', callLeaderboard);
		copyright = new Bitmap( Assets.getBitmapData('img/MainMenu/copyright.png'));
		
		play.x = 120;
		play.y = 465;
		shop.x = 120;
		shop.y = 550;
		options.x = 120;
		options.y = 635;
		leaderboard.x = 55;
		leaderboard.y = 725;
		copyright.x = 183;
		copyright.y = 875;
		logo.scaleX = 2;
		logo.scaleY = 2;
		
		addChild(logo);
		childs.push(logo);
		this.addChild(play);
		this.addChild(shop);
		this.addChild(options);
		this.addChild(leaderboard);
		this.addChild(copyright);
		
	}
	
	public function callPlay(_) {
		SoundManager.stop();
		SoundManager.playRandom();
		Main.getInstance().sceneMap.set('level1', new Level('img/Level1/background.png', 'img/Level1/bgbot.png', 'img/Level1/back.png', 'img/Level1/floor.png'));
		Main.getInstance().setScene('level1'); //Level selector
	}
	public function callShop(_) {
		//
	}
	public function callOptions(_) {
		Main.getInstance().setScene('options');
	}
	public function callLeaderboard(_) {
		//
	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);	       	
	}
	
}