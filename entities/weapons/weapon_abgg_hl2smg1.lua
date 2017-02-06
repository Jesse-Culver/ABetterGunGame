AddCSLuaFile()

SWEP.Base = "weapon_abgg_base"

SWEP.HoldType = "smg"

SWEP.Spawnable = true
SWEP.PrintName = "MP7"

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 54

SWEP.Slot = 2 --This is the colum it will be in 0 = crowbar/stunstick/gravitygun
SWEP.SlotPos = 0 --This is the row within the colum

--Primary fire defautls
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 45 --Max ammo per clip/magazine
SWEP.Primary.DefaultClip = 45 --Starting ammo in the Clip/magazine
SWEP.Primary.ExtraAmmo = 225
SWEP.Primary.Automatic = true --does holding down fire make it continous

SWEP.Primary.Sound          = Sound( "weapons/smg1/smg1_fire1.wav" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 4
SWEP.Primary.Force          = 1 --Physics force
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.08
SWEP.Primary.Delay          = 0.1

--Secondary fire defaults
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = 0 --Max ammo per clip/magazine
SWEP.Secondary.DefaultClip = 0 --Starting ammo in the Clip/magazine
SWEP.Secondary.Automatic = false --does holding down fire make it continous

SWEP.ReloadSound = Sound("weapons/smg1/smg1_reload.wav")

function SWEP:CanSecondaryAttack()
  return false
end
