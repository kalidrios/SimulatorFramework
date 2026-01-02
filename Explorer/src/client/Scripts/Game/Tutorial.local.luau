-- https://github.com/kalidrios

local m_Library = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not m_Library.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end
local t_cost = m_Library.Directory.Eggs["Cracked Egg"].cost;
function Finished() -- Line: 25
	--[[
		Upvalues:
			[1] = m_Library
	--]]
	m_Library.Signal.Fire("Notification", "Nice! You can afford your first box! Go buy it!", {
		color = Color3.fromRGB(255, 243, 62),
		time = 7
	});
	m_Library.Signal.Fire("Fireworks Animation");
end
function Progress() -- Line: 31
	--[[
		Upvalues:
			[1] = m_Library
			[2] = t_cost
	--]]
	local v1 = m_Library.Save.Get();
	if not v1 then return end
	local t_TutorialProgress = v1.TutorialProgress;
	if t_TutorialProgress < 100 then
		m_Library.Signal.Fire("Notification", "(" .. t_TutorialProgress .. "%) Save up " .. t_cost .. " Coins");
	end
end
m_Library.Signal.Fired("Stat Changed"):Connect(function(p1) -- Line: 44
	if p1 == "TutorialProgress" then
		Progress();
	end
end);
m_Library.Network.Fired("Finished Tutorial"):Connect(function() -- Line: 51
	Finished();
end);
