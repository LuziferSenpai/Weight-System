require "mod-gui"

local Functions = require "functions"
local ev = defines.events
local di = defines.inventory
local NOWEIGHT = require "noweight"

script.on_init( Functions.Load )

script.on_configuration_changed( Functions.Load )

script.on_event(
	{
		ev.on_player_main_inventory_changed,
		ev.on_player_quickbar_inventory_changed,
		ev.on_player_trash_inventory_changed,
		ev.on_player_armor_inventory_changed,
		ev.on_player_placed_equipment
	},
	function( ee )
		Functions.Update( ee.player_index )
	end
)

script.on_event( ev.on_player_created, function( ee )
	local id = ee.player_index
	local p = game.players[id]
	local md = global.MapData
	local i = p.get_inventory( di.player_armor )
	global.PlayerData[id] = { cw = 0, ai = 0, ei = 0, mw = md.mw + md.mwi }
	if not i.is_empty() then
		local n = i[1].name
		if global.IAList[n] then
			global.PlayerData[id].bwa = global.IAList[n]
		end
	end
	local m = mod_gui.get_button_flow( p )
	if not m.WeightSystemButton then
		local b = Functions.AddButton( m, "WeightSystemButton", Functions.GetCaption( id ) )
		b.style.visible = true
	end
end )

script.on_event( ev.on_runtime_mod_setting_changed, function( ee )
	if ee.setting == "WeightSystemMaxWeight" then
		global.MapData.mw = settings.global["WeightSystemMaxWeight"].value
		for _, p in pairs( game.players ) do
			Functions.Update( p.index )
		end
	end
end )

script.on_event( { ev.on_gui_click, ev.on_gui_selection_state_changed }, function( ee )
	local id = ee.player_index
	local p = game.players[id]
	local e = ee.element
	local n = e.name
	local pa = e.parent
	local m = mod_gui.get_frame_flow( p )

	if not ( n or pa ) then return end

	if n == "WeightSystemButton" then
		if m.WeightSystemMainGui then
			m.WeightSystemMainGui.destroy()
		else
			Functions.MainGui( m )
		end
		return
	elseif n == "WeightSystemDropDown" and e.selected_index > 0 then
		pa.children[3].clear()
		local n = global.Categories[e.selected_index]
		Functions.WeightGui( pa.children[3], global.ICategories[n], n )
		return
	end
end )

script.on_event( ev.on_research_finished, function( ee )
	if ee == nil then return end
	local r = ee.research
	local e = r.effects
	local f = game.forces["player"]
	for _, p in pairs( e ) do
		if p.type == "ammo-damage" then
			local a = p.ammo_category
			local m = f.get_ammo_damage_modifier( a )
			if a == "MaxWeight" then
				global.MapData.mwi = m
			elseif global.ICategories[a] then
				for _, n in pairs( global.ICategories[a] ) do
					global.CWeight[n] = global.SWeight[n] - ( global.SWeight[n] * m )
				end
			end
			for _, p in pairs( game.players ) do
				Functions.Update( p.index )
			end
		end
	end
end )

commands.add_command("missing_weights", "Prints out the Missing Weights", function()
	local t = ""
	for n, i in pairs( game.item_prototypes ) do
		if not ( global.SWeight[n] or NOWEIGHT[n] or n:find( "creative" ) or n:find( "blueprint" ) or n:find( "book" ) or n:find( "forcefield" ) ) then
				t = t .. n .. "\n"
		end
	end
	game.write_file( "missing_weights.txt", t )
end )