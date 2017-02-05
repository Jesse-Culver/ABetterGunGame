AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("database.lua")
DEFINE_BASECLASS( "gamemode_base" )

function GM:Initialize()
  --Make sure we are starting with a clean table
  CreateTable()
end

function GM:PlayerInitialSpawn(ply)
  --Check if they are a returning player
  if CheckPlayerExists(ply) then
    print("Player "..ply:Name().." has rejoined the server")
    return
  end
  --Add them to the table
  NewPlayerToDataBase(ply)
  --Make sure they are added to the table, if we can't add them then they should be kicked
  if CheckPlayerExists(ply) then
    print("Player "..ply:Name().." added to table")
  else
    print("ERROR: Player "..ply:Name().." not added to table! Kicking them")
    ply:Kick("Could not add you to the SQL Table, please try rejoining")
  end
end

function GM:PlayerSpawn(ply)
  player_manager.SetPlayerClass( ply, "player_abgg" )
  BaseClass.PlayerSpawn( self, ply )
  local plylevel = GetLevelFromDatabase(ply)
  ply:PrintMessage(HUD_PRINTTALK,"You are level "..plylevel)
end
