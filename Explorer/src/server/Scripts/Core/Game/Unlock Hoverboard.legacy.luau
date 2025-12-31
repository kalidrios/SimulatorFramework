-- this script was maded by szythe
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local Signal = ReplicatedStorage:WaitForChild('Library').Signal
local Saving = require(ReplicatedStorage:WaitForChild('Library')).Saving
local Network = require(ReplicatedStorage:WaitForChild('Library')).Network
local Gamepasses = require(ReplicatedStorage:WaitForChild('Library')).Gamepasses
local Directory = require(ReplicatedStorage:WaitForChild('Library')).Directory

local Debug = RunService:IsStudio()
local OwnsHoverboard = false
local OwnsVIP = false

local function AddHoverboard(player, hoverboardName)
	local save = Saving.Get(player)
	if not save then return end

	if not table.find(save.Hoverboards, hoverboardName) then
		if Debug then
			warn('Hoverboard', hoverboardName, 'is being added to player inventory')
		end

		table.insert(save.Hoverboards, hoverboardName)
		Network.Fire('Hoverboard Unlocked', player, hoverboardName)
		save.EquippedHoverboard = hoverboardName
	end
end

local function Update(player)
	local groupRank = player:GetRankInGroup(1072042)
	local save = Saving.Get(player)
	local robuxSpent = save.RobuxSpent or 0

	if not save then return end

	if Debug then
		warn('Checking hoverboards & rewarding them')
	end

	if OwnsHoverboard then
		local hoverboardsToUnlock = {
			'Original', 'VIP', 'Bee', 'Steampunk', 'Sleigh',
			'Rudolph', 'Cat', 'Red Flying Carpet', 'Rainbow', 'Purple', 'Pumpkin Cat',
			'M-10', 'High Tech', 'Flame', 'M-10', 'Easter Bunny', 'Doodle',
			'Diamond Cat', 'Blue Flying Carpet', 'Bling'
		}

		for _, hoverboardName in pairs(hoverboardsToUnlock) do
			AddHoverboard(player, hoverboardName)
		end
	end

	if OwnsVIP and OwnsHoverboard then
		AddHoverboard(player, 'VIP')
	end

	if groupRank == 254 then
		AddHoverboard(player, 'Flame')
	end

	if robuxSpent >= 100 then
		AddHoverboard(player, 'Bling')
	end

	if _G.LBSpot >= 100 or _G.LBSpotRAP >= 100 then
		AddHoverboard(player, 'Red Flying Carpet')
	end

	if _G.LBSpot >= 10 or _G.LBSpotRAP >= 10 then
		AddHoverboard(player, 'Blue Flying Carpet')
	end

	if save.Diamonds >= Directory.Currency['Diamonds'].Limit then
		AddHoverboard(player, 'Diamond')
	end
end

local function PlayerAdded(player)
	_G.LBSpot = 0
	_G.LBSpotRAP = 0

	OwnsHoverboard = Gamepasses.Owns(player, Directory.Gamepasses.Hoverboard.ID)
	OwnsVIP = Gamepasses.Owns(player, Directory.Gamepasses.VIP.ID)

	while true do
		if not player or not player.Parent then
			if Debug then
				warn('No player, ending hoverboard loop')
			end
			break
		end

		Update(player)

		wait(10)
	end
end

local function StatChanged(player, stat)
	if stat == 'Gamepasses' then
		if not OwnsHoverboard then
			OwnsHoverboard = Gamepasses.Owns(player, Directory.Gamepasses.Hoverboard.ID)
		end

		if not OwnsVIP then
			OwnsVIP = Gamepasses.Owns(player, Directory.Gamepasses.VIP.ID)
		end
	end
end

Signal.Fired('Player Added').Connect(PlayerAdded)
Signal.Fired('Stat Changed').Connect(StatChanged)

for _, player in pairs(Players:GetPlayers()) do
	PlayerAdded(player)
end
--[[ Last synced 9/21/2025 04:55                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Às vezes é mais fácil desistir mesmo ]]    --[[                                                                                                  ]]--