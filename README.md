-- // FLORENG MENU (Standalone)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // СОЗДАНИЕ МЕНЮ
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "floreng_Menu"

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0, 20, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
MainFrame.Active = true
MainFrame.Draggable = true -- Меню можно двигать

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Title.Text = "floreng"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Функция создания кнопок
local function CreateToggle(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name .. " [OFF]"
    btn.Font = Enum.Font.SourceSans
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)
end

-- // НАСТРОЙКИ
local Settings = {
    ESP = false,
    Fly = false,
    Aimbot = false
}

-- // ДОБАВЛЯЕМ КНОПКИ В МЕНЮ
CreateToggle("ESP Players", 40, function(v) Settings.ESP = v end)
CreateToggle("Fly", 80, function(v) Settings.Fly = v end)
CreateToggle("Aimbot (Hold E)", 120, function(v) Settings.Aimbot = v end)

-- Кнопка Закрыть/Открыть
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0.9, 0, 0, 30)
CloseBtn.Position = UDim2.new(0.05, 0, 0, 250)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "CLOSE MENU"
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Кнопка для возврата меню (маленький кружок)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 20, 0, 100)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
OpenBtn.Text = "F"
OpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 24
OpenBtn.Visible = false
OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

MainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    if not MainFrame.Visible then
        OpenBtn.Visible = true
    end
end)

-- // ЛОГИКА ЧИТОВ

-- ESP
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local highlight = p.Character:FindFirstChild("florengESP")
            if Settings.ESP then
                if not highlight then
                    local h = Instance.new("Highlight")
                    h.Name = "florengESP"
                    h.Parent = p.Character
                    h.FillColor = Color3.new(1, 0, 0)
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

-- Fly
RunService.RenderStepped:Connect(function()
    if Settings.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
    end
end)

print("floreng menu loaded!")
