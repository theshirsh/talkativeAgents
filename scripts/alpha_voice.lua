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
				elseif evType == simdefs.EV_UNIT_WIRELESS_SCAN and not evData.scan then	-- redirects Int's wireless hijack
					evType = EVENT_HIJACK
				elseif evType == simdefs.EV_UNIT_USECOMP then
					if evData.targetID ~= nil then
						local targetUnit = sim:getUnit(evData.targetID)
						if targetUnit:getTraits().mainframe_console and targetUnit:getTraits().cpus > 0 then
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
								script:queue( { script=text, type="newOperatorMessage", doNotQueue=true } ) 								
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
