exclusion_zones = T{0,14,26,32,43,44,48,50,53,70,71,80,87,94,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,280,284}
okToCast = true
nextAllowableCast = 0
holdMovement = 0
currentCast = ''
cast_speed = 1.0
failCount = 0
rangedDelay = 600
magicTypes	= T{'WhiteMagic','BlackMagic','SummonerPact','Ninjutsu','BardSong','BlueMagic','Geomancy','Trust'}
jaTypes		= T{'JobAbility','Scholar','CorsairRoll','PetCommand','CorsairShot','Samba','Waltz','Jig','Flourish1','Flourish2','Flourish3','Effusion','Rune','Ward','BloodPactRage','BloodPactWard','Monster'}

local zoneData = windower.ffxi.get_info()
if zoneData.zone ~= nil then
	if exclusion_zones:contains(zoneData.zone) then
		inTown = true
	else
		inTown = false
	end
else
	inTown = false
end

function check_able()
	if buffactive['terror'] ~= nil then
		windower.add_to_chat(050, "Unable to act. [Terror].")
		handle_idle()
		return false
	end
	if buffactive['sleep'] ~= nil then
		windower.add_to_chat(050, "Unable to act. [Sleep].")
		handle_idle()
		return false
	end
	if buffactive['stun'] ~= nil then
		windower.add_to_chat(050, "Unable to act. [Stun].")
		handle_idle()
		return false
	end
	if buffactive['petrification'] ~= nil then
		windower.add_to_chat(050, "Unable to act. [Petrification].")
		handle_idle()
		return false
	end
	if player.hp == 0 then
		windower.add_to_chat(050, "Unable to act. [KO].")
		return false
	end
	if player.status == 'Resting' then
		windower.add_to_chat(050, "Unable to act. [Resting].")
		return false
	end
	if player.status == 'Event' then
		windower.add_to_chat(050, "Unable to act. [Event].")
		return false
	end
	if os.clock() < nextAllowableCast and failCount < 2 then
		windower.add_to_chat(050, "Unable to act. [Input Delay or Spell Casting "..math.ceil((nextAllowableCast-os.clock())).."s].")
		failCount = failCount + 1
		return false
	else
		if failCount >= 2 then
			failCount = 0
			windower.add_to_chat(050, "Overriding Input Delay.")
		end
		okToCast = true
		nextAllowableCast = 0
		holdMovement = 0
	end
	return true
end

function check_ready(spell)
	if midaction() or os.clock() < nextAllowableCast then
		okToCast = false
		if spell.type == 'Item' then
			return true
		elseif check_able() then
			if magicTypes:contains(spell.type) then
				local tempRecastData = windower.ffxi.get_spell_recasts()
				if tempRecastData[spell.recast_id] ~= nil and tempRecastData[spell.recast_id] == 0 then
					if player.mp > spell.mp_cost then
						okToCast = true
						return true
					else
						windower.add_to_chat(050, "Not enough MP.")
						return false
					end
				else
					windower.add_to_chat(050, "Spell not ready yet. ["..(tempRecastData[spell.recast_id]).." seconds remain]")
					return false
				end
			elseif spell.type == "Weaponskill" then
				okToCast = true
				return true
			elseif jaTypes:contains(spell.type) then
				--[[local tempRecastData = windower.ffxi.get_ability_recasts()
				if tempRecastData[spell.recast_id] ~= nil and tempRecastData[spell.recast_id] == 0 then
					okToCast = true
					return true
				else
					windower.add_to_chat(050, "Ability not ready yet. ["..tempRecastData[spell.recast_id].." seconds remain]")
					return false
				end]]--
			else
				return true
			end
		else
			return false
		end
	else
		failCount = 0
		nextAllowableCast = 0
		holdMovement = 0
		return true
	end
end

function check_ready_status()
	if midaction() or os.clock() < nextAllowableCast then
		okToCast = false
		if buffactive['terror'] or buffactive['sleep'] or buffactive['stunned'] or buffactive['petrification'] then
			handle_idle()
			return false
		elseif not buffactive['KO'] and player.status ~= 'Event' and player.hp > 0 and os.clock() >= nextAllowableCast then
			okToCast = true
			return true
		else
			return false
		end
	else
		if buffactive['terror'] or buffactive['sleep'] or buffactive['stunned'] or buffactive['petrification'] then
			handle_idle()
			return false
		elseif not buffactive['KO'] and player.status ~= 'Event' and player.hp > 0 then
			return true
		else
			return false
		end
	end
end

function check_ready_silent()
	if midaction() or os.clock() < nextAllowableCast then
		okToCast = false
		if buffactive['terror'] or buffactive['sleep'] or buffactive['stunned'] or buffactive['petrification'] then
			handle_idle()
			return false
		elseif not buffactive['charm'] and not buffactive['Mounted'] and not buffactive['KO'] and player.status ~= 'Event' and player.status ~= 'Resting' and player.hp > 0 and os.clock() >= nextAllowableCast then
			okToCast = true
			return true
		else
			return false
		end
	else
		if buffactive['terror'] or buffactive['sleep'] or buffactive['stunned'] or buffactive['petrification'] then
			handle_idle()
			return false
		elseif not buffactive['charm'] and not buffactive['Mounted'] and not buffactive['KO'] and player.status ~= 'Event' and player.status ~= 'Resting' and player.hp > 0 then
			return true
		else
			return false
		end
	end
end

function check_ready_status()
	if midaction() or os.clock() < nextAllowableCast then
		okToCast = false
		if buffactive['terror'] or buffactive['sleep'] or buffactive['stunned'] or buffactive['petrification'] then
			handle_idle()
			return false
		elseif not buffactive['KO'] and player.status ~= 'Event' and os.clock() >= nextAllowableCast then
			okToCast = true
			return true
		else
			return false
		end
	else
		if buffactive['terror'] or buffactive['sleep'] or buffactive['stunned'] or buffactive['petrification'] then
			handle_idle()
			return false
		elseif not buffactive['KO'] and player.status ~= 'Event' then
			failCount = 0
			nextAllowableCast = 0
			return true
		else
			return false
		end
	end
end


function spam_protection_on(precastSpell)
	currentCast = precastSpell.english
	if precastSpell.type == 'Misc' then
		nextAllowableCast = os.clock() + math.ceil((rangedDelay/106)*cast_speed) + 2.1
		holdMovement = os.clock() + math.ceil((rangedDelay/106)*cast_speed)
		send_command('timers d "Casting";timers c "Casting" '..(math.ceil((rangedDelay/106)*cast_speed) + 2)..' up;')
	elseif precastSpell.type == 'Item' then
		nextAllowableCast = 0
		holdMovement = 0
	elseif precastSpell.type == 'JobAbility' or precastSpell.type == 'PetCommand' or precastSpell.type == 'Scholar' or precastSpell.cast_time == nil then
		send_command('timers d "Casting";timers c "Casting" 1 up;')
		nextAllowableCast = os.clock() + 0.6
		holdMovement = 0
	else
		if precastSpell.english == 'Stoneskin' then
			nextAllowableCast = os.clock() + math.ceil((10*cast_speed)) + 3.1
			holdMovement = os.clock() + math.ceil((10*cast_speed))
			send_command('timers d "Casting";timers c "Casting" '..(math.ceil((precastSpell.cast_time*cast_speed)) + 3)..' up;')
		else
			nextAllowableCast = os.clock() + math.ceil(((precastSpell.cast_time)*cast_speed)) + 3.1
			holdMovement = os.clock() + math.ceil(((precastSpell.cast_time)*cast_speed))
			send_command('timers d "Casting";timers c "Casting" '..(math.ceil((precastSpell.cast_time*cast_speed)) + 3)..' up;')
		end
	end
end

function spam_protection_off(aftercastSpell)
	if aftercastSpell.english == currentCast then
		currentCast= ''
		okToCast = true
		holdMovement = 0

		if aftercastSpell.interrupted or aftercastSpell.action_type == 'Interruption' then
			failCount = 0
			nextAllowableCast = 0
		else
			if aftercastSpell.type == 'Misc' then
				nextAllowableCast = os.clock() + 1.5
				send_command('timers d "Casting";timers d "Input Delay";timers c "Input Delay" 2 up;')
			elseif aftercastSpell.type == 'Item' or aftercastSpell.type == 'JobAbility' or aftercastSpell.type == 'PetCommand' or aftercastSpell.type == 'Scholar' or aftercastSpell.cast_time == nil then
				--do nothing
                nextAllowableCast = os.clock() + 0.1
				send_command('timers d "Casting";timers d "Input Delay";')
			else
				nextAllowableCast = os.clock() + 2.5
				send_command('timers d "Casting";timers d "Input Delay";timers c "Input Delay" 3 up;')
			end
		end
		return true
	else
		return false
	end
end