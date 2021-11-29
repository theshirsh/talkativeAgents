---------------------------------------------------------------------
-- Invisible Inc. MOD.
--
local _M =
{
--	name of speech event		-- Corresponding existing simdef EV or TRG
--	= value of existed EV/TRG on the right

	ATTACK_GUN = 8,			-- EV_UNIT_START_SHOOTING 
	ATTACK_MELEE = 30,		-- EV_UNIT_MELEE

	GOT_HIT = 57,			-- EV_UNIT_HIT, not trigger on Last Words
	REVIVED = 102,			-- EV_UNIT_HEAL
	HIJACK = 19,			-- EV_UNIT_USECOMP also EV_UNIT_WIRELESS_SCAN for Internationale's wireless hijack got sent here
	INTERRUPTED = 4,		-- EV_UNIT_INTERRUPTED
	PEEK = 18,			-- EV_UNIT_PEEK
	OVERWATCH = 27,			-- EV_UNIT_OVERWATCH
	OVERWATCH_MELEE = 28,		-- EV_UNIT_OVERWATCH_MELEE
	PIN = 111,			-- EV_UNIT_START_PIN -- unused in game --Not anymore -- added by Cyberboy2000 :)

	SAFE_LOOTED = 66,       	-- TRG_SAFE_LOOTED -- there's trigger used
	INSTALL_AUGMENT = 62,	
	DISGUISE_IN = 129,		-- for Prism's disguise -- currently also triggers when disguise is dropped
	CLOAK_IN = 614,			-- for activating cloak	

	WIRELESS_SCAN = 100,		-- solely for Wireless Emitter Nerf mod, won't trigger normally
	
-- next added for 'custom' events (sub-events?):

	ATTACK_GUN_KO = 1008,		-- for dartguns
	MEDGEL = 1009,			-- for using medgel on a downed agent
	SHOOT_CAMERA = 1010,
	SHOOT_DRONE = 1011, 

	PARALYZER = 1012,		-- Banks have test line		
	STIM_SELF = 1013,		-- Rush have test line		-- I just put some placeholders to test. Shirsh
	STIM_OTHER = 1014,		-- Shalem have test line
	SELF_STIMMED = 1015,		-- Rush have test line
	STIMMED_BY = 1016,		-- Rush have test line
	WAKE_OTHER = 1017,		-- Rush have test line
	AWAKENED_BY = 1018,		-- Shalem have test line

	EXEC_TERMINAL_LOOTED = 1019,	-- optional for Exec Terminals 	
	THREAT_DEVICE_LOOTED = 1020,	-- optional for looting FTM devices with tech (scanner and router)
	
	RESCUER = 1021,			-- agent who opens detention cell
	BAD_ESCAPE = 1022, -- Exit teleporter comments
	GOOD_ESCAPE = 1023,
	BLOODY_MISSION = 1024,
	ABANDONING_OTHER = 1025,
	SET_SHOCKTRAP = 1026,
	SAVED_FROM_OW = 2001, -- saved from guard, both currently unused
	AGENT_DEATH = 1027,
	OW_INTERVENTION = 1028, -- save someone from a guard who's on OW
	EVENT_SELECTED = 1029, --now used! fires once per mission per agent
	
-- agentIDs list:

-- 	NAME = agentID	-- just for convenience: agentID is a number or string, name is easier to use
--	DECK = 0, -- tutorial	

	DECKER = 1,		-- Decker
	SHALEM = 2,		-- Shalem
	TONY = 3,		-- Xu	
	BANKS = 4,		-- Banks
	INTERNATIONALE = 5,	-- Internationale
	NIKA = 6,		-- Nika
	SHARP = 7,		-- Sharp
	PRISM = 8,		-- Prism
	
--	monster_final = 99,	-- got sent to 100 by alpha_voice
	MONSTER = 100,		-- starting
--	central_final = 107,	-- got sent to 107 by alpha_voice
	CENTRAL = 108,		-- starting

	OLIVIA = 1000,
	DEREK = 1001,
	RUSH = 1002,
	DRACO = 1003,

	PEDLER = "mod_01_pedler",  -- MODS AGENTS
	MIST = "mod_02_mist",
	GHUFF = "mod_03_ghuff",
	N_UMI = "mod_04_n_umi",
	CARMEN = "carmen_sandiego_o",
	
	-- guard types for guard lines
	GENERIC = "type_guard",
	GENERIC_HUNTING = "type_guard_alerted",
	CFO = "type_cfo",
	SYSADMIN = "type_sysadmin",
	SCIENTIST = "type_scientist",
	DRONE = "type_combatdrone",

}

-- Speech chance  list
-- Can be edited here centrally to change the chance that line will fire for a specific trigger, for all agents.
-- If need be, agent-specific chances can still be tweaked by directly using a number there.

local p_selected = 1
local p_gun = 0.7
local p_gunko = 0.7
local p_melee = 0.6
local p_ow = 0.6
local p_gothit = 0.7
local p_revived = 0.8
local p_scan = 0.5
local p_hj = 0.2
local p_loot = 0.5
local p_inter = 0.5
local p_peek = 0.1
local p_pin = 0.5
local p_augm = 0.9
local p_cloak = 0.8
local p_medgel = 0.8
local p_rescuer = 0.8 --0.5
local p_shootcam = 0.8
local p_shootdrone = 0.8
local p_badescape = 1 -- 0.9
local p_goodescape = 1
local p_bloodymission = 1
local p_abandonedother = 1
local p_setshocktrap = 0.8
local p_savefromow = 0.9
local p_ow_saved = 1 --0.8 --unused
local p_agentdeath = 0.9


-- guard p values
local p_guard_generic = 0.4
local p_guard_generic_hunt = 0.3
local p_guard_cfo = 0.5 -- these NPCs are rarer so make theirs procc more frequently
local p_guard_admin = 0.5
local p_guard_sci = 0.5
local p_guard_drone = 0.3
local p_begging = 0.15


local DLC_STRINGS =
{	       	
	OPTIONS =
	{
		MOD = "Talkative Agents",
		MOD_TIP = "Agents will quip with one-liners when they complete certain actions", --"<c:FF8411>FOR AGENTS</c>\nDecker\nInternationale\nShalem 11\nBanks\nNika\nPedler",   
		GUARDS = "Talkative Guards",
		GUARDS_TIP = "Enables idle enemy chatter",
		GUARDS_ALERTED = "Alerted Guard Chatter",
		GUARDS_ALERTED_TIP = "Extra customisation for Talkative Guards option: Enables enemy chatter from hunting guards. Can be disabled if you find it too distracting when the heat is on.",
		FREQUENCY = "Oneliner chance multiplier",
		FREQUENCY_TIP = "Modifies how often agents and guards will speak up. Pick lower values if you feel the characters are speaking up too often.",
		FREQUENCY_STRINGS = {"0.1X","0.3X","0.5X","0.75X","1X (default)","1.5X","2X","Always trigger"},
		BURNT_TOAST = "Burnt toast mode",
		BURNT_TOAST_TIP = "Enables inanimate object chatter. Please don't take this seriously.",
						
	},
	
	-- guard oneliners and banters
	GUARDS =
	{
		LINES = {
		
			[_M.GENERIC] = {p_guard_generic,{
			"< grumble > Hate these night shifts...",
			"...Did I fill the bowl before I left? I must have. \n < sigh > Two hours down, nine to go...",
			"< Yawn > ",
			"Huh? \nDamn rats.",
			"I can't believe I still have to work here...",
			"...Does this gun even work? \nBetter not glitch out on me.",
			"... \nQuiet tonight...",
			"Bored...",
			"Did I hear something? Hmm, better not be rats.",
			"...",
			"< Sigh > Just a couple more months.",
			"Hmm, I better check the cams again.",
			"Why am I here? I might as well just stand there and stare at a wall for all the good I'm doing...",
			"< grumble > ...should quit and go back to school.... < grumble >",
			"I should bring my bonsai plant from home. Liven the place up a little...",
			"That was weird. Thought I heard something. \n...Benny? Is that you?",
			"< whistles >",
			"Mmh-hmm... never gonna let you down... Hmm-hmmm... never gonna run around and... desert you...",
			"Damn noises. Stupid cheap building...",
			"Was that door open before, or closed? I can't remember...",
			"Shit. Where did I put my contacts? They were in my pocket, weren't they? Damn...",
			"Can't wait to get home... Put my feet up...",
			"I wonder what's for dinner tonight...",
			"Shift's nearly over. I could go for a coffee... or just straight to bed...",
			"< grumble > Wish I had coffee... Guess the smokes will have to do...",
			"Ten minute break soon. Those noodles better still be where I left them...", --new batch starts here
			"Hope McMurry's still open when I finish my shift...",
			"I need to take Spencer on a walk when I get back. Poor guy's been cooped up all day...",
			"I better get my paycheck before the rent is due...",
			"I wonder if there's any new holovids lately...",
			"...Did I leave the lights on back home? Dammit...",
			"I... think my oven's still on.",
			"Maybe I should just them I'm quitting. I'll do it today, for sure...",
			" < sigh > Sometimes I wonder if the benefits are worth it...",
			"Okay, first day... Deep breath... positive attitudes...",
			"Roger better not have stolen my lunch again. I swear, we get fridge slots for a reason...",
			"Shit. I hope I don't end up like Morgan...",
			"...Did I hear something? \nMust have been the wind...",
			"I wonder when they'll give me my real arm back.",
			"Damn cheap building... stupid thin walls...",
			"Just two more months and I can afford a new phone.",
			"All this overtime, when I should be there for dad... Paid leave can't come soon enough...",
			"Damn contract... just fire me already...",
			"This decor is awful. Do they have no sense of aesthetic?",
			"This decor isn't bad.",
			"< shudder > Damn drones... Those things creep me out.",
			"At least I'm indoors.",
			"Damn genecode nearly killed me...",
			"Hey, where'd my sandwich go?",
			"I need a coffee I.V. for this job.",
			"I wonder if there's even anyone on the other end of those cameras... Always watching...",
			"Uhhh. Why'd I even sign up for that sweep...",
			"I swear one day I'll drop dead on my shift and no one will even remember me...",
			"Where'd my pack of cigs go? I swear I'd pocketed it earlier...",
			"< ZAP > Arghhhh! Stupid heart monitor...",
			"Crap, where'd all the Pidgeys go?",
			"Shit. There was a Jolteon *right there*...",
			"< sniff > \n...My shirt smells... Cheap dry cleaning... All this stuff on my skin...",
			"Ugh. Who farted?",
			"I could use a drink right about now...",
			"Sky must be pretty right now... Wish I was outside...",
			"How fire-safe is the building? Probably shouldn't think about that...",
			"Ughh. Probably shouldn't have eaten that sandwich...",
			"My feet are killing me...",
			"Would it kill them to put a few chairs in here... Can't spend all night on my feet... Not healthy...",
			"Third day on the job. Still can't find the bathrooms on this floor...",
			"I miss the beach.",
			"I hope this place isn't bugged...",
			"Can't wait to catch up when I'm home... I swear, the leaks better not be true...",
			"I hate ketchup.",
			"Brrrr. What is it with the AC in this building?",
			"What page of 'Homemade Crafts for Dummies' was I on before?",
			"Damn Jimmy... spoiled the entire show for me... Hope he gets shot... Okay, no, that's too harsh...",
			"This uniform is so itchy...",
			"Where'd my wallet go?",
			"I wonder if they've've fixed that leaky pipe yet.",
			"Stop complaining, Jake... 'Oh, the dental in this job sucks!' At least you have a job...",
			"I swear the Financial guy smelled like eggs...",
			"I wish I'd picked the day shift instead.",
			"I ought to ask for a raise...",
			"I smell funny... Should take a bath when I get home...",
			"I want ice cream...",
			"At least they actually pay me at this job...",
			"I could go for a burger right now...",
			"Forgot my insulin... Ugh, this is gonna be a long shift...",
			}},
			
			[_M.GENERIC_HUNTING] = {p_guard_generic_hunt,{
			"Finally, some action!",
			"Yes! I get to use my gun for once!",
			"Time to get the heart pumping!",
			"Oh, I've been waiting for a good fight!",
			"This place must be like a maze to them...",
			"No visual on the infiltrators.",
			"I lost them... Damn it!",
			"How'd they disappear that fast?!",
			"Show yourselves!",
			"They must have some kind of cloaking device...",
			"Come out or... or I'll keep searching for you!",
			"Where are you?!",
			"Give it up! It'll save us both some time!",
			"Maybe the other guys will find them...",
			"First one that pops the spies gets a bonus!",
			"Uh... Come out! We'll find you anyway!",
			"You'd better come out now! \n\n...Hello?",
			"Don't be stupid. Just give yourselves up, and we'll take you into custody...",
			"I know you're in here!",
			"I'm giving you one chance. Drop any weapons and come out slowly, now!",
			"I better get my hazard pay for this.",
			"So much for a quiet night, godammit."
			}},
			
			[_M.DRONE] = {p_guard_drone,{	--new!
			" *Detecting a temperature rise of 0.02 degrees Celsius.* ",
			" *Weapons: Operational.* ",
			" *Internal grime detected. Maintenance required.* ",
			" *Unverified signature detected. Probability of rats: 92%. Ignoring...* ",		
			" *Charge at 86%. Status: Operational.* ",
			" *Electromagnetic interference detected. Caution advised.* ",
			" *Plasma signature detected. Caution advised.* ",
			" *Warning. Network intrusion detected.* ",
			" *Analysing surroundings. Threats: Null.* ",
			" *Service limit passed. Maintenance recommended.* ",
			" *Software trial period expired. Please contact a representative to purchase a license.* ",
			" *Analysing surroundings. Threat level: Normal.* ",
			" *System update downloaded. Installing...* ",
			" *Update installed. Enhanced hunting protocols initiated.* ",
			" *Turn #11: Bishop to F5. Awaiting response from Security Personnel #HK254. All possible counters calculated.* ",
			" *New San-Cake OS update available. Unit reboot is required to finish installing the update.* ",

			}},
			
			[_M.CFO] = {p_guard_cfo,{
			"Hmm, the returns from the last quarter... This is good, isn't it? I'm sure it's good...",
			" Ah-ahem. Good day, sir, I appreciate you taking the time. I wanted to discuss my recent... \nNo, that's too formal, what am I thinking?",
			"These numbers are no good. < sigh > I'll have to sell my yacht at this rate...",
			"Can't believe they left me out of the message chain... better not be promoting that bastard behind my back...",
			"...Did anyone else hear that? \n...Just me, then.",
			"I need to stop wasting time and finish this. What am I doing?",
			"Five more hours, I've still got five more hours... Who needs sleep, anyway?",
			"...Meeting's in the morning. That's fine. I've got plenty of time.",
			}},
			
			[_M.SYSADMIN] = {p_guard_admin,{
			"...Did I run the update? I should do that before I leave...",
			"Feels like something weird is going on tonight. Hope nobody jumps me...",
			" < Yawn > I can't believe it's so late...",
			"I'm going to ask for that promotion... Yeah, I'll do it this week, for sure...",
			"I wonder if they even appreciate the work I do...",
			"Ugh, feels like I'm being watched again. Don't think about it, don't think about it...",
			"Air's so dry here. These damn vents...",
			"< grumble > How did I get stuck on the night shift, anyway...",
			"Let's see... Cameras, check, database, check... what's that? Huh. That's a bit weird...",
			"That's a weird-looking signal. Firewall's fine, though. Must have been a false positive...",
			"Did someone tamper with the main firewall? I should be on guard, just in case...",
			"That's not right. I'd better run a diagnostic...",
			"Strange. Alarm keeps ticking up, but what tripped it? Must be a glitch...",
			}},
			
			[_M.SCIENTIST] = {p_guard_sci,{
			"Hmmm? \nThought I heard a sound...",
			"If I apply the Chi square test, maybe I can... hmm...",
			"That's strange. Where did I put those notes? They have to be here somewhere...",
			"< Yawn > I should probably call it a night soon...",
			"At this rate, maybe I can retire soon. < sigh >",
			"Can we make this work? The budget is already so tight... < sigh >",
			"What time is it? \n...I suppose that means I've missed his birthday again...", 
			"...Who took down these results? This is a mess.",
			"Hmmm, between the two peaks, is that a signal? \n...Oh, just a coffee stain...",
			"I hope it stays quiet... I'd hate to be trapped here on lockdown again.",
			"Sometimes I wonder why I took this job... No, I shouldn't think like that.",
			"Oh. Now this is interesting. If we run a multicomponent analysis here, then...",
			}},
		
		},
		-- oneliners when you attack an enemy --unused
		BEGGING = { p_begging, {
		"No, please!",
		"Don't-",
		"No-",
		"Please, I don't want to-",
		"Aaaagh!",
		"Wait! N-no...",
		"Wh-who are... you...",
		"Please! Stop...",
		
		}},
		
		BANTERS = {
		
			{"Did you get that last memo?",
			"Yeah. Bring Your Kid to Work Day is cancelled, right? Can't say I'm too upset.",
			"That's because you're a childless misanthrope. Jake was looking forward to checking this place out, you know.",
			"There's always next time.",},

			{"You okay?",
			"Just jittery. Damn coffee machine is broke.",
			"Heh, getting the shakes already? Hang in there, man.",
			"Shut up.",},

			{"I have breath mints. You want some?",
			"What are you getting at?",
			"Nevermind.",},

			{"How's Molly? You picking out names yet?",
			"Good, she's good. Um, not yet. We don't want to jinx it, you know? After last time...",
			"Yeah, uh... I'm sorry.",
			"It's fine, man...",},

			{"Hey. You wanna see a funny pic?",
			"Sure. Just keep your voice down, okay?",
			"Sorry, man. Okay, so a friend of mine sent me this parrot holofeed...",},

			{"Hey. I trained my cat to fetch yesterday, and I got it on film. Wanna see?",
			"< sigh > Send it over.",},
			
			{"Stop looking at your phone. We've got a job to do.",
			"Get off my back, Gary...",},

			{"You ever feel like you're being watched?",
			"You're just paranoid.",
			"If you say so...",},

			{"Place gives me the creeps, this time of night.",
			"You think it's haunted? \n...Oh shit, did you see that? That door opened by itself!",
			"You think you're so funny...",},

			{"You ever think about what we're missing out on, stuck in the rat race?",
			"No.",
			"Oh, good... Uh, me neither.",},

			{"What was that? Sounded like a, a sound of some kind.",
			"Really? Shit. Guess we won't be making it to retirement, then.",
			"I was being serious, Pete...",},

			{"I should have become a writer.",
			"That's rich.",
			"You'll see. I'll write a book one day. \"A Security Guard's Life\". It'll be a hit.",
			"Can't wait.",},

			{"Shit, I'm hungry...",
			"I think there's still some year-old pudding left in the office freezer.",
			"On second thought...",},

			{"Hey, you okay? You're looking a little off, man.",
			"< cough > It's fine. Not like I can take a sick day, anyway.",
			"Whatever. Just don't get it on me.",},

			{"Achoo!",
			"Bless you.",
			"Thanks.",},

			{"I hate these patrols.", 
			"Couldn't imagine why.",
			"I wonder what upper management is thinking sometimes. Would you believe I had to stare at a wall yesterday for five hours straight?",
			"Less whining, more patrolling.",},

			{"Were you smoking just now?",
			"What? That's none of your business.",
			"Smoking kills, you know. It's the number two cause of premature mortality.",
			"Not for us, it's not...",},

			{"Who were you on the phone with just now?",
			"< sigh > The police.",
			"Shit, really?",
			"It's my sixteen-year-old. It's fine. I'll just have to bail her out in the morning...",},

			{"I think I heard something. In the vents.",
			"In the vents? They're too small to climb through. You've been watching too many holos, man.",
			"Could be an pigeon. Or a genetically-engineered assassin who can dislocate his shoulders to fit through.",
			"...Like I said, too many holos.",},

			{"Do you ever think about how there's no fire escapes anywhere?",
			"I am now, thanks.",
			"What happens if there's a fire?",
			"Relax. You'll die of smoke inhalation long before the fire gets to you.",
			"Uh... thanks.",},
			
			{"Shit! My wedding band! Where is it?!",
			"Calm down. It probably just fell off somewhere. Cleanbots must have picked it up by now.",
			"What would they do with it?",
			"Toss it in the incinerator, probably.",
			"Well that doesn't help!",},

			{"Hell yeah! New season of GAT came out today.",
			"What was that? Global Action Team?",
			"Yeah, there's a guy in a hazmat suit and a chick with dolphins and a-",
			"That's kid stuff, man. Next thing I know, you'll be patrolling with a toy gun.",
			"It's really good, Tim!",},

			{"I hope my heart monitor doesn't act up again.",
			"So what? Just a false alarm. Wasn't your fault.",
			"But what if it, like, stops my heart or something?",
			"Pretty sure it can't. But just to be safe, dibs on your gaming rig.",},

			{"Why do we even have these passcards?",
			"Huh?",
			"Like why can't they just put it in our chips.",
			"Because they're cheap, that's why.",},
			
			{"You sure these drone things can't hear us? Damn spyware is everywhere these days.",
			"If you want to find out, try telling them what you think of middle management.",
			"I'd rather not.",},			
		},
	
		BANTERS_HUNTING = {
			{"Careful, these people are armed.",
			"With what?",
			"Worst case scenario, a flurry gun.",
			"Dear god...",},

			{"You check this way, I'll look over here.",
			"Hey! Who says you get to give the orders?",
			"You want to get whacked by these intruders?",
			" < Muttering > ",},

			{"You're saying you can't find them?!",
			"Yep.",
			"And they're still somewhere on this floor?",
			"Yep!",
			"And that we might get shot any second?!",
			"YEP.",
			"\n..."},

			{"The enemy is here!",
			"I know that!",
			"Then why aren't you searching for them?",
			"I am!",
			"Then search harder!",},
			
			{"Hey, did you hear that?!",
			"That's just the AC! Dammit, Tony, I'm jumpy enough as it is!"},

			{"Maybe they already left the building.",
			"Don't be stupid. They're still here!",
			"How can you be sure?",
			"They're listening to us right now. I can tell!",
			"I always get stationed with the weird ones...",},
			},
			
			{"Come on, look alive over here! We've got intruders on site!",
			"No need to yell, I already know that...",},
			
			{"They're still in the building! Look sharp!",
			"You don't have to tell me twice!",},
			
	},
	
	HOSTAGEQUIPS = {
		
		[_M.DRACO] = {"The night, honed into deadly purpose.","Your saviour."},
		[_M.SHALEM] = {"I could tell you, but then I'd have to kill you."},
		[_M.RUSH] = {"The answer to your prayers."},
		[_M.DEREK] = {"Don't look at me, I'm just here for the sweet, sweet cash."},
		[_M.OLIVIA] = {"No time to explain. Follow my lead."},
		[_M.INTERNATIONALE] = {"We're here to help. Let's get you out of here."},
		[_M.BANKS] = {"Come to cut the knots.","You can trust me, I'm a thief."},
		[_M.NIKA] = {"Quiet. Come with me.","..."},
		[_M.CENTRAL] = {"Right now, we're your best and only chance.","It's best for you if you don't find out."},
		[_M.MONSTER] = {"Come with me if you want to live, is how I believe the saying goes..."},
		[_M.SHARP] = {"This sack of pus isn't worth my time."},
		[_M.DECKER] = {"Well, pal, we'd be the cavalry."},
		[_M.TONY] = {"Who is anyone, really?","A fascinating question. Let's table it for later."},
		[_M.PRISM] = {"Right now, we're the good guys."},
		
	},
	

	-- Decker
	[_M.DECKER] = {
		[_M.EVENT_SELECTED] = 	{p_selected,{"Yeah, yeah. I hear you."," < sigh > Contact confirmed.","You better have a plan.","Comms are up. We're in.","This better not go like that job in Dubai.","Here we go.","I need a sip for good luck. Don't tell the boss, will ya?", " < grunt > Well, here we go.","Damn. Brings back memories.","Let's get this over with."}},  
		[_M.ATTACK_GUN] = 		{p_gun,{"Here we go.","Taking aim.","Hands are still steady. That's gotta count for something, right?"}},  
		[_M.SHOOT_DRONE] =		nil,  
		[_M.SHOOT_CAMERA] =		nil,  
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Night night.","Bed time.","Lights out.","Sweet dreams.","He's about to catch some z's."}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Dig fast!","Chump.","Like a sack of potatoes.","Not much of a fight.","Might put some ice on that, pal.","Looks like the old dog still knows a few tricks."}},					
		[_M.OVERWATCH] = 		{p_ow,{"Got it covered.","Like old times.",}},				
		[_M.OVERWATCH_MELEE] =		nil,
				
	--	[_M.EVENT_HIT_MELEE] = 		{1,{"chump"}},		
	--	[_M.EVENT_MISS_GUN] = 		{1,{"Slippery sucker"}},	
		[_M.GOT_HIT] = 			{p_gothit,{"You... have... to..."}},			
		[_M.REVIVED] = 			{p_revived,{"My hero.","I'm getting too old for this.","Doesn't mean I owe you squat."}},	
				
		[_M.HIJACK] = 			{p_hj,{"Uploading virus.","Hmpf. Not as secure as they used to be."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Jackpot.","That's better."}},
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,	
				
		[_M.INTERRUPTED] = 		{p_inter,{"Crud.","< sigh >","Oh, great."}},				
		[_M.PEEK] = 			{p_peek,{"Just a quick look.","Scouting the way."}},								
		
		[_M.PIN] = 			{p_pin,{"This one's pinned.","Do yourself a favor and stay down, pal.","Not much of a talker, are you."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Still human.","Flood myself with metal.","The future will drown us all.","Another one? Starting to lose count."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Running silent.","In the old days, they'd have burned me as a witch.","Right into thin air.","Whoosh..","And gone.","This thing's more useful than most of the people I work with."}},
		[_M.MEDGEL] =			{p_medgel,{"Typical, really.","Think you can pack it this time?","< Sigh >","Quiet. Job ain't over.","Heads up, we're still on the clock.","Don't mention it.","You need to pick up the slack."}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Pack your bags, pal.","You coming, or what?","Looks like today's your lucky day."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"We got away this time.","Let's get the hell out of here.","I'm gonna need a drink after this shit.","Why don't it ever go smooth?","...","Well, dammit.","I've seen worse.",}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Finally. I need a drink.","Not too bad, I suppose.","Could have gone worse.","Ha. Cakewalk.","Time for a drink.","Let's leave.","Where's my flask?","Godspeed.",}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"Any chance we could split the cleanup on that?","Ugh. I need a drink.","Just like old times, eh...","These men were poorly trained. Not our fault.","Back when I was on the job this mess would have caused an uproar.","They were all too slow.",}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"Poor sod.","Should have packed a spare bullet.","So much for that.","At my old job we used to call that \"high employee turnover\".","Corps ain't too friendly to intruders these days.","Stay put. We'll be back.","Let's hope that their neural probes are worse at digging up dirt than I remember.","...I'm sorry.",}},
		[_M.OW_INTERVENTION] =	 {p_savefromow,{"< Sigh >","Don't mention it.","Buy me a drink later.","Easy on the trigger there, pal.","Nobody holds my team at gunpoint. Except me, maybe.","Don't make me bail you out again.","Staring down the barrel, huh? Trust  me, we've all been there.","You ever heard about stealth, pal?","The trick is to not let them see you."}},
		[_M.SAVED_FROM_OW] =	 {p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"I'll raise a glass to ya. Soon as I get one.","Aw, hell.","So much for that."," <sigh> "}},
	},

	-- Xu
	[_M.TONY] = {
	
		[_M.EVENT_SELECTED] = 	{p_selected,{"Contact established, Operator.","I hear you, Operator.","You're coming in clear.", "Hmm? Ah yes. So what's the first move?","You have my attention. Use it well.","Let us get to it!","I can't wait to begin.","This should be interesting.","I am ready.","Active.","How are you, Operator?"}},  
		[_M.ATTACK_GUN] = 		{p_gun,{"Aim and fire... simple enough...","Hm, I don't suppose he'll be getting back up...","That ought to clear the air a bit.","An unfortunate necessity."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Excellent.","He's down for the count.","...Did I get him? Oh, there we go.","I do believe I'm getting the hang of this.","Yes!"}},						
		[_M.ATTACK_MELEE] = 		{p_melee,{"...And stay down!","Nothing like a little power surge.","These things pack quite the punch.","A-ha! Triumph.","< huff > Got him!"}},  	
		[_M.OVERWATCH] = 		{p_ow,{"Weapon primed.","Monitoring the area.","Leave this to me.","Rest assured, I will handle it."}},
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"I think I've been...","Oh, well, that's..."}},	
		[_M.REVIVED] = 			{p_revived,{"That was unpleasant.","Much appreciated.","Ngh. Is that my blood?"}},  	
		[_M.HIJACK] = 			{p_hj,{"I don't suppose I could get five minutes with this? ...No?","Let's see what you're made of.","I wish I could take my time with this.","There's a certain elegance to their systems.","Hmpf. Not much of a challenge...","They really make this too easy.","This takes me back."}}, 	
		[_M.SAFE_LOOTED] = 		{p_loot,{"What do we have here?","Let's see what's inside.","How curious...","Now that's interesting.","This will come in handy.","Would you look at that?"}},
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Could be a problem.","Not ideal.","Er. Hello..."}},  	
		[_M.PEEK] = 			{p_peek,{"Information is key.","Let's not charge in blindly.","Scouting area.","Surveying the room."}},  	
		
		[_M.PIN] = 			{p_pin,{"Enemy subdued.","This one won't be going anywhere.","Target pinned.","I hope you're comfortable.","I have it under control."}},  
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I cannot wait to use this.","This seems promising.","I've always wanted to try that.","Still more human than some people I could name.","Efficiency improved.","I'll tinker around with this later."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Too bad this won't last for long.","That's some incredible tech.","I could get used to this.","The tricky part is not tripping over yourself.","It's a shame I didn't have this years ago.","You know, Clark's third law says that... Alright, maybe now is not the time","And for my next trick..."}},	
		[_M.MEDGEL] =			{p_medgel,{"Good as new.","Are you alright?","Quiet! We're still in the field.","Welcome back."}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		{0.5,{"This better not become a habit.","Whatever gives us the edge on them."}},
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"No time for pleasantries, I'm afraid.","Are you ready? Let's not linger.","I'm sure you'll be happier outside. Follow me.","Let's put this unpleasant place behind us.","You look like you could use some fresh air."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"That probably could have gone better.","That was, ah, tense.","An uncomfortably close call.","That was eventful."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"This went well.","Excellent. We did quite well, don't you think?","Central should be pleased.","I'm a bit winded. I'm looking forward to a nice long break before the next job.","Finally. Now I can get back to tinkering with my equipment."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"Quite the body count there...","Perhaps the white shirt was a mistake today.","That turned out bloody.","It's not that I sympathise with the enemy, but... was all that really necessary?"}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"Ah, I wish it hadn't gone like this...","Pity we weren't able to make it out with everyone we came in with."}},
		[_M.SET_SHOCKTRAP] =		{p_setshocktrap, {"This should be interesting.","Never gets old.","Someone's in for a... shock.","This reminds me of simpler times.","Let's amp up the current situation.","A little surprise.","They ought to place more failsafes on their doors.","Now I just need to not forget that it's there.",}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"You're welcome!","Not so fast.","Gotcha.","You okay there?"}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"Er, thank you.","I appreciate that."}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"I fear our odds may have just plummeted.","Could this have been prevented? No, I mustn't think of that now."}},		
	},


	-- Shalem
	[_M.SHALEM] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Operator. Always a pleasure.","What do you need, beautiful?","You're coming in clear.","Go ahead.","Let's make this one clean.","Hm?","What now?"}},  
		[_M.ATTACK_GUN] = 		{p_gun,{"Lined up.","In sights.","Gentle squeeze...","End of the line.","Keeping it clean."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"That was a half-measure.","He's out. For now.","That won't keep him down forever.","Not as permanent as I'd like.","Hmpf."}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Boring conversation anyway.","That's one less.","I think he sprained something.","He'll be fine. The floor broke his fall."}},		
		[_M.OVERWATCH] = 		{p_ow,{"Setting up.","Doing what I do.","Let them come.","Here we go.","I'm ready."}},				
		[_M.OVERWATCH_MELEE] =		nil,
	
	--	[_M.EVENT_MISS_GUN] = 		{0.5,{"Guess that was a warning shot?","I.. uh.. missed."}},	
		[_M.GOT_HIT] = 			{p_gothit,{"I'm coming... Rita...","About... time...","Not gonna just..."}},			
		[_M.REVIVED] = 			{p_revived,{"Just in time.","Hmpf...","...\nThanks."}},					
		[_M.HIJACK] = 			{p_hj,{"Uploading virus.","You're wasting me on this?.","A monkey could do this.","The device is ours now.","Finally. What I've always trained for.","Give me a trigger, not a button."}},
		[_M.SAFE_LOOTED] = 		{p_loot,{"All boys need toys.","Not bad.","I get a cut of this, right?"}},	
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,
			
		[_M.INTERRUPTED] = 		{p_inter,{"...","Mnh. Complication."}},			
		[_M.PEEK] = 			{p_peek,{"No surprises.","Searching for hostiles.","Scouting ahead.","Active recon."}},
		
		[_M.PIN] = 			{p_pin,{"Shouldn't I just... shoot him?","Taking prisoners isn't really my bag.","...So how's your pension plan?","This could get dull.","Target subdued.","I've got him pinned."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"So long as it's useful.","This better work.","This better not slow me down.","More metal or less, it doesn't change anything.","Whatever it takes to win."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Hidden.","Seems a bit like cheating, doesn't it?","Cloaked.","Better not get too used to this."}},
		[_M.MEDGEL] =			{p_medgel,{"Try to stay on your feet this time.","Eyes sharp now.","We're not done here yet.","By all means, take your time...","Don't take it personally.","Get up. We need to move."}},
		[_M.WAKE_OTHER] =			nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil, --{1,{"Try this."}}, -- sorry had no better ideas
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil, --{1,{"I... uh..."}}, -- sorry had no better ideas
		[_M.RESCUER] = 			{p_rescuer,{"Oh, you. What was your name again?","Try to make yourself useful...","We're breaking you out. Come along."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Hmph. Well, we're still standing. That makes it a successful job in my books.","That was a mess and a half.","So much for putting on our best show."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Almost time for a G and T, don't you think?","This is what happens when everyone pulls their weight.","Not bad. We may actually survive at this rate."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"My suit will need some dry cleaning after this.","...Is that blood? This better come off...","Reminds me of some rougher jobs.","Rather sloppy. In my day, people valued finesse."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"Ruthless, hm? I can live with that.","Well. Suppose we're a bit more short-handed now.","I suppose the jet was starting to get crowded, anyway."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"Don't take it personally.","Just doing my job...","Too slow.","Rescues cost extra, just so you know.","So much for us not getting spotted.","Next time, I might not be there to save your skin."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"There are worse ways to go.","Part of the job."}},		
	},
	
	-- Banks
	[_M.BANKS] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Where to?","Hey there, other voice in my head.","Hope this one goes smooth.","Alright then. Give me the stuff.","Tell me what's what.","Hmm? Oh right, right, the mission.","Okay, great, I read you. At least I assume that's what's going on.","I've done a lot of jobs. Don't make this my last, okay?","Make it good.","What do you got for me?","Dia Duit.","Hello, Operator!","What will it be?"}}, 
		[_M.ATTACK_GUN] = 		{0.3,{"Guns, I hate these things.","Do we really have to do this?","Sometimes I miss the solo gigs."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"I could get used to this.","I'd leave ya an asprin if I had one.","Believe me, buddy, I'm doing you a favor.","He's down.","I've got him.","He's tranquilized.","He's still awake? Oof. No, there we go.","Yup. He's gonna have a headache.",}},							
		[_M.ATTACK_MELEE] = 		{p_melee,{"Zappy would have been nice right now.","Facing a lot of resistance right now.","Down he goes!","Aaagh... everything's under control.","Sparkly.","How about you rest for a while?","Take a little break, okay?","Shhhhhh."}},					
		[_M.OVERWATCH] = 		{p_ow,{"Holding here.","Watching the way.","I'm on it.","I'm ready, I'm ready.","Okay..."}},				
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"I guess... I tried... one too many.","Doesn't... hurt... at all...","Had... a good run","It'll... be okay..."}},				
	--	[_M.EVENT_MISS_GUN] = 		{1,{"Ok, ok, I'm learning","Dammit! Harder than it looks"}},	
		[_M.REVIVED] = 			{p_revived,{"I owe you for that one.","Not a dream, then...","How many lives left?","Owww.","Mmm, guava.","Aaugh! I'm up, I'm up!"}},					
		[_M.HIJACK] = 			{p_hj,{"Just gotta bypass the... Done!","Easy peasy.","I wrote this code in Haiku.","CPU, I own you.","This console reeks of coffee.","Knock knock little machine.","Ooh, this still has Minesweeper."}},		
		[_M.SAFE_LOOTED] = 		{p_loot,{"Who wants stuff?.","Come to mamma.","Do I really have to share this?","I love this part.","Nice!","Oh yeah, here we go.","Sweet.","Got the booty!","Not too shabby."}},	
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,
				
		[_M.INTERRUPTED] = 		{p_inter,{"Uh oh.","Uh, this isn't what it looks like?","...Hi there..."}},					
		[_M.PEEK] = 			{p_peek,{"I see them, but they don't see me.","Swift and silent.","I know what lies in wait.","I see the way ahead.","Crap, they saw me- Ok nevermind, I'm good."}},								
		
		[_M.PIN] = 			{p_pin,{"Just stay there, buddy.","It will go better for you if you don't move.","I could sing you a lullaby while we're here.","Feel free to stay down."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Will this fix me?","Another one.","I can hear it inside me.","This will keep me company.","We're all just automatons in the end.","Two lefts can make a wrong."}},						
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Invisible, intangible, I have become air.","Into nothing I return.","Light as a feather.","...Am I a ghost?","I can't see my- Oh. I forgot.","A puca now roams these halls.","I vanish."}},
		[_M.MEDGEL] =			{p_medgel,{"Shh. Just let them sew you up.","Easy there, buddy.","You okay?","Wow, that's a lot of blood.","I'm sure you'll be fine!","You'd do the same for me, right?","Don't worry, I've got you.","Does that hurt?","Don't worry. The pain is how you know it worked."}},
		[_M.WAKE_OTHER] =				nil,
		
		[_M.PARALYZER] =		{1,{"Sleep well.","Shhhh.","Don't worry, you'll miss all the bad parts.","You won't remember any of this.","No one has to get hurt.","Safest place for you to be is nowhere."}},
		[_M.STIM_SELF] =		{0.5,{"This should help.","Already feeling things clear up...","Wow, I can focus! That's great!","Is this what being normal feels like?","It's like the fog in my head just... poofed.","Ok, ok, so what do I do next?"}},
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Let's hit the road!","Doesn't look too comfy.","Come on!","The sky outside is beautiful. Come on, I'll show you."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Time to go!","Let's not stick around.","Oof, that was a tough one.","We made a complete haymes o' that.","One little mess-up means nothing.","There's always a second chance.","At least we're not dead - right?",}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Piece of cake.","I think that went well!","I think we did pretty good there.","I can't wait to count the credits.","That went fierce well.","Well done everyone!","A fine job.","Bang on.",}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"I kind of hoped it wouldn't be like... that.","Mmm. This was a bad day to be lucid, huh...","Maybe we could just knock some of them out next time?","Ugh, that was awful.","They shouldn't have gotten in the way.","I would have let them live...","We made right bags o' this.","These people deserved a second shot at life.",
}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"Do we have to? Can't we...","We'll find you again, I promise.","Sad day...","I don't like this...","This is why I worked alone, back in the day. Fewer people to lose.","I wish we could've done something.","This... shouldn't have happened.",}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"I've got him. You' okay?","Take cover! Okay, nevermind, he's dealt with.","Let's hope nobody heard that.","I've got your back.","There. We should scram now."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"I'll keep an ear on the daemons. Maybe I'll hear yours one day.","Oh no...","Until we meet again."}},		
	},

	-- Internationale
	[_M.INTERNATIONALE] = {
	
		[_M.EVENT_SELECTED] = 	{p_selected,{"You're coming in clear.","On the team.","Read you loud and clear, Operator.","I read you. Radio check.","Coming in clear.","Signal's good on my end. You read me?","Yes, Operator?","I am ready."}},   
		[_M.ATTACK_GUN] = 		{p_gun,{"I do not like this.","This is the only way.","Count to three, pull the trigger...","Deep breath..."}},  
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Delivering toxin.","Clearing things up.","Let's open the way.","Taking him down."}}, 		
		[_M.ATTACK_MELEE] = 		{p_melee,{"Too bad we can't talk this out.","Sorry, friend.","This will probably sting.","Libertad!","El enemigo está bajo control.","Awaiting further instructions."}},				
		[_M.OVERWATCH] = 		{p_ow,{"Ok, focused in.","I will take care of it.","I've got it.","Everything's under control.","Keeping a look out."}},			
		[_M.OVERWATCH_MELEE] =		nil,
							
	--	[_M.EVENT_MISS_GUN] = 		{1,{"Target is obscured!","Need a better angle"}},	
		[_M.GOT_HIT] = 			{p_gothit,{"I can't feel my... ","No, I...","Damn... you...","For... the team..."}},			
		[_M.REVIVED] = 			{p_revived,{"That really cleared things up.","Thank you. I mean it.","Back in the fray.","That was too close.","For a moment there, I thought...","I knew I could count on you"}},			
		[_M.HIJACK] = 			{p_hj,{"I'm on it.","Installing virus.","Let's see what their security is like.","No obstacles encountered.","Accessing their system."}},		
		[_M.WIRELESS_SCAN] = 		{p_scan,{"Scanning area.","Pinging the mainframe.","Homing in on the signal.","A lot of noise around us.","Detecting.","Let's see...","I'm searching.","Checking for mainframe objects."}}, -- rather test	
		[_M.SAFE_LOOTED] = 		{p_loot,{"Busted open.","Secrets revealed.","Time to redistribute.","New assets acquired.","New capital under our control."}},				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Damn it, I'm seen!","Cover is blown."}},					
		[_M.PEEK] = 			{p_peek,{"Scouting ahead.","I know what's coming.","Area sighted.","I have eyes on this."}},					
		
		[_M.PIN] = 			{p_pin,{"I shouldn't sit here long.","I suppose this is more merciful.","Too bad you're unconscious. There are things I could tell you about your rights as a worker.","I'm just gonna leave this leaflet in your pocket, okay?"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Whatever it takes to get the job done.","More than the sum of my parts.","I can use this.","Hopefully, this won't make me start drinking."}},								
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Time for stealth.","The subtle approach.","I can see why Brian likes this trick so much","Cloaked and ready.","Cloak active."}},
		[_M.MEDGEL] =			{p_medgel,{"Take it easy.","Easy now.","Next time, be careful.","All good?","It'll be okay.","Let's get you out of here","We don't have time. Can you walk?","We're not safe yet. Focus.","Don't worry, they'll pay for this.","You okay? You just need to make it to the exit."}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"We're getting you out of here.","No pressure, but we need to leave. Now."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"It's not always easy. But we made it out, this time.","This is but a bump in our road to a better world.",
"We've made mistakes. We'll fix that."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Here's to a job well done.","Even Gladstone shouldn't find fault with this.","We've all earned our rest. Let's get back.","This was a success.","Mission accomplished.",}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{".........","This was so unnecessary.","We had no reason to kill so many.","Someday, this will catch up to us.","What horrors have we committed...","...","This is *not* why I signed up.","They didn't deserve to die.","They were at the wrong place, at the wrong time.",}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"Just for the record, I don't like this.","We don't leave our own behind... no matter who it is.","We should have tried to...","This is terrible.","I shouldn't have let this happen..."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"This is why we're a team.","I've got you covered.","Keep your head down. I might not be there next time.","Did he get you? No? Good."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"I can't believe we let this happen...","This death will not be in vain while I can still fight.","The forces of capital are heartless, but will not win."}},		
	},

	-- Nika
	[_M.NIKA] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Will get it done.","Yes?","I read you.","I'm waiting.","Receiving. Do you read?","I'm here, Operator.","Operator.","Uplink confirmed.","Awaiting instruction.","Signal is good. Let's go.","Hm?"}},  
		[_M.ATTACK_GUN] = 		{p_gun,{"With lethal force.","Terminating.","Taking action.","...\nHe's down.","Enemy down.","Target down.","Threat eliminated.","Neutralized.","...","Hm.","......"}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Tranquing.","Knocking out the target.","...","...","Neutralizing target"}},  
		[_M.ATTACK_MELEE] = 		{p_melee,{"...","These guards are not good enough.","He is down.","Ready for the next target.","Hah!","Who's next?","Hm. Gets the blood flowing."}},	
		[_M.OVERWATCH] = 		{p_ow,{"Covering this zone.","Will get it done.","Standing guard.","Ready to intercept."}},				
		[_M.OVERWATCH_MELEE] =		nil,											
	
	--	[_M.EVENT_MISS_GUN] = 		{1,{"Zey have cover"}},		
		[_M.GOT_HIT] = 			{p_gothit,{"Do svidanya...","Ne... ne mogu...","I'll...","Nghhhhh...","Operator, make sure the team is..."}},				
		[_M.REVIVED] = 			{p_revived,{"Spasibo.","They cannot stop me.","Thank you.","... \nI'm up."}},				
		[_M.HIJACK] = 			{p_hj,{"Virus installed.","Device hacked.","...","...\n I have the device."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I have captured something.","Supplies.","..."}},	
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,		
			
		[_M.INTERRUPTED] = 		{p_inter,{"..."}},					
		[_M.PEEK] = 			nil,								
		
		[_M.PIN] = 			{p_pin,{"I will break you.","Stay down.","I have him.","He will not move, trust me.","Target subdued."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Hmm.","Good.","...","Stronger now."}},								
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"...","I am cloaked.","Concealment active.","Very well. If it is stealth you need."}},
		[_M.MEDGEL] =			{p_medgel,{"Get up.","Ne zha shto.","...","...Good?","Move.","You're awake. Good.","Stay behind me.","...\nStay close to me if you cannot handle yourself.","We have work to do. Don't slow me down again.","You need to be better."}},
		[_M.WAKE_OTHER] =		nil,
	
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"You can still walk. Good.","I'm here to free you.","Follow me.","You need to find your strength. Quickly."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Everyone who's still alive is out. That's what matters.","...","We need to train harder to match them.","They're strong. We must be stronger."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Job went well.","...\nGood."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"Reminds me of my old job. Messy."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"...","I consider this a failure.","...\n...We should have done better."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"...","He hesitated. His mistake.","I won't allow this.","I have you covered. Move.","Find a better hiding spot. Now.","... \nKeep moving.","Don't let them see you again."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"...","Goodbye.","They will regret this.","I.. failed."}},		
	},
 		
	-- Sharp
	[_M.SHARP] = {
	
		[_M.EVENT_SELECTED] = 	{p_selected,{"Ugh, what do you want?","I already know what to do.","Don't waste my time.","I can handle this.","You think you can tell me what to do?","I read you. But we're doing this my way.","...","... \nWhat?","What was that? I can't hear you. Guess I'll have to improvise.","I will not be bossed around by the likes of you.",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Nowhere to run, meatbag.","This takes me back.","Perfect execution.","You should thank me.","They always drop too quickly.","Perish."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Pathetic.","Exploiting systemic vulnerabilities...","Foiled by a chemical.","That was too easy.","See, and that's why organic blood is a bad idea.",}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Hardly an opponent.","It didn't stand a chance.","No match for me.","Frail excuse for an organic.","Obsolete piece of meat.","Heh.","Are you watching, Operator?","This is how it's done."}},					
		[_M.OVERWATCH] = 		{p_ow,{"Armed and ready.","They won't know what hit them.","Prepared for perfection.","Watch and learn.","Time to make this look good."}},				
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"I... refuse...!","I am NOT... this... fragile...","Missed... me...","No, NO! I'm not...","Like that's gonna... stop me..."}},			
		[_M.REVIVED] = 			{p_revived,{"I didn't need your help.","I was just resting.","Ugh. Don't look at me.","Don't touch me.","Hands off, I'm fine!","..."}},					
		[_M.HIJACK] = 			{p_hj,{"Uploading virus.","Even their digital systems fall short against me.","Interfacing with a vastly superior being.","Finally, some better company.","Accessing data."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I have the goods.","Looting the container.","This should buy me an upgrade or two."}},
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,
					
		[_M.INTERRUPTED] = 		{p_inter,{"How annoying.","This changes things.","Adapting."}},				
		[_M.PEEK] = 			nil,							
		
		[_M.PIN] = 			{p_pin,{"Ugh, I think it's still alive.","Stop twitching!","Why am I wasting my time here?","This is humiliating.","Do I really have to be touching him? Can't I just... no?","Do you know how easy it would be to snap his neck?"}},
		[_M.INSTALL_AUGMENT] =		{1,{"Perfection is hard to improve, but I believe that did the trick.","At last!","One step closer to perfection.","Yes!","I am even more optimized.","I think that one had a scratch on it.","Acceptable.","Only the finest.","This better not be some cheap knock-off.","Who could bear to look upon such beauty?","Look at me. Do NOT touch.","Are you sure that was the best we had?","Working with a pile of meatsacks is worth it, for this."}},											
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Not certain if I like this.","...Still more attractive than anyone here.","I prefer my enemies to look me in the face before I obliterate them.","Undetectable. Yet another on my long list of traits.","This hardly seems necessary."}},
		[_M.MEDGEL] =			{p_medgel,{"Pathetic.","Don't get your juices on me, meatbag.","That only delayed the inevitable, you know.","You're up? Good, because I refuse to drag you.","See? That was me, being a good teammate.","I just saved your life, you worthless sack of juice.","There. Try not to fall over yourself with gratitude.","You can thank me later. Cash is best."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Waste of time, really.","Oh, good. You can carry my things.","Fantastic, more dead weight."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Bah! I hate having meatbags slow me down.","Mission took a turn for the ugly. This is all your fault, you know.","Next time, just send me in solo. I'll do a better job, I guarantee you."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"We perservered, as well we should.","We were clearly superior to them. You're welcome.","We couldn't have done that without me.","That was a smooth run. I take full credit.","They were no match against my enhanced frame."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"Now that is what I call sport.","Quite entertaining, for a change.","Pity not every job is like this.","Nothing better than the squealing death throes of husks that haven't yet begun to rot."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"Dibs on the free bunk.","The less dead weight, the better."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"I will handle this.","Leave it to the machine.","Be glad I was there for you, meatstain.","I'm feeling magnanimous today.","How typical. A meatsack in need of a rescue.","This doesn't mean I like you."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"I told you to keep backups...","That's what happens when you run around in a body like that.","Surprised you lasted this long, really...","Hmpf. Organics...","This is what happens when you get sloppy."}},		
	},
	
	-- Prism
	[_M.PRISM] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Let's get started.","This should be easy.","I'm in. Try not to get me killed.","Coming in clear, Operator. Don't make me regret ditching solo jobs.","Bring it.","I'm listening.","You've got a plan?","Coast is clear. Let's move.",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Let's get this over with.","Taking him down.","Time to pay, pig.","Roll credits.","Oh yeah. He's down.","Not the red carpet I want, but it'll do.",}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"He's one of the lucky ones.","I guess that's one way to deal with them.","Oh yeah. He's down.","Time for your nap."}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Guess what? That wasn't a prop.","Corporate pig.","This does make me feel better.","How's that for a stunt?","Yeah, I don't think so."}},					
		[_M.OVERWATCH] = 		{p_ow,{"Sweet.","They won't get past me.","I'll show them.","Time to dazzle."}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"No! I won't...","Can't... be...","Nice shot, asshole."}},			
		[_M.REVIVED] = 			{p_revived,{"They'll pay for that.","Back in the floodlights.","Think this could stop me? Watch.","Thanks, I guess","Yeah, um... I owe you one."}},					
		[_M.HIJACK] = 			{p_hj,{"Uploading program.","Siphoning the PWR.","This device is ours now."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Good thing we stopped by.","X marks the spot.","My favorite moment.","I'm sure they won't miss this.","Not a bad haul."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Yikes.","Aw, shit.","Damn it.","So much for staying on the down-low..."}},				
		[_M.PEEK] = 			{p_peek,{"Path scouted.","I see all.","Nothing shall slip me by."}},								
		
		[_M.PIN] = 			{p_pin,{"If you're smart, you won't wake up.","I've got him under control.","Got it. Enemy pinned.","What now?","Already bored.","This could get old, real fast."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I should get some nice mileage out of this.","Just what I've been looking for.","Damn, that stings.","Sweet, an upgrade.","I better not turn into one of those chrome nuts."}},														
		[_M.DISGUISE_IN] =		{1,{"Time to become someone else.","They won't know what hit them.","Let's do some acting.","Roll out the red carpet.","First and final take.","Just like the good old days.","This takes me back.","Ahem. Just an ordinary guard...","Hey there, fellow security..."}},
		[_M.CLOAK_IN] =			{p_cloak,{"Out of sight, out of mind.","Bit of a strange feeling, this.","I do not need this to blend in.","Putting the 'invisible' in... well, you know.","Just like magic, but better."}},	
		[_M.MEDGEL] =			{p_medgel,{"Let's get moving.","You good? Okay, let's go.","Can't laze around forever, you know.","We haven't got all day.","Try not to collapse till we're in the clear.","Oh good, you're still alive.","You're welcome.","You wanna get out of here or what?","Let's not stick around."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Good news. This is officially a jailbreak.","Yeah, yeah, it's me. Rescue now, autograph later.","Good. I was hoping it'd be one of us."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Well, that was a disaster.","Hey, at least we got away.","So we probably could have handled that one better...","For a while there, I thought that was it.","Made it! Wasn't sure we would..."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Terrific performance.","Roll credits.","Job done, everyone out. Nice."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"They got what they deserved.","I feel a little bad for them. Just a bit, mind you."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"So much for team spirit, huh?","Shit.","I had to leave a lot of people behind, back in the day. Hoped it wouldn't come to that..."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"Yeah, I don't think so.","Behind you, corporate pig.","Thanks for distracting him.","You okay? I've taken him out.","I don't mind playing hero, but that was way too close."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"I'm adding this to the list, you bastards.","Damn it.","Looks like we owe someone a bullet.","Keep moving..."}},		
	},
	
	
	-- Olivia
	[_M.OLIVIA] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"I'm on site. Insertion clean.","I read you.","Communication is up. Let's do dally.","No contact so far. What's our next step?","What are we looking at, Operator?","I'm counting on you.","We don't have much time. Let's make this count.","Coming in clear.","Operator, do you read me?",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Eliminating the target.","Clean and precise.","Enemy neutralized","That's one less for us to deal with."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"He's down. Let's not waste time.","That ought to do it.","Enemy neutralized.","Clean and precise."}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"He's dealt with.","Aggressor neutralized.","Time to get rough, then.","That ought to teach you.","Threat removed, I would say."}},				
		[_M.OVERWATCH] = 		{p_ow,{"I'll keep a watchful eye.","Readying my sights.","I'll show these boys a thing or two.","I suppose we'll have to do this old-school."}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"No! They mustn't...","You... bastard...","No... I still need to...","Damn you...","You can't... take me alive..."}},			
		[_M.REVIVED] = 			{p_revived,{"Good. I'm not done with them yet.","I'm still alive? I suppose they've never had the best aim...","Only a minor setback.","You have my thanks, agent.","I've weathered worse than that."}},										
		[_M.HIJACK] = 			{p_hj,{"Uploading the worm.","Subverting enemy tech.","Another asset gained.","Virus installed."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Well this should prove useful."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Oh, bother.","Hm, a setback."}},				
		[_M.PEEK] = 			nil,								
		
		[_M.PIN] = 			{p_pin,{"I've got him pinned down.","Under control.","He's not going anywhere."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I suppose that's useful enough.","An augment is only as good as its host.","I'll make do with this.","Anything to give us the edge.","Power can have many forms.","A beneficial upgrade."}},														
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Can't see me now, can you?","Cloak in."}},	
		[_M.MEDGEL] =			{p_medgel,{"Enough dilly-dallying.","Look sharp, we're still in enemy territory.","That was a close recovery.","You should be fine for now.","Do try not to get shot next time.","Don't be so sloppy."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"I believe you're overdue for a change of scenery.","Do not dally. They're coming for us.","Take it easy, agent. We're here for you."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Disappointing, but at least we got away in the end.","Let's aim to do better next time, shall we? This should have gone much more smoothly.","This one was a bit of a mess.","I expect a full evaluation on ways we could have improved our performance in this mission."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"That was exemplary. Colour me surprised.","That actually went quite well for a change. Well done, team.","If only all missions could be that smooth.","Now that is what I like to see.","Back to the jet. I'll allow for a celebration, a small one."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"It may not be pretty, but the lethal approach is the most effective one, sometimes.","Sometimes, ruthless efficiency is what's called for. Emphasis on \"ruthless\"."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"This is disgraceful, but it's the only choice we have.","Damn it.","We'll do our best to track down the agent we just lost. Until then, I expect everyone to pull double their weight."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"Not on my watch.","I don't think so.","That's my agent, you loathsome wretch.","You'll want to reconsider.","Coast is clear. You should move.","Remember, we stay on our feet to survive."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"Someday, we'll hold them accountable for this.","Not another one.","It's better than being captured. Trust me.","It happens. Keep your head on the mission, Operator."}},		
	},
	
	
	-- Derek 
	[_M.DEREK] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Now see, being Operator? That's a nice gig, don't you think?","I'm listening. For now, anyway.","You have my undivided attention.","Let's get this heist started.","Don't get me in trouble, now.","Comms are up.","I read you.","Yes?","Comms are functioning. Thank goodness for that, at least.","Uplink established.","I'm receiving. Go ahead.",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Well. That takes care of that","Time to get messy.","Try not to splatter too much.","Taking aim.","Ugh, I suppose this is unavoidable..."}},	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Take a nap, my friend.","Why don't you have a lie-down?","Well that takes care of that","I should get one of these custom-made.","If I could just rewire this a bit..."}},								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Okay, acquiring this thing was worth it.","I'm looking forward to the contents of your pockets.","Subduing the enemy.","Well that takes care of that.","Ah, wetwork.","That's quite enough.","Do be quiet.","I'm taking him out.","Enemy engaged."}},						
		[_M.OVERWATCH] = 		{p_ow,{"This is really so uncivilized.","Prepared to take action.","Watching this area.","Ready to fire.","Preparing a nasty surprise."}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Well, that's...not good...","I blame... the  management...","Corporate... scum...","No, not after everything...","Not... like this...","I can't be..."}},			
		[_M.REVIVED] = 			{p_revived,{"Ugh. Do I even get hazard pay?","A second chance.","Let's up the stakes.","Back in the game.","My thanks, friend.","Remind me to thank you later."}},					
		[_M.HIJACK] = 			{p_hj,{"Money is power, but so is data.","Let's take a look at this darling.","Time to get to work.","Ths is what I'm here for.","And now the real job begins.","Subverting enemy mainframe.","Ahhh, now this? This is more like it.","Just look at this system - how quaint.","Open sesame!"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"A penny stolen is a penny earned.","Let's wipe this place clean.","This is pocket change to them. But it's our pocket change now.","Let's grab this and run.","Marvelous. Anything else we could lift?","Can't leave this lying around.","Let's put this to use.","I imagine they'd want to keep this. That's too bad.","Now that's what I call rewarding.","This day just got better."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Well, uh...","So much for the ghost approach.","I've encountered difficulties."}},			
		[_M.PEEK] = 			nil,								
		
		[_M.PIN] = 			{p_pin,{"Keeping him down.","I've always aspired to be someone's hired muscle.","Enemy pinned.","Well this could get old rather fast.","He's not going anywhere."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Time to embrace the new age.","Ah, the wonders of technology.","Not a bad choice.","I wasn't attached to that bit of tissue anyway."}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"This is more my style.","I'm sure I could tweak this to work longer.","Now that's some toy.","I like this."}},	
		[_M.MEDGEL] =			{p_medgel,{"You are quite fortunate to have modern medicine on your side.","There you go, friend.","Can you walk? Marvelous.","Don't worry, the stinging is how you know it's working.","Come on, I'll help you up.","Friends don't let friends bleed out on the ground, remember.","Stick to the buddy rule next time.","You'll have to make that up to me.","Let's move along now.","Good. Saves me the bother of dragging you."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Yeah, yeah. You can thank me later.","Let's get you out of here, friend.","Not exactly what you'd call a luxury suite, is it?","You don't owe me money, do you? Because now-ish would be a fine time to deliver."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Any chance we could make it a bit less eventful, next time?","I think we may have overstayed our welcome.","We couldn't have cut that one any closer.","I'm going to need some calming tea after this."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Everyone in? Splendid, let's go.","Please make sure all limbs are contained in the elevator area before we depart.","We certainly made a tidy profit.","Why, I think we might have been almost competent."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"I really, really need to get a desk job.","See, that's why they call it wetwork.","I got blood on my laptop. Let's pray the thing still works.","This wetwork deal is starting to lose its shine."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"...","...\nDamn it...","On the bright side, I suppose we've got a vacancy now..."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"Time to play the hero.","How much would you say your life is worth? Because you owe me one.","They think themselves unstoppable.","Plot twist: I've got toys of my own.","How's that taste?","Pardon me.","You can make it up to me later. Money's good. Money's best, actually."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"Damn...","Bad luck. Happens to all of us.","Anyone else think it's high time we high-tail it out of here?","I think we've stayed here too long...","Darn it. This isn't the way it's supposed to go."}},		
	},
	
	
	-- Draco
	[_M.DRACO] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"You called upon me?","I am your servant.","Now the feast can begin.","I hear you, Operator.","Command me, and I shall do your bidding.","Shall we?","Yours to command.","As night fell, he rose.", "The scent of blood filled the air - he was ready.", "Let us finish before the sun rises.", "My life is in your hands.", "I trust you... for now.", "Leave as we came: without regrets.", "Make sure we walk out of here, Operator.","This place is familiar. Could it be..."}},
		[_M.ATTACK_GUN] = 		{p_gun,{"See you in hell.","More prey.","Add this to my tab.","It is almost too easy.","I wonder what you've got for me."}},  	
		[_M.SHOOT_DRONE] =		{p_shootdrone,{"No blood spilled this time.","Still no match for a predator's reflexes.","I wonder how much this cost them.","Peekaboo.","You are no use to me, anyway."}},
		[_M.SHOOT_CAMERA] =		{p_shootcam,{"I'm watching you, Big Brother.","Target practice.","This might get some attention.","Blind them first, it drives them crazy.","Nothing to see here."}},
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"How dull.","Inadequate.","Won't stay down for long.","This is your lucky day.","You look tired, friend..."}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Bothersome.","This is how it feels!","A shocking experience.","For your own sake, stay down.","...You were saying?","The hunter strikes!"}},					
		[_M.OVERWATCH] = 		{p_ow,{"The hunter awaits.","Prepared to strike.","Enemies beware.","The element of surprise!","Muscles tense, his focus didn't waver, not for a moment..","Trust me, I'm not afraid to use it."}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Careless... of me...","Not... again...","You'll never... take me alive...","Never hear the end... of this..."}},			
		[_M.REVIVED] = 			{p_revived,{"No rest for the wicked.","This chapter is still unfinished.","Like a bat out of hell.","Someone will pay for that.","He shall rise again.","It takes more than that to keep me down.","Frankly, I'm terrible at dying.","I live!","I am in your debt."}},					
		[_M.HIJACK] = 			{p_hj,{"Truly thrilling.","Though boring it may be, it's part of the job."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Finders keepers!","Well, hello there.","Would be a shame to leave this here.","No one will miss it, I am certain.","Ours for the taking.","A treasure trove."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"There you are!","I see you.","They have me in their sights.","Hssst!"}},				
		[_M.PEEK] = 			{p_peek,{"Senses sharpened.","A quick look is enough.","Curiosity saved the cat.","Just to be sure I don't fall prey to another.","He was silent and careful, nothing gave him away..."}},								
		
		[_M.PIN] = 			{p_pin,{"Don't make me do anything you'll regret.","I should have brought a book.","If you're lucky I won't be anywhere near when you wake up.","So... is the insurance good?","Here we are. Just you, me, and your brain.","I can read you like a book.","Let's peek between those pages.","The hunter swoops, pinning his prey."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Surprisingly refreshing.","Evolve to survive.","This just got more interesting.","The craving has eased a little.","They are not ready for what I am now."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Into the shadows.","With a light step.","Now you see me... now you don't.","You saw nothing.","Fading into darkness.","They won't see me coming.","Striking from the shadows.","A deadly apparition."}},
		[_M.MEDGEL] =			{p_medgel,{"Rise and shine!","Awaken.","I command you: Rise.","This shall knit your flesh together.","Next time, do not let them catch you."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		{1,{"A paralyzing bite!","Your slumber deepens."}},
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"I release you.","Freedom beckons. Let's both of us follow its song.","You must spring free of their clutches!","You are weak, still. Trust me, they will not slow down for that."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"A messy escape, but an escape nonetheless.","The thrill of the hunt lies in its lack of perfection.","They are our prey, but the reverse is true, as well.","We've met our match today. Perhaps we can do better.","Never a better time to leave.","Let us go while we are in one piece.","Until next time.","This time, they get the upper the hand."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"A worthy show of our abilities.","We persevered, as well we should.","They were no match for our cunning.","They had no chance against us.","A happy end - to this chapter, anyway."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"The smell of carnage fills the air.","We've hunted our fill today.","They put up a good fight.","They struggled, but we perservered.","They squealed like pigs.","It is time to leave this battleground."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"A ghastly  necessity.","We are stronger in numbers. Alas.","Rather be the hunter than the prey.","This begs for some old-fashioned revenge.","Eye for an eye, they owe us one.","Would this justify the upcoming clean-up cost?"}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"Consider yourself in my debt.","Anything else while I'm feeling generous?","This temptation, I must resist it night by night.","And here I thought you could handle it without me.","Waited for my moment.","My moment comes!","I'll take it from here, thank you.","Emerged from the night, left no witnesses.",}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"In the end, all must feel night's sweet embrace.","I see the shadows descend - but not for me.","A requiem for a hope.","I'll pen your obituary."}},		
	},
	
	
	
	-- Rush
	[_M.RUSH] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Oh great, it's middle management.","What do you want?","Yeah?","Make it quick. I can't wait to get started.","Let me guess. You want me to peek through that door?", " < Yawn > ", "Uh-oh. Here comes the nanny...","Alright, yeah! Let's do this!","Ready to crash this place to the ground?",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"I like it when we don't hold back.","Unpleasant, but at least it's not boring.","No more than they deserve.","I prefer a personal touch.","Taking out the target.","This is what you get."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"See? I can do bloodless.","I would have rocked the biathlon, if I'd bothered.","Perfect aim. As always.","He's down, but still in the game.","Couche-toi!","Taking him out."}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"I'm so good at this.","This is so much faster than stealth.","That was subtle, for me.","Sucker.","Is that what they call armed force? Pathetic.","I expected better.","Next!","Not so tough now, are you?","You better hope I didn't break a nail, buddy."}},					
		[_M.OVERWATCH] = 		{p_ow,{"Got it covered.","All right, I'll wait.","Fine, I'll do it.","Lying in wait.","Prepared to ambush.","I'm watching this area.","Here we go!"}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Like you could... stop me...","What? No...","I don't believe...","Worth it...","Damn... you...","Casse-toi...","Operator? So the bad news is..."}},			
		[_M.REVIVED] = 			{p_revived,{"Let me at them!","They'll have to try harder than that.","Ugh, fine, I'll buy you a drink later.","Yeah, I know. I totally saved you."}},					
		[_M.HIJACK] = 			{p_hj,{"There, tech, do your techy thing.","Knowing how this works isn't my job.","Why are we bothering with these, again?","System... you know, whatever.","Uh, open sesame?"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Bingo","Smash. Grab. Okay, less smashing than I'd like.","Is this all? I thought these people were rich.","Money? Well, I won't say no.","Hm. Underwhelming."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"They can see  me. Good.","Hey there!","Gotta make this look good.","Oh good, I was worried I'd done my hair for nothing.","An audience. Finally!","I'm used to a bigger crowd when I do my stuff."}},				
		[_M.PEEK] = 			{p_peek,{"Nothing I'd consider interesting.","Yawn.","Let's have a look-see.","Room scouted. Great, can I go in now?"}},							
		
		[_M.PIN] = 			{p_pin,{"And here I thought this job would be exciting.","...How long do I have to do this?","I'm not here to babysit.","Enemy pinned. If that helps."}},	
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I swore I was done with these.","Ugh, if I have to.","Ow.","I don't need that. I'm already the best.","You want to turn me into some sort of cybersoldier? Fine, whatever."}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"So, uh... what now?","Cloak and dagger isn't really my style.","Can I do something useful for a change?","Cloak active. For whatever that's worth","Whoo! Pretty fun.","Time to be super duper quiet."}},	
		[_M.MEDGEL] =			{p_medgel,{"Next time, I just leave you behind.","See? I can do teamwork!","I don't have time to babysit.","Hurts, huh? Suck it up and let's go.","You up? Good. Get a move on.","This? This is slowing me down.","Clock's ticking.","You're less of a dead weight now.","Walk it off.","Sheesh.","< Eyeroll >","Look on the bright side: Scars are in fashion."}},
		[_M.WAKE_OTHER] =			{1,{"Stand up!","I was just about to kick you."}}, -- sorry had no better ideas
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		{1,{"A little overclock can't hurt.","Zing. Where to?","GAME ON.","Not as much of a rush as it used to be.","Whoo! Yeah! Let's do this!","READY SET GO.","So much for trying to shake that habit."}},
		[_M.STIM_OTHER] =		nil,--{1,{"Try this"}}, -- sorry had no better ideas
		[_M.SELF_STIMMED] = 	nil,--	{1,{"Refreshing!"}}, -- sorry had no better ideas, test
		[_M.STIMMED_BY] = 		{1,{"Thanks, pal."}}, -- same
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Look who's here: The answer to your prayers.","So you coming, or what?","Come on, we've got a ride to catch."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Whoo, what a mess!","Hey, at least it wasn't boring.","Ugh. That sucked.","I should be better than that.","Sometimes you fall flat on your face. We'll show them next time."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"And that is how you do it.","We just ran circles around those idiots.","We sure showed them!","Oh yeah, that got the blood pumping!","I think I set a new personal best, just then.","Smash and grab. Just the way I like it.","Yeah!"}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"Rats. I got blood on my favourite shoes.","This was fun.","They got what was coming to them.","And that is why you don't stand in our way."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"I guess we're not going back, huh?","Too bad. I was starting to like the company."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"Like I always say: I'm the best.","Don't say I've never done anything for you.","Held at gunpoint. Exciting, wasn't it?","Don't make me clean up after you again.","Bored again.","That was fun. Call me next time you get caught again.","I think you're losing your edge."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"Huh. Well, that sucked.","Too bad. I was starting to like you.",}},		
	},
	
		-- Monst3r
	[_M.MONSTER] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Goodness me. Still not quite used to having you in my ear.","Technically, I don't answer to you. But let's hear it.","Mmm, yes?","Uplink is up. Please, do go on.","You're coming in clear. Shall we begin now?","Must be nice, sitting back there and pulling on strings.","I read you, Operator.","Ugh. Don't make me regret getting back in the field, will you?","Yes, yes, I hear you.","I read you.","You're coming in nice and clear.",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Inelegant, but this isn't a civilized age.","Call me squeamish, but this isn't really my preferred M.O.","Enemy snuffed. Enough of a euphemism for you?","All that work tinkering with that gun, and I still have to do... this."}}, 	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Guess what? You get to test my new prototype.","And here I thought I'd put these days behind me.","Now this is more like it.","Tranquilising the target. Happy now?"}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Well that takes care of that.","Some things you don't forget. Like riding a bike.","Not my preferred weapon, but it works.","A little trip down memory lane.","Oof. I'm not as young as I used to be, you know!"}},					
		[_M.OVERWATCH] = 		{p_ow,{"They won't be passing through here, I assure you.","I'll keep an eye out.","Ambush prepared."}},
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Didn't see that coming.","Well that was unwise...","I seem to have made a...","That really... stings...","Gladstone, are you there? I...","No, that's not how it's supposed to...","You... corporate... fiend..."}},	
		[_M.REVIVED] = 			{p_revived,{"Good. I'd rather not have to take one for the team.","Oh, splendid.","Didn't think you'd be rid of me that easily, did you?","That one's bound to leave a mark.","Oh, thank you. A refreshing bout of competence.","Ngh. Much appreciated.","I've missed this. Having someone who has my back, I mean.","Urghh. Thank you, I shall be fine now.","Still stings, but this should keep me on my feet until we're out, at least."}},					
		[_M.HIJACK] = 			{p_hj,{"Finally, back to my comfort bubble.","Do try to avoid bringing down any heat while I'm busy.","Almost makes me want to get back into software.","No meowing. Thank goodness.","At least that was easy.","Now what do we have here?","Hmmmmm... interesting.","Ah! I recognise this.","I can work with this, yes."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Would be a terrible shame to leave this lying around...","Money. I'd know it anywhere.","Oh good, we could use some new toys.","I like you, so I won't take my usual percentage.","I'll find a good home for this.","This could be useful, I'm sure."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		nil,				
		[_M.PEEK] = 			{p_peek,{"Knowledge makes the man.","Let's see what's ahead."}},															
			
		[_M.PIN] = 			{p_pin,{"Undignified for both of us, isn't it?","What do you take me for - some kind of thug?","I have the enemy pinned, if that helps.","I'd much rather be doing something else with my time.","My usual job involves a tad more sophistication.","I have him pinned."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Ooh, I think this one's a limited edition!","Hmph, if I must.","Not too shabby.","Not inadequate, but I do miss my old suppliers."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"I do love these new toys.","This is incredibly satisfying.","This should give them the slip.","It is time to... disappear.","Whoosh. Ahem, that ought to do it.","More my style."}},
		[_M.MEDGEL] =			{p_medgel,{"Oh, good. I wasn't looking forward to having to drag you around.","Do be more careful next time.","You're welcome. I'll be sending you the reimbursement bill later.","Someone has to pull their weight around here. Might as well be me.","Gladstone's always excelled at risking her live assets. You're spared that fate, for now.","You know she still considers you expendable, right?"}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Let's not abuse their hospitality.","Come along, now.","Not staying to enjoy the view, are you?"}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"I forgot how much I hate fieldwork.","Phew, back to safety. I haven't missed being in the field."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"I wish there was some other way of exiting the building.","I may get used to field work someday, but I will never get used to the transport beam."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"Why, I ought to start selling you ammunition in bulk.","Goodness gracious. With these cleanup costs, it's no wonder you are perpetually short on credits."}},
		[_M.ABANDONING_OTHER] = 	nil,--{p_abandonedother,{"This went well."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"A dreadful business. You alright there?","Let's both be thankful I got to you in time.","You'll want to keep your head out of trouble, next time.","I would jest about a reimbursement fee, but even I'm not that callous.","On the house.","Are you unharmed? Well then, what the blazes are you waiting for?"}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"You knew the risks, friend...","Sigh. Not the first casualty I've seen.","Could we perhaps stop letting them shoot at us? By any chance?"}},		
	},	

	
			
			
		-- Central
	[_M.CENTRAL] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Coming in clear. Don't let us down, Operator.","The mission is in your hands, Operator.","Let's not waste time, Operator.","Let's begin. I'm counting on you, Operator.","You're coming in clear.","Very good. Comms link is up.","Let's do this one by the book.","I read you.",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Obstacle eliminated.","Taking the shot.","I'm doing this for her.","Doing what must be done.","Let's keep the mess to a minimum.","If I have to get my hands dirty, so be it."}},	
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Temporarily neutralized.", "Done. Now let's not waste time.","Taking the shot.","An elegant, quiet solution.","Let's not be here when he wakes up."}},								
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_MELEE] = 		{p_melee,{"Brutal, but effective.","This one won't get in our way.","The sooner this is over with, the better.","Deep in the nit and grit of it.","Let's make sure they don't stand in our way.","I still remember how to do this."}},					
		[_M.OVERWATCH] = 		{p_ow,{"I have my eyes peeled.","Preparing the ambush.","Ready for hostiles.","Ready to engage.","Overwatch ready."}},		
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"No! We were... so close...","I have... to finish...","After all this time...","This won't be how... we lose...","Incognita? You must..."}},			
		[_M.REVIVED] = 			{p_revived,{"Back into the field.","I will not be held back by the likes of this.","Good. We have work to do.","You're earning your keep, agent.","Good. Let's continue.","You're only doing your duty, but don't think I don't appreciate that."}},					
		[_M.HIJACK] = 			{p_hj,{"Subverting the system.","She now has access to this.","Power. There's no need to comment on the irony.","A little something extra for her to work with."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I never thought we'd get this desperate.","This should prove useful.","Let's pick their bones clean.","Time to play the common thief."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Curses!","Ah."}},				
		[_M.PEEK] = 			{p_peek,{"Let's not get sloppy.","Scouting ahead.","I see the way.","Gathering intel."}},								
				
		[_M.PIN] = 			{p_pin,{"Let's keep things under control, shall we?","All this troble just to avoid bloodletting. Pity he won't appreciate it.","I have this one subdued.","I'm keeping him down."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"This should prove useful.","Our bodies are such a small price to pay.","It's been installed seamlessly. Good.","Better this than being under-equipped.","We need every edge we can get."}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Such a rare and useful bit of tech.","Cloak engaged."}},	
		[_M.MEDGEL] =			{p_medgel,{"Back on your feet, agent.","I need you on your feet. There we go.","Pay more attention next time.","Keep your head down. I'll get you out of here, I promise.","Don't thank me yet. If they capture you, you're going to wish I'd let you bleed out."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"We're short on time. Their security just got a bump.","Let's get a move on, shall we? Time is wasting.","You will receive full treatment later. For now, I must ask you to be at your best.","Let me be clear: If you sold us out, you'd best walk right back into that cell.","We'll do a debrief of this later. Let's make sure we get you out of here alive."}},
		[_M.BAD_ESCAPE] = 			{p_badescape,{"Unsatisfactory. We've trained to be better than this.","We must try harder next time.","I expect a full evaluation on the ways we could have improved our performance here."}},
		[_M.GOOD_ESCAPE] = 			{p_goodescape,{"Good show, team. Let's not get cocky.","Well done, everyone. If we keep this up, we may actually have a chance.","Not bad. To think all that training I invested in is actually paying off for a change.","Let's get back now. You've earned your rest."}},
		[_M.BLOODY_MISSION] = 		{p_bloodymission,{"This was brutal, perhaps, unnecessarily so.","A bloody mess, that's what this was. Perhaps we could try to keep things a little cleaner next time?","The cleanup fees will be a nightmare, I can tell.","They are the enemy, and today, we had to treat them as such."}},
		[_M.ABANDONING_OTHER] = 	{p_abandonedother,{"Unfortunate.","A mercy kill may have been kinder, but we don't have that luxury.","We'll prioritise detention facilities when we can. It's the best we can do.","I hate to leave an agent behind, but we have no other choice.","This has weakened our team. Let's try to pick up the pace."}},
		[_M.OW_INTERVENTION] = 		{p_savefromow,{"If you want something done, do it yourself.","Don't just stand there, find cover!","Don't be so sloppy. They nearly had you.","Don't let yourself be compromised again. We need all hands on deck.","Be more careful next time."}},
		[_M.SAVED_FROM_OW] = 		{p_ow_saved,{"",}},
		[_M.AGENT_DEATH] = 		nil, -- Central already has reactions to this	
	},

------------

	[_M.PEDLER] = {
		
		[_M.EVENT_SELECTED] = 		{p_selected,{"*Shall we proceed?*","*Do not waste my Time*"}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"*Such dirty work.*","*A necessary unpleasantry.*"}},  
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		nil,  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"*Enough with you!*","*Servo 3 is twitchy.*"}},	
		[_M.OVERWATCH] = 		{p_ow,{"*This way is watched.*"}},				
		[_M.OVERWATCH_MELEE] =		nil,	

	--	[_M.EVENT_MISS_GUN] = 		{1,{"*Servo 3 is twitchy*"}},		
		[_M.GOT_HIT] = 			{p_gothit,{"*Power... empty...*"}},			
		[_M.REVIVED] = 			{p_revived,{"*Let's not do that again.*"}},				
		[_M.HIJACK] = 			{p_hj,{"*Uploading virus.*"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"*I want to deconstruct this.*"}},	
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,
			
		[_M.INTERRUPTED] = 		{p_inter,{"*I have complications.*"}},				
		[_M.PEEK] = 			nil,							
		
		[_M.PIN] = 			{p_pin,{"*Such dirty work.*","A necessary unpleasantry.*"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"*My power grows.*","*I am now... more*","*I have integrated it.*","*I find this... satisfactory.*"}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			nil,	
		[_M.MEDGEL] =			nil,
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
		[_M.BAD_ESCAPE] = 		nil,
		[_M.GOOD_ESCAPE] = 		nil,
		[_M.BLOODY_MISSION] = 	nil,
		[_M.ABANDONING_OTHER] = nil,
		[_M.OW_INTERVENTION] = 	nil,
		[_M.SAVED_FROM_OW] = 	nil,
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"*There are ways to cheat death... but not this time.*",}},		
	},

	[_M.MIST] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Don't think... don't feel... just do it","I work for Invisible now."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"This will sting. Like a sea anemone.","I wonder what toxin this uses."}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"I feel your pain. Literally.","Looks like my training paid off.","That was surprisingly easy.","Okay. Now what?","Sometimes stealth isn’t the answer."}}, 
		[_M.OVERWATCH] = 		nil,  	
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"Experiment... failed.","Looks like I'll never see Iceland again"}}, 			
		[_M.REVIVED] = 			{p_revived,{"No... no... oh, it's you.","I knew I couldn't die."}}, 					
		[_M.HIJACK] = 			{p_hj,{"I can do things with this.","Power... yes..."}},  			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I found something.","How much can we buy with this?","Some day I'm going to have to ask someone to explain the financial system to me."}},				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"What? What's going on?"}}, 				
		[_M.PEEK] = 			{p_peek,{"See without being seen."}},							
					
		[_M.PIN] = 			{p_pin,{"I'm good at this part.","On/off... awake/asleep...","I know how your augments feel.","Is this what revenge feels like?"}}, 
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I've always wanted one of these.","So what percentage human am I now?"}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"I chose my new name for a reason.","You can't see me"}},	
		[_M.MEDGEL] =			nil,
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
		[_M.BAD_ESCAPE] = 		nil,
		[_M.GOOD_ESCAPE] = 		nil,
		[_M.BLOODY_MISSION] = 	nil,
		[_M.ABANDONING_OTHER] = nil,
		[_M.OW_INTERVENTION] = 	nil,
		[_M.SAVED_FROM_OW] = 	nil,
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"Gone, just like that... I could feel it.",}},		
	},

	[_M.GHUFF] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Time to make some new enemies"}}, 	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"You don't know how lucky you are.","Yeah, let's get this guy out of the way."}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Gotcha.","These things are kind of fun.","Zapped.","It's nothing personal."}},
		[_M.OVERWATCH] = 		{p_ow,{"Nobody sneaks up on me"}},	
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"You got lucky.","Too bad... things were just getting interesting..."}}, 			
		[_M.REVIVED] = 			{p_revived,{"Much obliged, friend.",}},					
		[_M.HIJACK] = 			{p_hj,{"Anything to get ahead.","Should I adjust the air conditioning while I'm here? This place is too damn cold."}},  			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Checking for hidden compartments.","What have we got here?","Leave no stone unturned.","There are people who'd kill for this much. Poor bastards."}}, 				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		nil,  				
		[_M.PEEK] = 			{p_peek,{"Leave the scouting to me.","My eyes see everything.","Got a real good view."}},							
					
		[_M.PIN] = 			nil,  
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Hmm... feels good.","Now we're in business.","Better quality than what my old friends sold."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Would you believe this is more illegal than anything else I've done?"}},	
		[_M.MEDGEL] =			nil,
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
		[_M.BAD_ESCAPE] = 		{p_badescape, {"What an absolute mess.","Let's try and not do *that* again."}},
		[_M.GOOD_ESCAPE] = 		nil,
		[_M.BLOODY_MISSION] = 	nil,
		[_M.ABANDONING_OTHER] = nil,
		[_M.OW_INTERVENTION] = 	nil,
		[_M.SAVED_FROM_OW] = 	nil,
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"Well, damn.",}},		
	},

	[_M.N_UMI] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"",}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"Die.","I've chosen my side."}}, 	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Dream for a while."}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Electricity has many uses.","If they could see me now.","If it's any consolation, your brain is more resistant to damage than delicate electronics are."}},

		[_M.OVERWATCH] = 		nil,  	
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"Remember... remember..."}},  			
		[_M.REVIVED] = 			{p_revived,{"Is my drone okay too?"}},  					
		[_M.HIJACK] = 			{p_hj,{"Fuel for my drone army! ...Just kidding.","Power transferred.","Interesting... but unlike some people, I can prioritize."}}, 			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Like robots, credits are just a tool. It's what you use them for.","I've searched it.","Empty now."}},				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		nil,  				
		[_M.PEEK] = 			nil,		
					
		[_M.PIN] = 			{p_pin,{"Everything has a power-off switch, if you know where to look."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Why does this process seem vaguely familiar?","Not the absolute highest quality, but it'll do.","I could improve this, but we don't have the time."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"I can't help but be awed by this tech."}},
		[_M.MEDGEL] =			nil,
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
		[_M.BAD_ESCAPE] = 		nil,
		[_M.GOOD_ESCAPE] = 		nil,
		[_M.BLOODY_MISSION] = 	nil,
		[_M.ABANDONING_OTHER] = nil,
		[_M.OW_INTERVENTION] = 	nil,
		[_M.SAVED_FROM_OW] = 	nil,
		[_M.AGENT_DEATH] = 		{p_agentdeath, {"Life is impermanent.",}},		
	},	
	
	[_M.CARMEN] = {
		
		[_M.EVENT_SELECTED] = 	{p_selected,{"Here we go.","What's good, Opera?","I'm listening.","You're coming in loud and clear. Where to next?"}}, 
		[_M.ATTACK_GUN] = 		{0.2,{"I swore I would never do this....","I just stole something I can never give back.",}}, 	
		[_M.SHOOT_DRONE] =		{p_shootdrone,{"I've got my own gadgets to deal with you.",}},
		[_M.SHOOT_CAMERA] =		{p_shootcam,{"No peeking!","Lights out.","I'm not looking to get on camera today.",}},
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Don't worry, you won't feel a thing.","Taking him out from a distance.","There we go.","All clear!",}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"This is going to sting.","Sorry, you're in my way.","Easy now.","Okay, he's down.","He's out.","I'm taking him out.","I've gotta be rough here, sorry."}},

		[_M.OVERWATCH] = 		{p_ow,{"I'm ready.","I'll give you the cover you need.","I've got the room covered.",}}, 	
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"Ow, that... hurts...","I think I have to... stop here...","Good thing I... wore red...","It's fine, go on... without me...","I might have to... take a break...",}},  			
		[_M.REVIVED] = 			{p_revived,{"Ow. Still stings.","Thanks. I feel better already.","Didn't search my pockets for loose change first, did you? Wouldn't blame you.","They owe me a new coat.","Thanks. I'll be fine.",}},  					
		[_M.HIJACK] = 			{p_hj,{"I'm in the system.","Let's see what we have here...","I'm in.","That's one cluttered desktop.",}}, 			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I've got the valuables.","This goes straight in my pockets.","I prefer stealing artefacts, myself.","Maybe we can donate some of this when we're done.","I know a children's charity that could use some of this.","Don't worry, I left them a consolation note.","All clean now.","Bait and switch. Easy enough.",}},				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_loot,{"Drat!","Hey there.","Looks like you've caught a peek of me. You'll have to try harder than that to catch me.",}}, 				
		[_M.PEEK] = 			{p_peek,{"Let's see what's going on here...","Eyes and ears open.","A quick look inside.","I think I got a pretty good look.","Interesting...",}},		
					
		[_M.PIN] = 			{p_pin,{"Keep still, now.","Don't mind me while I go through your pockets.","I'll make sure he stays like this. Wouldn't want him walking around again.",}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"It's not the tech that makes the thief. But it helps.","This should be useful!","Ouch, I'm going to feel that one for a while.","This will take some getting used to.",}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"They won't see me like this.","Time for a bit more subtlety.","I guess the public appearance will have to wait.",}},
		[_M.MEDGEL] =			{p_medgel,{"You alright?","It's okay, I've got you.","We need to get you out of here...","Take it easy, now.","You got shot. But you're all better now.","I'm sure you're disoriented. Stay calm and follow my lead.",}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Time to fly the coop.","I'm sure you want to stretch your legs.","Now for the fun part.","The more, the merrier!","Good to have you onboard.",}},
		[_M.BAD_ESCAPE] = 		{p_badescape,{"Oof. At least we got away...","That could have gone better.","Better luck next time.","We'll need a better plan.","That was too close.",}},
		[_M.GOOD_ESCAPE] = 		{p_goodescape,{"My pockets are full. Nice.","We sure showed them!","Reminds me of that heist in Cairo.","These villains are no match for us.",}},
		[_M.BLOODY_MISSION] = 	{p_bloodymission,{"That was... gruesome.","This wasn't the deal. I can't work like this.","We stole so many lives...","This isn't how it should be.","Sometimes I think you people are no better than V.I.L.E....",}},
		[_M.ABANDONING_OTHER] = {p_abandonedother,{"No! We have to go back, we have to!","Never leave someone behind... I used to follow that motto.","...","< sigh >",}},
		[_M.OW_INTERVENTION] = 	nil,
		[_M.SAVED_FROM_OW] = 	nil,
		[_M.AGENT_DEATH] = 		nil,		
	},	

------------
	
}

return DLC_STRINGS
