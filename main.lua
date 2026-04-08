--// 👑 SUPREME HUB PRO V2 (FULL RESTORE + PRO CORE)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// SERVICES
local S = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UIS = game:GetService("UserInputService"),
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService"),
    TeleportService = game:GetService("TeleportService"),
    MarketplaceService = game:GetService("MarketplaceService"),
    HttpService = game:GetService("HttpService")
}

local lp = S.Players.LocalPlayer
local mouse = lp:GetMouse()
local cam = workspace.CurrentCamera

--// CHARACTER
local function Char()
    return lp.Character or lp.CharacterAdded:Wait()
end

--// CONNECTION MANAGER
local Conn = {}
function Conn:Set(name, c)
    if self[name] then self[name]:Disconnect() end
    self[name] = c
end
function Conn:Clear(name)
    if self[name] then self[name]:Disconnect() self[name]=nil end
end

--// STATE
local State = {
    InfJump=false, Fly=false, Noclip=false,
    FullBright=false, Spin=false, AutoClick=false
}

--// CORE FIXES

-- Inf Jump
S.UIS.JumpRequest:Connect(function()
    if State.InfJump then
        local h = Char():FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Noclip
S.RunService.Stepped:Connect(function()
    if State.Noclip then
        for _,v in pairs(Char():GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end
end)

-- AutoClick
task.spawn(function()
    while task.wait() do
        if State.AutoClick then pcall(mouse1click) end
    end
end)

-- Audio
local function Play(id)
    local s = S.SoundService:FindFirstChild("Supreme") or Instance.new("Sound",S.SoundService)
    s.Name="Supreme"
    s.SoundId="rbxassetid://"..id
    s.Volume=3
    s:Play()
end

--// UI
local W = Rayfield:CreateWindow({
    Name="👑 Supreme Hub PRO V2",
    LoadingTitle="Booting Systems...",
    LoadingSubtitle="Full Edition",
    ConfigurationSaving={Enabled=true,FolderName="SupremeProV2"},
    Theme="DarkBlue"
})

--// TABS (ALL RESTORED)
local Dash=W:CreateTab("📊 Dash",4483362458)
local Player=W:CreateTab("🏃 Player",4483362458)
local Combat=W:CreateTab("⚔️ Combat",4483362458)
local Visuals=W:CreateTab("👁️ Visuals",4483362458)
local World=W:CreateTab("🌎 World",4483362458)
local Chaos=W:CreateTab("🌪️ Chaos",4483362458)
local Safety=W:CreateTab("🛡️ Safety",4483362458)
local Scripts=W:CreateTab("📜 Scripts",4483362458)
local Waypoint=W:CreateTab("📍 Waypoints",4483362458)
local Vibe=W:CreateTab("🎵 Vibe",4483362458)
local Themes=W:CreateTab("🎨 Themes",4483362458)
local Stats=W:CreateTab("📈 Stats",4483362458)
local Settings=W:CreateTab("⚙️ Settings",4483362458)

-- DASH
local info=S.MarketplaceService:GetProductInfo(game.PlaceId)
Dash:CreateLabel("Game: "..info.Name)
Dash:CreateLabel("Creator: "..info.Creator.Name)

-- PLAYER
Player:CreateToggle({Name="Infinite Jump",Callback=function(v)State.InfJump=v end})

Player:CreateToggle({
    Name="Fly",
    Callback=function(v)
        State.Fly=v
        if v then
            Conn:Set("Fly",S.RunService.RenderStepped:Connect(function()
                local hrp=Char():FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity=cam.CFrame.LookVector*100 end
            end))
        else Conn:Clear("Fly") end
    end
})

Player:CreateSlider({
    Name="WalkSpeed",
    Range={16,300},
    Callback=function(v)
        local h=Char():FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=v end
    end
})

Player:CreateButton({
    Name="Ctrl Click TP",
    Callback=function()
        if Conn.TP then return end
        Conn.TP=mouse.Button1Down:Connect(function()
            if S.UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                local hrp=Char():FindFirstChild("HumanoidRootPart")
                if hrp then hrp.CFrame=mouse.Hit+Vector3.new(0,3,0) end
            end
        end)
    end
})

-- COMBAT
Combat:CreateToggle({
    Name="SpinBot",
    Callback=function(v)
        State.Spin=v
        task.spawn(function()
            while State.Spin do
                local hrp=Char():FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(50),0)
                end
                task.wait()
            end
        end)
    end
})

Combat:CreateToggle({Name="AutoClicker",Callback=function(v)State.AutoClick=v end})

-- VISUALS
Visuals:CreateSlider({
    Name="FOV",
    Range={70,120},
    Callback=function(v) cam.FieldOfView=v end
})

Visuals:CreateButton({
    Name="ESP Highlight",
    Callback=function()
        for _,p in pairs(S.Players:GetPlayers()) do
            if p~=lp and p.Character then
                Instance.new("Highlight",p.Character)
            end
        end
    end
})

-- WORLD
World:CreateToggle({
    Name="FullBright",
    Callback=function(v)
        State.FullBright=v
        if v then
            Conn:Set("Bright",S.RunService.RenderStepped:Connect(function()
                S.Lighting.Brightness=2
                S.Lighting.ClockTime=14
                S.Lighting.GlobalShadows=false
            end))
        else Conn:Clear("Bright") end
    end
})

World:CreateToggle({Name="Noclip",Callback=function(v)State.Noclip=v end})

-- CHAOS
Chaos:CreateButton({
    Name="Void Parts",
    Callback=function()
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Anchored then
                v.Velocity=Vector3.new(0,-1000,0)
            end
        end
    end
})

-- SAFETY
Safety:CreateButton({
    Name="Rejoin",
    Callback=function()
        S.TeleportService:Teleport(game.PlaceId,lp)
    end
})

-- SCRIPTS
Scripts:CreateButton({
    Name="Infinite Yield",
    Callback=function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

-- WAYPOINT
Waypoint:CreateButton({
    Name="Save Pos",
    Callback=function()
        local hrp=Char():FindFirstChild("HumanoidRootPart")
        if hrp then State.Pos=hrp.CFrame end
    end
})

Waypoint:CreateButton({
    Name="Teleport Back",
    Callback=function()
        local hrp=Char():FindFirstChild("HumanoidRootPart")
        if hrp and State.Pos then hrp.CFrame=State.Pos end
    end
})

-- VIBE
Vibe:CreateButton({Name="Play Music",Callback=function()Play(9043881473)end})

-- THEMES
Themes:CreateButton({Name="Dark",Callback=function()W.ModifyTheme("DarkBlue")end})
Themes:CreateButton({Name="Ocean",Callback=function()W.ModifyTheme("Ocean")end})

-- STATS
local fps=Stats:CreateLabel("FPS: ...")
task.spawn(function()
    while task.wait(1) do
        fps:Set("FPS: "..math.floor(workspace:GetRealPhysicsFPS()))
    end
end)

-- SETTINGS
Settings:CreateKeybind({
    Name="Toggle UI",
    CurrentKeybind="RightShift",
    Callback=function()Rayfield:Toggle()end
})

Settings:CreateButton({
    Name="Destroy",
    Callback=function()Rayfield:Destroy()end
})

Rayfield:Notify({
    Title="SUPREME PRO V2",
    Content="All tabs + Pro system active",
    Duration=6
})
