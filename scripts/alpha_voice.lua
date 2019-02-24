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


local function isKO( unit )
    return unit:isKO()
end

local function isNotKO( unit )
    return not unit:isKO()
end

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
		sim:addTrigger( simdefs.TRG_MAP_EVENT, self ) -- for exiting mission

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
		sim:removeTrigger( simdefs.TRG_MAP_EVENT, self )
	    self.abilityOwner = nil
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
				log:write("EVTYPE: ".. tostring(evType))
				log:write("LOG: active event block")
				if evType == simdefs.EV_UNIT_START_SHOOTING  then
					local weaponUnit = simquery.getEquippedGun( self.abilityOwner )
					local targetUnit = sim:getUnit(evData.targetUnitID)
					if weaponUnit:getTraits().canSleep then
						evType = EV_ATTACK_GUN_KO;				-- custom number added for shooting Darts	      
					elseif targetUnit:getTraits().mainframe_camera then
						evType = EV_SHOOT_CAMERA;				-- custom for shooting cameras
					elseif targetUnit:getTraits().isDrone then
						evType = EV_SHOOT_DRONE					-- custom for shooting drones
					elseif targetUnit:getTraits().isGuard then
						evType = simdefs.EV_UNIT_START_SHOOTING
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
				end
				if agentDef.agentID ~= nil then 
					local agent = agentDef.agentID	
					if agent == 99 then					-- last mission's Monster to starting Monster 
						agent = 100;
					elseif agent == 107 then 				-- last mission's Central to starting Central 
						agent = 108;
					end
					if evType == EV_RESCUED_OTHER then -- opening detention cell
						agentDef = sim.rescuer
						agent = sim.rescuer.agentID -- if rescue, we want the agent who opened the doors to speak, not (just) the rescuee
					end
					
					if STRINGS.alpha_voice[ agent] ~= nil then		
						local speechData = STRINGS.alpha_voice[ agent][evType ]				
						if speechData ~= nil then			
							local p = speechData[1]
							if sim:nextRand() <= p then
						   		local choice = speechData[2]
								local speech = choice[math.floor(sim:nextRand()*#choice)+1]	
								
								-- some logwrites for now, don't mind me - Hek
								log:write("LOG: oneliner")
								log:write(util.stringize(agentDef.name,2))
								log:write(util.stringize(speech,2))
								log:write(util.stringize(evType,2))
								
								
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
					if agent == 99 then					-- last mission's Monster to starting Monster 
						agent = 100;
					elseif agent == 107 then 				-- last mission's Central to starting Central 
						agent = 108;
					end

					if STRINGS.alpha_voice[ agent] ~= nil then		
						local speechData = STRINGS.alpha_voice[ agent][evType ]				
						if speechData ~= nil then			
							local p = speechData[1]
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
		
	end,

	-- trigger

	onTrigger = function( self, sim, evType, evData  )	
		local script = sim:getLevelScript()
		local agentDef = self.abilityOwner:getUnitData()
		
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
					until speaker:isNotKO()
				end
				if speaker:getUnitData().agentID then
					agent = speaker:getUnitData().agentID
				end
				
				if agent and not sim.alreadySpoken then -- every agent has this ability  but it should only trigger once per escape
					if agent == 99 then					-- last mission's Monster to starting Monster 
						agent = 100;
					elseif agent == 107 then 				-- last mission's Central to starting Central 
						agent = 108;
					end
				
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
								log:write("LOG: oneliner")
								log:write(util.stringize(agent,1))
								log:write(util.stringize(text,1))
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
					if agent == 99 then					-- last mission's Monster to starting Monster 
						agent = 100;
					elseif agent == 107 then 				-- last mission's Central to starting Central 
						agent = 108;
					end
									
					if STRINGS.alpha_voice[ agent] ~= nil then		
						local speechData = STRINGS.alpha_voice[ agent][evType ]				
						if speechData ~= nil then				
							local p = speechData[1]
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
								script:queue( { script=text, type="newOperatorMessage", doNotQueue=true } ) log:write("LOG: oneliner")
								log:write(util.stringize(agent,1))
								log:write(util.stringize(text,1))
								--script:queue( 3*cdefs.SECONDS )
								--script:queue( { type="clearOperatorMessage" } ) -- it autoclears after "timing =3"
							end
						end
					end
				end
			end
		end
	end,
	
}

return alpha_voice
