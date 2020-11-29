package;

import PlayState.Direction;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy extends FlxSprite
{
	static final MOVE_SPEED:Float = PlayState.CELL_SIZE * 2;
	static final JUMP_SPEED:Float = PlayState.CELL_SIZE * 10;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	public var totalHits:Int;
	public var currentHits:Int;

	var looking_at:Direction;
	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(FlxG.state);
		this.looking_at = Direction.Right;

		acceleration.y = GRAVITY;
		velocity.x = MOVE_SPEED;
		maxVelocity.x = MOVE_SPEED;
		maxVelocity.y = JUMP_SPEED;

		makeGraphic(PlayState.CELL_SIZE, PlayState.CELL_SIZE, FlxColor.RED);
	}

	override public function update(elapsed:Float):Void
	{
		movement();

		super.update(elapsed);

		FlxG.collide(this, parent.blocks);
		FlxG.collide(this, parent.bounds);
	}

	function movement():Void
	{
		switch (looking_at)
		{
			case Direction.Left:
				if (this.isTouching(FlxObject.LEFT))
				{
					velocity.x = MOVE_SPEED;
					looking_at = Direction.Right;
				}
			case Direction.Right:
				if (this.isTouching(FlxObject.RIGHT))
				{
					velocity.x = -MOVE_SPEED;
					looking_at = Direction.Left;
				}
			default:
		}
	}
}
