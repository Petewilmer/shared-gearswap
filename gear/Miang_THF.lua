-- send_command('input /macro book 17;')

organizer_items = {
    remedy="Remedy",
    food="Rabbit Pie",
    food2="Sublime Sushi",
    food3="Red Curry Bun",
    shijo2="Shijo",
    blunt="Mafic Cudgel",
    sari="Twashtar",
    kartika="Kartika",
}
sets['HighAcc'] = T{}
sets['MidAcc'] = T{}
sets['LowAcc'] = T{}
sets['GearCollector'] = {main="Vajra",}

sets['GearCollector2'] = {main="Mandau"}

sets['doom'] = {
    left_ring="Purity Ring",
    right_ring="Saida Ring",
    waist="Gishdubar Sash",
}

sets['STP'] = {
    ammo="Yamarang",
    head="Turms Cap",
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+25 Attack+25','"Store TP"+6','DEX+4','Accuracy+7','Attack+2',}},
    feet="Jute Boots +1",
    neck="Ainia Collar",
    waist="Patentia Sash",
    left_ear="Telos Earring",
    right_ear="Dedition Earring",
    left_ring="Rajas Ring",
    right_ring="K'ayres Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
}

sets['doom'] = {ring1="Purity Ring",ring2="Saida Ring"}

sets['Archaic Rampart'] = {main="Bronze Dagger", sub="Bronze Dagger"}
sets['Salvage Weapons'] = {main="Twashtar", sub="Shijo"}

--Standard Gear
sets['LowAcc']['Standard'] = {
    ammo="Yamarang",
    head="Taeon Chapeau",
    neck="Anu Torque",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    body="Pillager's Vest +3",
    hands="Floral Gauntlets",
    ring1="Epona's Ring",
    ring2="Hetairoi Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}},
    waist="Reiki Yotai",
    legs="Pill. Culottes +3",
    feet="Taeon Boots"
}

--Standard gear with march+haste on
sets['LowAcc']['StandardMarch'] = {
    ammo="Yamarang",
    head="Adhemar Bonnet +1",
    neck="Anu Torque",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    body="Pillager's Vest +3",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    ring1="Epona's Ring",
    ring2="Hetairoi Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
    waist="Reiki Yotai",
    legs="Pill. Culottes +3",
    feet="Plun. Poulaines +1",
}

--Standard Gear
sets['MidAcc']['Standard'] = {
    ammo="Yamarang",
    head="Taeon Chapeau",
    neck="Combatant's Torque",
    left_ear="Heartseeker Earring",
    right_ear="Dudgeon Earring",
    body="Adhemar Jacket +1",
    hands="Floral Gauntlets",
    ring1="Epona's Ring",
    ring2="Hetairoi Ring",
    back="Canny Cape",
    waist="Patentia Sash",
    legs="Pill. Culottes +3",
    feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+4',}}
}

sets['MidAcc']['StandardMarch'] = {
    ammo="Yamarang",
    head="Adhemar Bonnet +1",
    neck="Combatant's Torque",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    body="Pillager's Vest +3",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    ring1="Epona's Ring",
    ring2="Hetairoi Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
    waist="Reiki Yotai",
    legs="Pill. Culottes +3",
    feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+4',}}
}
--Standard High Acc Gear
sets['HighAcc']['Standard'] = {
    ammo="Yamarang",
    head="Adhemar Bonnet +1",
    body="Adhemar Jacket +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Pill. Culottes +3",
    feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+4',}},
    neck="Combatant's Torque",
    waist="Reiki Yotai",
    left_ear="Zennaroi Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
}

sets['HighAcc']['StandardMarch'] = {
    ammo="Yamarang",
    head="Adhemar Bonnet +1",
    body="Pillager's Vest +3",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Pill. Culottes +3",
    feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+4',}},
    neck="Combatant's Torque",
    waist="Reiki Yotai",
    left_ear="Zennaroi Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
}
sets['Encumbrance'] = set_combine(sets['HighAcc']['StandardMarch'], {
    main="Vajra",
    sub="Twashtar",
})

sets['LowAcc']['StandardTH'] = set_combine(sets['LowAcc']['Standard'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})
sets['LowAcc']['StandardMarchTH'] = set_combine(sets['LowAcc']['StandardMarch'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})
sets['MidAcc']['StandardTH'] = set_combine(sets['MidAcc']['Standard'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})
sets['MidAcc']['StandardMarchTH'] = set_combine(sets['MidAcc']['StandardMarch'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})
sets['HighAcc']['StandardTH'] = set_combine(sets['HighAcc']['Standard'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})
sets['HighAcc']['StandardMarchTH'] = set_combine(sets['HighAcc']['StandardMarch'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})

--DT gear
sets['LowAcc']['DT'] = {
    ammo="Staunch Tathlum +1",
    head={ name="Herculean Helm", augments={'Accuracy+30','Damage taken-3%','Attack+6',}},
    neck="Loricate Torque +1",
    left_ear="Etiolation Earring",
    right_ear="Sanare Earring",
    body="Ashera Harness",
    hands={ name="Herculean Gloves", augments={'Damage taken-4%','Accuracy+15',}},
    ring1="Defending Ring",
    ring2="Moonlight Ring",
    back="Moonlight Cape",
    waist="Reiki Yotai",
    legs="Mummu Kecks +2",
    feet={ name="Herculean Boots", augments={'Attack+25','Damage taken-3%','STR+4','Accuracy+5',}},
}

sets['LowAcc']['DTTH'] =    set_combine(sets['LowAcc']['DT'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})

sets['MidAcc']['DT'] = set_combine(sets['LowAcc']['DT'], {
})
sets['MidAcc']['DTTH'] =    set_combine(sets['MidAcc']['DT'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})

sets['HighAcc']['DT'] = set_combine(sets['MidAcc']['DT'], {
})

sets['HighAcc']['DTTH'] =   set_combine(sets['HighAcc']['DT'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})

sets['Curing Waltz'] = set_combine(sets['LowAcc']['DT'], {
    head="Mummu Bonnet +2",
    body="Passion Jacket",
})

--Precast ranged attacks
sets['Snapshot'] =          set_combine(sets['HighAcc']['Standard'], {
    feet="Meg. Jam. +2",
})
--Midcast ranged attacks
sets['midshot'] =           sets['HighAcc']['Standard']

--Used with events.lua for death DT handling
sets['Death'] =             set_combine(sets['LowAcc']['DT'], {
    ring1="Shadow Ring",
    ring2="Eihwaz Ring",
})

--SA
sets['SA'] = {
    head="Pill. Bonnet +3",
    neck="Caro Necklace",
    left_ear="Heartseeker Earring",
    right_ear="Dudgeon Earring",
    body="Meg. Cuirie +2",
    hands="Skulk. Armlets +1",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
    waist="Cetl Belt",
    legs="Lustr. Subligar +1",
    feet="Pill. Poulaines +1",
}

--SA with TH on
sets['SATH'] = set_combine(sets['SA'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})

--TA
sets['TA'] = {
    head="Pill. Bonnet +3",
    neck="Moepapa Medal",
    left_ear="Heartseeker Earring",
    right_ear="Dudgeon Earring",
    body="Meg. Cuirie +2",
    hands="Pill. Armlets +3",
    ring1="Garuda Ring +1",
    ring2="Garuda Ring +1",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
    waist="Windbuffet Belt +1",
    legs="Pill. Culottes +3",
    feet="Pill. Poulaines +1",
}

--TA with TH on
sets['TATH'] = set_combine(sets['TA'], {
    hands="Plun. Armlets +1",
    feet="Skulk. Poulaines +1",
})

sets['Steal'] = {
    neck="Pentalagus Charm",
    hands="Pill. Armlets +3",
    legs="Pill. Culottes +3",
    feet="Pill. Poulaines +1",
}

sets['Mug'] = set_combine(sets['SA'], {})

sets['Despoil'] = set_combine(sets['Steal'], {
    feet="Skulk. Poulaines +1",
})

sets['Accomplice'] = {head="Skulker's Bonnet +1",}
sets['Collaborator'] = {head="Skulker's Bonnet +1",}

sets['Flee'] = set_combine(sets['LowAcc']['DT'], {feet="Pill. Poulaines +1",})

sets['Running'] = set_combine(sets['LowAcc']['DT'], {
    head="Turms Cap",
    feet="Jute Boots +1",
})

sets['SATA'] = T{}

sets['WS'] = {
    ammo="Jukukik Feather",
    head="Pill. Bonnet +3",
    body={ name="Herculean Vest", augments={'Accuracy+25','Weapon skill damage +5%','DEX+6','Attack+1',}},
    hands="Meg. Gloves +2",
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Fotia Gorget",
    waist="Metalsinger Belt",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Ifrit Ring +1",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}

sets['Moonshade Replacement'] = {
    left_ear = "Mache Earring +1",
}

sets['Evisceration'] = set_combine(sets['WS'], {
    ammo="Yetshila +1",
    head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands="Pill. Armlets +3",
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Mache Earring +1",
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
})
sets['Evisceration']['Moonshade Replacement'] = {
    left_ear = "Sherida Earring",
}

--SA or TA or SATA version of evis
sets['SATA']['Evisceration'] = set_combine(sets['Evisceration'], {
})

sets['Exenterator'] = set_combine(sets['WS'], {
    ring1="Garuda Ring +1",
    ring2="Garuda Ring +1",
    waist="Fotia Belt",
})

sets["Rudra's Storm"] = {
    ammo="Jukukik Feather",
    head="Pill. Bonnet +3",
    neck="Caro Necklace",
    left_ear = "Moonshade Earring",
    right_ear = "Sherida Earring",
    body={ name="Herculean Vest", augments={'Accuracy+25','Weapon skill damage +5%','DEX+6','Attack+1',}},
    hands="Meg. Gloves +2",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
    waist="Chiner's Belt +1",
    legs="Lustr. Subligar +1",
    feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
}

--SA or TA or SATA version of Rudra's Storm
sets['SATA']["Rudra's Storm"] = set_combine(sets["Rudra's Storm"], {
    ammo="Yetshila +1",
    body="Pillager's Vest +3",
})

sets["Mandalic Stab"] = set_combine(sets["Rudra's Storm"],{
    neck="Fotia Gorget"
})

sets['SATA']["Mandalic Stab"] = set_combine(sets["Rudra's Storm"],{
    ammo="Yetshila +1",
    body="Pillager's Vest +3",
    neck="Fotia Gorget"
})

sets["Mercy Stroke"] =  set_combine(sets['WS'], {
})

sets['UtsuSet'] = {
    ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Accuracy+30','Damage taken-3%','Attack+6',}},
    body="Samnuha Coat",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Limbo Trousers",
    feet={ name="Iuitl Gaiters +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Accuracy+7',}},
    neck="Magoraga Beads",
    waist="Flume Belt +1",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Weather. Ring",
    right_ring="Prolix Ring",
    back="Moonlight Cape",
}

sets['PreUtsuSet'] =    {
    ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Accuracy+30','Damage taken-3%','Attack+6',}},
    body="Adhemar Jacket",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Limbo Trousers",
    feet={ name="Iuitl Gaiters +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Accuracy+7',}},
    neck="Magoraga Beads",
    waist="Flume Belt +1",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Weather. Ring",
    right_ring="Prolix Ring",
    back="Moonlight Cape",
}

sets['Aeolian Edge'] = {
    ammo="Pemphredo Tathlum",
    head={ name="Herculean Helm", augments={'Pet: Phys. dmg. taken -3%','Magic Damage +15','Accuracy+2 Attack+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
    body="Samnuha Coat",
    hands={ name="Herculean Gloves", augments={'Attack+13','Weapon skill damage +5%','DEX+8','Accuracy+5',}},
    legs="Limbo Trousers",
    feet={ name="Herculean Boots", augments={'Accuracy+26','Weapon skill damage +5%','DEX+1','Attack+14',}},
    neck="Sanctity Necklace",
    waist="Fotia Belt",
    left_ear="Crematio Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}

sets['Sanguine Blade'] = set_combine(sets['Aeolian Edge'], {
})

sets['PerfectDodge'] = set_combine(sets['LowAcc']['DT'], {
    hands="Plun. Armlets +1",
})

sets['Violent Flourish'] = {
    ammo="Yamarang",
    head="Mummu Bonnet +2",
    body="Mummu Jacket +1",
    hands="Mummu Wrists +1",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +1",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Gwati Earring",
    left_ring="Weather. Ring",
    right_ring="Stikini Ring",
    back="Moonlight Cape",
}

sets['Trust'] = set_combine(sets['PreUtsuSet'], {})

sets['Naked'] =        {
        ammo=empty,
        head=empty,
        body=empty,
        hands=empty,
        legs=empty,
        feet=empty,
        neck=empty,
        waist=empty,
        left_ear=empty,
        right_ear=empty,
        left_ring=empty,
        right_ring=empty,
        back=empty,
    }

sets['Naked Accuracy'] =        {
        ammo="Staunch Tathlum +1",
        head=empty,
        body=empty,
        hands=empty,
        legs=empty,
        feet=empty,
        neck="Loricate Torque +1",
        waist="Reiki Yotai",
        left_ear="Genmei Earring",
        right_ear="Digni. Earring",
        left_ring="Defending Ring",
        right_ring="Moonlight Ring",
        back="Moonlight Cape",
    }