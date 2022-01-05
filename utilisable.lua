ESX.RegisterUsableItem('expresso', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('expresso', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_expresso'))
end)

ESX.RegisterUsableItem('lungo', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lungo', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_lungo'))
end)

ESX.RegisterUsableItem('caffelatte', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('caffelatte', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_caffelate'))
end)

ESX.RegisterUsableItem('icelatte', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('icelatte', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_icelatte'))
end)

ESX.RegisterUsableItem('macchiato', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('macchiato', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_macchiato'))
end)

ESX.RegisterUsableItem('macchiatocara', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('macchiatocara', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_macchiatocara'))
end)

ESX.RegisterUsableItem('cappuccino', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cappuccino', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_cappuccino'))
end)

ESX.RegisterUsableItem('cappuccinoice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cappuccinoice', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_cappuccinoice'))
end)

ESX.RegisterUsableItem('painchoco', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('painchoco', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_painchoco'))
end)

ESX.RegisterUsableItem('croissant', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('croissant', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_croissant'))
end)

ESX.RegisterUsableItem('torsadechoco', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('torsadechoco', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_torsadechoco'))
end)



--- ADD IN YOUR ESX_BACICNEEDS TRANSLATION FILE
--- A AJOUTER DANS VOTRE FICHIER TRADUCTION DU ESX_BASICNEEDS
['used_expresso'] = 'vous avez utilisé ~y~1x~s~ ~b~expresso~s~',
['used_lungo'] = 'vous avez utilisé ~y~1x~s~ ~b~lungo~s~',
['used_caffelate'] = 'vous avez utilisé ~y~1x~s~ ~b~Caffé Latte~s~',
['used_icelatte'] = 'vous avez utilisé ~y~1x~s~ ~b~Iced Latte~s~',
['used_macchiato'] = 'vous avez utilisé ~y~1x~s~ ~b~Macchiato~s~',
['used_macchiatocara'] = 'vous avez utilisé ~y~1x~s~ ~b~Caramel Macchiato~s~',
['used_cappuccino'] = 'vous avez utilisé ~y~1x~s~ ~b~Cappuccino~s~',
['used_cappuccinoice'] = 'vous avez utilisé ~y~1x~s~ ~b~Iced Cappuccino~s~',
['used_painchoco'] = 'vous avez utilisé ~y~1x~s~ ~b~Pain au chocolat~s~',
['used_croissant'] = 'vous avez utilisé ~y~1x~s~ ~b~Croissant~s~',
['used_torsadechoco'] = 'vous avez utilisé ~y~1x~s~ ~b~Torsade Chocolat~s~',

