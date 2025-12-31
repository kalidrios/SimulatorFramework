local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local collisionGroup = "Players"
PhysicsService:CreateCollisionGroup(collisionGroup)
PhysicsService:CollisionGroupSetCollidable(collisionGroup, collisionGroup, false)

local previousCollisionGroups = {}

local function setCollisionGroup(object)
	if object:IsA("BasePart") then
		previousCollisionGroups[object] = object.CollisionGroupId
		PhysicsService:SetPartCollisionGroup(object, collisionGroup)
	end
end

local function setCollisionGroupRecursive(object)
	setCollisionGroup(object)

	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end

local function resetCollisionGroup(object)
	local previousCollisionGroupId = previousCollisionGroups[object]
	if not previousCollisionGroupId then return end 

	local previousCollisionGroupName = PhysicsService:GetCollisionGroupName(previousCollisionGroupId)
	if not previousCollisionGroupName then return end

	PhysicsService:SetPartCollisionGroup(object, previousCollisionGroupName)
	previousCollisionGroups[object] = nil
end

local function onCharacterAdded(character)
	setCollisionGroupRecursive(character)

	character.DescendantAdded:Connect(setCollisionGroup)
	character.DescendantRemoving:Connect(resetCollisionGroup)
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end

Players.PlayerAdded:Connect(onPlayerAdded)


PhysicsService = game:GetService('PhysicsService')

PhysicsService:CreateCollisionGroup('Coins')
PhysicsService:CreateCollisionGroup('Orbs')
PhysicsService:CreateCollisionGroup('Lootbags')
PhysicsService:CreateCollisionGroup('Yeet')


PhysicsService:CollisionGroupSetCollidable('Coins', 'Players', true)
PhysicsService:CollisionGroupSetCollidable('Coins', 'Orbs', false)
PhysicsService:CollisionGroupSetCollidable('Coins', 'Lootbags', false)
PhysicsService:CollisionGroupSetCollidable('Coins', 'Yeet', false)

PhysicsService:CollisionGroupSetCollidable('Lootbags', 'Orbs', false)
PhysicsService:CollisionGroupSetCollidable('Lootbags', 'Players', false)
PhysicsService:CollisionGroupSetCollidable('Lootbags', 'Coins', false)
PhysicsService:CollisionGroupSetCollidable('Lootbags', 'Yeet', false)

PhysicsService:CollisionGroupSetCollidable('Orbs', 'Coins', false)
PhysicsService:CollisionGroupSetCollidable('Orbs', 'Lootbags', false)
PhysicsService:CollisionGroupSetCollidable('Orbs', 'Players', false)
PhysicsService:CollisionGroupSetCollidable('Orbs', 'Yeet', false)

PhysicsService:CollisionGroupSetCollidable('Yeet', 'Coins', false)
PhysicsService:CollisionGroupSetCollidable('Yeet', 'Lootbags', false)
PhysicsService:CollisionGroupSetCollidable('Yeet', 'Players', false)
--[[ Last synced 9/21/2025 04:56                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Às vezes é mais fácil desistir mesmo ]]    --[[                                                                                                  ]]--