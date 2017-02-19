--Contains functions related to the weapon table

local weapon_table = {
};

--Checks if the proper files exist then fills the weapon table
function CreateWeaponTable()
  if file.Exists("abgg","DATA") then
    print("abgg folder exists")
  else
    print("abgg folder does not exist, creating it")
    file.CreateDir("abgg")
  end
  if file.Exists("weapons.txt","DATA/abgg") then
    print("Reading in weapons.txt file")
    FillWeaponTable()
  else
    print("Creating weapons file")
    local tempWeaponTable = [[
weapon_abgg_hl2pistol
weapon_abgg_hl2smg1
weapon_abgg_hl2357]]
    file.Write("abgg/weapons.txt", tempWeaponTable)
    FillWeaponTable()
  end
end

function FillWeaponTable()
  local weaponFile = file.Read("abgg/weapons.txt")
  weaponFile  = string.Explode("\n", weaponFile)
  for k, v in pairs(weaponFile) do
    table.insert(weapon_table,k,v)
  end
end

function GetMaxLevel()
  return #weapon_table + 1
end

function RandomizeWeaponOrder()
  print("Original Weapon Order")
  PrintTable(weapon_table)
  local upperBound = #weapon_table
  local tempTable = {
};
  for i=1,upperBound do
    local tempRand = math.random(#weapon_table)
    table.insert(tempTable,weapon_table[tempRand])
    table.remove(weapon_table,tempRand)
  end
  table.CopyFromTo(tempTable,weapon_table)
  print("New Weapon Order")
  PrintTable(weapon_table)
      print("Weapon 1 is "..weapon_table[1])
end

function GetWeaponForLevel(lvl)
  //print("Player is lvl "..lvl)
  print("Player is getting a "..weapon_table[lvl])
  return weapon_table[lvl]
end
