if shared.debug then
    loadDebugMode = true
    loadWorkspace = true
else
    loadDebugMode = false
    loadWorkspace = true
end
local lplr = game.Players.LocalPlayer
local plrs = game.Players
local looptable = {}
local function doLoop(name,func)
    if looptable[name] == nil then
        looptable[name] = game:GetService("RunService").Stepped:Connect(func)
    end
end
local function endLoop(name)
    if looptable[name] then
        looptable[name]:Disconnect()
        looptable[name] = nil
    end
end
local function notif(text)
	game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = text})
end
local colors = {
    SchemeColor = Color3.fromRGB(255,75,255),
    Background = Color3.fromRGB(255,175,255),
    Header = Color3.fromRGB(255,145,255),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(235,165,245)
}
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("qwertyware - 1.1", colors)
local MainTab = Window:NewTab("Main")
local Main = MainTab:NewSection("Main")
local AutoTab = Window:NewTab("Automated")
local Auto = AutoTab:NewSection("AutoMated")
Main:NewButton("ShelterTP","does what it says",function()
    lplr.Character.HumanoidRootPart.CFrame = CFrame.new(75494, 31957, -142) -- nvm
end)
Auto:NewToggle("AutoWin","does what it says",function(callback)
    if callback then
        doLoop("AutoWin",function()
            lplr.Character.HumanoidRootPart.CFrame = CFrame.new(75492, 31957, -63) -- nvm
        end)
    else
        endLoop("AutoWin")
    end
end)
