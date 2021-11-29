local util = include("modules/util")
local serverdefs = include( "modules/serverdefs" )
local simdefs = include( "sim/simdefs" )

local voicedAgents = {} -- to be populated with agentdefs that get debug voice

local QuipsEnabled
-- local hostageEvent = nil
local quippingagent = nil

local function init( modApi )
	local scriptPath = modApi:getScriptPath()
	local dataPath = modApi:getDataPath()
	
	include( scriptPath .. "/eventlistener" )
	
	modApi.requirements = {"Sim Constructor","No Dialogues (Reworked)"}	
	
	    -- Mount data (icons, agent upgrade pic).
	KLEIResourceMgr.MountPackage( dataPath .. "/dlc_banter_ico.kwad", "data" ) 	

	modApi:addGenerationOption("alpha_voice", STRINGS.alpha_voice.OPTIONS.MOD , STRINGS.alpha_voice.OPTIONS.MOD_TIP, {noUpdate = true})	
	
	modApi:addGenerationOption("chattyguards", STRINGS.alpha_voice.OPTIONS.GUARDS, STRINGS.alpha_voice.OPTIONS.GUARDS_TIP, {noUpdate = true} )
	
	modApi:addGenerationOption("talkativeagents_multiplier", STRINGS.alpha_voice.OPTIONS.FREQUENCY, STRINGS.alpha_voice.OPTIONS.FREQUENCY_TIP, 
	{
		values = {0.1, 0.3, 0.5, 1, 1.5, 2}, 
		strings = STRINGS.alpha_voice.OPTIONS.FREQUENCY_STRINGS, 
		value=1,
		noUpdate = true,
	})
	
	-- modApi:addGenerationOption("burnttoast", STRINGS.alpha_voice.OPTIONS.BURNT_TOAST, STRINGS.alpha_voice.OPTIONS.BURNT_TOAST_TIP, {enabled = false, noUpdate = true} )	
	
	
end


local function lateInit()
	
	-- some blatant hijacking of script event queue stuff to remove clunky delays for hostages and agent rescues
	
	local mission_panel = require "hud/mission_panel"
	local oldProcessEvent = mission_panel.processEvent
	mission_panel.processEvent = function(self, event)
		
		local agentHireTexts = {}
		local agents = include("sim/unitdefs/agentdefs")
		for i, agentdef in pairs(agents) do
			if agentdef.hireText then 
				agentHireTexts[agentdef.hireText] = true
			end
		end
		
		-- log:write("LOG event")
		-- log:write(util.stringize(event,4))
		if QuipsEnabled and type(event) == "table" and event.type == "newOperatorMessage" then
			if event.script then
				if event.script[1].text == STRINGS.MISSIONS.ESCAPE.OPERATOR_HOSTAGE_CONVO1 and (event.script[1].donotskip == nil) then
				-- donotskip is a special flag for the manual re-adding of Central's line

					-- hostageEvent = event
					self._skipping = nil
					-- remove Central's comment and manually re-add it in alpha_voice, independent of agent oneliner
					-- technically, this will make Central's line not show up at all in the hypothetical event that you have a non-agent who doesn't have the voice ability rescue the hostage, but........ \o/
				else
				
					oldProcessEvent( self, event )

				end
			
				
			else
				oldProcessEvent( self, event )
			end

		else
			if type(event) == "table" and (event.type == "enemyMessage" or event.type == "modalConversation") then
				-- log:write("LOG enemy message")
				-- log:write(util.stringize(event,2))
				
				local rescuedline = false
				
				if event.body and agentHireTexts[event.body] then
				local queueLine = self._hud._game.simCore:getLevelScript():getQueue()
				if type(queueLine[1]) == "number" and queueLine[1] == 480 then
					queueLine[1] = 240 --get the next entry in the script queue which should be an 8 second delay after the hireText script. changes 8 second delay to 4 second
				end
				-- log:write("LOG queue")
				-- log:write(util.stringize(queueLine,3))
				end
						
			end
			
			oldProcessEvent( self, event )
			
		end
		
	
	end
		
end

local function load(modApi, options, params)
	local scriptPath = modApi:getScriptPath()
	modApi:addAbilityDef( "alpha_voice", scriptPath .."/alpha_voice" )
	if options["chattyguards"] and options["chattyguards"].enabled and params then
		params.chattyguards = true
	end
	
	if options["talkativeagents_multiplier"] and params then
		params.talkativeagents_multiplier = options["talkativeagents_multiplier"].value
	end
	
	-- if options["burnttoast"] and params then
		-- params.burnttoast = options["burnttoast"].value
	-- end
	
end

local function initStrings(modApi)
	local scriptPath = modApi:getScriptPath()
	local dataPath = modApi:getDataPath()
	
	local DLC_STRINGS = include( scriptPath .. "/strings" )
 	modApi:addStrings( dataPath, "alpha_voice", DLC_STRINGS )
end

local function addAbilityToDef(id,def)
	if def.abilities and voicedAgents[id] == nil then
		voicedAgents[id] = def
		table.insert(def.abilities, "alpha_voice")
	end
end

local function unload()
	--take away debug voices
	for id, def in pairs(voicedAgents) do
		for i, v in ipairs(def.abilities) do
			if v == "alpha_voice" then
				table.remove(def.abilities, i)
				break
			end
		end
	end
	voicedAgents = {}
	QuipsEnabled = false
end

local function lateLoad(modApi, options, params, allOptions)
	if options["alpha_voice"].enabled then
		local agents = include( "sim/unitdefs/agentdefs" )
		for k,v in pairs(agents) do
			--debug give everybody the voice ability
			addAbilityToDef(k,v)
		end

		local guards = include( "sim/unitdefs/guarddefs" )
		for k,v in pairs(guards) do
			--debug give everybody the voice ability
			addAbilityToDef(k,v)
		end
	QuipsEnabled = true
	else
		unload()
	end
end

return {
    init = init,
	lateInit = lateInit,
    load = load,
	lateLoad = lateLoad,
	unload = unload,
    initStrings = initStrings,
}
