local function validAction(text,func)
	frameActionValidBeforeStart = vgui.Create("DFrame")
	frameActionValidBeforeStart:SetSize(300,110)
	frameActionValidBeforeStart:Center()
	frameActionValidBeforeStart:SetDraggable(false)
	frameActionValidBeforeStart:SetSizable(false)
	frameActionValidBeforeStart:MakePopup() 
	frameActionValidBeforeStart:SetTitle("")
	frameActionValidBeforeStart:ShowCloseButton(false)
	frameActionValidBeforeStart.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Tiger.PrimaryColor)
		surface.SetDrawColor(color_black)
		surface.DrawOutlinedRect(0,0,w,h)
		draw.SimpleText(text,"TigerAS2_Context",w/2,5,Color(255,255,255),TEXT_ALIGN_CENTER)
	end

	validFrameAction = vgui.Create("DTextEntry",frameActionValidBeforeStart)
	validFrameAction:SetSize(frameActionValidBeforeStart:GetWide() - 10,30)
	validFrameAction:SetPos(5,40)

	local accept =  vgui.Create("DButton",frameActionValidBeforeStart)
	accept:SetPos(3,75)
	accept:SetSize(frameActionValidBeforeStart:GetWide() / 2 - 6,30)
	accept:SetText("")
	accept.Paint = function(s,w,h)
		if accept:IsHovered() then
			draw.RoundedBox(0,0,0,w,h,Tiger.SecondaryColor)
		else
			draw.RoundedBox(0,0,0,w,h,Tiger.PrimaryButtonColor)
		end
		draw.SimpleText("Valider","TigerAS1_Context",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
	accept.DoClick = func

	local deny =  vgui.Create("DButton",frameActionValidBeforeStart)
	deny:SetPos(frameActionValidBeforeStart:GetWide() / 2 + 3,75)
	deny:SetSize(frameActionValidBeforeStart:GetWide() / 2 - 6,30)
	deny:SetText("")
	deny.Paint = function(s,w,h)
		if deny:IsHovered() then
		draw.RoundedBox(0,0,0,w,h,Tiger.SecondaryColor)
		else
			draw.RoundedBox(0,0,0,w,h,Tiger.PrimaryButtonColor)
		end
		draw.SimpleText("Annuler","TigerAS1_Context",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
	deny.DoClick = func
	deny.DoClick = function() frameActionValidBeforeStart:Close() end
end


hook.Add("OnContextMenuOpen","CustomContextMenuHookOpen",function()
	gui.EnableScreenClicker(true)
	sFrameContextMenu = vgui.Create("DFrame")
	sFrameContextMenu:ShowCloseButton(false)
	sFrameContextMenu:SetDraggable(false)
	sFrameContextMenu:SetSizable(false)
	sFrameContextMenu:SetTitle("")
	sFrameContextMenu:SetSize(ScrW() * 0.20,ScrH())
	sFrameContextMenu:SetPos(ScrW() - sFrameContextMenu:GetWide(),0)
	sFrameContextMenu.Paint = function(s,w,h)
		-- BASE
		draw.RoundedBox(0,0,0,w,h,Tiger.PrimaryColor)
		draw.RoundedBox(0,0,0,w,ScrH() * 0.037,Tiger.SecondaryColor)
		surface.SetDrawColor(color_black)
		surface.DrawOutlinedRect(0,0,w,h)
		draw.SimpleText(Tiger.ContextMenu_Name,"TigerAS2_Context",w/2,ScrH() * 0.005,color_white,TEXT_ALIGN_CENTER)
		
		-- SEPARATEUR
		
		-- SEPARATEUR Admin
		if Tiger.StaffGroups[ LocalPlayer():GetUserGroup() ] then
			draw.RoundedBox(0,0,ScrH() * 0.26,w,ScrH() * 0.010,Tiger.SecondaryColor)
		end

		-- Lien
		draw.RoundedBox(0,0,ScrH() * 0.59,ScrW() * 0.26,ScrH() * 0.035,Tiger.SecondaryColor)
		draw.SimpleText("- Lien Utile -","TigerAS2_Context",w/2,ScrH() * 0.6060,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		
		-- Titre Magasin
		draw.RoundedBox(0,0,ScrH() * 0.71,ScrW() * 0.26,ScrH() * 0.035,Tiger.SecondaryColor)
		draw.SimpleText("- Magasin -","TigerAS2_Context",w/2,ScrH() * 0.7255,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)		

	end

	local function actionButton(px,py,sx,sy,color,text,font,action)
		local actionButtonButton = vgui.Create("DButton",sFrameContextMenu)
		actionButtonButton:SetPos(px,py)
		actionButtonButton:SetSize(sx,sy)
		actionButtonButton:SetText("")
		actionButtonButton.Paint = function(s,w,h)
			if actionButtonButton:IsHovered() then
				draw.RoundedBox(0,0,0,w,h,Tiger.SecondaryColor)
			else
				draw.RoundedBox(0,0,0,w,h,color)
			end
			draw.SimpleText(text,font,w/2,h/2,Tiger.TextButtonColor,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		actionButtonButton.DoClick = action

	end

	--Bordure / de 30 en 30 / longeur / largeur
	actionButton(ScrW() * 0.005,ScrH() * 0.045,ScrW() * 0.19,ScrH() * 0.025,Tiger.PrimaryButtonColor,"Jeter l'arme actuelle","TigerAS1_Context",function() LocalPlayer():ConCommand("say /dropweapon") end)
	actionButton(ScrW() * 0.005,ScrH() * 0.075,ScrW() * 0.19,ScrH() * 0.025,Tiger.PrimaryButtonColor,"Ecrire une lettre","TigerAS1_Context",function() validAction("Ecrire une lettre",function() LocalPlayer():ConCommand("say /write " .. validFrameAction:GetText()) frameActionValidBeforeStart:Close() end) end)
	actionButton(ScrW() * 0.005,ScrH() * 0.105,ScrW() * 0.19,ScrH() * 0.025,Tiger.PrimaryButtonColor,"Vendre toutes mes portes","TigerAS1_Context",function() LocalPlayer():ConCommand("darkrp unownalldoors") end)
	actionButton(ScrW() * 0.005,ScrH() * 0.135,ScrW() * 0.19,ScrH() * 0.025,Tiger.PrimaryButtonColor,"Demander une licence d'arme","TigerAS1_Context",function() LocalPlayer():ConCommand("darkrp requestlicense") end)
	actionButton(ScrW() * 0.005,ScrH() * 0.165,ScrW() * 0.19,ScrH() * 0.025,Tiger.PrimaryButtonColor,"Vue troisième personne","TigerAS1_Context",function() LocalPlayer():ConCommand("simple_thirdperson_enable_toggle") end)
	actionButton(ScrW() * 0.005,ScrH() * 0.195,ScrW() * 0.19,ScrH() * 0.025,Tiger.PrimaryButtonColor,"Résoudre les bugs de son","TigerAS1_Context",function() LocalPlayer():ConCommand("stopsound") end)
	
	--Admin
	actionButton(ScrW() * 0.005,ScrH() * 0.225,ScrW() * 0.19,ScrH() * 0.025,Tiger.AdminButtonColor,"Faire un Ticket Admin","TigerAS1_Context",function() validAction("Ticket Admin",function() RunConsoleCommand("say", "@ " .. validFrameAction:GetText()) frameActionValidBeforeStart:Close() end) end)
	
    if Tiger.StaffGroups[ LocalPlayer():GetUserGroup() ] then
		
		--Mode Admin
		actionButton(ScrW() * 0.005,ScrH() * 0.275,ScrW() * 0.19,ScrH() * 0.025,Tiger.AdminButtonColor,"Mode Admin","TigerAS1_Context",function() LocalPlayer():ConCommand("") end)
		-- On/Off
		actionButton(ScrW() * 0.005,ScrH() * 0.305,ScrW() * 0.092,ScrH() * 0.025,Tiger.AdminButtonColor,"On","TigerAS1_Context",function() LocalPlayer():ConCommand([[ulx administrate "]]..ply:SteamID()..[["]]) end)
		actionButton(ScrW() * 0.102,ScrH() * 0.305,ScrW() * 0.092,ScrH() * 0.025,Tiger.AdminButtonColor,"Off","TigerAS1_Context",function() LocalPlayer():ConCommand([[ulx unadministrate "]]..ply:SteamID()..[["]]) end)
		
		--Warn
		actionButton(ScrW() * 0.005,ScrH() * 0.335,ScrW() * 0.19,ScrH() * 0.025,Tiger.AdminButtonColor,"Warn","TigerAS1_Context",function() LocalPlayer():ConCommand("awarn_menu") end)
		
		--Logs
		actionButton(ScrW() * 0.005,ScrH() * 0.365,ScrW() * 0.19,ScrH() * 0.025,Tiger.AdminButtonColor,"Logs","TigerAS1_Context",function() LocalPlayer():ConCommand("blogs") end)
    end
	
	--URL
	actionButton(ScrW() * 0.005,ScrH() * 0.635,ScrW() * 0.093,ScrH() * 0.03,Tiger.PrimaryButtonColor,"SITE","TigerAS1_Context",function() gui.OpenURL("http://crossrp.mtxserv.fr") end)
	actionButton(ScrW() * 0.103,ScrH() * 0.635,ScrW() * 0.093,ScrH() * 0.03,Tiger.PrimaryButtonColor,"WORKSHOP","TigerAS1_Context",function() gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=1442983547") end)
	actionButton(ScrW() * 0.005,ScrH() * 0.670,ScrW() * 0.093,ScrH() * 0.03,Tiger.PrimaryButtonColor,"GROUPE STEAM","TigerAS1_Context",function() gui.OpenURL("https://steamcommunity.com/groups/crossrp") end)
	actionButton(ScrW() * 0.103,ScrH() * 0.670,ScrW() * 0.093,ScrH() * 0.03,Tiger.PrimaryButtonColor,"BOUTIQUE","TigerAS1_Context",function() gui.OpenURL("http://boutique-crossrp.mtxserv.fr/") end)

	local MagasinMenu = vgui.Create( "DPanelList", sFrameContextMenu )
	MagasinMenu:SetPos( ScrW() * 0.005,ScrH() * 0.755 )
	MagasinMenu:SetSize( ScrW() * 0.19,ScrH() * 0.24 )
	MagasinMenu:SetSpacing( 2 ) 
	MagasinMenu:EnableHorizontal( false )
	MagasinMenu:EnableVerticalScrollbar( true )
	--MagasinMenu.Paint = function(s,w,h) draw.RoundedBox(0,0,0,w,h,Color(255,0,0)) end

	local sbar = MagasinMenu.VBar
	function sbar:Paint( w, h )
		draw.RoundedBox(0,0,0,w,h,Tiger.SecondaryColor)
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h,Tiger.SecondaryColor)
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h,Tiger.SecondaryColor)
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h,Tiger.PrimaryButtonColor)
	end


	for k, v in pairs(DarkRPEntities) do
		local ShowThisItem = true
		if istable(v.allowed) and not table.HasValue( v.allowed, LocalPlayer():Team() ) then ShowThisItem = false end
		if ShowThisItem then
			local maPanel = vgui.Create("DPanel",MagasinMenu)
			maPanel:SetSize(MagasinMenu:GetWide() / 2 - 2,ScrH() * 0.07)
			maPanel.Paint = function(s,w,h)
				draw.RoundedBox(0,0,0,w,h,Tiger.PrimaryButtonColor)
				draw.RoundedBox(0,0,0,ScrW() * 0.033,ScrW() * 0.035,Tiger.PrimaryButtonColor)
				draw.SimpleText(v.name,"TigerAS1_Context",ScrW() * 0.038,ScrH() * 0.005,Color(255,255,255))
				draw.SimpleText("Prix: " .. v.price .. "$","TigerAS1_Context",ScrW() * 0.038,ScrH() * 0.020,Color(255,255,255))
			end

			local model = vgui.Create("SpawnIcon",maPanel)
			model:SetSize(ScrW() * 0.033,ScrW() * 0.033)
			model:SetPos(3,5)
			model:SetModel(v.model)

			local buy = vgui.Create("DButton",maPanel)
			buy:SetSize(ScrW() * 0.06,ScrH()* 0.023) 
			buy:SetPos(ScrW() * 0.038,ScrH()*0.043)
			buy:SetText("Acheter")
			buy:SetTextColor(color_white)
			buy.Paint = function(s,w,h) 
				if buy:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(100, 100, 100))
		else
			draw.RoundedBox(0,0,0,w,h,Tiger.SecondaryColor)
				end
			end
			buy.DoClick = function() LocalPlayer():ConCommand("darkrp " .. v.cmd) end

			MagasinMenu:AddItem(maPanel)
		end
	end

	return ""
end)

hook.Add("OnContextMenuClose","CustomContextMenuHookClose",function()
	gui.EnableScreenClicker(false)
	if IsValid(sFrameContextMenu) then sFrameContextMenu:Close() end
end)