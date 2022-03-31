
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = true
ENT.PrintName = "FireStar broom"
ENT.Category = "Harry Potter"

local quaffleyazirenk = Color(255, 69, 0)

function ENT:SpawnFunction(ply, tr, name)
	if not tr.Hit then return end

	local pos = tr.HitPos + tr.HitNormal * 32
	
	local ent = ents.Create("kekc_broom_ent")
	ent:SetPos(pos)
	ent:SetAngles(Angle(0, 0, 180))
	ent:Spawn()
	ent:Activate()
	
	// set up variables
	ent.NextAttack = 0
	ent.Speed = 800
	ent.Class = self.PrintName
	ent:CreateGhost()
	
	if ent.Broom and ent.Broom:IsValid() then ent.Broom:SetColor(Color(150, 150, 255)) end
	
	if IsValid(ent:GetPhysicsObject()) then ent:GetPhysicsObject():Wake() else return NULL end
	
	return ent
end

hook.Add("KeyPress", "broomfs_KeyPress", function(ply, key)
	if CLIENT then return end

	local ent = ply:GetNWEntity("broom_active")
	if not ent:IsValid() or ent.Class != "FireStar broom" then return end //only for fire star

	if key == IN_ATTACK and CurTime() > ent.NextAttack then
		local fb = ents.Create("bt_quaffle")
		local forw = ent:GetAngles():Forward()
		fb:SetPos(ent:GetPos() + forw * 200)
		fb:Spawn()
		fb:SetOwner(ply)
		fb:GetPhysicsObject():EnableGravity(false)
		fb:GetPhysicsObject():SetVelocity(ent:GetAngles():Forward() * 99999999999)
		
		local ef = EffectData()
		ef:SetOrigin(ent:GetPos() + forw * 80)
		ef:SetAngles(ent:GetAngles())
		util.Effect("effect_ring_kekc", ef)
		
		ent.NextAttack = CurTime() + 0.1
	end
end)