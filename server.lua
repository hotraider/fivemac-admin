ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function notAdmin(player)
        for k,v in pairs(FC_S.Permission) do
            if v == player.identifier then
                return false
            end
        end
    return true
end

function sendToDiscord(name, message, color)
	local connect = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = "FC Admin - www.fivemac.com",
				  ["icon_url"] = "https://media.discordapp.net/attachments/627114895183446016/881084382109106206/pngwing.com_1.png?width=662&height=676"
			  },
		  }
	  }
	PerformHttpRequest(FC_S.Webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end

  function getid(src)
	local identifier = {}
	local identifiers = {}
	
	identifiers = GetPlayerIdentifiers(src)
	for i = 1, #identifiers do
		if string.match(identifiers[i], "discord:") then
			identifier["discord"] = string.sub(identifiers[i], 9)
			identifier["discord"] = "<@"..identifier["discord"]..">"
		end
		if string.match(identifiers[i], "steam:") then
			identifier["license"] = identifiers[i]
		end
	end
	if identifier["discord"] == nil then
		identifier["discord"] = "Bilinmiyor"
	end
	return identifier
end

RegisterServerEvent("fivemac:permission")
AddEventHandler("fivemac:permission", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    local id = getid(src)["discord"]
    local hex = getid(src)["license"]
    local grade = xPlayer.job.name
    local cash = xPlayer.getMoney(source)
    local bank = xPlayer.getAccount('bank').money
    bank = xPlayer.getAccount('bank').money
    if notAdmin(xPlayer) then
    TriggerClientEvent("nopefuck", source)
    return
    else
    sendToDiscord("Menüyü Açtı.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
    TriggerClientEvent('notification', source, 'Authorization verified, anti-cheat menu opened!', 2)
    end
end)

RegisterServerEvent("fivemac:ServerAllVehicle")
AddEventHandler("fivemac:ServerAllVehicle", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    local id = getid(src)["discord"]
    local hex = getid(src)["license"]
    local grade = xPlayer.job.name
    local cash = xPlayer.getMoney(source)
    local bank = xPlayer.getAccount('bank').money
    bank = xPlayer.getAccount('bank').money
    if notAdmin(xPlayer) then
    return
    else
        sendToDiscord("Araçları sildi.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
        TriggerClientEvent('notification', source, 'All vehicle deleted!', 2)
        TriggerClientEvent("fivemac-VehicleDeleteAll", -1)
    end
end)

RegisterServerEvent("fivemac:ServerAllPed")
AddEventHandler("fivemac:ServerAllPed", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    local id = getid(src)["discord"]
    local hex = getid(src)["license"]
    local grade = xPlayer.job.name
    local cash = xPlayer.getMoney(source)
    local bank = xPlayer.getAccount('bank').money
    bank = xPlayer.getAccount('bank').money
    if notAdmin(xPlayer) then
	return
else
    TriggerClientEvent('notification', source, 'All ped deleted!', 2)
    sendToDiscord("Pedleri Sildi.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
    TriggerClientEvent("fivemac-PedDeleteAll", -1)
    end
end)

RegisterServerEvent("fivemac:ServerAllObject")
AddEventHandler("fivemac:ServerAllObject", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    local id = getid(src)["discord"]
    local hex = getid(src)["license"]
    local grade = xPlayer.job.name
    local cash = xPlayer.getMoney(source)
    local bank = xPlayer.getAccount('bank').money
    bank = xPlayer.getAccount('bank').money
    if notAdmin(xPlayer) then
    return
    else
        TriggerClientEvent('notification', source, 'All object deleted!', 2)
        sendToDiscord("Objeleri Sildi.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
        TriggerClientEvent("fivemac-DeleteObjectAll", -1)
    end
end)

RegisterServerEvent("fivemac:community")
AddEventHandler("fivemac:community", function(data)
    if FC_S.DataCommunity then
        local xPlayer = ESX.GetPlayerFromId(source)
        local src = source
        local id = getid(src)["discord"]
        local hex = getid(src)["license"]
        local grade = xPlayer.job.name
        local cash = xPlayer.getMoney(source)
        local bank = xPlayer.getAccount('bank').money
        bank = xPlayer.getAccount('bank').money
        if notAdmin(xPlayer) then
        return
        else
        sendToDiscord("Data sildi communityservice.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
        TriggerClientEvent('notification', src, 'Community - Datası Temizlendi!', 2)
        MySQL.Async.execute("DELETE FROM communityservice", {}, function(players)
            end)
        end
    end
end)

RegisterServerEvent("fivemac:deletebilling")
AddEventHandler("fivemac:deletebilling", function(data)
    if FC_S.DataBilling then
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    local id = getid(src)["discord"]
    local hex = getid(src)["license"]
    local grade = xPlayer.job.name
    local cash = xPlayer.getMoney(source)
    local bank = xPlayer.getAccount('bank').money
    bank = xPlayer.getAccount('bank').money
    if notAdmin(xPlayer) then
        return
        else
            sendToDiscord("Data sildi billing.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
            TriggerClientEvent('notification', src, 'Fatura - Datası Temizlendi!', 2)
            MySQL.Async.execute("DELETE FROM billing", {}, function(players)
            end)
        end
    end
end)

RegisterServerEvent("fivemac:userdatasil")
AddEventHandler("fivemac:userdatasil", function(data)
    if FC_S.DataUser then
        local xPlayer = ESX.GetPlayerFromId(source)
        local src = source
        local id = getid(src)["discord"]
        local hex = getid(src)["license"]
        local grade = xPlayer.job.name
        local cash = xPlayer.getMoney(source)
        local bank = xPlayer.getAccount('bank').money
        bank = xPlayer.getAccount('bank').money
        if notAdmin(xPlayer) then
        return
        else
            sendToDiscord("Data sildi users.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
            TriggerClientEvent('notification', src, 'User - Datası Temizlendi!', 2)
            MySQL.Async.execute("DELETE FROM users", {}, function(players)
            end)
        end
    end
end)

RegisterServerEvent("fivemac:userinventorysil")
AddEventHandler("fivemac:userinventorysil", function(data)
    if FC_S.DataINV then
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    local id = getid(src)["discord"]
    local hex = getid(src)["license"]
    local grade = xPlayer.job.name
    local cash = xPlayer.getMoney(source)
    local bank = xPlayer.getAccount('bank').money
    bank = xPlayer.getAccount('bank').money
    if notAdmin(xPlayer) then
    return
    else
    sendToDiscord("Data sildi user_inventory.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
    TriggerClientEvent('notification', src, 'user_inventory - Datası Temizlendi!', 2)
    MySQL.Async.execute("DELETE FROM user_inventory", {}, function(players)
    end)
    end
    end
    end)


RegisterServerEvent("fivemac:ownedvehiclesremove")
AddEventHandler("fivemac:ownedvehiclesremove", function(data)
    if FC_S.DataVehicles then
        local xPlayer = ESX.GetPlayerFromId(source)
        local src = source
        local id = getid(src)["discord"]
        local hex = getid(src)["license"]
        local grade = xPlayer.job.name
        local cash = xPlayer.getMoney(source)
        local bank = xPlayer.getAccount('bank').money
        bank = xPlayer.getAccount('bank').money
        if notAdmin(xPlayer) then
        return
        else
            sendToDiscord("Data sildi owned_vehicles.", "\n\n\nOyuncu:"..GetPlayerName(source).."("..src..")\n\nJob:**"..grade.."**\n\n**Hesap Detayları:**\n\n💳 **Bank:**"..bank.."\n\n💶 **Cash:**"..cash.."\n\n**Discord:**"..id.."\n\n"..hex, 65280)
            TriggerClientEvent('notification', src, 'owned_vehicles - Datası Temizlendi!', 2)
            MySQL.Async.execute("DELETE FROM owned_vehicles", {}, function(players)
            end)
        end
    end
end)



