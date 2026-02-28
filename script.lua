local svc = game:GetService("HttpService")
local fontPath = "minecraft.ttf"
local configPath = "minecraft.json"
local fontURL = "https://raw.githubusercontent.com/karmamlk/Fonte-de-Minecraft-/main/Minecraft.ttf"

if not isfile(fontPath) then
    writefile(fontPath, game:HttpGet(fontURL))
end

writefile(configPath, svc:JSONEncode({
    name = "Minecraft",
    faces = {{name="Regular", weight=400, style="normal", assetId=getcustomasset(fontPath)}}
}))

local mcFont = Font.new(getcustomasset(configPath))
local blockedFont = tostring(Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json"))

local function shouldSkip(obj)
    if obj.TextStrokeTransparency ~= 1 then return false end
    local currentFont = tostring(obj.FontFace)
    return currentFont == blockedFont or string.find(currentFont, "BuilderIcons")
end

local function updateFont(obj)
    if (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then
        if not shouldSkip(obj) then
            obj.FontFace = mcFont
        end
    end
end

for _, element in pairs(game:GetDescendants()) do
    spawn(function() 
        updateFont(element) 
    end)
end

game.DescendantAdded:Connect(function(newElement)
    spawn(function() 
        updateFont(newElement) 
    end)
end)

print("✓ Minecraft Font Loaded!")
