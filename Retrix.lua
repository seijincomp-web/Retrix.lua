-- [[ Retrix Hub - Universal Script ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configurações iniciais
local AimPart = "Head"
local AimFOV = 50
local WallCheck = true
local AimEnabled = false
local EspEnabled = false
local ShowName = false
local ShowHealth = false
local ShowDistance = false
local HitboxExpand = 0

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RetrixHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Função para criar interface
local function createGui()
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 300, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Título e Botão de Minimizar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 25)
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "Retrix Hub"
    Title.Size = UDim2.new(1, -25, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 16
    Title.Parent = TopBar

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "Minimize"
    MinimizeButton.Text = "X"
    MinimizeButton.Size = UDim2.new(0, 25, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -25, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.TextSize = 16
    MinimizeButton.Parent = TopBar

    -- Conteúdo Principal
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "Content"
    ContentFrame.Size = UDim2.new(1, 0, 1, -25)
    ContentFrame.Position = UDim2.new(0, 0, 0, 25)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    -- Abas
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = "Tabs"
    TabFrame.Size = UDim2.new(0, 70, 1, 0)
    TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabFrame.BorderSizePixel = 0
    TabFrame.Parent = ContentFrame

    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 5)
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Parent = TabFrame

    local AimbotTab = Instance.new("TextButton")
    AimbotTab.Name = "Aimbot"
    AimbotTab.Text = "Aimbot"
    AimbotTab.Size = UDim2.new(1, -10, 0, 30)
    AimbotTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AimbotTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    AimbotTab.Font = Enum.Font.SourceSans
    AimbotTab.TextSize = 14
    AimbotTab.Parent = TabFrame

    local EspTab = Instance.new("TextButton")
    EspTab.Name = "ESP"
    EspTab.Text = "ESP"
    EspTab.Size = UDim2.new(1, -10, 0, 30)
    EspTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    EspTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    EspTab.Font = Enum.Font.SourceSans
    EspTab.TextSize = 14
    EspTab.Parent = TabFrame

    -- Conteúdo das Abas
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -70, 1, 0)
    ContentArea.Position = UDim2.new(0, 70, 0, 0)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = ContentFrame

    -- Aba Aimbot
    local AimbotFrame = Instance.new("ScrollingFrame")
    AimbotFrame.Name = "AimbotFrame"
    AimbotFrame.Size = UDim2.new(1, 0, 1, 0)
    AimbotFrame.BackgroundTransparency = 1
    AimbotFrame.ScrollBarThickness = 0
    AimbotFrame.Visible = true
    AimbotFrame.Parent = ContentArea

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = AimbotFrame

    -- FOV Input
    local FovLabel = Instance.new("TextLabel")
    FovLabel.Text = "FOV: " .. AimFOV
    FovLabel.Size = UDim2.new(1, 0, 0, 20)
    FovLabel.BackgroundTransparency = 1
    FovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FovLabel.Font = Enum.Font.SourceSans
    FovLabel.TextSize = 14
    FovLabel.Parent = AimbotFrame

    local FovTextBox = Instance.new("TextBox")
    FovTextBox.Name = "FovInput"
    FovTextBox.Size = UDim2.new(0.8, 0, 0, 20)
    FovTextBox.Position = UDim2.new(0.1, 0, 0, 20)
    FovTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    FovTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    FovTextBox.Text = tostring(AimFOV)
    FovTextBox.Font = Enum.Font.SourceSans
    FovTextBox.TextSize = 14
    FovTextBox.ClearTextOnFocus = false
    FovTextBox.Parent = AimbotFrame

    local FovSlider = Instance.new("TextButton")
    FovSlider.Name = "FovSlider"
    FovSlider.Size = UDim2.new(0.8, 0, 0, 10)
    FovSlider.Position = UDim2.new(0.1, 0, 0, 45)
    FovSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    FovSlider.Text = ""
    FovSlider.Parent = AimbotFrame

    local FovFill = Instance.new("Frame")
    FovFill.Name = "Fill"
    FovFill.Size = UDim2.new(AimFOV / 100, 0, 1, 0)
    FovFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    FovFill.BorderSizePixel = 0
    FovFill.Parent = FovSlider

    -- Part Selection
    local PartLabel = Instance.new("TextLabel")
    PartLabel.Text = "Aim Part: " .. AimPart
    PartLabel.Size = UDim2.new(1, 0, 0, 20)
    PartLabel.Position = UDim2.new(0, 0, 0, 60)
    PartLabel.BackgroundTransparency = 1
    PartLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PartLabel.Font = Enum.Font.SourceSans
    PartLabel.TextSize = 14
    PartLabel.Parent = AimbotFrame

    local HeadButton = Instance.new("TextButton")
    HeadButton.Text = "Head"
    HeadButton.Size = UDim2.new(0.25, 0, 0, 20)
    HeadButton.Position = UDim2.new(0.1, 0, 0, 80)
    HeadButton.BackgroundColor3 = AimPart == "Head" and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    HeadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeadButton.Font = Enum.Font.SourceSans
    HeadButton.TextSize = 12
    HeadButton.Parent = AimbotFrame

    local ChestButton = Instance.new("TextButton")
    ChestButton.Text = "Chest"
    ChestButton.Size = UDim2.new(0.25, 0, 0, 20)
    ChestButton.Position = UDim2.new(0.375, 0, 0, 80)
    ChestButton.BackgroundColor3 = AimPart == "Torso" and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    ChestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ChestButton.Font = Enum.Font.SourceSans
    ChestButton.TextSize = 12
    ChestButton.Parent = AimbotFrame

    local LegButton = Instance.new("TextButton")
    LegButton.Text = "Leg"
    LegButton.Size = UDim2.new(0.25, 0, 0, 20)
    LegButton.Position = UDim2.new(0.65, 0, 0, 80)
    LegButton.BackgroundColor3 = AimPart == "HumanoidRootPart" and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    LegButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LegButton.Font = Enum.Font.SourceSans
    LegButton.TextSize = 12
    LegButton.Parent = AimbotFrame

    -- Wall Check
    local WallCheckButton = Instance.new("TextButton")
    WallCheckButton.Text = "Wall Check: " .. (WallCheck and "ON" or "OFF")
    WallCheckButton.Size = UDim2.new(0.8, 0, 0, 20)
    WallCheckButton.Position = UDim2.new(0.1, 0, 0, 105)
    WallCheckButton.BackgroundColor3 = WallCheck and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    WallCheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    WallCheckButton.Font = Enum.Font.SourceSans
    WallCheckButton.TextSize = 14
    WallCheckButton.Parent = AimbotFrame

    -- Aimbot Toggle
    local AimbotToggle = Instance.new("TextButton")
    AimbotToggle.Text = "Aimbot: OFF"
    AimbotToggle.Size = UDim2.new(0.8, 0, 0, 20)
    AimbotToggle.Position = UDim2.new(0.1, 0, 0, 130)
    AimbotToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    AimbotToggle.Font = Enum.Font.SourceSans
    AimbotToggle.TextSize = 14
    AimbotToggle.Parent = AimbotFrame

    -- Hitbox Expand
    local HitboxLabel = Instance.new("TextLabel")
    HitboxLabel.Text = "Hitbox Expand: " .. HitboxExpand
    HitboxLabel.Size = UDim2.new(1, 0, 0, 20)
    HitboxLabel.Position = UDim2.new(0, 0, 0, 155)
    HitboxLabel.BackgroundTransparency = 1
    HitboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    HitboxLabel.Font = Enum.Font.SourceSans
    HitboxLabel.TextSize = 14
    HitboxLabel.Parent = AimbotFrame

    local HitboxTextBox = Instance.new("TextBox")
    HitboxTextBox.Size = UDim2.new(0.8, 0, 0, 20)
    HitboxTextBox.Position = UDim2.new(0.1, 0, 0, 175)
    HitboxTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    HitboxTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    HitboxTextBox.Text = tostring(HitboxExpand)
    HitboxTextBox.Font = Enum.Font.SourceSans
    HitboxTextBox.TextSize = 14
    HitboxTextBox.ClearTextOnFocus = false
    HitboxTextBox.Parent = AimbotFrame

    -- Aba ESP
    local EspFrame = Instance.new("ScrollingFrame")
    EspFrame.Name = "EspFrame"
    EspFrame.Size = UDim2.new(1, 0, 1, 0)
    EspFrame.BackgroundTransparency = 1
    EspFrame.ScrollBarThickness = 0
    EspFrame.Visible = false
    EspFrame.Parent = ContentArea

    local EspToggle = Instance.new("TextButton")
    EspToggle.Text = "ESP: OFF"
    EspToggle.Size = UDim2.new(0.8, 0, 0, 20)
    EspToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    EspToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    EspToggle.Font = Enum.Font.SourceSans
    EspToggle.TextSize = 14
    EspToggle.Parent = EspFrame

    local NameToggle = Instance.new("TextButton")
    NameToggle.Text = "Show Name: OFF"
    NameToggle.Size = UDim2.new(0.8, 0, 0, 20)
    NameToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    NameToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameToggle.Font = Enum.Font.SourceSans
    NameToggle.TextSize = 14
    NameToggle.Parent = EspFrame

    local HealthToggle = Instance.new("TextButton")
    HealthToggle.Text = "Show Health: OFF"
    HealthToggle.Size = UDim2.new(0.8, 0, 0, 20)
    HealthToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    HealthToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    HealthToggle.Font = Enum.Font.SourceSans
    HealthToggle.TextSize = 14
    HealthToggle.Parent = EspFrame

    local DistanceToggle = Instance.new("TextButton")
    DistanceToggle.Text = "Show Distance: OFF"
    DistanceToggle.Size = UDim2.new(0.8, 0, 0, 20)
    DistanceToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DistanceToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    DistanceToggle.Font = Enum.Font.SourceSans
    DistanceToggle.TextSize = 14
    DistanceToggle.Parent = EspFrame

    -- Lógica de navegação
    AimbotTab.MouseButton1Click:Connect(function()
        AimbotFrame.Visible = true
        EspFrame.Visible = false
    end)

    EspTab.MouseButton1Click:Connect(function()
        EspFrame.Visible = true
        AimbotFrame.Visible = false
    end)

    -- Minimizar
    local MinimizedFrame = Instance.new("Frame")
    MinimizedFrame.Name = "Minimized"
    MinimizedFrame.Size = UDim2.new(0, 50, 0, 50)
    MinimizedFrame.Position = MainFrame.Position
    MinimizedFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MinimizedFrame.BorderSizePixel = 0
    MinimizedFrame.Visible = false
    MinimizedFrame.Parent = ScreenGui

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 10)
    UICorner2.Parent = MinimizedFrame

    local Logo = Instance.new("TextLabel")
    Logo.Text = "RH"
    Logo.Size = UDim2.new(1, 0, 1, 0)
    Logo.BackgroundTransparency = 1
    Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    Logo.Font = Enum.Font.SourceSansBold
    Logo.TextSize = 20
    Logo.Parent = MinimizedFrame

    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MinimizedFrame.Visible = true
        MinimizedFrame.Position = MainFrame.Position
    end)

    MinimizedFrame.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        MinimizedFrame.Visible = false
    end)

    -- Funções
    FovTextBox.FocusLost:Connect(function()
        local value = tonumber(FovTextBox.Text)
        if value then
            value = math.clamp(value, 0, 100)
            AimFOV = value
            FovTextBox.Text = tostring(value)
            FovLabel.Text = "FOV: " .. value
            FovFill.Size = UDim2.new(value / 100, 0, 1, 0)
        end
    end)

    HeadButton.MouseButton1Click:Connect(function()
        AimPart = "Head"
        PartLabel.Text = "Aim Part: Head"
        HeadButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        ChestButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        LegButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    ChestButton.MouseButton1Click:Connect(function()
        AimPart = "Torso"
        PartLabel.Text = "Aim Part: Chest"
        ChestButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        HeadButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        LegButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    LegButton.MouseButton1Click:Connect(function()
        AimPart = "HumanoidRootPart"
        PartLabel.Text = "Aim Part: Leg"
        LegButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        HeadButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        ChestButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    WallCheckButton.MouseButton1Click:Connect(function()
        WallCheck = not WallCheck
        WallCheckButton.Text = "Wall Check: " .. (WallCheck and "ON" or "OFF")
        WallCheckButton.BackgroundColor3 = WallCheck and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    end)

    AimbotToggle.MouseButton1Click:Connect(function()
        AimEnabled = not AimEnabled
        AimbotToggle.Text = "Aimbot: " .. (AimEnabled and "ON" or "OFF")
        AimbotToggle.BackgroundColor3 = AimEnabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    end)

    HitboxTextBox.FocusLost:Connect(function()
        local value = tonumber(HitboxTextBox.Text)
        if value then
            value = math.clamp(value, 0, 100)
            HitboxExpand = value
            HitboxTextBox.Text = tostring(value)
            HitboxLabel.Text = "Hitbox Expand: " .. value
        end
    end)

    EspToggle.MouseButton1Click:Connect(function()
        EspEnabled = not EspEnabled
        EspToggle.Text = "ESP: " .. (EspEnabled and "ON" or "OFF")
        EspToggle.BackgroundColor3 = EspEnabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    end)

    NameToggle.MouseButton1Click:Connect(function()
        ShowName = not ShowName
        NameToggle.Text = "Show Name: " .. (ShowName and "ON" or "OFF")
        NameToggle.BackgroundColor3 = ShowName and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    end)

    HealthToggle.MouseButton1Click:Connect(function()
        ShowHealth = not ShowHealth
        HealthToggle.Text = "Show Health: " .. (ShowHealth and "ON" or "OFF")
        HealthToggle.BackgroundColor3 = ShowHealth and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    end)

    DistanceToggle.MouseButton1Click:Connect(function()
        ShowDistance = not ShowDistance
        DistanceToggle.Text = "Show Distance: " .. (ShowDistance and "ON" or "OFF")
        DistanceToggle.BackgroundColor3 = ShowDistance and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 40)
    end)

    -- Função de Aimbot
    RunService.RenderStepped:Connect(function()
        if AimEnabled then
            local closest = nil
            local shortestDistance = AimFOV

            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local part = player.Character:FindFirstChild(AimPart)
                    if part then
                        local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                        if onScreen then
                            local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                            local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude

                            if dist < shortestDistance then
                                if WallCheck then
                                    local ray = Ray.new(Camera.CFrame.Position, part.Position - Camera.CFrame.Position)
                                    local hit, _ = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character})
                                    if hit and hit:IsDescendantOf(player.Character) then
                                        closest = part
                                        shortestDistance = dist
                                    end
                                else
                                    closest = part
                                    shortestDistance = dist
                                end
                            end
                        end
                    end
                end
            end

            if closest then
                local target = closest.Position + Vector3.new(0, 0, 0)
                local point = Camera:WorldToScreenPoint(target)
                mousemoverel(point.X - mouse.X, point.Y - mouse.Y)
            end
        end
    end)
end

-- Iniciar GUI
createGui()
