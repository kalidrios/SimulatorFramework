--[[
    
    Datastore module
    This module will either get a Firebase(global saving)
    or the normal Roblox database.
    
]]--[[Variables]]--
local IsServer             = game:GetService("RunService"):IsServer()
local Enabled              = game:GetService("ReplicatedStorage"):GetAttribute("Firebase")
local DataStoreService     = game:GetService("DataStoreService")
local ServerScriptService  = IsServer and game:GetService("ServerScriptService") or nil
local FirebaseService      = IsServer and require(ServerScriptService["__FIREBASE"]) or nil
-------------------------------------------------------------------------------------------------------------------------------

if not Enabled then
	return game:GetService("DataStoreService")
end

if IsServer then
	return FirebaseService
else
	return DataStoreService
end
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------