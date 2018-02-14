include('organizer-lib.lua')
include('spam_protection.lua')
include('common_commands.lua')

engagedTargets = T{}
in_combat = false
thMode = false
ignoreHaste = I{false,true}
low_dmg_ws = I{false,true}
th_ignore = T{'Gin', 'Albumen', 'Warder of Courage', 'Goes', 'Sweetwater Fly', 'Sweetwater Tiger', 'Sweetwater Leech', 'Sweetwater Beetle', 'Bhata', 'Ashva', 'Gaja', 'Ratha', 'Mantri', 'Schah', 'Teles'}


function get_sets()
    standardMode = "Standard"
	accMode = 'LowAcc'
	thMode = false
	thSetter = false
    use_auto_th = false
	PL = 'Nekachu'

    load_gear_file()
end

function precast(spell,action)
	if check_ready(spell) then
		if spell.type == 'WeaponSkill' then
			if spell.target.distance > 8 or player.tp < 1000 then
				cancel_spell()
				return
			end

			if sets['SATA'][spell.english] and (buffactive['Sneak Attack'] or buffactive['Trick Attack']) then
				equip(sets['SATA'][spell.english])
			elseif sets[spell.english] then
				equip(sets[spell.english])
			else
				equip(sets['WS'])
			end

            if player.tp > 2750 then
                if sets[spell.english]['Moonshade Replacement'] then
                    equip(sets[spell.english]['Moonshade Replacement'])
                else
                    equip(sets['Moonshade Replacement'])
                end
            end

            if low_dmg_ws:current() then
                windower.add_to_chat(050, '-------------------- LOW DAMAGE WS MODE IS ON --------------------')
                equip(sets['Naked Accuracy'])
            end


			windower.add_to_chat(050, '['..spell.name..'] '..spell.target.name..' <'..player.tp..'%>')
		elseif spell.english == 'Ranged' then
			equip(sets['snapshot'])
		elseif spell.type == 'Ninjutsu' then
			if spell.english == 'Utsusemi: Ichi' or spell.english == 'Utsusemi: Ni' then
				equip(sets['PreUtsuSet'])
			end
		elseif spell.type == "JobAbility" then
			if spell.english == 'Perfect Dodge' then
				equip(sets['PerfectDodge'])
			elseif sets[spell.english] ~= nil then
				equip(sets[spell.english])
			end
		elseif spell.english == "Spectral Jig" then
			send_command('cancel 71;')
		elseif spell.type == 'Trust' then
			equip(sets['Trust'])
		end

		spam_protection_on(spell)
	else
		cancel_spell()
	end
end
function midcast(spell,action)
    if spell.type == 'JobAbility' or spell.type == 'WeaponSkill' then
        return true
    end

    if spell.type == 'Ninjutsu' then
		if spell.english == 'Utsusemi: Ichi' then
			if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
				equip(sets['UtsuSet'])
				send_command('wait 1.5;cancel 66;cancel 446;cancel 445;cancel 444;')
			end
		elseif spell.english == 'Utsusemi: Ni' then
			equip(sets['UtsuSet'])
		elseif spell.type == 'Trust' then
			equip(sets['Trust'])
		end
	elseif spell.english == 'Ranged' then
		equip(sets['midshot'])
	end
end

function aftercast(spell,action)
	if spam_protection_off(spell) then
		handle_idle()
	end
end

function status_change(new,old)
	if new == 'Engaged' and not thMode then
		in_combat = true
        if use_auto_th then
    		target_info = windower.ffxi.get_mob_by_target('t')
    		if type(target_info) == 'table' and not th_ignore:contains(target_info.name) then
    			engagedTargets[target_info['id']] = 0
    			thMode = true
    			thSetter = true
    			handle_idle()
    			windower.add_to_chat(167,"TH for new Target on")
    		end
        end
	end
	handle_idle()
end

function buff_change(buff,gain_or_loss)
	if player.tp < 1000 and (buff == 'Sneak Attack' or buff == 'Trick Attack') then
		handle_idle()
	end
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
	if thMode then
		--windower.add_to_chat(028,"thmode is on")
		appendString = 'TH'
	else
		--windower.add_to_chat(028,"thmode is off")
		appendString = ''
	end

	equipSet = sets[accMode][standardMode..appendString]

	if player.status == 'Engaged' then
		if buffactive['Sneak Attack'] then
			equipSet = sets['SA'..appendString]
		elseif buffactive['Trick Attack'] then
			equipSet = sets['TA'..appendString]
		else
			if standardMode == 'Standard' then
                if ignoreHaste:current() or get_haste_amount() > 30 then
					equipSet = sets[accMode]['StandardMarch'..appendString]
				else
					equipSet = sets[accMode]['Standard'..appendString]
				end
			end
		end
	else
        equipSet = sets['Running']
		-- equipSet = sets['STP']
	end

	if buffactive['doom'] then
		equipSet = set_combine(equipSet, sets['doom'])
	end

	equip(equipSet)
end

function self_command(command)
	command = string.lower(command)
	if command == 'trigger2' or command == 'dt' then
		standardMode = 'DT'
		if thMode == true then
			windower.add_to_chat(167,"DT Mode [ON] + TH")
		else
			windower.add_to_chat(167,"DT Mode [ON]")
		end
		handle_idle()
	elseif command == 'trigger3' or command == 'standard' then
		standardMode = 'Standard'
		if thMode == true then
			windower.add_to_chat(167,"TP Mode [ON] + TH")
		else
			windower.add_to_chat(167,"TP Mode [ON]")
		end
		handle_idle()
	elseif command == 'trigger4' or command == 'th' then
		if thMode == true then
			thMode = false
			thSetter = false
			windower.add_to_chat(167,"TH Mode [OFF]")
		else
			thMode = true
			thSetter = false
			windower.add_to_chat(167,"TH Mode [ON]")
		end
		handle_idle()
	elseif command == 'acc' or command == 'trigger5' then
		if accMode == 'LowAcc' then
			accMode = 'MidAcc'
			windower.add_to_chat(167,"Accuracy [Mid]")
		elseif accMode == 'MidAcc' then
			accMode = 'HighAcc'
			windower.add_to_chat(167,"Accuracy [High]")
		else
			accMode = 'LowAcc'
			windower.add_to_chat(167,"Accuracy [Low]")
		end
		handle_idle()
	elseif command == 'idle' then
		handle_idle()
    elseif command == 'wsmode' or command == 'lowdmgws' then
        low_dmg_ws:next()
        windower.add_to_chat(167,"Low Damaged WS Mode: "..tostring(low_dmg_ws:current()))
        handle_idle()
	elseif command == 'dt' or command == 'knockback_dt' then
		equip(sets['DT'])
		windower.add_to_chat(167,"DT for TP on")
	elseif command == 'death_dt' then
		equip(sets['Death'])
		windower.add_to_chat(167,"DT for Death on")
	elseif command == 'dt_end' then
		handle_idle()
        windower.add_to_chat(167,"DT for TP ended")
    elseif command == 'ignorehaste' then
        ignoreHaste:next()
		windower.add_to_chat(167,"Ignoring Haste ["..tostring(ignoreHaste:current()).."]")
    elseif command == 'key_s' then
		send_command('send nekachu gs c castspell Stun t;')
	elseif command == 'sneak' then
        if player.sub_job == 'DNC' then
            send_command('input /ja "Spectral Jig" <me>;')
        else
            send_command('send nekachu gs c castspell sneak Miang;')
        end
	elseif command == 'invisible' then
		send_command('send nekachu gs c castspell invisible Miang;')
	elseif command == 'trigger5' then
		heal_me()
	elseif command == 'trigger6' then
		buff_me()
    elseif command == 'autoth' then
        if use_auto_th then
            use_auto_th = false
            windower.add_to_chat(167,"Auto TH [OFF]")
        else
            use_auto_th = true
            windower.add_to_chat(167,"Auto TH [ON]")
        end
	elseif execute_common_command(command) then
		--done
	end
end

windower.raw_register_event('target change',function (targetID)
	if use_auto_th and not thMode then
		local playerData = windower.ffxi.get_player()
		if type(playerData) == 'table' and playerData.status == 1 then
			target_info = windower.ffxi.get_mob_by_target('t')
			if type(target_info) == 'table' and not th_ignore:contains(target_info.name) then
				engagedTargets[target_info['id']] = 0
				thMode = true
				thSetter = true
				send_command('gs c idle')
				windower.add_to_chat(167,"TH for new Target on")
			end
		end
	end
end)


--Function to handle melee hits on a target, it counts per target and removes TH, if it was on, after 2 hits
windower.raw_register_event("action", function(act)
	if use_auto_th and thSetter and thMode then
		local playerData = windower.ffxi.get_player()
		if type(playerData) == 'table' and playerData.status == 1 then
			local target_info = windower.ffxi.get_mob_by_target('t')
			if type(target_info) == 'table' then
				if playerData['id'] == act['actor_id'] and act['param'] == 29793 then
					if engagedTargets[target_info['id']] ~= nil and engagedTargets[target_info['id']] > 0 then
						engagedTargets[target_info['id']] = 0
						if thMode == true and not th_ignore:contains(target_info.name) then
							thMode = false
							thSetter = false
							send_command('gs c idle')
							windower.add_to_chat(167,"TH for new Target off")
						end
					else
						if engagedTargets[target_info['id']] == nil then
							engagedTargets[target_info['id']] = 0
							thMode = true
							thSetter = true
							send_command('gs c idle')
							windower.add_to_chat(167,"TH for new Target on")
						else
							engagedTargets[target_info['id']] = engagedTargets[target_info['id']] + 1
						end
					end
				end
			end
		end
	end
end)