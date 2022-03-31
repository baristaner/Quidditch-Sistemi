function tasiyan_oyuncu_oldu( victim, weapon, killer )
   local pos = victim:EyePos() +victim:GetForward()*50	
   if victim:GetNWBool("CanThrowQuaffle", true) then
   	victim:SetNWBool("CanThrowQuaffle", false)
   	local ent = ents.Create( "bt_quaffle" )
	ent:SetPos( pos )
	ent:Spawn()
	ent:Activate()
   	BroadcastLua( [[chat.AddText( Color( 255, 255, 0 ), "[Quidditch Sistemi]", Color( 255, 255, 255 )," Quaffle'a sahip oyuncu: " ,Color( 255, 0, 0 ),"]]..victim:Nick()..[[", Color( 255, 255, 255 ), " düşürdü!" )]] )
   end
end

hook.Add( "PlayerDeath", "olum_quaffle", tasiyan_oyuncu_oldu )

local function quidditch_oldu( ply )
	ply:SetNWBool("CanThrowQuaffle", false)
end
hook.Add( "PlayerInitialSpawn", "spawn_duzelt", quidditch_oldu )