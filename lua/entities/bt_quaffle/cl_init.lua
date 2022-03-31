function ENT:Think()
	if CLIENT then return end
	hook.Add( "KeyPress", "ThrowQuaffle", function( ply, key )
		local nextdo = CurTime() - 1
		if CurTime() > nextdo then
			if ply:GetActiveWeapon():GetClass() == "keys" and ( key == IN_ATTACK ) then
				if ( ply:IsValid() ) and ply:GetNWBool("CanThrowQuaffle", false) == true then
					ply:ChatPrint( "Quafflei Firlattin!" ) 
					ply:SetNWBool("CanThrowQuaffle", false)
					nextdo = CurTime() + 5

					local pos = ply:GetPos() + Vector(0,0,50)
					local ang = ply:EyeAngles()
					local vector = ply:GetAimVector()

					local a = ents.Create("bt_quaffle")
					a:SetPos(pos)
					a:SetOwner(self)
					a:Spawn()

					local dir = (ply:GetEyeTrace().HitPos - pos):GetNormal()

					local phys = a:GetPhysicsObject()

					if IsValid(phys) then
						phys:SetMass(1)
						phys:SetVelocity(vector * 3000)
						phys:ApplyForceCenter(dir * phys:GetMass() * 3000)
					end
				end
			end
		end
	end)
end

if ( SERVER ) then return end -- We do NOT want to execute anything below in this FILE on SERVER

--[[---------------------------------------------------------
	Name: Draw
-----------------------------------------------------------]]
function ENT:Draw()
	self:DrawModel()
end