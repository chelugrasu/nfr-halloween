local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

local hasQuest = false
local requirement = 0

RegisterServerEvent(GetCurrentResourceName()..":startQuest")
AddEventHandler(GetCurrentResourceName()..":startQuest", function(data)	
    local _source = source
    local user_id = vRP.getUserId({_source})
    exports.oxmysql:execute("SELECT * FROM nfr_halloween WHERE user_id = @user_id", {user_id = user_id}, function(rows)
            if #rows == 0 then
                    local target = math.random(Config.TargetPumpkins[1].value, Config.TargetPumpkins[2].value)
                    requirement = target
                    exports.oxmysql:insert('INSERT INTO nfr_halloween (user_id, first_status, progress, target) VALUES (?, ?, ?, ?) ', {user_id, "on-going", 0, target}, function(id) end)
                    local result = {
                        {target = target}
                    }
                    TriggerClientEvent(GetCurrentResourceName()..":startQuest", _source, false, result)
                    hasQuest = true
            else
                for _, v in pairs(rows) do
                    if v.first_status == 'finished' then
                        local time_diff_sec = os.time() - v.last_update / 1000
                        local total_minutes_left = math.floor(1440 - (time_diff_sec / 60))  -- Assuming a 24-hour period (1440 minutes)
                        local hours = math.floor(total_minutes_left / 60)
                        local minutes = total_minutes_left % 60
                        local time_left = string.format("%02d:%02d", hours, minutes)
                        if total_minutes_left <= 0 then
                            requirement = v.target
                            exports.oxmysql:update('UPDATE nfr_halloween SET first_status = ?  WHERE user_id = ? ', {'on-going', user_id}, function(affectedRows) end)
                            TriggerClientEvent(GetCurrentResourceName()..":startQuest", _source, true, rows)
                            hasQuest = true
                        else
                            vRPclient.notify(_source, {"Cooldown: "..time_left.." ore"})
                        end
                    else
                        requirement = v.target
                        exports.oxmysql:update('UPDATE nfr_halloween SET first_status = ?  WHERE user_id = ? ', {'on-going', user_id}, function(affectedRows) end)
                        TriggerClientEvent(GetCurrentResourceName()..":startQuest", _source, true, rows)
                        hasQuest = true
                    end
                end
            end
    end)
end)


RegisterServerEvent(GetCurrentResourceName()..":updateQuest")
AddEventHandler(GetCurrentResourceName()..":updateQuest", function(type, progress)	
    local _source = source
    local user_id = vRP.getUserId({_source})
    if type == "updateProgress" then
        exports.oxmysql:execute("SELECT * FROM nfr_halloween WHERE user_id = @user_id", {user_id = user_id}, function(rows)
            if #rows ~= 0 then
                for _, v in pairs(rows) do
                    if hasQuest then
                        if progress == requirement and v.first_status ~='finished' then

                            local candies = (math.random(Config.Rewards['First'].candiesValue1, Config.Rewards['First'].candiesValue2)) + v.candies
                            local money = math.random(Config.Rewards['First'].moneyValue1, Config.Rewards['First'].moneyValue2)
                            vRP.giveBankMoney({user_id, money})
                            exports.oxmysql:update('UPDATE nfr_halloween SET first_status = ?, progress = ?, target = ?, candies = ?  WHERE user_id = ? ', {'finished', 0, math.random(Config.TargetPumpkins[1].value, Config.TargetPumpkins[2].value), candies, user_id}, function(affectedRows) end)
                        else
                            exports.oxmysql:update('UPDATE nfr_halloween SET progress = ?  WHERE user_id = ? ', {progress, user_id}, function(affectedRows) end)
                        end
                    end
                end

            end
        end)
    end
end)

