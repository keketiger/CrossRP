if SERVER then 
	AddCSLuaFile( 'config.lua' ) 
end
include( 'config.lua' )

if !CLIENT then return end

local Scoreboard = nil
    --local x, y = ScrW(), ScrH()
	
	local imoney = Material("icon16/money.png")

    local function CanSee()
        if !Tiger.StaffGroups[ LocalPlayer():GetUserGroup() ] then
            return false
        end
        return true
    end

    local function GetNewX( self, x )
        if IsValid( self ) then
            if self.VBar.Enabled then x = x + 9 end
            return x
        end
    end

    local function CreateSimpleButton( parent, x, y, txt, font, col, target, click, cusFunc )
        local self = vgui.Create( 'DButton', parent )
        self:SetPos( x, y )
        self:SetSize( 90, 30 )
        self:SetFont( font )
        self:SetText( txt )
        self:SetTextColor( col )
        --if click then self.DoClick = click end
        if !cusFunc then
            self.DoClick = function()
                -- Check the target is still on the server when executing
                if !IsValid( target ) then return end
                LocalPlayer():ConCommand( click )
            end
        else
            self.DoClick = cusFunc
        end
        self.OnCursorEntered = function( me, w, h ) self.Hover = true end
        self.OnCursorExited = function( me, w, h ) self.Hover = false end
        self.Paint = function( me, w, h )
            if self.Hover then
                ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 180, 0, 0, 255 ) )
            else
                ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 32, 32, 32, 200 ) )
            end
        end
        return self
    end

    local function TranslateGroup( x, c )
        if not c then
            if Tiger.Scoreboard_Groups[ x ] then
                return Tiger.Scoreboard_Groups[ x ].name
            else
                return 'User'
            end
        else
            if Tiger.Scoreboard_Groups[ x ] then
                return Tiger.Scoreboard_Groups[ x ].color
            else
                return Color( 255, 255, 255 )
            end
        end
    end

	--[[---------------------
			Double Click
	------------------------]]
	
    local function ElegantCreateInspect( x )
        Inspect = vgui.Create( 'DFrame' )
        Inspect:SetSize( 600, 300 )
        Inspect:SetTitle( '' )
        Inspect:SetDraggable( false )
        Inspect:SetVisible( true )
        Inspect:ShowCloseButton( false )
        Inspect:Center()
        Inspect.Paint = function( me, w, h )
            if !IsValid( x ) then Inspect:Remove() return end
			draw.RoundedBox(0, 0, 0, 1100, 27.5, Color(40, 40, 40, 255))
			draw.RoundedBox( 0, 0, 27.5, 1100, 572.5, Color(0, 0, 0, 255))
			
			draw.SimpleText( x:Nick(), "TigerAS2", 310, 0, TranslateGroup( x:GetUserGroup(), true), TEXT_ALIGN_CENTER)
			draw.SimpleText( "⬥ SteamID : "..x:SteamID(), "TigerAS1", 10, 45, white)
			draw.SimpleText( "⬥ Grade : "..TranslateGroup( x:GetUserGroup(), false ), "TigerAS1", 10, 65, white)
			draw.SimpleText( "⬥ Emploi : "..team.GetName( x:Team()), "TigerAS1", 10, 85, white)
			draw.SimpleText( "⬥ Argent : "..x:getDarkRPVar("money").."$", "TigerAS1", 10, 105, white)
			draw.SimpleText( "-> Commandes de base :", "TigerAS2", 10, 125, white)
        end

        local steam_copy = vgui.Create( 'DImageButton', Inspect )
        steam_copy:SetPos( 260, 46 )
        steam_copy:SetSize( 16, 16 )
        steam_copy:SetIcon( 'icon16/paste_plain.png' )
        steam_copy.DoClick = function()
            if !IsValid( x ) then return end
            SetClipboardText( x:SteamID() )
            LocalPlayer():ChatPrint( x:Nick() .. " SteamID a été copié dans votre presse-papiers." )
        end

        CreateSimpleButton( Inspect, 35, 155, 'Goto', 'TigerAS1', Color( 255, 255, 255 ), x, 'ulx goto ' .. x:Nick() )
        CreateSimpleButton( Inspect, 145, 155, 'Bring', 'TigerAS1', Color( 255, 255, 255 ), x, 'ulx bring ' .. x:Nick() )
        CreateSimpleButton( Inspect, 255, 155, x.FreezeState and x.FreezeState or 'Freeze', 'TigerAS1', Color( 255, 255, 255 ), x, nil, function( self )
            if !x.Is_Frozen then
                x.FreezeState = 'Unfreeze'
                self:SetText( x.FreezeState )
                LocalPlayer():ConCommand( 'ulx freeze ' .. x:Nick() )
                x.Is_Frozen = true
            else
                x.FreezeState = 'Freeze'
                self:SetText( x.FreezeState )
                LocalPlayer():ConCommand( 'ulx unfreeze ' .. x:Nick() )
                x.Is_Frozen = false
            end
        end )
        CreateSimpleButton( Inspect, 365, 155, x.JailState and x.JailState or 'Jail', 'TigerAS1', Color( 255, 255, 255 ), x, nil, function( self )
            if !x.Is_Jailed then
                x.JailState = 'Unjail'
                self:SetText( x.JailState )
                LocalPlayer():ConCommand( 'ulx jail ' .. x:Nick() )
                x.Is_Jailed = true
            else
                x.JailState = 'Jail'
                self:SetText( x.JailState )
                LocalPlayer():ConCommand( 'ulx unjail ' .. x:Nick() )
                x.Is_Jailed = false
            end
        end )
        CreateSimpleButton( Inspect, 475, 155, 'Spectate', 'TigerAS1', Color( 255, 255, 255 ), x, 'fspectate ' .. x:Nick() )
        CreateSimpleButton( Inspect, 35, 195, x.GodState and x.GodState or 'God', 'TigerAS1', Color( 255, 255, 255 ), x, nil, function( self )
            if !x.Is_God then
                x.GodState = 'UnGod'
                self:SetText( x.GodState )
                LocalPlayer():ConCommand( 'ulx god ' .. x:Nick() )
                x.Is_God = true
            else
                x.GodState = 'God'
                self:SetText( x.GodState )
                LocalPlayer():ConCommand( 'ulx ungod ' .. x:Nick() )
                x.Is_God = false
            end
        end )
		CreateSimpleButton( Inspect, 145, 195, x.RagdollState and x.RagdollState or 'Ragdoll', 'TigerAS1', Color( 255, 255, 255 ), x, nil, function( self )
            if !x.Is_Ragdoll then
                x.RagdollState = 'UnRagdoll'
                self:SetText( x.RagdollState )
                LocalPlayer():ConCommand( 'ulx ragdoll ' .. x:Nick() )
                x.Is_Ragdoll = true
            else
                x.RagdollState = 'Ragdoll'
                self:SetText( x.RagdollState )
                LocalPlayer():ConCommand( 'ulx unragdoll ' .. x:Nick() )
                x.Is_Ragdoll = false
            end
        end )
    end

	--[[-------------------
			DFrame
	---------------------]]
    local function ElegantCreateBase()
        Elegant = vgui.Create( 'DFrame' )
        Elegant:SetSize( 600, 700 )
        Elegant:SetTitle( '' )
        Elegant:SetDraggable( false )
        Elegant:SetVisible( true )
        Elegant:ShowCloseButton( false )
        Elegant:Center()
        gui.EnableScreenClicker( true )
        Elegant.Paint = function( me, w, h )
			draw.RoundedBox(0, 0, 0, 1100, 27.5, Color(40, 40, 40, 255))
			draw.RoundedBox( 0, 0, 27.5, 1100, 672.5, Color(255, 255, 255, 20))
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawOutlinedRect(0 ,0 ,600 ,700)
			draw.RoundedBox(0, 10, 50, w - 20, 20, Color(40, 40, 40, 255))
			draw.RoundedBox(0, 10, 660, w - 20, 20, Color(40, 40, 40, 255))
			draw.SimpleText("CrossRP - V2", "TigerAS2", w / 2, 0, white, TEXT_ALIGN_CENTER)
            --ScoreboardDrawing.DrawText( #player.GetAll() == 1 and '' or 'There are currently ' .. #player.GetAll() .. " players online.", "ElegantScoreFontUnder", w / 2, h - 22, Color( 3,169,244, 255 ) )
        end

        Elegant.PlayerList = vgui.Create( "DPanelList", Elegant )
        Elegant.PlayerList:SetSize( Elegant:GetWide() - 20, Elegant:GetTall() - 110 )
        Elegant.PlayerList:SetPos( 10, 70 )
        Elegant.PlayerList:SetSpacing( 2 )
        Elegant.PlayerList:EnableVerticalScrollbar( true )

        Elegant.PlayerList.Paint = function( me, w, h )
            ScoreboardDrawing.DrawRect( 0, 0, w, h, Color(0, 0, 0, 100) )
        end

        local sbar = Elegant.PlayerList.VBar
        function sbar:Paint( w, h )
            ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 0, 0, 0, 100 ) )
        end
        function sbar.btnUp:Paint( w, h )
            ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 44, 44, 44 ) )
        end
        function sbar.btnDown:Paint( w, h )
            ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 44, 44, 44 ) )
        end
        function sbar.btnGrip:Paint( w, h )
            ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 56, 56, 56 ) )
        end

        for _, x in pairs( player.GetAll() ) do
            local item = vgui.Create( 'DPanel', Elegant.PlayerList )
            item:SetSize( Elegant.PlayerList:GetWide() - 70, 35 )

            local self = Elegant.PlayerList
            local _y = 7

            item.Paint = function( me, w, h )
                if !IsValid( x ) then item:Remove() return end
                if _ % 2 == 0 then
                    ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 180, 0, 0, 255 ) )
                else
                    ScoreboardDrawing.DrawRect( 0, 0, w, h, Color( 180, 0, 0, 255 ) )
                end
		
                ScoreboardDrawing.DrawText( x:Nick(), "TigerAS2", 10, 5, color_white, TEXT_ALIGN_LEFT )
                ScoreboardDrawing.DrawText( x:Ping(), "TigerAS2", GetNewX( self, w - 30 ), 5, Color( 255, 255, 255 ) )
            end

            local bounds = vgui.Create( "DLabel", item )
            bounds:SetSize( item:GetWide() - 5, item:GetTall() )
            bounds:SetPos( 0, 0 )
            bounds:SetText( "" )
            bounds:SetMouseInputEnabled( true )

            bounds.DoDoubleClick = function()
                if !CanSee() then return end
                if IsValid( Inspect ) then
                    Inspect:Remove()
                end
                ElegantCreateInspect( x )
            end
			Elegant.PlayerList:AddItem( item )
        end
    end
	
    local function ElegantHide()
        Elegant:SetVisible( false )
        gui.EnableScreenClicker( false )
    end

    hook.Add( 'ScoreboardShow', 'ELEGANT_CREATE_BOARD', function()
        ElegantCreateBase()
        return true
    end )

    hook.Add( 'ScoreboardHide', 'ELEGANT_REMOVE_BOARD', function()
        if IsValid( Elegant ) then ElegantHide() end
        if IsValid( Inspect ) then Inspect:Remove() end        
        return true
    end )
