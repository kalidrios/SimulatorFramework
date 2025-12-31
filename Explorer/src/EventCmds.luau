-- its june and i making a game instead study for my entrance exame 
local v6 = game:GetService("Players")
local v9 = (game:GetService("ReplicatedStorage")):WaitForChild("Library")
local v12 = v9:WaitForChild("Client")
local v18 = require(v9.Directory)
local v21 = require(v9.Shared)
local v24 = require(v9.Functions)
local v27 = require(v12.Save)
local v30 = require(v12.Network)
local v33 = require(v9:WaitForChild("Types").Events)
local v34 = {
	Directory = v18.Events,
	Get = function(p1, p2)
        assert(v18.Events[p1])
        local v43, v44 = unpack(string.split(p2, "-"))
        assert(v43)
        local v47 = v44
        if v47 then
            if typeof(v44) ~= "string" then
                v47 = false
            end
            v47 = true
        end
        assert(v47)
        local v54 = tonumber(v44)
        v50 = v54
        assert(v50)
        local v56 = v18
        local v57 = v56.Events
        assert(v57[p1][v43][v54])
        local v61 = v27
        local v63 = v61.Get()
        if not v63 then
            v57 = v33
            v61 = v57.DefaultData
            return v61
        end
        local v72 = v63.Events[p1]
        if not v72 then
            v56 = v33.DefaultData
            return v56
        end
        local v66 = v72[p2]
        if not v66 then
            v65 = v33.DefaultData
            return v65
        end
        return v66
    end
}
v34.GetPoints = function()
local v74 = v27
local v76 = v74.Get()
if not v76 then
	v74 = 0
	return v74
end
return v76.Stars or 0
end
v30.Fired("Events: Update"):Connect(function(p3, p4, p5)
    local v84 = v27.Get()
    if not v84 then
        return 
    end
    local v91 = v84.Events
    local v85 = v91[p3]
    if not v85 then
        v85 = {}
        v91[p3] = v85
    end
    assert(v85)
    v85[p4] = p5
    v21.SignalStatUpdated(v6.LocalPlayer, "Events")
end)
v30.Fired("Events: Reset"):Connect(function(p6, p7)
    local v100 = v27.Get()
    if not v100 then
        return 
    end
    local v107 = v100.Events
    local v101 = v107[p6]
    if not v101 then
        v101 = {}
        v107[p6] = v101
    end
    assert(v101)
    v100.EventsRewardStage[p6] = 0
    v21.SignalStatUpdated(v6.LocalPlayer, "Events")
end)
v30.Fired("Events: Complete"):Connect(function(p8, p9, p10)
    local v121, v122 = unpack(string.split(p10, "-"))
    assert(v121)
	assert(typeof(v122) == "string")
    local v132 = tonumber(v122)
	assert(v132)
    assert(v18.Events[p9][v121][v132])
end)
return v34
