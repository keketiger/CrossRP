if not Tiger.Font then
    surface.CreateFont('TigerAS_Context',{
        font = 'Default',
        size = 18,
        bold = true,
        underline = true,
        italic = false
    })

    surface.CreateFont('TigerAS1_Context',{
        font = 'Arial',
        size = ScrH() * 0.017,
        weight = 750
    })

    surface.CreateFont('TigerAS2_Context',{
        font = 'Default',
        size = ScrH() * 0.028,
        underline = true,
        italic = false,
        bold = true
    })

    surface.CreateFont('TigerAS3_Context',{
        font = 'Default',
        size = 25,
        underline = true,
        italic = false,
        bold = true
    })
end
