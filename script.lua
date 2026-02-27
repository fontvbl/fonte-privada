local http = game:GetService("HttpService")

-- URL direta para a fonte Minecraft do repositório
-- Se o link não funcionar, você pode fazer download direto do repositório
local fontUrl = "https://raw.githubusercontent.com/karmamlk/Fonte-de-Minecraft-/main/Minecraft.ttf"

-- Baixar e salvar a fonte Minecraft
if not isfile("minecraft.ttf") then
    writefile("minecraft.ttf", game:HttpGet(fontUrl))
end

-- Criar o arquivo JSON com a configuração da fonte
writefile("minecraft.json", http:JSONEncode({
    name = "Minecraft",
    faces = {{name="Regular", weight=400, style="normal", assetId=getcustomasset("minecraft.ttf")}}
}))

local minecraftFont = Font.new(getcustomasset("minecraft.json"))

-- Fonte do ícone Roblox que não devemos tocar
local badfont = tostring(Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json"))

-- Função para verificar se não deve tocar na fonte
local function donttouch(this)
    if this.TextStrokeTransparency ~= 1 then return false end
    local cur = tostring(this.FontFace)
    return cur == badfont or string.find(cur, "BuilderIcons")
end

-- Função para mudar a fonte
local function changeit(txt)
    if txt:IsA("TextLabel") or txt:IsA("TextButton") or txt:IsA("TextBox") then
        if not donttouch(txt) then
            txt.FontFace = minecraftFont
        end
    end
end

-- Aplicar em tudo que já existe
for _, v in pairs(game:GetDescendants()) do
    spawn(function() changeit(v) end)
end

-- Aplicar em novos elementos
game.DescendantAdded:Connect(function(obj)
    spawn(function() changeit(obj) end)
end)

print("✓ Fonte Minecraft aplicada com sucesso!")
