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
local Auto = AutoTab:NewSection("Automated")
local lucky = game:GetService("ReplicatedStorage").SpawnLuckyBlock
local superblock = game:GetService("ReplicatedStorage").SpawnSuperBlock
local diamond = game:GetService("ReplicatedStorage").SpawnDiamondBlock
local rainbow = game:GetService("ReplicatedStorage").SpawnRainbowBlock
local galaxy = game:GetService("ReplicatedStorage").SpawnGalaxyBlock
local function SpawnRandomBlock()
    local amm = tonumber(math.random(1,5))
    if amm == 1 then
        lucky:FireServer()
    end
    if amm == 2 then
        superblock:FireServer()
    end
    if amm == 3 then
        diamond:FireServer()
    end
    if amm == 4 then
        rainbow:FireServer()
    end
    if amm == 5 then
        galaxy:FireServer()
    end
end
Main:NewButton("Random Block","opens a random lucky block",function()
    SpawnRandomBlock()
end)
local toOpen = "Lucky Block" -- prevents errors for using the feature without selecting a block first
Main:NewButton("Block Opener","does what it says",function()
    if toOpen == "Lucky Block" then
        lucky:FireServer()
    end
    if toOpen == "Super Lucky Block" then
        superblock:FireServer()
    end
    if toOpen == "Diamond Block" then
        diamond:FireServer()
    end
    if toOpen == "Rainbow Block" then
        rainbow:FireServer()
    end
    if toOpen == "Galaxy Block" then
        galaxy:FireServer()
    end
end)
Main:NewDropdown("Select Block", "does what it says", {"Lucky Block", "Super Lucky Block", "Diamond Block", "Rainbow Block", "Galaxy Block"}, function(currentOption)
    toOpen = currentOption
end)
local aob = false
Auto:NewToggle("AutoOpenBlock","does what it says",function(callback)
    if callback then
        aob = true
        repeat
            SpawnRandomBlock()
            task.wait(5)
        until not aob
    else
        aob = false
    end
end)
