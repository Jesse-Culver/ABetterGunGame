AddCSLuaFile()

SWEP.Base = "weapon_base"

SWEP.Category = "Gun Game"
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.PrintName = "Gun Game Weapon"
SWEP.Author = "Wazanator"

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 62
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.UseHands = false --The viewmodel must support it for this to work!

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.Weight = 5

SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false

SWEP.DrawCrosshair = true
SWEP.Ironsights = false

SWEP.Slot = 0 --This is the colum it will be in 0 = crowbar/stunstick/gravitygun
SWEP.SlotPos = 0 --This is the row within the colum

--Primary fire defautls
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 10 --Max ammo per clip/magazine
SWEP.Primary.DefaultClip = 10 --Starting ammo in the Clip/magazine
SWEP.Primary.ExtraAmmo = 10
SWEP.Primary.Automatic = true --does holding down fire make it continous

SWEP.Primary.Sound          = Sound( "Weapon_Pistol.Empty" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 1
SWEP.Primary.Force          = 1 --Physics force
SWEP.Primary.NumShots       = 1 --as in shots that come out at the same time like a shotgun
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.15
SWEP.Primary.Distance       = 56756


--Secondary fire defaults
SWEP.Secondary.Ammo = "Pistol"
SWEP.Secondary.ClipSize = 10 --Max ammo per clip/magazine
SWEP.Secondary.DefaultClip = 10 --Starting ammo in the Clip/magazine
SWEP.Secondary.ExtraAmmo = 10
SWEP.Secondary.Automatic = true --does holding down fire make it continous

SWEP.Secondary.Sound          = Sound( "Weapon_Pistol.Empty" )
SWEP.Secondary.Recoil         = 1.5
SWEP.Secondary.Damage         = 1
SWEP.Secondary.Force          = 1
SWEP.Secondary.NumShots       = 1
SWEP.Secondary.Cone           = 0.02
SWEP.Secondary.Delay          = 0.15
SWEP.Secondary.Distance       = 56756

SWEP.ReloadSound = Sound("weapons/pistol/pistol_reload1.wav")

--[[---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
-----------------------------------------------------------]]
function SWEP:PrimaryAttack()

  self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	-- Make sure we can shoot first
	if ( !self:CanPrimaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound(self.Primary.Sound)

	-- Shoot bullets, (damage,number,aimcone)
	self:ShootBullet( self.Primary.Damage, self.Primary.NumShots, self.Primary.Cone, self.Primary.Force, self.Primary.Distance, self.Primary.Ammo )

	-- Remove bullets from our clip/magazine
	self:TakePrimaryAmmo( self.Primary.NumShots )

	-- Punch the player's view
	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0 ) )

end


--[[---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
-----------------------------------------------------------]]
function SWEP:SecondaryAttack()

  self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
  self:SetNextPrimaryFire( CurTime() + self.Secondary.Delay )
	-- Make sure we can shoot first
	if ( !self:CanSecondaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound(self.Secondary.Sound)

	-- Shoot bullets, (damage,number,aimcone)
	self:ShootBullet( self.Secondary.Damage, self.Secondary.NumShots, self.Secondary.Cone, self.Secondary.Force, self.Primary.Distance, self.Secondary.Ammo )

	-- Remove bullets from our clip/magazine
	self:TakeSecondaryAmmo( self.Secondary.NumShots )

	-- Punch the player's view
	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Secondary.Recoil, math.Rand(-0.1,0.1) * self.Secondary.Recoil, 0 ) )

end


--[[---------------------------------------------------------
   Name: SWEP:Reload( )
   Desc: Reload is being pressed
-----------------------------------------------------------]]
function SWEP:Reload()
  if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
  self.Weapon:EmitSound(self.ReloadSound)
	self:DefaultReload(self.ReloadAnim)
end

--[[---------------------------------------------------------
   Name: SWEP:ShootBullet( )
   Desc: A convenience function to shoot bullets
-----------------------------------------------------------]]
function SWEP:ShootBullet( damage, num_bullets, aimcone, force, distance, ammo )

  self:SendWeaponAnim(self.PrimaryAnim)
  self.Owner:MuzzleFlash()
  self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local bullet = {}
	bullet.Num 		= num_bullets
	bullet.Src 		= self.Owner:GetShootPos()			-- Source
	bullet.Dir 		= self.Owner:GetAimVector()			-- Dir of bullet
	bullet.Spread 	= Vector( aimcone, aimcone, 0 )		-- Aim Cone
	bullet.Tracer	= 1								-- Show a tracer on every x bullets
	bullet.Force	= force									-- Amount of force to give to phys objects
	bullet.Damage	= damage
  bullet.Distance = distance
  bullet.AmmoType = ammo

	self.Owner:FireBullets( bullet )

end

function SWEP:Equip(NewOwner)
  NewOwner:SetAmmo(self.Primary.ExtraAmmo, self.Primary.Ammo)
  NewOwner:SetAmmo(self.Secondary.ExtraAmmo, self.Secondary.Ammo)
end
