local array = include( "modules/array" )
local util = include( "modules/util" )
local mathutil = include( "modules/mathutil" )
local cdefs = include( "client_defs" )
local simdefs = include("sim/simdefs")
local simquery = include("sim/simquery")
local abilityutil = include( "sim/abilities/abilityutil" )

local speechdefs = include( "sim/speechdefs" )

local EVENT_HIJACK = 19
local TRG_SAFE_LOOTED = 66

local EV_ATTACK_GUN_KO = 1008
local EV_HEALER = 1009
local EV_SHOOT_CAMERA = 1010
local EV_SHOOT_DRONE = 1011 

local EV_PARALYZER = 1012
local EV_STIM_SELF = 1013
local EV_STIM_OTHER = 1014
local EV_SELF_STIMMED = 1015
local EV_STIMMED_BY = 1016
local EV_WAKE = 1017
local EV_AWAKENED = 1018

local EV_EXEC_TERMINAL = 1019
local EV_DEVICE_LOOTED = 1020

local EV_RESCUED_OTHER = 1021
local EV_MISSION_BAD = 1022
local EV_MISSION_GOOD = 1023
local EV_MISSION_BLOODY = 1024
local EV_ABANDONED_AGENT = 1025

local EV_SET_SHOCKTRAP = 1026
local EV_AGENT_DEATH = 1027
local EV_OW_INTERVENTION = 1028

-- guard event types! -- 
local EV_GUARD_ONELINER = 2000
local EV_GUARD_BANTER = 2001
-- local EV_GUARD_BEGGING = 2002


local objectives = {["TERMINAL"] = true, ["CEO"] = true, ["RUN"] = true, ["escaped"] = true, ["VAULT-LOOTOUTER"] = true, ["BOUGHT"] = true, ["NANOFAB"] = true, ["TOPGEAR"] = true, ["USE_TERMINAL"] = true}

local alpha_voice =
{
	canUseAbility = function( self, sim, abilityOwner, abilityUser )
		if abilityOwner:isKO() then 
			return false
		end 
		if abilityOwner:isDead() then 
			return false
		end 
		return true
	end,

	name = STRINGS.ITEMS.AUGMENTS.CENTRALS,
	getName = function( self, sim, unit )
		return self.name
	end,
	
	onSpawnAbility = function( self, sim, unit )
	        self.abilityOwner = unit
	--      sim:addTrigger( simdefs.TRG_OPEN_DOOR, self )			-- left for a test/example purpose if needed
		sim:addTrigger( simdefs.TRG_SAFE_LOOTED, self )
	--	sim:addEventTrigger( simdefs.EV_UNIT_SPEAK, self )		-- example
		sim:addEventTrigger( simdefs.EV_UNIT_START_SHOOTING, self )
		sim:addEventTrigger( simdefs.EV_UNIT_MELEE, self )
		sim:addEventTrigger( simdefs.EV_UNIT_HIT, self )
		sim:addEventTrigger( simdefs.EV_UNIT_HEAL, self )
		sim:addEventTrigger( simdefs.EV_UNIT_USECOMP, self )
		sim:addEventTrigger( simdefs.EV_UNIT_WIRELESS_SCAN, self )
		sim:addEventTrigger( simdefs.EV_UNIT_INTERRUPTED, self )
		sim:addEventTrigger( simdefs.EV_UNIT_PEEK, self )
		sim:addEventTrigger( simdefs.EV_UNIT_OVERWATCH, self )
		sim:addEventTrigger( simdefs.EV_UNIT_OVERWATCH_MELEE, self )
		sim:addEventTrigger( simdefs.EV_UNIT_STOP_WALKING, self )
		sim:addEventTrigger( simdefs.EV_UNIT_START_PIN, self )		-- unused in game --Not anymore :)
		sim:addEventTrigger( simdefs.EV_UNIT_INSTALL_AUGMENT, self )	-- for installing augments
		sim:addEventTrigger( simdefs.EV_CLOAK_IN, self )		-- for activating cloak
		sim:addEventTrigger( simdefs.EV_UNIT_GOTO_STAND, self )		-- for Prism's disguise	
		sim:addEventTrigger( simdefs.EV_UNIT_RESCUED, self ) -- for rescuing other agent from detention cell
		sim:addEventTrigger( simdefs.EV_UNIT_USEDOOR_PST, self ) -- for shock trap line
		sim:addTrigger( simdefs.TRG_MAP_EVENT, self ) -- for exiting mission
		sim:addTrigger( simdefs.TRG_UNIT_KILLED, self ) -- for reaction to agent death
		sim:addTrigger( simdefs.TRG_START_TURN, self )
		sim:addTrigger( simdefs.TRG_UNIT_WARP, self ) -- for hostage

	end,
        
	onDespawnAbility = function( self, sim, unit )
	--      sim:removeTrigger( simdefs.TRG_OPEN_DOOR, self )
		sim:removeTrigger( simdefs.TRG_SAFE_LOOTED, self )
	--	sim:removeEventTrigger( simdefs.EV_UNIT_SPEAK, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_START_SHOOTING, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_MELEE, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_HIT, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_HEAL, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_USECOMP, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_WIRELESS_SCAN, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_INTERRUPTED, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_PEEK, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_OVERWATCH, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_OVERWATCH_MELEE, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_STOP_WALKING, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_START_PIN, self )		-- unused in game --Not anymore :)
		sim:removeEventTrigger( simdefs.EV_UNIT_INSTALL_AUGMENT, self )		-- for installing augments
		sim:removeEventTrigger( simdefs.EV_CLOAK_IN, self )			-- for activating cloak
		sim:removeEventTrigger( simdefs.EV_UNIT_GOTO_STAND, self )		-- for Prism's disguise
		sim:removeEventTrigger( simdefs.EV_UNIT_RESCUED, self )
		sim:removeEventTrigger( simdefs.EV_UNIT_USEDOOR_PST, self )
		sim:removeTrigger( simdefs.TRG_MAP_EVENT, self )
		sim:removeTrigger( simdefs.TRG_UNIT_KILLED, self )
		sim:removeTrigger( simdefs.TRG_START_TURN, self )
		sim:removeTrigger( simdefs.TRG_UNIT_WARP, self )
	    self.abilityOwner = nil
	end,

	checkAgentID = function( agent )
		if agent == 99 then					-- last mission's Monster to starting Monster 
			agent = 100;
		elseif agent == 107 then 				-- last mission's Central to starting Central 
			agent = 108;
		elseif agent == 230 then	--SAA compatibility stuff >_>
			agent = 1 --decker
		elseif agent == 232 then
			agent = 2 --shalem
		elseif agent == 234 then
			agent = 3 --xu
		elseif agent == 233 then
			agent = 4 --banks
		elseif agent == 231 then
			agent = 5 --maria
		elseif agent == 235 then
			agent = 6 --nika
		elseif agent == 236 then
			agent = 7 --sharp
		elseif agent == 237 then
			agent = 8 --prism
		end
		return agent
	end,
	
	checkPMultiplier = function( sim, p_value )
		local p_mod = sim:getParams().difficultyOptions.talkativeagents_multiplier
		if p_mod ~= nil then
			p_value = p_value*p_mod
		end
		if sim:getParams().world == "omni" then --make agent oneliners a lot less frequent in Omni missions
			p_value = p_value*0.1
		end
		return p_value
	end,
	
	getGuards = function( sim, observers, getAlerted )
		local enemies = {}
		local params = sim:getParams()
		local getAlerted = getAlerted or false
		-- local enemynames = {}
		if not (#observers > 0) then return enemies end
		-- log:write("talkative guards getGuards")
		local allEnemies = sim:getNPC():getUnits()
		for k, agent in pairs( observers ) do			
			if agent and #allEnemies > 0 then
				for i, enemy in pairs(allEnemies) do
									
					if enemy and sim:canUnitSeeUnit( agent, enemy ) 
					and not enemy:isKO() and ( not enemy:isAlerted() or getAlerted ) 
					and ( not enemy:getTraits().isDrone or not enemy:getTraits().pacifist ) and not enemy:getTraits().omni and enemy:getTraits().isGuard and not enemy:getTraits().enforcer and (not enemy:getTraits().mainframe_camera or ( (sim:nextRand() <=0.01) and params.world ~= "omni" ) ) then
						table.insert( enemies, enemy )
					end
				end
			end
		end
		-- log:write("LOG enemynames")
		-- log:write(util.stringize(enemynames,2)) -- for debugging
		return enemies
	
	end,
	
	checkGuardType = function( chattyguard )
	
		if chattyguard:getTraits().cfo then
			guardtype = "type_cfo"
		elseif chattyguard:getTraits().scientist or chattyguard:getUnitData().template == "npc_scientist" then
			guardtype = "type_scientist"
		elseif chattyguard:getTraits().pacifist and chattyguard:getTraits().investigateHackedDevices then
			guardtype = "type_sysadmin"
		elseif chattyguard:getTraits().isDrone then
			guardtype = "type_combatdrone" --pacifist check done in getGuards
		else 
			guardtype = "type_guard"
		end
		return guardtype
	end,
	
	doGuardBanter = function( sim, speaker1, speaker2 )
		local speechQue = {}
		local message_time = 4
		local delay_time = 0.5
		local script = sim:getLevelScript()
		local dialogues = STRINGS.alpha_voice.GUARDS.BANTERS
		local banter = dialogues[sim:nextRand(1,#dialogues)]
		local guardDef1 = speaker1:getUnitData()
		local guardDef2 = speaker2:getUnitData()
		-- log:write("guard banter 1")

		for i, line in ipairs(banter) do	
			local anim = guardDef1.profile_anim
			local build = guardDef1.profile_anim
			if guardDef1.profile_build then
				build = guardDef1.profile_build
			end
			local name = guardDef1.name
			local enemy = true --start on the right
			if (i % 2 == 0) then -- for left/right display alternation
				enemy = false
				anim = guardDef2.profile_anim
				build = guardDef2.profile_anim
				if guardDef2.profile_build then
					build = guardDef2.profile_build
				end
				name = guardDef2.name
			end

			local speech = {
				{
					text = banter[i],
					anim = anim,
					build = build,
					name = name,
					timing = message_time,
					enemy = enemy,				
				}
			}
			table.insert(speechQue, speech)		
		end
		-- do the banter!

		script:queue( delay_time*cdefs.SECONDS )
		for i,que in ipairs(speechQue)do

			if que[1].enemy then
				script:queue( { body=que[1].text, header=que[1].name, type="enemyMessage", 
					profileAnim=que[1].anim,
					profileBuild=que[1].build,
				} )	
				script:queue( message_time*cdefs.SECONDS )					
				script:queue( { type="clearEnemyMessage" } )
		else
				script:queue( { script=que, type="newOperatorMessage" } )        		
			end        	
		end	
		sim.chattyGuards = sim:getTurnCount()
		
	end,
	
	findBuddy = function( guard, enemies )
		local closestRange = math.huge
		local closestUnit = nil
		local x0, y0 = guard:getLocation()
		for i, unit in pairs(enemies) do
			if unit ~= guard then
				local x1, y1 = unit:getLocation()
				if x1 then
					local range = mathutil.distSqr2d( x0, y0, x1, y1 )
					if range < closestRange then
						closestRange = range
						closestUnit = unit
					end
				end
			end
		end
	return closestUnit, math.sqrt( closestRange )
	end,

	onEventTrigger = function( self, sim, evType, evData, before )	
		local script = sim:getLevelScript()
		local agentDef = self.abilityOwner:getUnitData()

	-- Pinning block:	
	
		if evType == simdefs.EV_UNIT_STOP_WALKING and (evData.unit == self.abilityOwner or evData.unitID == self.abilityOwner:getID()) and simquery.isUnitPinning( sim, evData.unit ) and not before then
			sim:dispatchEvent( simdefs.EV_UNIT_START_PIN, evData )
		end
	
	-- Block for 'active' events(being executor of action or healing etc):	

	if (evData.unit == self.abilityOwner or evData.unitID == self.abilityOwner:getID()) and not evData.cancel and before then 	
			if not self.abilityOwner:isKO() then	
				-- log:write("EVTYPE: ".. tostring(evType))
				-- log:write("LOG: active event block")
				if evType == simdefs.EV_UNIT_START_SHOOTING  then
					local weaponUnit = simquery.getEquippedGun( self.abilityOwner )
					local targetUnit = sim:getUnit(evData.targetUnitID)
					if weaponUnit:getTraits().canSleep then
						evType = EV_ATTACK_GUN_KO;				-- custom number added for shooting Darts	
						if targetUnit:isAiming() and not simquery.isUnitUnderOverwatch(self.abilityOwner) then
							for i, unit in pairs(sim:getPC():getUnits()) do
								if unit:getUnitData().agentID and unit ~= self.abilityOwner and sim:canUnitSeeUnit( targetUnit, unit ) then
									evType = EV_OW_INTERVENTION
								end
							end
						end
					elseif targetUnit:getTraits().mainframe_camera then
						evType = EV_SHOOT_CAMERA;				-- custom for shooting cameras
					elseif targetUnit:getTraits().isDrone then
						evType = EV_SHOOT_DRONE					-- custom for shooting drones
					elseif targetUnit:getTraits().isGuard then
						evType = simdefs.EV_UNIT_START_SHOOTING
						if weaponUnit:getTraits().canTag then
							evType = 0
						end
						if targetUnit:isAiming() and not simquery.isUnitUnderOverwatch(self.abilityOwner) then
							for i, unit in pairs(sim:getPC():getUnits()) do
								if unit:getUnitData().agentID and unit ~= self.abilityOwner and sim:canUnitSeeUnit( targetUnit, unit ) then
									evType = EV_OW_INTERVENTION
								end
							end
						end
					end
				elseif evType == simdefs.EV_UNIT_MELEE then
					local targetUnit = evData.targetUnit
					-- log:write(util.stringize(targetUnit,2))
					if targetUnit:isAiming() and not simquery.isUnitUnderOverwatch(self.abilityOwner) then
						evType = EV_OW_INTERVENTION --can't check for LOS here, as LOS is refreshed in melee.lua before the event is dispatched
					end
				elseif evType == simdefs.EV_UNIT_WIRELESS_SCAN then	-- redirects Int's wireless hijack
					evType = EVENT_HIJACK
				elseif evType == simdefs.EV_UNIT_USECOMP then
					if evData.targetID ~= nil then
						local targetUnit = sim:getUnit(evData.targetID)
						if targetUnit:hasTag("detention_processor") then	
							if agentDef.agentID ~= nil then
								sim.rescuer = agentDef -- use for EV_UNIT_RESCUED
							end
						end
						if targetUnit:getTraits().mainframe_console and targetUnit:getTraits().cpus > 0 and not targetUnit:hasTag("detention_processor") then
							evType = EVENT_HIJACK		-- use console
						else evType = 0
						end					
					else evType = 0
					end	
				elseif evType == simdefs.EV_UNIT_HEAL then		-- injection event
					if evData.revive then
						if not evData.target:isDead() then	
							evType = EV_WAKE		-- raise other from KO				
						else 
							evType = EV_HEALER		-- revive fallen agent	
						end								
					elseif evData.target:getTraits().isGuard then
						evType = EV_PARALYZER			-- custom number for palaryzers	
					elseif evData.target == evData.unit then
						evType = EV_STIM_SELF	
					else 
						evType = EV_STIM_OTHER
					end
				elseif evType == simdefs.EV_UNIT_RESCUED and evData.unit:getUnitData().agentID and sim.rescuer then -- make sure it's an agent rescuing an agent and not prisoner, etc.
					evType = EV_RESCUED_OTHER	
				elseif evType == simdefs.EV_UNIT_USEDOOR_PST and evData.unitID then --this should only work when setting trap but not when disarming it (if disarmed, trap is already nil by the time trigger is given
					local trapper = sim:getUnit(evData.unitID)
					local x0, y0 = trapper:getLocation()
					for _, targetUnit in pairs( sim:getAllUnits() ) do
						local x1, y1 = targetUnit:getLocation()
						if x1 == x0 and y1 == y0 and targetUnit:getTraits().trap then
							evType = EV_SET_SHOCKTRAP
						end
					end
				elseif evType == simdefs.EV_UNIT_GOTO_STAND then
					if evData.unit:getTraits().walk == false then
						evType = 0
					end
				end
				if agentDef.agentID ~= nil then 
					local agent = agentDef.agentID	
					agent = self.checkAgentID( agent ) --reassign agentID if necessary
					
					if evType == EV_RESCUED_OTHER then -- opening detention cell
						agentDef = sim.rescuer
						agent = sim.rescuer.agentID -- if rescue, we want the agent who opened the doors to speak, not (just) the rescuee
						agent = self.checkAgentID( agent )
					end
					
					if STRINGS.alpha_voice[ agent] ~= nil then		
						local speechData = STRINGS.alpha_voice[ agent][evType ]				
						if speechData ~= nil then			
							local p = speechData[1]
							p = self.checkPMultiplier( sim, p )
							if sim:nextRand() <= p then
						   		local choice = speechData[2]
								local speech = choice[math.floor(sim:nextRand()*#choice)+1]	
								
								-- some logwrites for now, don't mind me - Hek
								-- log:write("LOG: oneliner")
								-- log:write(util.stringize(agentDef.name,2))
								-- log:write(util.stringize(speech,2))
								-- log:write(util.stringize(evType,2))
								
								
								local text =  {{							
									text = speech,
									anim = agentDef.profile_anim,
									build = agentDef.profile_build,
									name = agentDef.name,
									timing = 3,
									voice = nil,
								}}					
								script:queue( { script=text, type="newOperatorMessage", doNotQueue=true } ) 
								--script:queue( 3*cdefs.SECONDS )
								--script:queue( { type="clearOperatorMessage" } ) -- it autoclears after "timing =3"
							end
						end
					end
				end
			end
		end


	-- Block for 'passive' events(being target of healing), triggers after, message on the right:

		if (evData.target == self.abilityOwner or evData.targetID == self.abilityOwner:getID()) and not before then 
			if evType == simdefs.EV_UNIT_HEAL and not before then
				if not evData.revive then			-- if it's Stim or Defib
					if evData.target ~= evData.unit then
						evType = EV_STIMMED_BY		-- by other agent
					else 	evType = EV_SELF_STIMMED	-- by self						
					end
				elseif not evData.target:isDead() then	
					evType = EV_AWAKENED			-- raised from KO				
				end			
				if agentDef.agentID ~= nil then 
					local agent = agentDef.agentID	
					agent = self.checkAgentID( agent )

					if STRINGS.alpha_voice[ agent] ~= nil then		
						local speechData = STRINGS.alpha_voice[ agent][evType ]				
						if speechData ~= nil then			
							local p = speechData[1]
							p = self.checkPMultiplier( sim, p )
							if sim:nextRand() <= p then
								local choice = speechData[2]
								local speech = choice[math.floor(sim:nextRand()*#choice)+1]								
								local anim = agentDef.profile_anim
								local build = agentDef.profile_anim	-- if there no build then use default one from anim
								if agentDef.profile_build then		
									build = agentDef.profile_build	-- either way use build as a skin
								end								
								local name = agentDef.name
								if evType == EV_SELF_STIMMED then	-- to have speech pop-up on the left
									local text =  {{								
									text = speech,
									anim = anim,
									build = build,
									name = name,
									timing = 3,
									voice = nil,
									}}		
									script:queue( 0.5*cdefs.SECONDS )			
									script:queue( { script=text, type="newOperatorMessage", doNotQueue=true } ) 
								else					-- to have speech pop-up on the right						
									script:queue( { body = speech, header= name, type="enemyMessage", 
											profileAnim= anim,
											profileBuild= build,									
											} )
									script:queue( 3*cdefs.SECONDS )			-- time before clear, 3 seconds, as timing
									script:queue( { type="clearEnemyMessage" } )	-- no autoclear for those eh	
								end
							end
						end
					end
				end
			end			
		end
	-- BLOCK END	
	
	-- block for special guard reaction oneliners
	if not sim:getParams().difficultyOptions.chattyguards or (sim:getParams().difficultyOptions.chattyguards and sim:getParams().difficultyOptions.chattyguards == true) then
	
	
	if (evData.unit == self.abilityOwner or evData.unitID == self.abilityOwner:getID()) and not evData.cancel and before then 
		local guardBegging = false
		local targetUnit = nil
		if evType == simdefs.EV_UNIT_START_SHOOTING  then
			local weaponUnit = simquery.getEquippedGun( self.abilityOwner )
			targetUnit = sim:getUnit(evData.targetUnitID)
			local traits = targetUnit:getTraits()
			
			if traits and traits.isGuard and not traits.omni
			and not traits.enforcer and not traits.isDrone
			and not weaponUnit:getTraits().canTag then
				guardBegging = true
			end
		elseif evType  == simdefs.EV_UNIT_MELEE then
			targetUnit = evData.targetUnit
			local traits = targetUnit:getTraits()
			if traits and traits.isGuard and not traits.omni
			and not traits.enforcer and not traits.isDrone then
				guardBegging = true
			end
			
		end
		
		if ( guardBegging == true ) and targetUnit then
			local guardDef = targetUnit:getUnitData()
			local anim = guardDef.profile_anim
			local build = guardDef.profile_anim	-- if there no build then use default one from anim
			if guardDef.profile_build then		
				build = guardDef.profile_build	-- either way use build as a skin
			end								
			local name = guardDef.name
			local speechData = STRINGS.alpha_voice.GUARDS.BEGGING
			
			if #speechData ~= nil then
				local p = speechData[1]
				p = self.checkPMultiplier( sim, p )
				-- commented out for now, wasn't working well
				-- if sim:nextRand() <= p then
					-- local choice = speechData[2]
					-- local speech = choice[math.floor(sim:nextRand()*#choice)+1]

						-- script:queue( 1*cdefs.SECONDS )
						
						-- script:queue( { 
						-- body= speech, 
						-- header= name, 
						-- type="enemyMessage", 
						-- profileAnim= anim,
						-- profileBuild= build,
						-- } )
						
						-- script:queue( 4*cdefs.SECONDS )			-- time before clear, 3 seconds, as timing
						-- script:queue( { type="clearEnemyMessage" } )				
				
				-- end			
			end		
		end	
	end
	-- block end

	end -- params end
	--end of guard oneliner block
	end,

	-- trigger

	onTrigger = function( self, sim, evType, evData  )	
		local script = sim:getLevelScript()
		local agentDef = self.abilityOwner:getUnitData()
		
		local function isKO( unit )
			return unit:isKO()
		end

		local function isNotKO( unit )
			return not unit:isKO()
		end
		
		-- Block for exit teleportation oneliners
		if evType == simdefs.TRG_MAP_EVENT and evData.event == simdefs.MAP_EVENTS.TELEPORT then

			evType = 0
			local fieldUnits, escapingUnits = simquery.countFieldAgents( sim )
			if escapingUnits and #escapingUnits > 0 then
				local agent = nil
				local speaker = escapingUnits[ sim:nextRand(1, #escapingUnits ) ]
				if speaker:isKO() then
					repeat
						speaker = escapingUnits[ sim:nextRand(1, #escapingUnits ) ] -- this should be returned eventually since there had to be someone to activate the escape ability... right? ^^;;
					until not speaker:isKO()
				end
				if speaker:getUnitData().agentID then
					agent = speaker:getUnitData().agentID
				end
				
				if agent and not sim.alreadySpoken then -- every agent has this ability  but it should only trigger once per escape
					agent = self.checkAgentID( agent )
				
				-- check how well the mission went!
				
					local casualties = nil
					local finalescape = nil
					local bloodymission = nil
					local success = true
					-- log:write("LOG2")
					-- log:write(util.stringize(sim:getLevelScript().hooks,3))
					
					local missionhooks = script.hooks
					for i, hook in pairs(missionhooks) do
						if objectives[hook.name] then
							success = false
						end
						
						-- if hook.name == "TERMINAL" or hook.name == "CEO" or hook.name == "RUN" or hook.name == "escaped" or hook.name == "VAULT-LOOTOUTER" or hook.name == "BOUGHT" or hook.name == "NANOFAB" or hook.name == "TOPGEAR" or hook.name == "USE_TERMINAL" then
							-- success = false -- super ugly check for uncompleted main objectives
						-- end
					end
					
					local isPartialEscape = array.findIf( fieldUnits, isNotKO) ~= nil
					local abandonedUnit = array.findIf( fieldUnits, isKO ) -- wounded agents still in the field
					if not isPartialEscape then
						finalescape = true
					end
					local injuredUnit = array.findIf( escapingUnits, isKO )
					-- check for "dead" agents who are also in the elevator
					
					if injuredUnit then 
						casualties = true 
					end
					
					if sim.permadeathkilled then --permadeath mod compatibility
						casualties = true
					end
					
					if sim:getCleaningKills() > 2 then
						bloodymission = true
					end
					
					-- actually decide what type of reaction to show
					if finalescape then
						if not success or casualties then 
							evType = EV_MISSION_BAD
						end

						if success and not casualties then 
							evType = EV_MISSION_GOOD
						end
						
						if bloodymission and sim:nextRand() <= 0.7 then 
							evType = EV_MISSION_BLOODY
						end
					end
					
					if abandonedUnit then
						evType = EV_ABANDONED_AGENT --takes precedence
					end

					if STRINGS.alpha_voice[ agent] ~= nil then		
							local speechData = STRINGS.alpha_voice[ agent][evType ]	
							local agentDef = speaker:getUnitData()
							if speechData ~= nil then				
								local p = speechData[1]
								p = self.checkPMultiplier( sim, p )
								if sim:nextRand() <= p then
									local choice = speechData[2]
									local speech = choice[math.floor(sim:nextRand()*#choice)+1]								
									local text =  {{							
										text = speech,
										anim = agentDef.profile_anim,
										build = agentDef.profile_build,
										name = agentDef.name,
										timing = 3,
										voice = nil,
									}}					
									script:queue( { script=text, type="newOperatorMessage", doNotQueue=true } )
									sim.alreadySpoken = true
									-- log:write("LOG: oneliner")
									-- log:write(util.stringize(agent,1))
									-- log:write(util.stringize(text,1))
								end
							end
						end	
					
				end
				
			end
		
		end

		-- normal trigger stuff
		if (evData.unit == self.abilityOwner or evData.unitID == self.abilityOwner:getID()) and not evData.cancel then 	
			if not self.abilityOwner:isKO() then
				if evType == simdefs.TRG_SAFE_LOOTED then 
					if evData.targetUnit:getTraits().safeUnit then
						evType = TRG_SAFE_LOOTED
					elseif evData.targetUnit:getTraits().public_term then
						evType = EV_EXEC_TERMINAL		-- 
					elseif evData.targetUnit:getTraits().scanner or evData.targetUnit:getTraits().router then
						evType = EV_DEVICE_LOOTED
					else evType = 0
					end	
				end				
				if agentDef.agentID ~= nil then 
					local agent = agentDef.agentID	
					agent = self.checkAgentID( agent )
									
					if STRINGS.alpha_voice[ agent] ~= nil then		
						local speechData = STRINGS.alpha_voice[ agent][evType ]				
						if speechData ~= nil then				
							local p = speechData[1]
							p = self.checkPMultiplier( sim, p )
							if sim:nextRand() <= p then
						   		local choice = speechData[2]
								local speech = choice[math.floor(sim:nextRand()*#choice)+1]								
								local text =  {{							
									text = speech,
									anim = agentDef.profile_anim,
									build = agentDef.profile_build,
									name = agentDef.name,
									timing = 3,
									voice = nil,
								}}					
								script:queue( { script=text, type="newOperatorMessage", doNotQueue=true } )
								-- log:write("LOG: oneliner")
								-- log:write(util.stringize(agent,1))
								-- log:write(util.stringize(text,1))
								--script:queue( 3*cdefs.SECONDS )
								--script:queue( { type="clearOperatorMessage" } ) -- it autoclears after "timing =3"
							end
						end
					end
				end
			end
		end
	
		-- agent reaction to agent death, message on the right
		if evType == simdefs.TRG_UNIT_KILLED and evData.unit:getUnitData().agentID and evData.unit:getTraits().corpseTemplate then
			evType = EV_AGENT_DEATH
			local units = sim:getPC():getUnits()
			local speakerunits = {}
			for _, unit in pairs(units) do
				if unit:getUnitData().agentID and not unit:isKO() then
					table.insert( speakerunits, unit )
				end
			end
			
			local speaker = speakerunits[ sim:nextRand(1, #speakerunits) ]
			local speakerDef = speaker:getUnitData()
			local agent = speakerDef.agentID
			agent = self.checkAgentID( agent )
			
			if STRINGS.alpha_voice[ agent ] ~= nil and not evData.unit:getTraits().alreadyMourned then
				local speechData = STRINGS.alpha_voice[ agent][ evType ]
				if speechData ~= nil then
					local p = speechData[1]
					p = self.checkPMultiplier( sim, p )
					if sim:nextRand() <= p then
						local choice = speechData[2]
						local speech = choice[math.floor(sim:nextRand()*#choice)+1]								
								local anim = speakerDef.profile_anim
								local build = speakerDef.profile_anim	-- if there no build then use default one from anim
								if speakerDef.profile_build then		
									build = speakerDef.profile_build	-- either way use build as a skin
								end								
								local name = speakerDef.name
			
								script:queue( { 
									body = speech, 
									header= name, 
									type="enemyMessage", 
									profileAnim= anim,
									profileBuild= build,
									} )
									script:queue( 3*cdefs.SECONDS )			-- time before clear, 3 seconds, as timing
									script:queue( { type="clearEnemyMessage" } )
								evData.unit:getTraits().alreadyMourned = true
					end
				end
			end
		end

	-- chatty guard block --
		if not sim:getParams().difficultyOptions.chattyguards or (sim:getParams().difficultyOptions.chattyguards and sim:getParams().difficultyOptions.chattyguards == true) then
	
	
		if evType == simdefs.TRG_START_TURN and evData:isPC() then
			local p_banter = 0.3 -- chance a banter will trigger instead of a oneliner, when both are available
			if sim.chattyGuards == nil then 
				sim.chattyGuards = sim:getTurnCount()
			end
			-- log:write("talkative guards 1")
			if sim:getTurnCount() > sim.chattyGuards and (sim:getTrackerStage( sim:getTracker() ) < 3) then
				-- This makes sure it only proccs once per turn
				
				local agents = sim:getPC():getUnits()
				local observers = {}
				for _, agent in pairs(agents) do
					if not agent:isKO() and agent:getTraits().isAgent and agent:getTraits().hasSight then
						table.insert(observers, agent)
						-- log:write("LOG observer")
						-- log:write(util.stringize(agent:getUnitData().name,1))
					end
				end

				local getAlerted = false
				local enemies = self.getGuards( sim, observers, getAlerted )

				if #enemies > 0 then
					local chattyguard = enemies[sim:nextRand(1, #enemies)]
					local guardDef = chattyguard:getUnitData()
					local x1, y1 = chattyguard:getLocation()
					local buddy, range = self.findBuddy( chattyguard, enemies )
					local canSeeBuddy = false
								
					-- check what NPC type
					chattyguard:getTraits().guardType = self.checkGuardType( chattyguard )
					-- if buddy and range and range < 7 then --pick someone close enough to talk to \o/
					if buddy then
						buddy:getTraits().guardType = self.checkGuardType( buddy )
						if simquery.couldUnitSeeCell( sim, chattyguard, sim:getCell( buddy:getLocation() ) ) then
							canSeeBuddy = true
						end
						-- log:write("LOG buddytype")
					end

					local evType = 2000 --kind of cosmetic, we don't really need evType here...
					if buddy and (buddy:getTraits().guardType == "type_guard") and (chattyguard:getTraits().guardType == "type_guard") and (sim:nextRand() <= p_banter) and canSeeBuddy then 
						evType = 2001
						-- log:write("LOG evType 2001")
					end
					
					if evType == 2001 then -- guard banter
						self.doGuardBanter( sim, chattyguard, buddy )
						log:write("guard banter coming up")
					elseif evType == 2000 then -- oneliner block
						-- log:write("talkative guards 3")

						local anim = guardDef.profile_anim
						local build = guardDef.profile_anim	-- if there no build then use default one from anim
						if guardDef.profile_build then		
							build = guardDef.profile_build	-- either way use build as a skin
						end								
						local name = guardDef.name
						local speechData = STRINGS.alpha_voice.GUARDS.LINES[ chattyguard:getTraits().guardType ]
						if speechData ~= nil then
							local p = speechData[1]
							p = self.checkPMultiplier( sim, p )
							if sim:nextRand() <= p then
								local choice = speechData[2]
								local speech = choice[math.floor(sim:nextRand()*#choice)+1]
						
							-- log:write("talkative guards 4")
								script:queue( 2*cdefs.SECONDS )
								
								script:queue( { 
								body= speech, 
								header= name, 
								type="enemyMessage", 
								profileAnim= anim,
								profileBuild= build,
								} )
								
								script:queue( 4*cdefs.SECONDS )			-- time before clear, 3 seconds, as timing
								script:queue( { type="clearEnemyMessage" } )
								
								sim.chattyGuards = sim:getTurnCount()
							end
						end
					end
				end
		

			end
		
		end
	
		end -- param block
		-- Block for hostage response
	
	if evType == simdefs.TRG_UNIT_WARP and evData.unit:getTraits().untie_anim then -- this triggers on despawn of the hostage prop
		if sim.hostageReply == nil then
			-- log:write("log unit untie")
			local hostage = nil
			local unbinder = nil
			local units = {}
			for i, unit in pairs(sim:getPC():getUnits()) do			
				if unit:getTraits().hostage == true then
					hostage = unit -- find actual hostage unit
				elseif unit:getTraits().isAgent and not unit:isKO() then
					table.insert( units, unit )
				end
			end
			
			if hostage then 
				local buddy, range = self.findBuddy( hostage, units ) -- find closest agent, presumably the one who freed the hostage
				if buddy and range < 1.5 then 
					unbinder = buddy
				end
				
				if unbinder and unbinder:getUnitData().agentID then
				
					local agentDef = unbinder:getUnitData()
					local agent = agentDef.agentID
					agent = self.checkAgentID( agent )
					
					if STRINGS.alpha_voice.HOSTAGEQUIPS[ agent ] ~= nil then
						local speechData = STRINGS.alpha_voice.HOSTAGEQUIPS[ agent ]
						local speech = speechData[math.floor(sim:nextRand()*#speechData)+1]
						local anim = agentDef.profile_anim
						local build = agentDef.profile_anim	-- if there no build then use default one from anim
						if agentDef.profile_build then		
							build = agentDef.profile_build	-- either way use build as a skin
						end								
						local name = agentDef.name						
						
						local text =  {{								
							text = speech,
							anim = anim,
							build = build,
							name = name,
							timing = 3,
							voice = nil,
							}}		
						script:queue( 0.5*cdefs.SECONDS )			
						script:queue( { script=text, type="newOperatorMessage", doNotQueue=true } )
						script:queue( 3*cdefs.SECONDS )
						
						-- sim.hostageReply = true
						
					
					end	

					sim.hostageReply = true
					local text = {{
						text = STRINGS.MISSIONS.ESCAPE.OPERATOR_HOSTAGE_CONVO1,
						anim = "portraits/central_face",
						build = "portraits/central_face",
						name = "CENTRAL",
						voice = "SpySociety/VoiceOver/Missions/Hostage/Operator_MissingCourier",
						timing = 3,
						donotskip = true,
						}}
				
					script:queue( 0.5*cdefs.SECONDS )
					script:queue( {script=text, type="newOperatorMessage", doNotQueue=true} )
				end
			
			end		
			
		end				
	end
	
	end,
	
}

return alpha_voice
