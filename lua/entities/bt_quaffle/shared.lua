AddCSLuaFile()
DEFINE_BASECLASS( "base_gmodentity" )

ENT.PrintName 	= "Quaffle"
ENT.Author 		= "baristaner"
ENT.Information = "Quaffle"
ENT.Category 	= "baristaner Quidditch"

ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false

surface.CreateFont( "ent", {
        font = "Harry P",
        extended = false,
        size =  120,
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

surface.CreateFont( "ent2", {
        font = "Harry P",
        extended = false,
        size =  60,
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

local quaffleyazirenk = Color(0,255,255)
local beyazrenk = Color(255,255,255)
local siyahrenk = Color(0,0,0,255)
local kirmizirenk = Color(255,0,0,255)
local siyahrenkopak = Color(0,0,0,180)



function ENT:Draw()
self:DrawModel()
if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then
local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 90 )
cam.IgnoreZ( false )
cam.Start3D2D( self:GetPos() + Vector( -1, 0, 10 ), ang, .1 )

draw.SimpleTextOutlined( "Quaffle" , "ent", -7, -120, quaffleyazirenk, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, siyahrenk )
draw.SimpleTextOutlined( "'Dokunarak Alabilirsin'", "ent2", -5, -60,  beyazrenk, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, siyahrenk)

cam.End3D2D()
end
end