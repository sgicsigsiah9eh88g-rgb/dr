local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "SCRIPTER COMMUNITY | Premium",
    SubTitle = "by Voce",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = { Main = Window:CreateTab({ Title = "Principais", Icon = "home" }) }

Tabs.Main:CreateSlider("SpeedSlider", {
    Title = "Velocidade (Speed)",
    Default = 16, Min = 16, Max = 300, Rounding = 0,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local FlyToggle = Tabs.Main:CreateToggle("FlyToggle", {Title = "Ativar Voo (Fly)", Default = false})
local flying = false
local speed = 50
local c, h, bv, bg

FlyToggle:OnChanged(function()
    flying = FlyToggle.Value
    local char = game.Players.LocalPlayer.Character
    if flying and char then
        c = char:WaitForChild("HumanoidRootPart")
        h = char:WaitForChild("Humanoid")
        bv = Instance.new("BodyVelocity", c)
        bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
        bg = Instance.new("BodyGyro", c)
        bg.maxTorque = Vector3.new(1e9, 1e9, 1e9)
        task.spawn(function()
            while flying and task.wait() do
                h.PlatformStand = true
                local cam = workspace.CurrentCamera.CFrame
                local move = Vector3.new(0,0,0)
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
                bv.velocity = move.Unit * speed
                if move == Vector3.new(0,0,0) then bv.velocity = Vector3.new(0,0,0) end
                bg.cframe = cam
            end
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
            if h then h.PlatformStand = false end
        end)
    end
end)

Tabs.Main:CreateToggle("ESPToggle", {
    Title = "ESP (Ver Jogadores)", 
    Default = false,
    Callback = function(Value)
        _G.ESP = Value
        for _, pl in pairs(game.Players:GetPlayers()) do
            if pl ~= game.Players.LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                if _G.ESP then
                    local hi = Instance.new("Highlight", pl.Character.HumanoidRootPart)
                    hi.FillColor = Color3.fromRGB(255, 0, 128)
                else
                    if pl.Character.HumanoidRootPart:FindFirstChild("Highlight") then
                        pl.Character.HumanoidRootPart.Highlight:Destroy()
                    end
                end
            end
        end
    end
})

Window:SelectTab(Tabs.Main)
