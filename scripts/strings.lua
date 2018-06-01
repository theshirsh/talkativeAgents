---------------------------------------------------------------------
-- Invisible Inc. MOD.
--
local _M =
{
--	name of speech event		-- Corresponding simdef EV or TRG

--	EVENT_SELECTED = 1,
	EVENT_ATTACK_GUN = 8,		-- EV_UNIT_START_SHOOTING 
	EVENT_ATTACK_MELEE = 30,	-- EV_UNIT_MELEE
--	EVENT_HIT_GUN = 4,
--	EVENT_HIT_MELEE = 5,
--	EVENT_KILL_GUN = 6,
--	EVENT_KILL_MELEE = 7,
--	EVENT_MISS_GUN = 8,
--	EVENT_IS_HIT = 9,
--	EVENT_HP_DOWN = 10,
	EVENT_DEATH = 57,		-- EV_UNIT_HIT instead of death, should not trigger on Last Words
	EVENT_REVIVED = 102,		-- EV_UNIT_HEAL
	EVENT_HIJACK = 19,		-- EV_UNIT_USECOMP also EV_UNIT_WIRELESS_SCAN for Internationale 
	EVENT_INTERRUPTED = 4,		-- EV_UNIT_INTERRUPTED
	EVENT_PEEK = 18,		-- EV_UNIT_PEEK
	EVENT_OVERWATCH = 27,		-- EV_UNIT_OVERWATCH
--	EVENT_OVERWATCH_TARGET = 18,
	EVENT_PIN = 111,		-- EV_UNIT_START_PIN -- unused in game --Not anymore :)
	EVENT_ATTACK_GUN_KO = 1008,	-- added 'custom' 
--	EVENT_HIT_GUN_KO = 21,
	EVENT_LOOT = 66,           	-- TRG_SAFE_LOOTED -- there's trigger used

	-- NPC events			-- Guard's speeches part unused here
--	ARRESTING = 100,
--	ENGAGED = 101,
--	ENGAGED_REVIVED = 102,
--	ENGAGED_WITNESS = 103,
--	ENGAGED_TARGET_LOST = 104,
--	HUNTING = 105,
--	INVESTIGATE_REVIVED = 110,
--	INVESTIGATE_NOISE = 111,
--	INVESTIGATE_SHARED = 112,
--	INVESTIGATE_DONE = 113,
--	INVESTIGATE_LOOKAROUND = 114,
--	ARRESTING_CORPSE = 115,

-- 	agentDef = agentID		-- just for convenience: agentID is a number, agentDef name is easier to use for filling strings
--	stealth_1 = 0, -- tutorial	

	stealth_1 = 1,
	engineer_1 = 2,
	sharpshooter_1 = 3,
	stealth_2 = 4,
	engineer_2 = 5,
	sharpshooter_2 = 6,
	cyborg_1 = 7,
	disguise_1 = 8,
	
	monster = 99,			-- to do: if agentID = ... etc into alpha_voice.lua, to send both version to same destination
	monst3r_pc = 100,		-- starting
	central = 107,
	central_pc = 108,		-- starting

	olivia = 1000,
	derek = 1001,
	rush = 1002,
	draco = 1003,


--	mod_01_pedler = mod_01_pedler,  -- not required, agentID is not a number
--	mod_02_mist = mod_02_mist,
--	mod_03_ghuff = mod_03_ghuff,
--	mod_04_n_umi = mod_04_n_umi,

}

local DLC_STRINGS =
{	       	
	OPTIONS =
	{
		MOD = "Talkative Agents",
		MOD_TIP = "<c:FF8411>FOR AGENTS</c>\nDecker\nInternationale\nShalem 11\nBanks\nNika\nPedler",   	
						
	},

	[_M.stealth_1] = {
	--	speechData = 				{0.2,{"You as ready as I am?","Like old times","Running silent"}},  
		[_M.EVENT_ATTACK_GUN] = 		{1,{"Here we go","Taking aim"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 		{1,{"Night night","Bed time","Lights out","Sweet dreams"}},  								
		[_M.EVENT_ATTACK_MELEE] = 		{1,{"Dig fast!"}},					
	--	[_M.EVENT_HIT_GUN] = 			nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 		{1,{"Night night","Bed time","Lights out","Sweet dreams"}},				
	--	[_M.EVENT_HIT_MELEE] = 			{1,{"chump"}},						
	--	[_M.EVENT_KILL_GUN] = 			nil,
	--	[_M.EVENT_KILL_MELEE] = 		nil,
	--	[_M.EVENT_MISS_GUN] = 			{1,{"Slippery sucker"}},			
	--	[_M.EVENT_IS_HIT] = 			nil,								
	--	[_M.EVENT_HP_DOWN] = 			nil,
		[_M.EVENT_DEATH] = 			{1,{"you.. have.. to.."}},			
		[_M.EVENT_REVIVED] = 			{1,{"My hero"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading virus"}},			
		[_M.EVENT_LOOT] = 			{1,{"Jackpot"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"Hold up"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"Got it covered"}},				
		[_M.EVENT_PIN] = 			{1,{"This one's pinned"}},		-- not used in game
	},

	[_M.engineer_1] = {
	
	--	[_M.EVENT_SELECTED] = 				nil,  	
		[_M.EVENT_ATTACK_GUN] = 			nil,  	
		[_M.EVENT_ATTACK_GUN_KO] = 			nil,  							
		[_M.EVENT_ATTACK_MELEE] = 			nil,  	
	--	[_M.EVENT_HIT_GUN] = 				nil,
	--	[_M.EVENT_HIT_GUN_KO] = 			nil,
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				nil,  	
	--	[_M.EVENT_IS_HIT] = 				nil,							
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				nil,  	
		[_M.EVENT_REVIVED] = 				nil,  	
		[_M.EVENT_HIJACK] = 				nil,  	
		[_M.EVENT_LOOT] = 				nil,  	
		[_M.EVENT_INTERRUPTED] = 			nil,  	
		[_M.EVENT_PEEK] = 				nil,  	
		[_M.EVENT_OVERWATCH] = 				nil,  	
		[_M.EVENT_PIN] = 				nil,  		
	},


	[_M.sharpshooter_1] = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"Almost time for a G and T dont you think?","What do you need, beautiful?"}},  
		[_M.EVENT_ATTACK_GUN] = 			{1,{"Lined up","In sights","gentle squeeze.."}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 			nil,  								
		[_M.EVENT_ATTACK_MELEE] = 			{0.1,{"Boring conversation anyway"}},		
	--	[_M.EVENT_HIT_GUN] = 				nil,
	--	[_M.EVENT_HIT_GUN_KO] = 			nil,
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{0.5,{"Guess that was a warning shot?","I.. uh.. missed."}},			
	--	[_M.EVENT_IS_HIT] = 				nil,								
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"I'm coming.. Rita.."}},			
		[_M.EVENT_REVIVED] = 				{1,{"Just in time"}},					
		[_M.EVENT_HIJACK] = 				nil,
		[_M.EVENT_LOOT] = 				{1,{"All boys need toys"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"Target ahead","Target sighted"}},			
		[_M.EVENT_PEEK] = 				nil,							
		[_M.EVENT_OVERWATCH] = 				{1,{"Setting up","doing what I do"}},				
		[_M.EVENT_PIN] = 				{0.3,{"Shouldn't I just..shoot him?","Taking prisoners isn't really my bag"}},		
	},
	
	[_M.stealth_2] = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"And I thought VillaBank was a hard job.","Keep moving"}},
		[_M.EVENT_ATTACK_GUN] = 			{0.3,{"Guns, I hate these things"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 			{1,{"I could get used to this","I'd leave ya an asprin if I had one"}},							
		[_M.EVENT_ATTACK_MELEE] = 			{1,{"Zappy would have been nice right now","Facing a lot of resistance right now"}},					
	--	[_M.EVENT_HIT_GUN] = 				nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 			{1,{"I could get used to this","I'd leave ya an asprin if I had one"}},			
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{1,{"Ok, ok, I'm learning","Dammit! Harder than it looks"}},		
	--	[_M.EVENT_IS_HIT] = 				nil,								
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"I guess.. I tried.. one too many."}},				
		[_M.EVENT_REVIVED] = 				{1,{"I owe you for that one."}},					
		[_M.EVENT_HIJACK] = 				{1,{"Just gotta bypass the.. Done!","Easy peasy","I wrote this code in Haiku","CPU, I own you","This console reaks of coffee","Knock knock little machine"}},		
		[_M.EVENT_LOOT] = 				{1,{"Who wants stuff?","Come to mamma"}},					
		[_M.EVENT_INTERRUPTED] = 			{1,{"Uh oh"}},					
		[_M.EVENT_PEEK] = 				nil,								
		[_M.EVENT_OVERWATCH] = 				{1,{"Holding here"}},				
		[_M.EVENT_PIN] = 				{0.3,{"Just stay there, buddy","It will go better for you if you don't move"}},	
	},

	[_M.engineer_2] = {
	
	--	[_M.EVENT_SELECTED] = 				{0.2,{"You're coming in clear","On the team"}},  
		[_M.EVENT_ATTACK_GUN] = 			{0.3,{"Clearing things up","Lets open they way"}},  
		[_M.EVENT_ATTACK_GUN_KO] = 			{1,{"Delivering toxin"}}, 		
		[_M.EVENT_ATTACK_MELEE] = 			nil,				
	--	[_M.EVENT_HIT_GUN] = 				nil,							
	--	[_M.EVENT_HIT_GUN_KO] = 			{1,{"Delivering toxin"}},			
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{1,{"Target is obscured!","Need a better angle"}},	
	--	[_M.EVENT_IS_HIT] = 				nil,							
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"I can't feel my.. "}},			
		[_M.EVENT_REVIVED] = 				{1,{"That really cleared things up."}},			
		[_M.EVENT_HIJACK] = 				{1,{"Installing virus"}},		
		[_M.EVENT_LOOT] = 				{1,{"Busted open","Secrets revealed"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"I've spotted something"}},					
		[_M.EVENT_PEEK] = 				nil,					
		[_M.EVENT_OVERWATCH] = 				{1,{"Ok, focused in"}},			
		[_M.EVENT_PIN] = 				{0.3,{"I shouldn't sit here long"}},		
	},

	[_M.sharpshooter_2] = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"Vil get it done.","zey vont get avay vit dis"}},  
		[_M.EVENT_ATTACK_GUN] = 			{0.3,{"With lethal force","Terminating"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 			{0.3,{"Tranquing","Knocking out the target"}},  
		[_M.EVENT_ATTACK_MELEE] = 			nil,					
	--	[_M.EVENT_HIT_GUN] = 				nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 			{1,{"Delivering toxin"}},				
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{1,{"Zey have cover"}},			
	--	[_M.EVENT_IS_HIT] = 				nil,							
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"Do svidanya..."}},				
		[_M.EVENT_REVIVED] = 				{1,{"Spasibo"}},				
		[_M.EVENT_HIJACK] = 				{1,{"Virus installed"}},			
		[_M.EVENT_LOOT] = 				{1,{"I have captured something"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"Wait!"}},					
		[_M.EVENT_PEEK] = 				nil,								
		[_M.EVENT_OVERWATCH] = 				{1,{"Covering this zone"}},				
		[_M.EVENT_PIN] = 				{0.3,{"I vill break you"}},			
	},
 	
------------

	mod_01_pedler = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"*Shall we proceed?*","*Do not waste my Time*"}}, 
		[_M.EVENT_ATTACK_GUN] = 			{1,{"*Such dirty work*","*A necessary unplesantry*"}},  
		[_M.EVENT_ATTACK_GUN_KO] = 			nil,  								
		[_M.EVENT_ATTACK_MELEE] = 			{0.5,{"*Enough with you!*","*Servo 3 is twitchy*"}},		
	--	[_M.EVENT_HIT_GUN] = 				nil,
	--	[_M.EVENT_HIT_GUN_KO] = 			nil,
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{1,{"*Servo 3 is twitchy*"}},			
	--	[_M.EVENT_IS_HIT] = 				nil,							
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"*Power ... empty..*"}},			
		[_M.EVENT_REVIVED] = 				{1,{"*Let's not do that again*"}},				
		[_M.EVENT_HIJACK] = 				{1,{"*Uploading virus*"}},			
		[_M.EVENT_LOOT] = 				{1,{"*I want to deconstruct this*"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"*I have complications*"}},				
		[_M.EVENT_PEEK] = 				nil,							
		[_M.EVENT_OVERWATCH] = 				{1,{"*This way is watched*"}},				
		[_M.EVENT_PIN] = 				{1,{"*Such dirty work","A necessary unplesantry*"}},			
	},

}

return DLC_STRINGS
