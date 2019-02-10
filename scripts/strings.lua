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
	DISGUISE_IN = 129,		-- for Prism's disguise
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

}

-- Speech chance  list
-- Can be edited here centrally to change the chance that line will fire for a specific trigger, for all agents.
-- If need be, agent-specific chances can still be tweaked by directly using a number there.

local p_gun = 0.7
local p_gunko = 0.7
local p_melee = 0.5
local p_ow = 0.4
local p_gothit = 1
local p_revived = 0.8
local p_hj = 1 --0.5
local p_loot = 0.5
local p_inter = 0.5
local p_peek = 0.1
local p_pin = 0.7
local p_augm = 1
local p_cloak = 0.8
local p_medgel = 0.8
local p_rescuer = 1 --0.5


local DLC_STRINGS =
{	       	
	OPTIONS =
	{
		MOD = "Talkative Agents",
		MOD_TIP = "<c:FF8411>FOR AGENTS</c>\nDecker\nInternationale\nShalem 11\nBanks\nNika\nPedler",   	
						
	},

	-- Decker
	[_M.DECKER] = {
	--	[_M.EVENT_SELECTED] = 		{0.2,{"You as ready as I am?","Like old times","Running silent"}},  
		[_M.ATTACK_GUN] = 		{p_gun,{"Here we go.","Taking aim."}},  
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
		[_M.MEDGEL] =			{p_medgel,{"Typical, really.","Think you can pack it this time?","< Sigh >","Quiet. Job ain't over.","Heads up, we're still on the clock.","Don't mention it."}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Pack your bags, pal.","You coming, or what?","Looks like today's your lucky day."}},
	},

	-- Xu
	[_M.TONY] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"Aim and fire... simple enough","Hm, I don't suppose he'll be getting back up...","That ought to clear the air a bit.","An unfortunate necessity."}},  	
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

		[_M.INTERRUPTED] = 		{p_inter,{"Could be a problem.","Not ideal."}},  	
		[_M.PEEK] = 			{p_peek,{"Information is key.","Let's not charge in blindly.","Scouting area.","Surveying the room."}},  	
		
		[_M.PIN] = 			{p_pin,{"Enemy subdued.","This one won't be going anywhere.","Target pinned.","I hope you're comfortable.","I have it under control."}},  
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I cannot wait to use this.","This seems promising.","I've always wanted to try that.","Still more human than some people I could name.","Efficiency improved.","I'll tinker around with this later."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Too bad this won't last for long.","That's some incredible tech.","I could get used to this.","The tricky part is not tripping over yourself.","It's a shame I didn't have this years ago.","You know, Clark's third law says that... Alright, maybe now is not the time","And for my next trick..."}},	
		[_M.MEDGEL] =			{p_medgel,{"Good as new.","Are you alright?.","Quiet! We're still in the field.","Welcome back."}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		{0.5,{"This better not become a habit.","Whatever gives us the edge on them."}},
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"No time for pleasantries, I'm afraid."}},
	},


	-- Shalem
	[_M.SHALEM] = {
		
	--	[_M.EVENT_SELECTED] = 		{0.2,{"Almost time for a G and T dont you think?","What do you need, beautiful?"}},  
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
			
		[_M.INTERRUPTED] = 		{p_inter,{"Target ahead.","Target sighted."}},			
		[_M.PEEK] = 			{p_peek,{"No surprises.","Searching for hostiles.","Scouting ahead.","Active recon."}},
		
		[_M.PIN] = 			{p_pin,{"Shouldn't I just... shoot him?","Taking prisoners isn't really my bag.","...So how's your pension plan?","This could get dull.","Target subdued.","I've got him pinned."}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"So long as it's useful.","This better work.","This better not slow me down.","More metal or less, it doesn't change anything.","Whatever it takes to win."}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Hidden.","Seems a bit like cheating, doesn't it?","Cloaked.","Better not get too used to this."}},
		[_M.MEDGEL] =			{p_medgel,{"Try to stay on your feet this time.","Eyes sharp now.","We're not done here yet.","By all means, take your time...","Don't take it personally.","Get up. We need to move."}},
		[_M.WAKE_OTHER] =			nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		{1,{"Try this."}}, -- sorry had no better ideas
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		{1,{"I... uh..."}}, -- sorry had no better ideas
		[_M.RESCUER] = 			{p_rescuer,{"Oh, you. What was your name again?","Try to  make yourself useful..."}},
	},
	
	-- Banks
	[_M.BANKS] = {
		
	--	[_M.EVENT_SELECTED] = 		{0.2,{"And I thought VillaBank was a hard job.","Keep moving"}},
		[_M.ATTACK_GUN] = 		{0.3,{"Guns, I hate these things","Do we really have to do this?","Sometimes I miss the solo gigs"}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"I could get used to this","I'd leave ya an asprin if I had one","Believe me, buddy, I'm doing you a favor","He's down","I've got him","He's tranquilized","He's still awake? Oof. No, there we go","Yup. He's gonna have a headache"}},							
		[_M.ATTACK_MELEE] = 		{p_melee,{"Zappy would have been nice right now","Facing a lot of resistance right now","Down he goes!","Aaagh... everything's under control","Sparkly","How about you rest for a while?","Take a little break, okay?","Shhhhhh."}},					
		[_M.OVERWATCH] = 		{p_ow,{"Holding here","Watching the way","I'm on it","I'm ready, I'm ready.","Okay..."}},				
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"I guess... I tried... one too many.","Doesn't... hurt... at all...","Had... a good run","It'll... be okay..."}},				
	--	[_M.EVENT_MISS_GUN] = 		{1,{"Ok, ok, I'm learning","Dammit! Harder than it looks"}},	
		[_M.REVIVED] = 			{p_revived,{"I owe you for that one.","Not a dream, then...","How many lives left?","Owww.","Mmm, guava.","Aaugh! I'm up, I'm up!"}},					
		[_M.HIJACK] = 			{p_hj,{"Just gotta bypass the... Done!","Easy peasy","I wrote this code in Haiku","CPU, I own you","This console reeks of coffee","Knock knock little machine","Ooh, this still has Minesweeper"}},		
		[_M.SAFE_LOOTED] = 		{p_loot,{"Who wants stuff?","Come to mamma","Do I really have to share this?","I love this part","Nice!","Oh yeah, here we go","Sweet.","Got the booty!","Not too shabby"}},	
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,
				
		[_M.INTERRUPTED] = 		{p_inter,{"Uh oh","Hold your horses","Wait a second"}},					
		[_M.PEEK] = 			{p_peek,{"I see them, but they don't see me","Swift and silent","I know what lies in wait","I see the way ahead","Crap, they saw me- Ok nevermind, I'm good"}},								
		
		[_M.PIN] = 			{p_pin,{"Just stay there, buddy","It will go better for you if you don't move","I could sing you a lullaby while we're here","Feel free to stay down"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Will this fix me?","Another one","I can hear it inside me","This will keep me company","We're all just automatons in the end","Two lefts can make a wrong"}},						
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Invisible, intangible, I have become air.","Into nothing I return","Light as a feather","...Am I a ghost?","I can't see my- Oh. I forgot.","A puca now roams these halls","I vanish"}},
		[_M.MEDGEL] =			{p_medgel,{"Shh. Just let them sew you up","Easy there, buddy","You okay?","Wow, that's a lot of blood.","I'm sure you'll be fine!","You'd do the same for me, right?","Don't worry, I've got you.","Does that hurt?","Don't worry. The pain is how you know it worked."}},
		[_M.WAKE_OTHER] =				nil,
		
		[_M.PARALYZER] =		{1,{"Sleep well","Shhhh.","Don't worry, you'll miss all the bad parts","You won't remember any of this","No one has to get hurt","Safest place for you to be is nowhere"}},
		[_M.STIM_SELF] =		{0.5,{"This should help.","Already feeling things clear up...","Wow, I can focus! That's great!","Is this what being normal feels like?","It's like the fog in my head just... poofed","Ok, ok, so what do I do next?"}},
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Let's hit the road!","Doesn't look too comfy.","Come on!"}},
	},

	-- Internationale
	[_M.INTERNATIONALE] = {
	
	--	[_M.EVENT_SELECTED] = 		{0.2,{"You're coming in clear","On the team"}},  
		[_M.ATTACK_GUN] = 		{p_gun,{"I do not like this.","This is the only way","Count to three, pull the trigger...","Deep breath..."}},  
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Delivering toxin","Clearing things up","Let's open the way","Taking him down"}}, 		
		[_M.ATTACK_MELEE] = 		{p_melee,{"Too bad we can't talk this out","Sorry, friend","This will probably sting","Libertad!","El enemigo está bajo control","Awaiting further instructions"}},				
		[_M.OVERWATCH] = 		{p_ow,{"Ok, focused in","I will take care of it","I've got it","Everything's under control","Keeping a look out"}},			
		[_M.OVERWATCH_MELEE] =		nil,
							
	--	[_M.EVENT_MISS_GUN] = 		{1,{"Target is obscured!","Need a better angle"}},	
		[_M.GOT_HIT] = 			{p_gothit,{"I can't feel my... ","No, I...","Damn... you...","For... the team..."}},			
		[_M.REVIVED] = 			{p_revived,{"That really cleared things up.","Thank you. I mean it.","Back in the fray","That was too close","For a moment there, I thought...","I knew I could count on you"}},			
		[_M.HIJACK] = 			{p_hj,{"I'm on it","Installing virus","Let's see what their security is like","No obstacles encountered","Accessing their system"}},		
		[_M.WIRELESS_SCAN] = 		{1,{"Scanning area","Pinging the mainframe","Homing in on the signal","A lot of noise around us.","I see them!"}}, -- rather test	
		[_M.SAFE_LOOTED] = 		{p_loot,{"Busted open","Secrets revealed","Time to redistribute","New assets acquired","New capital under our control"}},				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"I've spotted something","There's something here"}},					
		[_M.PEEK] = 			{p_peek,{"Scouting ahead","I know what's coming","Area sighted","I have eyes on this"}},					
		
		[_M.PIN] = 			{p_pin,{"I shouldn't sit here long","I suppose this is more merciful","Too bad you're unconscious. There are things I could tell you about your rights as a worker","I'm just gonna leave this leaflet in your pocket, okay?"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Whatever it takes to get the job done","More than the sum of my parts","I can use this","I hope this doesn't make me start drinking"}},								
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Time for stealth","The subtle approach.","I can see why Brian likes this trick so much","Cloaked and ready","Cloak active"}},
		[_M.MEDGEL] =			{p_medgel,{"Take it easy.","Easy now.","Next time, be careful.","All good?","It'll be okay.","Let's get you out of here","We don't have time. Can you walk?","We're not safe yet. Focus.","Don't worry, they'll pay for this","You okay? You just need to make it to the exit"}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"We're getting you out of here.","No pressure, but we need to leave. Now."}},
	},

	-- Nika
	[_M.NIKA] = {
		
	--	[_M.EVENT_SELECTED] = 		{0.2,{"Vil get it done.","zey vont get avay vit dis"}},  
		[_M.ATTACK_GUN] = 		{p_gun,{"With lethal force","Terminating","Taking action","...\nHe's down.","Enemy down","Target down","Threat eliminated","Neutralized.","...","Hm.","......"}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Tranquing","Knocking out the target","...","...","Neutralizing target"}},  
		[_M.ATTACK_MELEE] = 		{p_melee,{"...","These guards are not good enough","He is down","Ready for the next target.","Hah!","Who's next?","Hm. Gets the blood flowing"}},	
		[_M.OVERWATCH] = 		{p_ow,{"Covering this zone","Will get it done","Standing guard","Ready to intercept"}},				
		[_M.OVERWATCH_MELEE] =		nil,											
	
	--	[_M.EVENT_MISS_GUN] = 		{1,{"Zey have cover"}},		
		[_M.GOT_HIT] = 			{p_gothit,{"Do svidanya...","Ne... ne mogu...","I'll...","Nghk...","Operator, make sure the team is..."}},				
		[_M.REVIVED] = 			{p_revived,{"Spasibo","They cannot stop me","Thank you.","... \nI'm up."}},				
		[_M.HIJACK] = 			{p_hj,{"Virus installed","Device hacked","...","...\n I have the device."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I have captured something","Supplies.","..."}},	
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,		
			
		[_M.INTERRUPTED] = 		{p_inter,{"Wait!"}},					
		[_M.PEEK] = 			nil,								
		
		[_M.PIN] = 			{p_pin,{"I will break you","Stay down.","I have him","He will not move, trust me","Target subdued"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Hmm.","Good.","...","Stronger now."}},								
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"...","I am cloaked.","Concealment active","Very well. If it is stealth you need."}},
		[_M.MEDGEL] =			{p_medgel,{"Get up.","Ne zha shto.","...","...Good?","Move.","You're awake. Good.","Stay behind me.","...\nStay close to me if you cannot handle yourself.","We have work to do. Don't slow me down again","You need to be better."}},
		[_M.WAKE_OTHER] =		nil,
	
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"You can still walk. Good.","I'm here to free you.","Follow me."}},
	},
 		
	-- Sharp
	[_M.SHARP] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"Nowhere to run, meatbag","This takes me back","Perfect execution","You should thank me","They always drop too quickly","Perish."}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Pathetic.","Exploiting systemic vulnerabilities...","Foiled by a chemical","That was too easy","See, and that's why organic blood is a bad idea"}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Hardly an opponent","It didn't stand a chance","No match for me","Frail excuse for an organic","Obsolete piece of meat","Heh.","Are you watching, Operator?","This is how it's done"}},					
		[_M.OVERWATCH] = 		{p_ow,{"Armed and ready","They won't know what hit them","Prepared for perfection","Watch and learn","Time to make this look good"}},				
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"I... refuse...!","I am NOT... this... fragile...","Missed... me...","No, NO! I'm not...","Like that's gonna... stop me..."}},			
		[_M.REVIVED] = 			{p_revived,{"I didn't need your help","I was just resting","Ugh. Don't look at me.","Don't touch me.","Hands off, I'm fine!","..."}},					
		[_M.HIJACK] = 			{p_hj,{"Uploading virus","Even their digital systems fall short against me","Interfacing with a vastly superior being","Finally, some better company","Accessing data"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I have the goods","Looting the container","This should buy me an upgrade or two"}},
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,
					
		[_M.INTERRUPTED] = 		{p_inter,{"Stop","This changes things","Adapting"}},				
		[_M.PEEK] = 			nil,							
		
		[_M.PIN] = 			{p_pin,{"Ugh, I think it's still alive","Stop twitching!","Why am I wasting my time here?","This is humiliating","Do I really have to be touching him? Can't I just... no?","Do you know how easy it would be to snap his neck?"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Perfection is hard to improve, but I believe that did the trick.","At last!","One step closer to perfection","Yes!","I am even more optimized","I think that one had a scratch on it","Acceptable.","Only the finest","This better not be some cheap knock-off","Who could bear to look upon such beauty?","Look at me. Do NOT touch.","Are you sure that was the best we had?","Working with a pile of meatsacks is worth it, for this"}},											
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Not certain if I like this","...Still more attractive than anyone here.","I prefer my enemies to look me in the face before I obliterate them","Undetectable. Yet another on my long list of traits","This hardly seems necessary"}},
		[_M.MEDGEL] =			{p_medgel,{"Pathetic.","Don't get your juices on me, meatbag.","That only delayed the inevitable, you know.","You're up? Good, because I refuse to drag you","See? That was me, being a good teammate","I just saved your life, you worthless sack of juice.","There. Try not to fall over yourself with gratitude","You can thank me later. Cash is best"}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Waste of time, really.","Oh, good. You can carry my things."}},
	},
	
	-- Prism
	[_M.PRISM] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"Let's get this over with","Taking him down","Time to pay, pig","Roll credits","Oh yeah. He's down",}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"He's one of the lucky ones","I guess that's one way to deal with them","Oh yeah. He's down","Time for your nap"}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Guess what? That wasn't a prop","Corporate pig","This does make me feel better","How's that for a stunt?","Yeah, I don't think so"}},					
		[_M.OVERWATCH] = 		{p_ow,{"Sweet","They won't get past me","I'll show them","Time to dazzle"}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"No! I won't...","Can't... be...","Nice shot, asshole."}},			
		[_M.REVIVED] = 			{p_revived,{"They'll pay for that","Back in the floodlights","Think this could stop me? Watch.","Thanks, I guess","Yeah, um... I owe you one."}},					
		[_M.HIJACK] = 			{p_hj,{"Uploading program","Siphoning the PWR","This device is ours now"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Good thing we stopped by","X marks the spot","My favorite moment","I'm sure they won't miss this","Not a bad haul"}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Hold it","What was that?"}},				
		[_M.PEEK] = 			{p_peek,{"Path scouted","I see all","Nothing shall slip me by"}},								
		
		[_M.PIN] = 			{p_pin,{"If you're smart, you won't wake up","I've got him under control","Got it. Enemy pinned","What now?","Already bored","This could get old, real fast"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I should get some nice mileage out of this","Just what I've been looking for","Damn, that stings","Sweet, an upgrade","I better not turn into one of those chrome nuts"}},														
		[_M.DISGUISE_IN] =		{1,{"Time to become someone else","They won't know what hit them","Let's do some acting","Roll out the red carpet","First and final take","Just like the good old days","This takes me back","Ahem. Just an ordinary guard...","Hey there, fellow security..."}},
		[_M.CLOAK_IN] =			{p_cloak,{"Out of sight, out of mind","Bit of a strange feeling, this","I do not need this to blend in","Putting the 'invisible' in... well, you know.","Just like magic, but better"}},	
		[_M.MEDGEL] =			{p_medgel,{"Let's get moving","You good? Okay, let's go.","Can't laze around forever, you know.","We ain't got all day","Try not to collapse till we're in the clear.","Oh good, you're still alive.","You're welcome.","You wanna get out of here or what?","Let's not stick around"}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Good news. This is officially a jailbreak."}},
	},
	
	
	-- Olivia
	[_M.OLIVIA] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"Eliminating the target","Clean and precise","Enemy neutralized","That's one less for us to deal with"}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"He's down. Let's not waste time","That ought to do it","Enemy neutralized","Clean and precise"}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"He's dealt with.","Aggressor neutralized","Time to get rough, then","That ought to teach you","Threat removed, I would say"}},				
		[_M.OVERWATCH] = 		{p_ow,{"I'll keep a watchful eye","Readying my sights","I'll show these boys a thing or two"}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"No! They mustn't...","You... bastard...","No... I still need to...","Damn you...","You can't... take me alive..."}},			
		[_M.REVIVED] = 			{p_revived,{"Good. I'm not done with them yet","I'm still alive? I suppose they've never had the best aim...","Only a minor setback","You have my thanks, agent","I've weathered worse than that"}},										
		[_M.HIJACK] = 			{p_hj,{"Uploading the worm","Subverting enemy tech","Another asset gained","Virus installed"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Well this should prove useful"}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Oh, bother","Hmm, what's that?"}},				
		[_M.PEEK] = 			nil,								
		
		[_M.PIN] = 			{p_pin,{"I've got him pinned down","Under control","He's not going anywhere"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I suppose that's useful enough","An augment is only as good as its host","I'll make do with this","Anything to give us the edge","Power can have many forms","A beneficial upgrade"}},														
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Can't see me now, can you?","Cloak in."}},	
		[_M.MEDGEL] =			{p_medgel,{"Enough dilly-dallying","Look sharp, we're still in enemy territory","That was a close recovery","You should be fine for now","Do try not to get shot next time","Don't be so sloppy"}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"I believe you're overdue for a change of scenery.","Do not dally. They're coming for us.","Take it easy, agent. We're here for you."}},
	},
	
	
	-- Derek 
	[_M.DEREK] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"Well. That takes care of that","Time to get messy","Try not to splatter too much","Taking aim","Ugh, I suppose this is unavoidable..."}},	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Take a nap, my friend","Why don't you have a lie-down?","Well that takes care of that","I should get one of these custom-made","If I could just rewire this a bit..."}},								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Okay, acquiring this thing was worth it","I'm looking forward to the contents of your pockets","Subduing the enemy","Well that takes care of that","Ah, wetwork","That's quite enough","Do be quiet","I'm taking him out","Enemy engaged"}},						
		[_M.OVERWATCH] = 		{p_ow,{"This is really so uncivilized","Prepared to take action","Watching this area","Ready to fire","Preparing a nasty surprise"}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Well, that's...not good...","I blame... the  management...","Corporate... scum...","No, not after everything...","Not... like this...","I can't be..."}},			
		[_M.REVIVED] = 			{p_revived,{"Ugh. Do I even get hazard pay?","A second chance","Let's up the stakes","Back in the game","My thanks, friend","Remind me to thank you later"}},					
		[_M.HIJACK] = 			{p_hj,{"Money is power, but so is data","Let's take a look at this darling","Time to get to work","Ths is what I'm here for","And now the real job begins","Subverting enemy mainframe","Ahhh, now this? This is more like it","Just look at this system - how quaint"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"A penny stolen is a penny earned","Let's wipe this place clean","This is pocket change to them. But it's our pocket change now","Let's grab this and run","Marvelous. Anything else we could lift?","Can't leave this lying around","Let's put this to use","I imagine they'd want to keep this. That's too bad.","Now that's what I call rewarding","This day just got better"}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"Well, this is new","Ah, I see","One moment"}},			
		[_M.PEEK] = 			nil,								
		
		[_M.PIN] = 			{p_pin,{"Keeping him down","I've always aspired to be someone's hired muscle","Enemy pinned","Well this could get old rather fast","He's not going anywhere"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Time to embrace the new age","Ah, the wonders of technology","Not a bad choice","I wasn't attached to that bit of tissue anyway"}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"This is more my style","I'm sure I could tweak this to work longer","Now that's some toy","I like this"}},	
		[_M.MEDGEL] =			{p_medgel,{"You are quite fortunate to have modern medicine on your side","There you go, friend","Can you walk? Marvelous","Don't worry, the stinging is how you know it's working","Come on, I'll help you up","Friends don't let friends bleed out on the ground, remember","Stick to the buddy rule next time","You'll have to make that up to me","Let's move along now","Good. Saves me the bother of dragging you."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			{p_rescuer,{"Yeah, yeah. You can thank me later."}},
	},
	
	
	-- Draco
	[_M.DRACO] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"See you in hell","More prey","Add this to my tab","It is almost too easy","I wonder what you've got for me"}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"How dull","Inadequate","Won't stay down for long","This is your lucky day","You look tired, friend"}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Bothersome","This is how it feels!","A shocking experience","For your own sake, stay down","...You were saying?","The hunter strikes"}},					
		[_M.OVERWATCH] = 		{p_ow,{"The hunter awaits","Prepared to strike","Enemies beware","The element of surprise!","Muscles tense, his focus didn't waver, not for a moment","Trust me, I'm not afraid to use it"}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Careless... of me...","Not... again...","You'll never... take me alive...","Never hear the end... of this..."}},			
		[_M.REVIVED] = 			{p_revived,{"No rest for the wicked","This chapter is still unfinished","Like a bat out of hell","Someone will pay for that","He shall rise again","Takes more than that to keep me down","Frankly I'm not great at dying","I live!","I am in your debt"}},					
		[_M.HIJACK] = 			{p_hj,{"Truly thrilling","Though boring it may be, it's part of the job"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Finders keepers!","Well, hello there","Would be a shame to leave this here","No one will miss it, I am certain","Ours for the taking","A treasure trove"}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"There you are!","How am I just seeing this now?"}},				
		[_M.PEEK] = 			{p_peek,{"Senses sharpened","A quick look is enough","Curiosity saved the cat","Just to be sure I don't fall prey to another","He was silent and careful, nothing gave him away"}},								
		
		[_M.PIN] = 			{p_pin,{"Don't make me do anything you'll regret","I should have brought a book","If you're lucky I won't be anywhere near when you wake up","So... is the insurance good?","Here we are. Just you, me, and your brain","I can read you like a book","Let's peek between those pages.","The hunter swoops, pinning his prey"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Surprisingly refreshing","Evolve to survive","This just got more interesting","The craving has eased a little","They are not ready for what I am now"}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Into the shadows","With a light step","Now you see me... now you don't","You saw nothing","Fading into darkness","They won't see me coming","Striking from the shadows"}},
		[_M.MEDGEL] =			{p_medgel,{"Rise and shine!","Awaken.","I command you: rise.","This should knit your flesh together.","Next time, do not let them catch you."}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		{1,{"A paralyzing bite","Your slumber deepens"}},
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
	},
	
	
	
	-- Rush
	[_M.RUSH] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"I like it when we don't hold back","Unpleasant, but at least it's not boring","No more than they deserve.","I prefer a personal touch","Taking out the target","This is what you get"}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"See? I can do bloodless","I would have rocked the biathlon, if I'd bothered","Perfect aim. As always","He's down, but still in the game","Couche-toi","Taking him out"}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"I'm so good at this.","This is so much faster than stealth","That was subtle, for me","Sucker.","Is that what they call armed force? Pathetic.","I expected better.","Next!","Not so tough now, are you?","You better hope I didn't break a nail, buddy"}},					
		[_M.OVERWATCH] = 		{p_ow,{"Got it covered","All right, I'll wait","Fine, I'll do it","Lying in wait","Prepared to ambush","I'm watching this area"}},				
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Like you could... stop me...","What? No...","I don't believe...","Worth it...","Damn... you...","Casse-toi...","Operator? So the bad news is..."}},			
		[_M.REVIVED] = 			{p_revived,{"Let me at them!","They'll have to try harder than that","Ugh, fine, I'll buy you a drink later"}},					
		[_M.HIJACK] = 			{p_hj,{"There, tech, do your techy thing","Knowing how this works isn't my job","Why are we bothering with these, again?","System... you know, whatever","Uh, open sesame?"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Bingo","Smash. Grab. Okay, less smashing than I'd like","Is this all? I thought these people were rich","Money? Well, I won't say no","Hm. Underwhelming."}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"What's the hold-up?"}},				
		[_M.PEEK] = 			{p_peek,{"Nothing I'd consider interesting"}},							
		
		[_M.PIN] = 			{p_pin,{"And here I thought this job would be exciting","...How long do I have to do this?","I'm not here to babysit","Enemy pinned. If that helps"}},	
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I swore I was done with these","Ugh, if I have to.","Ow.","I don't need that. I'm already the best.","You want to turn me into some sort of cybersoldier? Fine, whatever"}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"So, uh... what now?","Cloak and dagger isn't really my style","Can I do something useful for a change?","Cloak active. For whatever that's worth","Whoo! Pretty fun."}},	
		[_M.MEDGEL] =			{p_medgel,{"Next time, I just leave you behind.","See? I can do teamwork!","I don't have time to babysit","Hurts, huh? Suck it up and let's go","You up? Good. Get a move on","This? This is slowing me down.","Clock's ticking","You're less of a dead weight now","Walk it off.","Sheesh.","< Eyeroll >"}},
		[_M.WAKE_OTHER] =			{1,{"Stand up"}}, -- sorry had no better ideas
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		{1,{"A little overclock can't hurt","Zing. Where to?","GAME ON.","Not as much of a rush as it used to be.","Whoo! Yeah! Let's do this!","READY SET GO.","So much for trying to shake that habit"}},
		[_M.STIM_OTHER] =		{1,{"Try this"}}, -- sorry had no better ideas
		[_M.SELF_STIMMED] = 		{1,{"Refreshing!"}}, -- sorry had no better ideas, test
		[_M.STIMMED_BY] = 		{1,{"Thanks, pal."}}, -- same
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
	},
	
		-- Monst3r
	[_M.MONSTER] = {
	--
		[_M.ATTACK_GUN] = 		{p_gun,{"Inelegant, but this isn't a civilized age","Call me squeamish, but this isn't really my preferred M.O.","Enemy snuffed. Enough of a euphemism for you?","All that work tinkering with that gun, and I still have to do... this."}}, 	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Guess what? You get to test my new prototype","And here I thought I'd put these days behind me","Now this is more like it","Tranquilising the target. Happy now?"}},  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Well that takes care of that.","Some things you don't forget. Like riding a bike","Not my preferred weapon, but it works","A little trip down memory lane","Oof. I'm not as young as I used to be, you know!"}},					
		[_M.OVERWATCH] = 		{p_ow,{"They won't be passing through here, I assure you","I'll keep an eye out","Ambush prepared"}},
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"Didn't see that coming","Well that was unwise...","I seem to have made a...","That really... stings...","Gladstone, are you there? I...","No, that's not how it's supposed to...","You... corporate... fiend..."}},	
		[_M.REVIVED] = 			{p_revived,{"Good. I'd rather not have to take one for the team","Oh, splendid","Didn't think you'd be rid of me that easily, did you?","That one's bound to leave a mark","Oh, thank you. A refreshing bout of competence","Ngh. Much appreciated.","I've missed this. Having someone who has my back, I mean.","Urghh. Thank you, I shall be fine now.","Still stings, but this should keep me on my feet until we're out, at least."}},					
		[_M.HIJACK] = 			{p_hj,{"Finally, back to my comfort bubble","Do try to avoid bringing down any heat while I'm busy","Almost makes me want to get back into software","No meowing. Thank goodness","At least that was easy","Now what do we have here?","Hmmmmm... interesting","Ah! I recognise this.","I can work with this, yes."}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Would be a terrible shame to leave this lying around...","Money. I'd know it anywhere","Oh good, we could use some new toys","I like you, so I won't take my usual percentage","I'll find a good home for this","This could be useful, I'm sure"}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		nil,				
		[_M.PEEK] = 			{p_peek,{"Knowledge makes the man","Let's see what's ahead"}},															
			
		[_M.PIN] = 			{p_pin,{"Undignified for both of us, isn't it?","What do you take me for - some kind of thug?","I have the enemy pinned, if that helps","I'd much rather be doing something else with my time","My usual job involves a tad more sophistication.","I have him pinned"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Ooh, I think this one's a limited edition!","Hmph, if I must","Not too shabby","Not inadequate, but I do miss my old suppliers"}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"I do love these new toys","This is incredibly satisfying","This should give them the slip","It is time to... disappear","Whoosh. Ahem, that ought to do it.","More my style."}},
		[_M.MEDGEL] =			{p_medgel,{"Oh, good. I wasn't looking forward to having to drag you around.","Do be more careful next time","You're welcome. I'll be sending you the reimbursement bill later","Someone has to pull their weight around here. Might as well be me","Gladstone's always excelled at risking her live assets. You're spared that fate, for now","You know she still considers you expendable, right?"}},
		[_M.WAKE_OTHER] =		nil,
		
		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
	},	

	
			
			
		-- Central
	[_M.CENTRAL] = {
	
		[_M.ATTACK_GUN] = 		{p_gun,{"Obstacle eliminated","Taking the shot","I'm doing this for her","Doing what must be done","Let's keep the mess to a minimum","If I have to get my hands dirty, so be it"}},	
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Temporarily neutralized", "Done. Now let's not waste time","Taking the shot","An elegant, quiet solution","Let's not be here when he wakes up"}},								
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_MELEE] = 		{p_melee,{"Brutal, but effective","This one won't get in our way","The sooner this is over with, the better","Deep in the nit and grit of it","Let's make sure they don't stand in our way","I still remember how to do this"}},					
		[_M.OVERWATCH] = 		{p_ow,{"I have my eyes peeled","Preparing the ambush","Ready for hostiles","Ready to engage","Overwatch ready"}},		
		[_M.OVERWATCH_MELEE] =		nil,
		
		[_M.GOT_HIT] = 			{p_gothit,{"No! We were... so close...","I have... to finish...","After all this time...","This won't be how... we lose...","Incognita? You must..."}},			
		[_M.REVIVED] = 			{p_revived,{"Back into the field","I will not be held back by the likes of this","Good. We have work to do","You're earning your keep, agent","Good. Let's continue.","You're only doing your duty, but don't think I don't appreciate that."}},					
		[_M.HIJACK] = 			{p_hj,{"Subverting the system","She now has access to this","Power. There's no need to comment on the irony","A little something extra for her to work with"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I never thought we'd get this desperate","This should prove useful","Let's pick their bones clean","Time to play the common thief"}},					
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"There's something here","Ah."}},				
		[_M.PEEK] = 			{p_peek,{"Let's not get sloppy","Scouting ahead","I see the way"}},								
				
		[_M.PIN] = 			{p_pin,{"Let's keep things under control, shall we?","All this troble just to avoid bloodletting. Pity he won't appreciate it","I have this one subdued","I'm keeping him down"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"This should prove useful","Our bodies are such a small price to pay","It's been installed seamlessly. Good.","Better this than being under-equipped","We need every edge we can get"}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"Such a rare and useful bit of tech","Cloak engaged"}},	
		[_M.MEDGEL] =			{p_medgel,{"Back on your feet, agent","I need you on your feet. There we go","Pay more attention next time","Keep your head down. I'll get you out of here, I promise.","Don't thank me yet. If they capture you, you're going to wish I'd let you bleed out"}},
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
	},

------------

	[_M.PEDLER] = {
		
	--	[_M.EVENT_SELECTED] = 		{0.2,{"*Shall we proceed?*","*Do not waste my Time*"}}, 
		[_M.ATTACK_GUN] = 		{p_gun,{"*Such dirty work*","*A necessary unpleasantry*"}},  
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		nil,  								
		[_M.ATTACK_MELEE] = 		{p_melee,{"*Enough with you!*","*Servo 3 is twitchy*"}},	
		[_M.OVERWATCH] = 		{p_ow,{"*This way is watched*"}},				
		[_M.OVERWATCH_MELEE] =		nil,	

	--	[_M.EVENT_MISS_GUN] = 		{1,{"*Servo 3 is twitchy*"}},		
		[_M.GOT_HIT] = 			{p_gothit,{"*Power... empty...*"}},			
		[_M.REVIVED] = 			{p_revived,{"*Let's not do that again*"}},				
		[_M.HIJACK] = 			{p_hj,{"*Uploading virus*"}},			
		[_M.SAFE_LOOTED] = 		{p_loot,{"*I want to deconstruct this*"}},	
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,
			
		[_M.INTERRUPTED] = 		{p_inter,{"*I have complications*"}},				
		[_M.PEEK] = 			nil,							
		
		[_M.PIN] = 			{p_pin,{"*Such dirty work","A necessary unpleasantry*"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"*My power grows","*I am now... more*","*I have integrated it*","*I find this... satisfactory*"}},
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
	},

	[_M.MIST] = {
			
		[_M.ATTACK_GUN] = 		{p_gun,{"Don't think... don't feel... just do it","I work for Invisible now"}},  	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"This will sting. Like a sea anemone","I wonder what toxin this uses"}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"I feel your pain. Literally.","Looks like my training paid off","That was surprisingly easy","Okay. Now what?","Sometimes stealth isn’t the answer"}}, 
		[_M.OVERWATCH] = 		nil,  	
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"Experiment... failed","Looks like I'll never see Iceland again"}}, 			
		[_M.REVIVED] = 			{p_revived,{"No... no... oh, it's you","I knew I couldn't die"}}, 					
		[_M.HIJACK] = 			{p_hj,{"I can do things with this","Power... yes..."}},  			
		[_M.SAFE_LOOTED] = 		{p_loot,{"I found something","How much can we buy with this?","Some day I'm going to have to ask someone to explain the financial system to me"}},				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		{p_inter,{"What? What's going on?"}}, 				
		[_M.PEEK] = 			{p_peek,{"See without being seen"}},							
					
		[_M.PIN] = 			{p_pin,{"I'm good at this part","On/off... awake/asleep...","I know how your augments feel","Is this what revenge feels like?"}}, 
		[_M.INSTALL_AUGMENT] =		{p_augm,{"I've always wanted one of these","So what percentage human am I now?"}},	
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"I chose my new name for a reason","You can't see me"}},	
		[_M.MEDGEL] =			nil,
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
	},

	[_M.GHUFF] = {
		
		[_M.ATTACK_GUN] = 		{p_gun,{"Time to make some new enemies"}}, 	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"You don't know how lucky you are","Yeah, let's get this guy out of the way"}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Gotcha.","These things are kind of fun","Zapped.","It's nothing personal"}},
		[_M.OVERWATCH] = 		{p_ow,{"Nobody sneaks up on me"}},	
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"You got lucky.","Too bad... things were just getting interesting..."}}, 			
		[_M.REVIVED] = 			nil,  					
		[_M.HIJACK] = 			{p_hj,{"Anything to get ahead","Should I adjust the air conditioning while I'm here? This place is too damn cold"}},  			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Checking for hidden compartments","What have we got here?","Leave no stone unturned","There are people who'd kill for this much. Poor bastards."}}, 				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		nil,  				
		[_M.PEEK] = 			{p_peek,{"Leave the scouting to me","My eyes see everything","Got a real good view"}},							
					
		[_M.PIN] = 			nil,  
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Hmm... feels good","Now we're in business","Better quality than what my old friends sold"}},
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
	},

	[_M.N_UMI] = {
		
		[_M.ATTACK_GUN] = 		{p_gun,{"Die.","I've chosen my side"}}, 	
		[_M.SHOOT_DRONE] =		nil,
		[_M.SHOOT_CAMERA] =		nil,
		[_M.ATTACK_GUN_KO] = 		{p_gunko,{"Dream for a while"}}, 								
		[_M.ATTACK_MELEE] = 		{p_melee,{"Electricity has many uses","If they could see me now.","If it's any consolation, your brain is more resistant to damage than delicate electronics"}},

		[_M.OVERWATCH] = 		nil,  	
		[_M.OVERWATCH_MELEE] =		nil,
	
		[_M.GOT_HIT] = 			{p_gothit,{"Remember... remember..."}},  			
		[_M.REVIVED] = 			{p_revived,{"Is my drone okay too?"}},  					
		[_M.HIJACK] = 			{p_hj,{"Fuel for my drone army! ...Just kidding.","Power transferred.","Interesting... but unlike some people, I can prioritize"}}, 			
		[_M.SAFE_LOOTED] = 		{p_loot,{"Like robots, credits are just a tool. It's what you use them for.","I've searched it","Empty now"}},				
		[_M.EXEC_TERMINAL_LOOTED] =	nil,	
		[_M.THREAT_DEVICE_LOOTED] =	nil,

		[_M.INTERRUPTED] = 		nil,  				
		[_M.PEEK] = 			nil,		
					
		[_M.PIN] = 			{p_pin,{"Everything has a power-off switch, if you know where to look"}},
		[_M.INSTALL_AUGMENT] =		{p_augm,{"Why does this process seem vaguely familiar?","Not the absolute highest quality, but it'll do","I could improve this, but we don't have the time"}},
		[_M.DISGUISE_IN] =		nil,
		[_M.CLOAK_IN] =			{p_cloak,{"I can't help but be awed by this tech"}},
		[_M.MEDGEL] =			nil,
		[_M.WAKE_OTHER] =		nil,

		[_M.PARALYZER] =		nil,
		[_M.STIM_SELF] =		nil,
		[_M.STIM_OTHER] =		nil,
		[_M.SELF_STIMMED] =		nil,
		[_M.STIMMED_BY] =		nil,
		[_M.AWAKENED_BY] =		nil,
		[_M.RESCUER] = 			nil,
	},	

------------
	
}

return DLC_STRINGS
