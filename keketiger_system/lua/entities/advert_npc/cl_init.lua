include('shared.lua')

function TheSimpleAdvert()

    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 470)
    frame:SetDraggable(false)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function( self )
        Derma_DrawBackgroundBlur( self, 1 )
        draw.RoundedBox(0, 0, 0, 1100, 27.5, Tiger.SecondaryColor)
        draw.RoundedBox( 0, 0, 27.5, 1100, 572.5, Tiger.PrimaryColor)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawOutlinedRect(0 ,0 ,400 ,470)
        draw.SimpleText(Tiger.MainText, "TigerAS2", 200, 0, white, TEXT_ALIGN_CENTER)
    end

    local closebutton = vgui.Create("DButton", frame)
    closebutton:SetPos(373.5)
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

    local buttonlist = vgui.Create ("DPanelList", frame)
    buttonlist:SetSize(320,555 - 80)
    buttonlist:SetPos(40,100)
    buttonlist:SetPadding(1)
    buttonlist:SetSpacing(45)
    buttonlist:SetVerticalScrollbarEnabled( true )

    local function AddButton(price, text, idbutton)

        local hV = false

        local buttonone = vgui.Create("DButton", frame)
        buttonone:SetText(text)
        buttonone:SetSize(600, 55.5)
        buttonone:SetFont("TigerAS1")
        buttonone:SetPos(100, 150)
        buttonone.OnCursorEntered = function() hV = true end
        buttonone.OnCursorExited = function() hV = false end
        if LocalPlayer():getDarkRPVar("money") < price or Tiger.SetDisableButton[idbutton] then
            buttonone:SetDisabled(true)
            buttonone:SetTextColor(Tiger.SecondaryButtonColor)
            buttonone.Paint = function (s,w,h)
                draw.RoundedBox(0, 0, 0, w, 42.5, Tiger.SecondaryColor)
                draw.RoundedBox(0, 0, 7.5, w, h, Tiger.SecondaryColor)
                draw.RoundedBox(0, 525, 0, 550, h, Tiger.SecondaryButtonColor)
                draw.SimpleText(GAMEMODE.Config.currency .. price,"TigerAS2",585,12.5, Tiger.TextButtonColorOnDisable, TEXT_ALIGN_RIGHT)
            end
        else
            buttonone:SetDisabled(false)
            buttonone:SetTextColor(Tiger.TextButtonColor)
            buttonone.Paint = function(s , w , h)
                draw.RoundedBox(0, 0, 0, w, 55.5, Tiger.SecondaryButtonColor)
                draw.RoundedBox(0, 0, 7.5, w, h, Tiger.PrimaryButtonColor)
                draw.RoundedBox(0, 525, 0, 550, h, Tiger.SecondaryColor)
                draw.SimpleText(GAMEMODE.Config.currency .. price,"TigerAS2",585,12.5, Tiger.PrimaryButtonColor, TEXT_ALIGN_RIGHT)
                surface.SetDrawColor(0, 0, 0, 200)
                surface.DrawOutlinedRect(0,0,w,h)
                if hV then
                    surface.DrawRect(0,0,w,h)
                end
            end
        end
        buttonone.DoClick = function(self)
            frame:Close()
            WriteBoard(price, text, idbutton)
        end
        buttonlist:AddItem(buttonone)
    end

    for i=1,3 do
        AddButton(Tiger.AdvertPrice[i], Tiger.MainTextButton[i], i)
    end

end

function WriteBoard(price, text, idbutton)

    if not price then return end

    local hV2 = false

    local writeboard = vgui.Create("DFrame")
    writeboard:SetSize(800, 150)
    writeboard:SetDraggable(true)
    writeboard:Center()
    writeboard:SetTitle("")
    writeboard:MakePopup()
    writeboard:ShowCloseButton(false)
    writeboard.Paint = function( self )
        Derma_DrawBackgroundBlur( self, 1 )
        draw.RoundedBox(0, 0, 0, 1100, 27.5, Tiger.SecondaryColor)
        draw.RoundedBox( 0, 0, 27.5, 1100, 572.5, Tiger.PrimaryColor)
        draw.SimpleText(Tiger.MainTextWritingBoard[idbutton], "TigerAS2", 400, 35, Tiger.PrimaryButtonColor, TEXT_ALIGN_CENTER)
    end

    local closewriteboard = vgui.Create("DButton", writeboard)
    closewriteboard:SetPos(773.5)
    closewriteboard:SetText("Х")
    closewriteboard:SetFont("TigerAS1")
    closewriteboard:SetSize(27.5,27.5)
    closewriteboard:SetTextColor(Tiger.TextButtonColor)
    closewriteboard.Paint = function(s , w , h)
        draw.RoundedBox(0, 0, 0, w, h, Tiger.PrimaryButtonColor)
    end
    closewriteboard.DoClick = function ( self )
        writeboard:Close()
        TheSimpleAdvert()
    end

    local TextEntry = vgui.Create( "DTextEntry", writeboard )
    TextEntry:SetPos( 50, 75 )
    TextEntry:SetSize( 700, 35 )

    local confirmbutton = vgui.Create("DButton", writeboard)
    confirmbutton:SetPos(355, 117)
    confirmbutton:SetText(Tiger.Confirm)
    confirmbutton:SetFont("TigerAS")
    confirmbutton:SetSize(85,27.5)
    confirmbutton:SetTextColor(Tiger.TextButtonColor)
    confirmbutton.OnCursorEntered = function() hV2 = true end
    confirmbutton.OnCursorExited = function() hV2 = false end
    confirmbutton.Paint = function(s , w , h)
        draw.RoundedBox(0, 0, 0, w, h, Tiger.PrimaryButtonColor)
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawOutlinedRect(0,0,w,h)
        if hV2 then
            surface.DrawRect(0,0,w,h)
        end
    end
    confirmbutton.DoClick = function ( self )
        AdSend()
        writeboard:Close()
    end

    function AdSend()
        net.Start("buyadvert")
        net.WriteUInt(idbutton, 3)
        net.WriteString(TextEntry:GetValue())
        net.SendToServer()
    end

end
net.Receive("AdTiger", TheSimpleAdvert)


