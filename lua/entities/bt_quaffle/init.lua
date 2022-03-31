include("shared.lua") 
function ENT:Initialize()

	-- We do NOT want to execute anything below in this FUNCTION on CLIENT
	if ( CLIENT ) then return end

	self:SetModel( "models/models/quaffle/quaffle.mdl" )
	self:SetModelScale( 1, 0 )

    self.Entity:PhysicsInit( SOLID_VPHYSICS )   
    self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
    self.Entity:SetSolid( SOLID_VPHYSICS )

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
	    phys:Wake()
		--phys:SetMass(50)
        phys:EnableMotion(true)
	end

	self.Entity.pos = self.Entity:GetPos()
end

function ENT:OnTakeDamage( dmginfo )
	-- React physically when shot/getting blown
	self:TakePhysicsDamage( dmginfo )
end

function ENT:Touch( entity )
	local ply = entity

	if ( ply:IsPlayer() ) then
		if ply:GetNWBool("CanThrowQuaffle", false) != true then
			self:Remove()
			ply:SetNWBool("CanThrowQuaffle", true)
			ply:ChatPrint( "Quaffle Sende" )

		end
	elseif ply:GetClass() == "kekc_broom_ent" || ply:GetClass() == "kekc_broom_nim2000" || ply:GetClass() == "kekc_broom_nim2001" || ply:GetClass() == "kekc_broom_atesoku" then
		if ply:GetNWBool("CanThrowQuaffle", false) != true then
			self:Remove()
			ply:SetNWBool("CanThrowQuaffle", true)

		timer.Create( "quaffle_dusur", 4, 1, function()
			if ply:GetNWBool("CanThrowQuaffle", true) then
	            ply:SetNWBool("CanThrowQuaffle", false)
                BroadcastLua( [[chat.AddText( Color( 100, 100, 255 ), "[Quidditch Sistemi]", Color( 255, 255, 255 ), " Quaffle dusuruldu! ")]] )
                local pos = ply:GetPos() + Vector(0,80,0)
	            local a = ents.Create("bt_quaffle")
                a:SetPos(pos)
	            a:SetOwner(self)
	            a:Spawn()
	        end
            end)
		end
	end
end


function ENT:Think()
	if CLIENT then return end
	hook.Add( "KeyPress", "ThrowQuaffle", function( ply, key )
		local nextdo = CurTime() - 1
		if CurTime() > nextdo then
			if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "keys" and ( key == IN_ATTACK ) then
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



function EntityTakeDamage( target, dmginfo)
	if( target:IsPlayer() and dmginfo:IsDamageType( DMG_GENERIC )) then 
		dmginfo:SetDamage( 0 ) 
		target:TakeDamage( 1 )
	end
end
hook.Add("EntityTakeDamage", "Get Damage", EntityTakeDamage)
