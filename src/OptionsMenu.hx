package ;
import engine.Button;
import engine.Scene;
import openfl.display.Bitmap;
import openfl.Assets;
import engine.ScoreManager;
import engine.SoundManager;
import openfl.feedback.Haptic;

/**
 * ...
 * @author Dario Fernandez Torre
 */
class OptionsMenu extends Scene
{
	var bg: Bitmap;
	var musicOn: Button;
	var sfxOn: Button;
	var hapticsOn: Button;
	var musicOff: Button;
	var sfxOff: Button;
	var hapticsOff: Button;
	var arrow: Button;
	
	public function new() 
	{
		super();
		
		bg = new Bitmap(Assets.getBitmapData('img/options.png'));
		arrow = new Button('img/arrow.png', back);
		musicOn = new Button('img/on.png', setMusicOff);
		sfxOn = new Button('img/on.png', setSFXOff);
		hapticsOn = new Button('img/on.png', setHapticsOff);
		musicOff = new Button('img/off.png', setMusicOn);
		sfxOff = new Button('img/off.png', setSFXOn);
		hapticsOff = new Button('img/off.png', setHapticsOn);
		
		arrow.x = 5;
		arrow.y = 900;
		musicOn.x = sfxOn.x = hapticsOn.x = musicOff.x = sfxOff.x = hapticsOff.x = 155;
		musicOn.y = musicOff.y = 510;
		sfxOn.y = sfxOff.y = musicOn.y + 147;
		hapticsOn.y = hapticsOff.y = sfxOn.y + 145;
		
		addChild(bg);
		addChild(arrow);
		if (ScoreManager.Music()) addChild(musicOn); 
		else addChild(musicOff);
		if (ScoreManager.SFX()) addChild(sfxOn);
		else addChild(sfxOff);
		if (ScoreManager.Haptics()) addChild(hapticsOn);
		else addChild(hapticsOff);
	}
	
	public function back(_) {
		Main.getInstance().setScene('mainmenu');
	}
	
	public function setMusicOn(_) {
		removeChild(musicOff);
		ScoreManager.setMusic(true);
		SoundManager.musicState = true;
		SoundManager.playMusic('audio/menu.ogg');
		
		addChild(musicOn);
	}
	
	public function setSFXOn(_) {
		removeChild(sfxOff);
		ScoreManager.setSFX(true);
		SoundManager.sfxState = true;
		SoundManager.playSound('audio/enemy.ogg');
		
		addChild(sfxOn);
	}
	
	public function setHapticsOn(_) {
		removeChild(hapticsOff);
		ScoreManager.setHaptics(true);
		Haptic.vibrate(100, 500);
		
		addChild(hapticsOn);
	}
	
	public function setMusicOff(_) {
		removeChild(musicOn);
		SoundManager.stop();
		SoundManager.musicState = false;
		ScoreManager.setMusic(false);
		
		
		addChild(musicOff);
	}
	
	public function setSFXOff(_) {
		removeChild(sfxOn);
		SoundManager.sfxState = false;
		ScoreManager.setSFX(false);
		addChild(sfxOff);
	}
	
	public function setHapticsOff(_) {
		removeChild(hapticsOn);
		ScoreManager.setHaptics(false);
		addChild(hapticsOff);
	}
	
}