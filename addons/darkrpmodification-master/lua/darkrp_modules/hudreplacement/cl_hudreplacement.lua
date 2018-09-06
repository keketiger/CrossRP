--[[---------------------------------------------------------------------------
	Manufactured by keketiger
---------------------------------------------------------------------------]]

local hideHUDElements = {
	["DarkRP_HUD"] = false,
	["DarkRP_EntityDisplay"] = false,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_Hungermod"] = true,
	["DarkRP_Agenda"] = false,
	["DarkRP_LockdownHUD"] = true,
	["DarkRP_ArrestedHUD"] = false,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true
}

-- this is the code that actually disables the drawing.
hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)

surface.CreateFont( "HudFont", {
	font = "TargetID",
	size = 16,
	antialias = true,
})

local page = Material("icon16/page_white_text.png")
local iname = Material("icon16/user.png")
local imoney = Material("icon16/money.png")
local isalary = Material("icon16/money_add.png")

local Health = 0
local function hudPaint()

	local ply = LocalPlayer()
	local name = ply:Nick()
	local bani = ply.DarkRPVars and ply.DarkRPVars.money or "0"
	local salar = ply.DarkRPVars and ply.DarkRPVars.salary or "0"
	local hunger = LocalPlayer():getDarkRPVar("Energy") or "0"

	local ColorBox = Color(0,0,0,170)

	-- left / Gauche

	local x1, y1 = 10, ScrH() - 10

		-- Name
		draw.RoundedBox(0, x1 - 5, y1 - 95, 20, 20, ColorBox)
		surface.SetMaterial(iname)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(x1 - 3, y1 - 93, 16, 16)
		draw.RoundedBox(0, x1 + 20, y1 - 95, 190, 20, ColorBox)
		draw.DrawText("⬥ "..name,"HudFont", x1 + 24, y1 - 93, color_white, TEXT_ALIGN_LEFT)

		-- GunLicense / License d'arme
		draw.RoundedBox(0, x1 - 5, y1 - 70, 20, 20, ColorBox)
		surface.SetMaterial(page)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(x1 - 3, y1 - 68, 16, 16)
		draw.RoundedBox(0, x1 + 20, y1 - 70, 190, 20, ColorBox)
		if LocalPlayer():getDarkRPVar("HasGunlicense") then
			draw.DrawText("⬥ License d'arme : Valide","HudFont", x1 + 24, y1 - 68, color_white, TEXT_ALIGN_LEFT)
		else
			draw.DrawText("⬥ License d'arme : Invalide","HudFont", x1 + 24, y1 - 68, color_white, TEXT_ALIGN_LEFT)
		end

	    -- Money / Argent
	    draw.RoundedBox(0,x1 - 5, y1 - 45, 20, 20, ColorBox)
	    surface.SetMaterial(imoney)
	    surface.SetDrawColor(255,255,255,255)
	    surface.DrawTexturedRect(x1 - 2, y1 - 43, 16, 16)
	    draw.RoundedBox(0, x1 + 20, y1 - 45, 190, 20, ColorBox)
	    draw.DrawText("⬥ ".."$"..bani,"HudFont", x1 + 24, y1 - 43, color_white, TEXT_ALIGN_LEFT)

	    -- Salary / Salaire
	    draw.RoundedBox(0, x1 - 5, y1 - 20, 20, 20, ColorBox)
	    surface.SetMaterial(isalary)
	    surface.SetDrawColor(255,255,255,255)
	    surface.DrawTexturedRect(x1 - 2, y1 - 18, 16, 16)
	    draw.RoundedBox(0, x1 + 20, y1 - 20, 190, 20, ColorBox)
	    draw.DrawText("⬥ ".."$"..salar, "HudFont", x1 + 24, y1 - 18)

	    -- Ammo / Munition
	    if !IsValid(ply:GetActiveWeapon()) then return end
		if (ply:GetActiveWeapon():Clip1() == NULL or ply:GetActiveWeapon() == "Camera") then return end
			local mag_left = LocalPlayer():GetActiveWeapon():Clip1()
			local mag_extra = LocalPlayer():GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType())

		if mag_left <= 0 then
		elseif mag_left > 100 then
			draw.RoundedBox(0, x1 + 220, y1 - 45, 85, 45, ColorBox)
			draw.SimpleText(mag_left, "HudFont", x1 + 225, y1 -40)
			draw.SimpleText("-----", "HudFont", x1 + 255, y1 - 40)
			draw.SimpleText(mag_extra, "HudFont", x1 + 270, y1 - 40)
		elseif mag_left < 100 then
			draw.RoundedBox(0, x1 + 220, y1 - 45, 80, 45, ColorBox)
			draw.SimpleText("⬥ "..mag_left, "HudFont", x1 + 225, y1 -40)
			draw.SimpleText("________", "HudFont", x1 + 224, y1 - 35)
			draw.SimpleText("⬥ "..mag_extra, "HudFont", x1 + 225, y1 - 20)
		end
		
		--if mag_left > 0 and mag_left <= 5 then
		--	draw.DrawText("RECHARGER","HudFont", x1 + 230, y1 - 20, Color(200,0,0,math.random(50,255)))
		--end

	-- Right / Droite

	local x, y = ScrW() - 180, ScrH() 
	Health = math.min(100, (Health == LocalPlayer():Health() and Health) or Lerp(0.1, Health, LocalPlayer():Health()))

	-- Health / Vie
	local DrawHealth = math.Min(Health / GAMEMODE.Config.startinghealth, 1)
	local Border = math.Min(0, math.pow(2, math.Round(3*DrawHealth)))
		draw.RoundedBox(Border, x, y - 30, 180 - 8, 20, ColorBox)
		draw.RoundedBox(Border, x + 3, y - 27, (175 - 8) * DrawHealth, 14, Color(140,0,0,255))

		-- Hunger / Faim
		draw.RoundedBox(0, x, y - 55, 180 - 8, 20, ColorBox)
		draw.RoundedBox(0,x + 3, y - 52, (175 - 9) * hunger / 100, 14, Color(0, 128, 28, 255))

	local armor = LocalPlayer():Armor()
	if armor >= 100 then
		draw.RoundedBox(0, x , y - 80, 180 - 8, 20, ColorBox)
		draw.RoundedBox(0,x + 3, y - 77, 166, 14, Color(0, 0, 255, 255))
	elseif armor ~= 0 then
		draw.RoundedBox(0, x, y - 80, 180 - 8, 20, ColorBox)
		draw.RoundedBox(0,x + 3, y - 77, (175 - 8) * armor / 100, 14, Color(0, 0, 255, 255))
	end
end
hook.Add("HUDPaint", "DarkRP_Mod_HUDPaint", hudPaint)