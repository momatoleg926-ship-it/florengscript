-- // FLORENG MM2 HUB (BASE)
-- // Собери свой чит здесь

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "floreng",
    LoadingTitle = "floreng",
    LoadingSubtitle = "by you",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "floreng",
        FileName = "Config"
    },
    KeySystem = false
})

-- // СЕРВИСЫ
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- // НАСТРОЙКИ
local Settings = {
    Aimbot = false,
    Triggerbot = false,
    Fly = false,
    ESP = false,
    WalkSpeed = 16
}

-- // ВКЛАДКА "COMBAT"
local CombatTab = Window:CreateTab("Combat", 4483362458)

CombatTab:CreateToggle({
    Name = "Aimbot (Murderer)",
    CurrentValue = Settings.Aimbot,
    Flag = "Aimbot_Enabled",
    Callback = function(value)
        Settings.Aimbot = value
    end
})

CombatTab:CreateToggle({
    Name = "Triggerbot",
    CurrentValue = Settings.Triggerbot,
    Flag = "Triggerbot_Enabled",
    Callback = function(value)
        Settings.Triggerbot = value
    end
})

-- // ВКЛАДКА "MOVEMENT"
local MoveTab = Window:CreateTab("Movement", 4483362458)

MoveTab:CreateToggle({
    Name = "Fly (Полет)",
    CurrentValue = Settings.Fly,
    Flag = "Fly_Enabled",
    Callback = function(value)
        Settings.Fly = value
    end
})

MoveTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = Settings.WalkSpeed,
    Flag = "WalkSpeed",
    Callback = function(value)
        Settings.WalkSpeed = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

-- // ВКЛАДКА "VISUALS"
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

VisualsTab:CreateToggle({
    Name = "ESP (Игроки)",
    CurrentValue = Settings.ESP,
    Flag = "ESP_Enabled",
    Callback = function(value)
        Settings.ESP = value
    end
})

-- // ЛОГИКА (Здесь ты сам дописываешь функции)

-- 1. AIMBOT (Пример: наводится на ближайшего мурдерера, если ты шериф)
RunService.RenderStepped:Connect(function()
    if Settings.Aimbot and LocalPlayer.Character then
        local localRole = "Innocent"
        if LocalPlayer.Backpack:FindFirstChild("Knife") or LocalPlayer.Character:FindFirstChild("Knife") then localRole = "Murderer" end
        
        if localRole == "Murderer" then
            -- Тут логика наведения на шерифа
        end
    end
end)

-- 2. FLY (Простейшая левитация)
RunService.RenderStepped:Connect(function()
    if Settings.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
    end
end)

-- 3. ESP (Просто подсветка через Highlight)
RunService.RenderStepped:Connect(function()
    if Settings.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if not p.Character:FindFirstChild("florengESP") then
                    local h = Instance.new("Highlight")
                    h.Name = "florengESP"
                    h.Parent = p.Character
                    h.FillColor = Color3.new(1, 0, 0) -- Красный (можно менять)
                end
            end
        end
    end
end)

print("floreng hub loaded.")
