--[[function modtest( n )
	if ( mods and mods[n] ) or ( game and game.active_mods[n] ) then
		return true
	else
		return false
	end
end]]--

local Weights =
{
	["Ammo"] =
	{
		-- Vanilla

		["firearm-magazine"] = 0.3,
		["piercing-rounds-magazine"] = 0.3,
		["uranium-rounds-magazine"] = 0.3,
		["shotgun-shell"] = 0.5,
		["piercing-shotgun-shell"] = 0.5,
		["cannon-shell"] = 5,
		["explosive-cannon-shell"] = 5,
		["uranium-cannon-shell"] = 5,
		["explosive-uranium-cannon-shell"] = 5,
		["artillery-shell"] = 200,
		["rocket"] = 1,
		["explosive-rocket"] = 1,
		["atomic-bomb"] = 500,
		["flamethrower-ammo"] = 0.5,
		["grenade"] = 0.34,
		["cluster-grenade"] = 1,
		["poison-capsule"] = 1,
		["slowdown-capsule"] = 1,

		-- Senpais Trains
		["dora-shell"] = 1500
	},
	["Armor"] =
	{
		-- Vanilla

		["light-armor"] = 15,
		["heavy-armor"] = 30,
		["modular-armor"] = 25,
		["power-armor"] = 40,
		["power-armor-mk2"] = 40,

		-- Increase

		["Increase"] =
		{
			-- Vanilla

			["power-armor"] = 25,
			["power-armor-mk2"] = 75
		}
	},
	["Assembling"] =
	{
		-- Vanilla

		["assembling-machine-1"] = 10000,
		["assembling-machine-2"] = 10000,
		["assembling-machine-3"] = 10000,
		["oil-refinery"] = 20000,
		["chemical-plant"] = 12500,
		["centrifuge"] = 48000,
		["rocket-silo"] = 1000000,

		-- MoreScience

		["seed-extractor"] = 7500,
		["wood-plantation"] = 10000,
	},
	["Barrels"] =
	{
		-- Vanilla

		["empty-barrel"] = 1,
		["crude-oil-barrel"] = 2,
		["heavy-oil-barrel"] = 2,
		["light-oil-barrel"] = 2,
		["lubricant-barrel"] = 2,
		["petroleum-gas-barrel"] = 2,
		["sulfuric-acid-barrel"] = 2,
		["water-barrel"] = 2,

		-- MoreScience

		["advanced-science-fluid-1-barrel"] = 2,
		["advanced-science-fluid-2-barrel"] = 2,
		["basic-automation-science-fluid-barrel"] = 2,
		["basic-logistics-science-fluid-barrel"] = 2,
		["basic-military-science-fluid-barrel"] = 2,
		["basic-power-science-fluid-barrel"] = 2,
		["basic-science-fluid-1-barrel"] = 2,
		["basic-science-fluid-2-barrel"] = 2,
		["basic-science-fluid-3-barrel"] = 2,
		["extreme-science-fluid-barrel"] = 2,
		["purified-water-barrel"] = 2,
	},
	["Belts"] =
	{
		-- Vanilla

		["transport-belt"] = 0.5,
		["fast-transport-belt"] = 0.5,
		["express-transport-belt"] = 0.5
	},
	["Cars"] =
	{
		-- Vanilla

		["car"] = 700,
		["tank"] = 2000
	},
	["Circuits"] =
	{
		-- Vanilla

		["small-lamp"] = 0.5,
		["red-wire"] = 0.1,
		["green-wire"] = 0.1,
		["arithmetic-combinator"] = 0.5,
		["decider-combinator"] = 0.5,
		["constant-combinator"] = 0.25,
		["power-switch"] = 1,
		["programmable-speaker"] = 1,

		-- SantasNixieTubeDisplay

		["SNTD-nixie-tube"] = 1,
		["SNTD-nixie-tube-small"] = 0.5,

		-- Wireless Circuit Network

		["Wireless-Sender"] = 1,
		["Wireless-Reciever"] = 1,
	},
	["Defense"] =
	{
		-- Vanilla

		["artillery-wagon"] = 4000,
		["defender-capsule"] = 5,
		["distractor-capsule"] = 5,
		["destroyer-capsule"] = 5,
		["land-mine"] = 2,
		["stone-wall"] = 15,
		["gate"] = 17.5,
		["gun-turret"] = 175,
		["laser-turret"] = 250,
		["flamethrower-turret"] = 175,
		["artillery-turret"] = 1000,
		["radar"] = 500,

		-- ForceFields2

		["forcefield-emitter"] = 100,

		-- Reinforced Walls

		["reinforced-wall"] = 25,
		["acid-resist-wall"] = 30,
		["damage-reflect-wall"] = 45,


		-- Senpais Trains

		["Senpais-Dora"] = 8000,
	},
	["Drills"] =
	{
		-- Vanilla

		["burner-mining-drill"] = 200,
		["electric-mining-drill"] = 250,
		["offshore-pump"] = 250,
		["pumpjack"] = 250
	},
	["Energy"] =
	{
		-- Vanilla

		["boiler"] = 300,
		["steam-engine"] = 700,
		["steam-turbine"] = 1000,
		["solar-panel"] = 100,
		["accumulator"] = 125,
		["nuclear-reactor"] = 10000,
		["heat-exchanger"] = 275,
		["heat-pipe"] = 1,

		-- Senpais Trains

		["Senpais-Power-Provider"] = 125
	},
	["Equipments"] =
	{
		-- Vanilla

		["solar-panel-equipment"] = 25,
		["fusion-reactor-equipment"] = 25,
		["energy-shield-equipment"] = 25,
		["energy-shield-mk2-equipment"] = 25,
		["battery-equipment"] = 25,
		["battery-mk2-equipment"] = 25,
		["personal-laser-defense-equipment"] = 25,
		["discharge-defense-equipment"] = 25,
		["exoskeleton-equipment"] = 25,
		["personal-roboport-equipment"] = 25,
		["personal-roboport-mk2-equipment"] = 25,
		["night-vision-equipment"] = 25,

		-- CorpseFlare

		["corpse-flare"] = 6,

		-- Senpais Trains

		["laser-2"] = 25,

		-- Increase

		["Increase"] =
		{
			-- Vanilla
			
			["exoskeleton-equipment"] = 25
		}
	},
	["Fuel"] =
	{
		-- Vanilla

		["raw-wood"] = 1,
		["solid-fuel"] = 4,
		["rocket-fuel"] = 7.5,
		["nuclear-fuel"] = 10,
		["uranium-fuel-cell"] = 12.75
	},
	["Furnaces"] =
	{
		-- Vanilla
		
		["stone-furnace"] = 200,
		["steel-furnace"] = 500,
		["electric-furnace"] = 700
	},
	["GroundTiles"] =
	{
		-- Vanilla

		["stone-brick"] = 3,
		["concrete"] = 5,
		["hazard-concrete"] = 5,
		["refined-concrete"] = 7.5,
		["refined-hazard-concrete"] = 7.5,
		["landfill"] = 10,

		-- Landmover

		["landmover"] = 10
	},
	["Ingredients"] =
	{
		-- Vanilla

		["wood"] = 0.25,
		["copper-cable"] = 0.01,
		["iron-stick"] = 0.2,
		["iron-gear-wheel"] = 0.5,
		["electronic-circuit"] = 0.5,
		["advanced-circuit"] = 0.5,
		["processing-unit"] = 0.5,
		["raw-fish"] = 0.3,
		["sulfur"] = 0.25,
		["plastic-bar"] = 0.1,
		["engine-unit"] = 10,
		["electric-engine-unit"] = 12.5,
		["explosives"] = 0.5,
		["battery"] = 0.1,
		["flying-robot-frame"] = 1,
		["low-density-structure"] = 25,
		["rocket-control-unit"] = 17.5,
		["rocket-part"] = 50,
		["satellite"] = 600,
		["uranium-235"] = 4,
		["uranium-238"] = 5,
		["used-up-uranium-fuel-cell"] = 3,

		-- MoreScience

		["cork"] = 0.1,
		["empty-bottle"] = 2,
		["rocketpart-hull-component"] = 200,
		["rocketpart-ion-thruster"] = 1500,
		["rocketpart-ion-booster"] = 8000,
		["rocketpart-fusion-reactor"] = 5000,
		["rocketpart-shield-array"] = 3000,
		["rocketpart-laser-array"] = 3000,
	},
	["Inserters"] =
	{
		-- Vanilla

		["burner-inserter"] = 15,
		["inserter"] = 15,
		["long-handed-inserter"] = 15,
		["fast-inserter"] = 15,
		["filter-inserter"] = 15,
		["stack-inserter"] = 15,
		["stack-filter-inserter"] = 15
	},
	["Loaders"] =
	{
		-- Vanilla

		["loader"] = 10,
		["fast-loader"] = 10,
		["express-loader"] = 10
	},
	["Locomotives"] =
	{
		-- Vanilla

		["locomotive"] = 2000,

		-- Senpais Trains

		["Senpais-Electric-Train"] = 2000,
		["Senpais-Electric-Train-Heavy"] = 5000,
		["Battle-Loco-1"] = 2000,
		["Battle-Loco-2"] = 4000,
		["Battle-Loco-3"] = 6000,
		["Elec-Battle-Loco-1"] = 2000,
		["Elec-Battle-Loco-2"] = 4000,
		["Elec-Battle-Loco-3"] = 6000
	},
	["Logistics"] =
	{
		-- Vanilla

		["logistic-robot"] = 5,
		["construction-robot"] = 5,
		["logistic-chest-active-provider"] = 15,
		["logistic-chest-passive-provider"] = 15,
		["logistic-chest-storage"] = 15,
		["logistic-chest-buffer"] = 15,
		["logistic-chest-requester"] = 15,
		["roboport"] = 150
	},
	["Modules"] = 
	{
		-- Vanilla

		["beacon"] = 125,
		["speed-module"] = 0.5,
		["speed-module-2"] = 0.5,
		["speed-module-3"] = 0.5,
		["effectivity-module"] = 0.5,
		["effectivity-module-2"] = 0.5,
		["effectivity-module-3"] = 0.5,
		["productivity-module"] = 0.5,
		["productivity-module-2"] = 0.5,
		["productivity-module-3"] = 1
	},
	["Ores"] =
	{
		-- Vanilla

		["iron-ore"] = 0.5,
		["copper-ore"] = 0.5,
		["stone"] = 0.5,
		["coal"] = 0.5,
		["uranium-ore"] = 1,

		-- MoreScience

		["tree-seed"] = 0.3,
	},
	["Other"] =
	{
		-- Vanilla

		["cliff-explosives"] = 1.25,
		["discharge-defense-remote"] = 0.5,
		["artillery-targeting-remote"] = 0.5
	},
	["Pipes"] =
	{
		-- Vanilla

		["pipe"] = 2.5,
		["pipe-to-ground"] = 2.5,
		["pump"] = 10
	},
	["Plates"] =
	{
		-- Vanilla

		["iron-plate"] = 1,
		["copper-plate"] = 1,
		["steel-plate"] = 5,

		-- MoreScience

		["sand"] = 0.4,
		["glass"] = 1,
		["organic-tree"] = 3,
	},
	["Poles"] =
	{
		-- Vanilla

		["small-electric-pole"] = 10,
		["medium-electric-pole"] = 36,
		["big-electric-pole"] = 100,
		["substation"] = 200
	},
	["RailStuff"] =
	{
		-- Vanilla

		["rail-signal"] = 5,
		["rail-chain-signal"] = 5,
		["rail"] = 25,
		["train-stop"] = 30
	},
	["Science"] =
	{
		-- Vanilla

		["lab"] = 200,
		["science-pack-1"] = 2.5,
		["science-pack-2"] = 2.5,
		["science-pack-3"] = 2.5,
		["military-science-pack"] = 2.5,
		["production-science-pack"] = 2.5,
		["high-tech-science-pack"] = 2.5,
		["space-science-pack"] = 2.5,

		-- MoreScience

		["lab-burner"] = 175,
		["lab-mk2"] = 300,
		["basic-automation-science-pack"] = 2.5,
		["basic-power-science-pack"] = 2.5,
		["basic-logistics-science-pack"] = 2.5,
		["infused-basic-science-pack-1"] = 4.5,
		["infused-basic-science-pack-2"] = 4.5,
		["infused-basic-military-science-pack"] = 4.5,
		["infused-basic-automation-science-pack"] = 4.5,
		["infused-basic-science-pack-3"] = 4.5,
		["infused-basic-power-science-pack"] = 4.5,
		["infused-advanced-science-pack-1"] = 4.5,
		["infused-basic-logistics-science-pack"] = 4.5,
		["infused-advanced-science-pack-2"] = 4.5,
		["infused-extreme-science-pack"] = 4.5,
	},
	["Splitter"] =
	{
		-- Vanilla

		["splitter"] = 5,
		["fast-splitter"] = 5,
		["express-splitter"] = 5
	},
	["Storage"] =
	{
		-- Vanilla

		["wooden-chest"] = 10,
		["iron-chest"] = 20,
		["steel-chest"] = 50,
		["storage-tank"] = 125,

		-- Item Collector Updated

		["item-collector-area"] = 50,
	},
	["Tools"] =
	{
		-- Vanilla

		["iron-axe"] = 3,
		["steel-axe"] = 6,
		["repair-pack"] = 1.5,

		-- Atomic Pickaxe

		["atomic-pickaxe"] = 7.5,

		-- Land Mover

		["landmover-shovel"] = 3,

		-- More Science

		["hand-saw"] = 3,
	},
	["UBelts"] =
	{
		-- Vanilla

		["underground-belt"] = 0.75,
		["fast-underground-belt"] = 0.75,
		["express-underground-belt"] = 0.75
	},
	["Wagons"] =
	{
		-- Vanilla

		["cargo-wagon"] = 1000,
		["fluid-wagon"] = 1000,

		-- Senpais Trains

		["Battle-Wagon-1"] = 2000,
		["Battle-Wagon-2"] = 4000,
		["Battle-Wagon-3"] = 6000
	},
	["Weapons"] =
	{
		-- Vanilla

		["pistol"] = 0.7,
		["submachine-gun"] = 3.49,
		["shotgun"] = 2.47,
		["combat-shotgun"] = 3.45,
		["rocket-launcher"] = 10,
		["flamethrower"] = 15
	},
}

return Weights