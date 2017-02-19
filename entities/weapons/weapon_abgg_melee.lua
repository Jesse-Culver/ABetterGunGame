AddCSLuaFile()
--A lot of the melee code is from TTT's crowbar
SWEP.Base = "weapon_abgg_base"

SWEP.HoldType = "melee"

SWEP.Spawnable = false
SWEP.PrintName = "melee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.AutoSwitchTo = true
SWEP.Weight = 1
SWEP.Slot = 0 --This is the colum it will be in 0 = crowbar/stunstick/gravitygun
SWEP.SlotPos = 0 --This is the row within the colum

--Primary fire defautls
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false --does holding down fire make it continous

SWEP.Primary.Sound          = Sound( "Weapon_Crowbar.Single" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 12
SWEP.Primary.Force          = 1 --Physics force
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.15

--Secondary fire defaults
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = 0 --Max ammo per clip/magazine
SWEP.Secondary.DefaultClip = 0 --Starting ammo in the Clip/magazine
SWEP.Secondary.Automatic = false --does holding down fire make it continous

function SWEP:PrimaryAttack()
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if ( !self:CanPrimaryAttack() ) then return end

   local spos = self.Owner:GetShootPos()
   local sdest = spos + (self.Owner:GetAimVector() * 70)

   local tr_main = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL})
   local hitEnt = tr_main.Entity

   self.Weapon:EmitSound(self.Primary.Sound)

   if IsValid(hitEnt) or tr_main.HitWorld then
      self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )

      if not (CLIENT and (not IsFirstTimePredicted())) then
         local edata = EffectData()
         edata:SetStart(spos)
         edata:SetOrigin(tr_main.HitPos)
         edata:SetNormal(tr_main.Normal)
         edata:SetSurfaceProp(tr_main.SurfaceProps)
         edata:SetHitBox(tr_main.HitBox)
         --edata:SetDamageType(DMG_CLUB)
         edata:SetEntity(hitEnt)

         if hitEnt:IsPlayer() or hitEnt:GetClass() == "prop_ragdoll" then
            util.Effect("BloodImpact", edata)
            -- do a bullet just to make blood decals work sanely
            -- need to disable lagcomp because firebullets does its own
            self.Owner:LagCompensation(false)
            self.Owner:FireBullets({Num=1, Src=spos, Dir=self.Owner:GetAimVector(), Spread=Vector(0,0,0), Tracer=0, Force=1, Damage=0})
         else
            util.Effect("Impact", edata)
         end
      end
   else
      self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
   end


   if CLIENT then
      -- used to be some shit here
   else -- SERVER

      -- Do another trace that sees nodraw stuff like func_button
      local tr_all = nil
      tr_all = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner})

      self.Owner:SetAnimation( PLAYER_ATTACK1 )

      if hitEnt and hitEnt:IsValid() then
         local dmg = DamageInfo()
         dmg:SetDamage(self.Primary.Damage)
         dmg:SetAttacker(self.Owner)
         dmg:SetInflictor(self.Weapon)
         dmg:SetDamageForce(self.Owner:GetAimVector() * 1500)
         dmg:SetDamagePosition(self.Owner:GetPos())
         dmg:SetDamageType(DMG_CLUB)

         hitEnt:DispatchTraceAttack(dmg, spos + (self.Owner:GetAimVector() * 3), sdest)
      else
         -- See if our nodraw trace got the goods
         if tr_all.Entity and tr_all.Entity:IsValid() then
            self:OpenEnt(tr_all.Entity)
         end
      end
   end
end


function SWEP:CanSecondaryAttack()
  return false
end
