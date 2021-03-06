--Database Functions
--We use an SQL Table because it's a better table manager then Lua's
--Plus if you are a server operator or modder you can make better use of it

function CreateTable()
  sql.Query("DROP TABLE player_data")
  sql.Query("CREATE TABLE player_data (SteamID string, Level int)")
end

function NewPlayerToDataBase(ply)
  --We use SteamID because it's more clean and a name change won't break it
  sql.Query("INSERT INTO player_data (SteamID, Level) VALUES ( '" .. ply:SteamID() .. "', 1 )")
end

function UpdateLevelToDatabase( ply, lvl )
	 sql.Query( "UPDATE player_data SET Level = " .. lvl .. " WHERE SteamID = '" .. ply:SteamID() .. "'" )
end

function GetLevelFromDatabase(ply)
  --Query returns a table where as QueryValue will convert to a string for us
  --So we then also need to change it to a int using tonumber
  local templevel = sql.QueryValue(" SELECT Level FROM player_data WHERE SteamID = '".. ply:SteamID() .. "'")
  return tonumber(templevel)
end

function CheckPlayerExists(ply)
  local templevel = sql.QueryValue(" SELECT Level FROM player_data WHERE SteamID = '".. ply:SteamID() .. "'")
  if templevel == false or templevel == nil or templevel == 0 then
    return false
  else
    return true
  end
end
