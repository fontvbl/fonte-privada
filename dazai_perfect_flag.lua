-- ╔═══════════════════════════════════════════════════════════╗
-- ║  DAZAI PERFECT FLAG - Graphics Enhancement                ║
-- ║  Delta Executor Mobile                                    ║
-- ╚═══════════════════════════════════════════════════════════╝

local lgt = game:GetService("Lighting")
local ws = game.Workspace

-- ═══════════════════════════════════════════════════════════
-- 🎨 INICIALIZAÇÃO
-- ═══════════════════════════════════════════════════════════

local function initGraphics()
    local atmosphere = lgt:FindFirstChild("Atmosphere")
    if atmosphere then atmosphere:Destroy() end
    
    lgt.GlobalShadows = false
    lgt.Brightness = 0.5
    lgt.Ambient = Color3.fromRGB(72, 62, 52)
    lgt.OutdoorAmbient = Color3.fromRGB(72, 62, 52)
    lgt.ClockTime = 16
end

-- ═══════════════════════════════════════════════════════════
-- 🔦 PROCESSAMENTO DE LUZES
-- ═══════════════════════════════════════════════════════════

local function processLights(parent)
    local queue = {parent}
    local idx = 1
    
    while idx <= #queue do
        local current = queue[idx]
        idx = idx + 1
        
        for _, child in pairs(current:GetChildren()) do
            if child:IsA("PointLight") or child:IsA("SpotLight") or child:IsA("SurfaceLight") then
                pcall(function()
                    child.Shadows = false
                    child.Brightness = child.Brightness * 0.5
                end)
            end
            table.insert(queue, child)
        end
    end
end

-- ═══════════════════════════════════════════════════════════
-- 🌈 AJUSTE DE CORES
-- ═══════════════════════════════════════════════════════════

local function enhanceColors(parent)
    local queue = {parent}
    local idx = 1
    
    while idx <= #queue do
        local current = queue[idx]
        idx = idx + 1
        
        for _, child in pairs(current:GetChildren()) do
            if child:IsA("BasePart") and child:FindFirstChild("Color") or child.Color then
                task.spawn(function()
                    pcall(function()
                        local r, g, b = child.Color.R, child.Color.G, child.Color.B
                        local brightness = (r + g + b) / 3
                        local boost = 1.05
                        
                        child.Color = Color3.new(
                            math.min(brightness + (r - brightness) * boost, 1),
                            math.min(brightness + (g - brightness) * boost, 1),
                            math.min(brightness + (b - brightness) * boost, 1)
                        )
                    end)
                end)
            end
            table.insert(queue, child)
        end
    end
end

-- ═══════════════════════════════════════════════════════════
-- 🎪 LIMPEZA DE EFEITOS
-- ═══════════════════════════════════════════════════════════

local function cleanEffects()
    for _, obj in pairs(lgt:GetChildren()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then
            pcall(function() obj.Enabled = false end)
        end
    end
end

-- ═══════════════════════════════════════════════════════════
-- ✅ EXECUÇÃO
-- ═══════════════════════════════════════════════════════════

task.spawn(function()
    initGraphics()
    print("✓ Iluminação ajustada")
end)

task.spawn(function()
    processLights(ws)
    print("✓ Sombras removidas")
end)

task.spawn(function()
    enhanceColors(ws)
    print("✓ Cores ajustadas")
end)

task.spawn(function()
    cleanEffects()
    print("✓ Efeitos removidos")
end)

task.wait(0.5)

print("╔════════════════════════════════════════════╗")
print("║  ✨ DAZAI PERFECT FLAG ATIVADO             ║")
print("║  Sistema gráfico otimizado - Pronto!       ║")
print("╚════════════════════════════════════════════╝")
