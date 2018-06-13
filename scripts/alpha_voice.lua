local array = include( "modules/array" )
local util = include( "modules/util" )
local mathutil = include( "modules/mathutil" )
local cdefs = include( "client_defs" )
local simdefs = include("sim/simdefs")
local simquery = include("sim/simquery")
local abilityutil = include( "sim/abilities/abilityutil" )

local speechdefs = include( "sim/speechdefs" )

local EV_ATTACK_GUN_KO = 1008
local EV_HEALER = 1009
local EV_SHOOT_CAMERA = 1010
local EV_SHOOT_DRONE = 1011 
local EV_PARALYZER = 1012

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
		sim:addEventTrigger( simdefs.EV_CLOAK_IN, self )			-- for activating cloak
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
					local targetunit = sim:getUnit(evData.targetUnitID)
					if weaponUnit:getTraits().canSleep then
						evType = EV_ATTACK_GUN_KO;					-- custom number added for shooting Darts	      
					elseif targetunit:getTraits().mainframe_camera then
						evType = EV_SHOOT_CAMERA;					-- custom for shooting cameras
					elseif targetunit:getTraits().isDrone then
						evType = EV_SHOOT_DRONE						-- custom for shooting drones
					elseif targetunit:getTraits().isGuard then
						evType = EV_UNIT_START_SHOOTING
					end
				elseif evType == simdefs.EV_UNIT_WIRELESS_SCAN then		-- redirects Int's wireless hijack
					evType = 19;	
				elseif evType == simdefs.EV_UNIT_HEAL then		-- injection event
					if not evData.revive then
						evType = EV_PARALYZER			-- custom number for palaryzers						
					else
						evType = EV_HEALER			-- custom number added for using medgel on other agent
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
								--script:queue( { type="clearOperatorMessage" } ) -- it autoclears after "timing =3" I think
							end
						end
					end
				end
			end
		end


	-- Block for 'passive' events(being target of healing), triggers after, message on the right:

		if (evData.target == self.abilityOwner or evData.targetID == self.abilityOwner:getID()) and not before then 
			if evType == simdefs.EV_UNIT_HEAL and evData.revive and not before then	    			
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
	-- BLOCK END	
		
	end,

	-- trigger

	onTrigger = function( self, sim, evType, evData  )	
		local script = sim:getLevelScript()
		local agentDef = self.abilityOwner:getUnitData()
		if (evData.unit == self.abilityOwner or evData.unitID == self.abilityOwner:getID()) and not evData.cancel then 	
			if not self.abilityOwner:isKO() then				
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
								--script:queue( { type="clearOperatorMessage" } ) -- it autoclears after "timing =3" I think
							end
						end
					end
				end
			end
		end
	end,
	
}

return alpha_voice
