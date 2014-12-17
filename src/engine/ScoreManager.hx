package engine;

import openfl.net.SharedObject;

class ScoreManager {

	private static var data:openfl.net.SharedObject=null;

	public static function setMusic(set:Bool){
		data.data.music = set;
		try {
			data.flush();
		}catch(e:Dynamic){
			trace("Music:"+set);
		}
	}
	
	public static function Music():Bool{
		if(data==null) data=openfl.net.SharedObject.getLocal('storage');
		if(data.data==null) return true;
		if(data.data.music==null) return true;
		return data.data.music;
	}
	
	public static function setSFX(set:Bool){
		data.data.sfx = set;
		try {
			data.flush();
		}catch(e:Dynamic){
			trace("SFX:"+set);
		}
	}
	
	public static function SFX():Bool{
		if(data==null) data=openfl.net.SharedObject.getLocal('storage');
		if(data.data==null) return true;
		if(data.data.sfx==null) return true;
		return data.data.sfx;
	}
	
	public static function setHaptics(set:Bool){
		data.data.haptics = set;
		try {
			data.flush();
		}catch(e:Dynamic){
			trace("Haptics:"+set);
		}
	}
	
	public static function Haptics():Bool{
		if(data==null) data=openfl.net.SharedObject.getLocal('storage');
		if(data.data==null) return true;
		if(data.data.haptics==null) return true;
		return data.data.haptics;
	}
	
	public static function setTutorial(){
		data.data.tutorial = true;
		try {
			data.flush();
		}catch(e:Dynamic){
			trace("User knows how to play.");
		}
	}
	
	public static function getTutorial():Bool{
		if(data==null) data=openfl.net.SharedObject.getLocal('storage');
		if(data.data==null) return false;
		if(data.data.tutorial==null) return false;
		return data.data.tutorial;
	}
	
	public static function setGems(gems:Int){
		var local:Int = getGems();
		data.data.gems = (local + gems);
		try {
			data.flush();
		}catch(e:Dynamic){
			trace("Error on saving gems: "+e);
		}
	}
	
	public static function setScore(score:Int) {
		if(getScore()>=score) return;
		data.data.score=score;
		try{
			data.flush();
		}catch(e:Dynamic){
			trace("Error on saving score: "+e);
		}
	}

	public static function getGems():Int{
		if(data==null) data=openfl.net.SharedObject.getLocal('storage');
		if(data.data==null) return 0;
		if(data.data.gems==null) return 0;
		return data.data.gems;
	}
	
	public static function getScore():Int{
		if(data==null) data=openfl.net.SharedObject.getLocal('storage');
		if(data.data==null) return 0;
		if(data.data.score==null) return 0;
		return data.data.score;
	}

}