ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- TriggerEvent('esx_gcphone:registerNumber', 'BeanMachine', 'alerte cafe', true, true) --Si vous avez gcphone
-- TriggerEvent('esx_addons_gcphone:registerNumber', 'BeanMachine', 'alerte cafe', true, true) --Si vous avez gcphone
-- TriggerEvent('esx_phone:registerNumber', 'BeanMachine', 'alerte cafe', true, true) --Si vous avez gcphone

TriggerEvent('esx_society:registerSociety', 'cafe', 'cafe', 'society_cafe', 'society_cafe', 'society_cafe', {type = 'public'})

RegisterServerEvent('koko_beanmachine:annonceopen')--Changer l'annonce d'ouverture
AddEventHandler('koko_beanmachine:annonceopen', function (target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BeanMachine', '~b~Annonce', '~y~On est ouvert, venez goûter nos délicieux cafés !', 'CHAR_PROPERTY_BAR_LES_BIANCO', 8)
    end
end)

RegisterServerEvent('koko_beanmachine:annoncefermer') --Changer l'annonce de fermeture
AddEventHandler('koko_beanmachine:annoncefermer', function (target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BeanMachine', '~b~Annonce', '~y~On est Fermé, a bientôt !', 'CHAR_PROPERTY_BAR_LES_BIANCO', 8)
    end 
end)

RegisterServerEvent('koko_beanmachine:annoncerecrutement') --Changer l'annonce de recrutement
AddEventHandler('koko_beanmachine:annoncerecrutement', function (target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BeanMachine', '~b~Annonce', '~y~Recrutement en cours, rendez-vous au cafe !', 'CHAR_PROPERTY_BAR_LES_BIANCO', 8)
    end 
end)

RegisterServerEvent('koko_beanmachine:patronmess')
AddEventHandler('koko_beanmachine:patronmess', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)

    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'cafe' then
            TriggerClientEvent('koko_beanmachine:infoservice', xPlayers[i], _raison, name, message)
        end
    end
end)





--------COFFRE
RegisterServerEvent('koko_beanmachine:getStockItem')
AddEventHandler('koko_beanmachine:getStockItem', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cafe', function(inventory)
        local item = inventory.getItem(itemName)

        if item.count >= count then
            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
        else
            xPlayer.showNotification(_U('quantity_invalid'))
        end

        xPlayer.showNotification(_U('have_withdrawn') .. count .. ' ' .. item.label)
    end)
end)

ESX.RegisterServerCallback('koko_beanmachine:getStockItems', function(source, cb)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cafe', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('koko_beanmachine:putStockItems')
AddEventHandler('koko_beanmachine:putStockItems', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cafe', function(inventory)
        local item = inventory.getItem(itemName)

        if item.count >= 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            xPlayer.showNotification(_U('quantity_invalid'))
        end

        xPlayer.showNotification(_U('added') .. count .. ' ' .. item.label)
    end)
end)

ESX.RegisterServerCallback('koko_beanmachine:getPlayerInventory', function(source, cb)
    local xPlayer    = ESX.GetPlayerFromId(source)
    local items      = xPlayer.inventory

    cb({
        items      = items
    })
end)


ESX.RegisterServerCallback('koko_beanmachine:inventairejoueur', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)



--Machine a café
RegisterServerEvent('koko_beanmachine:refillThirst')
AddEventHandler('koko_beanmachine:refillThirst', function()
	TriggerClientEvent('esx_status:add', source, 'thirst', 90000)
end)

RegisterServerEvent('koko_beanmachine:lamoney')
AddEventHandler('koko_beanmachine:lamoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getAccount('bank').money >= 100 then --> Changer le prix du café ici
		xPlayer.removeAccountMoney('bank', 100) --> Changer le prix du café ici
		--TriggerClientEvent('esx:showNotification', xPlayer.source, "Merci à bientot !" .. 2500) --Si vous n'avez pas de script notification
        TriggerClientEvent('dopeNotify2:Alert', source, "Bean", "Merci à bientot !", 7000, 'success') --Si vous avez DopeNotify
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cafe', function(account)
			societyAccount = account
		end)
		if societyAccount ~= nil then
		societyAccount.addMoney(100) --> Changer le prix du café ici
		end
    else
		--TriggerClientEvent('esx:showNotification', xPlayer.source, "La maison ne fait pas credit !" .. 2500) --Si vous n'avez pas de script notification
		TriggerClientEvent('dopeNotify2:Alert', source, "Bean", "La maison ne fait pas credit !", 7000, 'error') --Si vous avez DopeNotify
    end
end)



ESX.RegisterServerCallback('koko_beanmachine:lamoney', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getAccount('bank').money >= 100 then
		xPlayer.removeAccountMoney('bank', 100)
        TriggerClientEvent('dopeNotify2:Alert', source, "Bean", "Merci à bientot !", 7000, 'success')
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cafe', function(account)
			societyAccount = account
		end)
		if societyAccount ~= nil then
			societyAccount.addMoney(100)
		end
		cb(true)
    else
		TriggerClientEvent('dopeNotify2:Alert', source, "Bean", "La maison ne fait pas credit !", 7000, 'error')
		cb(false)
    end
end)

--Fin Machine a café




--------FARM
local PlayersHarvesting  = {}
local PlayersTransfo  = {}
local PlayersSelling  = {}

local function Harvest(source)
	SetTimeout(5000, function()
		if PlayersHarvesting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local grainedecafcaf = xPlayer.getInventoryItem('grainecafe').count
				xPlayer.addInventoryItem('grainecafe', 1)
				Harvest(source)
		end
	end)
end



--TRANSFO
local function Transfo(source)
	SetTimeout(5000, function()
		if PlayersTransfo[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local tabac = xPlayer.getInventoryItem('grainecafe').count
			local tabacsec = xPlayer.getInventoryItem('expresso').count

			if tabacsec > 50 then
				-- TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de tabac sec...')
				TriggerClientEvent('dopeNotify2:Alert', xPlayer.source, "", "Il semble que tu ne puisses plus porter d'expresso...", 3000, 'error')
			elseif tabac < 1 then
				TriggerClientEvent('dopeNotify2:Alert', xPlayer.source, "", "Pas assez de graine pour traiter...", 3000, 'error')
				-- TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de tabac pour traiter...')
			else
				xPlayer.removeInventoryItem('grainecafe', 1)
				xPlayer.addInventoryItem('expresso', 1)
			end
				Transfo(source)
		end
	end)
end
--FIN TRANSFO

RegisterServerEvent('koko_beanmachine:startHarvest')
AddEventHandler('koko_beanmachine:startHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = true
    TriggerClientEvent('dopeNotify2:Alert', _source, "", "Récolte de Graine de café", 3000, 'info') --Si vous utilisez dopeNotify2
	-- TriggerClientEvent('esx:showNotification', _source, "Récolte de glaçon") --Si vous utilisez esx_showNotification
	Harvest(source)
end)

RegisterServerEvent('koko_beanmachine:stopHarvest')
AddEventHandler('koko_beanmachine:stopHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = false
end)


-- TRANSFO
RegisterServerEvent('koko_beanmachine:starttransfo')
AddEventHandler('koko_beanmachine:starttransfo', function()
	local _source = source
	PlayersTransfo[_source] = true
    TriggerClientEvent('dopeNotify2:Alert', _source, "", "Préparation de café", 3000, 'info') --Si vous utilisez dopeNotify2
	-- TriggerClientEvent('esx:showNotification', _source, "Récolte de glaçon") --Si vous utilisez esx_showNotification
	Transfo(source)
end)

RegisterServerEvent('koko_beanmachine:stoptransfo')
AddEventHandler('koko_beanmachine:stoptransfo', function()
	local _source = source
	PlayersTransfo[_source] = false
end)
-- TRANSFO


local function Sell(source)
	SetTimeout(7500, function() 
	
		if PlayersSelling[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local societyAccount = nil

				if xPlayer.getInventoryItem('expresso').count <= 0 then
					TriggerClientEvent('esx:showNotification', source, "Tu n'as plus rien à vendre")
					return
				elseif xPlayer.getInventoryItem('expresso').count >= 1 then
					SetTimeout(1400, function()
						local money = 22
						xPlayer.removeInventoryItem('expresso', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cafe', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(140) --Argent société
							xPlayer.addMoney(140) --Argent Joueur
						end
						Sell(source)
					end)
				end
		end
	end)
end

RegisterServerEvent('koko_beanmachine:startVente')
AddEventHandler('koko_beanmachine:startVente', function()
	print ("DEBUG : START SELL")
	local _source = source
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source] = true
		TriggerClientEvent('dopeNotify2:Alert', _source, "", "Vente d'expresso", 3000, 'info')
		Sell(_source)
	end
end)

RegisterServerEvent('koko_beanmachine:stopVente')
AddEventHandler('koko_beanmachine:stopVente', function()
	local _source = source
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end
end)
--Fin farm



--Achat bar
RegisterNetEvent('koko_beanmachine:achatbar')
AddEventHandler('koko_beanmachine:achatbar', function(v, quantite)
    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil
    local playerMoney = xPlayer.getMoney()
    local playerlimite = xPlayer.getInventoryItem(v.item).count

    if playerlimite >= 10 then
        TriggerClientEvent('esx:showNotification', source, "Ton inventaire est plein!")

    else
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cafe', function(account)
        societyAccount = account
    end)
    if playerMoney >= v.prix * quantite then
        xPlayer.addInventoryItem(v.item, quantite)
        societyAccount.removeMoney(v.prix * quantite)

       TriggerClientEvent('esx:showNotification', source, "Tu as acheté ~g~x"..quantite.." ".. v.nom .."~s~ pour ~g~" .. v.prix * quantite.. "$")
    else
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de sous pour acheter ~g~"..quantite.." "..v.nom)
    end
    
end
    
end)