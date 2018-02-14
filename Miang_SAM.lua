include('organizer-lib.lua')
include('spam_protection.lua')
include('common_commands.lua')

autoWS = I{true, false}
autoWSToUse = I{'Tachi: Fudo'}

tpMode = I{'Standard', 'Hybrid', 'DT'}
accMode = I{'LowAcc','HighAcc'}
weapons = I{'Masamune', 'Kogarasumaru', 'Dojikiri Yasutsuna'}
low_dmg_ws = I{false,true}

lasttp = -1

function get_sets()
	idleMode = "Running"
	PL = 'Nekachu'

	load_gear_file()
end

function pretarget(spell)
    if check_ready(spell) == false then
        cancel_spell()
    end

    if spell.type == 'WeaponSkill' and player.tp < 1000 then
        cancel_spell()
    end

    if spell.english == 'Sneak' and spell.target.name == player.name and player.sub_job == 'DNC' and is_ability_ready('Spectral Jig') then
        cancel_spell()
        windower.send_command('input /ja "Spectral Jig" <me>;')
    end
end

function precast(spell,action)
	if check_ready(spell) then
		if spell.type == 'WeaponSkill' then
			if spell.target.distance > 10 and spell.english ~= 'Apex Arrow' then
				cancel_spell()
				return
			end

			if sets[accMode:current()][spell.english] then
				equipSet = sets[accMode:current()][spell.english]
			else
				equipSet = sets[accMode:current()]['WSSet']
			end

			if buffactive['Meikyo Shisui'] then
				equipSet = set_combine(equipSet, sets['WeaponSkill']['Meikyo Shisui'])
			end

			if (wsProperty[spell.skillchain_a] ~= nil and wsProperty[spell.skillchain_a]:contains(world.day_element)) or (wsProperty[spell.skillchain_b] ~= nil and wsProperty[spell.skillchain_b]:contains(world.day_element)) or (wsProperty[spell.skillchain_c] ~= nil and wsProperty[spell.skillchain_c]:contains(world.day_element)) then
				equipSet = set_combine(equipSet, sets['WeaponSkill']['Day Aligned'])
			end

			if buffactive['Sekkanoki'] then
				equipSet = set_combine(equipSet, sets['WeaponSkill']['Sekkanoki'])
			end

            if player.tp > 2900 then
                equipSet = set_combine(equipSet, sets[accMode:current()]['Moonshade Replacement'])
            end

            if world.time >= 1020 or world.time < 420 then
                equipSet = set_combine(equipSet, sets['WeaponSkill']['NightTime'] )
            end

            if low_dmg_ws:current() then
                windower.add_to_chat(050, '-------------------- LOW DAMAGE WS MODE IS ON --------------------')
                equipSet = set_combine(equipSet, sets['Naked Accuracy'])
            end

            -- equipSet = set_combine(equipSet, sets['Yoichinoyumi'])

			equip(equipSet)

			windower.add_to_chat(050, '['..spell.name..'] '..spell.target.name..' <'..player.tp..'%>')
		elseif spell.type == 'JobAbility' then
			if sets[spell.english] then
                equip(sets[spell.english])
				-- equip(sets['Yoichinoyumi'])
			end
		elseif spell.type == 'Ninjutsu' then
			if buffactive['hasso'] or buffactive['seigan'] then
				send_command('wait 0.1;cancel 353;cancel 354;')
			end
			equip(sets['Precast']['UtsuSet'])
            -- equip(sets['Yoichinoyumi'])
		elseif spell.type == 'Trust' then
			equip(sets['Trust'])
            -- equip(sets['Yoichinoyumi'])
        elseif spell.cast_time ~= nil then
            equip(sets['Precast'])
            -- equip(sets['Yoichinoyumi'])
		end

		spam_protection_on(spell)
	else
		cancel_spell()
	end
end

function midcast(spell,action)
	if spell.type == 'Ninjutsu' then
		if spell.english == 'Utsusemi: Ichi' then
			if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
				equip(sets['UtsuSet'])
                -- equip(sets['Yoichinoyumi'])
				send_command('cancel 66;cancel 446;cancel 445;cancel 444;')
			end
		elseif spell.english == 'Utsusemi: Ni' then
			equip(sets['Midcast']['UtsuSet'])
            -- equip(sets['Yoichinoyumi'])
		end
	elseif spell.type == 'Trust' then
		equip(sets['Trust'])
        -- equip(sets['Yoichinoyumi'])
    elseif spell.cast_time ~= nil then
        equip(sets['Midcast'])
        -- equip(sets['Yoichinoyumi'])
	end
end

function aftercast(spell,action)
	if spam_protection_off(spell)then
		handle_idle()
	end
	--checkAftercast(spell)
end

function status_change(new,old)
    -- if old == 'Engaged' then
    --     windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
    -- end
	if check_ready_status()then
		handle_idle()
	end
end

function buff_change(buff,gain_or_loss)
	if gain_or_loss then
		if buff == 'Aftermath: Lv.3' then
			send_command('timers c "AM3" 180 up "Aftermath"')
		elseif buff == 'Aftermath: Lv.2' then
			send_command('timers c "AM2" 180 up "Aftermath"')
		elseif buff == 'Aftermath: Lv.1' then
			send_command('timers c "AM1" 180 up "Aftermath"')
		end

		if buff == 'doom' then
			send_command('input /p doomed')
			equip(sets['doom'])
		end

		if buff == 'weakness' then
			send_command('timers c "Weakness" 300 up "Weakness"')
		end
	else
		if buff == 'Aftermath: Lv.3' then
			send_command('timers d "AM3"')
		elseif buff == 'Aftermath: Lv.2' then
			send_command('timers d "AM2"')
		elseif buff == 'Aftermath: Lv.1' then
			send_command('timers d "AM1"')
		elseif buff == 'encumbrance' then
			windower.send_command('gs c dt_end;')
		end

		if buff == 'weakness' then
			send_command('timers d "Weakness"')
		end
	end
end

function handle_idle()
	equipSet = sets[accMode:current()][tpMode:current()]
	if player.status == 'Engaged' then
		if accMode:current() == 'LowAcc' and player.mp < 100 then
			equipSet = set_combine(equipSet, {ring2="K'ayres Ring"})
		end
	else
	    equipSet = sets[accMode:current()][idleMode]
	end

	if buffactive['doom'] then
		equipSet = set_combine(equipSet,sets['doom'])
	end

    if player.equipment.main == 'empty' or player.equipment.sub == 'empty' then
        equipSet = set_combine(equipSet, sets[weapons:current()])
    end

    -- equipSet = set_combine(equipSet, sets['Yoichinoyumi'])

	equip(equipSet)
end

function self_command(command)
	if command == 'checktwilight' then
		if player.equipment.head == 'Twilight Helm' and player.equipment.body == 'Twilight Mail' then
			disable('head','body')
		else
			enable('head','body')
			equip({head="Twilight Helm",body="Twilight Mail"})
			send_command('wait 0.2;gs c checktwilight;')
		end
	elseif command == 'trigger1' then
        tpMode:setTo('DT')
		idleMode = "DT"
		windower.add_to_chat(167,"Mode [DT + "..accMode:current().."]")
		handle_idle()
	elseif command == 'trigger2' then
        tpMode:setTo('Hybrid')
        idleMode = 'Running'
        windower.add_to_chat(167,"Mode [Hybrid + "..accMode:current().."]")
        handle_idle()
    elseif command == 'trigger3' then
        tpMode:setTo('Standard')
		idleMode = 'Running'
        windower.add_to_chat(167,"Mode [Standard + "..accMode:current().."]")
		handle_idle()
	elseif command == 'trigger4' then
        accMode:next()
        windower.add_to_chat(167,"Acc Mode ["..accMode:current().."]")
		handle_idle()
    elseif command == 'trigger5' then
        tpMode:next()
        idleMode = "Running"
        if tpMode:current() == 'DT' then
            idleMode = "DT"
        end
        windower.add_to_chat(167,"Mode ["..tpMode:current().." "..accMode:current().."]")
        handle_idle()
    elseif command == 'weapon' then
        weapons:next()
        windower.add_to_chat(167,"Using "..weapons:current())
        handle_idle()
    elseif command == 'wsmode' or command == 'lowdmgws' then
        low_dmg_ws:next()
        windower.add_to_chat(167,"Low Damaged WS Mode: "..tostring(low_dmg_ws:current()))
        handle_idle()
	elseif command == 'dt' or command == 'mdt' then
		equip(sets[accMode:current()]['DT'])
		windower.add_to_chat(167,"DT for TP on")
	elseif command == 'death_dt' then
		equip(sets['Death'])
		windower.add_to_chat(167,"DT for Death on")
	elseif command == 'dt_end' then
		handle_idle()
		windower.add_to_chat(167,"DT for TP end")
	elseif command == 'sneak' then
		send_command('send nekachu //sneak Miang;')
	elseif command == 'invisible' then
		send_command('send nekachu //invisible Miang;')
	elseif command == 'request_songs' then
		send_command('send mazuki gs c sing min march march min Miang;')
    elseif execute_common_command(command) then
	end
end
