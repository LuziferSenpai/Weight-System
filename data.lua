require "bonus-gui-ordering"
local Weights = require "weights"
local MODNAME = "__Weight_System__"
WeightSystem = WeightSystem or {}
WeightSystem.Functions =
{
	Tech =
	{
		type = "technology",
		icon_size = 128,
		effects = { { type = "ammo-damage" } },
		upgrade = true,
		order = "w-w-w"
	},
	AddTech = function( n, i, c, m, p, u, l )
		local t = util.table.deepcopy( WeightSystem.Functions.Tech )
		t.name = n
		t.icon = i
		t.effects[1].ammo_category = c
		t.effects[1].modifier = m
		t.prerequisites = p
		t.unit = u
		t.max_level = l
		if c == "MaxWeight" then
			t.localised_name = { "Weight-System.MaxWeight" }
			t.localised_description = { "Weight-System.DescriptionMaxWeight" }
		else
			t.localised_name = { "Weight-System.Tech", { "Weight-System." .. c } }
			t.localised_description = { "Weight-System.DescriptionTech", { "Weight-System." .. c } }
		end

		data:extend{ t }
	end,
}

for n in pairs( Weights ) do
	data:extend{ { type = "ammo-category", name = n } }
	WeightSystem.Functions.AddTech( "WeightSystem-" .. n .. "-1", MODNAME .. "/graphics/test.png", n, 0.02, nil, { count_formula = "200*L", ingredients = { { "science-pack-1", 2 }, { "science-pack-2", 2 }, { "science-pack-3", 2 }, { "production-science-pack", 2 }, { "high-tech-science-pack", 2 } }, time = 60 }, 5 )
	WeightSystem.Functions.AddTech( "WeightSystem-" .. n .. "-6", MODNAME .. "/graphics/test.png", n, 0.10, { "WeightSystem-" .. n .. "-1" }, { count_formula = "200*L", ingredients = { { "science-pack-1", 2 }, { "science-pack-2", 2 }, { "science-pack-3", 2 }, { "production-science-pack", 2 }, { "high-tech-science-pack", 2 }, { "space-science-pack", 2 } }, time = 60 }, 9 )
end

local m = "MaxWeight"
data:extend{ { type = "ammo-category", name = m } }
WeightSystem.Functions.AddTech( "WeightSystem-" .. m .. "-1", MODNAME .. "/graphics/test.png", m, 0.05, nil, { count_formula = "100*L", ingredients = { { "science-pack-1", 1 }, { "science-pack-2", 1 }, { "science-pack-3", 1 } }, time = 30 }, 3 )
WeightSystem.Functions.AddTech( "WeightSystem-" .. m .. "-4", MODNAME .. "/graphics/test.png", m, 0.10, { "WeightSystem-MaxWeight-1" }, { count_formula = "150*L", ingredients = { { "science-pack-1", 1 }, { "science-pack-2", 1 }, { "science-pack-3", 1 }, { "production-science-pack", 1 } }, time = 60 }, 7 )
WeightSystem.Functions.AddTech( "WeightSystem-" .. m .. "-8", MODNAME .. "/graphics/test.png", m, 0.20, { "WeightSystem-MaxWeight-4" }, { count_formula = "200*L", ingredients = { { "science-pack-1", 2 }, { "science-pack-2", 2 }, { "science-pack-3", 2 }, { "production-science-pack", 2 }, { "high-tech-science-pack", 2 } }, time = 90 }, 11 )
WeightSystem.Functions.AddTech( "WeightSystem-" .. m .. "-12", MODNAME .. "/graphics/test.png", m, 1, { "WeightSystem-MaxWeight-8" }, { count_formula = "250*L", ingredients = { { "science-pack-1", 5 }, { "science-pack-2", 5 }, { "science-pack-3", 5 }, { "production-science-pack", 3 }, { "high-tech-science-pack", 2 }, { "space-science-pack", 2 } }, time = 120 }, "infinite" )

local ses = util.table.deepcopy( data.raw["sticker"]["slowdown-sticker"] )
ses.animation = nil
ses.duration_in_ticks = 4294967295
for n = 1, 100 do
	local se = util.table.deepcopy( ses )
	se.name = "Weight-Sticker-" .. n
	se.target_movement_modifier = 1 - n / 100
	data:extend{ se }
end