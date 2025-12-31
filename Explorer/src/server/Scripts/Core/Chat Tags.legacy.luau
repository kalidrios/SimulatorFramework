--------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------
local ChatService = require(game.ServerScriptService:WaitForChild("ChatServiceRunner"):WaitForChild("ChatService"))

--------|    Variables    |--------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if not game.ServerScriptService:WaitForChild("ChatServiceRunner") then
	return
end

--- Return the correct chat tag style for this player depending on their group rankings/misc stuff
function GetStyle(player)
    local function FindCustomTag(userId)
        for _, customData in ipairs(_L.Settings.CustomChatTags) do
            if _L.Functions.SearchArray(customData.userIds, userId) then
                return customData.tag
            end
        end
    end

    -- save
    local save = _L.Saving.Get(player)
    if not save then
        return nil
    end

    --- Find correct tag
    local customTag = FindCustomTag(player.UserId)
    if customTag then
        return customTag

    elseif _L.Admins.IsAdmin(player) then
        local rank = player:GetRankInGroup(1072042)

        --- Owner
        if rank == 255 or rank == 254 then
            return {
                tag = "⚡God", 
                tagColor = Color3.fromRGB(236, 255, 0), 
                chatColor = Color3.fromRGB(250, 255, 180), 
                nameColor = Color3.fromRGB(255, 38, 230)
            }

            --- Developer
        elseif rank == 100 then
            return {
                tag = "🔨Devloper", 
                tagColor = Color3.fromRGB(255, 56, 114),
                chatColor = Color3.fromRGB(243, 188, 210), 
                nameColor = Color3.fromRGB(29, 107, 231),
            }

            --- Community Manager
        elseif rank == 10 then
            return {
                tag = "🌴Community Manager",
                tagColor = Color3.fromRGB(56, 255, 189), 
                chatColor = Color3.fromRGB(204, 255, 221),
                nameColor = Color3.fromRGB(56, 255, 189),
            }

            --- Admin
        elseif rank == 3 then
            return {
                tag = "🛠️Administrator", 
                tagColor = Color3.fromRGB(157, 23, 240), 
                chatColor = Color3.fromRGB(222, 193, 240),
            }

            --- Moderator
        else
            return {
                tag = "🔧Moderator", 
                tagColor = Color3.fromRGB(220, 162, 247), 
                chatColor = Color3.fromRGB(239, 223, 247),
            }
        end

    else
        local rank = player:GetRankInGroup(3112828)
        local rankWorldwide = _L.Signal.Invoke("Get Leaderboard Position", player) or 0
        local pwrRankWorldwide = _L.Signal.Invoke("Get Power Leaderboard Position", player) or 0
        if rankWorldwide < pwrRankWorldwide then
            rankWorldwide = pwrRankWorldwide
        end



        --- Partner
        if rank == 5 then
            return {
                tag = "🔥Partner", 
                tagColor = Color3.fromRGB(255, 136, 0),
                nameColor = Color3.fromRGB(255, 191, 0),
			}
			
		elseif rank == 10 then
			return {
				tag = "💗Booster", 
				tagColor = Color3.fromRGB(255, 207, 249),
				nameColor = Color3.fromRGB(255, 244, 254),
			}

            --- Top 100 Rank
        elseif rankWorldwide and rankWorldwide <= 100 and rankWorldwide >= 1 then
            return {
                tag = "🌎" .. string.format("#%d", rankWorldwide),
                tagColor = Color3.fromRGB(135, 255, 239)
            }
            --- Affiliate
        elseif rank == 15 then
            return {
                tag = "🛠Affiliate", 
                tagColor = Color3.fromRGB(135, 255, 239),
            }

            --- VIP
        elseif _L.Gamepasses.Owns(player, _L.Directory.Gamepasses["VIP"].ID) then
            return {
                tag = "👑VIP", 
                tagColor = Color3.fromRGB(221, 229, 66), 
                chatColor = Color3.fromRGB(223, 229, 156),
                nameColor = Color3.fromRGB(246, 255, 64),
            }

            --- Verified
        elseif save.IsFollowingOnTwitter then
            return {
                tag = "✅Verified", 
                tagColor = Color3.fromRGB(113, 220, 99)
            }

            --- Fan
        elseif player:IsInGroup(3112828) then
            return {
                tag = "Fan", 
                tagColor = Color3.fromRGB(229, 151, 86)
            }
        end
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- Player has joined
ChatService.SpeakerAdded:Connect(function(SpeakerName)
    local t = tick()
    repeat
        --- Get speaker & player
        local success = false
        local player = game.Players:FindFirstChild(SpeakerName)
        local speaker = ChatService:GetSpeaker(SpeakerName)

        --- Update chat & tag style settings
        if speaker and player then
            local styleData = GetStyle(player)
            --
            if styleData then
                --- Custom
                local tag, tagColor, chatColor, nameColor = styleData.tag, styleData.tagColor, styleData.chatColor, styleData.nameColor
                speaker:SetExtraData("Tags", {{TagText = tag, TagColor = tagColor}})
                speaker:SetExtraData("ChatColor", chatColor)
				speaker:SetExtraData("NameColor", nameColor or Color3.fromRGB(175, 175, 175))
			
            else
                --- Default
                speaker:SetExtraData("NameColor", Color3.fromRGB(175, 175, 175))
            end
            --
            success = true
        end

        wait(1)
    until (not success)
end)

--[[ Last synced 9/21/2025 04:51                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Às vezes é mais fácil desistir mesmo ]]    --[[                                                                                                  ]]--