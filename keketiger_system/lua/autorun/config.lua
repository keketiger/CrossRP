if not Tiger then Tiger = {} end

-- Background
Tiger.PrimaryColor = Color(255, 255, 255, 20)
-- Header
Tiger.SecondaryColor = Color(40, 40, 40, 255)
-- Button
Tiger.PrimaryButtonColor = Color(188, 0, 0, 255)
-- Button Background
Tiger.SecondaryButtonColor = Color(0, 0, 0, 200)
-- Button Text
Tiger.TextButtonColor = color_white
-- Button Off
Tiger.TextButtonColorOnDisable = Color(255, 255, 255, 150)

-- Server Name
Tiger.ServerName = "CrossRP - V2"

-- Admin
Tiger.StaffGroups = {
    [ 'superadmin' ] = true,
    [ 'admin' ] = true,
    [ 'moderateur' ] = true,
	[ 'developer' ] = true
}

--[[-------------------------------------------------------------------------
Context Menu
---------------------------------------------------------------------------]]

Tiger.ContextMenu_Name = "- Menu Personnel -"
Tiger.AdminButtonColor = Color( 122, 0, 0, 255 )
Tiger.VIPButtonColor = Color( 228, 201, 67, 255 )

--[[-------------------------------------------------------------------------
Scoreboard
---------------------------------------------------------------------------]]

Tiger.Scoreboard_Groups = {
	[ 'superadmin' ] = {name = 'Super Admin', color = Color( 199, 44, 44 )},
    [ 'developer' ] = {name = 'Developer', color = Color( 199, 44, 44 )},
    [ 'admin' ] = {name = 'Administrateur', color = Color( 241, 196, 15 )},
    [ 'moderateur' ] = {name = 'Modérateur', color = Color( 52, 152, 219 )},
    [ 'donator' ] = {name = 'Donateur', color = Color( 155, 89, 182 )},
    [ 'vip' ] = {name = 'VIP', color = Color( 155, 89, 182 )}
}

--[[-------------------------------------------------------------------------
Panneau publicitaire
---------------------------------------------------------------------------]]
Tiger.SetDisableButton = {}
Tiger.MainTextButton = {}
Tiger.MainTextWritingBoard = {}
Tiger.AdvertPrice = {}
Tiger.TimerDelay = {}
Tiger.TimerRepetition = {}

Tiger.SetDisableButton[1] = false
Tiger.SetDisableButton[2] = false
Tiger.SetDisableButton[3] = false

Tiger.MainTextButton[1] = "Faire une simple publicite"
Tiger.MainTextButton[2] = "Faire une publicite repetitive"
Tiger.MainTextButton[3] = "Faire une annonce anonyme"

Tiger.MainTextWritingBoard[1] = "Annonce simple - Panneau publicitaire"
Tiger.MainTextWritingBoard[2] = "Annonce repetitive - Panneau publicitaire"
Tiger.MainTextWritingBoard[3] = "Annonce anonyme - Peanneau publicitaire"

Tiger.AdvertPrice[1] = 25
Tiger.AdvertPrice[2] = 55
Tiger.AdvertPrice[3] = 80

Tiger.TimerDelay[1] = 30
Tiger.TimerDelay[2] = 30

Tiger.TimerRepetition[1] = 5
Tiger.TimerRepetition[2] = 5

Tiger.AdvertText = "Publicite"
Tiger.MainText = "Annonces publicitaires"
Tiger.Confirm = "Confirmer"
Tiger.SuccesNotifyPurchase = "Vous avez achete une annonce pour"
Tiger.FailNotifyPurchase = "Vous devez ecrire un texte pour votre annonce"
Tiger.Anonymous = "Anonyme"


--[[-------------------------------------------------------------------------
Job NPC
---------------------------------------------------------------------------]]
Tiger.JNPC = {}
Tiger.JNPC.CreateNPC = {}

Tiger.JNPC.CreateNPC[1] = {
	name = "",
	color = Color(255, 50, 0, 255),
	title = "Civil",
	model = "models/kleiner.mdl",
	pos = Vector(-553, -56, 112),
	angle = Angle(0, 0, 0),
	jobs = {"TEAM_CITIZEN", "TEAM_MAYOR", "TEAM_COOK", "TEAM_POLICE", "TEAM_GANG", "TEAM_MOB", "TEAM_GUN", "TEAM_BANQUIER"},
}
Tiger.JNPC.CreateNPC[2] = {
	name = "",
	color = Color(255, 255, 255, 255),
	title = "Government ",
	model = "models/gman_high.mdl",
	pos = Vector(-594, -149, 112),
	angle = Angle(0, 0, 0),
	jobs = {"TEAM_POLICE", "TEAM_PERSONNEL"},
}