require "mod-gui"

local Weights = require "weights"
local di = defines.inventory

Functions =
{
	Globals = function()
		global.PlayerData = global.PlayerData or {}
		global.MapData = global.MapData or { mw = settings.global["WeightSystemMaxWeight"].value, mwi = 0 }
		global.Weights = Weights
	end,
	WGlobals = function()
		global.Categories = {}
		global.ICategories = {}
		global.SWeight = {}
		global.CWeight = {}
		global.IAList = {}
		global.IEList = {}
	end,
	Players = function()
		local md = global.MapData
		for _, p in pairs( game.players ) do
			local id = p.index
			global.PlayerData[id] = { cw = 0, mw = md.mw + md.mwi }
			local i = p.get_inventory( di.player_armor )
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
		end
	end,
	Load = function()
		Functions.Globals()
		Functions.WGlobals()
		Functions.DataUpdate()
		Functions.Players()
	end,
	DataUpdate = function()
		for n, c in pairs( global.Weights ) do
			table.insert( global.Categories, n )
			global.ICategories[n] = {}
			local m = game.forces["player"].get_ammo_damage_modifier( n )
			for w, v in pairs( c ) do
				if w == "Increase" then
					if n == "Armor" then
						for a, i in pairs( v ) do
							global.IAList[a] = i
						end
					elseif n == "Equipments" then
						for e, i in pairs( v ) do
							global.IEList[e] = i
						end
					end
				elseif game.item_prototypes[w] then
					table.insert( global.ICategories[n], w )
					global.SWeight[w] = v
					global.CWeight[w] = v - ( v * m )
				end
			end
		end
	end,
	Update = function( id )
		local p = game.players[id]
		local c = p.character
		local cw = global.CWeight
		local md = global.MapData
		local ia = global.IAList
		local ie = global.IEList
		local b = 0
		local w = 0
		local i
		i = p.get_main_inventory().get_contents()
		for n, v in pairs( i ) do
			if cw[n] then
				w = w + ( v * cw[n] )
			end
		end
		i = p.get_quickbar().get_contents()
		for n, v in pairs( i ) do
			if cw[n] then
				w = w + ( v * cw[n] )
			end
		end
		i = p.get_inventory( di.player_trash ).get_contents()
		for n, v in pairs( i ) do
			if cw[n] then
				w = w + ( v * cw[n] )
			end
		end
		i = p.get_inventory( di.player_armor )
		if not i.is_empty() then
			local n = i[1].name
			if ia[n] then
				b = ia[n]
			end
		end
		if c.grid then
			local e = c.grid.get_contents()
			for n, a in pairs( e ) do
				if ie[n] then
					b = b + ( a * ie[n] )
				end
			end
		end
		if c.stickers then
			for _, n in pairs( c.stickers ) do
				if n.name:find( "Weight" ) then
					n.destroy()
				end
			end
		end
		if global.PlayerData and global.PlayerData[id] then
			local mw = md.mw + b
			mw = mw + (mw * md.mwi )
			global.PlayerData[id].cw = w
			global.PlayerData[id].mw = mw
			local ps = Functions.Round( w / mw * 100 )
			if ps > 0 and ps < 100 then
				p.surface.create_entity{ name = "Weight-Sticker-" .. ps, position = p.position, target = p.character }
			elseif ps >= 100 then
				if settings.global["WeightSystemHardcoreMode"].value and w >= mw * 10 then
					p.die()
				else
					p.surface.create_entity{ name = "Weight-Sticker-100", position = p.position, target = p.character }
				end
			end
		end
		Functions.UpdateCaption( id )
	end,
	GetCaption = function( id )
		local p = global.PlayerData[id]
		return p.cw .. "/" .. p.mw .. "kg"
	end,
	UpdateCaption = function( id )
		local pd = global.PlayerData[id]
		mod_gui.get_button_flow( game.players[id] ).WeightSystemButton.caption = Functions.GetCaption( id )
	end,
	MainGui = function( p )
		local A01 = Functions.AddFrame( p, "WeightSystemMainGui", nil, "Select a Weight Category" )
		local A02 =
		{
			Functions.AddFlow( A01, "WeightSystemFlow01", "description_vertical_flow" ),
			Functions.AddDropDown( A01, "WeightSystemDropDown", global.Categories ),
			Functions.AddFrame( A01, "WeightSystemFrame01", "outer_frame", nil )
		}
		local A03 = Functions.AddTable( A02[1], "WeightSystemTable01", 2 )
		local A04 =
		{
			Functions.AddLabel( A03, "WeightSystemLabel01", "Max Weight Increase:", "description_label" ),
			Functions.AddLabel( A03, "WeightSystemLabel02", ( global.MapData.mwi * 100 ) .. "%", "description_value_label" )
		}
	end,
	WeightGui = function( p, i, name )
		local c = 2 * settings.global["WeightSystemGUIColumnCount"].value
		local B01 = Functions.AddFlow( p, "WeightSystemFlow02", "description_vertical_flow" )
		local B02 =
		{
			Functions.AddTable( B01, "WeightSystemTable02", 2 ),
			Functions.AddScrollPane( p, "WeightSystemScrollPane" )
		}
		B02[2].style.maximal_height = 270
		local B03 =
		{
			Functions.AddLabel( B02[1], "WeightSystemLabel03", "Decrease", "description_label" ),
			Functions.AddLabel( B02[1], "WeightSystemLabel04", ( game.forces["player"].get_ammo_damage_modifier( name ) * 100 ) .. "%", "description_value_label" ),
			Functions.AddFrame( B02[2], "WeightSystemFrame02", "image_frame", nil )
		}
		B03[3].style.left_padding = 4
		B03[3].style.right_padding = 8
		B03[3].style.bottom_padding = 4
		B03[3].style.top_padding = 4
		local B04 = Functions.AddTable( B03[3], "WeightSystemTable03", c )
		B04.style.horizontal_spacing = 16
		B04.style.vertical_spacing = 8
		B04.draw_horizontal_line_after_headers = true
		B04.draw_vertical_lines = true
		for n = 2, c, 2 do
			B04.style.column_alignments[n] = "center"
		end
		for n = 1, c / 2 do
			local B05 =
			{
				Functions.AddLabel( B04, "WeightSystemLabel02_" .. n, "Item" ),
				Functions.AddLabel( B04, "WeightSystemLabel03_" .. n, "Weight" )
			}
		end
		for n = 1, #i do
			local na = i[n]
			local B06 =
			{
				Functions.AddSprite( B04, "WeightSystemSprite_" .. n, "item/" .. na ),
				Functions.AddLabel( B04, "WeightSystemLabel04_" .. n, global.CWeight[na] )
			}
			local z = game.entity_prototypes[na] or game.tile_prototypes[na] or game.equipment_prototypes[na] or game.item_prototypes[na]
			B06[1].tooltip = z.localised_name
			B06[1].style.width = 32
			B06[1].style.height = 32
		end
	end,
	AddButton = function( f, n, c )
		return f.add{ type = "button", name = n, caption = c }
	end,
	AddDropDown = function( f, n, i )
		return f.add{ type = "drop-down", name = n, items = i }
	end,
	AddFlow = function( f, n, s )
		return f.add{ type = "flow", name = n, direction = "vertical", style = s }
	end,
	AddFrame = function( f, n, s, c )
		return f.add{ type = "frame", name = n, direction = "vertical", style = s, caption = c }
	end,
	AddLabel = function( f, n, c, s )
		return f.add{ type = "label", name = n, caption = c, style = s }
	end,
	AddScrollPane = function( f, n )
		return f.add{ type = "scroll-pane", name = n }
	end,
	AddSprite = function( f, n, s )
		return f.add{ type = "sprite", name = n, sprite = s }
	end,
	AddTable = function( f, n, c )
		return f.add{ type = "table", name = n, column_count = c }
	end,
	Round = function( n )
		return math.floor( n * 1 + 0.5 ) / 1
	end
}

return Functions