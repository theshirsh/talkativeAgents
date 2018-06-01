local util = include("modules/util")
local serverdefs = include( "modules/serverdefs" )
local simdefs = include( "sim/simdefs" )
--local cutil = include("client/client_util")

local voicedAgents = {} -- to be populated with agentdefs that get debug voice

local function init( modApi )
	modApi.requirements = {"Sim Constructor"}	
	modApi:addGenerationOption("alpha_voice", STRINGS.alpha_voice.OPTIONS.MOD , STRINGS.alpha_voice.OPTIONS.MOD_TIP, {noUpdate = true})  
	
end

local function load(modApi, options, params)
	local scriptPath = modApi:getScriptPath()
	modApi:addAbilityDef( "alpha_voice", scriptPath .."/alpha_voice" )
end

local function initStrings(modApi
	local scriptPath = modApi:getScriptPath()
	local dataPath = modApi:getDataPath()
	
	local DLC_STRINGS = include( scriptPath .. "/strings" )
 	modApi:addStrings( dataPath, "alpha_voice", DLC_STRINGS )
end

local function addAbilityToDef(id,def)
	if def.abilities and voicedAgents[id] == nil then
		voicedAgents[id] == def
		table.insert(v.abilities, "alpha_voice")
	end
end

local function unload()
	--take away debug voices
	for id, def in pairs(voicedAgents) do
		for i, v in ipairs(def.abilities) do
			if v == "alpha_voice" then
				table.remove(agents[k].abilities, i)
				break
			end
		end
	end
	voicedAgents = {}
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
	else
		unload()
	end
end

return {
    init = init,
    load = load,
	lateLoad = lateLoad,
	unload = unload,
    initStrings = initStrings,
}
