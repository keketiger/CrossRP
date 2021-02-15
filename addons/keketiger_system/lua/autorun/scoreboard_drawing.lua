if !CLIENT then return end

ScoreboardDrawing = ScoreboardDrawing or {}

function ScoreboardDrawing.DrawRect(x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.DrawRect(x, y, w, h)
end

function ScoreboardDrawing.DrawText(msg, fnt, x, y, c, align)
    draw.SimpleText(msg, fnt, x, y, c, align and align or TEXT_ALIGN_CENTER)
end

function ScoreboardDrawing.DrawOutlinedRect(x, y, w, h, t, c)
    surface.SetDrawColor(c)

    for i=0, t - 1 do
		surface.DrawOutlinedRect(x + i, y + i, w - i * 2, h - i * 2)
    end
end

local blur = Material("pp/blurscreen")
function ScoreboardDrawing.BlurMenu(panel, layers, density, alpha)
	local x, y = panel:LocalToScreen(0, 0)

	surface.SetDrawColor(255, 255, 255, alpha)
	surface.SetMaterial(blur)

	for i=1, 3 do
		blur:SetFloat("$blur", (i / layers) * density)
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
	end
end
