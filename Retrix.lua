-- RetrixAdminPanel - Interface Legítima para Admin Interno (Mobile Friendly)
-- Autor: Você (criador do jogo)
-- Funciona em celular e PC - NÃO É EXPLOIT

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local minimizeButton = Instance.new("TextButton")
local logo = Instance.new("ImageLabel")
local tabContainer = Instance.new("Frame")
local tagButton = Instance.new("TextButton")
local vipButton = Instance.new("TextButton")
local adminButton = Instance.new("TextButton")
local ownerButton = Instance.new("TextButton")
local customTagInput = Instance.new("TextBox")
local customTagButton = Instance.new("TextButton")

-- Configurações de cores RGB (você pode alterar)
local RGB_COLORS = {
    {r = 0.9, g = 0.2, b = 0.3}, -- Vermelho
    {r = 0.2, g = 0.7, b = 0.9}, -- Azul
    {r = 0.8, g = 0.3, b = 0.9}, -- Roxo
}

local isMinimized = false
local isDragging = false
local dragOffset = Vector2.new(0, 0)

-- Função para aplicar cor RGB em um objeto
local function setRGBColor(obj, r, g, b)
    obj.BackgroundColor3 = Color3.fromRGB(r * 255, g * 255, b * 255)
    obj.BorderColor3 = Color3.fromRGB(r * 255, g * 255, b * 255)
end

-- Função para animar transição de cor RGB
local function animateRGB(obj, colorIndex)
    local color = RGB_COLORS[colorIndex]
    setRGBColor(obj, color.r, color.g, color.b)
    task.wait(0.5)
    animateRGB(obj, (colorIndex % #RGB_COLORS) + 1)
end

-- Cria bordas arredondadas (via imagem de fundo simulada)
local function createRoundedFrame(parent, size, cornerRadius)
    local roundedFrame = Instance.new("Frame")
    roundedFrame.Size = size
    roundedFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    roundedFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    roundedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    roundedFrame.BackgroundTransparency = 0.7
    roundedFrame.BorderSizePixel = 0
    roundedFrame.Parent = parent

    -- Simula bordas arredondadas com sombra leve (não há suporte nativo em Roblox)
    -- Recomenda-se usar ImageLabel com PNG arredondado para melhor resultado real
    return roundedFrame
end

-- Criar a interface principal
local function createInterface()
    gui.Name = "RetrixAdminGUI"
    gui.Parent = player:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false

    -- Frame principal
    frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.4, 0, 0.6, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.8
    frame.BorderSizePixel = 0
    frame.Parent = gui

    -- Botão de minimizar (X)
    minimizeButton = Instance.new("TextButton")
    minimizeButton.Text = "X"
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -30, 0, 0)
    minimizeButton.AnchorPoint = Vector2.new(1, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = 20
    minimizeButton.Parent = frame
    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            frame.Visible = true
            logo.Visible = false
            isMinimized = false
        else
            frame.Visible = false
            logo.Visible = true
            isMinimized = true
        end
    end)

    -- Logo minimizada (aparece quando minimizado)
    logo = Instance.new("ImageLabel")
    logo.Image = "rbxassetid://123456789" -- Substitua por sua logo (PNG transparente)
    logo.Size = UDim2.new(0, 50, 0, 50)
    logo.Position = UDim2.new(0.5, 0, 0.5, 0)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.BackgroundTransparency = 0
    logo.Parent = gui
    logo.Visible = false
    logo.Active = true
    logo.MouseButton1Click:Connect(function()
        frame.Visible = true
        logo.Visible = false
        isMinimized = false
    end)

    -- Container de abas
    tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0.8, 0)
    tabContainer.Position = UDim2.new(0, 0, 0.1, 0)
    tabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabContainer.BackgroundTransparency = 0.7
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = frame

    -- Botão Tags
    tagButton = Instance.new("TextButton")
    tagButton.Text = "🏷️ TAGS"
    tagButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    tagButton.Position = UDim2.new(0, 0, 0, 0)
    tagButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
    tagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tagButton.Font = Enum.Font.SourceSansBold
    tagButton.TextSize = 18
    tagButton.Parent = tabContainer

    -- Botão VIP
    vipButton = Instance.new("TextButton")
    vipButton.Text = "💎 GANHAR VIP"
    vipButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    vipButton.Position = UDim2.new(0, 0, 0.15, 0)
    vipButton.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
    vipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    vipButton.Font = Enum.Font.SourceSansBold
    vipButton.TextSize = 18
    vipButton.Parent = tabContainer

    -- Botão Admin
    adminButton = Instance.new("TextButton")
    adminButton.Text = "👑 GANHAR ADMIN"
    adminButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    adminButton.Position = UDim2.new(0, 0, 0.3, 0)
    adminButton.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    adminButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    adminButton.Font = Enum.Font.SourceSansBold
    adminButton.TextSize = 18
    adminButton.Parent = tabContainer

    -- Botão Owner
    ownerButton = Instance.new("TextButton")
    ownerButton.Text = "🔥 GANHAR OWNER"
    ownerButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    ownerButton.Position = UDim2.new(0, 0, 0.45, 0)
    ownerButton.BackgroundColor3 = Color3.fromRGB(200, 200, 80)
    adminButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    adminButton.Font = Enum.Font.SourceSansBold
    adminButton.TextSize = 18
    ownerButton.Parent = tabContainer

    -- Input de Tag Personalizada
    customTagInput = Instance.new("TextBox")
    customTagInput.PlaceholderText = "Digite sua tag..."
    customTagInput.Size = UDim2.new(0.4, 0, 0.08, 0)
    customTagInput.Position = UDim2.new(0, 0, 0.6, 0)
    customTagInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    customTagInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    customTagInput.Font = Enum.Font.SourceSans
    customTagInput.TextSize = 16
    customTagInput.Parent = tabContainer

    -- Botão Aplicar Tag
    customTagButton = Instance.new("TextButton")
    customTagButton.Text = "✅ APLICAR TAG"
    customTagButton.Size = UDim2.new(0.4, 0, 0.08, 0)
    customTagButton.Position = UDim2.new(0, 0, 0.7, 0)
    customTagButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    customTagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    customTagButton.Font = Enum.Font.SourceSansBold
    customTagButton.TextSize = 16
    customTagButton.Parent = tabContainer

    -- Animar bordas RGB
    spawn(function()
        while true do
            for i = 1, #RGB_COLORS do
                setRGBColor(frame, RGB_COLORS[i].r, RGB_COLORS[i].g, RGB_COLORS[i].b)
                setRGBColor(minimizeButton, RGB_COLORS[i].r, RGB_COLORS[i].g, RGB_COLORS[i].b)
                task.wait(0.8)
            end
        end
    end)

    -- Eventos dos botões
    vipButton.MouseButton1Click:Connect(function()
        -- Enviar pedido ao servidor (LEGÍTIMO)
        local remoteEvent = game.ReplicatedStorage:FindFirstChild("GrantVIP")
        if remoteEvent then
            remoteEvent:FireServer()
            print("[RetrixAdmin] Pedido de VIP enviado.")
        else
            warn("RemoteEvent 'GrantVIP' não encontrado! Crie no ReplicatedStorage.")
        end
    end)

    adminButton.MouseButton1Click:Connect(function()
        local remoteEvent = game.ReplicatedStorage:FindFirstChild("GrantAdmin")
        if remoteEvent then
            remoteEvent:FireServer()
            print("[RetrixAdmin] Pedido de Admin enviado.")
        else
            warn("RemoteEvent 'GrantAdmin' não encontrado!")
        end
    end)

    ownerButton.MouseButton1Click:Connect(function()
        local remoteEvent = game.ReplicatedStorage:FindFirstChild("GrantOwner")
        if remoteEvent then
            remoteEvent:FireServer()
            print("[RetrixAdmin] Pedido de Owner enviado.")
        else
            warn("RemoteEvent 'GrantOwner' não encontrado!")
        end
    end)

    customTagButton.MouseButton1Click:Connect(function()
        local tag = customTagInput.Text
        if tag and #tag > 0 and #tag <= 15 then
            local remoteEvent = game.ReplicatedStorage:FindFirstChild("SetCustomTag")
            if remoteEvent then
                remoteEvent:FireServer(tag)
                print("[RetrixAdmin] Tag personalizada enviada: " .. tag)
                customTagInput.Text = ""
            else
                warn("RemoteEvent 'SetCustomTag' não encontrado!")
            end
        else
            warn("Tag inválida! Máximo de 15 caracteres.")
        end
    end)

    -- Arrastar a interface
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragOffset = Vector2.new(
                frame.Position.X.Scale * frame.AbsoluteSize.X - input.Position.X,
                frame.Position.Y.Scale * frame.AbsoluteSize.Y - input.Position.Y
            )
        end
    end)

    UserInputService.InputChanged:Connect(function(input, gameProcessed)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and not gameProcessed then
            local newPos = Vector2.new(
                (input.Position.X + dragOffset.X) / workspace.CurrentCamera.ViewportSize.X,
                (input.Position.Y + dragOffset.Y) / workspace.CurrentCamera.ViewportSize.Y
            )

            frame.Position = UDim2.new(newPos.X, 0, newPos.Y, 0)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
end

-- Garantir que o script só rode se o jogador for o dono (ou tiver permissão)
spawn(function()
    wait(1)
    if player.UserId == 123456789 then -- SUBSTITUA PELO SEU USERID
        createInterface()
    else
        print("[RetrixAdmin] Acesso negado. Somente o dono pode usar este painel.")
    end
end)
