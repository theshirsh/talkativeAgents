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

	stealth_1 = 1,	-- Decker
	engineer_1 = 2,	-- Xu
	sharpshooter_1 = 3,	--Shalem
	stealth_2 = 4,	-- Banks
	engineer_2 = 5,	-- Internationale
	sharpshooter_2 = 6,	-- Nika
	cyborg_1 = 7,	-- Sharp
	disguise_1 = 8,	-- Prism
	
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

	-- Decker
	[_M.stealth_1] = {
	--	speechData = 				{0.2,{"You as ready as I am?","Like old times","Running silent"}},  
		[_M.EVENT_ATTACK_GUN] = 		{1,{"Here we go","Taking aim","He's about to catch some z's"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 		{1,{"Night night","Bed time","Lights out","Sweet dreams"}},  								
		[_M.EVENT_ATTACK_MELEE] = 		{1,{"Dig fast!","Like a sack of potatoes","Not much of a fight"}},					
	--	[_M.EVENT_HIT_GUN] = 			nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 		{1,{"Night night","Bed time","Lights out","Sweet dreams"}},				
	--	[_M.EVENT_HIT_MELEE] = 			{1,{"chump"}},						
	--	[_M.EVENT_KILL_GUN] = 			nil,
	--	[_M.EVENT_KILL_MELEE] = 		nil,
	--	[_M.EVENT_MISS_GUN] = 			{1,{"Slippery sucker"}},			
	--	[_M.EVENT_IS_HIT] = 			nil,								
	--	[_M.EVENT_HP_DOWN] = 			nil,
		[_M.EVENT_DEATH] = 			{1,{"You... have... to..."}},			
		[_M.EVENT_REVIVED] = 			{1,{"My hero","I'm getting too old for this","Doesn't mean I owe you squat"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading virus","Hmpf. Not as secure as they used to be"}},			
		[_M.EVENT_LOOT] = 			{1,{"Jackpot"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"Hold up"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"Got it covered","Like old times","I was born ready"}},				
		[_M.EVENT_PIN] = 			{1,{"This one's pinned","Do yourself a favor and stay down, pal"}},
	},

	-- Xu
	[_M.engineer_1] = {
	
	--	[_M.EVENT_SELECTED] = 				nil,  	
		[_M.EVENT_ATTACK_GUN] = 			{1,{"Aim and fire... simple enough","Hm, I don't suppose he'll be getting back up...","That ought to clear the air a bit","An unfortunate necessity"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 			{1,{"Excellent","He's down for the count","...Did I get him? Oh, there we go","I do believe I'm getting the hang of this","Yes!"}},						
		[_M.EVENT_ATTACK_MELEE] = 			{1,{"...And stay down!","Nothing like a little power surge","These things pack quite the punch","A-ha! Triumph"}},  	
	--	[_M.EVENT_HIT_GUN] = 				nil,
	--	[_M.EVENT_HIT_GUN_KO] = 			nil,
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				nil,  	
	--	[_M.EVENT_IS_HIT] = 				nil,							
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"I think I've been...","Oh, well, that's..."}},	
		[_M.EVENT_REVIVED] = 				{1,{"That was unpleasant.","Much appreciated"}},  	
		[_M.EVENT_HIJACK] = 				{1,{"Let's see what you're made of","I wish I could take my time with this","There's a certain elegance to their systems","Hmpf. Not much of a challenge...","They really make this too easy"}}, 	
		[_M.EVENT_LOOT] = 				{1,{"What do we have here?","Let's see what's inside","How curious...","Now that's interesting"}},
		[_M.EVENT_INTERRUPTED] = 			{1,{"Just a moment","Could be a problem"}},  	
		[_M.EVENT_PEEK] = 				nil,  	
		[_M.EVENT_OVERWATCH] = 				{1,{"Weapon primed","Monitoring the area","Leave this to me","Rest assured, I will handle it"}},
		[_M.EVENT_PIN] = 				{1,{"Enemy subdued","This one won't be going anywhere","Target pinned"}},  		
	},


	-- Shalem
	[_M.sharpshooter_1] = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"Almost time for a G and T dont you think?","What do you need, beautiful?"}},  
		[_M.EVENT_ATTACK_GUN] = 			{1,{"Lined up","In sights","Gentle squeeze..."}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 			{1,{"That won't keep him down forever","Not as permanent as I'd like","Hmpf."}}, 								
		[_M.EVENT_ATTACK_MELEE] = 			{0.1,{"Boring conversation anyway"}},		
	--	[_M.EVENT_HIT_GUN] = 				nil,
	--	[_M.EVENT_HIT_GUN_KO] = 			nil,
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{0.5,{"Guess that was a warning shot?","I.. uh.. missed."}},			
	--	[_M.EVENT_IS_HIT] = 				nil,								
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"I'm coming... Rita...","About... time..."}},			
		[_M.EVENT_REVIVED] = 				{1,{"Just in time","Hmpf. It was only a scratch"}},					
		[_M.EVENT_HIJACK] = 				nil,
		[_M.EVENT_LOOT] = 				{1,{"All boys need toys","Not bad","I get a cut of this, right?"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"Target ahead","Target sighted"}},			
		[_M.EVENT_PEEK] = 				nil,
		[_M.EVENT_OVERWATCH] = 				{1,{"Setting up","Doing what I do","Let them come"}},				
		[_M.EVENT_PIN] = 				{0.3,{"Shouldn't I just... shoot him?","Taking prisoners isn't really my bag"}},
	},
	
	-- Banks
	[_M.stealth_2] = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"And I thought VillaBank was a hard job.","Keep moving"}},
		[_M.EVENT_ATTACK_GUN] = 			{0.3,{"Guns, I hate these things","Do we really have to do this?","Sometimes I miss the solo gigs"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 			{1,{"I could get used to this","I'd leave ya an asprin if I had one","Believe me, buddy, I'm doing you a favor"}},							
		[_M.EVENT_ATTACK_MELEE] = 			{1,{"Zappy would have been nice right now","Facing a lot of resistance right now"}},					
	--	[_M.EVENT_HIT_GUN] = 				nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 			{1,{"I could get used to this","I'd leave ya an asprin if I had one"}},			
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{1,{"Ok, ok, I'm learning","Dammit! Harder than it looks"}},		
	--	[_M.EVENT_IS_HIT] = 				nil,								
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"I guess... I tried... one too many."}},				
		[_M.EVENT_REVIVED] = 				{1,{"I owe you for that one.","Not a dream, then..."}},					
		[_M.EVENT_HIJACK] = 				{1,{"Just gotta bypass the... Done!","Easy peasy","I wrote this code in Haiku","CPU, I own you","This console reeks of coffee","Knock knock little machine"}},		
		[_M.EVENT_LOOT] = 				{1,{"Who wants stuff?","Come to mamma","Do I really have to share this?"}},					
		[_M.EVENT_INTERRUPTED] = 			{1,{"Uh oh"}},					
		[_M.EVENT_PEEK] = 				nil,								
		[_M.EVENT_OVERWATCH] = 				{1,{"Holding here","Watching the way"}},				
		[_M.EVENT_PIN] = 				{0.3,{"Just stay there, buddy","It will go better for you if you don't move","I could sing you a lullaby while we're here"}},	
	},

	-- Internationale
	[_M.engineer_2] = {
	
	--	[_M.EVENT_SELECTED] = 				{0.2,{"You're coming in clear","On the team"}},  
		[_M.EVENT_ATTACK_GUN] = 			{0.3,{"I do not like this.","This is the only way","Count to three, pull the trigger...","Deep breath..."}},  
		[_M.EVENT_ATTACK_GUN_KO] = 			{1,{"Delivering toxin","Clearing things up","Let's open the way"}}, 		
		[_M.EVENT_ATTACK_MELEE] = 			nil,				
	--	[_M.EVENT_HIT_GUN] = 				nil,							
	--	[_M.EVENT_HIT_GUN_KO] = 			{1,{"Delivering toxin"}},			
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{1,{"Target is obscured!","Need a better angle"}},	
	--	[_M.EVENT_IS_HIT] = 				nil,							
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"I can't feel my... "}},			
		[_M.EVENT_REVIVED] = 				{1,{"That really cleared things up.","Thank you. I mean it."}},			
		[_M.EVENT_HIJACK] = 				{1,{"Installing virus","Let's see what their security is like","No obstacles encountered","Accessing their system"}},		
		[_M.EVENT_LOOT] = 				{1,{"Busted open","Secrets revealed","Time to redistribute","New assets acquired"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"I've spotted something","There's something here"}},					
		[_M.EVENT_PEEK] = 				nil,					
		[_M.EVENT_OVERWATCH] = 				{1,{"Ok, focused in","I will take care of it"}},			
		[_M.EVENT_PIN] = 				{0.3,{"I shouldn't sit here long","I suppose this is more merciful"}},		
	},

	-- Nika
	[_M.sharpshooter_2] = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"Vil get it done.","zey vont get avay vit dis"}},  
		[_M.EVENT_ATTACK_GUN] = 			{0.3,{"With lethal force","Terminating","Taking action"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 			{0.3,{"Tranquing","Knocking out the target","..."}},  
		[_M.EVENT_ATTACK_MELEE] = 			nil,					
	--	[_M.EVENT_HIT_GUN] = 				nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 			{1,{"Delivering toxin"}},				
	--	[_M.EVENT_HIT_MELEE] = 				nil,
	--	[_M.EVENT_KILL_GUN] = 				nil,
	--	[_M.EVENT_KILL_MELEE] = 			nil,
	--	[_M.EVENT_MISS_GUN] = 				{1,{"Zey have cover"}},			
	--	[_M.EVENT_IS_HIT] = 				nil,							
	--	[_M.EVENT_HP_DOWN] = 				nil,
		[_M.EVENT_DEATH] = 				{1,{"Do svidanya...","Ne... ne mogu..."}},				
		[_M.EVENT_REVIVED] = 				{1,{"Spasibo","They cannot stop me"}},				
		[_M.EVENT_HIJACK] = 				{1,{"Virus installed","Device hacked."}},			
		[_M.EVENT_LOOT] = 				{1,{"I have captured something"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"Wait!"}},					
		[_M.EVENT_PEEK] = 				nil,								
		[_M.EVENT_OVERWATCH] = 				{1,{"Covering this zone","Will get it done","Standing guard","Ready to intercept"}},				
		[_M.EVENT_PIN] = 				{0.3,{"I will break you","Stay down.","I have him","He will not move, trust me"}},			
	},
 	
------------

	mod_01_pedler = {
		
	--	[_M.EVENT_SELECTED] = 				{0.2,{"*Shall we proceed?*","*Do not waste my Time*"}}, 
		[_M.EVENT_ATTACK_GUN] = 			{1,{"*Such dirty work*","*A necessary unpleasantry*"}},  
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
		[_M.EVENT_DEATH] = 				{1,{"*Power... empty...*"}},			
		[_M.EVENT_REVIVED] = 				{1,{"*Let's not do that again*"}},				
		[_M.EVENT_HIJACK] = 				{1,{"*Uploading virus*"}},			
		[_M.EVENT_LOOT] = 				{1,{"*I want to deconstruct this*"}},				
		[_M.EVENT_INTERRUPTED] = 			{1,{"*I have complications*"}},				
		[_M.EVENT_PEEK] = 				nil,							
		[_M.EVENT_OVERWATCH] = 				{1,{"*This way is watched*"}},				
		[_M.EVENT_PIN] = 				{1,{"*Such dirty work","A necessary unpleasantry*"}},			
	},

	
	-- Sharp
	[_M.cyborg_1] = {
	--	speechData = 				nil
		[_M.EVENT_ATTACK_GUN] = 		{1,{"Nowhere to run, meatbag","This takes me back","Perfect execution","You should thank me","They always drop too quickly","Perish."}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 		{1,{"Pathetic.","Exploiting systemic vulnerabilities...","Foiled by a chemical","That was too easy"}},  								
		[_M.EVENT_ATTACK_MELEE] = 		{1,{"Hardly an opponent","No match for me","Frail excuse for an organic","Obsolete piece of meat"}},					
	--	[_M.EVENT_HIT_GUN] = 			nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 		nil				
	--	[_M.EVENT_HIT_MELEE] = 			nil					
	--	[_M.EVENT_KILL_GUN] = 			nil,
	--	[_M.EVENT_KILL_MELEE] = 		nil,
	--	[_M.EVENT_MISS_GUN] = 			nil			
	--	[_M.EVENT_IS_HIT] = 			nil,								
	--	[_M.EVENT_HP_DOWN] = 			nil,
		[_M.EVENT_DEATH] = 			{1,{"I refuse...","I am not... this... fragile...","Missed... me..."}},			
		[_M.EVENT_REVIVED] = 			{1,{"I didn't need your help","I was just resting"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading virus","Interfacing with a vastly superior being","Finally, some better company"}},			
		[_M.EVENT_LOOT] = 			{1,{"I have the goods","Accessing data"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"Stop","This changes things","Adapting"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"Armed and ready","They won't know what hit them","Prepared for perfection","Watch and learn","Time to make this look good"}},				
		[_M.EVENT_PIN] = 			{1,{"Ugh, I think it's still alive","Stop twitching!","Why am I wasting my time here?","This is humiliating","Do I really have to be touching him? Can't I just... no?"}},		

	},
	
	-- Prism
	[_M.disguise_1] = {
	--	speechData = 				nil 
		[_M.EVENT_ATTACK_GUN] = 		{1,{"Let's get this over with","Taking him down","Time to pay, pig","Roll credits","Oh yeah. He's down",}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 		{1,{"He's one of the lucky ones","I guess that's one way to deal with them","Oh yeah. He's down","Time for your nap"}},  								
		[_M.EVENT_ATTACK_MELEE] = 		{1,{"Corporate pig","This does make me feel better","How's that for a stunt?"}},					
	--	[_M.EVENT_HIT_GUN] = 			nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 		nil				
	--	[_M.EVENT_HIT_MELEE] = 			nil					
	--	[_M.EVENT_KILL_GUN] = 			nil,
	--	[_M.EVENT_KILL_MELEE] = 		nil,
	--	[_M.EVENT_MISS_GUN] = 			nil			
	--	[_M.EVENT_IS_HIT] = 			nil,								
	--	[_M.EVENT_HP_DOWN] = 			nil,
		[_M.EVENT_DEATH] = 			{1,{"No! I won't...","Can't... be..."}},			
		[_M.EVENT_REVIVED] = 			{1,{"They'll pay for that","Back in the floodlights","Think this could stop me? Watch.","Thanks, I guess"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading program","Siphoning the PWR","This device is ours now"}},			
		[_M.EVENT_LOOT] = 			{1,{"Good thing we stopped by","X marks the spot","My favorite moment","I'm sure they won't miss this","Not a bad haul"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"Hold it","What was that?"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"Sweet","They won't get past me","I'll show them","Time to dazzle"}},				
		[_M.EVENT_PIN] = 			{1,{"If you're smart, you won't wake up","I've got him under control","Got it. Enemy pinned","What now?","Already bored"}},		-- not used in game
	},
	
	
	-- Olivia
	[_M.olivia] = {
	--	speechData = 				nil 
		[_M.EVENT_ATTACK_GUN] = 		{1,{"Eliminating the target","Clean and precise","Enemy neutralized","That's one less for us to deal with"}},  	
		[_M.EVENT_ATTACK_GUN_KO] = 		{1,{"He's down. Let's not waste time","That ought to do it","Enemy neutralized","Clean and precise"}},  								
		[_M.EVENT_ATTACK_MELEE] = 		{1,{"He's dealt with.","Aggressor neutralized"}},				
	--	[_M.EVENT_HIT_GUN] = 			nil,								
	--	[_M.EVENT_HIT_GUN_KO] = 		nil			
	--	[_M.EVENT_HIT_MELEE] = 			nil						
	--	[_M.EVENT_KILL_GUN] = 			nil,
	--	[_M.EVENT_KILL_MELEE] = 		nil,
	--	[_M.EVENT_MISS_GUN] = 			nil			
	--	[_M.EVENT_IS_HIT] = 			nil,								
	--	[_M.EVENT_HP_DOWN] = 			nil,
		[_M.EVENT_DEATH] = 			{1,{"No! They mustn't...","You... bastard..."}},			
		[_M.EVENT_REVIVED] = 			{1,{"I'm... still alive? I suppose they've never had the best aim...","Only a minor setback","You have my thanks, agent","I've weathered worse than that"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading the worm","Subverting enemy tech","Another asset gained","Virus installed"}},			
		[_M.EVENT_LOOT] = 			{1,{"Well this should prove useful"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"Oh, bother"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"I'll keep a watchful eye","Readying my sights"}},				
		[_M.EVENT_PIN] = 			{1,{"I've got him pinned down","Under control"}},		-- not used in game
	},
	
	
	-- Derek - STILL HAS DECKER PLACEHOLDER LINES
	[_M.derek] = {
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
		[_M.EVENT_REVIVED] = 			{1,{"Ugh. Do I even get hazard pay?"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading virus"}},			
		[_M.EVENT_LOOT] = 			{1,{"Jackpot"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"Hold up"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"Got it covered"}},				
		[_M.EVENT_PIN] = 			{1,{"This one's pinned"}},
	},
	
	
	-- Draco -- STILL HAS DRACO PLACEHOLDER LINES - Data will help
	[_M.draco] = {
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
		[_M.EVENT_PIN] = 			{1,{"This one's pinned"}},
	},
	
	
	
	-- Rush
	[_M.rush] = {
	--	speechData = 				nil,  
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
		[_M.EVENT_DEATH] = 			{1,{"Like you could... stop me...","What? No...","I don't believe..."}},			
		[_M.EVENT_REVIVED] = 			{1,{"Let me at them!","They'll have to try harder than that"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading virus"}},			
		[_M.EVENT_LOOT] = 			{1,{"Jackpot"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"What's the hold-up?"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"Got it covered"}},				
		[_M.EVENT_PIN] = 			{1,{"...How long do I have to do this?","I'm not a babysitter","Enemy pinned. If that helps"}},	
	},
	
		-- Monst3r
	[_M.monst3r_pc] = {
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
		[_M.EVENT_PIN] = 			{1,{"This one's pinned"}},
	},	

	
			
			
		-- Central
	[_M.central_pc] = {
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
		[_M.EVENT_REVIVED] = 			{1,{"Back into the field","I will not be held back by the likes of this"}},					
		[_M.EVENT_HIJACK] = 			{1,{"Uploading virus"}},			
		[_M.EVENT_LOOT] = 			{1,{"Jackpot"}},					
		[_M.EVENT_INTERRUPTED] = 		{1,{"Hold up"}},				
		[_M.EVENT_PEEK] = 			nil,								
		[_M.EVENT_OVERWATCH] = 			{1,{"Got it covered"}},				
		[_M.EVENT_PIN] = 			{1,{"This one's pinned"}},
	},	
	
}

return DLC_STRINGS
