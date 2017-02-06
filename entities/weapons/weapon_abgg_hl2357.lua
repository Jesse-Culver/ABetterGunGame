AddCSLuaFile()

SWEP.Base = "weapon_abgg_base"

SWEP.HoldType = "revolver"

SWEP.Spawnable = true
SWEP.PrintName = ".357"

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.UseHands = true

SWEP.Slot = 1 --This is the colum it will be in 0 = crowbar/stunstick/gravitygun
SWEP.SlotPos = 0 --This is the row within the colum

--Primary fire defautls
SWEP.Primary.Ammo = "357"
SWEP.Primary.ClipSize = 6 --Max ammo per clip/magazine
SWEP.Primary.DefaultClip = 6 --Starting ammo in the Clip/magazine
SWEP.Primary.ExtraAmmo = 30
SWEP.Primary.Automatic = false --does holding down fire make it continous

SWEP.Primary.Sound          = Sound( "weapons/357/357_fire2.wav" )
SWEP.Primary.Recoil         = 2.5
SWEP.Primary.Damage         = 75
SWEP.Primary.Force          = 20 --Physics force
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.25

--Secondary fire defaults
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = 0 --Max ammo per clip/magazine
SWEP.Secondary.DefaultClip = 0 --Starting ammo in the Clip/magazine
SWEP.Secondary.Automatic = false --does holding down fire make it continous

SWEP.ReloadSound = Sound("")

function SWEP:CanSecondaryAttack()
  return false
end
