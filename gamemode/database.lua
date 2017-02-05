--Database Functions

function CreateTable()
  sql.Query("CREATE TABLE player_data (SteamID string, Level init)")
end

function NewPlayerToDataBase(ply)
  --We use SteamID because it's more clean and a name change won't break it
  sql.Query("INSERT INTO player_data (SteamID, Level) VALUES ( '" .. ply:SteamID() .. "', 1 )")
end

function UpdateLevelToDatabase( ply, lvl )
	 sql.Query( "UPDATE player_data SET Level = " .. lvl .. " WHERE SteamID = '" .. ply:SteamID() .. "'" )
end

function GetLevelFromDatabase(ply)
  --Query returns a table where as QueryValue will convert to a number for us
  local templevel = sql.QueryValue(" SELECT Level FROM player_data WHERE SteamID = '".. ply:SteamID() .. "'")
  return templevel
end
