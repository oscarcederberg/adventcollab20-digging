package digging;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.ui.FlxButton;
import digging.tiles.Bedrock;

import ui.Controls;
#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class MenuState extends FlxState
{
	var playButton:FlxButton;
	var keys:Array<Action>;
	var step:Int;

	override public function create()
	{
		var background:FlxSprite = new FlxSprite(0, 0);
		background.loadGraphic(Global.asset("assets/images/spr_title.png"), false, 480, 270);
		add(background);

		playButton = new FlxButton(0, 10 * 540 / 32, null, clickPlay);
		playButton.loadGraphic(Global.asset("assets/images/spr_button_play.png"), true, 80, 26);
		playButton.screenCenter(X);
		add(playButton);

		FlxG.sound.playMusic(Global.asset("assets/music/mus_jingle.mp3"), 0.5, true);
		FlxG.sound.music.loopTime = 3692;

		keys = Konami.KEYS;
		step = 0;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (Controls.justPressed.ANY)
		{
			if (Konami.handleKeys(step))
			{
				step++;
				if (step == 10)
				{
					add(new Konami(352, 96));
				}
			}
			else
			{
				step = 0;
				if (Controls.justPressed.A)
				{
					clickPlay();
				}
			}
		}

		super.update(elapsed);
	}

	function clickPlay()
	{
		Global.switchState(new PlayState());
	}
}
