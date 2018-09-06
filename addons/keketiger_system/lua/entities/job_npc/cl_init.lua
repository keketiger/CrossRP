include("shared.lua")

local ID = 1
local function JobNPCMenu()

	ID = net.ReadInt(8)

	local frame = vgui.Create("DFrame")
	frame:SetSize(600, 600)
	frame:SetDraggable(false)
	frame:Center()
	frame:SetTitle("")
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Paint = function(self)
        draw.RoundedBox(0, 0, 0, 1100, 27.5, Tiger.SecondaryColor)
        draw.RoundedBox( 0, 0, 27.5, 1100, 572.5, Tiger.PrimaryColor)
       	surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawOutlinedRect(0 ,0 ,600 ,600)
		draw.SimpleText(Tiger.JNPC.CreateNPC[ID].title, "TigerAS2", 310, 0, white, TEXT_ALIGN_CENTER)
	end

    local closebutton = vgui.Create("DButton", frame)
    closebutton:SetPos(573.5)
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

    local buttonlist = vgui.Create ("DScrollPanel", frame)
    buttonlist:SetSize(530,555 - 50)
    buttonlist:SetPos(40,60)

    local sbar = buttonlist:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ))
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ))
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ))
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ))
	end

	local lay = vgui.Create("DIconLayout", buttonlist)
	lay:SetSize(700, 500)
	lay:SetPos(0, 0)
	lay:SetSpaceX(0)
	lay:SetSpaceY(10)

	for k, v in pairs(Tiger.JNPC.CreateNPC[ID].jobs) do
		job = _G[v]

		local job_slot = team.NumPlayers(job)
		local max_job_slot = 0
		local job_name = ""
		local job_description = ""
		local job_model = ""

		for k, v in pairs(RPExtraTeams) do
			if k == job then
				max_job_slot = v.max
				job_name = v.name
				job_description = v.description
				job_model = table.GetFirstValue(v.model)
			end
		end

		local j = lay:Add("DButton")
		j:SetSize(700, 100)
		j:SetText("")
		if job_slot < max_job_slot or max_job_slot == 0 then
			j:SetEnabled(true)
			j.Paint = function(s,w,h)
				if (j:IsHovered()) then
					draw.RoundedBox(0, 0, 0, w, 100, Tiger.PrimaryButtonColor)
					draw.RoundedBox(0, 0, 0, w, 100, Color(0, 0, 0, 170))
				else
					draw.RoundedBox(0, 0, 0, w, 100, Tiger.PrimaryButtonColor)
				end
				draw.SimpleText(job_name.." :", "TigerAS", 105, 2.5, Color(255, 255,255,255))
				draw.SimpleText(job_slot.."/"..max_job_slot, "TigerAS", 50, 90, Color(255, 255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.DrawText(job_description, "TigerAS", 105, 25, Color(255, 255,255,255))
			end
		else
			j:SetEnabled(false)
			j.Paint = function()
				draw.RoundedBox(0, 0, 0, 700, 100, Tiger.SecondaryButtonColor)
				surface.SetDrawColor(130, 130, 130, 255)
				surface.DrawOutlinedRect(0, 0, 700, 100)
				draw.SimpleText(job_name.." :", "TigerAS1", 105, 2.5, Color(255, 255,255,255))
				draw.SimpleText(job_slot.."/"..max_job_slot, "TigerAS1", 50, 90, Color(255, 255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.DrawText(job_description, "TigerAS1", 105, 25, Color(255, 255,255,255))
			end
		end
		j.DoClick = function()
			net.Start("tiger_jnpc_jobswitch")
			net.WriteString(v)
			net.SendToServer()
			frame:Close(true)
		end

		local panel = vgui.Create("DModelPanel", j)
		panel:SetSize(100, 80)
		panel:SetModel(job_model)
		panel:SetCamPos(Vector(70, -15, 60))
		panel:SetLookAt(Vector(5, 0, 62.5))
		panel:SetFOV(26)
		function panel:LayoutEntity(Entity) return end

	end

end
net.Receive("TigerJobNPCGUI", JobNPCMenu)

hook.Add("PostDrawOpaqueRenderables", "HeadNPCText", function()
	for ID, ent in pairs(ents.FindByClass("job_npc")) do
		if ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 100000 then
			local ang = ent:GetAngles()
			local pos = ent:GetPos()
			local up = ent:GetUp()

			ang:RotateAroundAxis(ang:Forward(), 90)
			ang:RotateAroundAxis(ang:Right(), -90)
			cam.Start3D2D(pos+up*90, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.35)
				draw.SimpleText(Tiger.JNPC.CreateNPC[ID].name, "TigerAS2", 0, 0, Tiger.JNPC.CreateNPC[ID].color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT)
			cam.End3D2D()
		end
	end
end)
