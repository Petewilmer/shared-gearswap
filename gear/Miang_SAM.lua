-- send_command('input /macro book 3;')

organizer_items = {
    food="Sublime Sushi",
    food2="Sublime Sushi +1",
    food3="Sole Sushi",
    food4="Red Curry Bun",
    wring="Warp Ring",
    yoichi="Yoichinoyumi",
    ammo1="Eminent Quiver",
}


sets['doom'] = {
    left_ring="Purity Ring",
    right_ring="Saida Ring",
    waist="Gishdubar Sash",
}

sets['Gear Collector'] = {main="Perfervid Sword",head = "Twilight Helm", body="Twilight Mail"}

sets['WeaponSkill'] = {}

sets['WeaponSkill']['Day Aligned'] = {
}

sets['WeaponSkill']['NightTime'] = {
    left_ear="Lugra Earring",
    right_ear="Lugra Earring +1",
}
sets['WeaponSkill']['Sekkanoki'] = {
}
sets['WeaponSkill']['Meikyo Shisui'] = {
    feet="Sak. Sune-Ate +1",
}

sets['Yoichinoyumi'] = {
    range="Yoichinoyumi",
    ammo="Eminent Arrow",
}

sets['Kogarasumaru'] = {
    main={name="Kogarasumaru",priority=2},
    sub={name="Utu Grip",priority=1},
}
sets['Dojikiri Yasutsuna'] = {
    main={name="Dojikiri Yasutsuna",priority=2},
    sub={name="Utu Grip",priority=1},
}
sets['Masamune'] = {
    main={name="Masamune",priority=2},
    sub={name="Utu Grip",priority=1},
}
sets['Amanomurakumo'] = {
    main={name="Amanomurakumo",priority=2},
    sub={name="Utu Grip",priority=1},
}

sets['HighAcc'] = T{}
sets['LowAcc'] = T{}

sets['Sekkanoki'] = {}

sets['LowAcc']['Standard'] = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'Accuracy+9','Mag. Acc.+1 "Mag.Atk.Bns."+1','Quadruple Attack +3','Accuracy+15 Attack+15',}},
    hands="Wakido Kote +3",
    legs="Ryuo Hakama +1",
    feet={ name="Valorous Greaves", augments={'Pet: INT+2','Pet: STR+4','Quadruple Attack +3','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck="Ganesha's Mala",
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Hetairoi Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}
sets['HighAcc']['Standard'] = set_combine(sets['LowAcc']['Standard'], {
    ammo="Ginsen",
    ear1="Zennaroi Earring",
    ear2="Telos Earring",
    body="Ryuo Domaru +1",
    hands="Wakido Kote +3",
    left_ring="Niqmaddu Ring",
    right_ring="Ilabrat Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
    waist="Olseni Belt",
    legs={ name="Valor. Hose", augments={'Accuracy+30','"Dbl.Atk."+4','Attack+8',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+22 Attack+22','DEX+9','Accuracy+13',}},
})

sets['LowAcc']['Hybrid'] = {
    ammo="Staunch Tathlum +1",
    head={ name="Valorous Mask", augments={'Attack+12','Damage taken-4%','AGI+4','Accuracy+13',}},
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','Damage taken-3%','STR+9','Accuracy+7','Attack+8',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+30','Damage taken-3%','VIT+3',}},
    neck="Loricate Torque +1",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -6%','Breath dmg. taken -4%','Magic dmg. taken -5%',}},
    back="Moonlight Cape",
}
sets['HighAcc']['Hybrid'] = set_combine(sets['LowAcc']['Hybrid'], {
    left_ear="Mache Earring +1",
})

sets['LowAcc']['DT'] = {
    ammo="Staunch Tathlum +1",
    head={ name="Valorous Mask", augments={'Attack+12','Damage taken-4%','AGI+4','Accuracy+13',}},
    body="Wakido Domaru +3",
    hands={ name="Valorous Mitts", augments={'Accuracy+20 Attack+20','Damage taken-3%','STR+3','Accuracy+11',}},
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','Damage taken-3%','STR+9','Accuracy+7','Attack+8',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+30','Damage taken-3%','VIT+3',}},
    neck="Loricate Torque +1",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back="Moonlight Cape",
}
sets['HighAcc']['DT'] = set_combine(sets['LowAcc']['DT'], {
    left_ear="Mache Earring +1",
})

sets['Death'] = {ring1="Shadow Ring", ring2="Eihwaz Ring"}

sets['HighAcc']['WSSet'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +5%','DEX+8','Accuracy+13','Attack+14',}},
    body={ name="Valorous Mail", augments={'Weapon skill damage +5%','STR+7','Accuracy+6',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +4%','STR+10','Accuracy+15','Attack+5',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','STR+10','Accuracy+6','Attack+13',}},
    neck="Moonbeam Nodowa",
    waist="Prosilio Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    right_ear="Ishvara Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets['LowAcc']['WSSet'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +5%','DEX+8','Accuracy+13','Attack+14',}},
    hands={ name="Valorous Mitts", augments={'Magic dmg. taken -1%','STR+9','Weapon skill damage +6%',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +4%','STR+10','Accuracy+15','Attack+5',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','STR+10','Accuracy+6','Attack+13',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    right_ear="Ishvara Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets['HighAcc']['Moonshade Replacement'] = {
    left_ear="Vulcan's Pearl",
}
sets['LowAcc']['Moonshade Replacement'] = {
    left_ear="Vulcan's Pearl",
}

sets['HighAcc']['Tachi: Ageha'] = set_combine(sets['HighAcc']['WSSet'], {
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +1",
    hands="Flam. Manopolas +1",
    legs="Flamma Dirs +1",
    feet="Flam. Gambieras +1"
})
sets['LowAcc']['Tachi: Ageha'] = set_combine(sets['LowAcc']['WSSet'], {
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +1",
    hands="Flam. Manopolas +1",
    legs="Flamma Dirs +1",
    feet="Flam. Gambieras +1"
})

sets['HighAcc']['Tachi: Gekko'] = sets['HighAcc']['WSSet']
sets['LowAcc']['Tachi: Gekko'] = sets['LowAcc']['WSSet']

sets['HighAcc']['Tachi: Yukikaze'] = sets['HighAcc']['Tachi: Gekko']
sets['LowAcc']['Tachi: Yukikaze'] = sets['LowAcc']['Tachi: Gekko']

sets['HighAcc']['Tachi: Kasha'] = sets['HighAcc']['Tachi: Gekko']
sets['LowAcc']['Tachi: Kasha'] = sets['LowAcc']['Tachi: Gekko']

sets['HighAcc']['Tachi: Kaiten'] = sets['HighAcc']['Tachi: Gekko']
sets['LowAcc']['Tachi: Kaiten'] = sets['LowAcc']['Tachi: Gekko']

sets['HighAcc']['Tachi: Rana'] = set_combine(sets['HighAcc']['Tachi: Gekko'], {
    ear1="Trux Earring",
    body={ name="Valorous Mail", augments={'Weapon skill damage +5%','STR+7','Accuracy+6',}},
})
sets['LowAcc']['Tachi: Rana'] = set_combine(sets['LowAcc']['Tachi: Gekko'], {
    ear1="Trux Earring",
    body={ name="Valorous Mail", augments={'Weapon skill damage +5%','STR+7','Accuracy+6',}},
})

sets['HighAcc']['Tachi: Fudo'] = set_combine(sets['HighAcc']['WSSet'], {
    neck="Fotia Gorget",
    body={ name="Valorous Mail", augments={'Weapon skill damage +5%','STR+7','Accuracy+6',}},
    waist="Fotia Belt"
})
sets['LowAcc']['Tachi: Fudo'] = set_combine(sets['LowAcc']['WSSet'], {
    neck="Fotia Gorget",
    waist="Fotia Belt"
})

sets['HighAcc']['Requiescat'] = set_combine(sets['HighAcc']['WSSet'],
    {neck="Fotia Gorget",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    waist="Fotia Belt"
})
sets['LowAcc']['Requiescat'] = set_combine(sets['LowAcc']['WSSet'],
    {neck="Fotia Gorget",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    waist="Fotia Belt"
})

sets['HighAcc']['Tachi: Shoha'] = set_combine(sets['HighAcc']['WSSet'], {
    neck="Fotia Gorget",
    waist="Fotia Belt",
})
sets['LowAcc']['Tachi: Shoha'] = set_combine(sets['LowAcc']['WSSet'], {
    neck="Fotia Gorget",
    waist="Fotia Belt",
})

sets['HighAcc']['Apex Arrow'] = set_combine(sets['HighAcc']['WSSet'], {
    head="Sakonji Kabuto +1",
    neck="Fotia Gorget",
    ear2="Vulcan's Pearl",
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +4%','STR+10','Accuracy+15','Attack+5',}},
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    waist="Fotia Belt",
})
sets['LowAcc']['Apex Arrow'] = sets['HighAcc']['Apex Arrow']

sets['LowAcc']['Running'] = set_combine(sets['LowAcc']['DT'], {
    feet="Danzo Sune-Ate"
})
sets['HighAcc']['Running'] = set_combine(sets['HighAcc']['DT'], {
    feet="Danzo Sune-Ate"
})

sets['Warding Circle'] = {
    head="Wakido Kabuto +3"
}

sets['Meikyo Shisui'] = set_combine(sets['HighAcc']['DT'], {
    feet="Sak. Sune-Ate +1"
})

sets['Meditate'] = {
    head="Wakido Kabuto +3",
    hands="Sakonji Kote +1",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}

sets['Town'] = set_combine(sets['HighAcc']['DT'], {})
--sets['Town'] = set_combine(sets['HighAcc']['DT'], {head="Shaded Specs.",body="Councilor's Garb",hands="Councilor's Cuffs",legs={ name="Acro Breeches", augments={'Accuracy+20 Attack+20','Weapon Skill Acc.+20','STR+10',}},feet="Sak. Sune-Ate +1"})

sets['Trust'] = sets['HighAcc']['Standard']

sets['Precast'] = {}
sets['Midcast'] = {}

sets['Precast']['General'] = set_combine(sets['HighAcc']['DT'], {
    ammo="Sapience Orb",
    neck="Orunmila's Torque",
    ear1="Enchntr. Earring +1",
    ear2="Loquac. Earring",
    hands="Leyline Gloves",
    legs="Limbo Trousers",
    ring1="Prolix Ring",
    ring2="Weather. Ring",
})
sets['Midcast']['General'] = set_combine(sets['Precast']['General'], {})

sets['Precast']['UtsuSet'] = set_combine(sets['Precast']['General'], {})
sets['Midcast']['UtsuSet'] = set_combine(sets['Precast']['UtsuSet'], {})


sets['Naked Accuracy'] =        {
        ammo="Staunch Tathlum +1",
        head=empty,
        body=empty,
        hands=empty,
        legs=empty,
        feet=empty,
        neck="Loricate Torque +1",
        waist="Olseni Belt",
        left_ear="Genmei Earring",
        right_ear="Digni. Earring",
        left_ring="Defending Ring",
        back="Moonlight Cape",
    }

sets['HighAcc']['Namas Arrow'] = set_combine(sets['HighAcc']['WSSet'], {
})
sets['LowAcc']['Namas Arrow'] = set_combine(sets['LowAcc']['WSSet'], {
    head={ name="Valorous Mask", augments={'Weapon skill damage +5%','DEX+8','Accuracy+13','Attack+14',}},
    body={ name="Valorous Mail", augments={'Weapon skill damage +5%','STR+7','Accuracy+6',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +4%','STR+10','Accuracy+15','Attack+5',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','STR+10','Accuracy+6','Attack+13',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Vulcan's Pearl",
    right_ear="Ishvara Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
})
