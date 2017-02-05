AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
DEFINE_BASECLASS( "gamemode_base" )

function GM:Initialize()

end

function GM:PlayerSpawn(ply)
  player_manager.SetPlayerClass( ply, "player_abgg" )
  BaseClass.PlayerSpawn( self, ply )
end
