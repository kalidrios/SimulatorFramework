-- https://github.com/kalidrios

local m_Library = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not m_Library.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end
local IsStudio_ret = m_Library.RunService:IsStudio();
if IsStudio_ret then
	game:GetService("StarterGui"):SetCore("ChatActive", false);
end
