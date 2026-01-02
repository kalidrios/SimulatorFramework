local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))

while not _L.Loaded do
	game:GetService("RunService").Heartbeat:Wait()
end

local selectedStarter = nil
local StarterGUI = _L.GUI.Starter
local isPickingStarter = false

-- Function to set up the starter selection GUI
function Setup()
	if _L.Save.Get().PickedStarter then
		return
	end

	local function SelectStarter(starterName)
		selectedStarter = starterName

		-- Update the visual appearance of the selected starter button
		for _, button in ipairs(StarterGUI.Pets:GetChildren()) do
			if button.ClassName == "TextButton" then
				local isSelected = button.Name == selectedStarter
				button.Picked.Visible = isSelected
				button.BackgroundColor3 = isSelected and Color3.fromRGB(69, 239, 69) or Color3.fromRGB(39, 233, 55)
			end
		end

		StarterGUI.Pick.Visible = true
	end

	-- Connect the starter buttons to the selection function
	for _, button in ipairs(StarterGUI.Pets:GetChildren()) do
		if button.ClassName == "TextButton" then
			button.Activated:Connect(function()
				if not isPickingStarter then
					isPickingStarter = true
					SelectStarter(button.Name)
					isPickingStarter = false
				end
			end)
		end
	end

	-- Function to handle picking the starter
	local function PickStarter()
		if selectedStarter then
			local success, petName = _L.Network.Invoke("Pick Starter", selectedStarter)
			if success then
				-- Play a sound, disable the GUI, and invoke a signal to rename the pet
				_L.Audio.Play(113921203653235, script, 1, 0.65)
				StarterGUI.Gui.Enabled = false
				_L.Signal.Invoke("Rename Pet", petName)
				_L.Variables.PickingStarter = false
			else
				_L.Message.New("Failed to pick starter pet! (unknown reason)")
				return
			end
		else
			return
		end
	end

	-- Connect the pick button to the picking function
	StarterGUI.Pick.Activated:Connect(function()
		if not isPickingStarter then
			isPickingStarter = true
			PickStarter()
			isPickingStarter = false
		end
	end)

	StarterGUI.Gui.Enabled = true
	_L.Variables.PickingStarter = true

	-- Set the selected object for gamepad navigation
	task.defer(function()
		if _L.UserInputService.GamepadEnabled then
			_L.GuiService.SelectedObject = _L.GUI.Starter.Frame.Pets.cat
		end
	end)
end

-- Apply button effects to the pick button and starter buttons
_L.GUIFX.ButtonFX(StarterGUI.Pick)
for _, button in ipairs(StarterGUI.Pets:GetChildren()) do
	if button.ClassName == "TextButton" then
		_L.GUIFX.ButtonFX(button)
	end
end

while not _L.Save.Get() do
	_L.Heartbeat()
end

Setup()