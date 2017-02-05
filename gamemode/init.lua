AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("database.lua")
DEFINE_BASECLASS( "gamemode_base" )

function GM:Initialize()
  --Make sure we are starting with a clean table
  if(sql.TableExists("player_data")) then
    sql.Query("DROP TABLE player_data")
  end
  CreateTable()
end

function GM:PlayerInitialSpawn(ply)
  NewPlayerToDataBase(ply)
  print("Player "..ply:Name().." added to table")
end

function GM:PlayerSpawn(ply)
  player_manager.SetPlayerClass( ply, "player_abgg" )
  BaseClass.PlayerSpawn( self, ply )
  local plylevel = GetLevelFromDatabase(ply)
  ply:PrintMessage(HUD_PRINTTALK,"You are level "..plylevel)
end
