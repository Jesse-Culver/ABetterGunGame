AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

include("database.lua")
include("player.lua")
include("weapontable.lua")
DEFINE_BASECLASS( "gamemode_base" )

function GM:Initialize()
  --Make sure we are starting with a clean table
  CreateTable()
  CreateWeaponTable()
  RandomizeWeaponOrder()
end
