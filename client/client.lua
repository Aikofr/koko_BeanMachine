ESX = nil --Appel fonction ESX base

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    blips()
	RefreshcafeMoney()
end)
--Fin



-- Ajout du blips
Citizen.CreateThread(function()
    local cafe = AddBlipForCoord(-632.55, 239.92, 81.88) -- Modifié coordoonée ici
    SetBlipSprite(cafe, 93) --Changer le type de blips
    SetBlipColour(cafe, 21) --Changer la couleur du blips
    SetBlipScale(cafe, 0.7) --Changer la taille du blips
    SetBlipAsShortRange(cafe, true) --false = ne s'affiche que si vous etes à coté
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("BeanMachine") --Changer le nom du blips
    EndTextCommandSetBlipName(cafe)
end)
--fin blips




-- check du setjob - Ajout des markers / blips
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(cafe.pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then 
            if (cafe.Type ~= -1 and GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < cafe.DrawDistance) then
                DrawMarker(cafe.Type, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, cafe.Size.x, cafe.Size.y, cafe.Size.z, cafe.Color.r, cafe.Color.g, cafe.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end
        end
        if letSleep then
            Citizen.Wait(500)
        end
end
end)
--Fin




-- bar cafe
RMenu.Add('barcafe', 'main', RageUI.CreateMenu("Bar", "Pour la consommation des clients"))
Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('barcafe', 'main'), true, true, true, function()    
         
        for k, v in pairs(cafe.baritem) do
            RageUI.Button(v.nom.." ~r~$"..v.prix.."/u", nil, {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                if (Selected) then  
                local quantite = 1    
                local item = v.item
                local prix = v.prix
                local nom = v.nom    
                TriggerServerEvent('koko_beanmachine:achatbar', v, quantite)
            end
            end)
        end
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, cafe.pos.bar.position.x, cafe.pos.bar.position.y, cafe.pos.bar.position.z)
        if jobdist <= 1.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then  
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au comptoir")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('barcafe', 'main'), not RageUI.Visible(RMenu:Get('barcafe', 'main')))
                end   
            end
            end 
    end
end)
--Fin Bar




-------garage
RMenu.Add('garagecafe', 'main', RageUI.CreateMenu("Garage", "Pour sortir la voiture."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garagecafe', 'main'), true, true, true, function() 
            RageUI.Button("Ranger voiture", "Pour ranger une voiture.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 4 then
                ESX.ShowAdvancedNotification("Koda la garagiste", "La voiture est de retour merci!", "", "CHAR_BIKESITE", 1)
                DeleteEntity(veh)
            end
            end
            end)
            RageUI.Button("Van", "Pour sortir un van.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected) --Changer le titre ici
            if (Selected) then
            ESX.ShowAdvancedNotification("Koda la garagiste", "La voiture arrive dans quelques instant..", "", "CHAR_BIKESITE", 1)
            Citizen.Wait(2000)
            spawnuniCar("speedo4") --Changer le véhicule ici
            ESX.ShowAdvancedNotification("Koda la garagiste", "Abime pas la voiture grosse folle !", "", "CHAR_BIKESITE", 1)
            end
            end)
            RageUI.Button("Baller", "Pour sortir un Baller.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected) -- Changer le titre ici
                if (Selected) then
                ESX.ShowAdvancedNotification("Koda la garagiste", "La voiture arrive dans quelques instant..", "", "CHAR_BIKESITE", 1)
                Citizen.Wait(2000)
                spawnuniCar("baller") --Changer le véhicule ici
                ESX.ShowAdvancedNotification("Koda la garagiste", "Abime pas la voiture grosse folle !", "", "CHAR_BIKESITE", 1)
                end
            end)

        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, cafe.pos.garage.position.x, cafe.pos.garage.position.y, cafe.pos.garage.position.z)
        if dist3 <= 3.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then    
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                if IsControlJustPressed(1,51) then           
                    RageUI.Visible(RMenu:Get('garagecafe', 'main'), not RageUI.Visible(RMenu:Get('garagecafe', 'main')))
                end
            end
            end
    end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, cafe.pos.spawnvoiture.position.x, cafe.pos.spawnvoiture.position.y, cafe.pos.spawnvoiture.position.z, cafe.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "cafe"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end




--vestiaire
RMenu.Add('vestiairecafe', 'main3', RageUI.CreateMenu("Vestiaire", "Pour vous changer"))
Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('vestiairecafe', 'main3'), true, true, true, function()
            RageUI.Button("Tenue civile", "Pour prendre votre tenue civile.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            -- ESX.ShowNotification('Vous avez repris votre ~b~tenue civile') --Si vous avez ESX_ShowNotification
            exports['dopeNotify2']:Alert("", 'Vous avez repris votre tenue civile', 3000, 'success') --Si vous avez dopeNotify2
            end)
            end
            end)
            
            RageUI.Button("Tenue de travail", "Pour prendre votre tenue de barista.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            if skin.sex == 0 then
                clothesSkin = { -- Tenue barista homme
                            ['tshirt_1'] = 7,  ['tshirt_2'] = 2,
                            ['torso_1'] = 11,   ['torso_2'] = 7,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 11,
                            ['pants_1'] = 56,   ['pants_2'] = 0,
                            ['shoes_1'] = 55,   ['shoes_2'] = 7
                        }
            else
                clothesSkin = { -- Tenue barista femme
                            ['tshirt_1'] = 29,   ['tshirt_2'] = 4,
                            ['torso_1'] = 7,    ['torso_2'] = 10,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 6,
                            ['pants_1'] = 79,   ['pants_2'] = 0,
                            ['shoes_1'] = 77,    ['shoes_2'] = 4
                        }
            end
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            -- ESX.ShowNotification('Vous avez équipé votre ~b~tenue de barista') --Si vous n'avez pas de script notif
            exports['dopeNotify2']:Alert("", 'Vous avez équipé votre tenue de barista', 3000, 'success') --Si vous avez dopeNotify2
            end)

            end
            end)

            RageUI.Button("Tenue de directeur/trice", "Pour prendre votre tenue de directeur/trice.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                if (Selected) then   

                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    clothesSkin = { --Tenue patron homme
                                ['tshirt_1'] = 23,  ['tshirt_2'] = 4,
                                ['torso_1'] = 159,   ['torso_2'] = 2,
                                ['decals_1'] = 0,   ['decals_2'] = 0,
                                ['arms'] = 8,
                                ['pants_1'] = 3,   ['pants_2'] = 8,
                                ['shoes_1'] = 55,   ['shoes_2'] = 2,
                                ['chain_1'] = -1,  ['chain_2'] = 0
                            }
                else
                    clothesSkin = { --Tenue patron femme
                                ['tshirt_1'] = 29,   ['tshirt_2'] = 4,
                                ['torso_1'] = 7,   ['torso_2'] = 10,
                                ['decals_1'] = 0,   ['decals_2'] = 0,
                                ['arms'] = 6,
                                ['pants_1'] = 79,   ['pants_2'] = 0,
                                ['shoes_1'] = 77,   ['shoes_2'] = 4,
                                ['chain_1'] = -1,   ['chain_2'] = 1
                            }
                end
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                -- ESX.ShowNotification('Vous avez équipé votre ~b~tenue de danseur') --Si vous n'avez pas de script notif
                exports['dopeNotify2']:Alert("", 'Vous avez équipé votre tenue de danseur', 3000, 'success') --Si vous avez dopeNotify2
                end)
                end
                end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycafejob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycafejob.x, plycafejob.y, plycafejob.z, cafe.pos.vestiaire.position.x, cafe.pos.vestiaire.position.y, cafe.pos.vestiaire.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then --Changer la touche : default 'E'
                        RageUI.Visible(RMenu:Get('vestiairecafe', 'main3'), not RageUI.Visible(RMenu:Get('vestiairecafe', 'main3')))
                    end   
                end
               end 
        end
end)

--Fin du vestiaire




--menu f6
local societycafemoney = nil
RMenu.Add('cafef6', 'main4', RageUI.CreateMenu("Menu cafe", "Menu Cafe"))
RMenu.Add('cafef6', 'patron', RageUI.CreateSubMenu(RMenu:Get('cafef6', 'main4'), "Option patron", "Option disponible pour le patron"))

Citizen.CreateThread(function()
    while true do
    	

        RageUI.IsVisible(RMenu:Get('cafef6', 'main4'), true, true, true, function()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' and ESX.PlayerData.job.grade_name == 'boss' then
        RageUI.Button("Option patron", "Option disponible pour le patron", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('cafef6', 'patron'))
        end

        RageUI.Button("Annonce ouvert", "Pour annoncer aux gens que le cafe est ouvert", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('koko_beanmachine:annonceopen')
            end
            end)
        RageUI.Button("Annonce Fermé", "Pour annoncer aux gens que le cafe est fermé", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('koko_beanmachine:annoncefermer')
            end
            end)
            end, function()
        end)
        RageUI.IsVisible(RMenu:Get('cafef6', 'patron'), true, true, true, function()
            if societycafemoney ~= nil then
            RageUI.Button("Montant disponible dans la société :", nil, {RightLabel = "$" .. societycafemoney}, true, function()
            end)
        end
        RageUI.Button("Message aux cafe", "Pour écrire un message aux employés", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local info = 'patron'
                local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
				TriggerServerEvent('koko_beanmachine:patronmess', info, message)
            end
            end)
        RageUI.Button("Annonce recrutement", "Pour annoncer des recrutements au cafe", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
				TriggerServerEvent('koko_beanmachine:annoncerecrutement')
            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then  
                if IsControlJustPressed(1,167) then
                    RageUI.Visible(RMenu:Get('cafef6', 'main4'), not RageUI.Visible(RMenu:Get('cafef6', 'main4')))
                    RefreshcafeMoney()
                end   
            end 
    end
end)

RegisterNetEvent('koko_beanmachine:infoservice')
AddEventHandler('koko_beanmachine:infoservice', function(service, nom, message)
	if service == 'patron' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('INFO cafe', '~b~A lire', 'Patron: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_FLOYD', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)

function RefreshcafeMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietycafeMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietycafeMoney(money)
    societycafemoney = ESX.Math.GroupDigits(money)
end

--Fin du menu F6




--bureau boss + coffre
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plycrdboss = GetEntityCoords(GetPlayerPed(-1), false)
            local bossdist = Vdist(plycrdboss.x, plycrdboss.y, plycrdboss.z, cafe.pos.boss.position.x, cafe.pos.boss.position.y, cafe.pos.boss.position.z)
        if bossdist <= 1.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then	
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la gestion d'entreprise")
                if IsControlJustPressed(1,51) then --Changer la touche : default 'E'
                    OpenBossActionscafeMenu()
                end   
            end
           end 
    end
end)

function OpenBossActionscafeMenu()
ESX.UI.Menu.CloseAll()

ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cafe',{
    title    = 'Action patron cafe',
    align    = 'top-left',
    elements = {
        {label = 'Gestion employées', value = 'boss_cafeactions'},
        {label = 'Déposer du Stock', value = 'put_stock'},
        {label = 'Prendre du Stock', value = 'get_stock'}
}}, function (data, menu)

        if data.current.value == 'put_stock' then
            OpenPutStocksMenu()
        end

        if data.current.value == 'get_stock' then
            OpenGetStocksMenu()
        end

    if data.current.value == 'boss_cafeactions' and ESX.PlayerData.job.name == 'cafe' and ESX.PlayerData.job.grade_name == 'boss' then
        TriggerEvent('esx_society:openBossMenu', 'cafe', function(data, menu)
            menu.close()
        end)
    end
end, function (data, menu)
    menu.close()

end)
end

function OpenGetStocksMenu()

ESX.TriggerServerCallback('koko_beanmachine:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do
        if (items[i].count ~= 0) then
            table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            title    = 'cafe Stock',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)

            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                    title = _U('quantity')
                }, function(data2, menu2)

                    local count = tonumber(data2.value)

                    if count == nil or count <= 0 then
                        ESX.ShowNotification(_U('quantity_invalid'))
                    else
                        menu2.close()
                        menu.close()
                        OpenGetStocksMenu()

                        TriggerServerEvent('koko_beanmachine:getStockItem', itemName, count)
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
        end, function(data, menu)
            menu.close()
        end)
end)
end

function OpenPutStocksMenu()

ESX.TriggerServerCallback('koko_beanmachine:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

        local item = inventory.items[i]

        if item.count > 0 then
            table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            title    = 'cafe Stock',
            elements = elements
        }, function(data, menu)

            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                    title = _U('quantity')
                }, function(data2, menu2)

                    local count = tonumber(data2.value)

                    if count == nil or count <= 0 then
                        ESX.ShowNotification(_U('quantity_invalid'))
                    else
                        menu2.close()
                        menu.close()
                        OpenPutStocksMenu()

                        TriggerServerEvent('koko_beanmachine:putStockItems', itemName, count)
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
        end, function(data, menu)
            menu.close()
        end)
end)
end
-------fin bureau boss




-- Machine a café
local waterCoolers = {690372739}
local IsAnimated = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if not IsAnimated then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)

            for i = 1, #waterCoolers do
                local watercooler = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, waterCoolers[i], false, false, false)
                local waterCoolerPos = GetEntityCoords(watercooler)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, waterCoolerPos.x, waterCoolerPos.y, waterCoolerPos.z, true)

                if dist < 1.8 then
                    local loc = vector3(waterCoolerPos.x, waterCoolerPos.y, waterCoolerPos.z + 1.0)

                    ESX.Game.Utils.DrawText3D(loc, 'Presse [~y~G~w~] pour boire un café.', 0.7) --Changer le text 3d ici
                    if IsControlJustReleased(0, 58) then --Changer la touche ici

                        ESX.TriggerServerCallback("esx_tgo_watercoolers:lamoney",  function(cb)
                            if cb then 
                                if not IsAnimated then
                                    prop_name = prop_name or 'prop_food_coffee'
                                    IsAnimated = true

                                    TriggerServerEvent('esx_tgo_watercoolers:refillThirst')

                                    Citizen.CreateThread(function()
                                        local playerPed = PlayerPedId()
                                        local x,y,z = table.unpack(GetEntityCoords(playerPed))
                                        local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
                                        local boneIndex = GetPedBoneIndex(playerPed, 18905)
                                        AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

                                        ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
                                            TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
                                            Citizen.Wait(3000)
                                            IsAnimated = false
                                            ClearPedSecondaryTask(playerPed)
                                            DeleteObject(prop)
                                        end)
                                    end)
                                end
                            end
                        end)
                    end
                else
                    Citizen.Wait(1500)
                end
            end
        end
    end
end)
-- Fin Machine a café




------Farm
local enrecolte = false
local entransfo = false
local envente = false

AddEventHandler('koko_beanmachine:hasEnteredMarker', function(zone)
	if zone == 'Recolte' then
		CurrentAction     = 'cafe_actions_menu'
		CurrentActionMsg  = "Appuyez sur [E] pour ouvrir le menu"
		CurrentActionData = {}
    end
    if zone == 'Transformation' then
		CurrentAction     = 'cafe_transfo_menu'
		CurrentActionMsg  = "Appuyez sur [E] pour ouvrir le menu"
		CurrentActionData = {}
    end
    if zone == 'Vente' then
		CurrentAction     = 'cafe_vente_menu'
		CurrentActionMsg  = "Appuyez sur [E] pour ouvrir le menu"
		CurrentActionData = {}
    end
end)

AddEventHandler('koko_beanmachine:hasExitedMarker', function(zone)
	
	if zone == 'Recolte' then
		TriggerServerEvent('koko_beanmachine:stopHarvest')	
        enrecolte = false
	end
    if zone == 'Transformation' then
		TriggerServerEvent('koko_beanmachine:stoptransfo')	
        entransfo = false
	end
    if zone == 'Vente' then
		TriggerServerEvent('koko_beanmachine:stopVente')
		envente = false
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then
				if CurrentAction == 'cafe_actions_menu' then
					OpenRecolteMenu()
                end
                if CurrentAction == 'cafe_transfo_menu' then
					OpenTransfoMenu()
                end
                if CurrentAction == 'cafe_vente_menu' then
					OpenVenteMenu()
                end
            end					
		end

	end
end)


function OpenRecolteMenu()  ----Menu récolte
		local elements = {
			{label = "Graine de café", value = 'grainecafe'}
		}
		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recolte', {
			title    = _U('harvest'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'grainecafe' then
                if enrecolte == true then
					exports['dopeNotify2']:Alert("", "Bien tenté", 3000, 'error') 
				else
					enrecolte = true
					TriggerServerEvent('koko_beanmachine:startHarvest')
				end
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'recolte'
			CurrentActionMsg  = "Menu de Récolte"
			CurrentActionData = {}
		end)
end


function OpenTransfoMenu()  ----Menu Transfo
    local elements = {
        {label = "élaboration d'expresso", value = 'cafemoulu'}
    }
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'transfo', {
        title    = 'Cuisine',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        menu.close()

        if data.current.value == 'cafemoulu' then
            if entransfo == true then
                exports['dopeNotify2']:Alert("", "Bien tenté", 3000, 'error') 
            else
                entransfo = true
                TriggerServerEvent('koko_beanmachine:starttransfo')
            end
        end
    end, function(data, menu)
        menu.close()
        CurrentAction     = 'transfo'
        CurrentActionMsg  = "Menu de Transformation"
        CurrentActionData = {}
    end)
end


function OpenVenteMenu()
    local elements = {
        {label = "Vente d'espresso", value = 'ventecafe'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vente', {
        title    = "Menu Vente",
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        menu.close()

        if data.current.value == 'ventecafe' then
            if envente == true then
                exports['dopeNotify2']:Alert("", "Bien tenté", 3000, 'error')
            else
                envente = true
                TriggerServerEvent('koko_beanmachine:startVente')
            end
        end
    end, function(data, menu)
        menu.close()
        CurrentAction     = 'vente'
        CurrentActionMsg  = "Menu Vente"
        CurrentActionData = {}
    end)
end


function blips()
	for i=1, #Config.Map, 1 do
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cafe' then
			local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
			SetBlipSprite (blip, Config.Map[i].id)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.7)
			SetBlipColour (blip, Config.Map[i].color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Map[i].name)
			EndTextCommandSetBlipName(blip)
		end
	end
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.FarmZones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cafe' then
            for i=1, #Config.Map, 1 do
                local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
                SetBlipSprite (blip, Config.Map[i].id)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.7)
                SetBlipColour (blip, Config.Map[i].color)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Config.Map[i].name)
                EndTextCommandSetBlipName(blip)
            end
            break
        end
    end
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cafe' then

			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker = false
			local currentZone = nil

			for k,v in pairs(Config.FarmZones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone

				TriggerEvent('koko_beanmachine:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
                print ("DEBUG : Sortie de ZONE")
				TriggerEvent('koko_beanmachine:hasExitedMarker', LastZone)
			end

		end
	end
end)
