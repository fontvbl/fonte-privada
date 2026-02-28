local svc = game:GetService("HttpService")
local fontPath = "minecraft.ttf"
local configPath = "minecraft.json"
local fontURL = "https://raw.githubusercontent.com/karmamlk/Fonte-de-Minecraft-/main/Minecraft.ttf"

local function loadFont()
    if not isfile(fontPath) then
        writefile(fontPath, game:HttpGet(fontURL))
    end
    
    local fontConfig = svc:JSONEncode({
        name = "Minecraft",
        faces = {{name="Regular", weight=400, style="normal", assetId=getcustomasset(fontPath)}}
    })
    writefile(configPath, fontConfig)
    return Font.new(getcustomasset(configPath))
end

local customFont = loadFont()
local defaultFont = tostring(Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json"))

local function isProtected(element)
    if element.TextStrokeTransparency ~= 1 then return true end
    local fontStr = tostring(element.FontFace)
    return fontStr == defaultFont or string.find(fontStr, "BuilderIcons") ~= nil
end

local function applyFont(element)
    if (element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox")) and not isProtected(element) then
        element.FontFace = customFont
    end
end

local descendants = game:GetDescendants()
for i = 1, #descendants do
    task.spawn(function() 
        applyFont(descendants[i]) 
    end)
end

game.DescendantAdded:Connect(function(newObj)
    task.spawn(function() 
        applyFont(newObj) 
    end)
end)

print("✓ Minecraft Font Applied!")
