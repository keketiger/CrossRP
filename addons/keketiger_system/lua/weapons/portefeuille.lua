AddCSLuaFile()
Portefeuille = Portefeuille or {}

if SERVER then util.AddNetworkString('PortefeuilleOpen') end

SWEP.PrintName = 'Portefeuille'
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Author = 'keketiger'
SWEP.Instructions = ''
SWEP.Contact = 'pro@keketiger.fr'
SWEP.Purpose = ''
SWEP.IsDarkRPPocket = false

SWEP.IconLetter = ''

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = true
SWEP.AnimPrefix = 'normal'
SWEP.Spawnable = false
SWEP.AdminOnly = true
SWEP.Category = 'keketiger'
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ''

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ''

function SWEP:Initialize()
    self:SetHoldType('normal')
end

function SWEP:Deploy()
    if SERVER then
        local player = self.Owner

        if IsValid(player) and player:Alive() then
            net.Start('PortefeuilleOpen')
            net.Send(player)
        end
    end

    return true
end

function SWEP:DrawWorldModel() end

function SWEP:PreDrawViewModel(vm)
    return true
end

if CLIENT then
    surface.CreateFont('TigerAS', {
        font = 'Default',
        size = 18,
        bold = true,
        underline = true,
        italic = false
    })

    surface.CreateFont('TigerAS1', {
        font = 'Arial',
        size = 18,
        weight = 750
    })

    surface.CreateFont('TigerAS2', {
        font = 'Default',
        size = 24,
        underline = true,
        italic = false,
        bold = true
    })

    surface.CreateFont('TigerAS3', {
        font = 'Default',
        size = 45,
        underline = true,
        italic = false,
        bold = true
    })

    local function theDerma()
        local player = LocalPlayer()
        if not IsValid(player) or not player:Alive() or IsValid(FMain) then return end

        FMain = vgui.Create('DFrame')

        FMain:SetSize(380,180)
        FMain:Center()
        FMain:SetTitle('')
        FMain:MakePopup()
        FMain:SetDraggable(false)
        FMain:ShowCloseButton(false)

        FMain.Paint = function(self, w, h)
            Derma_DrawBackgroundBlur(self, 1)

            draw.RoundedBox(0, 0, 0, 1100, 27.5, Tiger.SecondaryColor)
            draw.RoundedBox(0, 0, 27.5, 1100, 572.5, Tiger.PrimaryColor)
            draw.DrawText('Vous avez : $' .. LocalPlayer().DarkRPVars.money, 'TigerAS2', 5, 0, Tiger.TextButtonColor)
            draw.DrawText('Saisissez un montant :', 'TigerAS3', 20, 23, Tiger.TextButtonColor)
        end

        FMain.OnClose = function() gui.EnableScreenClicker(false) end
        gui.EnableScreenClicker(true)

        local closebutton = vgui.Create('DButton', FMain)
        closebutton:SetPos(353.5)
        closebutton:SetText('Х')
        closebutton:SetFont('TigerAS1')
        closebutton:SetSize(27.5,27.5)
        closebutton:SetTextColor(Tiger.TextButtonColor)

        closebutton.Paint = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Tiger.PrimaryButtonColor)
        end
        closebutton.DoClick = function(self)
            FMain:Close(true)
        end

        local FMain_Text = vgui.Create('DTextEntry', FMain)
        FMain_Text:SetSize(360, 40)
        FMain_Text:SetPos(10, 70)
        FMain_Text:SetFont('TigerAS1')

        FMain_Text.AllowInput = function(self, stringValue)
            if string.find(stringValue, '%d') then
                return false
            end

            return true
        end

        FMain_Text.Paint = function(self)
            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Tiger.TextButtonColor)
            self:DrawTextEntryText(color_black, Color(219, 219, 219, 100), color_black)
        end

        local FMain_Give = vgui.Create('DButton', FMain)
        FMain_Give:SetSize(180, 50)
        FMain_Give:SetPos(5, 120)
        FMain_Give:SetText('')

        FMain_Give.Paint = function(self, w, h)
            if FMain_Give.Depressed or FMain_Give.m_bSelected then 
                draw.RoundedBox(0, 0, 0, w, h, Color(52, 201, 36, 200))
                draw.SimpleText('Donner', 'TigerAS1', w / 2, h / 2, color_white, 1, 1)
            elseif FMain_Give.Hovered then
                draw.RoundedBox(0, 0, 0, w, h, Color(52, 201, 36, 200))
                draw.SimpleText('Donner', 'TigerAS1', w / 2, h / 2, color_white, 1, 1)
            else
                draw.RoundedBox(0, 0, 0, w, h, Tiger.PrimaryButtonColor)
                draw.SimpleText('Donner', 'TigerAS1', w / 2, h / 2, color_white, 1, 1)
            end
        end
        FMain_Give.DoClick = function()
            local value = FMain_Text:GetValue()

            if value and type(value) == 'string' and value ~= '' then
                player:ConCommand('say /give ' .. value)

                if IsValid(player:GetEyeTrace().Entity) and player:GetEyeTrace().Entity:IsPlayer() then
                    chat.AddText(color_white, 'Vous avez donné ' .. DarkRP.formatMoney(tonumber(value)) .. '$ à ' .. player:GetEyeTrace().Entity:Name() .. '.')
                end

                FMain:Close(true)
            end
        end

        local FMain_Drop = vgui.Create('DButton', FMain)
        FMain_Drop:SetSize(180, 50)
        FMain_Drop:SetPos(195, 120)
        FMain_Drop:SetText('')

        FMain_Drop.Paint = function(self, w, h)
            if FMain_Drop.Depressed or FMain_Drop.m_bSelected then 
                draw.RoundedBox(0, 0, 0, w, h, Color(52, 201, 36, 200))
                draw.SimpleText('Jeter', 'TigerAS1', w / 2, h / 2, color_white, 1, 1)
            elseif FMain_Drop.Hovered then
                draw.RoundedBox(0, 0, 0, w, h, Color(52, 201, 36, 200))
                draw.SimpleText('Jeter', 'TigerAS1', w / 2, h / 2, color_white, 1, 1)
            else
                draw.RoundedBox(0, 0, 0, w, h, Tiger.PrimaryButtonColor)
                draw.SimpleText('Jeter', 'TigerAS1', w / 2, h / 2, color_white, 1, 1)
            end
        end
        FMain_Drop.DoClick = function()
            local value = FMain_Text:GetValue()

            if value and type(value) == 'string' and value ~= '' then
                player:ConCommand('say /dropmoney ' .. value)
                chat.AddText(color_white, 'Vous avez déposé $' .. value)
                FMain:Remove()
            end
        end
    end

    function SWEP:PrimaryAttack()
        self:SetNextPrimaryFire(CurTime() + .2)
        if SERVER then return end
        theDerma()
    end

    function SWEP:SecondaryAttack()
        self:SetNextSecondaryFire(CurTime() + .2)
        if SERVER then return end
        theDerma()
    end
end

function SWEP:Holster()
    if not SERVER then return true end

    self:GetOwner():DrawViewModel(true)
    self:GetOwner():DrawWorldModel(true)

    return true
end
