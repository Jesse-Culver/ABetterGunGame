AddCSLuaFile()

SWEP.Base = "weapon_abgg_base"

SWEP.HoldType = "pistol"

SWEP.Spawnable = true
SWEP.PrintName = "USP Match"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.Slot = 1 --This is the colum it will be in 0 = crowbar/stunstick/gravitygun
SWEP.SlotPos = 0 --This is the row within the colum

--Primary fire defautls
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 18 --Max ammo per clip/magazine
SWEP.Primary.DefaultClip = 18 --Starting ammo in the Clip/magazine
SWEP.Primary.ExtraAmmo = 90
SWEP.Primary.Automatic = false --does holding down fire make it continous

SWEP.Primary.Sound          = Sound( "weapons/pistol/pistol_fire2.wav" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 12
SWEP.Primary.Force          = 1 --Physics force
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.04
SWEP.Primary.Delay          = 0.15

--Secondary fire defaults
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = 0 --Max ammo per clip/magazine
SWEP.Secondary.DefaultClip = 0 --Starting ammo in the Clip/magazine
SWEP.Secondary.Automatic = false --does holding down fire make it continous

SWEP.ReloadSound = Sound("weapons/pistol/pistol_reload1.wav")

function SWEP:CanSecondaryAttack()
  return false
end
