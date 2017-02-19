--This file contains functions related to the player
DEFINE_BASECLASS( "gamemode_base" )

function GM:PlayerInitialSpawn(ply)
  --Check if they are a returning player
  if ply:IsPlayer() != true then return end
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
  ABGGUpdateEquipment(ply,plylevel)
end

function ABGGPlayerDeath(victim, inflictor, attacker)
  --This handles leveling
  if victim:IsPlayer() and attacker:IsPlayer() and attacker != victim then
    local templevel = GetLevelFromDatabase(attacker)
    templevel = templevel + 1
    UpdateLevelToDatabase(attacker, templevel)
    ABGGUpdateEquipment(attacker,templevel)
    for k, ply in pairs(player.GetAll()) do
      if templevel == GetMaxLevel() then
        ply:ChatPrint(attacker:Nick().." is on crowbar level!!!")
      else
        ply:ChatPrint(attacker:Nick().." is on level "..templevel)
      end
    end

  else
    --They either suicided or died from a non player so remove a level
    local templevel = GetLevelFromDatabase(victim)
    templevel = templevel - 1
    if templevel <= 0 then
      templevel = 1
    end
    UpdateLevelToDatabase(victim, templevel)
    for k, ply in pairs(player.GetAll()) do
      ply:ChatPrint(victim:Nick().." went down a level and is now level "..templevel)
    end
  end
end

hook.Add("PlayerDeath","abggPlayerDeath", ABGGPlayerDeath)

function ABGGUpdateEquipment(ply,lvl)
  if ply:IsPlayer() != true then return end
  ply:RemoveAllItems()
  ply:Give( "weapon_abgg_hl2crowbar")
  if lvl == GetMaxLevel() then return end
  local tempstring = tostring(GetWeaponForLevel(lvl))
  ply:Give(tempstring)
end

--Override because we want realistic fall damage at all times
function GM:GetFallDamage(ply, speed)
  return ( speed - 526.5 ) * ( 100 / 396 ) -- the Source SDK value
end
