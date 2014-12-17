package  ;
import elements.*;
import engine.*;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import motion.Actuate;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class Level extends Scene
{
	public var BackG:Background;
	public var Hero:Character;
	public var channel:SoundChannel;
	public var elemControl:ElementController;
	var swipeL:Bitmap;
	var swipeR:Bitmap;
	var paused:Bool;
	var pauseMenu:PauseMenu;
	var back:Button;
	var three:Bitmap;
	var two:Bitmap;
	var one:Bitmap;
	var go:Bitmap;
	public var localGems:Int;
	public var localScore:Int;
	public var localHealth:Int;
	var status: StatusBar;
	var gobg: Bitmap;
	var gobg2: Bitmap;
	var retry: Bitmap;
	var yes: Button;
	var no: Button;
	var font:Font;
	var scoreText:TextField;
	var newhs: Bitmap;
	
	public function new(BG:String,BGL:String,Horizon:String, Floor:String) 
	{
		super();
		
		this.localGems = 0;
		this.localScore = 0;
		this.localHealth = 3;
		
		BackG = new Background(BG, BGL, Horizon, Floor);
		addChild(BackG);
		childs.push(BackG);
		
		swipeL = new Bitmap(Assets.getBitmapData('img/swipeL.png'));
		swipeL.x = 300;
		swipeL.y = 300;
		swipeR = new Bitmap(Assets.getBitmapData('img/swipeR.png'));
		swipeR.x = 80;
		swipeR.y = 300;
		
		three = new Bitmap(Assets.getBitmapData('img/3.png'));
		two = new Bitmap(Assets.getBitmapData('img/2.png'));
		one = new Bitmap(Assets.getBitmapData('img/1.png'));
		go = new Bitmap(Assets.getBitmapData('img/go.png'));
		three.alpha = two.alpha = one.alpha = go.alpha = 0;
		three.x = two.x = one.x = 240;
		three.y = two.y = one.y = go.y = 230;
		go.x = three.x - 40;
		
		if (!ScoreManager.getTutorial()) tutorial();
		else count();
		
		
		elemControl = new ElementController(this, 100);
		addChild(elemControl);
		childs.push(elemControl);
		
		Hero = new Character(this);
		addChild(Hero);
		childs.push(Hero);
		
		pauseMenu = new PauseMenu(this);
		addChild(pauseMenu);
		
		this.paused = false;
		
		status = new StatusBar(this);
		addChild(status);
		this.childs.push(status);
		
		back = new Button('img/pause.png', pause);
		back.y = 2;
		back.x = 485;
		addChild(back);
		
		gobg = new Bitmap(Assets.getBitmapData('img/gobg.png'));
		gobg2 = new Bitmap(Assets.getBitmapData('img/gobg2.png'));
		gobg2.alpha = 0;
		retry = new Bitmap(Assets.getBitmapData('img/retry.png'));
		retry.x = 165; retry.y = 700;
		yes = new Button('img/yes.png', callPlay);
		no = new Button('img/no.png', function(_) { SoundManager.playMusic('audio/menu.ogg'); Main.getInstance().setScene('mainmenu'); } );
		yes.x = 125; no.x = 315;
		yes.y = 830; no.y = 815;
		retry.alpha = yes.alpha = no.alpha = 0;
		scoreText = new TextField();
		scoreText.selectable=false;
		scoreText.width=300;
		scoreText.height = 100;
		scoreText.x = 225;
		scoreText.y = 622;
		this.font = Assets.getFont('img/font.ttf');
		var tf = new TextFormat(font.fontName, 60, 0xFFFFFF);
		scoreText.setTextFormat(tf);
		scoreText.defaultTextFormat = tf;
		
		newhs = new Bitmap(Assets.getBitmapData('img/new.png'));
		newhs.x = 53; newhs.y = 585;
	}
	
	public function gameOver() {
		this.paused = true;
		this.pauseGame();
		Actuate.pauseAll();
		SoundManager.stop();
		addChild(gobg);
		if (ScoreManager.getScore() < this.localScore) addChild(newhs);
		ScoreManager.setGems(this.localGems);
		ScoreManager.setScore(this.localScore);
		this.scoreText.text = '' + (ScoreManager.getScore());
		addChild(gobg2);
		addChild(retry);
		addChild(yes);
		addChild(no);
		addChild(scoreText);
		Actuate.tween(retry, 3, { alpha: 1 } ).delay(1);
		Actuate.tween(yes, 3, { alpha: 1 } ).delay(1);
		Actuate.tween(no, 3, { alpha: 1 } ).delay(1);
		Actuate.tween(gobg2, 3, { alpha:1 } );
	}
	
	public function callPlay(_) {
		SoundManager.stop();
		SoundManager.playRandom();
		Main.getInstance().sceneMap.set('level1', new Level('img/Level1/background.png', 'img/Level1/bgbot.png', 'img/Level1/back.png', 'img/Level1/floor.png'));
		Main.getInstance().setScene('level1'); //Level selector
	}
	
	function count() {
		addChild(three); addChild(two); addChild(one); addChild(go); 
		Actuate.tween(three, 1, { alpha:1 } ).onComplete(function() { removeChild(three); Actuate.tween(two, 1, { alpha:1 } ).onComplete(function() { removeChild(two); Actuate.tween(one, 1, { alpha:1 } ).onComplete(function() { removeChild(one);Actuate.tween(go, 1, { alpha:1 } ).onComplete(function(){removeChild(go);}); } ); } ); } );
	}
	
	function tutorial() {
		addChild(swipeL);
		Actuate.tween(swipeL, 3, { x:80 } ).onComplete(tutorial2);
	}
	
	function tutorial2() {
		Actuate.tween(swipeL, 1, { alpha:0 } );
		addChild(swipeR);
		Actuate.tween(swipeR, 3, { x:300 } ).onComplete( function () { Actuate.tween(swipeR, 1, { alpha:0 } ).onComplete(function() { ScoreManager.setTutorial();}); } );
	}
	
	override public function updateLogic(time:Float) {
		if (paused == false) {
			setChildIndex(Hero, this.numChildren - 1);
			this.localScore += 1;
		}
		super.updateLogic(time);
	}
	
	function pause(_) {
		this.paused = true;
		this.pauseGame();
		setChildIndex(pauseMenu, this.numChildren -1);
		pauseMenu.activate();
		Actuate.pauseAll();
		SoundManager.pause();
	}
	
	public function unPause() {
		this.paused = false;
		this.resumeGame();
		Actuate.resumeAll();
		SoundManager.resume();
	}
	
}