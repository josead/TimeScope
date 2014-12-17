package engine;

import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.Assets;
import openfl.events.Event;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class SoundManager
{
	public static var channel:SoundChannel;
	public static var channel2:SoundChannel;
	public static var position:Float; 
	public static var musicState: Bool = ScoreManager.Music();
	public static var sfxState: Bool = ScoreManager.SFX();
	static var music:Sound;
	static var music2:Sound;

	public static function playMusic(soundDir:String) {
		if ((ScoreManager.Music()) || (musicState)) {
			music = Assets.getMusic(soundDir);
		channel2 = music.play();
		}
	}
	
	public static function playRandom() {
		if ((ScoreManager.Music()) || (musicState)) {
			switch (Std.random(11)) {
				case 0: music = Assets.getMusic('audio/music/level.ogg');
				case 1: music = Assets.getMusic('audio/music/level1.ogg');
				case 2: music = Assets.getMusic('audio/music/level2.ogg');
				case 3: music = Assets.getMusic('audio/music/level3.ogg');
				case 4: music = Assets.getMusic('audio/music/level4.ogg');
				case 5: music = Assets.getMusic('audio/music/level5.ogg');
				case 6: music = Assets.getMusic('audio/music/level6.ogg');
				case 7: music = Assets.getMusic('audio/music/level7.ogg');
				case 8: music = Assets.getMusic('audio/music/level8.ogg');
				case 9: music = Assets.getMusic('audio/music/level9.ogg');
				case 10: music = Assets.getMusic('audio/music/level10.ogg');
			}
			channel2 = music.play();
			channel2.addEventListener(Event.SOUND_COMPLETE, onSongEnd );
		}
	}
	
	static public function onSongEnd(event:Event) {
		if ((ScoreManager.Music()) || (musicState)) {
			channel2.removeEventListener(Event.SOUND_COMPLETE, onSongEnd);
			playRandom();
		}
	}
	
	
	public static function playSound(soundDir:String) {
		if ((ScoreManager.SFX()) || (sfxState)) {
			music2 =  Assets.getSound(soundDir);
			channel = music2.play();
		}
	}
	
	public static function stop() {
		if ((ScoreManager.Music()) || (musicState)) {
			channel2.stop();
		}
	}
	
	public static function pause() {
		if ((ScoreManager.Music()) || (musicState)) {
			position = channel2.position;
			channel2.stop();
		}
	}
	
	public static function resume() {
		if ((ScoreManager.Music()) || (musicState)) {
			channel2 = music.play(position);
		}
	}
	
}