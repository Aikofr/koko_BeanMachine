cafe = {}
Config = {}
Config.Locale = 'fr' -- Language


--marker
cafe.DrawDistance = 100
cafe.Size         = {x = 1.0, y = 1.0, z = 1.0}
cafe.Color        = {r = 255, g = 155, b = 0}
cafe.Type         = 31



--Achat bar
cafe.baritem = {
	{nom = "Lungo", prix = 8, item = "lungo"},
	{nom = "Caffé Latte", prix = 12, item = "caffelatte"},
	{nom = "Iced Latte", prix = 15, item = "icelatte"},
	{nom = "Macchiato", prix = 12, item = "macchiato"},
	{nom = "Caramel Macchiato", prix = 15, item = "macchiatocara"},
	{nom = "Cappuccino", prix = 12, item = "cappuccino"},
	{nom = "Iced Cappuccino", prix = 15, item = "cappuccinoice"},
	{nom = "Croissant", prix = 10, item = "croissant"},
	{nom = "Pain au chocolat", prix = 10, item = "painchoco"},
	{nom = "Torsade Chocolat", prix = 10, item = "torsadechoco"},
}



--position des menus et marker
cafe.pos = {
	vestiaire = {
		position = {x = -634.54, y = 225.9, z = 81.88} --Position du vestiaire
	},

	bar = {
		position = {x = -635.03, y = 235.25, z = 81.88}
	},

	garage = {
		position = {x = -607.27, y = 187.68, z = 69.96}
	},

	spawnvoiture = {
		position = {x = -617.64, y = 187.42, z = 69.27, h = 94.54}
	},

	boss = {
		position = {x = -631.6, y = 228.00, z = 81.88} --Position de l'action patron + coffre
	}
}



--FARM
Config.FarmZones = {
	Recolte = { 
		Pos   = { x = 2142.43, y = 5166.68, z = 54.05}, --Changer point récolte
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 255, g = 155, b = 0 },
		Type  = 39
	},
	Transformation = {
		Pos   = { x = -630.19, y = 223.58, z = 81.88}, --Changer point transfo
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 155, b = 0 },
		Type  = 24
	},
	Vente = {
		Pos   = {x = -687.22, y = -854.62, z = 23.88}, --Changer point de vente
		Size  = {x = 2.0, y = 2.0, z = 2.0},
		Color = {r = 255, g = 155, b = 0},
		Type  = 29
	},
}



--Blips sur la map
Config.Map = {
	{name="Garage",color=21, id=823, x = -607.27, y = 187.68, z = 69.96}, --Blips map de transfo
	{name="Récolte de Graine de cafe",color=21, id=85, x = 2142.43, y = 5166.68, z = 54.05}, --Blips map de récolte
	{name="Transformation des graines",color=21, id=85, x = -630.19, y = 223.58, z = 81.88}, --Blips map de transfo
	{name="Vente d'expresso",color=21, id=85, x = -687.22, y = -854.62, z = 23.88}, --Blips map de vente
}

Config.DrawDistance               = 20.0 -- How close you need to be in order for the markers to be drawn (in GTA units).