package engine;

import flash.display.Sprite;
import flash.display.BitmapData;
import openfl.display.Tilesheet;
import flash.geom.Rectangle;
import flash.geom.Point;

/**
 * ...
 * @author fbricker
 */
class CharAnimation extends GameElement {
	var t:Tilesheet;
	var totalTime:Float;
	var cant:Int;
	
	public function new (img:BitmapData, cols:Int, rows:Int) {		
		super();
		var col:Int;
		var row:Int;
		var w:Int=Math.round(img.width/cols);
		var h:Int=Math.round(img.height/rows);

		t=new Tilesheet(img);
		for(col in 0 ... cols){
			for(row in 0 ... rows){
				t.addTileRect(new Rectangle(col*w,row*h,w,h));
			}
		}
		this.width=w;
		this.height=h;
		cant=cols*rows;
		trace(cant);
		t.drawTiles(graphics,[0,0,0]);
		totalTime=0;
	}

	public function reset(){
		totalTime=0;
	}

	public function getFrame():Int{
		return Math.round(totalTime*25)%cant;			
	}
	
	override public function updateLogic(time:Float){
		graphics.clear();
		totalTime+=time;
		t.drawTiles(graphics,[0,0,getFrame()]);
	}

}