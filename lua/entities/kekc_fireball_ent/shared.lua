

AddCSLuaFile()

//We can use it by using FireStar broom or spawning in Q menu

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = true
ENT.Category = "Harry Potter"
ENT.PrintName = "Exploding ball"

function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not ply then return end
	if not ply:IsValid() then return end

	local pos = tr.HitPos + tr.HitNormal * 32
	
	local ent = ents.Create("kekc_fireball_ent")
	ent:SetPos(pos)
	ent:SetAngles(Angle(0, 0, 180))
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:EnableGravity(false) phys:Wake() else return NULL end
	
	return ent
end

function ENT:Draw()
	if SERVER then return end
	
	render.SetMaterial(Material("particle/particle_glow_04_additive"))
	render.DrawSprite(self:GetPos(), 50, 50, Color(255, 255, 255))
end

function ENT:Explosive(pos)
	local ef = EffectData()
	ef:SetOrigin(pos)
	util.Effect("Explosion", ef)
	
	local owner = self:GetOwner()
	if not owner then owner = self end
	if not owner:IsValid() then owner = self end
	
	util.BlastDamage(self, owner, self:GetPos(), 180, 20)
	
	self:Remove()
end

function ENT:Initialize()
	if CLIENT then		
		return 
	end

	self:SetModel("models/props_junk/PopCan01a.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
	
	timer.Simple(5, function() 
		if self and self:IsValid() then 
			self:Explosive(self:GetPos()) 
		end 
	end)
end

function ENT:PhysicsCollide(data, phys)
	if CLIENT then return end

	self:Explosive(data.HitPos)
end