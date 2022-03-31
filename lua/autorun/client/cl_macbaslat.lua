surface.CreateFont( "ekraniyazisi", {
        font = "Harry P",
        extended = false,
        size =  50,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = true,
})

surface.CreateFont( "sayac", {
        font = "Harry P",
        extended = false,
        size =  ScrW() * 0.02,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = true,
})


local yetkilistesi = {
    ["superadmin"] = true,
        ["Mod"] = true,
        ["Admin"] = true,
        ["Head Admin"] = true,
        ["Yönetim Ekibi"] = true,
        ["admin"] = true,
        ["Admin+"] = true,
        ["Mod+"] = true
}


hook.Add("OnPlayerChat", "macbaslat", function(ply, strText) 
if (strText == "!macbaslat") then
if yetkilistesi[ply:GetUserGroup()] then
net.Start("macbaslat")
net.SendToServer()
end
end
end)

hook.Add("OnPlayerChat", "macbitir", function(ply, strText) 
if (strText == "!macbitir") then
if yetkilistesi[ply:GetUserGroup()] then
net.Start("macbitir")
net.SendToServer()
end
end
end)



hook.Add("HUDPaint","skorgoster",function()
	if quidmac then
        local x = ScrW()
        local y = ScrH()

        surface.SetDrawColor( Color(255,0,0,255) )
        surface.DrawOutlinedRect(x * 0.39,y * 0.12,x * 0.22,y * 0.07 )
        draw.RoundedBox(0,x * 0.39,y * 0.12,x * 0.22,y * 0.07,Color(0,0,0,180))
        surface.SetFont("ekraniyazisi")
        draw.SimpleText("Takim A : " ..tostring(GetGlobalInt("mavitakim", 0)), "sayac", ScrW() * 0.44, ScrH() * 0.15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("-", "sayac", ScrW() * 0.50, ScrH() * 0.15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
 
        draw.SimpleText(tostring(GetGlobalInt("kirmizitakim", 0)) .. " : Takim B ", "sayac", ScrW() * 0.56, ScrH() * 0.15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end
end)