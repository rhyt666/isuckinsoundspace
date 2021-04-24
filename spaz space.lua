--[[
  EQUIP DEFAULT SPACE FOR THIS TO WORK
  THIS WILL BREAK YOUR GAME UNTIL YOU REJOIN
--]]
_G.CONFIG = { -- EDIT THESE TO YOUR LIKING
  Often = 1; -- How many hits until change
  RandomSpace = false; -- Change to a random space instead of cycling
  IgnoreList = { -- Spaces to skip
    [9] = true; -- easter has terrain, terrain = lag
  };
}

local currentSpace = 1
local nextSpace = 2
local hits = 0
local spaces = game.ReplicatedFirst:WaitForChild("Spaces")
local lighting = game:GetService("Lighting")
function cycle()
  if not _G.CONFIG.RandomSpace then
    if currentSpace == #spaces:GetChildren() then
      nextSpace = 1
    else
      nextSpace += 1
    end
  else
    nextSpace = math.random(1,#spaces:GetChildren())
  end
  if _G.CONFIG.IgnoreList[nextSpace] or nextSpace == currentSpace then cycle() end
end
spaces["1"].OnHit.OnInvoke = function()
  hits += 1
  if hits < _G.CONFIG.Often then return end
  hits = 0
  spaces[tostring(currentSpace)].Toggle:Invoke(false)
  currentSpace = nextSpace
  local newSpace = spaces[tostring(currentSpace)]
  newSpace.Toggle:Invoke(true)
  if newSpace:FindFirstChild("FogColor") then
    lighting.FogColor = newSpace.FogColor.Value
  end
  if newSpace:FindFirstChild("FogStart") then
    lighting.FogStart = newSpace.FogStart.Value
  end
  if newSpace:FindFirstChild("FogEnd") then
    lighting.FogEnd = newSpace.FogEnd.Value
  end
  if newSpace:FindFirstChild("Ambient") then
    lighting.Ambient = newSpace.Ambient.Value
  end
  if newSpace:FindFirstChild("Brightness") then
    lighting.Brightness = newSpace.Brightness.Value
  end
  cycle()
end