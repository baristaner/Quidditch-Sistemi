AddCSLuaFile()
ENT.Type            = "anim"
ENT.Base            = "base_gmodentity"
ENT.Category = "baristaner Quidditch"
ENT.PrintName	    = "Takim A Sayac"
ENT.Author          = ""
ENT.Spawnable	    = true
ENT.AdminSpawnable	= false

topspawnla = Vector(-9808.903320, 5610.830078, -63.968750)

if SERVER then
function ENT:Initialize()
self.Entity:SetModel("models/hunter/tubes/circle2x2.mdl")
self.Entity:PhysicsInit( SOLID_CUSTOM )
self.Entity:SetMoveType(MOVETYPE_NONE)
self.Entity:SetSolid( SOLID_VPHYSICS )
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetRenderMode(RENDERMODE_TRANSCOLOR)
self.Entity:SetMaterial("models/shadertest/shader3")
self.Entity:SetColor(Color(255,0,0,10))
if IsValid(self.Entity:GetPhysicsObject()) then 
self.Entity:GetPhysicsObject():EnableMotion(true)
end
end
function ENT:Touch( entity )
if GetGlobalInt("macbasla", 0) == 0 then return end
if entity:GetClass() == "bt_quaffle" or entity:GetClass() == "kekc_fireball_ent" then 
SetGlobalInt( "mavitakim", GetGlobalInt("mavitakim", 0)+(self.puan or 10))
entity:SetPos(topspawnla)
for k, ply in pairs( player.GetAll() ) do
ply:SendLua('chat.AddText( Color( 100, 255, 100 ), "TAKIM A SAYI YAPTI!", Color( 100, 100, 255 )," Tebrikler!" )')
ply:SendLua('surface.PlaySound( "ui/freeze_cam.wav" )')
end
end
end
end