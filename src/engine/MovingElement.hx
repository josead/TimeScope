package engine;

import motion.MotionPath;
import openfl.Assets;
import elements.Character;
import engine.*;
import openfl.feedback.Haptic;

import motion.Actuate;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class MovingElement extends GameElement
{
	var lvl:Level;
	var anim:Animation;
	var speed:Int;
	var type:String;
	public var lane:Int;
	var done:Bool;
	
	public function new(type:String, lane:Int, speed:Int, lvl:Level) 
	{
		super();
		
		switch (type) {
			case 'Enemy1': anim = new Animation( Assets.getBitmapData("img/Enemies/GaiaKeeper.png"), 3, 1);
			case 'Enemy2': anim = new Animation( Assets.getBitmapData("img/Enemies/gem.png"), 5, 2);
			case 'Enemy3': anim = new Animation( Assets.getBitmapData("img/Enemies/mine.png"), 6, 1);
			case 'Heart': anim = new Animation( Assets.getBitmapData("img/heart.png"), 7, 1);
			case 'Gem': anim = new Animation( Assets.getBitmapData("img/gem.png"), 7, 1);
		}
		
		anim.x = 265;
		anim.y = 300;
		anim.scaleX = 0.01;
		anim.scaleY = 0.01;
		this.type = type;
		this.lvl = lvl;
		this.lane = lane;	
		this.speed = speed;
		this.done = false;
	}
	
	public function spawn() {
		lvl.childs.push(anim);
		lvl.addChild(anim);
		switch (lane) {
			case 0:	Actuate.tween(anim, this.speed * 3, { scaleX:1, scaleY:1, x: 25, y: 450} ).onUpdate(moveLeft);
			case 1:	Actuate.tween(anim, this.speed * 3, { scaleX:1, scaleY:1, x: 190, y: 450} ).onUpdate(moveMid);
			case 2:	Actuate.tween(anim, this.speed * 3, { scaleX:1, scaleY:1, x: 350, y: 450 } ).onUpdate(moveRight);
		}
		
	}
	
	public function moveLeft() {
		if (anim.y > 335) {
			var path = new MotionPath().line( -200, 1000, 1);
			Actuate.tween(anim, this.speed, { scaleX:1.5, scaleY:1.5 } );
			Actuate.motionPath(anim, this.speed, { x: path.x, y: path.y }).onUpdate(end);
		}
		
	}
	
	public function moveMid() {
		if (anim.y > 335) {
			var path = new MotionPath().line( 125, 1000, 1);
			Actuate.tween(anim, this.speed, { scaleX:1.5, scaleY:1.5 } );
			Actuate.motionPath(anim, this.speed, { x: path.x, y: path.y }).onUpdate(end);
		}
		
	}
	
	public function moveRight() {
		if (anim.y > 335) {
			var path = new MotionPath().line( 448, 1000, 1);
			Actuate.tween(anim, this.speed, { scaleX:1.5, scaleY:1.5 } );
			Actuate.motionPath(anim, this.speed, { x: path.x, y: path.y }).onUpdate(end);
		}
		
	}
	
	public function end() {
		if (anim.y > 720) {
				state = 0;
				lvl.childs.remove(anim);
				lvl.removeChild(anim);
		}
		if ((anim.y > 580) && (anim.y < 615) && (!done)) {
			if (lvl.Hero.lane == this.lane) {
				done = true;
				lvl.childs.remove(anim);
				lvl.removeChild(anim);
				switch (type) {
					case 'Enemy1': {
						if (ScoreManager.Haptics()) Haptic.vibrate(100, 300);
						SoundManager.playSound('audio/enemy.ogg');
						lvl.localHealth--;
						if (lvl.localHealth == 0) {
							lvl.gameOver();
						}
					}
					case 'Enemy2': {
						if (ScoreManager.Haptics()) Haptic.vibrate(100, 900);
						SoundManager.playSound('audio/enemy2.ogg');
						lvl.localHealth=0;
						if (lvl.localHealth == 0) {
							lvl.gameOver();
						}
					}
					case 'Enemy3': {
						if (ScoreManager.Haptics()) Haptic.vibrate(100, 600);
						SoundManager.playSound('audio/enemy3.ogg');
						lvl.localHealth --;
						if (lvl.localHealth == 0) {
							lvl.gameOver();
						}
					}
					case 'Heart': {
						if (lvl.localHealth < 3) lvl.localHealth++;
						SoundManager.playSound('audio/heart.ogg');
					}
					case 'Gem': {
						lvl.localGems++;
						SoundManager.playSound('audio/gem.ogg');
					}
				}
			}
		}	
	}
	
	override public function updateLogic(time:Float) 
	{	
		if (state == 0) return;
		super.updateLogic(time);
	}
	
}