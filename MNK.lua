-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
	state.CombatForm = get_combat_form()
	update_melee_groups()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'MidAcc', 'Acc','Hybrid'}
	options.DefenseModes = {'Normal', 'PDT'}
	options.WeaponskillModes = {'Normal', 'Acc'}
	options.CastingModes = {'Off','Smite','Fury'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'HP'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	physical_Qaaxoleggings1 = {name="Qaaxo leggings",augments={"Attack +15", "Magic Attack Bonus +15", "Strength +12"}}
    physical_Qaaxoleggings2 = {name="Qaaxo leggings",augments={"Accuracy +15", "Strength +7","Physical Damage Taken -3%"}}

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	-- Additional local binds
	send_command('bind ^` gs c cycle casting')
	send_command('bind !` gs c set CastingMode Off')
			
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}

	sets.precast.JA['Boost'] = {hands="Anch. Gloves +1"}

	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}

	sets.precast.JA['Focus'] = {head="Anchor. Crown +1"}

	sets.precast.JA['Counterstance'] = {feet="Hesychast's gaiters +1"}

	sets.precast.JA['Chi Blast'] = {
		head="Melee Crown +2",
		body="Otronif Harness +1",hands="Otronif Gloves +1",
		back="Tuilha Cape",legs="Ighwa Trousers",feet="Thurandaut Boots +1"}

	sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}

	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +1"}

	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +2"}

	sets.precast.JA['Chakra'] = {ammo="Iron Gobbet",
		head="Lithelimb Cap",neck="Tjukurrpa Medal",
		body="Anch. Cyclas +1",hands="Hesychast's Gloves +1",ring1="Terrasoul Ring",ring2="Terrasoul Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Ighwa Trousers",feet="Thurandaut Boots +1"}
	
	sets.precast.Lunge = {
		head="Umbani Cap",neck="Stoicheion medal",ear1="Hecate's Earring",ear2="Friomisi Earring",
		ring1="Demon's Ring",ring2="Demon's Ring",
		back="Toro Cape",legs="Shneddick Tights +1",feet="Qaaxo Leggings"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Ighwa Trousers",feet="Thurandaut Boots +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",head="Haruspex hat",ear2="Loquacious Earring",hands="Thaumas Gloves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Tantra Tathlum",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Anchorite's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum",
		head="Whirlpool Mask",
		back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Victory Smite"]     = {ammo="Tantra Tathlum",
		head="Uk'uxkaj Cap",neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Anchorite's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Buquwik Cape",waist="Caudata Belt",legs="Qaaxo tights",feet="physical_Qaaxoleggings1"}  --- need ighwa trosers
	sets.precast.WS["Victory Smite"].Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Anch. Cyclas +1",hands="Anchorite's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Caudata Belt",legs="Qaaxo tights",feet="Qaaxo Leggings"}

	sets.precast.WS['Shijin Spiral']     = {ammo="Jukukik Feather",
		head="Felistris Mask",neck="Flame Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Anch. Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Flame Belt",legs="Manibozho Brais",feet="Daihanshi Habaki"}
	sets.precast.WS['Shijin Spiral'].Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Flame Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Anch. Cyclas +1",hands="Anch. Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Flame Belt",legs="Manibozho Brais",feet="Daihanshi Habaki"}

	sets.precast.WS['Asuran Fists']     = set_combine(sets.precast.WS, {neck="Soil Gorget",ring2="Spiral Ring"})
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {neck="Soil Gorget",ring2="Spiral Ring"})

	sets.precast.WS["Ascetic's Fury"]     = {ammo="Tantra Tathlum",
		head="Felistris Mask",neck="Light Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Anchorite's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Rancorous Mantle",waist="Light Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
	sets.precast.WS["Ascetic's Fury"].MidAcc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Light Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Rancorous Mantle",waist="Light Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
	sets.precast.WS["Ascetic's Fury"].Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Light Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Anch. Cyclas +1",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Light Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
		
	sets.precast.WS['Cataclysm'] = {
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt"}
		
	sets.precast.WS["Howling Fist"]     = {ammo="Jukukik feather",
		head="Uk'uxkaj Cap",neck="Tjukurrpa medal",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Hesychast's gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Buquwik Cape",waist="Caudata Belt",legs="Manibozho brais",feet="Daihanshi habaki"}	
	sets.precast.WS["Raging Fists"]     = {ammo="Jukukik feather",
		head="Uk'uxkaj Cap",neck="Tjukurrpa medal",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Hesychast's gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Buquwik Cape",waist="Caudata Belt",legs="Manibozho brais",feet="Daihanshi habaki"}	
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Lithelimb Cap",ear2="Loquacious Earring",
		body="Otronif Harness +1",hands="Thaumas Gloves",
		waist="Black Belt",feet="Otronif Boots +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {ammo="Impatiens",
		head="Lithelimb Cap",ear2="Loquacious Earring",
		body="Otronif Harness +1",hands="Thaumas Gloves",
		waist="Black Belt",legs="Ighwa Trousers",feet="Otronif Boots +1"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		body="Hesychast's Cylas +1",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {ammo="Iron Gobbet",
		head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ear1="Dawn earring",ear2="Brutal earring",
		body="Hesychast's cyclas +1",hands="Garden bangles",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow mantle",waist="Black Belt",legs="Otronif brais",feet="Hermes' sandals +1"}

	sets.idle.Town = {ammo="Iron gobbet",
		head="Ocelomeh Headpiece +1",neck="Wiglen gorget",ear1="Dawn earring",ear2="Brutal earring",
		body="Khepri jacket",hands="Garden bangles",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow mantle",waist="Black belt",legs="Otronif brais",feet="Hermes' sandals +1"}
	
	sets.idle.Weak = {ammo="Iron Gobbet",
		head="Lithelimb cap",neck="Inquisitor bead necklace",ear1="Cassie earring",ear2="Bloodgem Earring",
		body="Hesychast's cyclas +1",hands="Hesychast's gloves +1",ring1="K'ayres ring",ring2="Meridian Ring",
		back="Gigant mantle",waist="Black Belt",legs="Hesychast's hose +1",feet="Hesychast's gaiters +1"}
	
	-- Defense sets
	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Lithelimb Cap",neck="Twilight Torque",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Repulse Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	sets.defense.HP = {ammo="Iron Gobbet",
		head="Lithelimb cap",neck="Inquisitor bead necklace",ear1="Cassie earring",ear2="Bloodgem Earring",
		body="Hesychast's cyclas +1",hands="Hesychast's gloves +1",ring1="K'ayres ring",ring2="Meridian Ring",
		back="Gigant mantle",waist="Black Belt",legs="Hesychast's hose +1",feet="Hesychast's gaiters +1"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	sets.Kiting = {feet="Hermes' sandals +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee groups
	
	-- xxx Accuracy
	sets.engaged.Impetus = set_combine(sets.engaged, {body="Tantra Cyclas +2",feet="Anchorite's gaiters +1"}) --- remove after glan
	sets.engaged = {ammo="Ginsen",
		head="Usukane somen +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.AM3 = {ammo="Ginsen",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.AM3.Impetus = {ammo="Ginsen",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Cetl Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
		
	sets.engaged.Adoulin = {ammo="Ginsen",
		head="Usukane somen +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.Adoulin.AM3 = {ammo="Ginsen",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.Adoulin.AM3.Impetus = {ammo="Ginsen",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}

		
	-- xxx Accuracy
	sets.engaged.MidAcc = {ammo="Honed Tathlum",
		head="Felistris Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.MidAcc.AM3 = {ammo="Honed Tathlum",
		head="Felistris Mask",neck="Ej Necklace +1",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.MidAcc.AM3.Impetus = {ammo="Honed Tathlum",
		head="Felistris Mask",neck="Ej Necklace +1",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}

	sets.engaged.Adoulin.MidAcc = {ammo="Honed Tathlum",
		head="Felistris Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.Adoulin.MidAcc.AM3 = {ammo="Honed Tathlum",
		head="Felistris Mask",neck="Ej Necklace +1",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.Adoulin.MidAcc.AM3.Impetus = {ammo="Honed Tathlum",
		head="Felistris Mask",neck="Ej Necklace +1",ear1="Tripudio Earring",ear2="Brutal Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
		
	-- xxx Accuracy
	sets.engaged.Acc= {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Qaaxo mitaines",ring1="Enlivened ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan sash",legs="Qaaxo tights",feet="Qaaxo Leggings"}
	sets.engaged.Acc.AM3 = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
	sets.engaged.Acc.AM3.Impetus = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}

	sets.engaged.Adoulin.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
	sets.engaged.Adoulin.Acc.AM3 = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
	sets.engaged.Adoulin.Acc.AM3.Impetus = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
		
		sets.engaged.Hybird= {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Qaaxo mitaines",ring1="Enlivened ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan sash",legs="Qaaxo tights",feet="Qaaxo Leggings"}
	sets.engaged.Hybird.AM3 = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
	sets.engaged.Hybird.AM3.Impetus = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}

	sets.engaged.Adoulin.Hybird = {ammo="Honed Tathlum",
		head="Lithelimb cap",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Qaaxo mitaines",ring1="Enlivened ring",ring2="Defending ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Qaaxo tights",feet="Qaaxo Leggings"}
	sets.engaged.Adoulin.Hybird.AM3 = {ammo="Honed Tathlum",
		head="Lithelimb cap",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Qaaxo mitaines",ring1="Enlivened ring",ring2="Defending ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Qaaxo tights",feet="Qaaxo Leggings"}
	sets.engaged.Adoulin.Hybird.AM3.Impetus = {ammo="Honed Tathlum",
		head="Lithelimb cap",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Qaaxo mitaines",ring1="Enlivened ring",ring2="Defending ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Qaaxo tights",feet="Qaaxo Leggings"}	
		
		
		
	-- Defensive melee group
	
	sets.engaged.PDT = {ammo="Iron Gobbet",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Black Earring",ear2="Brutal Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.MidAcc.PDT = {ammo="Iron Gobbet",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Black Earring",ear2="Brutal Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Patricius Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Black Earring",ear2="Brutal Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Patricius Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
		
	sets.engaged.Adoulin.PDT = set_combine(sets.engaged.PDT)
	sets.engaged.Adoulin.MidAcc.PDT = set_combine(sets.engaged.MidAcc.PDT)
	sets.engaged.Adoulin.Acc.PDT = set_combine(sets.engaged.Acc.PDT)
		
	-- Footwork melee group
	sets.engaged.Footwork = {ammo="Ginsen",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Anchorite's Gaiters"}
	sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Anchorite's Gaiters"}

	-- Hundred Fists melee group
	
	sets.engaged.HF = {ammo="Ginsen",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Otronif Boots +1"}
	sets.engaged.HF.MidAcc = {ammo="Honed Tathlum",
		head="Felistris Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	sets.engaged.HF.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Mars's Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Ighwa Trousers",feet="Qaaxo Leggings"}
	
	sets.engaged.Acc = set_combine(sets.engaged.Acc, {feet="Qaaxo leggings"})  ----??
	sets.engaged.HF.AM3 = set_combine(sets.engaged.HF, {body="Tantra Cyclas +2"})
	sets.engaged.HF.MidAcc.AM3 = set_combine(sets.engaged.HF.MidAcc, {body="Tantra Cyclas +2"})
	sets.engaged.HF.Acc.AM3 = set_combine(sets.engaged.HF.Acc, {body="Tantra Cyclas +2"})	
	sets.engaged.Adoulin.HF = set_combine(sets.engaged.HF)
	sets.engaged.Adoulin.HF.MidAcc = set_combine(sets.engaged.HF.MidAcc)
	sets.engaged.Adoulin.HF.Acc = set_combine(sets.engaged.HF.Acc)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Don't gearswap for weaponskills when Defense is on.
	if spell.type:lower() == 'weaponskill' and state.Defense.Active then
		eventArgs.handled = true
	elseif spell.type == 'Waltz' then
		refine_waltz(spell, action, spellMap, eventArgs)
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' and not state.Defense.Active then
		if buffactive.impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
			equip({body="Tantra Cyclas +2"})
		elseif buffactive.footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
			equip({feet="Anchorite's Gaiters +1"})
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other game events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- Set Footwork as combat form any time it's active and Hundred Fists is not.
	if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
		state.CombatForm = 'Footwork'
	elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
		state.CombatForm = 'Footwork'
	elseif buff == "Ionis" and gain and areas.Adoulin:contains(world.area) then
		state.CombatForm = 'Adoulin'
	else
		state.CombatForm = nil
	end
	
	-- Hundred Fists and Impetus modify the custom melee groups
	if buff == "Hundred Fists" or buff == "Impetus" or buff == "Aftermath: Lv.3" then
		classes.CustomMeleeGroups:clear()
		
		if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
			classes.CustomMeleeGroups:append('HF')
		end
		
		if (buff == "Aftermath: Lv.3" and gain) or buffactive['aftermath: lv.3'] then
			classes.CustomMeleeGroups:append('AM3')
		end
		if (buff == "Impetus" and gain) or buffactive.impetus then
			classes.CustomMeleeGroups:append('Impetus')
		end
	end

	-- Update gear if any of the above changed
	if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" or buff == "Aftermath: Lv.3" or buff == "Ionis" then
		handle_equipping_gear(player.status)
	end
end


-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
	update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
	if buffactive.footwork and not buffactive['hundred fists'] then
		return 'Footwork'

	
	elseif areas.Adoulin:contains(world.area) and buffactive.ionis then
		return 'Adoulin'
	end
end

function update_melee_groups()
	classes.CustomMeleeGroups:clear()
	
	if buffactive['hundred fists'] then
		classes.CustomMeleeGroups:append('HF')
	end

	if buffactive['aftermath: lv.3'] then
		classes.CustomMeleeGroups:append('AM3')
	end
	
	if buffactive.impetus then
		classes.CustomMeleeGroups:append('Impetus')
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 1)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 1)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 1)
	else
		set_macro_page(4, 1)
	end
end

windower.register_event('tp change', function(tp)
	if not buffactive['amnesia'] then
		if state.CastingMode == 'Smite' then
			if player.equipment.main == 'Glanzfaust' then
				local player = windower.ffxi.get_player()
				if player and 100 <= tp and tp <= 300 and buffactive['Aftermath: Lv.3']  and player.status == 'Engaged' then
					windower.send_command('input /ws Victory Smite <t>')
				end
				local player = windower.ffxi.get_player()
				if player and tp == 300 and not buffactive['Aftermath: Lv.3']  and player.status == 'Engaged' then
					windower.send_command("input /ws Ascetic's Fury <t>")
				end
			else
				local player = windower.ffxi.get_player()
				if player and 100 <= tp and tp <= 300 and player.status == 'Engaged' then
					windower.send_command('input /ws Victory Smite <t>')
				end
			end
		end
		if state.CastingMode == 'Fury' then
			if player.equipment.main == 'Glanzfaust' then
				local player = windower.ffxi.get_player()
				if player and 100 <= tp and tp <= 300 and buffactive['Aftermath: Lv.3']  and player.status == 'Engaged' then
					windower.send_command("input /ws Ascetic's Fury <t>")
				end
				local player = windower.ffxi.get_player()
				if player and tp == 300 and not buffactive['Aftermath: Lv.3']  and player.status == 'Engaged' then
					windower.send_command("input /ws Ascetic's Fury <t>")
				end
			else
				local player = windower.ffxi.get_player()
				if player and 100 <= tp and tp <= 300 and player.status == 'Engaged' then
					windower.send_command("input /ws Ascetic's Fury <t>")
				end
			end
		end
	end
end)
