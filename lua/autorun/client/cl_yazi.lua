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

hook.Add("HUDPaint","gosteramcayapipiyi",function()
    if( LocalPlayer():GetNWBool("CanThrowQuaffle") == true ) then
    local paddingx2 = 10
    local paddingy3 = 10

    local x3 = ScrW()/2---w2-paddingx2
    local y3 = paddingy3 + 200 + 10

	surface.SetFont("ekraniyazisi")
	
	draw.SimpleText("Quaffle Sende!", "ekraniyazisi",x3,y3,Color(255, 69, 0),TEXT_ALIGN_CENTER)
	
	end
	
	

end)