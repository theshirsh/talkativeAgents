local util = include("modules/util")
local serverdefs = include( "modules/serverdefs" )
local simdefs = include( "sim/simdefs" )
--local cutil = include("client/client_util")

local voicedAgents = {} -- to be populated with agentdefs that get debug voice

local function init( modApi )
	local scriptPath = modApi:getScriptPath()
	local dataPath = modApi:getDataPath()
	local DLC_STRINGS = include( scriptPath .. "/strings" )
 	modApi:addStrings( dataPath, "alpha_voice", DLC_STRINGS )
	modApi.requirements = {"Sim Constructor"}	
	modApi:addGenerationOption("alpha_voice", STRINGS.alpha_voice.OPTIONS.MOD , STRINGS.alpha_voice.OPTIONS.MOD_TIP, {noUpdate = true})  
	
end

local function load(modApi, options, params)
	local scriptPath = modApi:getScriptPath()
	include( scriptPath .. "/eventlistener" )
	modApi:addAbilityDef( "alpha_voice", scriptPath .."/alpha_voice" )
end

local function initStrings(modApi)
end

local function lateLoad(modApi, options, params, allOptions)
	local agents = include( "sim/unitdefs/agentdefs" )
	for k,v in pairs(agents) do
		--debug give everybody the voice ability
		if v.abilities and nil == util.indexOf(v.abilities, "alpha_voice") then
			-- log:write("Adding voice to ".. k)
			table.insert(voicedAgents, k)
			table.insert(v.abilities, "alpha_voice")
		end
	end
end

local function unload()
	--take away debug voices
	if #voicedAgents > 0 then
		local agents = include( "sim/unitdefs/agentdefs" )
		for _,k in pairs(voicedAgents) do
			if agents[k] then
				for i, v in pairs(agents[k].abilities) do
					if v == "alpha_voice" then
						-- log:write("Removing voice from ".. k)
						table.remove(agents[k].abilities, i)
						break
					end
				end
			end
		end
	end
end

return {
    init = init,
    load = load,
	lateLoad = lateLoad,
	unload = unload,
    initStrings = initStrings,
}