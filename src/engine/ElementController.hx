package engine;

import motion.Actuate;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class ElementController extends GameElement
{
	
	public var objects(default,null):Array<MovingElement>;
	private var baseSpeed:Int;
	private var objectsTimer:Float;
	public var scene:Level;
	public var diffInc:Int;
	public var diffFactor:Float;
	public var difficulty:Float;
	var amount:Int;
	
	public function new(currentScene:Level, amount:Int) 
	{
		super();
		this.scene = currentScene;
		this.amount = amount;
		
		baseSpeed = 10;
		objects = new Array<MovingElement>();
		for (i in 0 ... amount) {
			switch (Std.random(30)){
				 case 1, 6: objects.push(new MovingElement('Heart', Std.random(3), baseSpeed, currentScene));
				 case 2, 3, 4, 5: objects.push(new MovingElement('Gem', Std.random(3), baseSpeed, currentScene));
				 case 7, 8, 9, 10: objects.push(new MovingElement('Enemy2', Std.random(3), baseSpeed, currentScene));
				 case 11, 12, 13, 14, 15: objects.push(new MovingElement('Enemy3', Std.random(3), baseSpeed, currentScene));
				 default: objects.push(new MovingElement('Enemy1', Std.random(3), baseSpeed, currentScene));
			}
		}
		difficulty = 1;
		diffInc = 0;
		objectsTimer = 6;
		diffFactor = 0.3;
	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);	       	
		objectsTimer-=time;
		if(objectsTimer<0){
			objectsTimer = (Std.random(3) + 0.5) / difficulty + 0.25;
			if (objects.length > 0) {
				objects.pop().spawn();
				diffInc++;
			}
			if (objects.length == 0) {
				for (i in 0 ... amount) {
					switch (Std.random(30)){
						 case 1, 6: objects.push(new MovingElement('Heart', Std.random(3), baseSpeed, scene));
						 case 2, 3, 4, 5: objects.push(new MovingElement('Gem', Std.random(3), baseSpeed, scene));
						 case 7, 8, 9, 10: objects.push(new MovingElement('Enemy2', Std.random(3), baseSpeed, scene));
						 case 11, 12, 13, 14, 15: objects.push(new MovingElement('Enemy3', Std.random(3), baseSpeed, scene));
						 default: objects.push(new MovingElement('Enemy1', Std.random(3), baseSpeed, scene));
					}
				}
			}
		}
       	if (diffInc >= 2) {
			diffInc = 0;
			difficulty += diffFactor;
		}
	}
	
}