package;

import haxe.Constraints.Function;

@:native("mathgames-api")
@:ns("MathGamesAPI")

typedef InstanceConfig = {
	api_key:String,
	wrapper:Dynamic,
	debug:Bool
}

typedef SelectSkillConfig = {
	pool_key:String
}

typedef ColorConfig = {
	question:Array<Float>,
	choices:Array<Array<Float>>
}

typedef QuestionConfig = {
	colors:ColorConfig
}

enum APIEventType
{
	SESSION_READY;
	SKILL_SELECTED;
	SKILL_CHANGED;
	PROGRESS_CLOSED;
	AVERAGE_TIME_CHANGE;
	AVAILABLE_STANDARDS_CLOSED;
	ERROR;
}

/** The question object has the image data needed to display the question */
typedef Question = {
	display:String,
	choices:Array<String>
}

typedef APIInstance = {
	
	/** Add new event listener to the API Instance */
	function on(event:APIEventType, listener:Function):APIInstance;
	
	/** Remove added event listener from the API Instance */
	function off(event:APIEventType, listener:Function):APIInstance;
	
	/** Display the select skill dialog to the user. Requires a pool_key (generally 'COMPLETE') */
	function selectSkill(options:SelectSkillConfig):Void;
	
	/** Starts the session. StartSession should only be called after the SKILL_SELECTED event */
	function startSession():Void;
	
	/** Returns a new question */
	function getQuestion(?options:QuestionConfig):Question;
	
	/** The index parameter is the index of the question choice that was answered */
	function answerQuestion(index:Float):Bool;
	
	/** Display the progress dialog */
	function showProgress():Void;
	
	/** Ends the session */
	function endSession():Void;
	
	/** Dsiplay available standarts */
	function showAvailableStandards():Void;
}

/** The MathGamesAPI provides a simple interface for developers to integrate the MathGames questions engine in to their html5 based games */
extern class MathGamesAPI
{
	/** Returns new instance of MathGamesAPI. The wrapper is a DOMElement which wraps 
	 * the game canvas and is used to add api interface elements over the canvas */
	public static function getInstance(options:InstanceConfig):APIInstance;
}