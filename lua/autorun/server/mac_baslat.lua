--KODUN SAHIBI BYPOLAT BARISTANER EKLEMELER YAPMISTIR 

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

local topspawnla = Vector(-9808.903320, 5610.830078, -63.968750)

local quidmac = false
util.AddNetworkString("macbaslat")
net.Receive( "macbaslat", function( len, pl )
if !IsValid(pl) then return end
if yetkilistesi[pl:GetUserGroup()] then
if not quidmac then
quidmac = true
SetGlobalInt( "mavitakim", 0)
SetGlobalInt( "kirmizitakim", 0)
SetGlobalInt( "macbasla", 1)
local p = ents.Create("bt_quaffle")
p:SetPos(topspawnla)
p:SetMoveType(MOVETYPE_VPHYSICS)
p:Spawn()
for k, ply in pairs( player.GetAll() ) do
ply:SendLua('chat.AddText( Color( 100, 255, 100 ), "Quidditch maci basladi!", Color( 100, 100, 255 )," Basarilar.." )')
ply:SendLua('surface.PlaySound( "weapons/physgun_off.wav" )')
ply:SendLua('quidmac = true')
end
else
pl:ChatPrint("Zaten aktif bir quiditch maçi var.")
end
end
end)

util.AddNetworkString("macbitir")
net.Receive( "macbitir", function( len, pl )
if !IsValid(pl) then return end
if yetkilistesi[pl:GetUserGroup()] then
if quidmac then
quidmac = false
SetGlobalInt( "macbasla", 0)
local sil = ents.FindByClass("bt_quaffle")
for k, ply in pairs( player.GetAll() ) do
for k, v in pairs(sil) do
SafeRemoveEntity(v) 
end
if GetGlobalInt("mavitakim", 0) == GetGlobalInt("kirmizitakim", 0) then
ply:SendLua('chat.AddText( Color( 100, 255, 100 ), "Quidditch maci bitti! Mac", Color( 100, 100, 255 )," BERABERE ('..GetGlobalInt("mavitakim", 0)..'-'..GetGlobalInt("kirmizitakim", 0)..') ", Color( 100, 255, 100 ),"kaldi! Tebrikler..." )')
elseif GetGlobalInt("mavitakim", 0) > GetGlobalInt("kirmizitakim", 0) then
ply:SendLua('chat.AddText( Color( 100, 255, 100 ), "Quidditch maci bitti! Maci", Color( 100, 100, 255 )," TAKIM A ('..GetGlobalInt("mavitakim", 0)..'-'..GetGlobalInt("kirmizitakim", 0)..') ", Color( 100, 255, 100 ),"kazandi! Tebrik ediyoruz..." )')
else
ply:SendLua('chat.AddText( Color( 100, 255, 100 ), "Quidditch maci bitti! Maci", Color( 100, 100, 255 )," TAKIM B ('..GetGlobalInt("kirmizitakim", 0)..'-'..GetGlobalInt("mavitakim", 0)..') ", Color( 100, 255, 100 ),"kazandi! Tebrik ediyoruz..." )')
end
ply:SendLua('surface.PlaySound( "ui/achievement_earned.wav" )')
ply:SendLua('quidmac = false')
end
else
pl:ChatPrint("Aktif bir quidditch maci yok.")
end
end
end)