package ;
import engine.GameElement;
import engine.Animation;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.Font;
import openfl.Assets;
import engine.ScoreManager;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class StatusBar extends GameElement
{
	var scene:Level;
	
	var hp1:Animation;
	var hp2:Animation;
	var hp3:Animation;
	var movGem:Animation;
	
	var font:Font;
	var scoreText:TextField;
	var gemText:TextField;
	var globalGems:Int;
	
	
	public function new(currentScene:Level) 
	{
		super();

		this.scene = currentScene;
		this.globalGems = ScoreManager.getGems();
		
		hp1 = new Animation( Assets.getBitmapData("img/heart.png"), 7, 1);
		hp2 = new Animation( Assets.getBitmapData("img/heart.png"), 7, 1);
		hp3 = new Animation( Assets.getBitmapData("img/heart.png"), 7, 1);
		movGem = new Animation( Assets.getBitmapData("img/gem.png"), 7, 1);
		

		movGem.x = 235;
		movGem.y = -10;
		movGem.scaleX = 0.22;
		movGem.scaleY = 0.22;
		
		hp1.scaleX = 0.3;
		hp1.scaleY = 0.3;
		hp1.x = 4;
		hp1.y = -25;
		hp2.scaleX = 0.3;
		hp2.scaleY = 0.3;
		hp2.scaleY = 0.3;
		hp2.x = hp1.x + 40;
		hp2.y = hp1.y;
		hp3.scaleX = 0.3;
		hp3.scaleY = 0.3;
		hp3.x = hp2.x + 40;
		hp3.y = hp1.y;
		
		
		this.childs.push(hp1);
		this.addChild(hp1);
		this.childs.push(hp2);
		this.addChild(hp2);
		this.childs.push(hp3);
		this.addChild(hp3);
		
		this.childs.push(movGem);
		this.addChild(movGem);
		
		scoreText = new TextField();
		scoreText.selectable=false;
		scoreText.width=300;
		scoreText.height = 100;
		scoreText.x = 225;
		scoreText.y = 80;
		
		gemText = new TextField();
		gemText.selectable=false;
		gemText.width=300;
		gemText.height = 100;
		gemText.x = 280;
		gemText.y = 0;
		
		this.font = Assets.getFont('img/font.ttf');

		var tf = new TextFormat(font.fontName, 60, 0xFFFFFF);
		scoreText.setTextFormat(tf);
		scoreText.defaultTextFormat = tf;
		var tf2 = new TextFormat(font.fontName, 40, 0xFFFFFF);
		gemText.setTextFormat(tf2);
		gemText.defaultTextFormat=tf2;

		this.addChild(scoreText);
		this.addChild(gemText);
	}
	
	override public function updateLogic(time:Float) {
		scoreText.text = '' + (scene.localScore);
		gemText.text = '' + (scene.localGems + this.globalGems);
		switch (scene.localHealth) {
			case 1: {
				hp2.visible = false;
			}
			case 2: {
				hp2.visible = true;
				hp3.visible = false;
			}
			case 3: hp3.visible = true;
		}
		super.updateLogic(time);
	}
	
}