include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

local function OpenMenu()
	local ply = LocalPlayer()

	local frame = vgui.Create("DFrame")
	frame:SetSize(500, 600)
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:Center()
	frame:MakePopup()
	frame.Paint = function(self)
		Derma_DrawBackgroundBlur(self, 1)
		draw.RoundedBox(0, 0, 0, 1100, 27.5, Tiger.SecondaryColor)
		draw.RoundedBox(0, 0, 27.5, 1100, 572.5, Tiger.PrimaryColor)
	    surface.SetDrawColor(color_black)
        surface.DrawOutlinedRect(0 ,0 ,500 ,600)
		draw.SimpleText("Boutique de Nourriture", "TigerAS2", 250, 0, white, TEXT_ALIGN_CENTER)
	end
	
	local closebutton = vgui.Create("DButton", frame)
    closebutton:SetPos(473.5)
    closebutton:SetText("Х")
    closebutton:SetFont("TigerAS1")
    closebutton:SetSize(27.5,27.5)
    closebutton:SetTextColor(Tiger.TextButtonColor)
    closebutton.Paint = function(s , w , h)
        draw.RoundedBox(0, 0, 0, w, h, Tiger.PrimaryButtonColor)
    end
    closebutton.DoClick = function ( self )
        frame:Close(true)
    end

	local Scroll = vgui.Create("DScrollPanel", frame)
	Scroll:Dock( FILL )
	
	local sbar = Scroll:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Tiger.SecondaryColor )
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Tiger.SecondaryColor )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Tiger.SecondaryColor )
	end

	for i, item in ipairs(DarkRPEntities) do
	
		local ShowThisItem = true
	
		if istable(item.allowed) and not table.HasValue( item.allowed, LocalPlayer():Team() ) then 
			ShowThisItem = false 
		end
		if item.customCheck and not item.customCheck( LocalPlayer()) then
			ShowThisItem = false 
		end
		
		if ShowThisItem == true then
			local button = Scroll:Add( "DButton" )
			button:SetSize(500, 72)
			button:SetText("")
			button:Dock( TOP )
			button:DockMargin( 0, 0, 0, 5 )
			button.Paint = function(s,w,h)
				if (button:IsHovered()) then
					draw.RoundedBox(0, 0, 0, w, 100, Tiger.PrimaryButtonColor)
					draw.RoundedBox(0, 0, 0, w, 100, Color(0, 0, 0, 170))
				else
					draw.RoundedBox(0, 0, 0, w, 100, Tiger.PrimaryButtonColor)
				end
				draw.SimpleText(item.name, "TigerAS", 105, 2.5, Color(255, 255,255,255))
				draw.SimpleText("Prix : "..DarkRP.formatMoney( item.price ).." - Maximum : "..item.max, "TigerAS", 165, 30, Color(255, 255,255,255), 0, 0)
			end
			button.DoClick = function()
				RunConsoleCommand("DarkRP", item.cmd)
			end
			
			local panel = vgui.Create("ModelImage", button)
			panel:SetSize(72, 72)
			panel:SetModel(item.model)
		end
	end
		
end

net.Receive("Shop::OpenMenu", OpenMenu)