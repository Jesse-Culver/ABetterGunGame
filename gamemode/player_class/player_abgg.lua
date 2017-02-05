AddCSLuaFile()
DEFINE_BASECLASS("player_default")

local PLAYER = {}

PLAYER.WalkSpeed = 300
PLAYER.RunSpeed = 300

function PLAYER:Loadout()
  self.Player:RemoveAllAmmo()
  self.Player:RemoveAllItems()
  self.Player:Give( "weapon_crowbar")
end

player_manager.RegisterClass("player_abgg", PLAYER, "player_default")
