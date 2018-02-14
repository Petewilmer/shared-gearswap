include('iterator.lua')

party_target = false
lastChat = 0

allow_engage = I{true,false}
haste_mode = I{'Haste', 'Haste II'}

alt_names = T{'Miang','Nekachu','Mazuki','Norzu','Ulor','Tosel'}
-- alt_names = T{'Miang','Nekachu','Mazuki','Norzu','Tosel'}

allowFollow = I{true,false}

opposingElement = T{}
opposingElement['Water'] = 'Fire'
opposingElement['Lightning'] = 'Water'
opposingElement['Earth'] = 'Lightning'
opposingElement['Wind'] = 'Earth'
opposingElement['Ice'] = 'Wind'
opposingElement['Fire'] = 'Ice'
opposingElement['Light'] = 'Dark'
opposingElement['Dark'] = 'Light'

stormNames = T{}
stormNames['Water'] = 'Rainstorm'
stormNames['Lightning'] = 'Thunderstorm'
stormNames['Earth'] = 'Sandstorm'
stormNames['Wind'] = 'Windstorm'
stormNames['Ice'] = 'Hailstorm'
stormNames['Fire'] = 'Firestorm'
stormNames['Light'] = 'Voidstorm'
stormNames['Dark'] = 'Aurorastorm'


elements_base = I{'Water','Thunder','Stone','Aero','Blizzard','Fire'}
elements_helix = I{'Hydrohelix','Ionohelix','Geohelix','Anemohelix','Cryohelix','Pyrohelix'}
elements_am = I{'Flood','Burst','Quake','Tornado','Freeze','Flare'}
elements_storm = I{'Rainstorm','Thunderstorm','Sandstorm','Windstorm','Hailstorm','Firestorm'}
elements_geo = I{'Watera','Thundara','Stonera','Aera','Blizzara','Fira'}
elements_threnody = I{'Water Threnody','Ltng. Threnody','Earth Threnody','Wind Threnody','Ice Threnody','Fire Threnody'}
elements_ninjutsu = I{'Suiton', 'Raiton', 'Doton', 'Huton', 'Hyoton', 'Katon'}

--WS Properties
wsProperty = T{}
--Level 1s
wsProperty['Transfixion'] = T{'Light'}
wsProperty['Compression'] = T{'Dark'}
wsProperty['Liquefaction'] = T{'Fire'}
wsProperty['Scission'] = T{'Earth'}
wsProperty['Reverberation'] = T{'Water'}
wsProperty['Detonation'] = T{'Wind'}
wsProperty['Induration'] = T{'Ice'}
wsProperty['Impaction'] = T{'Lightning'}
--Level 2s
wsProperty['Gravitation'] = T{'Dark','Earth'}
wsProperty['Distortion'] = T{'Water','Ice'}
wsProperty['Fusion'] = T{'Fire','Light'}
wsProperty['Fragmentation'] = T{'Wind','Lightning'}
--Level 3s
wsProperty['Darkness'] = T{'Dark','Earth','Water','Ice'}
wsProperty['Light'] = T{'Light','Fire','Wind','Lightning'}

local zoneData = windower.ffxi.get_info()

--Zone IDs to ignore (Town)
exclusion_zones = T{14,26,43,44,48,50,53,70,71,80,87,94,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,256,257,280,284}

windower.raw_register_event('Zone change',function (new_id, old_id)
    if exclusion_zones:contains(new_id) then
        inTown = true
    else
        inTown = false
    end
end)

inTown = false

if exclusion_zones:contains(zoneData.zone) then
    inTown = true
end

function get_job_points_spent()
    if type(windower.ffxi.get_player().job_points) == 'table' and windower.ffxi.get_player().job_points[player.main_job:lower()].jp_spent then
        return tonumber(windower.ffxi.get_player().job_points[player.main_job:lower()].jp_spent)
    end
    return 0
end

function file_exists(name)
   local f=io.open(windower.addon_path..'data/'..name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function load_gear_file()
    if file_exists('gear/'..player.name..'_'..player.main_job..'.lua') then
        include('gear/'..player.name..'_'..player.main_job..'.lua')
    elseif file_exists('gear/'..player.name..'_'..player.main_job:lower()..'.lua') then
        include('gear/'..player.name..'_'..player.main_job:lower()..'.lua')
    elseif file_exists('gear/'..player.name:lower()..'_'..player.main_job..'.lua') then
        include('gear/'..player.name:lower()..'_'..player.main_job..'.lua')
    elseif file_exists('gear/'..player.name:lower()..'_'..player.main_job:lower()..'.lua') then
        include('gear/'..player.name:lower()..'_'..player.main_job:lower()..'.lua')
    elseif file_exists('gear/'..player.name:upper()..'_'..player.main_job..'.lua') then
        include('gear/'..player.name:upper()..'_'..player.main_job..'.lua')
    elseif file_exists('gear/'..player.name:upper()..'_'..player.main_job:lower()..'.lua') then
        include('gear/'..player.name:upper()..'_'..player.main_job:lower()..'.lua')
    elseif file_exists('gear/'..player.main_job:lower()..'.lua') then
        include('gear/'..player.main_job:lower()..'.lua')
    elseif file_exists('gear/'..player.main_job..'.lua') then
        include('gear/'..player.main_job..'.lua')
    else
        windower.add_to_chat(028,'Error: Gear file is missing. Please add gear file in /gearswap/data/gear/ named as '..player.name..'_'..player.main_job..'.lua')
    end
end

if player.name == 'Nekachu' then
	PL = 'Mazuki'
else
	PL = 'Nekachu'
end


mirror_nukers = T{}

function stagger_send_to_all(commandSlug)
    if #commandSlug > 0 then
        sendString = ''
        for i,v in pairs(alt_names) do
            sendString = sendString..'send '..v..' '..commandSlug..';wait 1;'
        end
        if #sendString > 0 then
            send_command(sendString)
        end
    end
end

function send_to_all(commandSlug)
	if #commandSlug > 0 then
		sendString = ''
		for i,v in pairs(alt_names) do
			sendString = sendString..'send '..v..' '..commandSlug
		end
		if #sendString > 0 then
			send_command(sendString)
		end
	end
end

function send_to_alts(commandSlug)
	if #commandSlug > 0 then
		sendString = ''
		for i,v in pairs(alt_names) do
			if v ~= player.name then
				sendString = sendString..'send '..v..' '..commandSlug
			end
		end
		if #sendString > 0 then
			send_command(sendString)
		end
	end
end

function send_to_alts_in_range(commandSlug)
	if #commandSlug > 0 then
		sendString = ''
		for i,v in pairs(windower.ffxi.get_mob_array()) do
			if v.name ~= '' and v.name ~= player.name and alt_names:contains(v.name) and v.valid_target then
				sendString = sendString..'send '..v.name..' '..commandSlug
			end
		end
		if #sendString > 0 then
			send_command(sendString)
		end
	end
end

function checkNumberOfItem(bag_data,itemID)
    for index,value in pairs(bag_data) do
        if type(value) == 'table' then
            if value.id == itemID and value.count > 0 then
                return true
            end
        end
    end
    return false
end

function execute_common_command(passedCommand)
	if passedCommand == 'request_assist' then
		if player.status == 'Engaged' then
			local current_targ = windower.ffxi.get_mob_by_target('t')
			if current_targ ~= nil and current_targ.hpp > 20 and current_targ.id then
				send_to_alts_in_range('gs c engage_target '..current_targ.id..';')
			end
		end
		return true
    elseif passedCommand == "setpartytarget" then
        local target_info = windower.ffxi.get_mob_by_target('t')
        if type(target_info) == 'table' and target_info.id ~= nil then
            send_to_alts_in_range('gs c partytarget '..target_info.id..';')
            send_command('gs c partytarget '..target_info.id..';')
            windower.add_to_chat(167,"Sending current target ["..target_info.name.."] to alts in range")
        end
	elseif passedCommand:sub(1,13) == 'engage_target' then
        if allow_engage:current() == false then
            return true
        end
		passedCommand = passedCommand:gsub("engage_target ", "")
		if player.status ~= 'Engaged' and passedCommand ~= '' then
			passedCommand = tonumber(passedCommand)
			engage_passed_target(passedCommand)
		elseif player.status == 'Engaged' then
			passedCommand = tonumber(passedCommand)
			local current_targ = windower.ffxi.get_mob_by_target('t')
			if passedCommand ~= current_targ.id then
				send_command('input /attackoff;wait 2;gs c engage_target '..passedCommand..';')
			end
		end
		return true
	elseif passedCommand:sub(1,7) == 'element' then
		targetElement = passedCommand:gsub("element ", "")
		targetElement = targetElement:gsub(" ", "")
		elements_base:setTo(targetElement)
        targetElement = targetElement:lower()
		elements_helix:jumpTo(elements_base.pos)
		elements_am:jumpTo(elements_base.pos)
		elements_geo:jumpTo(elements_base.pos)
		elements_storm:jumpTo(elements_base.pos)

		windower.add_to_chat(167,elements_base:current().." Mode")
	elseif passedCommand == 'next_element' then
		elements_base:next()
		elements_helix:next()
		elements_am:next()
		elements_geo:next()
		elements_storm:next()

		windower.add_to_chat(167,elements_base:current().." Mode")
	elseif passedCommand == 'prev_element' then
		elements_base:previous()
		elements_helix:previous()
		elements_am:previous()
		elements_geo:previous()
		elements_storm:previous()

		windower.add_to_chat(167,elements_base:current().." Mode")
	elseif passedCommand == 'alt_ws' then
		send_to_alts('gs c ws;')
		return true
    elseif passedCommand == 'indion' then
        send_to_alts_in_range('gs c indi;')
        return true
    elseif passedCommand == 'geoon' then
        send_to_alts_in_range('gs c geo;')
        return true
	elseif passedCommand == 'town on' then
		inTown = true
		return true
	elseif passedCommand == 'town off' then
		inTown = false
		return true
	elseif passedCommand == 'soul' then
		send_command('input /item "Soultrapper 2000" <t>;')
		send_to_alts_in_range('gs c use_soul;')
		return true
	elseif passedCommand == 'use_soul' then
		send_command('input /item "Soultrapper 2000" <t>;')
		return true
	elseif passedCommand == 'tradeplate' then
		local bag_data = windower.ffxi.get_items(0)
		local traded = false
		for index,value in pairs(bag_data) do
			if type(value) == 'table' then
				if not traded and value.id == 2477 and value.count > 0 then
					traded = true
					send_command('setkey f8 down;wait 0.2;setkey f8 up;wait 0.4;input /item "Soul Plate" <t>;')
				end
			end
		end
		return true
    elseif passedCommand == 'cancel' then
        sparksLeft = 0
        keysLeft = 0
    elseif passedCommand:slice(1,7) == 'dumpall' then
        passedCommand = passedCommand:gsub("dumpall ","")
        if passedCommand ~= nil and string.len(passedCommand) > 0 and tonumber(passedCommand) ~= nil then
            sparksLeft = tonumber(passedCommand)
            if sparksLeft >= 2755 then
                send_command('setkey alt up;setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey up down;wait 0.1;setkey up up;wait 0.2; setkey enter down;wait 0.1;setkey enter up;wait 1; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey enter down;wait 0.1;setkey enter up;wait 1; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey down down;wait 0.1;setkey down up;wait 0.2; setkey enter down;wait 0.1;setkey enter up;wait 1; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey right down;wait 0.1;setkey right up;wait 0.2; setkey down down;wait 0.1;setkey down up;wait 0.2; setkey down down;wait 0.1;setkey down up;wait 0.3;gs c dumpsparks '..sparksLeft..';')
            end
        end
    elseif passedCommand:slice(1,10) == 'dumpsparks' then
        passedCommand = passedCommand:gsub("dumpsparks ","")
        if passedCommand ~= nil and string.len(passedCommand) > 0 and tonumber(passedCommand) ~= nil then
            sparksLeft = tonumber(passedCommand)
            if sparksLeft >= 2755 then
                local bag_data = windower.ffxi.get_bag_info(0)
                if bag_data ~= 'nil' and type(bag_data) == 'table' and bag_data.count ~= nil and bag_data.count < bag_data.max then
                    send_command('setkey enter down;wait 0.1;setkey enter up;wait 0.4;setkey up down;wait 0.1;setkey up up;wait 0.4;setkey enter down;wait 0.1;setkey enter up;wait 2.1;gs c dumpsparks '..(sparksLeft-2755))
                    windower.add_to_chat(050,'Shields left to collect ['..math.floor((sparksLeft-2755)/2755)..']')
                else
                    windower.add_to_chat(050,'Done because full')
                    windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
                end
            else
                windower.add_to_chat(050,'Done')
                windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
            end
        end
        return true
    elseif passedCommand:slice(1,11) == 'use_pickaxe' then
        send_command("input /targetnpc; wait 0.2; input /item 'Pickaxe' <t>;")
    elseif passedCommand:slice(1,8) == 'use_keys' then
        passedCommand = passedCommand:gsub("use_keys ","")
        if passedCommand ~= nil and string.len(passedCommand) > 0 and tonumber(passedCommand) ~= nil then
            keysLeft = tonumber(passedCommand)
            if keysLeft > 0 then
                local bag_data = windower.ffxi.get_bag_info(0)
                if bag_data ~= 'nil' and type(bag_data) == 'table' and bag_data.count ~= nil and bag_data.count < bag_data.max then
                    send_command('input /targetnpc; wait 0.2; input /item "SP Gobbie Key" <t>; wait 16;gs c use_keys '..(keysLeft-1))
                    windower.add_to_chat(050,'Keys left to use ['..keysLeft..']')
                else
                    windower.add_to_chat(050,'Done because full')
                    windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
                end
            else
                windower.add_to_chat(050,'Done')
                windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
            end
        else
            local bag_contents = windower.ffxi.get_items(0)
            keysLeft = 0
            for index,value in pairs(bag_contents) do
                if type(value) == 'table' then
                    if value.id == 8973 and value.count > 0 then
                        keysLeft = keysLeft + value.count
                    end
                end
            end
            local bag_data = windower.ffxi.get_bag_info(0)
            if keysLeft > bag_data.max - bag_data.count then
                keysLeft = bag_data.max - bag_data.count
            end
            if keysLeft > 0 then
                execute_common_command('use_keys '..keysLeft)
            end
        end
        return true
    elseif passedCommand:slice(1,12) == 'use_anv_keys' then
        passedCommand = passedCommand:gsub("use_anv_keys ","")
        if passedCommand ~= nil and string.len(passedCommand) > 0 and tonumber(passedCommand) ~= nil then
            keysLeft = tonumber(passedCommand)
            if keysLeft > 0 then
                local bag_data = windower.ffxi.get_bag_info(0)
                if bag_data ~= 'nil' and type(bag_data) == 'table' and bag_data.count ~= nil and bag_data.count < bag_data.max then
                    send_command('input /targetnpc; wait 0.2; input /item "Dial Key #ANV" <t>; wait 16;gs c use_anv_keys '..(keysLeft-1))
                    windower.add_to_chat(050,'ANV Keys left to use ['..keysLeft..']')
                else
                    windower.add_to_chat(050,'Done because full')
                    windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
                end
            else
                windower.add_to_chat(050,'Done')
                windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
            end
        else
            local bag_contents = windower.ffxi.get_items(0)
            keysLeft = 0
            for index,value in pairs(bag_contents) do
                if type(value) == 'table' then
                    if value.id == 9274 and value.count > 0 then
                        keysLeft = keysLeft + value.count
                    end
                end
            end
            local bag_data = windower.ffxi.get_bag_info(0)
            if keysLeft > bag_data.max - bag_data.count then
                keysLeft = bag_data.max - bag_data.count
            end
            if keysLeft > 0 then
                execute_common_command('use_anv_keys '..keysLeft)
            end
        end
        return true
    elseif passedCommand == 'allow_follow' then
        allowFollow:next()
        windower.add_to_chat(050,'Auto Follow ['..tostring(allowFollow:current())..']')
        return true
	elseif passedCommand:slice(1,6) == 'follow' and allowFollow:current() then
		passedCommand = passedCommand:gsub("follow ","")
		if passedCommand ~= nil then
			if string.len(passedCommand) > 0 then
				for i,v in pairs(windower.ffxi.get_mob_array()) do
					if v.name ~= '' and v.name:lower() == passedCommand:lower() and v.valid_target then
                        windower.ffxi.follow(v.index)
					end
				end
			end
		end
		return true
	elseif passedCommand == 'stop follow' then
        send_command('setkey numpad7 down;wait 0.1;setkey numpad7 up;')
		return true
	elseif passedCommand == 'idle' then
		handle_idle()
		return true
	elseif passedCommand == 'request_follow' then
		send_to_alts_in_range('gs c follow '..player.name..';')
		return true
	elseif passedCommand == 'request_stop_follow' then
		send_to_alts_in_range('gs c stop follow;')
		return true
	elseif passedCommand == 'heal' then
		if player.sub_job == "NIN" then
			send_command('input /ma "Utsusemi: Ichi" <me>;')
		elseif player.sub_job == "DNC" then
			send_command('input /ja "Box Step" <t>;')
		else
			heal_me()
		end
		return true
	elseif passedCommand == 'buff' then
		if player.sub_job == "NIN" then
			send_command('input /ma "Utsusemi: Ni" <me>;')
		elseif player.sub_job == "DNC" then
			send_command('input /ja "Violent Flourish" <t>;')
			if buffactive['Haste'] == nil then
				send_command('send nekachu gs c castspell haste Miang;')
			end
		else
			buff_me()
		end
		return true
	elseif passedCommand == 'request_mazurka' then
		if player.name == 'Mazuki' then
			send_command('input /ma "Chocobo Mazurka" <me>;')
		else
			send_command('send Mazuki chocobomazurka')
		end
		return true
	elseif passedCommand == 'invitealts' then
		sendString = ''
		partyData = windower.ffxi.get_party()

		for i,v in pairs(alt_names) do
			if v ~= player.name then
				altFoundInParty = false
				for ii,vv in pairs(partyData) do
					if type(vv) == 'table' and vv.name == v then
						altFoundInParty = true
					end
				end

				if not altFoundInParty then
					sendString = sendString..'input /pcmd add '..v..';wait 2;'
				end
			end
		end

		if #sendString > 1 then
			send_command(sendString:sub(1,#sendString-7))
		end
		return true
    elseif passedCommand:sub(1,16) == 'stagger send all' then
        passedCommand = passedCommand:gsub("stagger send all ","")
        if passedCommand ~= nil then
            if string.len(passedCommand) > 0 then
                stagger_send_to_all(passedCommand..';')
            end
        end
        return true
	elseif passedCommand:sub(1,8) == 'send all' then
		passedCommand = passedCommand:gsub("send all ","")
		if passedCommand ~= nil then
			if string.len(passedCommand) > 0 then
				send_to_all(passedCommand..';')
			end
		end
		return true
	elseif passedCommand:sub(1,11) == 'send others' then
		passedCommand = passedCommand:gsub("send others ","")
		if passedCommand ~= nil then
			if string.len(passedCommand) > 0 then
				send_to_alts(passedCommand..';')
			end
		end
		return true
	elseif passedCommand:sub(1,7) == 'sendall' then
		passedCommand = passedCommand:gsub("sendall ","")
		if passedCommand ~= nil then
			if string.len(passedCommand) > 0 then
				send_to_all(passedCommand..';')
			end
		end
		return true
	elseif passedCommand:sub(1,10) == 'sendothers' then
		passedCommand = passedCommand:gsub("sendothers ","")
		if passedCommand ~= nil then
			if string.len(passedCommand) > 0 then
				send_to_alts(passedCommand..';')
			end
		end
		return true
	elseif passedCommand:sub(1,9) == 'send alts' then
		passedCommand = passedCommand:gsub("send alts ","")
		if passedCommand ~= nil then
			if string.len(passedCommand) > 0 then
				send_to_alts(passedCommand..';')
			end
		end
		return true
	elseif passedCommand:sub(1,8) == 'sendalts' then
		passedCommand = passedCommand:gsub("sendalts ","")
		if passedCommand ~= nil then
			if string.len(passedCommand) > 0 then
				send_to_alts(passedCommand..';')
			end
		end
		return true
	elseif passedCommand == 'alarm' then
		windower.add_to_chat(050,'Done')
		windower.play_sound(windower.addon_path..'data/sounds/alarm.wav')
		return true
	elseif passedCommand:slice(1,6) == 'mirror' then
		passedCommand = passedCommand:gsub("mirror ","")
		if passedCommand ~= nil and string.len(passedCommand) > 0 then
			if passedCommand:slice(1,3) == 'use' then
				passedCommand = passedCommand:gsub("use ","")
				if passedCommand ~= nil and string.len(passedCommand) > 0 then
					mirror_nukers = T{}
					local counter = 1
					for w in string.gmatch(passedCommand, "%w+") do
						mirror_nukers[counter] = w
						counter = counter + 1
						windower.add_to_chat(i,'Adding '..w..' to list of Mirror Nukers')
					end
				end
			elseif passedCommand:slice(1,3) == 'list' then
				for i,v in pairs(mirror_nukers) do
					windower.add_to_chat(i,'Sending nukes to '..tostring(v))
				end
			elseif passedCommand:slice(1,3) == 'ele' then
				passedCommand = passedCommand:gsub("ele ","")
				if passedCommand ~= nil and string.len(passedCommand) > 0 then
					local mirror_request = T{}
					local counter = 1
					for w in string.gmatch(passedCommand, "%w+") do
						mirror_request[counter] = w
						counter = counter + 1
					end
					if (mirror_request[1] == 'Blizzard' or mirror_request[1] == 'Fire' or mirror_request[1] == 'Aero' or mirror_request[1] == 'Stone' or mirror_request[1] == 'Thunder' or mirror_request[1] == 'Water') and (mirror_request[2] == 'single' or mirror_request[2] == 'aoe') and (mirror_request[3] == 'Y' or mirror_request[3] == 'N') and mirror_request[4] ~= nil then
						sendString = ''
						for i,v in pairs(windower.ffxi.get_mob_array()) do
							if v.name ~= '' and v.name ~= player.name and mirror_nukers:contains(v.name) and v.valid_target then
								sendString = sendString..'send '..v.name..' gs c nuke_req '..mirror_request[1]..' '..mirror_request[2]..' '..mirror_request[3]..' '..mirror_request[4]..';'
							end
						end
						if #sendString > 0 then
							if mirror_request[3] == 'Y' then
								send_command('wait 0.5;'..sendString)
							else
								send_command(sendString)
							end
						end
					end
				end
			end
		end
		return true
	elseif passedCommand == 'rcell' then
		send_command("input /item 'Rubicund Cell' <t>;")
		return true
	elseif passedCommand == 'ccell' then
		send_command("input /item 'Cobalt Cell' <t>;")
		return true
    elseif passedCommand == 'mirrorstonic' then
        send_command('input /item "Mirror\'s Tonic" <me>;')
        return true
    elseif passedCommand == 'la' then
        local lost_article = windower.ffxi.get_mob_by_name('Lost Article')
        if lost_article ~= nil then
            local article_distance = math.sqrt(((lost_article.x-player.x)*(lost_article.x-player.x)) + ((lost_article.y-player.y)*(lost_article.y-player.y)))
            windower.add_to_chat(tostring(article_distance))
            windower.add_to_chat('x:'..tostring(lost_article.x)..', y:'..tostring(lost_article.y))
            windower.add_to_chat('your x:'..tostring(player.x)..', your y:'..tostring(player.y))
        end
        return true
    elseif passedCommand == 'face_miang' then
        local players = windower.ffxi.get_party()
        local pi = 3.14159265359
        for index,p in pairs(players) do
            if type(p) == 'table' and p.name ~= nil and p.mob ~= nil and type(p.mob) == 'table' and p.mob.x ~= nil and p.mob.y ~= nil then
                if p.name == 'Miang' then
                    dx = player.x - p.mob.x
                    dy = player.y - p.mob.y
                    windower.ffxi.turn(math.atan2(dx, dy) + pi/2)
                end
            end
        end
    elseif passedCommand:sub(1,11) == 'request_sc ' then
        passedCommand = passedCommand:gsub("request_sc ","")
        local ele = tostring(elements_base:current())
        send_command('send '..passedCommand..' gs c sc '..ele:lower())
        return true
    elseif passedCommand == 'allow_engage' then
        allow_engage:next()
        windower.add_to_chat(050,'Allow Engage ['..tostring(allow_engage:current())..']')
	end
	return false
end

function engage_passed_target(newID)
	newID = tonumber(newID)
	local target = windower.ffxi.get_mob_by_id(newID)
	local current_targ = windower.ffxi.get_mob_by_target('t')
	if target ~= nil and target.distance < 400 and target.hpp > 20 then
		if windower.ffxi.get_player().status == 1 or (current_targ and current_targ.hpp == 0) then
			windower.packets.inject_outgoing(0x1A,string.char(0x1A,0x08,0,0)..cbytes2str(newID,4)..cbytes2str(target.index,2)..string.char(0x0F,0,0,0,0,0))
		else
			windower.packets.inject_outgoing(0x1A,string.char(0x1A,0x08,0,0)..cbytes2str(newID,4)..cbytes2str(target.index,2)..string.char(0x02,0,0,0,0,0))
		end
	end
end

function cbytes2str(num,lim)
	local outstr = ''
	while num > 0 do
		outstr = outstr..string.char(num%256)
		num = math.floor(num/256)
	end
	while #outstr < lim do
		outstr = outstr..string.char(0)
	end
	return outstr
end

function heal_me()
	if buffactive['silence'] and (player.main_job == 'GEO' or player.main_job == 'BRD' or player.main_job == 'WHM' or player.main_job == 'SCH' or player.main_job == 'PLD' or player.main_job == 'NIN') then
		send_command('input /item "Echo Drops" <me>;')
	end

	if player.main_job == 'WHM' or player.main_job == 'SCH' or player.sub_job == 'RDM' or player.sub_job == 'WHM' then
		local hN = (player.hp / ( player.hpp / 100) )-player.hp
		if hN > 650 then
			send_command('input /ma "Cure IV" <me>;')
		elseif hN > 350 then
			send_command('input /ma "Cure III" <me>;')
		end
    elseif player.sub_job == 'SCH' then
        local hN = (player.hp / ( player.hpp / 100) )-player.hp
        if hN > 350 then
            send_command('input /ma "Cure III" <me>;')
        end
	end

	if buffactive['Sleep'] then
		send_command('send '..PL..' gs c directstring zzz '..player.name..';')
	end
	if (player.main_job == 'SCH' or player.main_job == 'PLD' or player.main_job == 'BLM' or player.main_job == 'NIN') and buffactive['silence'] then
		send_command('send '..PL..' gs c directstring silence '..player.name..';')
	end
	if buffactive['paralysis'] then
		send_command('send '..PL..' gs c directstring para '..player.name..';')
	end
	if buffactive['plague'] or buffactive['disease'] then
		send_command('send '..PL..' gs c directstring virus '..player.name..';')
	end
	if buffactive['poison'] then
		send_command('send '..PL..' gs c directstring poison '..player.name..';')
	end
	if player.main_job ~= 'SCH' and buffactive['blindness'] then
		send_command('send '..PL..' gs c directstring blind '..player.name..';')
	end

	local erasesNeeded = 0

	if (player.main_job ~= 'SCH' and buffactive['Attack Down']) then
		erasesNeeded = 1
	end

	for i,v in pairs(eraseables) do
		if buffactive[v] then
			erasesNeeded = erasesNeeded + 1
		end
	end

	if PL == 'Nekachu' and erasesNeeded > 1 then
		send_command('send '..PL..' gs c directstring sacrifice '..player.name..';')
	elseif PL ~= 'Nekachu' or erasesNeeded == 1 then
		send_command('send '..PL..' gs c directstring erase '..player.name..';')
	end

	if buffactive['petrification'] then
		send_command('send '..PL..' gs c directstring stona '..player.name..';')
	end

	if buffactive['doom'] or buffactive['curse'] then
		send_command('send '..PL..' gs c directstring curse '..player.name..';')
	end
end

function buff_me()
	if player.main_job == 'SCH' then
		if not buffactive['aquaveil'] then
			send_command('input /ma "Aquaveil" <me>;')
		elseif not buffactive['Regain'] then
			send_command('input /ma "Adloquium" <me>;')
		elseif player.sub_job == 'RDM' and not buffactive['Phalanx'] then
			send_command('input /ma "Phalanx" <me>;')
		elseif not buffactive['stoneskin'] then
			send_command('input /ma "Stoneskin" <me>;')
		elseif not buffactive['Shock Spikes'] then
			send_command('input /ma "Shock Spikes" <me>;')
		elseif not buffactive['Regen'] then
			send_command('input /ma "Regen V" <me>;')
		elseif not buffactive['Pax'] then
			send_command('input /ma "Animus Minuo" <me>;')
		end
    elseif player.main_job == 'GEO' then
        if (player.sub_job == 'WHM' or player.sub_job == 'SCH') and not buffactive['Reraise'] then
            send_command('input /ma "Reraise" <me>;')
        elseif (player.sub_job == 'WHM' or player.sub_job == 'RDM' or player.sub_job == 'SCH') and not buffactive['aquaveil'] then
            send_command('input /ma "Aquaveil" <me>;')
        elseif player.sub_job == 'RDM' and not buffactive['phalanx'] then
            send_command('input /ma "Phalanx" <me>;')
        elseif player.sub_job == 'RDM' and not buffactive['refresh'] then
            send_command('input /ma "Refresh" <me>;')
        elseif (player.sub_job == 'WHM' or player.sub_job == 'RDM' or player.sub_job == 'SCH') and not buffactive['stoneskin'] then
            send_command('input /ma "Stoneskin" <me>;')
        elseif (player.sub_job == 'WHM' or player.sub_job == 'RDM' or player.sub_job == 'SCH') and not buffactive['Blink'] then
            send_command('input /ma "Blink" <me>;')
        end
	elseif player.main_job == 'BLM' then
		if (player.sub_job == 'WHM' or player.sub_job == 'RDM' or player.sub_job == 'SCH') and not buffactive['aquaveil'] then
			send_command('input /ma "Aquaveil" <me>;')
		elseif player.sub_job == 'RDM' and not buffactive['phalanx'] then
			send_command('input /ma "Phalanx" <me>;')
		elseif player.sub_job == 'RDM' and not buffactive['refresh'] then
			send_command('input /ma "Refresh" <me>;')
		elseif (player.sub_job == 'WHM' or player.sub_job == 'RDM' or  player.sub_job == 'SCH') and not buffactive['stoneskin'] then
			send_command('input /ma "Stoneskin" <me>;')
        elseif (player.sub_job == 'WHM') and not buffactive['Reraise'] then
            send_command('input /ma "Reraise" <me>;')
		elseif not buffactive['Shock Spikes'] then
			send_command('input /ma "Shock Spikes" <me>;')
		elseif not buffactive['Blink'] then
			send_command('input /ma "Blink" <me>;')
		end
	elseif player.main_job == 'PLD' then
		if not buffactive['phalanx'] then
			send_command('input /ma "Phalanx" <me>;')
		elseif not buffactive['enlight'] then
			send_command('input /ma "Enlight II" <me>;')
		elseif not buffactive['Enmity Boost'] then
			send_command('input /ma "Crusade" <me>;')
		end
    elseif player.sub_job == 'WHM' then
        if not buffactive['aquaveil'] then
            send_command('input /ma "Aquaveil" <me>;')
        elseif not buffactive['Reraise'] then
            send_command('input /ma "Reraise" <me>;')
        elseif not buffactive['stoneskin'] then
            send_command('input /ma "Stoneskin" <me>;')
        elseif not buffactive['Blink'] then
            send_command('input /ma "Blink" <me>;')
        end
	end

	inRange = false
	inRange2 = false
	partyData = windower.ffxi.get_party()
	for i,v in pairs(partyData) do
		if type(v) == 'table' then
			if i:sub(1,1) =='p' then
				if partyData[i].name ~= nil and partyData[i].name == PL then
					if type(partyData[i].mob) == 'table' then
						if partyData[i].mob.distance ~= nil then
							if partyData[i].mob.distance <= 100 then
								inRange = true
								inRange2 = true
							elseif partyData[i].mob.distance < 400 then
								inRange2 = true
							end
						else
							x = tonumber(partyData[i].mob.x) - tonumber(partyData[healerID].mob.x)
							y = tonumber(partyData[i].mob.y) - tonumber(partyData[healerID].mob.y)

							if ((x * x) + (y * y)) < 100 then
								inRange = true
								inRange2 = true
							elseif ((x * x) + (y * y)) <= 400 then
								inRange2 = true
							end
						end
					end
				end
			end
		end
	end

	if inRange2 then
		if buffactive['Haste'] == nil then
			send_command('send '..PL..' gs c push Haste '..player.name..';')
		end

		if PL == 'Nekachu' and buffactive['Protect'] == nil then
			send_command('send '..PL..' gs c directstring protect '..player.name..';')
		end
		if PL == 'Nekachu' and buffactive['Shell'] == nil then
			send_command('send '..PL..' gs c directstring shell '..player.name..';')
		end

		if inRange and PL == 'Nekachu' then
			if (player.main_job == 'THF' or player.main_job == 'PLD') and buffactive['DEX Boost'] == nil then
				send_command('send '..PL..' gs c directstring dex '..player.name..';')
			end

			if (player.main_job == 'SCH' or player.main_job == 'BLM') then
				if not buffactive['INT Boost'] then
					send_command('send '..PL..' gs c directstring int '..player.name..';')
				end
			end

			if not buffactive[elements_storm:current()] and player.main_job == 'BLM' then
				--send_command('send '..PL..' gs c directstring '..elements_storm:current()..' '..player.name..';')
			end

			if (player.main_job == 'SAM' or player.main_job == 'MNK' or player.main_job == 'WAR' or player.main_job == 'NIN') and buffactive['STR Boost'] == nil then
				send_command('send '..PL..' gs c directstring str '..player.name..';')
			end

			if player.main_job ~= 'SCH' and player.main_job ~= 'BLM' and player.main_job ~= 'PLD' and buffactive['Auspice'] == nil then
				send_command('send '..PL..' gs c directstring auspice '..player.name..';')
			end
		end
	end
end

function check_for_aftermath_timers(buff, gain_or_loss)
    if gain_or_loss then
        if buff == 'Aftermath: Lv.3' then
            send_command('timers c "AM3" 180 up "Aftermath"')
        elseif buff == 'Aftermath: Lv.2' then
            send_command('timers c "AM2" 180 up "Aftermath"')
        elseif buff == 'Aftermath: Lv.1' then
            send_command('timers c "AM1" 180 up "Aftermath"')
        end
    else
        if buff == 'Aftermath: Lv.3' then
            send_command('timers d "AM3"')
        elseif buff == 'Aftermath: Lv.2' then
            send_command('timers d "AM2"')
        elseif buff == 'Aftermath: Lv.1' then
            send_command('timers d "AM1"')
        end
    end
end

function check_for_weakness_timers(buff, gain_or_loss)
    if buff == 'weakness' then
        if gain_or_loss then
            send_command('timers c "Weakness" 300 up "Weakness"')
        else
            send_command('timers d "Weakness"')
        end
    end
end

function set_priorities(key)
    function get_val(piece)
        if piece and type(piece)=='table' and piece[key] and type(piece[key])=='number' then
            return piece[key]
        end
        return 0
    end
    local diff = {}
    for i,v in pairs(gearswap.equip_list) do
        if type(v) == 'table' then
            gearswap.equip_list[i].priority = get_val(gearswap.equip_list[i]) - get_val(gearswap.equip_list_history[i])
        else
            gearswap.equip_list[i] = {name=v,priority=get_val(v) - get_val(gearswap.equip_list_history[i])}
        end
    end
end


function get_haste_amount()

    -- Gearswap can't detect the difference between Haste I and Haste II

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%

    if haste_mode:current() == 'Haste II' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604]) or buffactive.march == 3) or buffactive[580] == 2 then
            --add_to_chat(122, 'Magic Haste Level: 43%')
            return 43;
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            return 35;
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            return 30;
        elseif (buffactive.march == 1 or buffactive[604]) then
            return 15;
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) or buffactive.march == 3 or buffactive[580] == 2 then
            return 43;
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            return 35;
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            return 30;
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            return 15;
        end
    end
    return 0;
end

function notify_party_of_troublesome_debuffs(debuff, gain_or_loss)
    if not gain_or_loss then
        return false
    end
    if debuff == 'charm' then
        send_command('input /p Charmed')
    elseif debuff == 'doom' then
        send_command('input /p Doomed')
    elseif debuff == 'sleep' then
        send_command('input /p Zzz')
    end
end