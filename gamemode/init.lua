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

function ABGGPlayerDeath(victim, inflictor, attacker)
  --This handles leveling
  if victim:IsPlayer() and attacker:IsPlayer() and attacker != victim then
    local templevel = GetLevelFromDatabase(attacker)
    templevel = templevel + 1
    UpdateLevelToDatabase(attacker, templevel)
    for k, ply in pairs(player.GetAll()) do
      ply:ChatPrint(attacker:Nick().." is on level "..templevel)
    end
  else
    --They either suicided or died from a non player so remove a level
    local templevel = GetLevelFromDatabase(attacker)
    templevel = templevel - 1
    if templevel <= 0 then
      templevel = 1
    end
    UpdateLevelToDatabase(attacker, templevel)
    for k, ply in pairs(player.GetAll()) do
      ply:ChatPrint(attacker:Nick().." went down a level and is now level "..templevel)
    end
  end
end

hook.Add("PlayerDeath","abggPlayerDeath", ABGGPlayerDeath)
